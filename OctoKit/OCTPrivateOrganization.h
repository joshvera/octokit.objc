//
//  OCTPrivateOrganization.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTOrganization.h"

@class OCTPlan;

@interface OCTPrivateOrganization : OCTOrganization

@property (nonatomic, assign, readonly) NSUInteger privateRepoCount;

@property (nonatomic, assign, readonly) NSUInteger ownedPrivateRepoCount;

@property (nonatomic, assign, readonly) NSUInteger diskUsage;

@property (nonatomic, assign, readonly) NSUInteger collaboratorCount;

@property (nonatomic, copy, readonly) OCTPlan *plan;

@property (nonatomic, assign, readonly) NSUInteger privateGistCount;

@end
