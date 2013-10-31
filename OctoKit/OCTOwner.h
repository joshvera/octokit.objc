//
//  OCTOwner.h
//  GitHub
//
//  Created by Josh Vera on 10/19/13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "OCTEntity.h"

@class CSURITemplate;

// Represents a GitHub repository owner.
@interface OCTOwner : OCTEntity

// The unique name for this owner, used in GitHub URLs.
@property (nonatomic, copy, readonly) NSString *login;

// The email address for this account.
@property (atomic, copy, readonly) NSString *email;

// The URL for any avatar image.
@property (atomic, copy, readonly) NSURL *avatarURL;

// The entity's unique gravatar ID.
@property (atomic, copy, readonly) NSString *gravatarID;

// A reference to a blog associated with this account.
@property (atomic, copy, readonly) NSString *blog;

// The name of a company associated with this account.
@property (atomic, copy, readonly) NSString *company;

// The total number of collaborators that this account has on their private repositories.
@property (atomic, assign, readonly) NSUInteger collaborators;

// The number of public repositories owned by this account.
@property (atomic, assign, readonly) NSUInteger publicRepoCount;

// The number of private repositories owned by this account.
@property (atomic, assign, readonly) NSUInteger privateRepoCount;

// The number of kilobytes occupied by this account's repositories on disk.
@property (atomic, assign, readonly) NSUInteger diskUsage;

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

// The plan that this account is on.
@property (atomic, strong, readonly) OCTPlan *plan;

@end
