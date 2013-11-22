//
//  OCTForkedRepository.h
//  OctoKit
//
//  Created by Josh Vera on 11/22/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTRepository.h"

@interface OCTForkedRepository : OCTRepository

@property (nonatomic, copy, readonly) OCTRepository *parentRepository;

@property (nonatomic, copy, readonly) OCTRepository *sourceRepository;

@end
