//
//  OCTUserOrganization.h
//  OctoKit
//
//  Created by Josh Vera on 10/21/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import <OctoKit/OctoKit.h>

@class CSURITemplate;

@interface OCTUserOrganization : OCTObject

// The unique name for this organization, used in GitHub URLs.
@property (atomic, copy, readonly) NSString *login;

// The URL for an avatar image.
@property (atomic, copy, readonly) NSURL *avatarURL;

// The organization's API URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The organization's repos URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *reposURITemplate;

// The organization's events URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *eventsURITemplate;

// The organization's members URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *membersURITemplate;

// The organization's public members URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *publicMembersURITemplate;

@end
