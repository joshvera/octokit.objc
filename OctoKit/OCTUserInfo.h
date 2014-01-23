//
//  OCTFollowableEntityInfo.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTFollowableEntityInfo.h"


@protocol OCTUserInfo <OCTFollowableEntityInfo>

@property (nonatomic, copy, readonly) NSString *bio;

@property (nonatomic, assign, readonly) NSNumber *hireable;


@end