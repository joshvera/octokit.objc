//
//  OCTNote.m
//  OctoKit
//
//  Created by Josh Vera on 6/20/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTNote.h"
#import "OCTUser.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"

@implementation OCTNote

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"body": @"body",
		@"noteURL": @"url",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"user": @"user"
	}];
}

+ (NSValueTransformer *)noteURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)userJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

@end
