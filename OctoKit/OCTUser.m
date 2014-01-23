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
#import "OCTAuthenticatedUser.h"

@implementation OCTUser
@synthesize name = _name;
@synthesize company = _company;
@synthesize blog = _blog;
@synthesize location = _location;
@synthesize email = _email;
@synthesize publicRepoCount = _publicRepoCount;
@synthesize publicGistCount = _publicGistCount;
@synthesize createdAtDate = _createdAtDate;
@synthesize updatedAtDate = _updatedAtDate;
@synthesize hireable = _hireable;
@synthesize followerCount = _followerCount;
@synthesize followingCount = _followingCount;
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

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
	if (JSONDictionary[@"plan"] != nil) return OCTAuthenticatedUser.class;
	return self;
}

@end
