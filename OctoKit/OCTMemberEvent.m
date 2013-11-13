//
//  OCTMemberEvent.m
//  OctoKit
//
//  Created by Josh Vera on 11/11/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTMemberEvent.h"
#import "OCTEventOwner.h"

@implementation OCTMemberEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"eventMember": @"member"
		}];
}

+ (NSValueTransformer *)eventMemberJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTEventOwner.class];
}

@end
