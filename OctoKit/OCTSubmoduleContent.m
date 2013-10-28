//
//  OCTSubmoduleContent.m
//  OctoKit
//
//  Created by Aron Cedercrantz on 14-07-2013.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTSubmoduleContent.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTSubmoduleContent
@synthesize APIURL = _APIURL;

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"submoduleGitURL": @"submodule_git_url",
		@"submoduleTreeURL": @"url",
		@"size": NSNull.null,
	}];
}

- (NSURL *)APIURL {
	if (_APIURL != nil) return _APIURL;
	NSURLComponents *components = [NSURLComponents componentsWithURL:self.submoduleTreeURL resolvingAgainstBaseURL:NO];
	components.path = [[[components.path
		stringByDeletingLastPathComponent]
		stringByDeletingLastPathComponent]
		stringByDeletingLastPathComponent];
	components.query = nil;
	_APIURL = components.URL;

	return _APIURL;
}

+ (NSValueTransformer *)submoduleTreeURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
