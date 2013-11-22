//
//  OCTForkedRepository.m
//  OctoKit
//
//  Created by Josh Vera on 11/22/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTForkedRepository.h"

@implementation OCTForkedRepository

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"sourceRepository": @"source",
		@"parentRepository": @"parent"
	}];
}

+ (NSValueTransformer *)parentRepositoryJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTRepository.class];
}

+ (NSValueTransformer *)sourceRepositoryJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTRepository.class];
}

@end
