//
//  OCTPullRequestComment.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"
#import "OCTIssueComment.h"
#import "OCTReviewComment.h"

@class CSURITemplate;
@class OCTUserEntity;
@class OCTPullRequest;

// A single comment on a pull request.
@interface OCTPullRequestComment : OCTIssueComment <OCTReviewComment>

@property (atomic, strong) OCTPullRequest *pullRequest;

// The body of the comment.
@property (nonatomic, copy, readonly) NSString *body;

// The html body of the comment.
@property (nonatomic, copy, readonly) NSString *HTMLBody;

// The comment's webpage URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The comment's API URL.
@property (nonatomic, copy, readonly) NSURL *pullRequestAPIURL;

// The comment's API URI template.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The comment's created at date.
@property (nonatomic, copy, readonly) NSDate *createdAtDate;

// The comment's updated at date.
@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

// The HEAD SHA of the pull request when the comment was originally made.
@property (nonatomic, copy, readonly) NSString *originalCommitSHA;

// This is the line index into the pull request's diff when the
// comment was originally made.
@property (nonatomic, copy, readonly) NSNumber *originalPosition;

// The hunk in the diff that this comment originally refered to.
@property (nonatomic, copy, readonly) NSString *diffHunk;

// The API URL for the pull request upon which this comment appears.
@property (nonatomic, copy, readonly) CSURITemplate *pullRequestURITemplate;

@property (nonatomic, copy, readonly) OCTUserEntity *user;

@property (nonatomic, copy, readonly) NSNumber *position;

@property (nonatomic, copy, readonly) NSString *path;

@property (nonatomic, copy, readonly) NSString *commitSHA;

@end
