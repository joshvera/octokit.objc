//
//  OCTClient+Comments.h
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTClient (Comments)

- (RACSignal *)fetchIssueCommentsForSubject:(OCTIssue *)issue;

- (RACSignal *)fetchCommentsAtURITemplate:(CSURITemplate *)template resultClass:(Class)class;

- (RACSignal *)fetchReviewCommentsForPullRequest:(OCTPullRequest *)pullRequest;

@end
