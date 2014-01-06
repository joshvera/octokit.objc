//
//  OCTClient+Issues.h
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@interface OCTClient (Issues)

- (RACSignal *)createIssueAtURITemplate:(CSURITemplate *)issuesTemplate withEdit:(OCTIssueEdit *)edit;

- (RACSignal *)fetchIssuesAtURITemplate:(CSURITemplate *)template parameters:(NSDictionary *)parameters;

@end
