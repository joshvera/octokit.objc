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

@property (nonatomic, assign, readonly) NSUInteger totalPrivateReposCount;

@property (nonatomic, assign, readonly) NSUInteger ownedPrivateReposCount;

@property (nonatomic, assign, readonly) NSUInteger diskUsage;

@property (nonatomic, assign, readonly) NSUInteger collaboratorsCount;

@property (nonatomic, copy, readonly) OCTPlan *plan;

@property (nonatomic, assign, readonly) NSUInteger privateGistsCount;

@end
