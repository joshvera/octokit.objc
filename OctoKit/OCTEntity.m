//
//  OCTEntity.m
//  OctoKit
//
//  Created by Josh Abernathy on 1/21/11.
//  Copyright 2011 GitHub. All rights reserved.
//

#import "OCTEntity.h"
#import "OCTPlan.h"
#import "OCTRepository.h"
#import "OCTUser.h"
#import "OCTOrganization.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTEntity

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"login": @"login",
		@"avatarURL": @"avatar_url",
		@"gravatarID": @"gravatar_id",
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
		@"type": @"type",
		@"siteAdmin": @"site_admin",
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

+ (NSValueTransformer *)subscriptionsURITemplateJSONTransformer {
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

@end
