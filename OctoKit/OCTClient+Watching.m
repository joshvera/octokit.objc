//
//  OCTClient+Watching.m
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "OCTClient+Watching.h"
#import "OCTClient+Private.h"

@implementation OCTClient (Watching)

- (RACSignal *)fetchWatchedRepositoriesForEntity:(OCTEntity *)entity {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];
	
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:entity.subscriptionsURITemplate parameters:nil];

	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

@end