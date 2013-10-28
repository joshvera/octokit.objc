//
//  OCTEntity.h
//  OctoKit
//
//  Created by Josh Abernathy on 1/21/11.
//  Copyright 2011 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTPlan;
@class CSURITemplate;

// Represents any GitHub object which is capable of owning repositories.
@interface OCTEntity : OCTObject

// The unique name for this entity, used in GitHub URLs.
@property (atomic, copy, readonly) NSString *login;

// The full name of this entity.
//
// Returns `login` if no name is explicitly set.
@property (atomic, copy, readonly) NSString *name;

// The OCTRepository objects associated with this entity.
//
// OCTClient endpoints do not actually set this property. It is provided as
// a convenience for persistence and model merging.
@property (atomic, copy) NSArray *repositories;

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

@property (nonatomic, copy, readonly) NSString *type;

// The plan that this account is on.
@property (atomic, strong, readonly) OCTPlan *plan;

// The entity's API URL.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The entity's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The entity's followers URL.
@property (nonatomic, copy, readonly) CSURITemplate *followersURITemplate;

// The entity's following URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *followingURITemplate;

// The entity's starred repos URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *starredURITemplate;

// The entity's gists URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *gistsURITemplate;

// The entity's subscriptions URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *subscriptionsURITemplate;

// The entity's organizations URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *organizationsURITemplate;

// The entity's repos URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *reposURITemplate;

// The entity's events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *eventsURITemplate;

// The entity's received events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *receivedEventsURITemplate;

// Updates the receiver's repositories with data from the set of remote
// repositories.
- (void)mergeRepositoriesWithRemoteCounterparts:(NSArray *)remoteRepositories;

@property (atomic, strong) NSArray *ownedRepositories;

+ (NSDictionary *)entityClassesByType;

@end
