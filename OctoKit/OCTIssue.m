//
//  OCTIssue.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTIssue.h"
#import "OCTPullRequest.h"
#import <ReactiveCocoa/EXTKeyPathCoding.h>
#import "OCTURITemplateTransformer.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTUser.h"
#import "OCTMilestone.h"

@interface OCTIssue ()

// The webpage URL for any attached pull request.
@property (nonatomic, copy, readonly) NSURL *pullRequestHTMLURL;

@end

@implementation OCTIssue

#pragma mark Properties

- (OCTPullRequest *)pullRequest {
	if (self.pullRequestHTMLURL == nil) return nil;

	// We don't have a "real" pull request model within the issue data, but we
	// have enough information to construct one.
	return [OCTPullRequest modelWithDictionary:@{
		@keypath(OCTPullRequest.new, objectID): self.objectID,
		@keypath(OCTPullRequest.new, HTMLURL): self.pullRequestHTMLURL,
		@keypath(OCTPullRequest.new, title): self.title,
	} error:NULL];
}

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"HTMLURL": @"html_url",
		@"pullRequestHTMLURL": @"pull_request.html_url",
		@"commentsURITemplate": @"comments_url",
		@"HTMLBody": @"body_html",
		@"user": @"user",
		@"assignee": @"assignee",
		@"milestone": @"milestone",
		@"HTMLURL": @"html_url",
		@"remoteID": @"number",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"APIURITemplate": @"url",
		@"reviewCommentsURITemplate": @"review_comments_url",
		@"commentsURITemplate": @"comments_url",
		@"commentCount": @"comments",
	}];
}

+ (NSValueTransformer *)HTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)pullRequestHTMLURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)userJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUserEntity.class];
}

+ (NSValueTransformer *)assigneeJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUserEntity.class];
}

+ (NSValueTransformer *)milestoneJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTMilestone.class];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)commentsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

@end
