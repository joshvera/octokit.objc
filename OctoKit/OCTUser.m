//
//  OCTUser.m
//  OctoKit
//
//  Created by Joe Ricioppo on 7/28/10.
//  Copyright 2010 GitHub. All rights reserved.
//

#import "OCTUser.h"
#import "OCTURITemplateTransformer.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"

@implementation OCTUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"name": @"name",
			@"company": @"company",
			@"blog": @"blog",
			@"location": @"location",
			@"email": @"email",
			@"hireable": @"hireable",
			@"bio": @"bio",
			@"publicRepoCount": @"public_repos",
			@"followerCount": @"followers",
			@"followingCount": @"following",
			@"createdAtDate": @"created_at",
			@"updatedAtDate": @"updated_at",
			@"publicGistCount": @"public_gists",
		}];
}

+ (NSValueTransformer *)hireableJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

@end