//
//  OCTPrivateUserInfo.h
//  OctoKit
//
//  Created by Josh Vera on 1/6/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

@class OCTPlan;

@protocol OCTPrivateUserInfo <OCTUserInfo>

@property (nonatomic, assign, readonly) NSUInteger totalPrivateRepoCount;

@property (nonatomic, assign, readonly) NSUInteger ownedPrivateRepoCount;

@property (nonatomic, assign, readonly) NSUInteger diskUsage;

@property (nonatomic, assign, readonly) NSUInteger collaboratorCount;

@property (nonatomic, copy, readonly) OCTPlan *plan;

@property (nonatomic, assign, readonly) NSUInteger privateGistCount;

@end
