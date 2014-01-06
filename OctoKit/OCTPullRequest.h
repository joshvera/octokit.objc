//
//  OCTPullRequest.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;
@class OCTEntity;
@class OCTUserEntity;
@class OCTMilestone;
@class OCTRepository;

// The state of the pull request. open or closed.
//
// OCTPullRequestStateOpen   - The pull request is open.
// OCTPullRequestStateClosed - The pull request is closed.
typedef enum : NSUInteger {
    OCTPullRequestStateOpen,
    OCTPullRequestStateClosed
} OCTPullRequestState;

@class CSURITemplate;

// A pull request on a repository.
@interface OCTPullRequest : OCTObject

// The api URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *URL;

// The webpage URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The issue URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *issueURL;

// The diff URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *diffURL;

// The patch URL for this pull request.
@property (nonatomic, copy, readonly) NSURL *patchURL;

// The issue URL for this pull request.
@property (nonatomic, copy, readonly) CSURITemplate *issueURITemplate;

// The user that opened this pull request.
@property (nonatomic, copy, readonly) OCTUserEntity *user;

// The title of this pull request.
@property (nonatomic, copy, readonly) NSString *title;

// The body text for this pull request.
@property (nonatomic, copy, readonly) NSString *body;

// The date/time this pull request was created.
@property (nonatomic, copy, readonly) NSDate *creationDate;

// The date/time this pull request was last updated.
@property (nonatomic, copy, readonly) NSDate *updatedDate;

// The date/time this pull request was closed. nil if the
// pull request has not been closed.
@property (nonatomic, copy, readonly) NSDate *closedDate;

// The date/time this pull request was merged. nil if the
// pull request has not been merged.
@property (nonatomic, copy, readonly) NSDate *mergedDate;

// The pull request number in its repository.
@property (nonatomic, assign, readonly) NSUInteger remoteID;

@property (nonatomic, copy, readonly) NSString *HTMLBody;

// The user this pull request is assigned to.
@property (nonatomic, copy, readonly) OCTUserEntity *assignee;

@property (nonatomic, copy, readonly) OCTMilestone *milestone;

@property (nonatomic, assign, readonly) NSUInteger additions;

@property (nonatomic, assign, readonly) NSUInteger deletions;

@property (nonatomic, copy, readonly) NSDate *createdAtDate;

@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@property (nonatomic, copy, readonly) NSDate *closedAtDate;

@property (nonatomic, copy, readonly) NSDate *mergedAtDate;

@property (nonatomic, copy, readonly) NSNumber *mergeable;

@property (nonatomic, assign, readonly, getter = isMerged) BOOL merged;

@property (nonatomic, strong, readonly) OCTUserEntity *merger;

@property (nonatomic, assign, readonly) NSUInteger commentCount;

@property (nonatomic, assign, readonly) NSUInteger reviewCommentCount;

@property (nonatomic, assign, readonly) NSUInteger commitCount;

@property (nonatomic, assign, readonly) NSUInteger changedFilesCount;

@property (nonatomic, copy, readonly) NSString *baseSHA;

@property (nonatomic, copy, readonly) NSString *baseRefName;

@property (nonatomic, copy, readonly) OCTEntity *baseUser;

@property (nonatomic, copy, readonly) NSString *baseLabel;

@property (nonatomic, copy, readonly) NSString *headRefName;

@property (nonatomic, copy, readonly) NSString *headSHA;

@property (nonatomic, copy, readonly) OCTEntity *headUser;

@property (nonatomic, copy, readonly) NSString *headLabel;

// The state of this pull request.
@property (nonatomic, readonly) OCTPullRequestState state;

// The repository that contains the pull request's changes.
@property (nonatomic, copy, readonly) OCTRepository *headRepository;

// The repository that the pull request's changes should be pulled into.
@property (nonatomic, copy, readonly) OCTRepository *baseRepository;

@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@property (nonatomic, copy, readonly) CSURITemplate *commentsURITemplate;

@property (nonatomic, copy, readonly) CSURITemplate *reviewCommentsURITemplate;

@property (atomic, strong) NSArray *commits;

@property (nonatomic, copy, readonly) CSURITemplate *commitsURITemplate;

@end
