//
//  OCTSubmoduleContent.m
//  OctoKit
//
//  Created by Aron Cedercrantz on 14-07-2013.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTSubmoduleContent.h"
#import "OCTURITemplateTransformer.h"
#import "CSURITemplate.h"

@implementation OCTSubmoduleContent
@synthesize APIURITemplate = _APIURITemplate;

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [super.JSONKeyPathsByPropertyKey mtl_dictionaryByAddingEntriesFromDictionary:@{
		@"submoduleGitURL": @"submodule_git_url",
		@"submoduleTreeURL": @"git_url",
		@"size": NSNull.null,
	}];
}

- (CSURITemplate *)APIURITemplate {
	if (_APIURITemplate != nil) return _APIURITemplate;
	NSURLComponents *components = [NSURLComponents componentsWithURL:self.submoduleTreeURL resolvingAgainstBaseURL:NO];
	components.path = [[[components.path
		stringByDeletingLastPathComponent]
		stringByDeletingLastPathComponent]
		stringByDeletingLastPathComponent];
	components.query = nil;
	_APIURITemplate = [CSURITemplate URITemplateWithString:components.URL.absoluteString error:NULL];

	return _APIURITemplate;
}

+ (NSValueTransformer *)submoduleTreeURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
