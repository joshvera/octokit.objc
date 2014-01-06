//
//  OCTClient+Notifications.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2013-11-22.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTClient+Notifications.h"
#import "NSDateFormatter+OCTFormattingAdditions.h"
#import "OCTClient+Private.h"
#import "OCTNotification.h"
#import "OCTRepository.h"
#import "RACSignal+OCTClientAdditions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation OCTClient (Notifications)

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
