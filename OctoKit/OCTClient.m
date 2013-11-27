//
//  OCTClient.m
//  OctoKit
//
//  Created by Josh Abernathy on 3/6/12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTClient.h"
#import "NSDateFormatter+OCTFormattingAdditions.h"
#import "OCTEvent.h"
#import "OCTGist.h"
#import "OCTGistFile.h"
#import "OCTObject+Private.h"
#import "OCTOrganization.h"
#import "OCTUserOrganization.h"
#import "OCTPublicKey.h"
#import "OCTRepository.h"
#import "OCTFileContent.h"
#import "OCTResponse.h"
#import "OCTServer.h"
#import "OCTTeam.h"
#import "OCTLabel.h"
#import "OCTLoginUser.h"
#import "OCTUser.h"
#import "OCTNotification.h"
#import "OCTPullRequest.h"
#import "OCTCommit.h"
#import "OCTMilestone.h"
#import "OCTIssue.h"
#import "OCTIssueComment.h"
#import "OCTPullRequestComment.h"
#import "RACSignal+OCTClientAdditions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <CSURITemplate/CSURITemplate.h>
#import "OCTAuthorization.h"

NSString * const OCTClientErrorDomain = @"OCTClientErrorDomain";
const NSInteger OCTClientErrorAuthenticationFailed = 666;
const NSInteger OCTClientErrorServiceRequestFailed = 667;
const NSInteger OCTClientErrorConnectionFailed = 668;
const NSInteger OCTClientErrorJSONParsingFailed = 669;
const NSInteger OCTClientErrorBadRequest = 670;
const NSInteger OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired = 671;
const NSInteger OCTClientErrorUnsupportedServer = 672;

NSString * const OCTClientErrorRequestURLKey = @"OCTClientErrorRequestURLKey";
NSString * const OCTClientErrorHTTPStatusCodeKey = @"OCTClientErrorHTTPStatusCodeKey";
NSString * const OCTClientErrorOneTimePasswordMediumKey = @"OCTClientErrorOneTimePasswordMediumKey";

// An environment variable that, when present, will enable logging of all
// responses.
static NSString * const OCTClientResponseLoggingEnvironmentKey = @"LOG_API_RESPONSES";

// An environment variable that, when present, will log the remaining API calls
// allowed before the rate limit is enforced.
static NSString * const OCTClientRateLimitLoggingEnvironmentKey = @"LOG_REMAINING_API_CALLS";

static const NSInteger OCTClientNotModifiedStatusCode = 304;

static NSString * const OCTClientOneTimePasswordHeaderField = @"X-GitHub-OTP";

@interface OCTClient ()

@property (nonatomic, strong, readwrite) OCTLoginUser *user;
@property (nonatomic, getter = isAuthenticated, readwrite) BOOL authenticated;

// An error indicating that a request required a valid user, but no `user`
// property was set.
+ (NSError *)userRequiredError;

// An error indicating that a request required authentication, but the client
// was not created with a token.
+ (NSError *)authenticationRequiredError;

// Enqueues a request to fetch information about the current user by accessing
// a path relative to the user object.
//
// method       - The HTTP method to use.
// relativePath - The path to fetch, relative to the user object. For example,
//                to request `user/orgs` or `users/:user/orgs`, simply pass in
//                `/orgs`. This may not be nil, and must either start with a '/'
//                or be an empty string.
// parameters   - HTTP parameters to encode and send with the request.
// resultClass  - The class that response data should be returned as.
//
// Returns a signal which will send an instance of `resultClass` for each parsed
// JSON object, then complete. If no `user` is set on the receiver, the signal
// will error immediately.
- (RACSignal *)enqueueUserRequestWithMethod:(NSString *)method relativePath:(NSString *)relativePath parameters:(NSDictionary *)parameters resultClass:(Class)resultClass;

// Creates a request.
//
// method - The HTTP method to use in the request (e.g., "GET" or "POST").
// path   - The path to request, relative to the base API endpoint. This path
//          should _not_ begin with a forward slash.
// etag   - An ETag to compare the server data against, previously retrieved
//          from an instance of OCTResponse.
//
// Returns a request which can be modified further before being enqueued.
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters notMatchingEtag:(NSString *)etag;

@end

@implementation OCTClient

#pragma mark Lifecycle

+ (instancetype)authenticatedClientWithUser:(OCTLoginUser *)user token:(NSString *)token {
	NSParameterAssert(user != nil);
	NSParameterAssert(token != nil);

	OCTClient *client = [self authenticatedClientWithUser:user];

	NSString *tokenValue = [NSString stringWithFormat:@"token %@", token];
	[client setDefaultHeader:@"Authorization" value:tokenValue];

	return client;
}

+ (instancetype)authenticatedClientWithUser:(OCTLoginUser *)user {
	OCTClient *client = [[self alloc] initWithServer:user.server];
	client.authenticated = YES;
	client.user = user;
	return client;
}

+ (instancetype)authenticatedClientWithUser:(OCTLoginUser *)user password:(NSString *)password {
	NSParameterAssert(user != nil);
	NSParameterAssert(password != nil);

	OCTClient *client = [self authenticatedClientWithUser:user];

	[client setAuthorizationHeaderWithUsername:user.login password:password];

	return client;
}

+ (instancetype)unauthenticatedClientWithUser:(OCTLoginUser *)user {
	NSParameterAssert(user != nil);

	OCTClient *client = [[self alloc] initWithServer:user.server];
	client.user = user;
	return client;
}

- (id)initWithBaseURL:(NSURL *)url {
	NSAssert(NO, @"%@ must be initialized using -initWithServer:", self.class);
	return nil;
}

- (id)initWithServer:(OCTServer *)server {
	NSParameterAssert(server != nil);

	self = [super initWithBaseURL:server.APIEndpoint];
	if (self == nil) return nil;
	
	self.parameterEncoding = AFJSONParameterEncoding;
	[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"application/vnd.github.beta+json", @"application/vnd.github.beta.html+json", nil]];
	[self registerHTTPOperationClass:AFJSONRequestOperation.class];
	[self setDefaultHeader:@"Accept" value:@"application/vnd.github.beta+json"];
	[AFHTTPRequestOperation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndex:OCTClientNotModifiedStatusCode]];

	return self;
}

#pragma mark Request Creation

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method template:(CSURITemplate *)template parameters:(NSDictionary *)parameters {
	NSParameterAssert(method != nil);
	NSParameterAssert(template != nil);

	NSMutableURLRequest *request = [self requestWithMethod:method path:@"" parameters:parameters notMatchingEtag:nil];

	NSURL *templateURL = [template URLWithVariables:@{} relativeToBaseURL:nil error:NULL];
	NSURLComponents *components = [NSURLComponents componentsWithURL:templateURL resolvingAgainstBaseURL:NO];
	components.query = request.URL.query;

	request.URL = components.URL;

	return [self etagRequestWithRequest:request];
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters notMatchingEtag:(NSString *)etag {
	NSParameterAssert(method != nil);
	
	NSMutableURLRequest *request = [self requestWithMethod:method path:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters];

	return [self etagRequestWithRequest:request];
}

- (NSMutableURLRequest *)etagRequestWithRequest:(NSURLRequest *)request {
	NSMutableURLRequest *mutableRequest = [request mutableCopy];
	NSCachedURLResponse *cachedResponse = [NSURLCache.sharedURLCache cachedResponseForRequest:request];
	NSDictionary *headerFields = [(NSHTTPURLResponse *)cachedResponse.response allHeaderFields];

	NSString *cachedEtag = headerFields[@"Etag"];
	[mutableRequest setValue:cachedEtag forHTTPHeaderField:@"If-None-Match"];

	return mutableRequest;
}

#pragma mark Request Enqueuing

- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass {
	return [self enqueueRequest:request resultClass:resultClass fetchAllPages:YES];
}

- (RACSignal *)enqueueRequest:(NSURLRequest *)request resultClass:(Class)resultClass fetchAllPages:(BOOL)fetchAllPages {
	RACSignal *signal = [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
		RACCompoundDisposable *compoundDisposable = RACCompoundDisposable.compoundDisposable;

		AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
			if ([operation isCancelled]) {
				[subscriber sendCompleted];
				return;
			}

			if (NSProcessInfo.processInfo.environment[OCTClientResponseLoggingEnvironmentKey] != nil) {
				NSLog(@"%@ %@ %@ => %li %@:\n%@", request.HTTPMethod, request.URL, request.allHTTPHeaderFields, (long)operation.response.statusCode, operation.response.allHeaderFields, responseObject);
			}

			NSString *requestEtag = [operation.request allHTTPHeaderFields][@"If-None-Match"];
			NSString *responseEtag = [operation.response allHeaderFields][@"Etag"];
			if ([requestEtag isEqualToString:responseEtag]) {
				responseObject = nil;
			}

			RACSignal *thisPageSignal = [[self parsedResponseOfClass:resultClass fromJSON:responseObject]
				map:^(id parsedResult) {
					OCTResponse *response = [[OCTResponse alloc] initWithHTTPURLResponse:operation.response parsedResult:parsedResult];
					NSAssert(response != nil, @"Could not create OCTResponse with response %@ and parsedResult %@", operation.response, parsedResult);

					return response;
				}];

			if (NSProcessInfo.processInfo.environment[OCTClientRateLimitLoggingEnvironmentKey] != nil) {
				__block BOOL loggedRemaining = NO;
				thisPageSignal = [thisPageSignal doNext:^(OCTResponse *response) {
					if (loggedRemaining) return;

					NSLog(@"%@ %@ => %li remaining calls: %li/%li", request.HTTPMethod, request.URL, (long)operation.response.statusCode, (long)response.remainingRequests, (long)response.maximumRequestsPerHour);
					loggedRemaining = YES;
				}];
			}
			
			RACSignal *nextPageSignal = [RACSignal empty];
			NSURL *nextPageURL = (fetchAllPages ? [self nextPageURLFromOperation:operation] : nil);
			if (nextPageURL != nil) {
				// If we got this far, the etag is out of date, so don't pass it on.
				NSMutableURLRequest *nextRequest = [request mutableCopy];
				nextRequest.URL = nextPageURL;
				nextRequest = [self etagRequestWithRequest:nextRequest];

				nextPageSignal = [self enqueueRequest:nextRequest resultClass:resultClass fetchAllPages:YES];
			}

			RACDisposable *disposable = [[[RACSignal return:thisPageSignal] concat:nextPageSignal] subscribe:subscriber];
			[compoundDisposable addDisposable:disposable];
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			if ([operation isCancelled]) {
				[subscriber sendCompleted];
				return;
			}

			if (NSProcessInfo.processInfo.environment[OCTClientResponseLoggingEnvironmentKey] != nil) {
				NSLog(@"%@ %@ %@ => FAILED WITH %li", request.HTTPMethod, request.URL, request.allHTTPHeaderFields, (long)operation.response.statusCode);
			}

			[subscriber sendError:[self.class errorFromRequestOperation:(AFJSONRequestOperation *)operation]];
		}];

		operation.successCallbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		operation.failureCallbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		[self enqueueHTTPRequestOperation:operation];

		RACDisposable *operationDisposable = [RACDisposable disposableWithBlock:^{
			[operation cancel];
		}];
		[compoundDisposable addDisposable:operationDisposable];

		return compoundDisposable;
	}];
	
	return [[[signal
		publish]
		autoconnect]
		setNameWithFormat:@"-enqueueRequest: %@ resultClass: %@ fetchAllPages: %i", request, resultClass, (int)fetchAllPages];
}

- (RACSignal *)enqueueUserRequestWithMethod:(NSString *)method relativePath:(NSString *)relativePath parameters:(NSDictionary *)parameters resultClass:(Class)resultClass {
	NSParameterAssert(method != nil);
	NSAssert([relativePath isEqualToString:@""] || [relativePath hasPrefix:@"/"], @"%@ is not a valid relativePath, it must start with @\"/\", or equal @\"\"", relativePath);
	
	if (self.user == nil) return [RACSignal error:self.class.userRequiredError];
		
	NSString *path = (self.authenticated ? [NSString stringWithFormat:@"user%@", relativePath] : [NSString stringWithFormat:@"users/%@%@", self.user.login, relativePath]);
	NSMutableURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
	if (self.authenticated) request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
	
	return [self enqueueRequest:request resultClass:resultClass];
}

#pragma mark Pagination

- (NSURL *)nextPageURLFromOperation:(AFHTTPRequestOperation *)operation {
	NSDictionary *header = operation.response.allHeaderFields;
	NSString *linksString = header[@"Link"];

	NSURLComponents *components = [NSURLComponents componentsWithURL:operation.response.URL resolvingAgainstBaseURL:NO];
	NSString *query = components.query;
	if (linksString == nil && query != nil && operation.responseData.length > 2) {

		NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:@"&page=(\\d+)&" options:0 error:NULL];
		NSTextCheckingResult *result = [expression firstMatchInString:query options:0 range:NSMakeRange(0, query.length)];

		if (result != nil) {
			NSRange pageRange = [result rangeAtIndex:1];
			NSString *page = [query substringWithRange:pageRange];
			NSUInteger pageNumber = [NSDecimalNumber decimalNumberWithString:page].unsignedIntegerValue;
			NSString *nextIndex = [@(pageNumber + 1) stringValue];

			components.query = [components.query stringByReplacingCharactersInRange:pageRange withString:nextIndex];
			return components.URL;
		}
	}

	if (linksString.length < 1) return nil;

	NSError *error = nil;
	NSRegularExpression *relPattern = [NSRegularExpression regularExpressionWithPattern:@"rel=\\\"?([^\\\"]+)\\\"?" options:NSRegularExpressionCaseInsensitive error:&error];
	NSAssert(relPattern != nil, @"Error constructing regular expression pattern: %@", error);

	NSMutableCharacterSet *whitespaceAndBracketCharacterSet = [NSCharacterSet.whitespaceCharacterSet mutableCopy];
	[whitespaceAndBracketCharacterSet addCharactersInString:@"<>"];
	
	NSArray *links = [linksString componentsSeparatedByString:@","];
	for (NSString *link in links) {
		NSRange semicolonRange = [link rangeOfString:@";"];
		if (semicolonRange.location == NSNotFound) continue;

		NSString *URLString = [[link substringToIndex:semicolonRange.location] stringByTrimmingCharactersInSet:whitespaceAndBracketCharacterSet];
		if (URLString.length == 0) continue;

		NSTextCheckingResult *result = [relPattern firstMatchInString:link options:0 range:NSMakeRange(0, link.length)];
		if (result == nil) continue;

		NSString *type = [link substringWithRange:[result rangeAtIndex:1]];
		if (![type isEqualToString:@"next"]) continue;

		return [NSURL URLWithString:URLString];
	}
	
	return nil;
}

#pragma mark Parsing

- (NSError *)parsingErrorWithFailureReason:(NSString *)localizedFailureReason {
	NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
	userInfo[NSLocalizedDescriptionKey] = NSLocalizedString(@"Could not parse the service response.", @"");

	if (localizedFailureReason != nil) {
		userInfo[NSLocalizedFailureReasonErrorKey] = localizedFailureReason;
	}

	return [NSError errorWithDomain:OCTClientErrorDomain code:OCTClientErrorJSONParsingFailed userInfo:userInfo];
}

- (RACSignal *)parsedResponseOfClass:(Class)resultClass fromJSON:(id)responseObject {
	NSParameterAssert(resultClass == nil || [resultClass isSubclassOfClass:MTLModel.class]);

	return [RACSignal createSignal:^ id (id<RACSubscriber> subscriber) {
		void (^parseJSONDictionary)(NSDictionary *) = ^(NSDictionary *JSONDictionary) {
			if (resultClass == nil) {
				[subscriber sendNext:JSONDictionary];
				return;
			}

			NSError *error = nil;
			OCTObject *parsedObject = [MTLJSONAdapter modelOfClass:resultClass fromJSONDictionary:JSONDictionary error:&error];
			if (parsedObject == nil) {
				// Don't treat "no class found" errors as real parsing failures.
				// In theory, this makes parsing code forward-compatible with
				// API additions.
				if (![error.domain isEqual:MTLJSONAdapterErrorDomain] || error.code != MTLJSONAdapterErrorNoClassFound) {
					[subscriber sendError:error];
				}

				return;
			}

			NSAssert([parsedObject isKindOfClass:OCTObject.class], @"Parsed model object is not an OCTObject: %@", parsedObject);

			// Record the server that this object has come from.
			parsedObject.baseURL = self.baseURL;
			[subscriber sendNext:parsedObject];
		};

		if ([responseObject isKindOfClass:NSArray.class]) {
			for (NSDictionary *JSONDictionary in responseObject) {
				if (![JSONDictionary isKindOfClass:NSDictionary.class]) {
					NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Invalid JSON array element: %@", @""), JSONDictionary];
					[subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
					return nil;
				}

				parseJSONDictionary(JSONDictionary);
			}

			[subscriber sendCompleted];
		} else if ([responseObject isKindOfClass:NSDictionary.class]) {
			parseJSONDictionary(responseObject);
			[subscriber sendCompleted];
		} else if (responseObject != nil) {
			NSString *failureReason = [NSString stringWithFormat:NSLocalizedString(@"Response wasn't an array or dictionary (%@): %@", @""), [responseObject class], responseObject];
			[subscriber sendError:[self parsingErrorWithFailureReason:failureReason]];
		} else {
			[subscriber sendCompleted];
		}

		return nil;
	}];
}

#pragma mark Error Handling

+ (NSString *)errorMessageFromErrorDictionary:(NSDictionary *)errorDictionary {
	NSString *message = errorDictionary[@"message"];
	NSString *resource = errorDictionary[@"resource"];
	if (message != nil) {
		return [NSString stringWithFormat:NSLocalizedString(@"• %@ %@.", @""), resource, message];
	} else {
		NSString *field = errorDictionary[@"field"];
		NSString *codeType = errorDictionary[@"code"];

		NSString * (^localizedErrorMessage)(NSString *) = ^(NSString *message) {
			return [NSString stringWithFormat:message, resource, field];
		};
		
		NSString *codeString = localizedErrorMessage(@"%@ %@ is missing");
		if ([codeType isEqual:@"missing"]) {
			codeString = localizedErrorMessage(NSLocalizedString(@"%@ %@ does not exist", @""));
		} else if ([codeType isEqual:@"missing_field"]) {
			codeString = localizedErrorMessage(NSLocalizedString(@"%@ %@ is missing", @""));
		} else if ([codeType isEqual:@"invalid"]) {
			codeString = localizedErrorMessage(NSLocalizedString(@"%@ %@ is invalid", @""));
		} else if ([codeType isEqual:@"already_exists"]) {
			codeString = localizedErrorMessage(NSLocalizedString(@"%@ %@ already exists", @""));
		}

		return [NSString stringWithFormat:@"• %@.", codeString];
	}
}

+ (NSError *)errorFromRequestOperation:(AFJSONRequestOperation *)operation {
	NSParameterAssert(operation != nil);
	
	NSInteger HTTPCode = operation.response.statusCode;
	NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
	NSInteger errorCode = OCTClientErrorServiceRequestFailed;

	NSDictionary *responseDictionary = nil;
	if ([operation.responseJSON isKindOfClass:NSDictionary.class]) {
		responseDictionary = operation.responseJSON;
	} else {
		NSLog(@"Unexpected JSON for error response: %@", operation.responseJSON);
	}

	NSString *message = responseDictionary[@"message"];
	
	if (HTTPCode == 401) {
		NSError *errorTemplate = self.class.authenticationRequiredError;

		errorCode = errorTemplate.code;
		NSString *OTPHeader = operation.response.allHeaderFields[OCTClientOneTimePasswordHeaderField];
		// E.g., "required; sms"
		NSArray *segments = [OTPHeader componentsSeparatedByString:@";"];
		if (segments.count == 2) {
			NSString *status = [segments[0] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
			NSString *medium = [segments[1] stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
			if ([status.lowercaseString isEqual:@"required"]) {
				errorCode = OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired;
				NSDictionary *mediumStringToWrappedMedium = @{
					@"sms": @(OCTClientOneTimePasswordMediumSMS),
					@"app": @(OCTClientOneTimePasswordMediumApp),
				};
				NSNumber *wrappedMedium = mediumStringToWrappedMedium[medium.lowercaseString];
				if (wrappedMedium != nil) userInfo[OCTClientErrorOneTimePasswordMediumKey] = wrappedMedium;
			}
		}

		[userInfo addEntriesFromDictionary:errorTemplate.userInfo];
	} else if (HTTPCode == 400) {
		errorCode = OCTClientErrorBadRequest;
		if (message != nil) userInfo[NSLocalizedDescriptionKey] = message;
	} else if (HTTPCode == 422) {
		errorCode = OCTClientErrorServiceRequestFailed;
		
		NSArray *errorDictionaries = responseDictionary[@"errors"];
		if ([errorDictionaries isKindOfClass:NSArray.class]) {
			NSMutableArray *errors = [NSMutableArray arrayWithCapacity:errorDictionaries.count];
			for (NSDictionary *errorDictionary in errorDictionaries) {
				NSString *message = [self errorMessageFromErrorDictionary:errorDictionary];
				if (message == nil) continue;
				
				[errors addObject:message];
			}

			userInfo[NSLocalizedDescriptionKey] = [NSString stringWithFormat:NSLocalizedString(@"%@:\n\n%@", @""), message, [errors componentsJoinedByString:@"\n"]];
		}
	} else if (operation.error != nil) {
		errorCode = OCTClientErrorConnectionFailed;
		if ([operation.error.domain isEqual:NSURLErrorDomain]) {
			userInfo[NSLocalizedDescriptionKey] = NSLocalizedString(@"There was a problem connecting to the server.", @"");
		} else {
			NSString *errorDescription = operation.error.userInfo[NSLocalizedDescriptionKey];
			if (errorDescription != nil) userInfo[NSLocalizedDescriptionKey] = errorDescription;
		}
	}

	if (userInfo[NSLocalizedDescriptionKey] == nil) {
		userInfo[NSLocalizedDescriptionKey] = NSLocalizedString(@"The universe has collapsed.", @"");
	}

	userInfo[OCTClientErrorHTTPStatusCodeKey] = @(HTTPCode);
	if (operation.request.URL != nil) userInfo[OCTClientErrorRequestURLKey] = operation.request.URL;
	if (operation.error != nil) userInfo[NSUnderlyingErrorKey] = operation.error;
	
	return [NSError errorWithDomain:OCTClientErrorDomain code:errorCode userInfo:userInfo];
}

+ (NSError *)userRequiredError {
	NSDictionary *userInfo = @{
		NSLocalizedDescriptionKey: NSLocalizedString(@"Username Required", @""),
		NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"No username was provided for getting user information.", @""),
	};

	return [NSError errorWithDomain:OCTClientErrorDomain code:OCTClientErrorAuthenticationFailed userInfo:userInfo];
}

+ (NSError *)authenticationRequiredError {
	NSDictionary *userInfo = @{
		NSLocalizedDescriptionKey: NSLocalizedString(@"Login Required", @""),
		NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"You must log in to access user information.", @""),
	};

	return [NSError errorWithDomain:OCTClientErrorDomain code:OCTClientErrorAuthenticationFailed userInfo:userInfo];
}

@end

@implementation OCTClient (Authorization)

- (NSArray *)scopesArrayFromScopes:(OCTClientAuthorizationScopes)scopes {
	NSDictionary *scopeToScopeString = @{
		@(OCTClientAuthorizationScopesPublicReadOnly): @"",
		@(OCTClientAuthorizationScopesUserEmail): @"user:email",
		@(OCTClientAuthorizationScopesUserFollow): @"user:follow",
		@(OCTClientAuthorizationScopesUser): @"user",
		@(OCTClientAuthorizationScopesRepositoryStatus): @"repo:status",
		@(OCTClientAuthorizationScopesPublicRepository): @"public_repo",
		@(OCTClientAuthorizationScopesRepository): @"repo",
		@(OCTClientAuthorizationScopesRepositoryDelete): @"delete_repo",
		@(OCTClientAuthorizationScopesNotifications): @"notifications",
		@(OCTClientAuthorizationScopesGist): @"gist",
	};

	return [[[[scopeToScopeString.rac_keySequence
		filter:^ BOOL (NSNumber *scopeValue) {
			OCTClientAuthorizationScopes scope = scopeValue.unsignedIntegerValue;
			return (scopes & scope) != 0;
		}]
		map:^(NSNumber *scopeValue) {
			return scopeToScopeString[scopeValue];
		}]
		filter:^ BOOL (NSString *scopeString) {
			return scopeString.length > 0;
		}]
		array];
}

- (RACSignal *)enqueueAuthorizationRequestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters password:(NSString *)password oneTimePassword:(NSString *)oneTimePassword {
	NSParameterAssert(method != nil);
	NSParameterAssert(path != nil);
	NSParameterAssert(password != nil);

	if (self.user == nil) return [RACSignal error:self.class.userRequiredError];

	// We create a dummy authenticated client with `password` so that our
	// authorization header is set for us. We don't want to set the
	// authorization header for `self` because we don't want other requests to
	// accidentally use it.
	//
	// Note that we're using `password` as the token, which works because
	// they're both sent to the server the same way: as the Basic Auth password.
	OCTClient *authedClient = [OCTClient authenticatedClientWithUser:self.user password:password];
	NSMutableURLRequest *request = [authedClient requestWithMethod:method path:path parameters:parameters];
	request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
	if (oneTimePassword != nil) [request setValue:oneTimePassword forHTTPHeaderField:OCTClientOneTimePasswordHeaderField];

	return [[self
		enqueueRequest:request resultClass:OCTAuthorization.class]
		catch:^(NSError *error) {
			NSNumber *statusCode = error.userInfo[OCTClientErrorHTTPStatusCodeKey];

			// 404s mean we tried to authorize in an unsupported way.
			if (statusCode.integerValue == 404) {
				NSMutableDictionary *userInfo = [error.userInfo mutableCopy];
				userInfo[NSLocalizedDescriptionKey] = NSLocalizedString(@"The server's version is unsupported.", @"");
				userInfo[NSUnderlyingErrorKey] = error;

				error = [NSError errorWithDomain:OCTClientErrorDomain code:OCTClientErrorUnsupportedServer userInfo:userInfo];
			}

			return [RACSignal error:error];
		}];
}

- (RACSignal *)requestAuthorizationWithPassword:(NSString *)password oneTimePassword:(NSString *)oneTimePassword scopes:(OCTClientAuthorizationScopes)scopes clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret {
	NSParameterAssert(password != nil);
	NSParameterAssert(clientID != nil);
	NSParameterAssert(clientSecret != nil);

	NSDictionary *params = @{
		@"scopes": [self scopesArrayFromScopes:scopes],
		@"client_secret": clientSecret,
	};

	NSString *path = [NSString stringWithFormat:@"authorizations/clients/%@", clientID];
	return [[self enqueueAuthorizationRequestWithMethod:@"PUT" path:path parameters:params password:password oneTimePassword:oneTimePassword] oct_parsedResults];
}

- (RACSignal *)requestAuthorizationWithPassword:(NSString *)password scopes:(OCTClientAuthorizationScopes)scopes clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret {
	NSParameterAssert(password != nil);
	NSParameterAssert(clientID != nil);
	NSParameterAssert(clientSecret != nil);

	return [self requestAuthorizationWithPassword:password oneTimePassword:nil scopes:scopes clientID:clientID clientSecret:clientSecret];
}

@end

@implementation OCTClient (User)

- (RACSignal *)fetchUserAtURITemplate:(CSURITemplate *)template {
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];

	return [[self enqueueRequest:request resultClass:OCTUser.class] oct_parsedResults];
}

- (RACSignal *)fetchStarredRepositoriesAtURITemplate:(CSURITemplate *)template {
	NSURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchFollowedUsersAtURITemplate:(CSURITemplate *)template {
	NSURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTUserEntity.class] oct_parsedResults];
}

- (RACSignal *)fetchFollowersAtURITemplate:(CSURITemplate *)template {
	NSURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTUserEntity.class] oct_parsedResults];
}

- (RACSignal *)fetchUserInfo {
	return [[self enqueueUserRequestWithMethod:@"GET" relativePath:@"" parameters:nil resultClass:OCTUser.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoriesAtURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:nil forHTTPHeaderField:@"Accept-Language"];
	request = [self etagRequestWithRequest:request];

	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchUserRepositories {
	return [[self enqueueUserRequestWithMethod:@"GET" relativePath:@"/repos" parameters:nil resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchUserStarredRepositories {
	return [[self enqueueUserRequestWithMethod:@"GET" relativePath:@"/starred" parameters:nil resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)createRepositoryWithName:(NSString *)name description:(NSString *)description private:(BOOL)isPrivate {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	return [self createRepositoryWithName:name organization:nil team:nil description:description private:isPrivate];
}

@end

@implementation OCTClient (Organizations)

- (RACSignal *)fetchUserOrganizations {
	return [[self enqueueUserRequestWithMethod:@"GET" relativePath:@"/orgs" parameters:nil resultClass:OCTOrganization.class] oct_parsedResults];
}

- (RACSignal *)fetchOrganizationsAtURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:nil forHTTPHeaderField:@"Accept-Language"];
	request = [self etagRequestWithRequest:request];

	return [[self enqueueRequest:request resultClass:OCTSimpleOrganization.class] oct_parsedResults];
}

- (RACSignal *)fetchOrganizationInfo:(OCTOrganization *)organization {
	NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"orgs/%@", organization.login] parameters:nil notMatchingEtag:nil];
	return [[self enqueueRequest:request resultClass:OCTOrganization.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoriesForOrganization:(OCTOrganization *)organization {
	NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"orgs/%@/repos", organization.login] parameters:nil notMatchingEtag:nil];
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)createRepositoryWithName:(NSString *)name organization:(OCTOrganization *)organization team:(OCTTeam *)team description:(NSString *)description private:(BOOL)isPrivate {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableDictionary *options = [NSMutableDictionary dictionary];
	options[@"name"] = name;
	options[@"private"] = @(isPrivate);

	if (description != nil) options[@"description"] = description;
	if (team != nil) options[@"team_id"] = team.objectID;
	
	NSString *path = (organization == nil ? @"user/repos" : [NSString stringWithFormat:@"orgs/%@/repos", organization.login]);
	NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:options notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchTeamsForOrganization:(OCTOrganization *)organization {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"orgs/%@/teams", organization.login] parameters:nil notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTTeam.class] oct_parsedResults];
}

@end

@implementation OCTClient (Keys)

- (RACSignal *)fetchPublicKeys {
	return [[self enqueueUserRequestWithMethod:@"GET" relativePath:@"/keys" parameters:nil resultClass:OCTPublicKey.class] oct_parsedResults];
}

- (RACSignal *)postPublicKey:(NSString *)key title:(NSString *)title {
	NSParameterAssert(key != nil);
	NSParameterAssert(title != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	OCTPublicKey *publicKey = [OCTPublicKey modelWithDictionary:@{
		@keypath(OCTPublicKey.new, publicKey): key,
		@keypath(OCTPublicKey.new, title): title,
	} error:NULL];
	
	NSURLRequest *request = [self requestWithMethod:@"POST" path:@"user/keys" parameters:[MTLJSONAdapter JSONDictionaryFromModel:publicKey] notMatchingEtag:nil];

	return [[self enqueueRequest:request resultClass:OCTPublicKey.class] oct_parsedResults];
}

@end

@implementation OCTClient (Events)

- (RACSignal *)fetchUserEventsNotMatchingEtag:(NSString *)etag {
	if (self.user == nil) return [RACSignal error:self.class.userRequiredError];

	NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"users/%@/received_events", self.user.login] parameters:nil notMatchingEtag:etag];
	
	return [self enqueueRequest:request resultClass:OCTEvent.class fetchAllPages:NO];
}

@end

@implementation OCTClient (Notifications)

- (RACSignal *)fetchSubjectAtURITemplate:(CSURITemplate *)template resultClass:(Class)class {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	[request setValue:@"application/vnd.github.beta.html+json" forHTTPHeaderField:@"Accept"];

	return [[self enqueueRequest:request resultClass:class] oct_parsedResults];
}

- (RACSignal *)fetchNotificationsNotMatchingEtag:(NSString *)etag includeReadNotifications:(BOOL)includeRead updatedSince:(NSDate *)since {
	return [self fetchNotificationsNotMatchingEtag:etag onlyParticipating:NO includeReadNotifications:includeRead updatedSince:since];
}

- (RACSignal *)fetchParticipatingNotificationsNotMatchingEtag:(NSString *)etag {
	return [self fetchNotificationsNotMatchingEtag:etag onlyParticipating:YES includeReadNotifications:NO updatedSince:nil];
}

- (RACSignal *)fetchNotificationsNotMatchingEtag:(NSString *)etag onlyParticipating:(BOOL)onlyParticipating includeReadNotifications:(BOOL)includeRead updatedSince:(NSDate *)since {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	parameters[@"all"] = includeRead ? @"true": @"false";
	parameters[@"page"] = @(1);

	parameters[@"participating"] = onlyParticipating ? @"true" : @"false";

	if (since != nil) {
		parameters[@"since"] = [NSDateFormatter oct_stringFromDate:since];
	}

	NSURLRequest *request = [self requestWithMethod:@"GET" path:@"notifications" parameters:parameters notMatchingEtag:etag];
	return [[self enqueueRequest:request resultClass:OCTNotification.class] oct_parsedResults];
}

- (RACSignal *)markNotificationThreadsAsReadForRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSString *path = [NSString stringWithFormat:@"repos/%@/%@/notifications", repository.ownerLogin, repository.name];
	NSMutableURLRequest *request = [self requestWithMethod:@"PUT" path:path parameters:@{}];

	return [[self enqueueRequest:request resultClass:nil] ignoreValues];
}

- (RACSignal *)markNotificationThreadAsReadAtURL:(NSURL *)threadURL {
	return [self patchThreadURL:threadURL withReadStatus:YES];
}

- (RACSignal *)patchThreadURL:(NSURL *)threadURL withReadStatus:(BOOL)read {
	NSParameterAssert(threadURL != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"PATCH" path:@"" parameters:@{ @"read": @(read) }];
	request.URL = threadURL;

	return [[self enqueueRequest:request resultClass:nil] ignoreValues];
}

- (RACSignal *)muteNotificationThreadAtURL:(NSURL *)threadURL {
	NSParameterAssert(threadURL != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"PUT" path:@"" parameters:@{ @"ignored": @YES }];
	request.URL = [threadURL URLByAppendingPathComponent:@"subscription"];

	return [[self enqueueRequest:request resultClass:nil] ignoreValues];
}

- (RACSignal *)fetchNotificationsForRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSDictionary *parameters = @{
		@"all": @"false",
		@"page": @(1)
	};

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:repository.notificationsURITemplate parameters:parameters];

	return [[self enqueueRequest:request resultClass:OCTNotification.class] oct_parsedResults];
}

@end

@implementation OCTClient (Repository)

- (RACSignal *)fetchRelativePath:(NSString *)relativePath inRepository:(OCTRepository *)repository reference:(NSString *)reference {
	NSParameterAssert(repository != nil);
	NSParameterAssert(repository.name.length > 0);
	NSParameterAssert(repository.ownerLogin.length > 0);
	
	relativePath = relativePath ?: @"";
	NSString *path = [NSString stringWithFormat:@"repos/%@/%@/contents/%@", repository.ownerLogin, repository.name, relativePath];
	
	NSDictionary *parameters = nil;
	if (reference.length > 0) {
		parameters = @{ @"ref": reference };
	}
	
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTContent.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoryReadme:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);
	NSParameterAssert(repository.name.length > 0);
	NSParameterAssert(repository.ownerLogin.length > 0);
	
	NSString *path = [NSString stringWithFormat:@"repos/%@/%@/readme", repository.ownerLogin, repository.name];
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTFileContent.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoryWithName:(NSString *)name owner:(NSString *)owner {
	NSParameterAssert(name.length > 0);
	NSParameterAssert(owner.length > 0);
	
	NSString *path = [NSString stringWithFormat:@"repos/%@/%@", owner, name];
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)unwatchRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSString *path = [NSString stringWithFormat:@"repos/%@/%@", repository.ownerLogin, repository.name];
	NSMutableURLRequest *request = [self requestWithMethod:@"DELETE" path:path parameters:nil];

	return [[self enqueueRequest:request resultClass:nil] ignoreValues];
	
}

- (RACSignal *)fetchLabelsForRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:repository.labelsURITemplate parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTLabel.class] oct_parsedResults];
}

- (RACSignal *)fetchMilestonesForRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:repository.milestonesURITemplate parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTMilestone.class] oct_parsedResults];
}

@end

@implementation OCTClient (Gist)

- (RACSignal *)fetchGists {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSURLRequest *request = [self requestWithMethod:@"GET" path:@"gists" parameters:nil notMatchingEtag:nil];
	return [[self enqueueRequest:request resultClass:OCTGist.class] oct_parsedResults];
}

- (RACSignal *)applyEdit:(OCTGistEdit *)edit toGist:(OCTGist *)gist {
	NSParameterAssert(edit != nil);
	NSParameterAssert(gist != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:edit];
	NSURLRequest *request = [self requestWithMethod:@"PATCH" path:[NSString stringWithFormat:@"gists/%@", gist.objectID] parameters:parameters notMatchingEtag:nil];
	return [[self enqueueRequest:request resultClass:OCTGist.class] oct_parsedResults];
}

- (RACSignal *)createGistWithEdit:(OCTGistEdit *)edit {
	NSParameterAssert(edit != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:edit];
	NSURLRequest *request = [self requestWithMethod:@"POST" path:@"gists" parameters:parameters notMatchingEtag:nil];
	return [[self enqueueRequest:request resultClass:OCTGist.class] oct_parsedResults];
}

@end

@implementation OCTClient (Comments)

- (RACSignal *)fetchIssueCommentsForSubject:(OCTIssue *)issue {
	return [self fetchCommentsAtURITemplate:issue.commentsURITemplate resultClass:OCTIssueComment.class];
}

- (RACSignal *)fetchCommentsAtURITemplate:(CSURITemplate *)template resultClass:(Class)class {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	[request setValue:@"application/vnd.github.beta.html+json" forHTTPHeaderField:@"Accept"];

	return [[self enqueueRequest:request resultClass:class] oct_parsedResults];
}

- (RACSignal *)fetchReviewCommentsForPullRequest:(OCTPullRequest *)pullRequest {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:pullRequest.reviewCommentsURITemplate parameters:nil];
	[request setValue:@"application/vnd.github.beta.html+json" forHTTPHeaderField:@"Accept"];

	return [self enqueueRequest:request resultClass:OCTPullRequestComment.class];
}

@end

@implementation OCTClient (Issues)

- (RACSignal *)fetchIssuesAtURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];

	return [[self enqueueRequest:request resultClass:OCTIssue.class] oct_parsedResults];
}

@end

@implementation OCTClient (PullRequests)

- (RACSignal *)fetchPullRequestsAtURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];

	return [[self enqueueRequest:request resultClass:OCTPullRequest.class] oct_parsedResults];
}

@end

@implementation OCTClient (Commits)

- (RACSignal *)fetchCommitsAtPullRequestURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	request.URL = [request.URL URLByAppendingPathComponent:@"commits"];
	[request setValue:@"application/vnd.github.beta.html+json" forHTTPHeaderField:@"Accept"];

	return [[self enqueueRequest:request resultClass:OCTCommit.class] oct_parsedResults];
}

@end

@implementation OCTClient (Watching)

- (RACSignal *)fetchWatchedRepositoriesForEntity:(OCTEntity *)entity {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];
	
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:entity.subscriptionsURITemplate parameters:nil];

	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

@end
