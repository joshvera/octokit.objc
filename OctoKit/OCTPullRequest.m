//
//  OCTPullRequest.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTPullRequest.h"
#import "OCTURITemplateTransformer.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTUser.h"
#import "OCTMilestone.h"
#import "OCTRepository.h"

@implementation OCTPullRequest

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"HTMLBody": @"body_html",
		@"user": @"user",
		@"assignee": @"assignee",
		@"milestone": @"milestone",
		@"URL" : @"url",
		@"HTMLURL": @"html_url",
		@"diffURL": @"diff_url",
		@"patchURL": @"patch_url",
		@"issueURL": @"issue_url",
		@"remoteID": @"number",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"additions": @"additions",
		@"deletions": @"deletions",
		@"APIURITemplate": @"url",
		@"reviewCommentsURITemplate": @"_links.review_comments.href",
		@"commentsURITemplate": @"comments_url",
		@"headSHA": @"head.sha",
		@"headRefName": @"head.ref",
		@"headUser": @"head.user",
		@"headRepository": @"head.repo",
		@"headLabel": @"head.label",
		@"baseSHA": @"base.sha",
		@"baseRefName": @"base.ref",
		@"baseLabel": @"base.label",
		@"baseUser": @"base.user",
		@"baseRepository": @"base.repo"
	}];
}

+ (NSValueTransformer *)URLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)diffURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)patchURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)issueURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)userJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

+ (NSValueTransformer *)assigneeJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

+ (NSValueTransformer *)milestoneJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTMilestone.class];
}

+ (NSValueTransformer *)baseUserJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

+ (NSValueTransformer *)baseRepositoryJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTRepository.class];
}

+ (NSValueTransformer *)headUserJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

+ (NSValueTransformer *)headRepositoryJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTRepository.class];
}

+ (NSValueTransformer *)stateJSONTransformer {
	NSDictionary *statesByName = @{
		@"open": @(OCTPullRequestStateOpen),
		@"closed": @(OCTPullRequestStateClosed),
	};

	return [MTLValueTransformer
		reversibleTransformerWithForwardBlock:^(NSString *stateName) {
			return statesByName[stateName];
		}
		reverseBlock:^(NSNumber *state) {
			return [statesByName allKeysForObject:state].lastObject;
		}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)reviewCommentsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)commentsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

@end
