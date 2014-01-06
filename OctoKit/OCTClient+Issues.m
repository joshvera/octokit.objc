//
//  OCTClient+Issues.m
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "OCTClient+Issues.h"
#import "OCTClient+Private.h"

@implementation OCTClient (Issues)

- (RACSignal *)createIssueAtURITemplate:(CSURITemplate *)issuesTemplate withEdit:(OCTIssueEdit *)edit {
	NSParameterAssert(issuesTemplate != nil);
	NSParameterAssert(edit != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:edit];
	NSURLRequest *request = [self requestWithMethod:@"POST" template:issuesTemplate parameters:parameters];
	return [[self enqueueRequest:request resultClass:OCTGist.class] oct_parsedResults];
}

- (RACSignal *)fetchIssuesAtURITemplate:(CSURITemplate *)template parameters:(NSDictionary *)parameters {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:parameters];

	return [[self enqueueRequest:request resultClass:OCTIssue.class] oct_parsedResults];
}

@end
