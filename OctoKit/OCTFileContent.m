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

- (BOOL)validateSize:(NSNumber **)sizePtr error:(NSError **)error {
	return (*sizePtr != nil);
}

@end
