//
//  OCTUser.h
//  OctoKit
//
//  Created by Joe Ricioppo on 7/28/10.
//  Copyright 2010 GitHub. All rights reserved.
//

#import "OCTEntity.h"

// A GitHub user.
@interface OCTUser : OCTEntity

// Returns a user that has the given name and email address.
+ (instancetype)userWithName:(NSString *)name email:(NSString *)email;

// Returns a user with the given username and OCTServer instance.
+ (instancetype)userWithLogin:(NSString *)login server:(OCTServer *)server;

// The user's gravatar ID.
@property (nonatomic, copy, readonly) NSString *gravatarID;

// The user's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The user's followers URL.
@property (nonatomic, copy, readonly) NSURL *followersURL;

// The user's following URL.
@property (nonatomic, copy, readonly) NSURL *followingURL;

// The user's starred repos URL.
@property (nonatomic, copy, readonly) NSURL *starredURL;

// The user's subscriptions URL.
@property (nonatomic, copy, readonly) NSURL *subscriptionsURL;

// The user's organizations URL.
@property (nonatomic, copy, readonly) NSURL *organizationsURL;

// The user's repos URL.
@property (nonatomic, copy, readonly) NSURL *reposURL;

// The user's events URL.
@property (nonatomic, copy, readonly) NSURL *eventsURL;

// The user's received events URL.
@property (nonatomic, copy, readonly) NSURL *receivedEventsURL;

// The user's location
@property (nonatomic, copy, readonly) NSString *location;

// The user's public gists.
@property (nonatomic, assign, readonly) NSUInteger publicGistCount;

// The user's following.
@property (nonatomic, assign, readonly) NSUInteger followingCount;

// The user's followers.
@property (nonatomic, assign, readonly) NSUInteger followersCount;

// The user's created at date.
@property (nonatomic, copy, readonly) NSDate *createdAtDate;

// The user's updated at date.
@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@end
