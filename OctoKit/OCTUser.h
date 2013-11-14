//
//  OCTUser.h
//  OctoKit
//
//  Created by Joe Ricioppo on 7/28/10.
//  Copyright 2010 GitHub. All rights reserved.
//

#import "OCTUserEntity.h"
#import "OCTUserInfo.h"

// A public GitHub user.
@interface OCTUser : OCTUserEntity <OCTUserInfo>

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
