//
//  OCTCommit.h
//  OctoKit
//
//  Created by Josh Vera on 8/14/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

// A commit on a repository
@interface OCTCommit : OCTObject

// The commits unique SHA.
@property (nonatomic, copy, readonly) NSString *SHA;

// The commit's message.
@property (nonatomic, copy, readonly) NSString *message;

// The author's date.
@property (nonatomic, copy, readonly) NSDate *authorDate;

// The date the commit was last updated, usually the commiter date.
@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

// The author's name.
@property (nonatomic, copy, readonly) NSString *authorName;

// The author's avatar url.
@property (nonatomic, copy, readonly) NSURL *avatarURL;

@end
