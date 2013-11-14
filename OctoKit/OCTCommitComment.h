//
//  OCTCommitComment.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTCommit;
@class OCTUserEntity;
@class CSURITemplate;

// A single comment on a commit.
@interface OCTCommitComment : OCTObject

// The SHA of the commit being commented upon.
@property (nonatomic, copy, readonly) NSString *commitSHA;

// The path of the file being commented on.
@property (nonatomic, copy, readonly) NSString *path;

// The line index in the commit's diff. This will be nil if the comment refers
// to the entire commit.
@property (nonatomic, copy, readonly) NSNumber *position;

@property (nonatomic, copy, readonly) NSNumber *line;

// The body of the comment.
@property (nonatomic, copy, readonly) NSString *body;

// The html body of the comment.
@property (nonatomic, copy, readonly) NSString *HTMLBody;

// The comment's webpage URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The comment's API URL.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The comment's created at date.
@property (nonatomic, copy, readonly) NSDate *createdAtDate;

// The comment's updated at date.
@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

// The login of the user who created this comment.
@property (nonatomic, copy, readonly) NSString *commenterLogin;

@property (atomic, strong) OCTCommit *commit;

@property (nonatomic, copy, readonly) OCTUserEntity *user;

@end
