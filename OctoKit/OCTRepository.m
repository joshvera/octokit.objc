//
//  OCTRepository.m
//  OctoKit
//
//  Created by Timothy Clem on 2/14/11.
//  Copyright 2011 GitHub. All rights reserved.
//

#import "OCTRepository.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTURITemplateTransformer.h"
#import "OCTUser.h"
#import "OCTOrganization.h"

static NSString *const OCTRepositoryHTMLIssuesPath = @"issues";

@implementation OCTRepository

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"name": @"name",
		@"ownerLogin": @"owner.login",
		@"fullName": @"full_name",
		@"repoDescription": @"description",
		@"admin": @"permissions.admin",
		@"canPush": @"permissions.push",
		@"canPull": @"permissions.pull",
		@"private": @"private",
		@"fork": @"fork",
		@"owner": @"owner",
		@"organization": @"organization",
		@"homepage": @"homepage",
		@"size": @"size",
		@"language": @"language",
		@"hasWiki": @"has_wiki",
		@"hasIssues": @"has_issues",
		@"forkCount": @"forks",
		@"openIssuesCount": @"open_issues",
		@"watchersCount": @"watchers",
		@"networkCount": @"network_count",
		@"defaultBranch": @"default_branch",
		@"masterBranch": @"master_branch",
		@"datePushed": @"pushed_at",
		@"pushedAtDate": @"pushed_at",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"HTTPSURL": @"clone_url",
		@"HTMLURL": @"html_url",
		@"SSHURL": @"ssh_url",
		@"gitURL": @"git_url",
		@"SVNURL": @"svn_url",
		@"APIURITemplate": @"url",
		@"contributorsURITemplate": @"contributors_url",
		@"forksURITemplate": @"forks_url",
		@"mergesURITemplate": @"merges_url",
		@"notificationsURITemplate": @"notifications_url",
		@"gitTagsURITemplate": @"git_tags_url",
		@"gitRefsURITemplate": @"git_refs_url",
		@"tagsURITemplate": @"tags_url",
		@"languagesURITemplate": @"languages_url",
		@"keysURITemplate": @"keys_url",
		@"hooksURITemplate": @"hooks_url",
		@"issueEventsURITemplate": @"issue_events_url",
		@"eventsURITemplate": @"events_url",
		@"collaboratorsURITemplate": @"collaborators_url",
		@"teamsURITemplate": @"teams_url",
		@"assigneesURITemplate": @"assignees_url",
		@"branchesURITemplate": @"branches_url",
		@"blobsURITemplate": @"blobs_url",
		@"stargazersURITemplate": @"stargazers_url",
		@"subscribersURITemplate": @"subscribers_url",
		@"commitsURITemplate": @"commits_url",
		@"issueCommentURITemplate": @"issue_comment_url",
		@"compareURITemplate": @"compare_url",
		@"contentsURITemplate": @"contents_url",
		@"archiveURITemplate": @"archive_url",
		@"issuesURITemplate": @"issues_url",
		@"pullsURITemplate": @"pulls_url",
		@"milestonesURITemplate": @"milestones_url",
		@"labelsURITemplate": @"labels_url",
		@"treesURITemplate": @"trees_url",
		@"statusesURITemplate": @"statuses_url",
		@"cloneURL": @"clone_url",
		@"mirrorURL": @"mirror_url",
		@"watchers": NSNull.null
	}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)adminJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}
+ (NSValueTransformer *)canPushJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}
+ (NSValueTransformer *)canPullJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)privateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)forkJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)ownerJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUser.class];
}

+ (NSValueTransformer *)organizationJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTRepository.class];
}

+ (NSValueTransformer *)hasWikiJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)hasIssuesJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSValueTransformer *)datePushedJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)pushedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)archiveURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)assigneesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)blobsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)branchesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)cloneURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)collaboratorsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)commitsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)compareURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)contentsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)contributorsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)eventsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)forksURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)gitURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)gitRefsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)gitTagsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)hooksURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)HTTPSURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)issueCommentURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)issueEventsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)issuesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)keysURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)labelsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)languagesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)mergesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)milestonesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)mirrorURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)pullsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)stargazersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)notificationsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)SSHURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)statusesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)subscribersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)SVNURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)tagsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}


+ (NSValueTransformer *)teamsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)treesURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

#pragma mark Derived Properties

- (NSURL *)issuesHTMLURL {
	return [self.HTMLURL URLByAppendingPathComponent:OCTRepositoryHTMLIssuesPath];
}

#pragma mark Migration

+ (NSDictionary *)dictionaryValueFromArchivedExternalRepresentation:(NSDictionary *)externalRepresentation version:(NSUInteger)fromVersion {
	NSMutableDictionary *dictionaryValue = [[super dictionaryValueFromArchivedExternalRepresentation:externalRepresentation version:fromVersion] mutableCopy];

	// Although some of these keys match JSON key paths, the format of this
	// external representation is fixed (since it's always old data), thus the
	// hard-coding.
	dictionaryValue[@"name"] = externalRepresentation[@"name"];

	id owner = externalRepresentation[@"owner"];
	if ([owner isKindOfClass:NSString.class]) {
		dictionaryValue[@"ownerLogin"] = owner;
	} else if ([owner isKindOfClass:NSDictionary.class]) {
		dictionaryValue[@"ownerLogin"] = owner[@"login"];
	}

	dictionaryValue[@"repoDescription"] = externalRepresentation[@"description"] ?: NSNull.null;
	dictionaryValue[@"private"] = externalRepresentation[@"private"] ?: @NO;
	dictionaryValue[@"fork"] = externalRepresentation[@"fork"] ?: @NO;
	dictionaryValue[@"datePushed"] = [self.datePushedJSONTransformer transformedValue:externalRepresentation[@"pushed_at"]] ?: NSNull.null;
	dictionaryValue[@"HTTPSURL"] = [self.HTTPSURLJSONTransformer transformedValue:externalRepresentation[@"clone_url"]] ?: NSNull.null;
	dictionaryValue[@"SSHURL"] = externalRepresentation[@"ssh_url"] ?: NSNull.null;
	dictionaryValue[@"gitURL"] = [self.gitURLJSONTransformer transformedValue:externalRepresentation[@"git_url"]] ?: NSNull.null;

	NSString *HTMLURLString = externalRepresentation[@"html_url"] ?: externalRepresentation[@"url"];
	dictionaryValue[@"HTMLURL"] = [self.HTMLURLJSONTransformer transformedValue:HTMLURLString] ?: NSNull.null;

	return dictionaryValue;
}

@end
