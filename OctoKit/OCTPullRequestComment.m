//
//  OCTPullRequestComment.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTPullRequestComment.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import <CSURITemplate/CSURITemplate.h>
#import "OCTURITemplateTransformer.h"

@implementation OCTPullRequestComment

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"pullRequestAPIURL": @"pull_request_url",
		@"body": @"body",
		@"HTMLBody": @"body_html",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"HTMLURL": @"html_url",
		@"commenterLogin": @"user.login",
		@"APIURITemplate": @"url"
	}];
}

+ (NSValueTransformer *)pullRequestAPIURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

@end
