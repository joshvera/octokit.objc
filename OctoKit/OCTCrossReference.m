//
//  OCTCrossReference.m
//  OctoKit
//
//  Created by Josh Vera on 9/20/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTCrossReference.h"
#import "OCTUser.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTCrossReference

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"sourceTitle": @"source.title",
			@"sourceType": @"source.type",
			@"sourceNumber": @"source.number",
			@"sourceID": @"source.id",
			@"sourceURITemplate": @"source.url",
			@"targetTitle": @"target.title",
			@"targetType": @"target.type",
			@"targetNumber": @"target.number",
			@"targetID": @"target.id",
			@"targetURITemplate": @"target.url",
			@"user": @"user"
		}];
}

+ (NSValueTransformer *)userJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

+ (NSValueTransformer *)sourceURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)targetURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}


@end
