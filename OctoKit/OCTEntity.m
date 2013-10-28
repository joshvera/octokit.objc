//
//  OCTEntity.m
//  OctoKit
//
//  Created by Josh Abernathy on 1/21/11.
//  Copyright 2011 GitHub. All rights reserved.
//

#import "OCTEntity.h"
#import "OCTPlan.h"
#import "OCTRepository.h"
#import "OCTUser.h"
#import "OCTOrganization.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTEntity

#pragma mark Class Cluster

+ (NSDictionary *)entityClassesByType {
	return @{
		@"User": OCTUser.class,
		@"Organization": OCTOrganization.class,
	};
}

#pragma mark Properties

@synthesize name = _name;
@synthesize type = _type;

- (NSString *)name {
	return _name ?: self.login;
}

- (NSString *)type {
	return _type ?: @"Organization";
}

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"gravatarID": @"gravatar_id",
		@"avatarURL": @"avatar_url",
		@"publicRepoCount": @"public_repos",
		@"privateRepoCount": @"owned_private_repos",
		@"diskUsage": @"disk_usage",
		@"APIURITemplate": @"url",
		@"HTMLURL": @"html_url",
		@"followersURITemplate": @"followers_url",
		@"followingURITemplate": @"following_url",
		@"gistsURITemplate": @"gists_url",
		@"starredURITemplate": @"starred_url",
		@"subscriptionsURITemplate": @"subscriptions_url",
		@"organizationsURITemplate": @"organizations_url",
		@"reposURITemplate": @"repos_url",
		@"eventsURITemplate": @"events_url",
		@"receivedEventsURITemplate": @"received_events_url"
	}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)repositoriesJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTRepository.class];
}

+ (NSValueTransformer *)avatarURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)planJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTPlan.class];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)followersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)followingURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)gistsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)starredURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)organizationsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)reposURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)eventsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)receivedEventsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)subscriptionsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

#pragma mark Merging

- (void)mergeRepositoriesFromModel:(OCTEntity *)entity {
	[self mergeRepositoriesWithRemoteCounterparts:entity.repositories];
}

- (void)mergeRepositoriesWithRemoteCounterparts:(NSArray *)remoteRepositories {
	if (remoteRepositories == nil) {
		// A nil array means that repositories were never fetched. An empty
		// array means that there are no remote repositories, so we should clear
		// ours out.
		return;
	}

	NSArray *localRepositories = [self.repositories copy];

	NSMutableArray *reposToAdd = [remoteRepositories mutableCopy];
	[reposToAdd removeObjectsInArray:localRepositories];
	
	NSMutableArray *reposToRemove = [localRepositories mutableCopy];
	[reposToRemove removeObjectsInArray:remoteRepositories];
	
	NSMutableArray *allRepos = [localRepositories mutableCopy] ?: [NSMutableArray array];
	[allRepos addObjectsFromArray:reposToAdd];
	[allRepos removeObjectsInArray:reposToRemove];
	
	// update every repo with the data from its remote equivalent
	for (OCTRepository *repo in allRepos) {
		NSUInteger index = [remoteRepositories indexOfObject:repo];
		if (index == NSNotFound) continue;
		
		OCTRepository *remoteCounterpart = remoteRepositories[index];
		[repo mergeValuesForKeysFromModel:remoteCounterpart];
	}
	
	self.repositories = allRepos;
}

#pragma mark Migration

+ (NSDictionary *)dictionaryValueFromArchivedExternalRepresentation:(NSDictionary *)externalRepresentation version:(NSUInteger)fromVersion {
	NSMutableDictionary *dictionaryValue = [[super dictionaryValueFromArchivedExternalRepresentation:externalRepresentation version:fromVersion] mutableCopy];

	// These keys will be copied as-is, one-to-one.
	NSArray *keysToCopy = @[ @"login", @"name", @"email", @"blog", @"company", @"collaborators" ];
	for (NSString *key in keysToCopy) {
		if (externalRepresentation[key] == nil) continue;

		dictionaryValue[key] = externalRepresentation[key];
	}

	// Although some of these keys match JSON key paths, the format of this
	// external representation is fixed (since it's always old data), thus the
	// hard-coding.
	dictionaryValue[@"repositories"] = [self.repositoriesJSONTransformer transformedValue:externalRepresentation[@"repositories"]] ?: NSNull.null;
	dictionaryValue[@"avatarURL"] = [self.avatarURLJSONTransformer transformedValue:externalRepresentation[@"avatar_url"]] ?: NSNull.null;
	dictionaryValue[@"publicRepoCount"] = externalRepresentation[@"public_repos"] ?: externalRepresentation[@"public_repo_count"] ?: @0;
	dictionaryValue[@"privateRepoCount"] = externalRepresentation[@"owned_private_repos"] ?: externalRepresentation[@"owned_private_repo_count"] ?: @0;
	dictionaryValue[@"diskUsage"] = externalRepresentation[@"disk_usage"] ?: @0;
	dictionaryValue[@"plan"] = [self.planJSONTransformer transformedValue:externalRepresentation[@"plan"]] ?: NSNull.null;

	return dictionaryValue;
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
	NSString *type = JSONDictionary[@"type"] ?: @"Organization";

	Class class = self.entityClassesByType[type];
	NSAssert(class != Nil, @"No known OCTEntity class for the type '%@'.", type);
	return class;
}

@end
