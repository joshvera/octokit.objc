//
//  OCTClient+PullRequests.m
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "OCTClient+PullRequests.h"
#import "OCTClient+Private.h"

@implementation OCTClient (PullRequests)

- (RACSignal *)fetchPullRequestsAtURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];

	return [[self enqueueRequest:request resultClass:OCTPullRequest.class] oct_parsedResults];
}

@end
