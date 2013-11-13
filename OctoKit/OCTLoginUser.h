//
//  OCTLoginUser.h
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import <Mantle/Mantle.h>

@class OCTServer;

@interface OCTLoginUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *email;

@property (nonatomic, copy, readonly) NSString *login;

@property (nonatomic, copy, readonly) NSString *baseURL;

// The server this object is associated with.
//
// This object is not encoded into JSON.
@property (nonatomic, strong, readonly) OCTServer *server;


// Returns a user that has the given name and email address.
+ (instancetype)userWithName:(NSString *)name email:(NSString *)email;

// Returns a user with the given username and OCTServer instance.
+ (instancetype)userWithLogin:(NSString *)login server:(OCTServer *)server;

@end
