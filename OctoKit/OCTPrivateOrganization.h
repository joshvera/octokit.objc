//
//  OCTPrivateOrganization.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTSimpleOrganization.h"
#import "OCTFollowableEntityInfo.h"
#import "OCTPrivateEntityInfo.h"

@class OCTPlan;

@interface OCTPrivateOrganization : OCTSimpleOrganization <OCTPrivateEntityInfo, OCTFollowableEntityInfo>

// The owner's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The private organization's type.
@property (nonatomic, copy, readonly) NSString *type;

@end
