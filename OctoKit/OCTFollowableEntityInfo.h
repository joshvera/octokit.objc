//
//  OCTFollowableEntityInfo.h
//  OctoKit
//
//  Created by Josh Vera on 1/22/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import "OCTEntityInfo.h"

@protocol OCTFollowableEntityInfo <OCTEntityInfo>

@property (nonatomic, assign, readonly) NSUInteger followerCount;

@property (nonatomic, assign, readonly) NSUInteger followingCount;

@end