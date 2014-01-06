//
//  OCTEventCommit.m
//  GitHub
//
//  Created by Josh Vera on 11/8/13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "OCTEventCommit.h"
#import "OCTURITemplateTransformer.h"


@implementation OCTEventCommit

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"objectID": @"sha",
			@"commitSHA": @"sha",
			@"authorName": @"author.name",
			@"authorEmail": @"author.email",
			@"APIURITemplate": @"url"
		}];
}

+ (NSValueTransformer *)APIURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *objectID) {
		return objectID;
	}];
}

@end
