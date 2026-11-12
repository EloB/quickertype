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

@interface QTArtist (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExternalUrls (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCopyright (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExternalIDS (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImage (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTracks (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTItem (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
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
        @"album_type": @"albumType",
        @"artists": @"artists",
        @"available_markets": @"availableMarkets",
        @"copyrights": @"copyrights",
        @"external_ids": @"externalIDS",
        @"external_urls": @"externalUrls",
        @"genres": @"genres",
        @"href": @"href",
        @"id": @"identifier",
        @"images": @"images",
        @"name": @"name",
        @"popularity": @"popularity",
        @"release_date": @"releaseDate",
        @"release_date_precision": @"releaseDatePrecision",
        @"tracks": @"tracks",
        @"type": @"type",
        @"uri": @"uri",
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
        if (![dict[@"album_type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"artists"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"available_markets"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"copyrights"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"external_ids"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"external_urls"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"genres"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"href"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"images"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"popularity"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"popularity"] doubleValue] != [dict[@"popularity"] longLongValue]) return nil;
        if (![dict[@"release_date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"release_date_precision"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tracks"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"uri"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _artists = map(_artists, λ(id x, [QTArtist fromJSONDictionary:x]));
        _copyrights = map(_copyrights, λ(id x, [QTCopyright fromJSONDictionary:x]));
        _externalIDS = [QTExternalIDS fromJSONDictionary:(id)_externalIDS];
        if (!_externalIDS && dict[@"external_ids"] && ![dict[@"external_ids"] isKindOfClass:NSNull.class]) return nil;
        _externalUrls = [QTExternalUrls fromJSONDictionary:(id)_externalUrls];
        if (!_externalUrls && dict[@"external_urls"] && ![dict[@"external_urls"] isKindOfClass:NSNull.class]) return nil;
        _images = map(_images, λ(id x, [QTImage fromJSONDictionary:x]));
        _tracks = [QTTracks fromJSONDictionary:(id)_tracks];
        if (!_tracks && dict[@"tracks"] && ![dict[@"tracks"] isKindOfClass:NSNull.class]) return nil;
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

    for (id jsonName in QTTopLevel.properties) {
        id propertyName = QTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"artists": map(_artists, λ(id x, [x JSONDictionary])),
        @"copyrights": map(_copyrights, λ(id x, [x JSONDictionary])),
        @"external_ids": [_externalIDS JSONDictionary],
        @"external_urls": [_externalUrls JSONDictionary],
        @"images": map(_images, λ(id x, [x JSONDictionary])),
        @"tracks": [_tracks JSONDictionary],
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

@implementation QTArtist
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"external_urls": @"externalUrls",
        @"href": @"href",
        @"id": @"identifier",
        @"name": @"name",
        @"type": @"type",
        @"uri": @"uri",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTArtist alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"external_urls"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"href"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"uri"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _externalUrls = [QTExternalUrls fromJSONDictionary:(id)_externalUrls];
        if (!_externalUrls && dict[@"external_urls"] && ![dict[@"external_urls"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTArtist.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTArtist.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTArtist.properties.allValues] mutableCopy];

    for (id jsonName in QTArtist.properties) {
        id propertyName = QTArtist.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"external_urls": [_externalUrls JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTExternalUrls
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"spotify": @"spotify",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExternalUrls alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"spotify"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExternalUrls.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExternalUrls.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExternalUrls.properties.allValues];
}
@end

@implementation QTCopyright
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"text": @"text",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCopyright alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"text"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCopyright.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCopyright.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCopyright.properties.allValues];
}
@end

@implementation QTExternalIDS
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"upc": @"upc",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExternalIDS alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"upc"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExternalIDS.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExternalIDS.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExternalIDS.properties.allValues];
}
@end

@implementation QTImage
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
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImage alloc] initWithJSONDictionary:dict] : nil;
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
    return [self dictionaryWithValuesForKeys:QTImage.properties.allValues];
}
@end

@implementation QTTracks
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"href": @"href",
        @"items": @"items",
        @"limit": @"limit",
        @"next": @"next",
        @"offset": @"offset",
        @"previous": @"previous",
        @"total": @"total",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTracks alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"href"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"items"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"limit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"limit"] doubleValue] != [dict[@"limit"] longLongValue]) return nil;
        if (!dict[@"next"]) return nil;
        if (![dict[@"offset"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"offset"] doubleValue] != [dict[@"offset"] longLongValue]) return nil;
        if (!dict[@"previous"]) return nil;
        if (![dict[@"total"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"total"] doubleValue] != [dict[@"total"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _items = map(_items, λ(id x, [QTItem fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTracks.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTracks.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTracks.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"items": map(_items, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTItem
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"artists": @"artists",
        @"available_markets": @"availableMarkets",
        @"disc_number": @"discNumber",
        @"duration_ms": @"durationMS",
        @"external_urls": @"externalUrls",
        @"href": @"href",
        @"id": @"identifier",
        @"explicit": @"isExplicit",
        @"name": @"name",
        @"preview_url": @"previewURL",
        @"track_number": @"trackNumber",
        @"type": @"type",
        @"uri": @"uri",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTItem alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"artists"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"available_markets"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"disc_number"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"disc_number"] doubleValue] != [dict[@"disc_number"] longLongValue]) return nil;
        if (![dict[@"duration_ms"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"duration_ms"] doubleValue] != [dict[@"duration_ms"] longLongValue]) return nil;
        if (![dict[@"external_urls"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"href"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"explicit"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"preview_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"track_number"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"track_number"] doubleValue] != [dict[@"track_number"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"uri"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _artists = map(_artists, λ(id x, [QTArtist fromJSONDictionary:x]));
        _externalUrls = [QTExternalUrls fromJSONDictionary:(id)_externalUrls];
        if (!_externalUrls && dict[@"external_urls"] && ![dict[@"external_urls"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTItem.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTItem.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTItem.properties.allValues] mutableCopy];

    for (id jsonName in QTItem.properties) {
        id propertyName = QTItem.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"artists": map(_artists, λ(id x, [x JSONDictionary])),
        @"external_urls": [_externalUrls JSONDictionary],
        @"explicit": _isExplicit ? @YES : @NO,
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
