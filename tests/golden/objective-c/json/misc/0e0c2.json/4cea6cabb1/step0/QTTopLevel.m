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

@interface QTResult (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCollection (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDetail (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFavMovie (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImage (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVideo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVoteScore (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTDetailLanguage
+ (NSDictionary<NSString *, QTDetailLanguage *> *)values
{
    static NSDictionary<NSString *, QTDetailLanguage *> *values;
    return values = values ? values : @{
        @"en": [[QTDetailLanguage alloc] initWithValue:@"en"],
        @"th": [[QTDetailLanguage alloc] initWithValue:@"th"],
    };
}

+ (QTDetailLanguage *)en { return QTDetailLanguage.values[@"en"]; }
+ (QTDetailLanguage *)th { return QTDetailLanguage.values[@"th"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTDetailLanguage.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTType
+ (NSDictionary<NSString *, QTType *> *)values
{
    static NSDictionary<NSString *, QTType *> *values;
    return values = values ? values : @{
        @"Poster": [[QTType alloc] initWithValue:@"Poster"],
        @"Backdrop": [[QTType alloc] initWithValue:@"Backdrop"],
    };
}

+ (QTType *)poster { return QTType.values[@"Poster"]; }
+ (QTType *)backdrop { return QTType.values[@"Backdrop"]; }

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

@implementation QTResultLanguage
+ (NSDictionary<NSString *, QTResultLanguage *> *)values
{
    static NSDictionary<NSString *, QTResultLanguage *> *values;
    return values = values ? values : @{
        @"en": [[QTResultLanguage alloc] initWithValue:@"en"],
        @"-": [[QTResultLanguage alloc] initWithValue:@"-"],
    };
}

+ (QTResultLanguage *)en { return QTResultLanguage.values[@"en"]; }
+ (QTResultLanguage *)empty { return QTResultLanguage.values[@"-"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTResultLanguage.values[value];
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
        @"count": @"count",
        @"next": @"next",
        @"previous": @"previous",
        @"results": @"results",
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
        if (![dict[@"count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"count"] doubleValue] != [dict[@"count"] longLongValue]) return nil;
        if (![dict[@"next"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"previous"]) return nil;
        if (![dict[@"results"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _results = map(_results, λ(id x, [QTResult fromJSONDictionary:x]));
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
        @"results": map(_results, λ(id x, [x JSONDictionary])),
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

@implementation QTResult
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"active_screens": @"activeScreens",
        @"collections": @"collections",
        @"details": @"details",
        @"duration": @"duration",
        @"fav_movie": @"favMovie",
        @"id": @"identifier",
        @"images": @"images",
        @"language": @"language",
        @"release_date": @"releaseDate",
        @"stars": @"stars",
        @"tags": @"tags",
        @"title": @"title",
        @"videos": @"videos",
        @"vote_score": @"voteScore",
        @"watches": @"watches",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResult alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"active_screens"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"active_screens"] doubleValue] != [dict[@"active_screens"] longLongValue]) return nil;
        if (![dict[@"collections"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"details"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"duration"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"duration"] doubleValue] != [dict[@"duration"] longLongValue]) return nil;
        if (![dict[@"fav_movie"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"images"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"language"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"release_date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"stars"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"stars"] doubleValue] != [dict[@"stars"] longLongValue]) return nil;
        if (!dict[@"tags"]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"videos"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"vote_score"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"watches"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"watches"] doubleValue] != [dict[@"watches"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _collections = map(_collections, λ(id x, [QTCollection fromJSONDictionary:x]));
        _details = map(_details, λ(id x, [QTDetail fromJSONDictionary:x]));
        _favMovie = [QTFavMovie fromJSONDictionary:(id)_favMovie];
        if (!_favMovie && dict[@"fav_movie"] && ![dict[@"fav_movie"] isKindOfClass:NSNull.class]) return nil;
        _images = map(_images, λ(id x, [QTImage fromJSONDictionary:x]));
        _language = [QTResultLanguage withValue:(id)_language];
        _videos = map(_videos, λ(id x, [QTVideo fromJSONDictionary:x]));
        _voteScore = [QTVoteScore fromJSONDictionary:(id)_voteScore];
        if (!_voteScore && dict[@"vote_score"] && ![dict[@"vote_score"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTResult.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTResult.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTResult.properties.allValues] mutableCopy];

    for (id jsonName in QTResult.properties) {
        id propertyName = QTResult.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"collections": map(_collections, λ(id x, [x JSONDictionary])),
        @"details": map(_details, λ(id x, [x JSONDictionary])),
        @"fav_movie": [_favMovie JSONDictionary],
        @"images": map(_images, λ(id x, [x JSONDictionary])),
        @"language": [_language value],
        @"videos": map(_videos, λ(id x, [x JSONDictionary])),
        @"vote_score": [_voteScore JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCollection
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"movies": @"movies",
        @"name": @"name",
        @"slug": @"slug",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCollection alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"movies"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"slug"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCollection.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCollection.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCollection.properties.allValues] mutableCopy];

    for (id jsonName in QTCollection.properties) {
        id propertyName = QTCollection.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDetail
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"cast": @"cast",
        @"director": @"director",
        @"id": @"identifier",
        @"language": @"language",
        @"storyline": @"storyline",
        @"tagline": @"tagline",
        @"title": @"title",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDetail alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"cast"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"director"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"language"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"storyline"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tagline"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _language = [QTDetailLanguage withValue:(id)_language];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDetail.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDetail.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDetail.properties.allValues] mutableCopy];

    for (id jsonName in QTDetail.properties) {
        id propertyName = QTDetail.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"language": [_language value],
    }];

    return dict;
}
@end

@implementation QTFavMovie
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"follow": @"isFollow",
        @"star": @"isStar",
        @"watched": @"isWatched",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFavMovie alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"follow"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"star"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"watched"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFavMovie.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFavMovie.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFavMovie.properties.allValues] mutableCopy];

    for (id jsonName in QTFavMovie.properties) {
        id propertyName = QTFavMovie.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"follow": _isFollow ? @YES : @NO,
        @"star": _isStar ? @YES : @NO,
        @"watched": _isWatched ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTImage
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"favs": @"favs",
        @"id": @"identifier",
        @"thumbnail": @"thumbnail",
        @"type": @"type",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImage alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"favs"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"favs"] doubleValue] != [dict[@"favs"] longLongValue]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"thumbnail"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTType withValue:(id)_type];
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
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTVideo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"kind": @"kind",
        @"language": @"language",
        @"source": @"source",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVideo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"kind"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"language"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"source"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _language = [QTResultLanguage withValue:(id)_language];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVideo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVideo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVideo.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"language": [_language value],
    }];

    return dict;
}
@end

@implementation QTVoteScore
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"avg": @"avg",
        @"score": @"score",
        @"total": @"total",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVoteScore alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"avg"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"avg"] doubleValue] != [dict[@"avg"] longLongValue]) return nil;
        if (![dict[@"score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"score"] doubleValue] != [dict[@"score"] longLongValue]) return nil;
        if (![dict[@"total"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"total"] doubleValue] != [dict[@"total"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVoteScore.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVoteScore.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTVoteScore.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
