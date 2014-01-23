//
//  OCTSimpleOrganization.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;

// The simplest representation of an organization returned by the API.
@interface OCTSimpleOrganization : OCTObject

// The unique name for this owner, used in GitHub URLs.
@property (nonatomic, copy, readonly) NSString *login;

// The URL for any avatar image.
@property (nonatomic, copy, readonly) NSURL *avatarURL;

// The entity's unique API URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The owner's repos URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *reposURITemplate;

// The owner's events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *eventsURITemplate;

// The owner's events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *membersURITemplate;

// The owner's received events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *publicMembersURITemplate;

@end
