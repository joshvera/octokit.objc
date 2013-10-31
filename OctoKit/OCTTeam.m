//
//  OCTTeam.m
//  OctoKit
//
//  Created by Josh Abernathy on 3/28/12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTTeam.h"
#import "OCTURITemplateTransformer.h"

@implementation OCTTeam

- (NSString *)type {
	return @"Team";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return [[super
		JSONKeyPathsByPropertyKey]
		mtl_dictionaryByAddingEntriesFromDictionary:@{
			@"membersURITemplate": @"members_url",
			@"reposURITemplate": @"repositories_url"
		}];
}

#pragma mark NSObject

// I kinda hate implementing this to something so mostly useless, but this makes bindings happier.
- (NSString *)description {
	return self.name;
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
	return self;
}

+ (NSValueTransformer *)membersURITemplateJSONTransformer {
	return [NSValueTransformer valueTransformerForName:OCTURITemplateValueTransformerName];
}

@end
