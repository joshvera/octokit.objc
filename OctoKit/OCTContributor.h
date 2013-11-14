//
//  OCTContributor.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTUserEntity.h"

@interface OCTContributor : OCTUserEntity

@property (nonatomic, assign, readonly) NSUInteger contributionCount;

@end
