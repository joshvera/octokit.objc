//
//  OCTUserOrganization.m
//  OctoKit
//
//  Created by Josh Vera on 1/22/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "OCTUserOrganization.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"

@implementation OCTUserOrganization
@synthesize name = _name;
@synthesize company = _company;
@synthesize blog = _blog;
@synthesize location = _location;
@synthesize email = _email;
@synthesize publicRepoCount = _publicRepoCount;
@synthesize publicGistCount = _publicGistCount;
@synthesize createdAtDate = _createdAtDate;
@synthesize updatedAtDate = _updatedAtDate;
@synthesize followerCount = _followerCount;
@synthesize followingCount = _followingCount;
@synthesize hireable = _hireable;
@synthesize bio = _bio;

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
			@"publicGistCount": @"public_gists",
			@"followerCount": @"followers",
			@"followingCount": @"following",
			@"createdAtDate": @"created_at",
			@"updatedAtDate": @"updated_at",
		}];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

@end
