//
//  OCTPullRequest.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;
@class OCTUser;
@class OCTMilestone;

// The state of the pull request. open or closed.
//
// OCTPullRequestStateOpen   - The pull request is open.
// OCTPullRequestStateClosed - The pull request is closed.
typedef enum : NSUInteger {
    OCTPullRequestStateOpen,
    OCTPullRequestStateClosed
} OCTPullRequestState;

// A pull request on a repository.
@interface OCTPullRequest : OCTObject

// The webpage URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The diff URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *diffURL;

// The patch URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *patchURL;

// The issue URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *issueURL;

// The title of this pull request.
@property (nonatomic, copy, readonly) NSString *title;

// The body text for this pull request.
@property (nonatomic, copy, readonly) NSString *body;

// The pull request number in its repository.
@property (nonatomic, assign, readonly) NSUInteger remoteID;

@property (nonatomic, copy, readonly) NSString *HTMLBody;

@property (nonatomic, copy, readonly) NSString *assignee;

@property (nonatomic, copy, readonly) OCTMilestone *milestone;

@property (nonatomic, assign, readonly) NSUInteger additions;

@property (nonatomic, assign, readonly) NSUInteger deletions;

@property (nonatomic, copy, readonly) NSDate *createdAtDate;

@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@property (nonatomic, copy, readonly) OCTUser *user;

// The state of this pull request.
@property (nonatomic, readonly) OCTPullRequestState state;

@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@property (nonatomic, copy, readonly) CSURITemplate *commentsURITemplate;

@property (nonatomic, copy, readonly) CSURITemplate *reviewCommentsURITemplate;

@end
