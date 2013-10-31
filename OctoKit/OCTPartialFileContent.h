//
//  OCTPartialFileContent.h
//  OctoKit
//
//  Created by Josh Vera on 10/30/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTContent.h"

// A partial representation of file in a git repository.
@interface OCTPartialFileContent : OCTContent

// The encoding of the file content.
@property (nonatomic, copy, readonly) NSString *encoding;

@end
