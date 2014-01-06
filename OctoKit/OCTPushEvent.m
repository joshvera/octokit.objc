//
//  OCTPushEvent.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTPushEvent.h"
#import "OCTEventCommit.h"

@implementation OCTPushEvent

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"commitCount": @"payload.size",
		@"distinctCommitCount": @"payload.distinct_size",
		@"previousHeadSHA": @"payload.before",
		@"currentHeadSHA": @"payload.head",
		@"branchName": @"payload.ref",
		@"commits": @"payload.commits"
	}];
}

+ (NSValueTransformer *)branchNameJSONTransformer {
	static NSString * const branchRefPrefix = @"refs/heads/";

	return [MTLValueTransformer
		reversibleTransformerWithForwardBlock:^ id (NSString *ref) {
			if (![ref hasPrefix:branchRefPrefix]) {
				NSLog(@"%s: Unrecognized ref prefix: %@", __func__, ref);
				return nil;
			}

			return [ref substringFromIndex:branchRefPrefix.length];
		}
		reverseBlock:^(NSString *branch) {
			return [branchRefPrefix stringByAppendingString:branch];
		}];
}

+ (NSValueTransformer *)commitsJSONTransformer {
	return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTEventCommit.class];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *objectID) {
		return objectID;
	}];
}

@end
