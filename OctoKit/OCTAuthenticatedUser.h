//
//  OCTAuthenticatedUser.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTUser.h"

@class OCTPlan;

@interface OCTAuthenticatedUser : OCTUser

@property (nonatomic, assign, readonly) NSUInteger totalPrivateRepoCount;

@property (nonatomic, assign, readonly) NSUInteger ownedPrivateRepoCount;

@property (nonatomic, assign, readonly) NSUInteger diskUsage;

@property (nonatomic, assign, readonly) NSUInteger collaboratorCount;

@property (nonatomic, copy, readonly) OCTPlan *plan;

@property (nonatomic, assign, readonly) NSUInteger privateGistCount;

@end
