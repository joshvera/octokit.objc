//
//  OCTEntitySpec.m
//  OctoKit
//
//  Created by Josh Vera on 8/31/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTObjectSpec.h"
#import "OCTEntity.h"

SpecBegin(OCTEntity)

__block NSDictionary *dict;
__block OCTEntity *entity;

	before(^{
		NSData *data = [NSData dataWithContentsOfFile:@"repository.json"];
		dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
		entity = [MTLJSONAdapter modelOfClass:OCTRepository.class fromJSONDictionary:dict error:NULL];
		expect(entity).notTo.beNil();
	});


describe(@"it initializes", ^{
	expect(entity.login).to.equal(dict[@"login"]);
	expect(entity.name).to.equal(dict[@"login"]);
	expect(entity.avatarURL).to.equal([NSURL URLWithString:dict[@"avatar_url"]]);
	expect(entity.publicRepoCount).to.equal([dict[@"public_repos"] unsignedIntegerValue]);
	expect(entity.privateRepoCount).to.equal([dict[@"owned_private_repos"] unsignedIntegerValue]);
	expect(entity.diskUsage).to.equal([dict[@"disk_usage"] unsignedIntegerValue]);
	expect(entity.APIURITemplate).to.equal([CSURITemplate URITemplateWithString:dict[@"url"] error:NULL]);
	expect(entity.HTMLURL).to.equal(dict[@"html_url"]);

	CSURITemplate *followers = [CSURITemplate URITemplateWithString:dict[@"followers_url"] error:NULL];
	expect(entity.followersURITemplate).to.equal(followers);

	CSURITemplate *following = [CSURITemplate URITemplateWithString:dict[@"following_url"] error:NULL];
	expect(entity.followingURITemplate).to.equal(following);

	CSURITemplate *gists = [CSURITemplate URITemplateWithString:dict[@"gists_url"] error:NULL];
	expect(entity.gistsURITemplate).to.equal(gists);

	CSURITemplate *starred = [CSURITemplate URITemplateWithString:dict[@"starred_url"] error:NULL];
	expect(entity.starredURITemplate).to.equal(starred);

	CSURITemplate *subscriptions = [CSURITemplate URITemplateWithString:dict[@"subscriptions_url"] error:NULL];
	expect(entity.subscriptionsURITemplate).to.equal(subscriptions);

	CSURITemplate *organizations = [CSURITemplate URITemplateWithString:dict[@"organizations_url"] error:NULL];
	expect(entity.organizationsURITemplate).to.equal(organizations);

	CSURITemplate *repos = [CSURITemplate URITemplateWithString:dict[@"repos_url"] error:NULL];
	expect(entity.reposURITemplate).to.equal(repos);

	CSURITemplate *events = [CSURITemplate URITemplateWithString:dict[@"events_url"] error:NULL];
	expect(entity.eventsURITemplate).to.equal(events);

	CSURITemplate *receivedEvents = [CSURITemplate URITemplateWithString:dict[@"received_events_url"] error:NULL];
	expect(entity.receivedEventsURITemplate).to.equal(receivedEvents);
});

SpecEnd
