//
//  OCTIssueComment.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-02.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"
#import "OCTComment.h"

@class CSURITemplate;
@class OCTUserEntity;
@class OCTPullRequest;
@class OCTIssue;

// A single comment on an issue.
@interface OCTIssueComment : OCTObject<OCTComment>

// The comment's issue URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *issueURITemplate;

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

@property (nonatomic, copy, readonly) OCTUserEntity *user;

@end
