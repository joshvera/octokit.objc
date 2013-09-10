//
//  OCTNotification.m
//  OctoKit
//
//  Created by Josh Abernathy on 1/22/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTNotification.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSValueTransformer+OCTPredefinedTransformerAdditions.h"
#import "OCTURITemplateTransformer.h"
#import "OCTRepository.h"
#import "OCTCommit.h"
#import "OCTIssue.h"
#import "OCTPullRequest.h"

NSString * const OCTNotificationErrorDomain = @"OCTNotificationErrorDomain";

NSInteger const OCTNotificationErrorTypeUnknown = -600;

@implementation OCTNotification

#pragma mark MTLModel

+ (NSSet *)propertyKeys {
	NSMutableSet *keys = [super.propertyKeys mutableCopy];

	// This is a derived property.
	[keys removeObject:@keypath(OCTNotification.new, subjectClass)];

	return keys;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"title": @"subject.title",
		@"threadURL": @"url",
		@"subjectURITemplate": @"subject.url",
		@"latestCommentURL": @"subject.latest_comment_url",
		@"type": @"subject.type",
		@"repository": @"repository",
		@"lastUpdatedDate": @"updated_at",
	}];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer transformerWithBlock:^ id (id num) {
		if ([num isKindOfClass:NSString.class]) {
			return num;
		} else if ([num isKindOfClass:NSNumber.class]) {
			return [num stringValue];
		} else {
			return nil;
		}
	}];
}

+ (NSValueTransformer *)threadURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)subjectURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)latestCommentURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)repositoryJSONTransformer {
	return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:OCTRepository.class];
}

+ (NSValueTransformer *)lastUpdatedDateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTDateValueTransformerName];
}

+ (NSValueTransformer *)typeJSONTransformer {
	NSDictionary *typesByName = @{
		@"Issue": @(OCTNotificationTypeIssue),
		@"PullRequest": @(OCTNotificationTypePullRequest),
		@"Commit": @(OCTNotificationTypeCommit),
	};

	return [MTLValueTransformer
		reversibleTransformerWithForwardBlock:^(NSString *name) {
			return typesByName[name] ?: @(OCTNotificationTypeUnknown);
		} reverseBlock:^(NSNumber *type) {
			return [typesByName allKeysForObject:type].lastObject;
		}];
}

# pragma mark - Initialization

- (Class)subjectClass {
	Class class;

	switch (self.type) {
		case OCTNotificationTypeCommit:
			class = OCTCommit.class;
			break;
		case OCTNotificationTypeIssue:
			class = OCTIssue.class;
			break;
		case OCTNotificationTypePullRequest:
			class = OCTPullRequest.class;
			break;
		default:
			break;
	}

	return class;
}

@end
