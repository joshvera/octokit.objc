//
//  OCTPullRequestComment.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;
@class OCTUser;
@class OCTPullRequest;

// A single comment on a pull request.
@interface OCTPullRequestComment : OCTObject

@property (atomic, strong) OCTPullRequest *pullRequest;

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

// The API URL for the pull request upon which this comment appears.
@property (nonatomic, copy, readonly) CSURITemplate *pullRequestURITemplate;

@property (nonatomic, copy, readonly) OCTUser *user;

@property (nonatomic, copy, readonly) NSString *diffHunk;

@property (nonatomic, assign, readonly) NSNumber *position;

@property (nonatomic, assign, readonly) NSNumber *originalPosition;

@property (nonatomic, copy, readonly) NSString *path;

@property (nonatomic, copy, readonly) NSString *commitSHA;

@property (nonatomic, copy, readonly) NSString *originalCommitSHA;

@end
