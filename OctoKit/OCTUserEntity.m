//
//  OCTUserEntity.m
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTUserEntity.h"
#import "OCTURITemplateTransformer.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"

@implementation OCTUserEntity

#pragma mark MTLJSONSerializing

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

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

@end
