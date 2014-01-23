//
//  OCTAuthenticatedUser.m
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTAuthenticatedUser.h"
#import "OCTPlan.h"

@implementation OCTAuthenticatedUser
@synthesize totalPrivateRepoCount = _totalPrivateRepoCount;
@synthesize ownedPrivateRepoCount = _ownedPrivateRepoCount;
@synthesize diskUsage = _diskUsage;
@synthesize collaboratorCount = _collaboratorCount;
@synthesize plan = _plan;
@synthesize privateGistCount = _privateGistCount;

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
	}];
}

+ (NSValueTransformer *)planJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTPlan.class];
}

@end
