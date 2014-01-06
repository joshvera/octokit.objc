//
//  OCTEventCommit.h
//  GitHub
//
//  Created by Josh Vera on 11/8/13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;


@interface OCTEventCommit : OCTObject
// The commit's unique SHA.
@property (nonatomic, copy, readonly) NSString *commitSHA;

// The commit's message.
@property (nonatomic, copy, readonly) NSString *message;

// The commit's API URL.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@property (nonatomic, copy, readonly) NSString *authorName;

@property (nonatomic, copy, readonly) NSString *authorEmail;

@property (nonatomic, assign, readonly, getter = isDistinct) BOOL distinct;

@end
