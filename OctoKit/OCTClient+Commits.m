//
//  OCTClient+Commits.m
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "OCTClient+Commits.h"
#import "OCTClient+Private.h"

@implementation OCTClient (Commits)

- (RACSignal *)fetchCommitsAtPullRequestURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	request.URL = [request.URL URLByAppendingPathComponent:@"commits"];
	[request setValue:@"application/vnd.github.beta.html+json" forHTTPHeaderField:@"Accept"];

	return [[self enqueueRequest:request resultClass:OCTCommit.class] oct_parsedResults];
}

@end
