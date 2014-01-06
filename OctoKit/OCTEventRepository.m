//
//  OCTEventRepository.m
//  OctoKit
//
//  Created by Josh Vera on 10/31/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTEventRepository.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTEventRepository

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
		return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"APIURITemplate": @"url",
		}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

@end
