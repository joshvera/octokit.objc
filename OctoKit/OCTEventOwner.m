//
//  OCTEventOwner.m
//  OctoKit
//
//  Created by Josh Vera on 10/31/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTEventOwner.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTEventOwner

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
		return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"APIURITemplate": @"url",
			@"gravatarID": @"gravatar_id",
			@"avatarURL": @"avatar_url",
		}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
