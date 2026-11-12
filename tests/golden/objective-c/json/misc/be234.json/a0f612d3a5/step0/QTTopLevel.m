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

@interface QTMedia (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOembed (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMediaEmbed (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPreview (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImage (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSource (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVariants (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGIF (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTDomain
+ (NSDictionary<NSString *, QTDomain *> *)values
{
    static NSDictionary<NSString *, QTDomain *> *values;
    return values = values ? values : @{
        @"reddit.com": [[QTDomain alloc] initWithValue:@"reddit.com"],
        @"i.redd.it": [[QTDomain alloc] initWithValue:@"i.redd.it"],
        @"i.imgur.com": [[QTDomain alloc] initWithValue:@"i.imgur.com"],
        @"gfycat.com": [[QTDomain alloc] initWithValue:@"gfycat.com"],
        @"imgur.com": [[QTDomain alloc] initWithValue:@"imgur.com"],
    };
}

+ (QTDomain *)redditCOM { return QTDomain.values[@"reddit.com"]; }
+ (QTDomain *)iReddIt { return QTDomain.values[@"i.redd.it"]; }
+ (QTDomain *)iImgurCOM { return QTDomain.values[@"i.imgur.com"]; }
+ (QTDomain *)gfycatCOM { return QTDomain.values[@"gfycat.com"]; }
+ (QTDomain *)imgurCOM { return QTDomain.values[@"imgur.com"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTDomain.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTPostHint
+ (NSDictionary<NSString *, QTPostHint *> *)values
{
    static NSDictionary<NSString *, QTPostHint *> *values;
    return values = values ? values : @{
        @"link": [[QTPostHint alloc] initWithValue:@"link"],
        @"image": [[QTPostHint alloc] initWithValue:@"image"],
        @"rich:video": [[QTPostHint alloc] initWithValue:@"rich:video"],
    };
}

+ (QTPostHint *)link { return QTPostHint.values[@"link"]; }
+ (QTPostHint *)image { return QTPostHint.values[@"image"]; }
+ (QTPostHint *)richVideo { return QTPostHint.values[@"rich:video"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPostHint.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSubreddit
+ (NSDictionary<NSString *, QTSubreddit *> *)values
{
    static NSDictionary<NSString *, QTSubreddit *> *values;
    return values = values ? values : @{
        @"funny": [[QTSubreddit alloc] initWithValue:@"funny"],
    };
}

+ (QTSubreddit *)funny { return QTSubreddit.values[@"funny"]; }

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
        @"t5_2qh33": [[QTSubredditID alloc] initWithValue:@"t5_2qh33"],
    };
}

+ (QTSubredditID *)t52Qh33 { return QTSubredditID.values[@"t5_2qh33"]; }

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
        @"r/funny": [[QTSubredditNamePrefixed alloc] initWithValue:@"r/funny"],
    };
}

+ (QTSubredditNamePrefixed *)rFunny { return QTSubredditNamePrefixed.values[@"r/funny"]; }

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
        @"post_hint": @"postHint",
        @"preview": @"preview",
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
        @"thumbnail_height": @"thumbnailHeight",
        @"thumbnail_width": @"thumbnailWidth",
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
        if (![dict[@"post_hint"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"preview"] isKindOfClass:NSDictionary.class]) return nil;
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
        if (![dict[@"thumbnail_height"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"thumbnail_height"] doubleValue] != [dict[@"thumbnail_height"] longLongValue]) return nil;
        if (![dict[@"thumbnail_width"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"thumbnail_width"] doubleValue] != [dict[@"thumbnail_width"] longLongValue]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"ups"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ups"] doubleValue] != [dict[@"ups"] longLongValue]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"user_reports"] isKindOfClass:NSArray.class]) return nil;
        if (!dict[@"view_count"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _domain = [QTDomain withValue:(id)_domain];
        _media = [QTMedia fromJSONDictionary:(id)_media];
        if (!_media && dict[@"media"] && ![dict[@"media"] isKindOfClass:NSNull.class]) return nil;
        _mediaEmbed = [QTMediaEmbed fromJSONDictionary:(id)_mediaEmbed];
        if (!_mediaEmbed && dict[@"media_embed"] && ![dict[@"media_embed"] isKindOfClass:NSNull.class]) return nil;
        _postHint = [QTPostHint withValue:(id)_postHint];
        _preview = [QTPreview fromJSONDictionary:(id)_preview];
        if (!_preview && dict[@"preview"] && ![dict[@"preview"] isKindOfClass:NSNull.class]) return nil;
        _secureMedia = [QTMedia fromJSONDictionary:(id)_secureMedia];
        if (!_secureMedia && dict[@"secure_media"] && ![dict[@"secure_media"] isKindOfClass:NSNull.class]) return nil;
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
        @"domain": [_domain value],
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
        @"media": NSNullify([_media isKindOfClass:NSNull.class] ? nil : [_media JSONDictionary]),
        @"media_embed": [_mediaEmbed JSONDictionary],
        @"post_hint": [_postHint value],
        @"preview": [_preview JSONDictionary],
        @"secure_media": NSNullify([_secureMedia isKindOfClass:NSNull.class] ? nil : [_secureMedia JSONDictionary]),
        @"secure_media_embed": [_secureMediaEmbed JSONDictionary],
        @"subreddit": [_subreddit value],
        @"subreddit_id": [_subredditID value],
        @"subreddit_name_prefixed": [_subredditNamePrefixed value],
        @"subreddit_type": [_subredditType value],
    }];

    return dict;
}
@end

@implementation QTMedia
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"oembed": @"oembed",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMedia alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"oembed"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _oembed = [QTOembed fromJSONDictionary:(id)_oembed];
        if (!_oembed && dict[@"oembed"] && ![dict[@"oembed"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTDomain withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMedia.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMedia.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMedia.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"oembed": [_oembed JSONDictionary],
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTOembed
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"height": @"height",
        @"html": @"html",
        @"provider_name": @"providerName",
        @"provider_url": @"providerURL",
        @"description": @"theDescription",
        @"thumbnail_height": @"thumbnailHeight",
        @"thumbnail_url": @"thumbnailURL",
        @"thumbnail_width": @"thumbnailWidth",
        @"title": @"title",
        @"type": @"type",
        @"version": @"version",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOembed alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"height"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"height"] doubleValue] != [dict[@"height"] longLongValue]) return nil;
        if (![dict[@"html"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"provider_name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"provider_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"thumbnail_height"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"thumbnail_height"] doubleValue] != [dict[@"thumbnail_height"] longLongValue]) return nil;
        if (![dict[@"thumbnail_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"thumbnail_width"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"thumbnail_width"] doubleValue] != [dict[@"thumbnail_width"] longLongValue]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"version"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"width"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"width"] doubleValue] != [dict[@"width"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOembed.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOembed.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOembed.properties.allValues] mutableCopy];

    for (id jsonName in QTOembed.properties) {
        id propertyName = QTOembed.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTMediaEmbed
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"content": @"content",
        @"height": @"height",
        @"scrolling": @"scrolling",
        @"width": @"width",
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

@implementation QTPreview
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"images": @"images",
        @"enabled": @"isEnabled",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPreview alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"images"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"enabled"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _images = map(_images, λ(id x, [QTImage fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPreview.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPreview.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPreview.properties.allValues] mutableCopy];

    for (id jsonName in QTPreview.properties) {
        id propertyName = QTPreview.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"images": map(_images, λ(id x, [x JSONDictionary])),
        @"enabled": _isEnabled ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTImage
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"resolutions": @"resolutions",
        @"source": @"source",
        @"variants": @"variants",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImage alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"resolutions"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"source"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"variants"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _resolutions = map(_resolutions, λ(id x, [QTSource fromJSONDictionary:x]));
        _source = [QTSource fromJSONDictionary:(id)_source];
        if (!_source && dict[@"source"] && ![dict[@"source"] isKindOfClass:NSNull.class]) return nil;
        _variants = [QTVariants fromJSONDictionary:(id)_variants];
        if (!_variants && dict[@"variants"] && ![dict[@"variants"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTImage.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTImage.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTImage.properties.allValues] mutableCopy];

    for (id jsonName in QTImage.properties) {
        id propertyName = QTImage.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"resolutions": map(_resolutions, λ(id x, [x JSONDictionary])),
        @"source": [_source JSONDictionary],
        @"variants": [_variants JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTSource
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"height": @"height",
        @"url": @"url",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSource alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"height"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"height"] doubleValue] != [dict[@"height"] longLongValue]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"width"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"width"] doubleValue] != [dict[@"width"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSource.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSource.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSource.properties.allValues];
}
@end

@implementation QTVariants
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"gif": @"gif",
        @"mp4": @"mp4",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVariants alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _gif = [QTGIF fromJSONDictionary:(id)_gif];
        if (!_gif && dict[@"gif"] && ![dict[@"gif"] isKindOfClass:NSNull.class]) return nil;
        _mp4 = [QTGIF fromJSONDictionary:(id)_mp4];
        if (!_mp4 && dict[@"mp4"] && ![dict[@"mp4"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVariants.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVariants.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVariants.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"gif": NSNullify([_gif isKindOfClass:NSNull.class] ? nil : [_gif JSONDictionary]),
        @"mp4": NSNullify([_mp4 isKindOfClass:NSNull.class] ? nil : [_mp4 JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTGIF
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"resolutions": @"resolutions",
        @"source": @"source",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGIF alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"resolutions"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"source"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _resolutions = map(_resolutions, λ(id x, [QTSource fromJSONDictionary:x]));
        _source = [QTSource fromJSONDictionary:(id)_source];
        if (!_source && dict[@"source"] && ![dict[@"source"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGIF.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGIF.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGIF.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"resolutions": map(_resolutions, λ(id x, [x JSONDictionary])),
        @"source": [_source JSONDictionary],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
