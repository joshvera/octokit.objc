//
//  OCTPublicOrganization.m
//  OctoKit
//
//  Created by Josh Vera on 10/21/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTPublicOrganization.h"
#import "OCTURITemplateTransformer.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTPrivateOrganization.h"

@implementation OCTPublicOrganization
@synthesize name = _name;
@synthesize company = _company;
@synthesize blog = _blog;
@synthesize location = _location;
@synthesize email = _email;
@synthesize publicRepoCount = _publicRepoCount;
@synthesize publicGistCount = _publicGistCount;
@synthesize followingCount = _followingCount;
@synthesize followerCount = _followerCount;
@synthesize createdAtDate = _createdAtDate;
@synthesize updatedAtDate = _updatedAtDate;

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"HTMLURL": @"html_url",
			@"type": @"type",
			@"name": @"name",
			@"company": @"company",
			@"blog": @"blog",
			@"location": @"location",
			@"email": @"email",
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

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
