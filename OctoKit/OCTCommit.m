//
//  OCTCommit.m
//  OctoKit
//
//  Created by Josh Vera on 8/14/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTCommit.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"

@implementation OCTCommit

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"SHA": @"sha",
			@"message": @"commit.message",
			@"authorDate": @"commit.author.date",
			@"updatedAtDate": @"commit.committer.date",
			@"authorName": @"commit.author.name",
			@"objectID": @"sha",
			@"avatarURL": @"author.avatar_url"
		}];
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)authorDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *objectID) {
		return objectID;
	}];
}

@end
