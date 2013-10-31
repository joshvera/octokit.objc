//
//  OCTEventRepository.h
//  OctoKit
//
//  Created by Josh Vera on 10/31/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;

@interface OCTEventRepository : OCTObject

@property (atomic, copy, readonly) NSString *name;

// The entity's API URL.
@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

@end
