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

@interface QTDatum (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImages (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDownsized (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDownsizedSmall (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFixedHeight (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLooping (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUser (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMeta (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPagination (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTRating
+ (NSDictionary<NSString *, QTRating *> *)values
{
    static NSDictionary<NSString *, QTRating *> *values;
    return values = values ? values : @{
        @"g": [[QTRating alloc] initWithValue:@"g"],
        @"pg": [[QTRating alloc] initWithValue:@"pg"],
        @"pg-13": [[QTRating alloc] initWithValue:@"pg-13"],
    };
}

+ (QTRating *)g { return QTRating.values[@"g"]; }
+ (QTRating *)pg { return QTRating.values[@"pg"]; }
+ (QTRating *)pg13 { return QTRating.values[@"pg-13"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRating.values[value];
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
        @"gif": [[QTType alloc] initWithValue:@"gif"],
    };
}

+ (QTType *)gif { return QTType.values[@"gif"]; }

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

@implementation QTUsername
+ (NSDictionary<NSString *, QTUsername *> *)values
{
    static NSDictionary<NSString *, QTUsername *> *values;
    return values = values ? values : @{
        @"": [[QTUsername alloc] initWithValue:@""],
        @"mashable": [[QTUsername alloc] initWithValue:@"mashable"],
        @"nba": [[QTUsername alloc] initWithValue:@"nba"],
        @"Originals": [[QTUsername alloc] initWithValue:@"Originals"],
    };
}

+ (QTUsername *)empty { return QTUsername.values[@""]; }
+ (QTUsername *)mashable { return QTUsername.values[@"mashable"]; }
+ (QTUsername *)nba { return QTUsername.values[@"nba"]; }
+ (QTUsername *)originals { return QTUsername.values[@"Originals"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTUsername.values[value];
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
        @"meta": @"meta",
        @"pagination": @"pagination",
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
        if (![dict[@"data"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"meta"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"pagination"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _data = map(_data, λ(id x, [QTDatum fromJSONDictionary:x]));
        _meta = [QTMeta fromJSONDictionary:(id)_meta];
        if (!_meta && dict[@"meta"] && ![dict[@"meta"] isKindOfClass:NSNull.class]) return nil;
        _pagination = [QTPagination fromJSONDictionary:(id)_pagination];
        if (!_pagination && dict[@"pagination"] && ![dict[@"pagination"] isKindOfClass:NSNull.class]) return nil;
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
        @"data": map(_data, λ(id x, [x JSONDictionary])),
        @"meta": [_meta JSONDictionary],
        @"pagination": [_pagination JSONDictionary],
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

@implementation QTDatum
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bitly_gif_url": @"bitlyGIFURL",
        @"bitly_url": @"bitlyURL",
        @"content_url": @"contentURL",
        @"embed_url": @"embedURL",
        @"id": @"identifier",
        @"images": @"images",
        @"import_datetime": @"importDatetime",
        @"is_indexable": @"isIndexable",
        @"rating": @"rating",
        @"slug": @"slug",
        @"source": @"source",
        @"source_post_url": @"sourcePostURL",
        @"source_tld": @"sourceTLD",
        @"trending_datetime": @"trendingDatetime",
        @"type": @"type",
        @"url": @"url",
        @"user": @"user",
        @"username": @"username",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDatum alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"bitly_gif_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"bitly_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"content_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"embed_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"images"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"import_datetime"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"is_indexable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"is_indexable"] doubleValue] != [dict[@"is_indexable"] longLongValue]) return nil;
        if (![dict[@"rating"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"slug"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"source"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"source_post_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"source_tld"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"trending_datetime"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"username"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _images = [QTImages fromJSONDictionary:(id)_images];
        if (!_images && dict[@"images"] && ![dict[@"images"] isKindOfClass:NSNull.class]) return nil;
        _rating = [QTRating withValue:(id)_rating];
        _type = [QTType withValue:(id)_type];
        _user = [QTUser fromJSONDictionary:(id)_user];
        if (!_user && dict[@"user"] && ![dict[@"user"] isKindOfClass:NSNull.class]) return nil;
        _username = [QTUsername withValue:(id)_username];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDatum.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDatum.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDatum.properties.allValues] mutableCopy];

    for (id jsonName in QTDatum.properties) {
        id propertyName = QTDatum.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"images": [_images JSONDictionary],
        @"rating": [_rating value],
        @"type": [_type value],
        @"user": NSNullify([_user isKindOfClass:NSNull.class] ? nil : [_user JSONDictionary]),
        @"username": [_username value],
    }];

    return dict;
}
@end

@implementation QTImages
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"downsized": @"downsized",
        @"downsized_large": @"downsizedLarge",
        @"downsized_medium": @"downsizedMedium",
        @"downsized_small": @"downsizedSmall",
        @"downsized_still": @"downsizedStill",
        @"fixed_height": @"fixedHeight",
        @"fixed_height_downsampled": @"fixedHeightDownsampled",
        @"fixed_height_small": @"fixedHeightSmall",
        @"fixed_height_small_still": @"fixedHeightSmallStill",
        @"fixed_height_still": @"fixedHeightStill",
        @"fixed_width": @"fixedWidth",
        @"fixed_width_downsampled": @"fixedWidthDownsampled",
        @"fixed_width_small": @"fixedWidthSmall",
        @"fixed_width_small_still": @"fixedWidthSmallStill",
        @"fixed_width_still": @"fixedWidthStill",
        @"looping": @"looping",
        @"original": @"original",
        @"original_mp4": @"originalMp4",
        @"original_still": @"originalStill",
        @"preview": @"preview",
        @"preview_gif": @"previewGIF",
        @"preview_webp": @"previewWebp",
        @"480w_still": @"the480WStill",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImages alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"downsized"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"downsized_large"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"downsized_medium"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"downsized_small"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"downsized_still"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_height"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_height_downsampled"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_height_small"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_height_small_still"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_height_still"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_width"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_width_downsampled"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_width_small"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_width_small_still"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed_width_still"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"looping"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"original"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"original_mp4"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"original_still"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"preview"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"preview_gif"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"preview_webp"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _downsized = [QTDownsized fromJSONDictionary:(id)_downsized];
        if (!_downsized && dict[@"downsized"] && ![dict[@"downsized"] isKindOfClass:NSNull.class]) return nil;
        _downsizedLarge = [QTDownsized fromJSONDictionary:(id)_downsizedLarge];
        if (!_downsizedLarge && dict[@"downsized_large"] && ![dict[@"downsized_large"] isKindOfClass:NSNull.class]) return nil;
        _downsizedMedium = [QTDownsized fromJSONDictionary:(id)_downsizedMedium];
        if (!_downsizedMedium && dict[@"downsized_medium"] && ![dict[@"downsized_medium"] isKindOfClass:NSNull.class]) return nil;
        _downsizedSmall = [QTDownsizedSmall fromJSONDictionary:(id)_downsizedSmall];
        if (!_downsizedSmall && dict[@"downsized_small"] && ![dict[@"downsized_small"] isKindOfClass:NSNull.class]) return nil;
        _downsizedStill = [QTDownsized fromJSONDictionary:(id)_downsizedStill];
        if (!_downsizedStill && dict[@"downsized_still"] && ![dict[@"downsized_still"] isKindOfClass:NSNull.class]) return nil;
        _fixedHeight = [QTFixedHeight fromJSONDictionary:(id)_fixedHeight];
        if (!_fixedHeight && dict[@"fixed_height"] && ![dict[@"fixed_height"] isKindOfClass:NSNull.class]) return nil;
        _fixedHeightDownsampled = [QTFixedHeight fromJSONDictionary:(id)_fixedHeightDownsampled];
        if (!_fixedHeightDownsampled && dict[@"fixed_height_downsampled"] && ![dict[@"fixed_height_downsampled"] isKindOfClass:NSNull.class]) return nil;
        _fixedHeightSmall = [QTFixedHeight fromJSONDictionary:(id)_fixedHeightSmall];
        if (!_fixedHeightSmall && dict[@"fixed_height_small"] && ![dict[@"fixed_height_small"] isKindOfClass:NSNull.class]) return nil;
        _fixedHeightSmallStill = [QTDownsized fromJSONDictionary:(id)_fixedHeightSmallStill];
        if (!_fixedHeightSmallStill && dict[@"fixed_height_small_still"] && ![dict[@"fixed_height_small_still"] isKindOfClass:NSNull.class]) return nil;
        _fixedHeightStill = [QTDownsized fromJSONDictionary:(id)_fixedHeightStill];
        if (!_fixedHeightStill && dict[@"fixed_height_still"] && ![dict[@"fixed_height_still"] isKindOfClass:NSNull.class]) return nil;
        _fixedWidth = [QTFixedHeight fromJSONDictionary:(id)_fixedWidth];
        if (!_fixedWidth && dict[@"fixed_width"] && ![dict[@"fixed_width"] isKindOfClass:NSNull.class]) return nil;
        _fixedWidthDownsampled = [QTFixedHeight fromJSONDictionary:(id)_fixedWidthDownsampled];
        if (!_fixedWidthDownsampled && dict[@"fixed_width_downsampled"] && ![dict[@"fixed_width_downsampled"] isKindOfClass:NSNull.class]) return nil;
        _fixedWidthSmall = [QTFixedHeight fromJSONDictionary:(id)_fixedWidthSmall];
        if (!_fixedWidthSmall && dict[@"fixed_width_small"] && ![dict[@"fixed_width_small"] isKindOfClass:NSNull.class]) return nil;
        _fixedWidthSmallStill = [QTDownsized fromJSONDictionary:(id)_fixedWidthSmallStill];
        if (!_fixedWidthSmallStill && dict[@"fixed_width_small_still"] && ![dict[@"fixed_width_small_still"] isKindOfClass:NSNull.class]) return nil;
        _fixedWidthStill = [QTDownsized fromJSONDictionary:(id)_fixedWidthStill];
        if (!_fixedWidthStill && dict[@"fixed_width_still"] && ![dict[@"fixed_width_still"] isKindOfClass:NSNull.class]) return nil;
        _looping = [QTLooping fromJSONDictionary:(id)_looping];
        if (!_looping && dict[@"looping"] && ![dict[@"looping"] isKindOfClass:NSNull.class]) return nil;
        _original = [QTFixedHeight fromJSONDictionary:(id)_original];
        if (!_original && dict[@"original"] && ![dict[@"original"] isKindOfClass:NSNull.class]) return nil;
        _originalMp4 = [QTDownsizedSmall fromJSONDictionary:(id)_originalMp4];
        if (!_originalMp4 && dict[@"original_mp4"] && ![dict[@"original_mp4"] isKindOfClass:NSNull.class]) return nil;
        _originalStill = [QTDownsized fromJSONDictionary:(id)_originalStill];
        if (!_originalStill && dict[@"original_still"] && ![dict[@"original_still"] isKindOfClass:NSNull.class]) return nil;
        _preview = [QTDownsizedSmall fromJSONDictionary:(id)_preview];
        if (!_preview && dict[@"preview"] && ![dict[@"preview"] isKindOfClass:NSNull.class]) return nil;
        _previewGIF = [QTDownsized fromJSONDictionary:(id)_previewGIF];
        if (!_previewGIF && dict[@"preview_gif"] && ![dict[@"preview_gif"] isKindOfClass:NSNull.class]) return nil;
        _previewWebp = [QTDownsized fromJSONDictionary:(id)_previewWebp];
        if (!_previewWebp && dict[@"preview_webp"] && ![dict[@"preview_webp"] isKindOfClass:NSNull.class]) return nil;
        _the480WStill = [QTDownsized fromJSONDictionary:(id)_the480WStill];
        if (!_the480WStill && dict[@"480w_still"] && ![dict[@"480w_still"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTImages.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTImages.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTImages.properties.allValues] mutableCopy];

    for (id jsonName in QTImages.properties) {
        id propertyName = QTImages.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"downsized": [_downsized JSONDictionary],
        @"downsized_large": [_downsizedLarge JSONDictionary],
        @"downsized_medium": [_downsizedMedium JSONDictionary],
        @"downsized_small": [_downsizedSmall JSONDictionary],
        @"downsized_still": [_downsizedStill JSONDictionary],
        @"fixed_height": [_fixedHeight JSONDictionary],
        @"fixed_height_downsampled": [_fixedHeightDownsampled JSONDictionary],
        @"fixed_height_small": [_fixedHeightSmall JSONDictionary],
        @"fixed_height_small_still": [_fixedHeightSmallStill JSONDictionary],
        @"fixed_height_still": [_fixedHeightStill JSONDictionary],
        @"fixed_width": [_fixedWidth JSONDictionary],
        @"fixed_width_downsampled": [_fixedWidthDownsampled JSONDictionary],
        @"fixed_width_small": [_fixedWidthSmall JSONDictionary],
        @"fixed_width_small_still": [_fixedWidthSmallStill JSONDictionary],
        @"fixed_width_still": [_fixedWidthStill JSONDictionary],
        @"looping": [_looping JSONDictionary],
        @"original": [_original JSONDictionary],
        @"original_mp4": [_originalMp4 JSONDictionary],
        @"original_still": [_originalStill JSONDictionary],
        @"preview": [_preview JSONDictionary],
        @"preview_gif": [_previewGIF JSONDictionary],
        @"preview_webp": [_previewWebp JSONDictionary],
        @"480w_still": NSNullify([_the480WStill isKindOfClass:NSNull.class] ? nil : [_the480WStill JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTDownsized
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"height": @"height",
        @"size": @"size",
        @"url": @"url",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDownsized alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"height"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"width"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDownsized.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDownsized.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDownsized.properties.allValues];
}
@end

@implementation QTDownsizedSmall
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"height": @"height",
        @"mp4": @"mp4",
        @"mp4_size": @"mp4Size",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDownsizedSmall alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"height"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mp4"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mp4_size"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"width"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDownsizedSmall.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDownsizedSmall.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDownsizedSmall.properties.allValues] mutableCopy];

    for (id jsonName in QTDownsizedSmall.properties) {
        id propertyName = QTDownsizedSmall.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFixedHeight
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"frames": @"frames",
        @"height": @"height",
        @"mp4": @"mp4",
        @"mp4_size": @"mp4Size",
        @"size": @"size",
        @"hash": @"theHash",
        @"url": @"url",
        @"webp": @"webp",
        @"webp_size": @"webpSize",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFixedHeight alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"height"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"size"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"webp"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"webp_size"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"width"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFixedHeight.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFixedHeight.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFixedHeight.properties.allValues] mutableCopy];

    for (id jsonName in QTFixedHeight.properties) {
        id propertyName = QTFixedHeight.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLooping
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"mp4": @"mp4",
        @"mp4_size": @"mp4Size",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLooping alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"mp4"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mp4_size"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLooping.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLooping.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLooping.properties.allValues] mutableCopy];

    for (id jsonName in QTLooping.properties) {
        id propertyName = QTLooping.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUser
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"avatar_url": @"avatarURL",
        @"banner_url": @"bannerURL",
        @"display_name": @"displayName",
        @"profile_url": @"profileURL",
        @"twitter": @"twitter",
        @"username": @"username",
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
        if (![dict[@"banner_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"display_name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"profile_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"username"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
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

    return dict;
}
@end

@implementation QTMeta
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"msg": @"msg",
        @"response_id": @"responseID",
        @"status": @"status",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMeta alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"msg"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"response_id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"status"] doubleValue] != [dict[@"status"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMeta.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMeta.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMeta.properties.allValues] mutableCopy];

    for (id jsonName in QTMeta.properties) {
        id propertyName = QTMeta.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPagination
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"count": @"count",
        @"offset": @"offset",
        @"total_count": @"totalCount",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPagination alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"count"] doubleValue] != [dict[@"count"] longLongValue]) return nil;
        if (![dict[@"offset"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"offset"] doubleValue] != [dict[@"offset"] longLongValue]) return nil;
        if (![dict[@"total_count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"total_count"] doubleValue] != [dict[@"total_count"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPagination.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPagination.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPagination.properties.allValues] mutableCopy];

    for (id jsonName in QTPagination.properties) {
        id propertyName = QTPagination.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
