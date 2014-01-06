//
//  OCTClient+Comments.m
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "OCTClient+Comments.h"
#import "OCTClient+Private.h"

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
