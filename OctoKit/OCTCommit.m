//
//  OCTCommit.m
//  OctoKit
//
//  Created by Josh Vera on 8/14/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTCommit.h"
#import "OCTUser.h"
#import "OCTFile.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"

@implementation OCTCommit

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"objectID": @"sha",
			@"SHA": @"sha",
			@"message": @"commit.message",
			@"authoredDate": @"commit.author.date",
			@"committedDate": @"commit.committer.date",
			@"APIURL": @"url",
			@"HTMLURL": @"html_url",
			@"commentsURL": @"comments_url",
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

+ (NSValueTransformer *)APIURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)commentsURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)authorJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

+ (NSValueTransformer *)committerJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}


+ (NSValueTransformer *)filesJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTFile.class];
}

@end
