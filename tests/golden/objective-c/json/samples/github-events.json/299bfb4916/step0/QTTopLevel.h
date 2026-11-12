// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTActor;
@class QTPayload;
@class QTComment;
@class QTUser;
@class QTType;
@class QTCommit;
@class QTAuthor;
@class QTIssue;
@class QTLabel;
@class QTMilestone;
@class QTIssuePullRequest;
@class QTPayloadPullRequest;
@class QTBase;
@class QTBaseRepo;
@class QTLinks;
@class QTComments;
@class QTTopLevelRepo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)user;
+ (QTType *)organization;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, strong)           QTActor *actor;
@property (nonatomic, copy)             NSString *createdAt;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, assign)           BOOL isPublic;
@property (nonatomic, nullable, strong) QTActor *org;
@property (nonatomic, strong)           QTPayload *payload;
@property (nonatomic, strong)           QTTopLevelRepo *repo;
@property (nonatomic, copy)             NSString *type;
@end

@interface QTActor : NSObject
@property (nonatomic, copy)           NSString *avatarURL;
@property (nonatomic, nullable, copy) NSString *displayLogin;
@property (nonatomic, copy)           NSString *gravatarID;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *login;
@property (nonatomic, copy)           NSString *url;
@end

@interface QTPayload : NSObject
@property (nonatomic, nullable, copy)   NSString *action;
@property (nonatomic, nullable, copy)   NSString *before;
@property (nonatomic, nullable, strong) QTComment *comment;
@property (nonatomic, nullable, copy)   NSArray<QTCommit *> *commits;
@property (nonatomic, nullable, strong) NSNumber *distinctSize;
@property (nonatomic, nullable, copy)   NSString *head;
@property (nonatomic, nullable, strong) QTIssue *issue;
@property (nonatomic, nullable, copy)   NSString *masterBranch;
@property (nonatomic, nullable, strong) NSNumber *number;
@property (nonatomic, nullable, strong) QTPayloadPullRequest *pullRequest;
@property (nonatomic, nullable, strong) NSNumber *pushID;
@property (nonatomic, nullable, copy)   NSString *pusherType;
@property (nonatomic, nullable, copy)   NSString *ref;
@property (nonatomic, nullable, copy)   NSString *refType;
@property (nonatomic, nullable, strong) NSNumber *size;
@property (nonatomic, nullable, copy)   NSString *theDescription;
@end

@interface QTComment : NSObject
@property (nonatomic, copy)   NSString *body;
@property (nonatomic, copy)   NSString *createdAt;
@property (nonatomic, copy)   NSString *htmlURL;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *issueURL;
@property (nonatomic, copy)   NSString *updatedAt;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, strong) QTUser *user;
@end

@interface QTUser : NSObject
@property (nonatomic, copy)   NSString *avatarURL;
@property (nonatomic, copy)   NSString *eventsURL;
@property (nonatomic, copy)   NSString *followersURL;
@property (nonatomic, copy)   NSString *followingURL;
@property (nonatomic, copy)   NSString *gistsURL;
@property (nonatomic, copy)   NSString *gravatarID;
@property (nonatomic, copy)   NSString *htmlURL;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL isSiteAdmin;
@property (nonatomic, copy)   NSString *login;
@property (nonatomic, copy)   NSString *organizationsURL;
@property (nonatomic, copy)   NSString *receivedEventsURL;
@property (nonatomic, copy)   NSString *reposURL;
@property (nonatomic, copy)   NSString *starredURL;
@property (nonatomic, copy)   NSString *subscriptionsURL;
@property (nonatomic, assign) QTType *type;
@property (nonatomic, copy)   NSString *url;
@end

@interface QTCommit : NSObject
@property (nonatomic, strong) QTAuthor *author;
@property (nonatomic, assign) BOOL isDistinct;
@property (nonatomic, copy)   NSString *message;
@property (nonatomic, copy)   NSString *sha;
@property (nonatomic, copy)   NSString *url;
@end

@interface QTAuthor : NSObject
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *name;
@end

@interface QTIssue : NSObject
@property (nonatomic, nullable, copy)   id assignee;
@property (nonatomic, copy)             NSArray *assignees;
@property (nonatomic, copy)             NSString *body;
@property (nonatomic, nullable, copy)   NSString *closedAt;
@property (nonatomic, assign)           NSInteger comments;
@property (nonatomic, copy)             NSString *commentsURL;
@property (nonatomic, copy)             NSString *createdAt;
@property (nonatomic, copy)             NSString *eventsURL;
@property (nonatomic, copy)             NSString *htmlURL;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           BOOL isLocked;
@property (nonatomic, copy)             NSArray<QTLabel *> *labels;
@property (nonatomic, copy)             NSString *labelsURL;
@property (nonatomic, nullable, strong) QTMilestone *milestone;
@property (nonatomic, assign)           NSInteger number;
@property (nonatomic, nullable, strong) QTIssuePullRequest *pullRequest;
@property (nonatomic, copy)             NSString *repositoryURL;
@property (nonatomic, copy)             NSString *state;
@property (nonatomic, copy)             NSString *title;
@property (nonatomic, copy)             NSString *updatedAt;
@property (nonatomic, copy)             NSString *url;
@property (nonatomic, strong)           QTUser *user;
@end

@interface QTLabel : NSObject
@property (nonatomic, copy)   NSString *color;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *url;
@end

@interface QTMilestone : NSObject
@property (nonatomic, nullable, copy) id closedAt;
@property (nonatomic, assign)         NSInteger closedIssues;
@property (nonatomic, copy)           NSString *createdAt;
@property (nonatomic, strong)         QTUser *creator;
@property (nonatomic, nullable, copy) NSString *dueOn;
@property (nonatomic, copy)           NSString *htmlURL;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSString *labelsURL;
@property (nonatomic, assign)         NSInteger number;
@property (nonatomic, assign)         NSInteger openIssues;
@property (nonatomic, copy)           NSString *state;
@property (nonatomic, copy)           NSString *theDescription;
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, copy)           NSString *url;
@end

@interface QTIssuePullRequest : NSObject
@property (nonatomic, copy) NSString *diffURL;
@property (nonatomic, copy) NSString *htmlURL;
@property (nonatomic, copy) NSString *patchURL;
@property (nonatomic, copy) NSString *url;
@end

@interface QTPayloadPullRequest : NSObject
@property (nonatomic, assign)         NSInteger additions;
@property (nonatomic, nullable, copy) id assignee;
@property (nonatomic, copy)           NSArray *assignees;
@property (nonatomic, strong)         QTBase *base;
@property (nonatomic, copy)           NSString *body;
@property (nonatomic, assign)         NSInteger changedFiles;
@property (nonatomic, copy)           NSString *closedAt;
@property (nonatomic, assign)         NSInteger comments;
@property (nonatomic, copy)           NSString *commentsURL;
@property (nonatomic, assign)         NSInteger commits;
@property (nonatomic, copy)           NSString *commitsURL;
@property (nonatomic, copy)           NSString *createdAt;
@property (nonatomic, assign)         NSInteger deletions;
@property (nonatomic, copy)           NSString *diffURL;
@property (nonatomic, strong)         QTBase *head;
@property (nonatomic, copy)           NSString *htmlURL;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         BOOL isLocked;
@property (nonatomic, assign)         BOOL isMaintainerCanModify;
@property (nonatomic, assign)         BOOL isMerged;
@property (nonatomic, copy)           NSString *issueURL;
@property (nonatomic, strong)         QTLinks *links;
@property (nonatomic, copy)           NSString *mergeCommitSHA;
@property (nonatomic, nullable, copy) id mergeable;
@property (nonatomic, copy)           NSString *mergeableState;
@property (nonatomic, copy)           NSString *mergedAt;
@property (nonatomic, strong)         QTUser *mergedBy;
@property (nonatomic, nullable, copy) id milestone;
@property (nonatomic, assign)         NSInteger number;
@property (nonatomic, copy)           NSString *patchURL;
@property (nonatomic, nullable, copy) id rebaseable;
@property (nonatomic, copy)           NSArray *requestedReviewers;
@property (nonatomic, copy)           NSString *reviewCommentURL;
@property (nonatomic, assign)         NSInteger reviewComments;
@property (nonatomic, copy)           NSString *reviewCommentsURL;
@property (nonatomic, copy)           NSString *state;
@property (nonatomic, copy)           NSString *statusesURL;
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, strong)         QTUser *user;
@end

@interface QTBase : NSObject
@property (nonatomic, copy)   NSString *label;
@property (nonatomic, copy)   NSString *ref;
@property (nonatomic, strong) QTBaseRepo *repo;
@property (nonatomic, copy)   NSString *sha;
@property (nonatomic, strong) QTUser *user;
@end

@interface QTBaseRepo : NSObject
@property (nonatomic, copy)           NSString *archiveURL;
@property (nonatomic, copy)           NSString *assigneesURL;
@property (nonatomic, copy)           NSString *blobsURL;
@property (nonatomic, copy)           NSString *branchesURL;
@property (nonatomic, copy)           NSString *cloneURL;
@property (nonatomic, copy)           NSString *collaboratorsURL;
@property (nonatomic, copy)           NSString *commentsURL;
@property (nonatomic, copy)           NSString *commitsURL;
@property (nonatomic, copy)           NSString *compareURL;
@property (nonatomic, copy)           NSString *contentsURL;
@property (nonatomic, copy)           NSString *contributorsURL;
@property (nonatomic, copy)           NSString *createdAt;
@property (nonatomic, copy)           NSString *defaultBranch;
@property (nonatomic, copy)           NSString *deploymentsURL;
@property (nonatomic, copy)           NSString *downloadsURL;
@property (nonatomic, copy)           NSString *eventsURL;
@property (nonatomic, assign)         NSInteger forks;
@property (nonatomic, assign)         NSInteger forksCount;
@property (nonatomic, copy)           NSString *forksURL;
@property (nonatomic, copy)           NSString *fullName;
@property (nonatomic, copy)           NSString *gitCommitsURL;
@property (nonatomic, copy)           NSString *gitRefsURL;
@property (nonatomic, copy)           NSString *gitTagsURL;
@property (nonatomic, copy)           NSString *gitURL;
@property (nonatomic, assign)         BOOL hasDownloads;
@property (nonatomic, assign)         BOOL hasIssues;
@property (nonatomic, assign)         BOOL hasPages;
@property (nonatomic, assign)         BOOL hasProjects;
@property (nonatomic, assign)         BOOL hasWiki;
@property (nonatomic, copy)           NSString *homepage;
@property (nonatomic, copy)           NSString *hooksURL;
@property (nonatomic, copy)           NSString *htmlURL;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, assign)         BOOL isFork;
@property (nonatomic, assign)         BOOL isPrivate;
@property (nonatomic, copy)           NSString *issueCommentURL;
@property (nonatomic, copy)           NSString *issueEventsURL;
@property (nonatomic, copy)           NSString *issuesURL;
@property (nonatomic, copy)           NSString *keysURL;
@property (nonatomic, copy)           NSString *labelsURL;
@property (nonatomic, copy)           NSString *language;
@property (nonatomic, copy)           NSString *languagesURL;
@property (nonatomic, copy)           NSString *mergesURL;
@property (nonatomic, copy)           NSString *milestonesURL;
@property (nonatomic, nullable, copy) id mirrorURL;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSString *notificationsURL;
@property (nonatomic, assign)         NSInteger openIssues;
@property (nonatomic, assign)         NSInteger openIssuesCount;
@property (nonatomic, strong)         QTUser *owner;
@property (nonatomic, copy)           NSString *pullsURL;
@property (nonatomic, copy)           NSString *pushedAt;
@property (nonatomic, copy)           NSString *releasesURL;
@property (nonatomic, assign)         NSInteger size;
@property (nonatomic, copy)           NSString *sshURL;
@property (nonatomic, assign)         NSInteger stargazersCount;
@property (nonatomic, copy)           NSString *stargazersURL;
@property (nonatomic, copy)           NSString *statusesURL;
@property (nonatomic, copy)           NSString *subscribersURL;
@property (nonatomic, copy)           NSString *subscriptionURL;
@property (nonatomic, copy)           NSString *svnURL;
@property (nonatomic, copy)           NSString *tagsURL;
@property (nonatomic, copy)           NSString *teamsURL;
@property (nonatomic, copy)           NSString *theDescription;
@property (nonatomic, copy)           NSString *treesURL;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, assign)         NSInteger watchers;
@property (nonatomic, assign)         NSInteger watchersCount;
@end

@interface QTLinks : NSObject
@property (nonatomic, strong) QTComments *comments;
@property (nonatomic, strong) QTComments *commits;
@property (nonatomic, strong) QTComments *html;
@property (nonatomic, strong) QTComments *issue;
@property (nonatomic, strong) QTComments *reviewComment;
@property (nonatomic, strong) QTComments *reviewComments;
@property (nonatomic, strong) QTComments *self;
@property (nonatomic, strong) QTComments *statuses;
@end

@interface QTComments : NSObject
@property (nonatomic, copy) NSString *href;
@end

@interface QTTopLevelRepo : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *url;
@end

NS_ASSUME_NONNULL_END
