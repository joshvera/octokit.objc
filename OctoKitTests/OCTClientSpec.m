//
//  OCTClientSpec.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2013-02-18.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

SpecBegin(OCTClient)

void (^stubResponseWithHeaders)(NSString *, NSString *, NSDictionary *) = ^(NSString *path, NSString *responseFilename, NSDictionary *headers) {
	headers = [headers mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"Content-Type": @"application/json",
	}];

	[OHHTTPStubs addRequestHandler:^ id (NSURLRequest *request, BOOL onlyCheck) {
		if (![request.URL.path isEqual:path]) return nil;
		
		NSURL *fileURL = [[NSBundle bundleForClass:self.class] URLForResource:responseFilename.stringByDeletingPathExtension withExtension:responseFilename.pathExtension];
		return [OHHTTPStubsResponse responseWithFileURL:fileURL statusCode:200 responseTime:0 headers:headers];
	}];
};

void (^stubResponseWithStatusCode)(NSString *, int) = ^(NSString *path, int statusCode) {
	[OHHTTPStubs addRequestHandler:^ id (NSURLRequest *request, BOOL onlyCheck) {
		if (![request.URL.path isEqual:path]) return nil;

		return [OHHTTPStubsResponse responseWithData:[NSData data] statusCode:statusCode responseTime:0 headers:nil];
	}];
};

void (^stubResponse)(NSString *, NSString *) = ^(NSString *path, NSString *responseFilename) {
	stubResponseWithHeaders(path, responseFilename, @{});
};

__block BOOL success;
__block NSError *error;

// A random ETag for testing.
NSString *etag = @"644b5b0155e6404a9cc4bd9d8b1ae730";

beforeEach(^{
	success = NO;
	error = nil;
});

describe(@"without a user", ^{
	__block OCTClient *client;

	beforeEach(^{
		client = [[OCTClient alloc] initWithServer:OCTServer.dotComServer];
		expect(client).notTo.beNil();
		expect(client.user).to.beNil();
		expect(client.authenticated).to.beFalsy();
	});
	
	it(@"should create a GET request with default parameters", ^{
		NSURLRequest *request = [client requestWithMethod:@"GET" path:@"rate_limit" parameters:nil notMatchingEtag:nil];
		
		expect(request).toNot.beNil();
		expect(request.URL).to.equal([NSURL URLWithString:@"https://api.github.com/rate_limit?per_page=100"]);
	});
	
	it(@"should create a POST request with default parameters", ^{
		NSURLRequest *request = [client requestWithMethod:@"POST" path:@"diver/dave" parameters:nil notMatchingEtag:nil];
		
		expect(request).toNot.beNil();
		expect(request.URL).to.equal([NSURL URLWithString:@"https://api.github.com/diver/dave"]);
	});
	
	it(@"should create a request using etags", ^{
		NSString *etag = @"\"deadbeef\"";
		NSURLRequest *request = [client requestWithMethod:@"GET" path:@"diver/dan" parameters:nil notMatchingEtag:etag];
		
		expect(request).toNot.beNil();
		expect(request.URL).to.equal([NSURL URLWithString:@"https://api.github.com/diver/dan?per_page=100"]);
		expect(request.allHTTPHeaderFields[@"If-None-Match"]).to.equal(etag);
	});

	it(@"should GET a JSON dictionary", ^{
		stubResponse(@"/rate_limit", @"rate_limit.json");

		NSURLRequest *request = [client requestWithMethod:@"GET" path:@"rate_limit" parameters:nil notMatchingEtag:nil];
		RACSignal *result = [client enqueueRequest:request resultClass:nil];
		OCTResponse *response = [result asynchronousFirstOrDefault:nil success:&success error:&error];
		expect(response).notTo.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();

		NSDictionary *expected = @{
			@"rate": @{
				@"remaining": @4999,
				@"limit": @5000,
			},
		};

		expect(response.parsedResult).to.equal(expected);
	});

	it(@"should conditionally GET a modified JSON dictionary", ^{
		stubResponseWithHeaders(@"/rate_limit", @"rate_limit.json", @{
			@"ETag": etag,
		});

		NSURLRequest *request = [client requestWithMethod:@"GET" path:@"rate_limit" parameters:nil notMatchingEtag:nil];
		RACSignal *result = [client enqueueRequest:request resultClass:nil];
		OCTResponse *response = [result asynchronousFirstOrDefault:nil success:&success error:&error];
		expect(response).notTo.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();

		NSDictionary *expected = @{
			@"rate": @{
				@"remaining": @4999,
				@"limit": @5000,
			},
		};

		expect(response.parsedResult).to.equal(expected);
		expect(response.etag).to.equal(etag);
	});

	it(@"should conditionally GET an unmodified endpoint", ^{
		stubResponseWithStatusCode(@"/rate_limit", 304);

		NSURLRequest *request = [client requestWithMethod:@"GET" path:@"rate_limit" parameters:nil notMatchingEtag:etag];
		RACSignal *result = [client enqueueRequest:request resultClass:nil];

		expect([result asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});

	it(@"should GET a paginated endpoint", ^{
		stubResponseWithHeaders(@"/items1", @"page1.json", @{
			@"Link": @"<https://api.github.com/items2>; rel=\"next\", <https://api.github.com/items3>; rel=\"last\"",
		});

		stubResponseWithHeaders(@"/items2", @"page2.json", @{
			@"Link": @"<https://api.github.com/items3>; rel=\"next\", <https://api.github.com/items3>; rel=\"last\"",
		});

		stubResponse(@"/items3", @"page3.json");

		NSURLRequest *request = [client requestWithMethod:@"GET" path:@"items1" parameters:nil notMatchingEtag:nil];
		RACSignal *result = [client enqueueRequest:request resultClass:nil];

		__block NSMutableArray *items = [NSMutableArray array];
		[result subscribeNext:^(OCTResponse *response) {
			NSDictionary *dict = response.parsedResult;
			expect(dict).to.beKindOf(NSDictionary.class);
			expect(dict[@"item"]).notTo.beNil();

			[items addObject:dict[@"item"]];
		}];

		expect([result asynchronouslyWaitUntilCompleted:&error]).to.beTruthy();
		expect(error).to.beNil();

		NSArray *expected = @[ @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
		expect(items).to.equal(expected);
	});
	
	it(@"should GET a repository", ^{
		NSURL *URL = [[NSBundle bundleForClass:self.class] URLForResource:@"repository" withExtension:@"json"];
		NSData *data = [NSData dataWithContentsOfURL:URL];
		NSDictionary *representation = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
		stubResponse(@"/repos/octokit/octokit.objc", @"repository.json");
		
		RACSignal *request = [client fetchRepositoryWithName:@"octokit.objc" owner:@"octokit"];
		OCTRepository *repository = [request asynchronousFirstOrDefault:nil success:&success error:&error];
		expect(success).to.beTruthy();
		expect(error).to.beNil();
		
		expect(repository).to.beKindOf(OCTRepository.class);
		expect(repository.objectID).to.equal(@"7530454");
		expect(repository.name).to.equal(@"octokit.objc");
		expect(repository.ownerLogin).to.equal(@"octokit");
		expect(repository.repoDescription).to.equal(@"GitHub API client for Objective-C");
		expect(repository.defaultBranch).to.equal(@"master");
		expect(repository.isPrivate).to.equal(@NO);
		expect(repository.isFork).to.equal(@NO);
		expect(repository.datePushed).to.equal([[[ISO8601DateFormatter alloc] init] dateFromString:representation[@"pushed_at"]]);
		expect(repository.SSHURL).to.equal([NSURL URLWithString:representation[@"ssh_url"]]);
		expect(repository.HTTPSURL).to.equal([NSURL URLWithString:representation[@"clone_url"]]);
		expect(repository.gitURL).to.equal([NSURL URLWithString:representation[@"git_url"]]);
		expect(repository.HTMLURL).to.equal([NSURL URLWithString:representation[@"html_url"]]);
	});
	
	it(@"should return nothing if repository is unmodified", ^{
		stubResponseWithStatusCode(@"/repos/octokit/octokit.objc", 304);
		
		RACSignal *request = [client fetchRepositoryWithName:@"octokit.objc" owner:@"octokit"];
		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});
	
	it(@"should not GET a non existing repository", ^{
		stubResponse(@"/repos/octokit/octokit.objc", @"repository.json");
		
		RACSignal *request = [client fetchRepositoryWithName:@"repo-does-not-exist" owner:@"octokit"];
		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beFalsy();
		expect(error).notTo.beNil();
	});
});

describe(@"authenticated", ^{
	__block OCTUser *user;
	__block OCTClient *client;

	beforeEach(^{
		user = [OCTUser userWithLogin:@"mac-testing-user" server:OCTServer.dotComServer];
		expect(user).notTo.beNil();

		client = [OCTClient authenticatedClientWithUser:user token:@""];
		expect(client).notTo.beNil();
		expect(client.user).to.equal(user);
		expect(client.authenticated).to.beTruthy();
	});

	it(@"should fetch notifications", ^{
		stubResponse(@"/notifications", @"notifications.json");

		RACSignal *request = [client fetchNotificationsNotMatchingEtag:nil includeReadNotifications:NO updatedSince:nil];
		OCTResponse *response = [request asynchronousFirstOrDefault:nil success:&success error:&error];
		expect(success).to.beTruthy();
		expect(error).to.beNil();

		OCTNotification *notification = response.parsedResult;
		expect(notification).to.beKindOf(OCTNotification.class);
		expect(notification.objectID).to.equal(@"1");
		expect(notification.title).to.equal(@"Greetings");
		expect(notification.threadURL).to.equal([NSURL URLWithString:@"https://api.github.com/notifications/threads/1"]);
		expect(notification.latestCommentURL).to.equal([NSURL URLWithString:@"https://api.github.com/repos/pengwynn/octokit/issues/comments/123"]);
		expect(notification.type).to.equal(OCTNotificationTypeIssue);
		expect(notification.lastUpdatedDate).to.equal([[[ISO8601DateFormatter alloc] init] dateFromString:@"2012-09-25T07:54:41-07:00"]);

		expect(notification.repository).notTo.beNil();
		expect(notification.repository.name).to.equal(@"Hello-World");
	});

	it(@"should return nothing if notifications are unmodified", ^{
		stubResponseWithStatusCode(@"/notifications", 304);

		RACSignal *request = [client fetchNotificationsNotMatchingEtag:etag includeReadNotifications:NO updatedSince:nil];
		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});

	it(@"should return nothing when marking a notification thread as read", ^{
		NSURL *URL = [NSURL URLWithString:@"https://github.com/notifications/threads/1"];
		stubResponseWithStatusCode(URL.path, 205);

		RACSignal *request = [client markNotificationThreadAsReadAtURL:URL];
	
		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});

	it(@"should return nothing when unwatching a repository", ^{
		OCTRepository *repository = [[OCTRepository alloc] initWithDictionary:@{
			@"name": @"github",
			@"ownerLogin": @"github"
		} error:NULL];

		NSURL *URL = [NSURL URLWithString:@"https://github.com/repos/github/github/"];
		NSString *path = [URL.path stringByAppendingPathComponent:@"subscription"];
		stubResponseWithStatusCode(path, 205);

		RACSignal *request = [client unwatchRepository:repository];
	
		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});

	it(@"should return nothing when muting a notification thread", ^{
		NSURL *URL = [NSURL URLWithString:@"https://github.com/notifications/threads/1"];
		NSString *path = [URL.path stringByAppendingPathComponent:@"subscription"];
		stubResponseWithStatusCode(path, 205);

		RACSignal *request = [client muteNotificationThreadAtURL:URL];

		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});

	it(@"should return nothing when marking a repository's notification threads as read", ^{
		OCTRepository *repository = [[OCTRepository alloc] initWithDictionary:@{
			@"name": @"github",
			@"ownerLogin": @"github"
		} error:NULL];

		NSString *path = [NSString stringWithFormat:@"/repos/%@/%@/notifications", repository.ownerLogin, repository.name];
		stubResponseWithStatusCode(path, 205);

		RACSignal *request = [client markNotificationThreadsAsReadForRepository:repository];

		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});
	
	it(@"should fetch user starred repositories", ^{
		NSURL *URL = [[NSBundle bundleForClass:self.class] URLForResource:@"user_starred" withExtension:@"json"];
		NSData *data = [NSData dataWithContentsOfURL:URL];
		NSDictionary *representation = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL][0];
		stubResponse(@"/user/starred", @"user_starred.json");
		
		RACSignal *request = [client fetchUserStarredRepositories];
		OCTRepository *repository = [request asynchronousFirstOrDefault:nil success:&success error:&error];
		expect(success).to.beTruthy();
		expect(error).to.beNil();
		
		expect(repository).to.beKindOf(OCTRepository.class);
		expect(repository.objectID).to.equal([representation[@"id"] stringValue]);
		expect(repository.name).to.equal(representation[@"name"]);
		expect(repository.ownerLogin).to.equal(representation[@"owner"][@"login"]);
		expect(repository.repoDescription).to.equal(representation[@"description"]);
		expect(repository.defaultBranch).to.equal(representation[@"default_branch"]);
		expect(repository.isPrivate).to.equal(representation[@"private"]);
		expect(repository.datePushed).to.equal([[[ISO8601DateFormatter alloc] init] dateFromString:representation[@"pushed_at"]]);
		expect(repository.SSHURL).to.equal([NSURL URLWithString:representation[@"ssh_url"]]);
		expect(repository.HTTPSURL).to.equal([NSURL URLWithString:representation[@"clone_url"]]);
		expect(repository.gitURL).to.equal([NSURL URLWithString:representation[@"git_url"]]);
		expect(repository.HTMLURL).to.equal([NSURL URLWithString:representation[@"html_url"]]);
	});
	
	it(@"should return nothing if user starred repositories are unmodified", ^{
		stubResponseWithStatusCode(@"/user/starred", 304);
		
		RACSignal *request = [client fetchUserStarredRepositories];
		expect([request asynchronousFirstOrDefault:nil success:&success error:&error]).to.beNil();
		expect(success).to.beTruthy();
		expect(error).to.beNil();
	});
});

describe(@"unauthenticated", ^{
	static NSString * const OCTClientSpecClientID = @"deadbeef";
	static NSString * const OCTClientSpecClientSecret = @"itsasekret";

	__block OCTUser *user;
	__block OCTClient *client;

	beforeEach(^{
		user = [OCTUser userWithLogin:@"mac-testing-user" server:OCTServer.dotComServer];
		expect(user).notTo.beNil();

		client = [OCTClient unauthenticatedClientWithUser:user];
		expect(client).notTo.beNil();
		expect(client.user).to.equal(user);
		expect(client.authenticated).to.beFalsy();
	});

	it(@"should send the appropriate error when requesting authorization with 2FA on", ^{
		[OHHTTPStubs addRequestHandler:^ id (NSURLRequest *request, BOOL onlyCheck) {
			if (![request.URL.path isEqual:[NSString stringWithFormat:@"/authorizations/clients/%@", OCTClientSpecClientID]] || ![request.HTTPMethod isEqual:@"PUT"]) return nil;

			NSURL *fileURL = [[NSBundle bundleForClass:self.class] URLForResource:@"authorizations" withExtension:@"json"];
			NSDictionary *headers = @{ @"X-GitHub-OTP": @"required; sms" };
			return [OHHTTPStubsResponse responseWithFileURL:fileURL statusCode:401 responseTime:0 headers:headers];
		}];

		RACSignal *request = [client requestAuthorizationWithPassword:@"" scopes:OCTClientAuthorizationScopesRepository clientID:OCTClientSpecClientID clientSecret:OCTClientSpecClientSecret];
		NSError *error;
		BOOL success = [request asynchronouslyWaitUntilCompleted:&error];
		expect(success).to.beFalsy();
		expect(error.domain).to.equal(OCTClientErrorDomain);
		expect(error.code).to.equal(OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired);
		expect([error.userInfo[OCTClientErrorOneTimePasswordMediumKey] integerValue]).to.equal(OCTClientOneTimePasswordMediumSMS);
	});

	it(@"should request authorization", ^{
		stubResponse([NSString stringWithFormat:@"/authorizations/clients/%@", OCTClientSpecClientID], @"authorizations.json");

		RACSignal *request = [client requestAuthorizationWithPassword:@"" scopes:OCTClientAuthorizationScopesRepository clientID:OCTClientSpecClientID clientSecret:OCTClientSpecClientSecret];
		OCTAuthorization *authorization = [request asynchronousFirstOrDefault:nil success:NULL error:NULL];
		expect(authorization).notTo.beNil();
		expect(authorization.objectID).to.equal(@"1");
		expect(authorization.token).to.equal(@"abc123");
	});
});

SpecEnd
