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

// The full name of this entity.
@property (atomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *type;

// The entity's API URL.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The entity's repos URITemplate.
@property (nonatomic, copy, readonly) CSURITemplate *reposURITemplate;

// The OCTRepository objects associated with this entity.
//
// OCTClient endpoints do not actually set this property. It is provided as
// a convenience for persistence and model merging.
@property (atomic, copy) NSArray *repositories;

// Updates the receiver's repositories with data from the set of remote
// repositories.
- (void)mergeRepositoriesWithRemoteCounterparts:(NSArray *)remoteRepositories;

+ (NSDictionary *)entityClassesByType;

@end
