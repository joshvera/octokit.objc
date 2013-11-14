//
//  OCTLoginUser.m
//  OctoKit
//
//  Created by Josh Vera on 11/13/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTLoginUser.h"
#import <ReactiveCocoa/EXTKeyPathCoding.h>
#import "OCTObject+Private.h"
#import "OCTServer.h"

@implementation OCTLoginUser

#pragma mark MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			@"name": @"name",
			@"email": @"email",
			@"login": @"login",
			@"baseURL": @"baseURL",
		};
}


#pragma mark Lifecycle

+ (instancetype)userWithName:(NSString *)name email:(NSString *)email {
	NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
	if (name != nil) userDict[@keypath(OCTLoginUser.new, name)] = name;
	if (email != nil) userDict[@keypath(OCTLoginUser.new, email)] = email;

	return [self modelWithDictionary:userDict error:NULL];
}

+ (instancetype)userWithLogin:(NSString *)login server:(OCTServer *)server {
	NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
	if (login != nil) userDict[@keypath(OCTLoginUser.new, login)] = login;
	if (server.baseURL != nil) userDict[@keypath(OCTLoginUser.new, baseURL)] = server.baseURL;

	return [self modelWithDictionary:userDict error:NULL];
}

#pragma mark MTLModel

- (void)mergeLoginFromModel:(MTLModel *)model {
	// Don't ever replace the login property, as this could be different
	// to the login property returned by the API (eg. LDAP logins
	// have any characters in [a-z0-9-] replaced with '-' for their GitHub
	// Enterprise 'login').
}

@end
