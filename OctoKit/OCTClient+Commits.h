//
//  OCTClient+Commits.h
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTClient (Commits)

- (RACSignal *)fetchCommitsAtPullRequestURITemplate:(CSURITemplate *)template;

- (RACSignal *)fetchCommitsAtURITemplate:(CSURITemplate *)template branchNameOrSHA:(NSString *)branchNameOrSHA perPage:(NSUInteger)perPage;

@end
