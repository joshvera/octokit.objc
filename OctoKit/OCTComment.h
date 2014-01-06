//
//  OCTComment.h
//  OctoKit
//
//  Created by Jackson Harper on 9/23/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

// A comment can be added to an issue, pull request, or commit.
@protocol OCTComment <NSObject>

// The login of the user who created this comment.
@property (nonatomic, copy, readonly) NSString *commenterLogin;

// The date at which the comment was originally created.
@property (nonatomic, copy, readonly) NSDate *creationDate;

// The date the comment was last updated. This will be equal to
// creationDate if the comment has not been updated.
@property (nonatomic, copy, readonly) NSDate *updatedDate;

@end

@class OCTUser;

@interface OCTComment : OCTObject

// The body of the comment.
@property (nonatomic, copy, readonly) NSString *body;

// The html body of the comment.
@property (nonatomic, copy, readonly) NSString *HTMLBody;

// The comment's webpage URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The comment's API URL.
@property (nonatomic, copy, readonly) NSURL *APIURL;

// The comment's created at date.
@property (nonatomic, copy, readonly) NSDate *createdAtDate;

// The comment's updated at date.
@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

// The login of the user who created this comment.
@property (nonatomic, copy, readonly) NSString *commenterLogin;

@end
