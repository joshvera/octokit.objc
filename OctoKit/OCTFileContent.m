//
//  OCTFileContent.m
//  OctoKit
//
//  Created by Aron Cedercrantz on 14-07-2013.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTFileContent.h"

@implementation OCTFileContent



#pragma mark NSKeyValueCoding

- (BOOL)validateContent:(NSString **)contentPtr error:(NSError **)error {
	return (*contentPtr != nil);
}

+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
	return self;
}

@end
