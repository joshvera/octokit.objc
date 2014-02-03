//
//  OCTCommit.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2013-11-22.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTUserEntity;
@class CSURITemplate;

// A git commit.
@interface OCTCommit : OCTObject

// The SHA for this commit.
@property (nonatomic, copy, readonly) NSString *SHA;

// The API URL to the tree that this commit points to.
@property (nonatomic, copy, readonly) NSURL *treeURL;

// The SHA of the tree that this commit points to.
@property (nonatomic, copy, readonly) NSString *treeSHA;

// The commit's unique SHA.
@property (nonatomic, copy, readonly) NSString *commitSHA;

// The commit's message.
@property (nonatomic, copy, readonly) NSString *message;

// The date the commit was authored.
@property (nonatomic, copy, readonly) NSDate *authoredDate;

// The date the commit was committed.
@property (nonatomic, copy, readonly) NSDate *committedDate;

// The commit's API URL.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The commit's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The commit's comments URL.
@property (nonatomic, copy, readonly) CSURITemplate *commentsURITemplate;

// The author's name. May differ from author's name if
// `author` is nil.
@property (nonatomic, copy, readonly) NSString *authorName;

// The committer's name. May differ from committer's name
// if `committer` is nil.
@property (nonatomic, copy, readonly) NSString *committerName;

// The commit's author. May be nil.
@property (nonatomic, copy, readonly) OCTUserEntity *author;

// The commit's committer. May be nil.
@property (nonatomic, copy, readonly) OCTUserEntity *committer;

// The commit's total line count.
@property (nonatomic, assign, readonly) NSUInteger total;

// The commit's number of lines added.
@property (nonatomic, assign, readonly) NSUInteger additions;

// The commit's number of lines deleted.
@property (nonatomic, assign, readonly) NSUInteger deletions;

// An array of OCTFiles.
@property (nonatomic, copy, readonly) NSArray *files;

@property (atomic, strong) NSArray *pullRequests;

@end
