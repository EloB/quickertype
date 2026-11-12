#import "QTTopLevel.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTTopLevel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTopLevelData (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChildData (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMediaEmbed (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTSubreddit
+ (NSDictionary<NSString *, QTSubreddit *> *)values
{
    static NSDictionary<NSString *, QTSubreddit *> *values;
    return values = values ? values : @{
        @"worldnews": [[QTSubreddit alloc] initWithValue:@"worldnews"],
    };
}

+ (QTSubreddit *)worldnews { return QTSubreddit.values[@"worldnews"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSubreddit.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSubredditID
+ (NSDictionary<NSString *, QTSubredditID *> *)values
{
    static NSDictionary<NSString *, QTSubredditID *> *values;
    return values = values ? values : @{
        @"t5_2qh13": [[QTSubredditID alloc] initWithValue:@"t5_2qh13"],
    };
}

+ (QTSubredditID *)t52Qh13 { return QTSubredditID.values[@"t5_2qh13"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSubredditID.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSubredditNamePrefixed
+ (NSDictionary<NSString *, QTSubredditNamePrefixed *> *)values
{
    static NSDictionary<NSString *, QTSubredditNamePrefixed *> *values;
    return values = values ? values : @{
        @"r/worldnews": [[QTSubredditNamePrefixed alloc] initWithValue:@"r/worldnews"],
    };
}

+ (QTSubredditNamePrefixed *)rWorldnews { return QTSubredditNamePrefixed.values[@"r/worldnews"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSubredditNamePrefixed.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSubredditType
+ (NSDictionary<NSString *, QTSubredditType *> *)values
{
    static NSDictionary<NSString *, QTSubredditType *> *values;
    return values = values ? values : @{
        @"public": [[QTSubredditType alloc] initWithValue:@"public"],
    };
}

+ (QTSubredditType *)public { return QTSubredditType.values[@"public"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSubredditType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTKind
+ (NSDictionary<NSString *, QTKind *> *)values
{
    static NSDictionary<NSString *, QTKind *> *values;
    return values = values ? values : @{
        @"t3": [[QTKind alloc] initWithValue:@"t3"],
    };
}

+ (QTKind *)t3 { return QTKind.values[@"t3"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTKind.values[value];
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
        return *error ? nil : [QTTopLevel fromJSONDictionary:json];
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
        id json = [topLevel JSONDictionary];
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

@implementation QTTopLevel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"data": @"data",
        @"kind": @"kind",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return QTTopLevelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"data"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _data = [QTTopLevelData fromJSONDictionary:(id)_data];
        if (!_data && dict[@"data"] && ![dict[@"data"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevel.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"data": [_data JSONDictionary],
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return QTTopLevelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelToJSON(self, encoding, error);
}
@end

@implementation QTTopLevelData
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"after": @"after",
        @"before": @"before",
        @"children": @"children",
        @"modhash": @"modhash",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelData alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"after"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"before"]) return nil;
        if (![dict[@"children"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"modhash"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTChild fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevelData.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevelData.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevelData.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"children": map(_children, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"data": @"data",
        @"kind": @"kind",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"data"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _data = [QTChildData fromJSONDictionary:(id)_data];
        if (!_data && dict[@"data"] && ![dict[@"data"] isKindOfClass:NSNull.class]) return nil;
        _kind = [QTKind withValue:(id)_kind];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChild.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"data": [_data JSONDictionary],
        @"kind": [_kind value],
    }];

    return dict;
}
@end

@implementation QTChildData
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"approved_at_utc": @"approvedAtUTC",
        @"approved_by": @"approvedBy",
        @"author": @"author",
        @"author_flair_css_class": @"authorFlairCSSClass",
        @"author_flair_text": @"authorFlairText",
        @"banned_at_utc": @"bannedAtUTC",
        @"banned_by": @"bannedBy",
        @"created": @"created",
        @"created_utc": @"createdUTC",
        @"distinguished": @"distinguished",
        @"domain": @"domain",
        @"downs": @"downs",
        @"gilded": @"gilded",
        @"id": @"identifier",
        @"archived": @"isArchived",
        @"brand_safe": @"isBrandSafe",
        @"can_gild": @"isCanGild",
        @"can_mod_post": @"isCanModPost",
        @"clicked": @"isClicked",
        @"contest_mode": @"isContestMode",
        @"edited": @"isEdited",
        @"hidden": @"isHidden",
        @"hide_score": @"isHideScore",
        @"locked": @"isLocked",
        @"over_18": @"isOver18",
        @"quarantine": @"isQuarantine",
        @"saved": @"isSaved",
        @"is_self": @"isSelf",
        @"spoiler": @"isSpoiler",
        @"stickied": @"isStickied",
        @"is_video": @"isVideo",
        @"visited": @"isVisited",
        @"likes": @"likes",
        @"link_flair_css_class": @"linkFlairCSSClass",
        @"link_flair_text": @"linkFlairText",
        @"media": @"media",
        @"media_embed": @"mediaEmbed",
        @"mod_reports": @"modReports",
        @"name": @"name",
        @"num_comments": @"numComments",
        @"num_reports": @"numReports",
        @"permalink": @"permalink",
        @"removal_reason": @"removalReason",
        @"report_reasons": @"reportReasons",
        @"score": @"score",
        @"secure_media": @"secureMedia",
        @"secure_media_embed": @"secureMediaEmbed",
        @"selftext": @"selftext",
        @"selftext_html": @"selftextHTML",
        @"subreddit": @"subreddit",
        @"subreddit_id": @"subredditID",
        @"subreddit_name_prefixed": @"subredditNamePrefixed",
        @"subreddit_type": @"subredditType",
        @"suggested_sort": @"suggestedSort",
        @"thumbnail": @"thumbnail",
        @"title": @"title",
        @"ups": @"ups",
        @"url": @"url",
        @"user_reports": @"userReports",
        @"view_count": @"viewCount",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChildData alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"approved_at_utc"]) return nil;
        if (!dict[@"approved_by"]) return nil;
        if (![dict[@"author"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"author_flair_css_class"]) return nil;
        if (!dict[@"author_flair_text"]) return nil;
        if (!dict[@"banned_at_utc"]) return nil;
        if (!dict[@"banned_by"]) return nil;
        if (![dict[@"created"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"created_utc"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"distinguished"]) return nil;
        if (![dict[@"domain"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"downs"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"downs"] doubleValue] != [dict[@"downs"] longLongValue]) return nil;
        if (![dict[@"gilded"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"gilded"] doubleValue] != [dict[@"gilded"] longLongValue]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"archived"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"brand_safe"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"can_gild"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"can_mod_post"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"clicked"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"contest_mode"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"edited"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"hidden"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"hide_score"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"locked"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"over_18"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"quarantine"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"saved"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"is_self"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"spoiler"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"stickied"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"is_video"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"visited"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"likes"]) return nil;
        if (!dict[@"link_flair_css_class"]) return nil;
        if (!dict[@"link_flair_text"]) return nil;
        if (!dict[@"media"]) return nil;
        if (![dict[@"media_embed"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"mod_reports"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"num_comments"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"num_comments"] doubleValue] != [dict[@"num_comments"] longLongValue]) return nil;
        if (!dict[@"num_reports"]) return nil;
        if (![dict[@"permalink"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"removal_reason"]) return nil;
        if (!dict[@"report_reasons"]) return nil;
        if (![dict[@"score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"score"] doubleValue] != [dict[@"score"] longLongValue]) return nil;
        if (!dict[@"secure_media"]) return nil;
        if (![dict[@"secure_media_embed"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"selftext"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"selftext_html"]) return nil;
        if (![dict[@"subreddit"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subreddit_id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subreddit_name_prefixed"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subreddit_type"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"suggested_sort"]) return nil;
        if (![dict[@"thumbnail"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"ups"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ups"] doubleValue] != [dict[@"ups"] longLongValue]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"user_reports"] isKindOfClass:NSArray.class]) return nil;
        if (!dict[@"view_count"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _mediaEmbed = [QTMediaEmbed fromJSONDictionary:(id)_mediaEmbed];
        if (!_mediaEmbed && dict[@"media_embed"] && ![dict[@"media_embed"] isKindOfClass:NSNull.class]) return nil;
        _secureMediaEmbed = [QTMediaEmbed fromJSONDictionary:(id)_secureMediaEmbed];
        if (!_secureMediaEmbed && dict[@"secure_media_embed"] && ![dict[@"secure_media_embed"] isKindOfClass:NSNull.class]) return nil;
        _subreddit = [QTSubreddit withValue:(id)_subreddit];
        _subredditID = [QTSubredditID withValue:(id)_subredditID];
        _subredditNamePrefixed = [QTSubredditNamePrefixed withValue:(id)_subredditNamePrefixed];
        _subredditType = [QTSubredditType withValue:(id)_subredditType];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChildData.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChildData.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChildData.properties.allValues] mutableCopy];

    for (id jsonName in QTChildData.properties) {
        id propertyName = QTChildData.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"archived": _isArchived ? @YES : @NO,
        @"brand_safe": _isBrandSafe ? @YES : @NO,
        @"can_gild": _isCanGild ? @YES : @NO,
        @"can_mod_post": _isCanModPost ? @YES : @NO,
        @"clicked": _isClicked ? @YES : @NO,
        @"contest_mode": _isContestMode ? @YES : @NO,
        @"edited": _isEdited ? @YES : @NO,
        @"hidden": _isHidden ? @YES : @NO,
        @"hide_score": _isHideScore ? @YES : @NO,
        @"locked": _isLocked ? @YES : @NO,
        @"over_18": _isOver18 ? @YES : @NO,
        @"quarantine": _isQuarantine ? @YES : @NO,
        @"saved": _isSaved ? @YES : @NO,
        @"is_self": _isSelf ? @YES : @NO,
        @"spoiler": _isSpoiler ? @YES : @NO,
        @"stickied": _isStickied ? @YES : @NO,
        @"is_video": _isVideo ? @YES : @NO,
        @"visited": _isVisited ? @YES : @NO,
        @"media_embed": [_mediaEmbed JSONDictionary],
        @"secure_media_embed": [_secureMediaEmbed JSONDictionary],
        @"subreddit": [_subreddit value],
        @"subreddit_id": [_subredditID value],
        @"subreddit_name_prefixed": [_subredditNamePrefixed value],
        @"subreddit_type": [_subredditType value],
    }];

    return dict;
}
@end

@implementation QTMediaEmbed
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMediaEmbed alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMediaEmbed.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMediaEmbed.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTMediaEmbed.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
