//
//  OCTCommit.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2013-11-22.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTCommit.h"
#import "OCTUser.h"
#import "OCTDiffEntry.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTCommit

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"objectID": @"sha",
			@"commitSHA": @"sha",
			@"SHA": @"sha",
			@"treeURL": @"tree.url",
			@"treeSHA": @"tree.sha",
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

+ (NSValueTransformer *)treeURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

#pragma mark NSObject

- (NSUInteger)hash {
	return self.SHA.hash;
}

- (BOOL)isEqual:(OCTCommit *)commit {
	if (self == commit) return YES;
	if (![commit isKindOfClass:OCTCommit.class]) return NO;

	return [self.SHA isEqual:commit.SHA];
}

@end
