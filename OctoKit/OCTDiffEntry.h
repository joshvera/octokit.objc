//
//  OCTDiffEntry.h
//  OctoKit
//
//  Created by Josh Vera on 8/30/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;

@interface OCTDiffEntry : OCTObject

// The diff entry's unique SHA.
@property (nonatomic, copy, readonly) NSString *blobSHA;

// The diff entry's filename.
@property (nonatomic, copy, readonly) NSString *filename;

// The diff entry's status.
@property (nonatomic, copy, readonly) NSString *status;

// The number of lines added for this commit.
@property (nonatomic, assign, readonly) NSUInteger additions;

// The number of lines deleted for this commit.
@property (nonatomic, assign, readonly) NSUInteger deletions;

// The number of lines changed for this commit.
@property (nonatomic, assign, readonly) NSUInteger changes;

// The diff entry's blob URL.
@property (nonatomic, copy, readonly) NSURL *blobURL;

// The diff entry's contents URL.
@property (nonatomic, copy, readonly) NSURL *rawURL;

// The diff entry's contents URL.
@property (nonatomic, copy, readonly) CSURITemplate *contentsURITemplate;

@property (nonatomic, copy, readonly) NSURL *contentsURL;

// The diff entry's patch.
@property (nonatomic, copy, readonly) NSString *patch;

@end

