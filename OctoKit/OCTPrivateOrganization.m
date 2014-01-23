//
//  OCTPrivateOrganization.m
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTPrivateOrganization.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTPlan.h"

@implementation OCTPrivateOrganization
@synthesize totalPrivateRepoCount = _totalPrivateRepoCount;
@synthesize ownedPrivateRepoCount = _ownedPrivateRepoCount;
@synthesize diskUsage = _diskUsage;
@synthesize collaboratorCount = _collaboratorCount;
@synthesize plan = _plan;
@synthesize privateGistCount = _privateGistCount;
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

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super 
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"totalPrivateRepoCount": @"total_private_repos",
			@"ownedPrivateRepoCount": @"owned_private_repos",
			@"diskUsage": @"disk_usage",
			@"collaboratorCount": @"collaborators",
			@"plan": @"plan",
			@"privateGistCount": @"private_gists",
			@"name": @"name",
			@"company": @"company",
			@"blog": @"blog",
			@"location": @"location",
			@"email": @"email",
			@"publicRepoCount": @"public_repos",
			@"publicGistCount": @"public_gists",
			@"createdAtDate": @"created_at",
			@"updatedAtDate": @"updated_at",
			@"HTMLURL": @"html_url",
			@"type": @"type"
	}];
}

+ (NSValueTransformer *)planJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTPlan.class];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
