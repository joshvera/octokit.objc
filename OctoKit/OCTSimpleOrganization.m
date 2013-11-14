//
//  OCTSimpleOrganization.m
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTSimpleOrganization.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTSimpleOrganization

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super 
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"login": @"login",
			@"avatarURL": @"avatar_url",
			@"APIURITemplate": @"url",
			@"reposURITemplate": @"repos_url",
			@"eventsURITemplate": @"events_url",
			@"membersURITemplate": @"members_url",
			@"publicMembersURITemplate": @"public_members_url",
		}];
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)reposURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)eventsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)membersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)publicMembersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

@end
