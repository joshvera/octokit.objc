//
//  OCTDiffEntrySpec.m
//  OctoKit
//
//  Created by Josh Vera on 8/30/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTDiffEntry.h"
#import "OCTObjectSpec.h"

SpecBegin(OCTDiffEntry)

NSDictionary *representation = @{
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
};

__block OCTDiffEntry *diffEntry;

before(^{
    diffEntry = [MTLJSONAdapter modelOfClass:OCTDiffEntry.class fromJSONDictionary:representation error:NULL];
	expect(diffEntry).notTo.beNil();
});

itShouldBehaveLike(OCTObjectArchivingSharedExamplesName, ^{
	return @{ OCTObjectKey: diffEntry };
});

it(@"should initialize", ^{
    expect(diffEntry.diffSHA).to.equal(representation[@"sha"]);
    expect(diffEntry.filename).to.equal(representation[@"filename"]);
    expect(diffEntry.status).to.equal(representation[@"status"]);
    expect(diffEntry.additions).to.equal([representation[@"additions"] unsignedIntegerValue]);
    expect(diffEntry.deletions).to.equal([representation[@"deletions"] unsignedIntegerValue]);
    expect(diffEntry.changes).to.equal([representation[@"changes"] unsignedIntegerValue]);

    NSURL *blobURL = [NSURL URLWithString:representation[@"blob_url"]];
    expect(diffEntry.blobURL).to.equal(blobURL);

    NSURL *rawURL = [NSURL URLWithString:representation[@"raw_url"]];
    expect(diffEntry.rawURL).to.equal(rawURL);

    NSURL *contentsURL = [NSURL URLWithString:representation[@"contents_url"]];
    expect(diffEntry.contentsURL).to.equal(contentsURL);

    expect(diffEntry.patch).to.equal(representation[@"patch"]);
});

SpecEnd

