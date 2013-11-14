//
//  OCTCrossReference.h
//  OctoKit
//
//  Created by Josh Vera on 9/20/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTUserEntity;
@class CSURITemplate;

@interface OCTCrossReference : OCTObject

@property (nonatomic, copy, readonly) NSString *sourceTitle;

@property (nonatomic, copy, readonly) NSString *sourceType;

@property (nonatomic, copy, readonly) NSNumber *sourceNumber;

@property (nonatomic, copy, readonly) NSNumber *sourceID;

@property (nonatomic, copy, readonly) CSURITemplate *sourceURITemplate;

@property (nonatomic, copy, readonly) NSString *targetTitle;

@property (nonatomic, copy, readonly) NSString *targetType;

@property (nonatomic, copy, readonly) NSString *targetNumber;

@property (nonatomic, copy, readonly) NSString *targetID;

@property (nonatomic, copy, readonly) CSURITemplate *targetURITemplate;

@property (nonatomic, copy, readonly) OCTUserEntity *user;

@end
