#import "QTTopLevel.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTTopLevelElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTActor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPayload (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUser (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCommit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAuthor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIssue (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLabel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMilestone (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIssuePullRequest (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPayloadPullRequest (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBase (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBaseRepo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLinks (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTComments (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTopLevelRepo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTType
+ (NSDictionary<NSString *, QTType *> *)values
{
    static NSDictionary<NSString *, QTType *> *values;
    return values = values ? values : @{
        @"User": [[QTType alloc] initWithValue:@"User"],
        @"Organization": [[QTType alloc] initWithValue:@"Organization"],
    };
}

+ (QTType *)user { return QTType.values[@"User"]; }
+ (QTType *)organization { return QTType.values[@"Organization"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
            result = [NSMutableArray arrayWithCapacity:[(NSArray *)collection count]];
            for (id x in collection) [result addObject:NSNullify(f(x))];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
            result = [NSMutableDictionary dictionaryWithCapacity:[(NSDictionary *)collection count]];
            for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        if (![json isKindOfClass:NSArray.class]) [NSException raise:@"Invalid JSON" format:@"Expected NSArray."];
        return *error ? nil : map(json, λ(id x, [QTTopLevelElement fromJSONDictionary:x]));
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return QTTopLevelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error)
{
    @try {
        id json = map(topLevel, λ(id x, [x JSONDictionary]));
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingFragmentsAllowed error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = QTTopLevelToData(topLevel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation QTTopLevelElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"actor": @"actor",
        @"created_at": @"createdAt",
        @"id": @"identifier",
        @"public": @"isPublic",
        @"org": @"org",
        @"payload": @"payload",
        @"repo": @"repo",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"actor"] isKindOfClass:NSDictionary.class]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"public"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"payload"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"repo"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _actor = [QTActor fromJSONDictionary:(id)_actor];
        if (!_actor && dict[@"actor"] && ![dict[@"actor"] isKindOfClass:NSNull.class]) return nil;
        _org = [QTActor fromJSONDictionary:(id)_org];
        if (!_org && dict[@"org"] && ![dict[@"org"] isKindOfClass:NSNull.class]) return nil;
        _payload = [QTPayload fromJSONDictionary:(id)_payload];
        if (!_payload && dict[@"payload"] && ![dict[@"payload"] isKindOfClass:NSNull.class]) return nil;
        _repo = [QTTopLevelRepo fromJSONDictionary:(id)_repo];
        if (!_repo && dict[@"repo"] && ![dict[@"repo"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevelElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevelElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevelElement.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevelElement.properties) {
        id propertyName = QTTopLevelElement.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"actor": [_actor JSONDictionary],
        @"public": _isPublic ? @YES : @NO,
        @"org": NSNullify([_org isKindOfClass:NSNull.class] ? nil : [_org JSONDictionary]),
        @"payload": [_payload JSONDictionary],
        @"repo": [_repo JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTActor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"avatar_url": @"avatarURL",
        @"display_login": @"displayLogin",
        @"gravatar_id": @"gravatarID",
        @"id": @"identifier",
        @"login": @"login",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTActor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"avatar_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"gravatar_id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"login"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTActor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTActor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTActor.properties.allValues] mutableCopy];

    for (id jsonName in QTActor.properties) {
        id propertyName = QTActor.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPayload
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"action": @"action",
        @"before": @"before",
        @"comment": @"comment",
        @"commits": @"commits",
        @"distinct_size": @"distinctSize",
        @"head": @"head",
        @"issue": @"issue",
        @"master_branch": @"masterBranch",
        @"number": @"number",
        @"pull_request": @"pullRequest",
        @"push_id": @"pushID",
        @"pusher_type": @"pusherType",
        @"ref": @"ref",
        @"ref_type": @"refType",
        @"size": @"size",
        @"description": @"theDescription",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPayload alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _commits = map(_commits, λ(id x, [QTCommit fromJSONDictionary:x]));
        _issue = [QTIssue fromJSONDictionary:(id)_issue];
        if (!_issue && dict[@"issue"] && ![dict[@"issue"] isKindOfClass:NSNull.class]) return nil;
        _pullRequest = [QTPayloadPullRequest fromJSONDictionary:(id)_pullRequest];
        if (!_pullRequest && dict[@"pull_request"] && ![dict[@"pull_request"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPayload.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPayload.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPayload.properties.allValues] mutableCopy];

    for (id jsonName in QTPayload.properties) {
        id propertyName = QTPayload.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"commits": NSNullify(map(_commits, λ(id x, [x JSONDictionary]))),
        @"issue": NSNullify([_issue isKindOfClass:NSNull.class] ? nil : [_issue JSONDictionary]),
        @"pull_request": NSNullify([_pullRequest isKindOfClass:NSNull.class] ? nil : [_pullRequest JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"body": @"body",
        @"created_at": @"createdAt",
        @"html_url": @"htmlURL",
        @"id": @"identifier",
        @"issue_url": @"issueURL",
        @"updated_at": @"updatedAt",
        @"url": @"url",
        @"user": @"user",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTComment alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"body"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"issue_url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"user"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _user = [QTUser fromJSONDictionary:(id)_user];
        if (!_user && dict[@"user"] && ![dict[@"user"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTComment.properties.allValues] mutableCopy];

    for (id jsonName in QTComment.properties) {
        id propertyName = QTComment.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"user": [_user JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTUser
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"avatar_url": @"avatarURL",
        @"events_url": @"eventsURL",
        @"followers_url": @"followersURL",
        @"following_url": @"followingURL",
        @"gists_url": @"gistsURL",
        @"gravatar_id": @"gravatarID",
        @"html_url": @"htmlURL",
        @"id": @"identifier",
        @"site_admin": @"isSiteAdmin",
        @"login": @"login",
        @"organizations_url": @"organizationsURL",
        @"received_events_url": @"receivedEventsURL",
        @"repos_url": @"reposURL",
        @"starred_url": @"starredURL",
        @"subscriptions_url": @"subscriptionsURL",
        @"type": @"type",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUser alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"avatar_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"events_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"followers_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"following_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"gists_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"gravatar_id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"site_admin"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"login"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"organizations_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"received_events_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"repos_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"starred_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subscriptions_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUser.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUser.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUser.properties.allValues] mutableCopy];

    for (id jsonName in QTUser.properties) {
        id propertyName = QTUser.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"site_admin": _isSiteAdmin ? @YES : @NO,
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTCommit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"author": @"author",
        @"distinct": @"isDistinct",
        @"message": @"message",
        @"sha": @"sha",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCommit alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"author"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"distinct"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"message"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sha"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _author = [QTAuthor fromJSONDictionary:(id)_author];
        if (!_author && dict[@"author"] && ![dict[@"author"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCommit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCommit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCommit.properties.allValues] mutableCopy];

    for (id jsonName in QTCommit.properties) {
        id propertyName = QTCommit.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"author": [_author JSONDictionary],
        @"distinct": _isDistinct ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTAuthor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"email": @"email",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAuthor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"email"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAuthor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAuthor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAuthor.properties.allValues];
}
@end

@implementation QTIssue
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"assignee": @"assignee",
        @"assignees": @"assignees",
        @"body": @"body",
        @"closed_at": @"closedAt",
        @"comments": @"comments",
        @"comments_url": @"commentsURL",
        @"created_at": @"createdAt",
        @"events_url": @"eventsURL",
        @"html_url": @"htmlURL",
        @"id": @"identifier",
        @"locked": @"isLocked",
        @"labels": @"labels",
        @"labels_url": @"labelsURL",
        @"milestone": @"milestone",
        @"number": @"number",
        @"pull_request": @"pullRequest",
        @"repository_url": @"repositoryURL",
        @"state": @"state",
        @"title": @"title",
        @"updated_at": @"updatedAt",
        @"url": @"url",
        @"user": @"user",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIssue alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"assignee"]) return nil;
        if (![dict[@"assignees"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"body"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"closed_at"]) return nil;
        if (![dict[@"comments"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"comments"] doubleValue] != [dict[@"comments"] longLongValue]) return nil;
        if (![dict[@"comments_url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"events_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"locked"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"labels"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"labels_url"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"milestone"]) return nil;
        if (![dict[@"number"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"number"] doubleValue] != [dict[@"number"] longLongValue]) return nil;
        if (![dict[@"repository_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"state"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"user"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _labels = map(_labels, λ(id x, [QTLabel fromJSONDictionary:x]));
        _milestone = [QTMilestone fromJSONDictionary:(id)_milestone];
        if (!_milestone && dict[@"milestone"] && ![dict[@"milestone"] isKindOfClass:NSNull.class]) return nil;
        _pullRequest = [QTIssuePullRequest fromJSONDictionary:(id)_pullRequest];
        if (!_pullRequest && dict[@"pull_request"] && ![dict[@"pull_request"] isKindOfClass:NSNull.class]) return nil;
        _user = [QTUser fromJSONDictionary:(id)_user];
        if (!_user && dict[@"user"] && ![dict[@"user"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIssue.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIssue.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIssue.properties.allValues] mutableCopy];

    for (id jsonName in QTIssue.properties) {
        id propertyName = QTIssue.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"locked": _isLocked ? @YES : @NO,
        @"labels": map(_labels, λ(id x, [x JSONDictionary])),
        @"milestone": NSNullify([_milestone isKindOfClass:NSNull.class] ? nil : [_milestone JSONDictionary]),
        @"pull_request": NSNullify([_pullRequest isKindOfClass:NSNull.class] ? nil : [_pullRequest JSONDictionary]),
        @"user": [_user JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTLabel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"color": @"color",
        @"id": @"identifier",
        @"default": @"isDefault",
        @"name": @"name",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLabel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"color"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"default"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLabel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLabel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLabel.properties.allValues] mutableCopy];

    for (id jsonName in QTLabel.properties) {
        id propertyName = QTLabel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"default": _isDefault ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTMilestone
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"closed_at": @"closedAt",
        @"closed_issues": @"closedIssues",
        @"created_at": @"createdAt",
        @"creator": @"creator",
        @"due_on": @"dueOn",
        @"html_url": @"htmlURL",
        @"id": @"identifier",
        @"labels_url": @"labelsURL",
        @"number": @"number",
        @"open_issues": @"openIssues",
        @"state": @"state",
        @"description": @"theDescription",
        @"title": @"title",
        @"updated_at": @"updatedAt",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMilestone alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"closed_at"]) return nil;
        if (![dict[@"closed_issues"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"closed_issues"] doubleValue] != [dict[@"closed_issues"] longLongValue]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"creator"] isKindOfClass:NSDictionary.class]) return nil;
        if (!dict[@"due_on"]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"labels_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"number"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"number"] doubleValue] != [dict[@"number"] longLongValue]) return nil;
        if (![dict[@"open_issues"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"open_issues"] doubleValue] != [dict[@"open_issues"] longLongValue]) return nil;
        if (![dict[@"state"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _creator = [QTUser fromJSONDictionary:(id)_creator];
        if (!_creator && dict[@"creator"] && ![dict[@"creator"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMilestone.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMilestone.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMilestone.properties.allValues] mutableCopy];

    for (id jsonName in QTMilestone.properties) {
        id propertyName = QTMilestone.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"creator": [_creator JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTIssuePullRequest
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"diff_url": @"diffURL",
        @"html_url": @"htmlURL",
        @"patch_url": @"patchURL",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIssuePullRequest alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"diff_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"patch_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIssuePullRequest.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIssuePullRequest.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIssuePullRequest.properties.allValues] mutableCopy];

    for (id jsonName in QTIssuePullRequest.properties) {
        id propertyName = QTIssuePullRequest.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPayloadPullRequest
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"additions": @"additions",
        @"assignee": @"assignee",
        @"assignees": @"assignees",
        @"base": @"base",
        @"body": @"body",
        @"changed_files": @"changedFiles",
        @"closed_at": @"closedAt",
        @"comments": @"comments",
        @"comments_url": @"commentsURL",
        @"commits": @"commits",
        @"commits_url": @"commitsURL",
        @"created_at": @"createdAt",
        @"deletions": @"deletions",
        @"diff_url": @"diffURL",
        @"head": @"head",
        @"html_url": @"htmlURL",
        @"id": @"identifier",
        @"locked": @"isLocked",
        @"maintainer_can_modify": @"isMaintainerCanModify",
        @"merged": @"isMerged",
        @"issue_url": @"issueURL",
        @"_links": @"links",
        @"merge_commit_sha": @"mergeCommitSHA",
        @"mergeable": @"mergeable",
        @"mergeable_state": @"mergeableState",
        @"merged_at": @"mergedAt",
        @"merged_by": @"mergedBy",
        @"milestone": @"milestone",
        @"number": @"number",
        @"patch_url": @"patchURL",
        @"rebaseable": @"rebaseable",
        @"requested_reviewers": @"requestedReviewers",
        @"review_comment_url": @"reviewCommentURL",
        @"review_comments": @"reviewComments",
        @"review_comments_url": @"reviewCommentsURL",
        @"state": @"state",
        @"statuses_url": @"statusesURL",
        @"title": @"title",
        @"updated_at": @"updatedAt",
        @"url": @"url",
        @"user": @"user",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPayloadPullRequest alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"additions"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"additions"] doubleValue] != [dict[@"additions"] longLongValue]) return nil;
        if (!dict[@"assignee"]) return nil;
        if (![dict[@"assignees"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"base"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"body"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"changed_files"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"changed_files"] doubleValue] != [dict[@"changed_files"] longLongValue]) return nil;
        if (dict[@"closed_at"] && [dict[@"closed_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"closed_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"comments"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"comments"] doubleValue] != [dict[@"comments"] longLongValue]) return nil;
        if (![dict[@"comments_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"commits"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"commits"] doubleValue] != [dict[@"commits"] longLongValue]) return nil;
        if (![dict[@"commits_url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"deletions"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"deletions"] doubleValue] != [dict[@"deletions"] longLongValue]) return nil;
        if (![dict[@"diff_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"head"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"locked"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"maintainer_can_modify"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"merged"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"issue_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"_links"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"merge_commit_sha"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"mergeable"]) return nil;
        if (![dict[@"mergeable_state"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"merged_at"] && [dict[@"merged_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"merged_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"merged_by"] isKindOfClass:NSDictionary.class]) return nil;
        if (!dict[@"milestone"]) return nil;
        if (![dict[@"number"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"number"] doubleValue] != [dict[@"number"] longLongValue]) return nil;
        if (![dict[@"patch_url"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"rebaseable"]) return nil;
        if (![dict[@"requested_reviewers"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"review_comment_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"review_comments"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"review_comments"] doubleValue] != [dict[@"review_comments"] longLongValue]) return nil;
        if (![dict[@"review_comments_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"state"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"statuses_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"user"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _base = [QTBase fromJSONDictionary:(id)_base];
        if (!_base && dict[@"base"] && ![dict[@"base"] isKindOfClass:NSNull.class]) return nil;
        _head = [QTBase fromJSONDictionary:(id)_head];
        if (!_head && dict[@"head"] && ![dict[@"head"] isKindOfClass:NSNull.class]) return nil;
        _links = [QTLinks fromJSONDictionary:(id)_links];
        if (!_links && dict[@"_links"] && ![dict[@"_links"] isKindOfClass:NSNull.class]) return nil;
        _mergedBy = [QTUser fromJSONDictionary:(id)_mergedBy];
        if (!_mergedBy && dict[@"merged_by"] && ![dict[@"merged_by"] isKindOfClass:NSNull.class]) return nil;
        _user = [QTUser fromJSONDictionary:(id)_user];
        if (!_user && dict[@"user"] && ![dict[@"user"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPayloadPullRequest.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPayloadPullRequest.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPayloadPullRequest.properties.allValues] mutableCopy];

    for (id jsonName in QTPayloadPullRequest.properties) {
        id propertyName = QTPayloadPullRequest.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"base": [_base JSONDictionary],
        @"head": [_head JSONDictionary],
        @"locked": _isLocked ? @YES : @NO,
        @"maintainer_can_modify": _isMaintainerCanModify ? @YES : @NO,
        @"merged": _isMerged ? @YES : @NO,
        @"_links": [_links JSONDictionary],
        @"merged_by": [_mergedBy JSONDictionary],
        @"user": [_user JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTBase
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"label": @"label",
        @"ref": @"ref",
        @"repo": @"repo",
        @"sha": @"sha",
        @"user": @"user",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBase alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"label"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"ref"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"repo"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sha"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"user"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _repo = [QTBaseRepo fromJSONDictionary:(id)_repo];
        if (!_repo && dict[@"repo"] && ![dict[@"repo"] isKindOfClass:NSNull.class]) return nil;
        _user = [QTUser fromJSONDictionary:(id)_user];
        if (!_user && dict[@"user"] && ![dict[@"user"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBase.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBase.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBase.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"repo": [_repo JSONDictionary],
        @"user": [_user JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTBaseRepo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"archive_url": @"archiveURL",
        @"assignees_url": @"assigneesURL",
        @"blobs_url": @"blobsURL",
        @"branches_url": @"branchesURL",
        @"clone_url": @"cloneURL",
        @"collaborators_url": @"collaboratorsURL",
        @"comments_url": @"commentsURL",
        @"commits_url": @"commitsURL",
        @"compare_url": @"compareURL",
        @"contents_url": @"contentsURL",
        @"contributors_url": @"contributorsURL",
        @"created_at": @"createdAt",
        @"default_branch": @"defaultBranch",
        @"deployments_url": @"deploymentsURL",
        @"downloads_url": @"downloadsURL",
        @"events_url": @"eventsURL",
        @"forks": @"forks",
        @"forks_count": @"forksCount",
        @"forks_url": @"forksURL",
        @"full_name": @"fullName",
        @"git_commits_url": @"gitCommitsURL",
        @"git_refs_url": @"gitRefsURL",
        @"git_tags_url": @"gitTagsURL",
        @"git_url": @"gitURL",
        @"has_downloads": @"hasDownloads",
        @"has_issues": @"hasIssues",
        @"has_pages": @"hasPages",
        @"has_projects": @"hasProjects",
        @"has_wiki": @"hasWiki",
        @"homepage": @"homepage",
        @"hooks_url": @"hooksURL",
        @"html_url": @"htmlURL",
        @"id": @"identifier",
        @"fork": @"isFork",
        @"private": @"isPrivate",
        @"issue_comment_url": @"issueCommentURL",
        @"issue_events_url": @"issueEventsURL",
        @"issues_url": @"issuesURL",
        @"keys_url": @"keysURL",
        @"labels_url": @"labelsURL",
        @"language": @"language",
        @"languages_url": @"languagesURL",
        @"merges_url": @"mergesURL",
        @"milestones_url": @"milestonesURL",
        @"mirror_url": @"mirrorURL",
        @"name": @"name",
        @"notifications_url": @"notificationsURL",
        @"open_issues": @"openIssues",
        @"open_issues_count": @"openIssuesCount",
        @"owner": @"owner",
        @"pulls_url": @"pullsURL",
        @"pushed_at": @"pushedAt",
        @"releases_url": @"releasesURL",
        @"size": @"size",
        @"ssh_url": @"sshURL",
        @"stargazers_count": @"stargazersCount",
        @"stargazers_url": @"stargazersURL",
        @"statuses_url": @"statusesURL",
        @"subscribers_url": @"subscribersURL",
        @"subscription_url": @"subscriptionURL",
        @"svn_url": @"svnURL",
        @"tags_url": @"tagsURL",
        @"teams_url": @"teamsURL",
        @"description": @"theDescription",
        @"trees_url": @"treesURL",
        @"updated_at": @"updatedAt",
        @"url": @"url",
        @"watchers": @"watchers",
        @"watchers_count": @"watchersCount",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBaseRepo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"archive_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"assignees_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"blobs_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"branches_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"clone_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"collaborators_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"comments_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"commits_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"compare_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"contents_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"contributors_url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"default_branch"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"deployments_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"downloads_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"events_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"forks"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"forks"] doubleValue] != [dict[@"forks"] longLongValue]) return nil;
        if (![dict[@"forks_count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"forks_count"] doubleValue] != [dict[@"forks_count"] longLongValue]) return nil;
        if (![dict[@"forks_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"full_name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"git_commits_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"git_refs_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"git_tags_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"git_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"has_downloads"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"has_issues"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"has_pages"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"has_projects"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"has_wiki"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"homepage"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"hooks_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"fork"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"private"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"issue_comment_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"issue_events_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"issues_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"keys_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"labels_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"language"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"languages_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"merges_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"milestones_url"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"mirror_url"]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"notifications_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"open_issues"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"open_issues"] doubleValue] != [dict[@"open_issues"] longLongValue]) return nil;
        if (![dict[@"open_issues_count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"open_issues_count"] doubleValue] != [dict[@"open_issues_count"] longLongValue]) return nil;
        if (![dict[@"owner"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"pulls_url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"pushed_at"] && [dict[@"pushed_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"pushed_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"releases_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"size"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"size"] doubleValue] != [dict[@"size"] longLongValue]) return nil;
        if (![dict[@"ssh_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"stargazers_count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"stargazers_count"] doubleValue] != [dict[@"stargazers_count"] longLongValue]) return nil;
        if (![dict[@"stargazers_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"statuses_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subscribers_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subscription_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"svn_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tags_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"teams_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"trees_url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"watchers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"watchers"] doubleValue] != [dict[@"watchers"] longLongValue]) return nil;
        if (![dict[@"watchers_count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"watchers_count"] doubleValue] != [dict[@"watchers_count"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _owner = [QTUser fromJSONDictionary:(id)_owner];
        if (!_owner && dict[@"owner"] && ![dict[@"owner"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBaseRepo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBaseRepo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBaseRepo.properties.allValues] mutableCopy];

    for (id jsonName in QTBaseRepo.properties) {
        id propertyName = QTBaseRepo.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"has_downloads": _hasDownloads ? @YES : @NO,
        @"has_issues": _hasIssues ? @YES : @NO,
        @"has_pages": _hasPages ? @YES : @NO,
        @"has_projects": _hasProjects ? @YES : @NO,
        @"has_wiki": _hasWiki ? @YES : @NO,
        @"fork": _isFork ? @YES : @NO,
        @"private": _isPrivate ? @YES : @NO,
        @"owner": [_owner JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTLinks
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comments": @"comments",
        @"commits": @"commits",
        @"html": @"html",
        @"issue": @"issue",
        @"review_comment": @"reviewComment",
        @"review_comments": @"reviewComments",
        @"self": @"self",
        @"statuses": @"statuses",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLinks alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"comments"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"commits"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"html"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"issue"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"review_comment"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"review_comments"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"self"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"statuses"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comments = [QTComments fromJSONDictionary:(id)_comments];
        if (!_comments && dict[@"comments"] && ![dict[@"comments"] isKindOfClass:NSNull.class]) return nil;
        _commits = [QTComments fromJSONDictionary:(id)_commits];
        if (!_commits && dict[@"commits"] && ![dict[@"commits"] isKindOfClass:NSNull.class]) return nil;
        _html = [QTComments fromJSONDictionary:(id)_html];
        if (!_html && dict[@"html"] && ![dict[@"html"] isKindOfClass:NSNull.class]) return nil;
        _issue = [QTComments fromJSONDictionary:(id)_issue];
        if (!_issue && dict[@"issue"] && ![dict[@"issue"] isKindOfClass:NSNull.class]) return nil;
        _reviewComment = [QTComments fromJSONDictionary:(id)_reviewComment];
        if (!_reviewComment && dict[@"review_comment"] && ![dict[@"review_comment"] isKindOfClass:NSNull.class]) return nil;
        _reviewComments = [QTComments fromJSONDictionary:(id)_reviewComments];
        if (!_reviewComments && dict[@"review_comments"] && ![dict[@"review_comments"] isKindOfClass:NSNull.class]) return nil;
        _self = [QTComments fromJSONDictionary:(id)_self];
        if (!_self && dict[@"self"] && ![dict[@"self"] isKindOfClass:NSNull.class]) return nil;
        _statuses = [QTComments fromJSONDictionary:(id)_statuses];
        if (!_statuses && dict[@"statuses"] && ![dict[@"statuses"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLinks.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLinks.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLinks.properties.allValues] mutableCopy];

    for (id jsonName in QTLinks.properties) {
        id propertyName = QTLinks.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comments": [_comments JSONDictionary],
        @"commits": [_commits JSONDictionary],
        @"html": [_html JSONDictionary],
        @"issue": [_issue JSONDictionary],
        @"review_comment": [_reviewComment JSONDictionary],
        @"review_comments": [_reviewComments JSONDictionary],
        @"self": [_self JSONDictionary],
        @"statuses": [_statuses JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTComments
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"href": @"href",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTComments alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"href"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTComments.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTComments.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTComments.properties.allValues];
}
@end

@implementation QTTopLevelRepo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelRepo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevelRepo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevelRepo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevelRepo.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevelRepo.properties) {
        id propertyName = QTTopLevelRepo.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
