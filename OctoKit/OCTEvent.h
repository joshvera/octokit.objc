//
//  OCTEvent.h
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2012-10-01.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTEventOwner;
@class OCTEventRepository;

// A class cluster for GitHub events.
@interface OCTEvent : OCTObject

// The name of the repository upon which the event occurred (e.g., `github/Mac`).
@property (nonatomic, copy, readonly) NSString *repositoryName;

// The login of the user who instigated the event.
@property (nonatomic, copy, readonly) NSString *actorLogin;

// The organization related to the event.
@property (nonatomic, copy, readonly) NSString *organizationLogin;

// The date that this event occurred.
@property (nonatomic, copy, readonly) NSDate *date;

@property (nonatomic, copy, readonly) OCTEventOwner *actor;

@property (nonatomic, copy, readonly) OCTEventOwner *organization;

@property (nonatomic, copy, readonly) OCTEventRepository *repository;

// The event type of the receiver.
@property (nonatomic, copy, readonly) NSString *type;

@property (nonatomic, assign, readonly, getter = isPublic) BOOL public;

@end
