//
//  OCTOrganization.m
//  OctoKit
//
//  Created by Joe Ricioppo on 10/27/10.
//  Copyright 2010 GitHub. All rights reserved.
//

#import "OCTOrganization.h"
#import "OCTURITemplateTransformer.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"

@implementation OCTOrganization

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super 
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"login": @"login",
			@"avatarURL": @"avatar_url",
			@"APIURITemplate": @"url",
			@"HTMLURL": @"html_url",
			@"reposURITemplate": @"repos_url",
			@"eventsURITemplate": @"events_url",
			@"receivedEventsURITemplate": @"received_events_url",
			@"membersURITemplate": @"members_url",
			@"publicMembersURITemplate": @"public_members_url",
			@"type": @"type",
			@"siteAdmin": @"site_admin",
			@"name": @"name",
			@"company": @"company",
			@"blog": @"blog",
			@"location": @"location",
			@"email": @"email",
			@"publicRepoCount": @"public_repos",
			@"publicGistCount": @"public_gists",
			@"createdAtDate": @"created_at",
			@"updatedAtDate": @"updated_at",
		}];
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)reposURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)eventsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)receivedEventsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)membersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)publicMembersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)siteAdminJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

@end
