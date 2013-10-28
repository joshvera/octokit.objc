//
//  OCTOwner.h
//  GitHub
//
//  Created by Josh Vera on 10/19/13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@class CSURITemplate;

// Represents a GitHub repository owner.
@interface OCTOwner : OCTObject

// The unique name for this owner, used in GitHub URLs.
@property (nonatomic, copy, readonly) NSString *login;

// The owner's avatar image URL.
@property (nonatomic, copy, readonly) NSURL *avatarURL;

// The owner's unique gravatar ID.
@property (nonatomic, copy, readonly) NSString *gravatarID;

// The owner's API URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The owner's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The owner's followers URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *followersURITemplate;

// The owner's followers URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *followingURITemplate;

// The owner's gists URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *gistsURITemplate;

// The owner's starred repos URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *starredURITemplate;

// The owner's subscriptions URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *subscriptionsURITemplate;

// The owner's organizations URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *organizationsURITemplate;

// The owner's repos URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *reposURITemplate;

// The owner's events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *eventsURITemplate;

// The owner's received events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *receivedEventsURITemplate;

// The owner's type.
@property (nonatomic, copy, readonly) NSString *type;

// Whether the owner is a site admin.
@property (nonatomic, assign, readonly, getter = isSiteAdmin) BOOL siteAdmin;

@end
