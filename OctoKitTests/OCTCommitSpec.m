//
//	OCTCommitSpec.m
//	OctoKit
//
//	Created by Josh Vera on 8/30/13.
//	Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTCommit.h"
#import "OCTUser.h"
#import "OCTFile.h"
#import "OCTObjectSpec.h"

SpecBegin(OCTCommit)

NSDictionary *representation = @{
	@"sha": @"5bfb0f1a86019e7924fc3ab4a0b7983f3416f272",
	@"commit": @{
		@"author": @{
			@"name": @"joshaber",
			@"email": @"joshaber@gmail.com",
			@"date": @"2013-07-26T15:37:01Z"
		},
		@"committer": @{
			@"name": @"joshaber",
			@"email": @"joshaber@gmail.com",
			@"date": @"2013-07-26T15:37:01Z"
		},
		@"message": @"++RAC",
		@"tree": @{
			@"sha": @"64bda6bb15bca58408a53aae9fc32b4db75791eb",
			@"url": @"https://api.github.com/repos/octokit/octokit.objc/git/trees/64bda6bb15bca58408a53aae9fc32b4db75791eb"
		},
		@"url": @"https://api.github.com/repos/octokit/octokit.objc/git/commits/5bfb0f1a86019e7924fc3ab4a0b7983f3416f272",
		@"comment_count": @0
	},
	@"url": @"https://api.github.com/repos/octokit/octokit.objc/commits/5bfb0f1a86019e7924fc3ab4a0b7983f3416f272",
	@"html_url": @"https://github.com/octokit/octokit.objc/commit/5bfb0f1a86019e7924fc3ab4a0b7983f3416f272",
	@"comments_url": @"https://api.github.com/repos/octokit/octokit.objc/commits/5bfb0f1a86019e7924fc3ab4a0b7983f3416f272/comments",
	@"author": @{
		@"login": @"joshaber",
		@"id": @213760,
		@"avatar_url": @"https://2.gravatar.com/avatar/62e8c8bfaa8d755cab82accb48d335c8?d=https%3A%2F%2Fidenticons.github.com%2F0699d72f474c31efe0028155463cd8a8.png",
		@"gravatar_id": @"62e8c8bfaa8d755cab82accb48d335c8",
		@"url": @"https://api.github.com/users/joshaber",
		@"html_url": @"https://github.com/joshaber",
		@"followers_url": @"https://api.github.com/users/joshaber/followers",
		@"following_url": @"https://api.github.com/users/joshaber/following{/other_user}",
		@"gists_url": @"https://api.github.com/users/joshaber/gists{/gist_id}",
		@"starred_url": @"https://api.github.com/users/joshaber/starred{/owner}{/repo}",
		@"subscriptions_url": @"https://api.github.com/users/joshaber/subscriptions",
		@"organizations_url": @"https://api.github.com/users/joshaber/orgs",
		@"repos_url": @"https://api.github.com/users/joshaber/repos",
		@"events_url": @"https://api.github.com/users/joshaber/events{/privacy}",
		@"received_events_url": @"https://api.github.com/users/joshaber/received_events",
		@"type": @"User"
	},
	@"committer": @{
		@"login": @"joshaber",
		@"id": @13760,
		@"avatar_url": @"https://2.gravatar.com/avatar/62e8c8bfaa8d755cab82accb48d335c8?d=https%3A%2F%2Fidenticons.github.com%2F0699d72f474c31efe0028155463cd8a8.png",
		@"gravatar_id": @"62e8c8bfaa8d755cab82accb48d335c8",
		@"url": @"https://api.github.com/users/joshaber",
		@"html_url": @"https://github.com/joshaber",
		@"followers_url": @"https://api.github.com/users/joshaber/followers",
		@"following_url": @"https://api.github.com/users/joshaber/following{/other_user}",
		@"gists_url": @"https://api.github.com/users/joshaber/gists{/gist_id}",
		@"starred_url": @"https://api.github.com/users/joshaber/starred{/owner}{/repo}",
		@"subscriptions_url": @"https://api.github.com/users/joshaber/subscriptions",
		@"organizations_url": @"https://api.github.com/users/joshaber/orgs",
		@"repos_url": @"https://api.github.com/users/joshaber/repos",
		@"events_url": @"https://api.github.com/users/joshaber/events{/privacy}",
		@"received_events_url": @"https://api.github.com/users/joshaber/received_events",
		@"type": @"User"
	},
	@"parents": @[@{
		@"sha": @"5f3a3a463428fee63c0519324f9ef6fae77c8040",
		@"url": @"https://api.github.com/repos/octokit/octokit.objc/commits/5f3a3a463428fee63c0519324f9ef6fae77c8040",
		@"html_url": @"https://github.com/octokit/octokit.objc/commit/5f3a3a463428fee63c0519324f9ef6fae77c8040"
	}],
	@"stats": @{
		@"total": @2,
		@"additions": @1,
		@"deletions": @1
	},
	@"files": @[@{
		@"sha": @"27838941393cc85fa79f58bd0a0cd604ab1c3c34",
		@"filename": @"External/ReactiveCocoa",
		@"status": @"modified",
		@"additions": @1,
		@"deletions":
		@1,
		@"changes": @2,
		@"blob_url": @"https://github.com/octokit/octokit.objc/blob/5bfb0f1a86019e7924fc3ab4a0b7983f3416f272/External/ReactiveCocoa",
		@"raw_url": @"https://github.com/octokit/octokit.objc/raw/5bfb0f1a86019e7924fc3ab4a0b7983f3416f272/External/ReactiveCocoa",
		@"contents_url": @"https://api.github.com/repos/octokit/octokit.objc/contents/External/ReactiveCocoa?ref=5bfb0f1a86019e7924fc3ab4a0b7983f3416f272",
		@"patch": @"@@ -1 +1 @@\n-Subproject commit a06965018b540ef9bf4c7a36867a882e00b90e1e\n+Subproject commit 27838941393cc85fa79f58bd0a0cd604ab1c3c34"
	}]
};

__block OCTCommit *commit;

before(^{
	commit = [MTLJSONAdapter modelOfClass:OCTCommit.class fromJSONDictionary:representation error:NULL];
	expect(commit).notTo.beNil();
});

itShouldBehaveLike(OCTObjectArchivingSharedExamplesName, ^{
	return @{ OCTObjectKey: commit };
});

it(@"should initialize", ^{
	expect(commit.commitSHA).to.equal(representation[@"commitSHA"]);
	expect(commit.HTMLURL).to.equal([NSURL URLWithString:representation[@"html_url"]]);
	expect(commit.commentsURL).to.equal([NSURL URLWithString:representation[@"comments_url"]]);
	expect(commit.APIURL).to.equal([NSURL URLWithString:representation[@"url"]]);

	NSDate *authored = [[[ISO8601DateFormatter alloc] init] dateFromString:representation[@"commit"][@"author"][@"date"]];
	expect(commit.authoredDate).to.equal(authored);

	NSDate *committed = [[[ISO8601DateFormatter alloc] init] dateFromString:representation[@"commit"][@"committer"][@"date"]];
	expect(commit.committedDate).to.equal(committed);



	OCTUser *author = [MTLJSONAdapter modelOfClass:OCTUser.class fromJSONDictionary:representation[@"author"] error:NULL];
	expect(commit.author).to.equal(author);

	OCTUser *committer = [MTLJSONAdapter modelOfClass:OCTUser.class fromJSONDictionary:representation[@"committer"] error:NULL];
	expect(commit.committer).to.equal(committer);

	expect(commit.total).to.equal([representation[@"total"] unsignedIntegerValue]);

	expect(commit.additions).to.equal([representation[@"additions"] unsignedIntegerValue]);

	expect(commit.deletions).to.equal([representation[@"deletions"] unsignedIntegerValue]);

	NSArray *array = [[NSValueTransformer mtl_JSONArrayTransformerWithModelClass:OCTFile.class] transformedValue:representation[@"files"]];
	expect(commit.files).to.equal(array);
});

SpecEnd

