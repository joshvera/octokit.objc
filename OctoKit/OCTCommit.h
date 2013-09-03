//
//  OCTCommit.h
//  OctoKit
//
//  Created by Josh Vera on 8/14/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTUser;

// A commit on a repository
@interface OCTCommit : OCTObject

// The commit's unique SHA.
@property (nonatomic, copy, readonly) NSString *commitSHA;

// The commit's message.
@property (nonatomic, copy, readonly) NSString *message;

// The date the commit was authored.
@property (nonatomic, copy, readonly) NSDate *authoredDate;

// The date the commit was committed.
@property (nonatomic, copy, readonly) NSDate *committedDate;

// The commit's API URL.
@property (nonatomic, copy, readonly) NSURL *APIURL;

// The commit's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The commit's avatar URL.
@property (nonatomic, copy, readonly) NSURL *avatarURL;

// The commit's comments URL.
@property (nonatomic, copy, readonly) NSURL *commentsURL;

// The commit's author.
@property (nonatomic, copy, readonly) OCTUser *author;

// The commit's committer.
@property (nonatomic, copy, readonly) OCTUser *committer;

// The commit's total line count.
@property (nonatomic, assign, readonly) NSUInteger total;

// The commit's number of lines added.
@property (nonatomic, assign, readonly) NSUInteger additions;

// The commit's number of lines deleted.
@property (nonatomic, assign, readonly) NSUInteger deletions;

// An array of OCTFiles.
@property (nonatomic, copy, readonly) NSArray *files;

@end
