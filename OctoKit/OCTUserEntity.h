//
//  OCTUserEntity.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTEntity.h"

@interface OCTUserEntity : OCTEntity

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *company;

@property (nonatomic, copy, readonly) NSString *blog;

@property (nonatomic, copy, readonly) NSString *location;

@property (nonatomic, copy, readonly) NSString *email;

@property (nonatomic, assign, readonly, getter = isHireable) BOOL hireable;

@property (nonatomic, copy, readonly) NSString *bio;

@property (nonatomic, assign, readonly) NSUInteger publicRepoCount;

@property (nonatomic, assign, readonly) NSUInteger followerCount;

@property (nonatomic, assign, readonly) NSUInteger followingCount;

@property (nonatomic, copy, readonly) NSDate *createdAtDate;

@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@property (nonatomic, assign, readonly) NSUInteger publicGistCount;

@end
