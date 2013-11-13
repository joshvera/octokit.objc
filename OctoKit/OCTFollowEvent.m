//
//  OCTFollowEvent.m
//  OctoKit
//
//  Created by Josh Vera on 11/11/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTFollowEvent.h"
#import "OCTEntity.h"

@implementation OCTFollowEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"followee": @"payload.target",
			@"repository": NSNull.null
		}];
}

+ (NSValueTransformer *)followeeJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTEntity.class];
}

@end
