//
//  OCTPullRequestComment.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTPullRequestComment.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTURITemplateTransformer.h"
#import "OCTUser.h"

@implementation OCTPullRequestComment
@synthesize line = _line;
@synthesize path = _path;
@synthesize position = _position;
@synthesize commitSHA = _commitSHA;

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"pullRequestAPIURL": @"_links.pull_request.href",
		@"pullRequestURITemplate": @"pull_request_url",
		@"body": @"body",
		@"HTMLBody": @"body_html",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"HTMLURL": @"html_url",
		@"commenterLogin": @"user.login",
		@"APIURITemplate": @"url",
		@"user": @"user",
		@"diffHunk": @"diff_hunk",
		@"position": @"position",
		@"originalPosition": @"original_position",
		@"line": @"line",
		@"path": @"path",
		@"commitSHA": @"commit_id",
		@"originalCommitSHA": @"original_commit_id",
	}];
}

+ (NSValueTransformer *)pullRequestAPIURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)pullRequestURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
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

+ (NSValueTransformer *)userJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUserEntity.class];
}

@end
