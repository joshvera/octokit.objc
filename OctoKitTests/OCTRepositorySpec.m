//
//  OCTRepositorySpec.m
//  GitHub
//
//  Created by Justin Spahr-Summers on 2012-09-26.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "OCTRepository.h"
#import "OCTObjectSpec.h"

SpecBegin(OCTRepository)

describe(@"from JSON", ^{
	__block NSDictionary *representation;
	__block OCTRepository *repository;

	before(^{
		NSURL *URL = [[NSBundle bundleForClass:self.class] URLForResource:@"repository" withExtension:@"json"];
		NSData *data = [NSData dataWithContentsOfURL:URL];
		representation = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
		expect(representation).notTo.beNil();

		repository = [MTLJSONAdapter modelOfClass:OCTRepository.class fromJSONDictionary:representation error:NULL];
		expect(repository).notTo.beNil();
	});

	itShouldBehaveLike(OCTObjectArchivingSharedExamplesName, ^{
		return @{ OCTObjectKey: repository };
	});

	it(@"should initialize", ^{
		expect(repository.objectID).to.equal([representation[@"id"] stringValue]);
		expect(repository.name).to.equal(representation[@"name"]);
		expect(repository.fullName).to.equal(representation[@"full_name"]);

		OCTUser *owner = [MTLJSONAdapter modelOfClass:OCTUser.class fromJSONDictionary:representation[@"owner"] error:NULL];
		expect(repository.owner).to.equal(owner);

		expect(repository.private).to.equal(representation[@"private"]);

		NSURL *HTMLURL = [NSURL URLWithString:representation[@"html_url"]];
		expect(repository.HTMLURL).to.equal(HTMLURL);

		expect(repository.repoDescription).to.equal(representation[@"description"]);
		expect(repository.fork).to.beFalsy();

		CSURITemplate *APIURITemplate = [CSURITemplate URITemplateWithString:representation[@"url"] error:NULL];
		expect(repository.APIURITemplate).to.equal(APIURITemplate);

		CSURITemplate *forksURITemplate = [CSURITemplate URITemplateWithString:representation[@"forks_url"] error:NULL];
		expect(repository.forksURITemplate).to.equal(forksURITemplate);

		CSURITemplate *keysURITemplate = [CSURITemplate URITemplateWithString:representation[@"keys_url"] error:NULL];
		expect(repository.keysURITemplate).to.equal(keysURITemplate);

		CSURITemplate *collaboratorsURITemplate = [CSURITemplate URITemplateWithString:representation[@"collaborators_url"] error:NULL];
		expect(repository.collaboratorsURITemplate).to.equal(collaboratorsURITemplate);

		CSURITemplate *teamsURITemplate = [CSURITemplate URITemplateWithString:representation[@"teams_url"] error:NULL];
		expect(repository.teamsURITemplate).to.equal(teamsURITemplate);

		CSURITemplate *hooksURITemplate = [CSURITemplate URITemplateWithString:representation[@"hooks_url"] error:NULL];
		expect(repository.hooksURITemplate).to.equal(hooksURITemplate);

		CSURITemplate *issueEventsURITemplate = [CSURITemplate URITemplateWithString:representation[@"issue_events_url"] error:NULL];
		expect(repository.issueEventsURITemplate).to.equal(issueEventsURITemplate);

		CSURITemplate *eventsURITemplate = [CSURITemplate URITemplateWithString:representation[@"events_url"] error:NULL];
		expect(repository.eventsURITemplate).to.equal(eventsURITemplate);

		CSURITemplate *assigneesURITemplate = [CSURITemplate URITemplateWithString:representation[@"assignees_url"] error:NULL];
		expect(repository.assigneesURITemplate).to.equal(assigneesURITemplate);

		CSURITemplate *branchesURITemplate = [CSURITemplate URITemplateWithString:representation[@"branches_url"] error:NULL];
		expect(repository.branchesURITemplate).to.equal(branchesURITemplate);

		CSURITemplate *tagsURITemplate = [CSURITemplate URITemplateWithString:representation[@"tags_url"] error:NULL];
		expect(repository.tagsURITemplate).to.equal(tagsURITemplate);

		CSURITemplate *blobsURITemplate = [CSURITemplate URITemplateWithString:representation[@"blobs_url"] error:NULL];
		expect(repository.blobsURITemplate).to.equal(blobsURITemplate);

		CSURITemplate *gitTagsURITemplate = [CSURITemplate URITemplateWithString:representation[@"git_tags_url"] error:NULL];
		expect(repository.gitTagsURITemplate).to.equal(gitTagsURITemplate);

		CSURITemplate *gitRefsURITemplate = [CSURITemplate URITemplateWithString:representation[@"git_refs_url"] error:NULL];
		expect(repository.gitRefsURITemplate).to.equal(gitRefsURITemplate);

		CSURITemplate *treesURITemplate = [CSURITemplate URITemplateWithString:representation[@"trees_url"] error:NULL];
		expect(repository.treesURITemplate).to.equal(treesURITemplate);

		CSURITemplate *statusesURITemplate = [CSURITemplate URITemplateWithString:representation[@"statuses_url"] error:NULL];
		expect(repository.statusesURITemplate).to.equal(statusesURITemplate);

		CSURITemplate *languagesURITemplate = [CSURITemplate URITemplateWithString:representation[@"languages_url"] error:NULL];
		expect(repository.languagesURITemplate).to.equal(languagesURITemplate);

		CSURITemplate *stargazersURITemplate = [CSURITemplate URITemplateWithString:representation[@"stargazers_url"] error:NULL];
		expect(repository.stargazersURITemplate).to.equal(stargazersURITemplate);

		CSURITemplate *contributorsURITemplate = [CSURITemplate URITemplateWithString:representation[@"contributors_url"] error:NULL];
		expect(repository.contributorsURITemplate).to.equal(contributorsURITemplate);

		CSURITemplate *subscribersURITemplate = [CSURITemplate URITemplateWithString:representation[@"subscribers_url"] error:NULL];
		expect(repository.subscribersURITemplate).to.equal(subscribersURITemplate);

		CSURITemplate *commitsURITemplate = [CSURITemplate URITemplateWithString:representation[@"commits_url"] error:NULL];
		expect(repository.commitsURITemplate).to.equal(commitsURITemplate);

		CSURITemplate *issueCommentURITemplate = [CSURITemplate URITemplateWithString:representation[@"issue_comment_url"] error:NULL];
		expect(repository.issueCommentURITemplate).to.equal(issueCommentURITemplate);

		CSURITemplate *contentsURITemplate = [CSURITemplate URITemplateWithString:representation[@"contents_url"] error:NULL];
		expect(repository.contentsURITemplate).to.equal(contentsURITemplate);

		CSURITemplate *compareURITemplate = [CSURITemplate URITemplateWithString:representation[@"compare_url"] error:NULL];
		expect(repository.compareURITemplate).to.equal(compareURITemplate);

		CSURITemplate *mergesURITemplate = [CSURITemplate URITemplateWithString:representation[@"merges_url"] error:NULL];
		expect(repository.mergesURITemplate).to.equal(mergesURITemplate);

		CSURITemplate *archiveURITemplate = [CSURITemplate URITemplateWithString:representation[@"archive_url"] error:NULL];
		expect(repository.archiveURITemplate).to.equal(archiveURITemplate);

		CSURITemplate *issuesURITemplate = [CSURITemplate URITemplateWithString:representation[@"issues_url"] error:NULL];
		expect(repository.issuesURITemplate).to.equal(issuesURITemplate);

		CSURITemplate *pullsURITemplate = [CSURITemplate URITemplateWithString:representation[@"pulls_url"] error:NULL];
		expect(repository.pullsURITemplate).to.equal(pullsURITemplate);

		CSURITemplate *milestonesURITemplate = [CSURITemplate URITemplateWithString:representation[@"milestones_url"] error:NULL];
		expect(repository.milestonesURITemplate).to.equal(milestonesURITemplate);

		CSURITemplate *notificationsURITemplate = [CSURITemplate URITemplateWithString:representation[@"notifications_url"] error:NULL];
		expect(repository.notificationsURITemplate).to.equal(notificationsURITemplate);

		CSURITemplate *labelsURITemplate = [CSURITemplate URITemplateWithString:representation[@"labels_url"] error:NULL];
		expect(repository.labelsURITemplate).to.equal(labelsURITemplate);

		NSURL *gitURL = [NSURL URLWithString:representation[@"git_url"]];
		expect(repository.gitURL).to.equal(gitURL);

		NSURL *SSHURL = [NSURL URLWithString:representation[@"ssh_url"]];
		expect(repository.SSHURL).to.equal(SSHURL);

		NSURL *cloneURL = [NSURL URLWithString:representation[@"clone_url"]];
		expect(repository.cloneURL).to.equal(cloneURL);

		NSURL *SVNURL = [NSURL URLWithString:representation[@"svn_url"]];
		expect(repository.SVNURL).to.equal(SVNURL);

		NSURL *mirrorURL = [NSURL URLWithString:representation[@"mirror_url"]];
		expect(repository.mirrorURL).to.equal(mirrorURL);

		expect(repository.HTTPSURL).to.equal([NSURL URLWithString:representation[@"clone_url"]]);

		expect(repository.HTMLURL).to.equal([NSURL URLWithString:representation[@"html_url"]]);

		expect(repository.homepage).to.equal(representation[@"homepage"]);
		expect(repository.size).to.equal([representation[@"size"] unsignedIntegerValue]);
		expect(repository.language).to.equal(representation[@"language"]);
		expect(repository.hasIssues).to.equal([representation[@"has_issues"] boolValue]);
		expect(repository.hasWiki).to.equal([representation[@"has_wiki"] boolValue]);
		expect(repository.forkCount).to.equal(representation[@"forks"]);
		expect(repository.openIssuesCount).to.equal(representation[@"open_issues"]);
		expect(repository.watchersCount).to.equal(representation[@"watchers"]);
		expect(repository.masterBranch).to.equal(representation[@"master_branch"]);
		expect(repository.defaultBranch).to.equal(representation[@"default_branch"]);

		expect(repository.admin).to.beTruthy();
		expect(repository.canPush).to.beTruthy();
		expect(repository.canPull).to.beTruthy();
		expect(repository.networkCount).to.equal([representation[@"network_count"] unsignedIntegerValue]);

		OCTOrganization *organization = [MTLJSONAdapter modelOfClass:OCTRepository.class fromJSONDictionary:representation[@"organization"] error:NULL];
		expect(repository.organization).to.equal(organization);

		NSDate *createdAtDate = [[[ISO8601DateFormatter alloc] init] dateFromString:representation[@"created_at"]];
		expect(repository.createdAtDate).to.equal(createdAtDate);

		NSDate *updatedAtDate = [[[ISO8601DateFormatter alloc] init] dateFromString:representation[@"updated_at"]];
		expect(repository.updatedAtDate).to.equal(updatedAtDate);

		NSDate *pushedAtDate = [[[ISO8601DateFormatter alloc] init] dateFromString:representation[@"pushed_at"]];
		expect(repository.datePushed).to.equal(pushedAtDate);
		expect(repository.pushedAtDate).to.equal(pushedAtDate);


		expect(repository.defaultBranch).to.equal(representation[@"default_branch"]);
		expect(repository.masterBranch).to.equal(representation[@"master_branch"]);
	});
});

it(@"should migrate from pre-MTLModel OCTObject", ^{
	NSDictionary *representation = @{
		@"OCTObjectModelVersionKey": @2,
		@"description": @"Formerly help.github.com/api. A list of projects using the API",
		@"fork": @0,
		@"forks": @0,
		@"has_downloads": @1,
		@"has_issues": @1,
		@"has_wiki": @1,
		@"homepage": @"poweredby.github.com",
		@"id": @1234,
		@"isPushable": @0,
		@"isTracking": @0,
		@"name": @"poweredby.github.com",
		@"open_issues": @0,
		@"owner": @"github",
		@"private": @1,
		@"url": [NSURL URLWithString:@"https://github.com/github/poweredby.github.com"],
		@"watchers": @1
	};

	NSDictionary *dictionaryValue = [OCTRepository dictionaryValueFromArchivedExternalRepresentation:representation version:0];
	expect(dictionaryValue).notTo.beNil();

	OCTRepository *repository = [OCTRepository modelWithDictionary:dictionaryValue error:NULL];
	expect(repository).notTo.beNil();

	// Test a key that actually changed format.
	expect(repository.ownerLogin).to.equal(@"github");
});

SpecEnd
