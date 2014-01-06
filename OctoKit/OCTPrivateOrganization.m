//
//  OCTPrivateOrganization.m
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTPrivateOrganization.h"
#import "OCTPlan.h"

@implementation OCTPrivateOrganization

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
