//
//  OCTContributor.m
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTContributor.h"

@implementation OCTContributor

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super 
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"contributionCount": @"contributions"
	}];
}

@end
