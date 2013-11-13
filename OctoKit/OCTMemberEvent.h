//
//  OCTMemberEvent.h
//  OctoKit
//
//  Created by Josh Vera on 11/11/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTEvent.h"

typedef NS_ENUM(NSUInteger, OCTMemberEventType) {
	OCTMemberEventTypeAdd
};

@interface OCTMemberEvent : OCTEvent

@property (nonatomic, copy, readonly) OCTEventOwner *eventMember;

@property (nonatomic, assign, readonly) OCTMemberEventType action;

@end
