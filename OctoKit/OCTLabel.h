//
//  OCTLabel.h
//  OctoKit
//
//  Created by Josh Vera on 11/26/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class CSURITemplate;

@interface OCTLabel : OCTObject <MTLJSONSerializing>

@property (nonatomic, strong, readonly) CSURITemplate *APIURITemplate;

@property (nonatomic, strong, readonly) NSString *hexColor;

@property (nonatomic, strong, readonly) NSString *name;

@end
