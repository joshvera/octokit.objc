//
//  OCTSubmoduleContent.h
//  OctoKit
//
//  Created by Aron Cedercrantz on 14-07-2013.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTContent.h"

@class CSURITemplate;

// A submodule in a git repository.
@interface OCTSubmoduleContent : OCTContent

// The git URL of the submodule.
@property (nonatomic, copy, readonly) NSString *submoduleGitURL;

@property (nonatomic, copy, readonly) NSURL *submoduleTreeURL;

@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@end
