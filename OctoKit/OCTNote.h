//
//  OCTNote.h
//  OctoKit
//
//  Created by Josh Vera on 6/20/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTUser;

@interface OCTNote : OCTObject

// The body of the note.
@property (nonatomic, strong, readonly) NSString *body;

@property (nonatomic, strong, readonly) NSURL *noteURL;

@property (nonatomic, strong, readonly) NSDate *createdAtDate;

@property (nonatomic, strong, readonly) NSDate *updatedAtDate;

@property (nonatomic, strong, readonly) OCTUser *user;

@end
