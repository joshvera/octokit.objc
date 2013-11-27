//
//  OCTLabel.m
//  OctoKit
//
//  Created by Josh Vera on 11/26/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTLabel.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTLabel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"objectID": @"url",
		@"APIURITemplate": @"url",
		@"hexColor": @"color",
		@"name": @"name"
	}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return nil;
}

@end
