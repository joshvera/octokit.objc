//
//  OCTIssue.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTPullRequest;
@class CSURITemplate;
@class OCTUser;

// The state of the issue. open or closed.
//
// OCTIssueStateOpen   - The pull request is open.
// OCTIssueStateClosed - The pull request is closed.
typedef enum : NSUInteger {
    OCTIssueStateOpen,
    OCTIssueStateClosed
} OCTIssueState;

// An issue on a repository.
@interface OCTIssue : OCTObject

@property (nonatomic, assign, readonly) NSUInteger remoteID;

@property (nonatomic, copy, readonly) NSDate *createdAtDate;

@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@property (nonatomic, copy, readonly) NSString *body;

@property (nonatomic, copy, readonly) NSString *HTMLBody;

@property (nonatomic, copy, readonly) OCTUser *assignee;

@property (nonatomic, copy, readonly) NSString *milestone;

@property (nonatomic, assign, readonly) OCTIssueState state;

@property (nonatomic, copy, readonly) OCTUser *user;

// The webpage URL for this issue.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The title of this issue.
@property (nonatomic, copy, readonly) NSString *title;

// The pull request that is attached to (i.e., the same as) this issue, or nil
// if this issue does not have code attached.
@property (nonatomic, copy, readonly) OCTPullRequest *pullRequest;

@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@property (nonatomic, copy, readonly) CSURITemplate *commentsURITemplate;

@end
