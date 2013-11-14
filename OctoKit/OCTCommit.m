//
//  OCTCommit.m
//  OctoKit
//
//  Created by Josh Vera on 8/14/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTCommit.h"
#import "OCTUser.h"
#import "OCTDiffEntry.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTCommit

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"objectID": @"sha",
			@"commitSHA": @"sha",
			@"message": @"commit.message",
			@"authoredDate": @"commit.author.date",
			@"committedDate": @"commit.committer.date",
			@"APIURITemplate": @"url",
			@"HTMLURL": @"html_url",
			@"commentsURITemplate": @"comments_url",
			@"committer": @"committer",
			@"author": @"author",
			@"total": @"total",
			@"additions": @"additions",
			@"deletions": @"deletions",
			@"files": @"files",
		}];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *objectID) {
		return objectID;
	}];
}

+ (NSValueTransformer *)authoredDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)committedDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)commentsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)authorJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUserEntity.class];
}

+ (NSValueTransformer *)committerJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUserEntity.class];
}


+ (NSValueTransformer *)filesJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTDiffEntry.class];
}

@end
