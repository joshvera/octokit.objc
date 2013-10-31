//
//  OCTOrganization.h
//  OctoKit
//
//  Created by Joe Ricioppo on 10/27/10.
//  Copyright 2010 GitHub. All rights reserved.
//

#import "OCTOwner.h"

// An organization.
@interface OCTOrganization : OCTOwner

// The OCTTeams in this organization.
//
// OCTClient endpoints do not actually set this property. It is provided as
// a convenience for persistence and model merging.
@property (atomic, copy) NSArray *teams;

@property (atomic, copy) NSArray *notifications;

@property (atomic, copy) NSArray *users;

@end
