//
//  OCTMilestone.m
//  OctoKit
//
//  Created by Josh Vera on 9/4/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTMilestone.h"
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTURITemplateTransformer.h"
#import "OCTUser.h"


@implementation OCTMilestone

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"remoteID": @"number",
		@"title": @"title",
		@"state": @"state",
		@"milestoneDescription": @"description",
		@"creator": @"creator",
		@"openIssuesCount": @"open_issues",
		@"closedIssuesCount": @"closed_issues",
		@"createdAtDate": @"created_at",
		@"updatedAtDate": @"updated_at",
		@"dueDate": @"due_on",
		@"APIURITemplate": @"url",
		@"labelsURITemplate": @"labels_url",
	}];
}

+ (NSValueTransformer *)creatorJSONTransformer {
	return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTUserEntity.class];
}

+ (NSValueTransformer *)createdAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)updatedAtDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)dueDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)labelsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)stateJSONTransformer {
	NSDictionary *statesByName = @{
		@"open": @(OCTMilestoneStateOpen),
		@"closed": @(OCTMilestoneStateClosed),
	};

	return [MTLValueTransformer
		reversibleTransformerWithForwardBlock:^(NSString *stateName) {
			return statesByName[stateName];
		}
		reverseBlock:^(NSNumber *state) {
			return [statesByName allKeysForObject:state].lastObject;
		}];
}

@end
