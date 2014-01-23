//
//  OCTUser.h
//  OctoKit
//
//  Created by Joe Ricioppo on 7/28/10.
//  Copyright 2010 GitHub. All rights reserved.
//

#import "OCTUserEntity.h"
#import "OCTUserInfo.h"

// A GitHub user.
//
// Users are equal if they come from the same server and have matching object
// IDs, *or* if they were both created with +userWithLogin:server: and their
// logins and servers are equal.
@interface OCTUser : OCTUserEntity <OCTUserInfo>

@end
