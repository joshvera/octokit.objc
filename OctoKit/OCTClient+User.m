//
//  OCTClient+User.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2013-11-22.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTClient+User.h"
#import "OCTClient+Private.h"
#import "OCTUser.h"
#import "RACSignal+OCTClientAdditions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation OCTClient (User)

- (RACSignal *)fetchUserAtURITemplate:(CSURITemplate *)template {
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];

	return [[self enqueueRequest:request resultClass:OCTUser.class] oct_parsedResults];
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

@end
