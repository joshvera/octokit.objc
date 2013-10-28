//
//  RACSignal+OCTClientAdditions.m
//  OctoKit
//
//  Created by Alan Rogers on 8/03/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "RACSignal+OCTClientAdditions.h"
#import "OCTResponse.h"

@implementation RACSignal (OCTClientAdditions)

- (RACSignal *)oct_parsedResults {
	return [self map:^(RACSignal *signal) {
		return [signal map:^(OCTResponse *response) {
			return response.parsedResult;
		}];
	}];
}

@end
