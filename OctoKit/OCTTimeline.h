//
//  OCTTimeline.h
//  OctoKit
//
//  Created by Josh Vera on 9/22/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTPullRequest;

@interface OCTTimeline : OCTObject

@property (nonatomic, copy, readonly) NSArray *crossReferences;

@property (nonatomic, copy, readonly) NSArray *commitComments;

@property (nonatomic, copy, readonly) NSArray *issueComments;

@property (nonatomic, copy, readonly) NSArray *pullRequestComments;

@property (nonatomic, copy, readonly) NSArray *changedCommits;

@property (nonatomic, copy, readonly) NSArray *issueEvents;

@property (atomic, strong) OCTPullRequest *pullRequest;

@end
