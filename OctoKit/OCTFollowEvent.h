//
//  OCTFollowEvent.h
//  OctoKit
//
//  Created by Josh Vera on 11/11/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTEvent.h"

@class OCTOwner;

@interface OCTFollowEvent : OCTEvent

@property (nonatomic, copy, readonly) OCTOwner *followee;

@end
