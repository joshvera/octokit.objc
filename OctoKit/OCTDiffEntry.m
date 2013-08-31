//
//  OCTDiffEntry.m
//  OctoKit
//
//  Created by Josh Vera on 8/30/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTDiffEntry.h"

@implementation OCTDiffEntry

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
        @"objectID": @"sha",
        @"diffSHA": @"sha",
        @"filename": @"filename",
        @"status": @"status",
        @"additions": @"additions",
        @"deletions": @"deletions",
        @"changes": @"changes",
        @"blobURL": @"blob_url",
        @"rawURL": @"raw_url",
        @"contentsURL": @"contents_url",
        @"patch": @"patch",
    }];
}

+ (NSValueTransformer *)blobURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)rawURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)contentsURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *objectID) {
		return objectID;
	}];
}


@end

