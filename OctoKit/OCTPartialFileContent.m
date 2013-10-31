//
//  OCTPartialFileContent.m
//  OctoKit
//
//  Created by Josh Vera on 10/30/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTPartialFileContent.h"

@implementation OCTPartialFileContent

#pragma mark NSKeyValueCoding

- (BOOL)validateSize:(NSNumber **)sizePtr error:(NSError **)error {
	return (*sizePtr != nil);
}

@end
