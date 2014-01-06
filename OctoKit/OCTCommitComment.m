//
//  OCTCommitComment.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTCommitComment.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTURITemplateTransformer.h"
#import "OCTUser.h"

@implementation OCTCommitComment

@synthesize body = _body;
@synthesize path = _path;
@synthesize position = _position;
@synthesize commitSHA = _commitSHA;
@synthesize commenterLogin = _commenterLogin;
@synthesize creationDate = _creationDate;
@synthesize updatedDate = _updatedDate;

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"commitSHA": @"commit_id",
		@"path": @"path",
		@"line": @"line",
		@"position": @"position",
		@"body": @"body",
		@"HTMLBody": @"body_html",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"HTMLURL": @"html_url",
		@"commenterLogin": @"user.login",
		@"creationDate": @"created_at",
		@"updatedDate": @"updated_at",
		@"APIURITemplate": @"url",
		@"user": @"user"
	}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)creationDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
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
