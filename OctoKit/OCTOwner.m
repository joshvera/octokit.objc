//
//  OCTOwner.m
//  GitHub
//
//  Created by Josh Vera on 10/19/13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "OCTOwner.h"
#import "OCTURITemplateTransformer.h"
#import "OCTPlan.h"

@implementation OCTOwner

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"publicRepoCount": @"public_repos",
		@"privateRepoCount": @"owned_private_repos",
		@"gravatarID": @"gravatar_id",
		@"avatarURL": @"avatar_url",
		@"diskUsage": @"disk_usage",
		@"APIURITemplate": @"url",
		@"HTMLURL": @"html_url",
		@"followersURITemplate": @"followers_url",
		@"followingURITemplate": @"following_url",
		@"gistsURITemplate": @"gists_url",
		@"starredURITemplate": @"starred_url",
		@"subscriptionsURITemplate": @"subscriptions_url",
		@"organizationsURITemplate": @"organizations_url",
		@"reposURITemplate": @"repos_url",
		@"eventsURITemplate": @"events_url",
		@"receivedEventsURITemplate": @"received_events_url",
		@"siteAdmin": @"site_admin",
		@"followingCount": @"following",
		@"followersCount": @"followers"
	}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)followersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)followingURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)gistsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)starredURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)organizationsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
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

+ (NSValueTransformer *)subscriptionsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)planJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTPlan.class];
}

@end
