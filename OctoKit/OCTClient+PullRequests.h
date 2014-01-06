//
//  OCTClient+PullRequests.h
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTClient (PullRequests)

- (RACSignal *)fetchPullRequestsAtURITemplate:(CSURITemplate *)template;

@end
