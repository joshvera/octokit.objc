//
//  OCTRepository.h
//  OctoKit
//
//  Created by Timothy Clem on 2/14/11.
//  Copyright 2011 GitHub. All rights reserved.
//

#import "OCTObject.h"

@class OCTOwner;
@class OCTOrganization;
@class CSURITemplate;

// A GitHub repository.
@interface OCTRepository : OCTObject

// The name of this repository, as used in GitHub URLs.
//
// This is the second half of a unique GitHub repository name, which follows the
// form `ownerLogin/name`.
@property (nonatomic, copy, readonly) NSString *name;

// The login of the account which owns this repository.
//
// This is the first half of a unique GitHub repository name, which follows the
// form `ownerLogin/name`.
@property (nonatomic, copy, readonly) NSString *ownerLogin;

// The unique GitHub repository name, of the form `ownerLogin/name`.
@property (nonatomic, copy, readonly) NSString *fullName;

// The description of this repository.
@property (nonatomic, copy, readonly) NSString *repoDescription;

@property (nonatomic, assign, readonly) BOOL admin;

@property (nonatomic, assign, readonly) BOOL canPush;

@property (nonatomic, assign, readonly) BOOL canPull;

// Whether this repository is private to the owner.
@property (nonatomic, assign, getter = isPrivate, readonly) BOOL private;

// Whether this repository is a fork of another repository.
@property (nonatomic, assign, getter = isFork, readonly) BOOL fork;

// The repository's owner.
@property (nonatomic, copy, readonly) OCTOwner *owner;

@property (nonatomic, copy, readonly) OCTOrganization *organization;

// The repository's homepage.
@property (nonatomic, copy, readonly) NSString *homepage;

// The repository's size.
@property (nonatomic, assign, readonly) NSUInteger size;

// The repository's main language.
@property (nonatomic, copy, readonly) NSString *language;

// Whether the repository has a wiki.
@property (nonatomic, assign, readonly) BOOL hasWiki;

// Whether the repository has issues.
@property (nonatomic, assign, readonly) BOOL hasIssues;

// The repository's number of forks.
@property (nonatomic, assign, readonly) NSUInteger forkCount;

// The repository's number of open issues.
@property (nonatomic, assign, readonly) NSUInteger openIssuesCount;

// The repository's number of watchers.
@property (nonatomic, assign, readonly) NSUInteger watchersCount;

// The repository's number of networks.
@property (nonatomic, assign, readonly) NSUInteger networkCount;

// The default branch's name. For empty repositories, this will be nil.
@property (nonatomic, copy, readonly) NSString *defaultBranch;

// The master branch's name. For empty repositories, this will be nil.
@property (nonatomic, copy, readonly) NSString *masterBranch;

// The repository's pushed at date.
@property (nonatomic, strong, readonly) NSDate *datePushed;

// The repository's pushed at date.
@property (nonatomic, copy, readonly) NSDate *pushedAtDate;

// The repository's created at date.
@property (nonatomic, copy, readonly) NSDate *createdAtDate;

// The repository's updated at date.
@property (nonatomic, copy, readonly) NSDate *updatedAtDate;

@property (nonatomic, copy, readonly) CSURITemplate *APIURITemplate;

// The repository's HTML URL.
@property (nonatomic, copy, readonly) NSURL *HTMLURL;

// The repository's archive API URL.
@property (nonatomic, copy, readonly) CSURITemplate *archiveURITemplate;

// The repository's assignees API URL.
@property (nonatomic, copy, readonly) CSURITemplate *assigneesURITemplate;

// The repository's blobs API URL.
@property (nonatomic, copy, readonly) CSURITemplate *blobsURITemplate;

// The repository's branches API URL.
@property (nonatomic, copy, readonly) CSURITemplate *branchesURITemplate;

// The repository's clone API URL.
@property (nonatomic, copy, readonly) NSURL *cloneURL;

// The repository's collaborators API URL.
@property (nonatomic, copy, readonly) CSURITemplate *collaboratorsURITemplate;

// The repository's commits API URL.
@property (nonatomic, copy, readonly) CSURITemplate *commitsURITemplate;

// The repository's compare API URL.
@property (nonatomic, copy, readonly) CSURITemplate *compareURITemplate;

// The repository's contents API URL.
@property (nonatomic, copy, readonly) CSURITemplate *contentsURITemplate;

// The repository's contributors API URL.
@property (nonatomic, copy, readonly) CSURITemplate *contributorsURITemplate;

// The repository's events API URL.
@property (nonatomic, copy, readonly) CSURITemplate *eventsURITemplate;

// The repository's forks API URL.
@property (nonatomic, copy, readonly) CSURITemplate *forksURITemplate;

// The URL for pulling this repository over the `git://` protocol.
@property (nonatomic, copy, readonly) NSURL *gitURL;

// The repository's git refs API URL.
@property (nonatomic, copy, readonly) CSURITemplate *gitRefsURITemplate;

// The repository's git tags API URL.
@property (nonatomic, copy, readonly) CSURITemplate *gitTagsURITemplate;

// The repository's hooks API URL.
@property (nonatomic, copy, readonly) CSURITemplate *hooksURITemplate;

// The URL for pushing and pulling this repository over HTTPS.
@property (nonatomic, copy, readonly) NSURL *HTTPSURL;

// The repository's issue comment API URL.
@property (nonatomic, copy, readonly) CSURITemplate *issueCommentURITemplate;

// The repository's issue events API URL.
@property (nonatomic, copy, readonly) CSURITemplate *issueEventsURITemplate;

// The repository's issues HTML URL.
@property (nonatomic, copy, readonly) NSURL *issuesHTMLURL;

// The repository's issues API URL.
@property (nonatomic, copy, readonly) CSURITemplate *issuesURITemplate;

// The repository's keys API URL.
@property (nonatomic, copy, readonly) CSURITemplate *keysURITemplate;

// The repository's labels API URL.
@property (nonatomic, copy, readonly) CSURITemplate *labelsURITemplate;

// The repository's languages API URL.
@property (nonatomic, copy, readonly) CSURITemplate *languagesURITemplate;

// The repository's merges API URL.
@property (nonatomic, copy, readonly) CSURITemplate *mergesURITemplate;

// The repository's milestones API URL.
@property (nonatomic, copy, readonly) CSURITemplate *milestonesURITemplate;

// The repository's mirror URL.
@property (nonatomic, copy, readonly) NSURL *mirrorURL;

// The repository's notifications API URL.
@property (nonatomic, copy, readonly) CSURITemplate *notificationsURITemplate;

// The repository's pulls API URL.
@property (nonatomic, copy, readonly) CSURITemplate *pullsURITemplate;

// The URL for pushing and pulling this repository over SSH, formatted as
// a string because SSH URLs are not correctly interpreted by NSURL.
@property (nonatomic, copy, readonly) NSString *SSHURL;

// The repository's stargazers API URL.
@property (nonatomic, copy, readonly) CSURITemplate *stargazersURITemplate;

// The repository's statuses API URL.
@property (nonatomic, copy, readonly) CSURITemplate *statusesURITemplate;

// The repository's subscribers API URL.
@property (nonatomic, copy, readonly) CSURITemplate *subscribersURITemplate;

// The repository's SVN URL.
@property (nonatomic, copy, readonly) NSURL *SVNURL;

// The repository's tags API URL.
@property (nonatomic, copy, readonly) CSURITemplate *tagsURITemplate;

// The repository's teams API URL.
@property (nonatomic, copy, readonly) CSURITemplate *teamsURITemplate;

// The repository's trees API URL.
@property (nonatomic, copy, readonly) CSURITemplate *treesURITemplate;

@end
