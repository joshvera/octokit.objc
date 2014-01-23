//
//  OCTEntityInfo.h
//  OctoKit
//
//  Created by Josh Vera on 1/22/14.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OCTEntityInfo <NSObject>

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *company;

@property (nonatomic, copy, readonly) NSString *blog;

@property (nonatomic, copy, readonly) NSString *location;

@property (nonatomic, copy, readonly) NSString *email;

@property (nonatomic, assign, readonly) NSUInteger publicRepoCount;

@property (nonatomic, assign, readonly) NSUInteger publicGistCount;

@property (nonatomic, copy, readonly) NSDate *createdAtDate;

@property (nonatomic, copy, readonly) NSDate *updatedAtDate;


@end
