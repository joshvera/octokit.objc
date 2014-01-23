//
//  OCTClient+Repositories.m
//  OctoKit
//
//  Created by Justin Spahr-Summers on 2013-11-22.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTClient+Repositories.h"
#import "OCTClient+Private.h"
#import "OCTContent.h"
#import "OCTPublicOrganization.h"
#import "OCTRepository.h"
#import "OCTTeam.h"
#import "OCTFileContent.h"
#import "OCTLabel.h"
#import "OCTMilestone.h"
#import "RACSignal+OCTClientAdditions.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation OCTClient (Repositories)

- (RACSignal *)fetchUserRepositories {
	return [[self enqueueUserRequestWithMethod:@"GET" relativePath:@"/repos" parameters:nil resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchUserStarredRepositories {
	return [[self enqueueUserRequestWithMethod:@"GET" relativePath:@"/starred" parameters:nil resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoriesForOrganization:(OCTPublicOrganization *)organization {
	NSURLRequest *request = [self requestWithMethod:@"GET" path:[NSString stringWithFormat:@"orgs/%@/repos", organization.login] parameters:nil notMatchingEtag:nil];
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)createRepositoryWithName:(NSString *)name description:(NSString *)description private:(BOOL)isPrivate {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	return [self createRepositoryWithName:name organization:nil team:nil description:description private:isPrivate];
}

- (RACSignal *)createRepositoryWithName:(NSString *)name organization:(OCTPublicOrganization *)organization team:(OCTTeam *)team description:(NSString *)description private:(BOOL)isPrivate {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableDictionary *options = [NSMutableDictionary dictionary];
	options[@"name"] = name;
	options[@"private"] = @(isPrivate);

	if (description != nil) options[@"description"] = description;
	if (team != nil) options[@"team_id"] = team.objectID;
	
	NSString *path = (organization == nil ? @"user/repos" : [NSString stringWithFormat:@"orgs/%@/repos", organization.login]);
	NSURLRequest *request = [self requestWithMethod:@"POST" path:path parameters:options notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchRelativePath:(NSString *)relativePath inRepository:(OCTRepository *)repository reference:(NSString *)reference {
	NSParameterAssert(repository != nil);
	NSParameterAssert(repository.name.length > 0);
	NSParameterAssert(repository.ownerLogin.length > 0);
	
	relativePath = relativePath ?: @"";
	NSString *path = [NSString stringWithFormat:@"repos/%@/%@/contents/%@", repository.ownerLogin, repository.name, relativePath];
	
	NSDictionary *parameters = nil;
	if (reference.length > 0) {
		parameters = @{ @"ref": reference };
	}
	
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:parameters notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTContent.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoryWithName:(NSString *)name owner:(NSString *)owner {
	NSParameterAssert(name.length > 0);
	NSParameterAssert(owner.length > 0);
	
	NSString *path = [NSString stringWithFormat:@"repos/%@/%@", owner, name];
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil notMatchingEtag:nil];
	
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoryReadme:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);
	NSParameterAssert(repository.name.length > 0);
	NSParameterAssert(repository.ownerLogin.length > 0);
	
	NSString *path = [NSString stringWithFormat:@"repos/%@/%@/readme", repository.ownerLogin, repository.name];
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil notMatchingEtag:nil];

	return [[self enqueueRequest:request resultClass:OCTFileContent.class] oct_parsedResults];
}

- (RACSignal *)fetchRepositoryReadme:(OCTRepository *)repository asHTML:(BOOL)asHTML {
	NSParameterAssert(repository != nil);
	NSParameterAssert(repository.name.length > 0);
	NSParameterAssert(repository.ownerLogin.length > 0);
	
	NSString *path = [NSString stringWithFormat:@"repos/%@/%@/readme", repository.ownerLogin, repository.name];
	NSMutableURLRequest *request = [self requestWithMethod:@"GET" path:path parameters:nil notMatchingEtag:nil];
	if (asHTML) {
		[request setValue:@"application/vnd.github.beta.html" forHTTPHeaderField:@"Accept"];
		return [[self enqueueRequest:request resultClass:nil] oct_parsedResults];
	}

	return [[self enqueueRequest:request resultClass:OCTFileContent.class] oct_parsedResults];
}

- (RACSignal *)unwatchRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSString *path = [NSString stringWithFormat:@"repos/%@/%@", repository.ownerLogin, repository.name];
	NSMutableURLRequest *request = [self requestWithMethod:@"DELETE" path:path parameters:nil];

	return [[self enqueueRequest:request resultClass:nil] ignoreValues];
	
}

- (RACSignal *)fetchLabelsForRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:repository.labelsURITemplate parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTLabel.class] oct_parsedResults];
}

- (RACSignal *)fetchMilestonesForRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:repository.milestonesURITemplate parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTMilestone.class] oct_parsedResults];
}

- (RACSignal *)fetchCollaboratorsForRepository:(OCTRepository *)repository {
	NSParameterAssert(repository != nil);

	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:repository.collaboratorsURITemplate parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTMilestone.class] oct_parsedResults];
}


- (RACSignal *)fetchRepositoriesAtURITemplate:(CSURITemplate *)template {
	if (!self.authenticated) return [RACSignal error:self.class.authenticationRequiredError];

	NSMutableURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:nil forHTTPHeaderField:@"Accept-Language"];
	request = [self etagRequestWithRequest:request];

	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

- (RACSignal *)fetchStarredRepositoriesAtURITemplate:(CSURITemplate *)template {
	NSURLRequest *request = [self requestWithMethod:@"GET" template:template parameters:nil];
	return [[self enqueueRequest:request resultClass:OCTRepository.class] oct_parsedResults];
}

@end
