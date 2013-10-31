//
//  OCTTeam.h
//  OctoKit
//
//  Created by Josh Abernathy on 3/28/12.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCTEntity.h"

// Represents a team within an OCTOrganization.
@interface OCTTeam : OCTEntity

@property (nonatomic, copy, readonly) NSString *slug;

@property (nonatomic, copy, readonly) NSString *permission;

@property (nonatomic, copy, readonly) CSURITemplate *membersURITemplate;

@end
