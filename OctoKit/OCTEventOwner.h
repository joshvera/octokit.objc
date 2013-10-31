//
//  OCTEventOwner.h
//  OctoKit
//
//  Created by Josh Vera on 10/31/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;

@interface OCTEventOwner : OCTObject

// The unique name for this organization, used in GitHub URLs.
@property (nonatomic, copy, readonly) NSString *login;

// The entity's unique gravatar ID.
@property (atomic, copy, readonly) NSString *gravatarID;

// The URL for an avatar image.
@property (nonatomic, copy, readonly) NSURL *avatarURL;

// The organization's API URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@end
