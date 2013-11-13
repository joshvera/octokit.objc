//
//  OCTOrganization.h
//  OctoKit
//
//  Created by Joe Ricioppo on 10/27/10.
//  Copyright 2010 GitHub. All rights reserved.
//

#import "OCTSimpleOrganization.h"

@class CSURITemplate;

// An organization.
@interface OCTOrganization : OCTSimpleOrganization

// The owner's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The owner's received events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *receivedEventsURITemplate;

// The owner's type.
@property (nonatomic, copy, readonly) NSString *type;

// Whether the owner is a site admin.
@property (nonatomic, assign, readonly, getter = isSiteAdmin) BOOL siteAdmin;

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *company;

@property (nonatomic, copy, readonly) NSString *blog;

@property (nonatomic, copy, readonly) NSString *location;

@property (nonatomic, copy, readonly) NSString *email;

@property (nonatomic, assign, readonly) NSUInteger publicRepoCount;

@property (nonatomic, assign, readonly) NSUInteger publicGistCount;

@property (nonatomic, copy, readonly) NSDate *createdAtDate;

@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@end
