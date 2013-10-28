//
//  OCTDiffEntry.m
//  OctoKit
//
//  Created by Josh Vera on 8/30/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTDiffEntry.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTDiffEntry

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
        @"objectID": @"sha",
        @"blobSHA": @"sha",
        @"blobURL": @"blob_url",
        @"rawURL": @"raw_url",
        @"contentsURITemplate": @"contents_url",
    }];
}

+ (NSValueTransformer *)blobURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)rawURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)contentsURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *objectID) {
		return objectID;
	}];
}


@end

