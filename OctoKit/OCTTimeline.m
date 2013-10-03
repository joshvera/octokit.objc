//
//  OCTTimeline.m
//  OctoKit
//
//  Created by Josh Vera on 9/22/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTTimeline.h"
#import "OCTCommit.h"
#import "OCTIssueEvent.h"
#import "OCTCommitComment.h"
#import "OCTIssueComment.h"
#import "OCTCrossReference.h"
#import "OCTPullRequestComment.h"


@implementation OCTTimeline

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"crossReferences": @"cross_references",
			@"pullRequestComments": @"pull_request_review_comments",
			@"issueComments": @"issue_comments",
			@"commitComments": @"commit_comments",
			@"changedCommits": @"commits",
			@"issueEvents": @"issue_events",
		}];
}

+ (NSValueTransformer *)pullRequestCommentsJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTPullRequestComment.class];

}

+ (NSValueTransformer *)crossReferencesJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTCrossReference.class];
}

+ (NSValueTransformer *)issueCommentsJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTIssueComment.class];
}

+ (NSValueTransformer *)commitCommentsJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTCommitComment.class];
}

+ (NSValueTransformer *)issueEventsJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTIssueEvent.class];
}

+ (NSValueTransformer *)changedCommitsJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTCommit.class];
}

@end
