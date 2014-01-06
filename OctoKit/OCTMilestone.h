//
//  OCTMilestone.h
//  OctoKit
//
//  Created by Josh Vera on 9/4/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTUserEntity;
@class CSURITemplate;

// The state of the milestone. open or closed.
//
// OCTMilestoneStateOpen   - The pull request is open.
// OCTMilestneStateClosed - The pull request is closed.
typedef enum : NSUInteger {
    OCTMilestoneStateOpen,
    OCTMilestoneStateClosed
} OCTMilestoneState;

@interface OCTMilestone : OCTObject

@property (nonatomic, assign, readonly) NSUInteger remoteID;

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSString *milestoneDescription;

@property (nonatomic, copy, readonly) OCTUserEntity *creator;

@property (nonatomic, assign, readonly) NSUInteger openIssuesCount;

@property (nonatomic, assign, readonly) NSUInteger closedIssuesCount;

@property (nonatomic, assign, readonly) OCTMilestoneState state;

@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@property (nonatomic, copy, readonly) NSDate *createdAtDate;

@property (nonatomic, copy, readonly) NSDate *dueDate;

@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@property (nonatomic, copy, readonly) CSURITemplate *labelsURITemplate;

@end
