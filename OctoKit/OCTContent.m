//
//  OCTContent.m
//  OctoKit
//
//  Created by Aron Cedercrantz on 14-07-2013.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTContent.h"
#import "OCTPartialFileContent.h"
#import "OCTDirectoryContent.h"
#import "OCTSymlinkContent.h"
#import "OCTSubmoduleContent.h"

@interface OCTContent ()

@end

@implementation OCTContent

#pragma mark Class Cluster

+ (NSDictionary *)contentClassesByType {
	return @{
		@"file": OCTPartialFileContent.class,
		@"dir": OCTDirectoryContent.class,
		@"symlink": OCTSymlinkContent.class,
		@"submodule": OCTSubmoduleContent.class,
	};
}

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"SHA": @"sha",
		@"objectID": @"sha",
		@"relativePath": @"path"
	}];
}

+ (NSValueTransformer *)objectIDJSONTransformer {
	return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *objectID) {
		return objectID;
	}];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError *__autoreleasing *)error {
	self = [super initWithDictionary:dictionaryValue error:error];
	if (self == nil) return nil;

	_relativePath = [self.path stringByDeletingLastPathComponent];

	return self;
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
	NSString *type = JSONDictionary[@"type"];
	NSAssert(type != nil, @"OCTContent JSON dictionary must contain a type string.");

	if ([type isEqualToString:@"file"]) {
		// Check if its a submodule by checking if its git URL repo differs from its URL repo
		NSString *gitURL = [NSURL URLWithString:JSONDictionary[@"git_url"]];
		NSString *APIURL = [NSURL URLWithString:JSONDictionary[@"url"]];
		NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 3)];
		NSArray *gitComponents = [gitURL.pathComponents objectsAtIndexes:indexes];
		NSArray *APIComponents = [APIURL.pathComponents objectsAtIndexes:indexes];

		if (![gitComponents isEqualToArray:APIComponents]) {
			type = @"submodule";
		}
	}

	Class class = self.contentClassesByType[type];

	NSAssert(class != Nil, @"No known OCTContent class for the type '%@'.", type);
	return class;
}

@end
