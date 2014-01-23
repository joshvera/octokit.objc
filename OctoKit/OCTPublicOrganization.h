//
//  OCTPublicOrganization.h
//  OctoKit
//
//  Created by Josh Vera on 10/21/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTSimpleOrganization.h"
#import "OCTFollowableEntityInfo.h"

// A public user representation of an organization
@interface OCTPublicOrganization : OCTSimpleOrganization <OCTFollowableEntityInfo>

// The owner's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The owner's type.
@property (nonatomic, copy, readonly) NSString *type;


@end
