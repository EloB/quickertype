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

@interface QTFeature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGeometry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMetadata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTGeometryType
+ (NSDictionary<NSString *, QTGeometryType *> *)values
{
    static NSDictionary<NSString *, QTGeometryType *> *values;
    return values = values ? values : @{
        @"Point": [[QTGeometryType alloc] initWithValue:@"Point"],
    };
}

+ (QTGeometryType *)point { return QTGeometryType.values[@"Point"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGeometryType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMagType
+ (NSDictionary<NSString *, QTMagType *> *)values
{
    static NSDictionary<NSString *, QTMagType *> *values;
    return values = values ? values : @{
        @"md": [[QTMagType alloc] initWithValue:@"md"],
        @"ml": [[QTMagType alloc] initWithValue:@"ml"],
        @"mb": [[QTMagType alloc] initWithValue:@"mb"],
    };
}

+ (QTMagType *)md { return QTMagType.values[@"md"]; }
+ (QTMagType *)ml { return QTMagType.values[@"ml"]; }
+ (QTMagType *)mb { return QTMagType.values[@"mb"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMagType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTStatus
+ (NSDictionary<NSString *, QTStatus *> *)values
{
    static NSDictionary<NSString *, QTStatus *> *values;
    return values = values ? values : @{
        @"automatic": [[QTStatus alloc] initWithValue:@"automatic"],
        @"reviewed": [[QTStatus alloc] initWithValue:@"reviewed"],
    };
}

+ (QTStatus *)automatic { return QTStatus.values[@"automatic"]; }
+ (QTStatus *)reviewed { return QTStatus.values[@"reviewed"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTStatus.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTPropertiesType
+ (NSDictionary<NSString *, QTPropertiesType *> *)values
{
    static NSDictionary<NSString *, QTPropertiesType *> *values;
    return values = values ? values : @{
        @"earthquake": [[QTPropertiesType alloc] initWithValue:@"earthquake"],
    };
}

+ (QTPropertiesType *)earthquake { return QTPropertiesType.values[@"earthquake"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPropertiesType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFeatureType
+ (NSDictionary<NSString *, QTFeatureType *> *)values
{
    static NSDictionary<NSString *, QTFeatureType *> *values;
    return values = values ? values : @{
        @"Feature": [[QTFeatureType alloc] initWithValue:@"Feature"],
    };
}

+ (QTFeatureType *)feature { return QTFeatureType.values[@"Feature"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFeatureType.values[value];
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
        @"bbox": @"bbox",
        @"features": @"features",
        @"metadata": @"metadata",
        @"type": @"type",
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
        if (![dict[@"bbox"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"features"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"metadata"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _features = map(_features, λ(id x, [QTFeature fromJSONDictionary:x]));
        _metadata = [QTMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
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
        @"features": map(_features, λ(id x, [x JSONDictionary])),
        @"metadata": [_metadata JSONDictionary],
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

@implementation QTFeature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"geometry": @"geometry",
        @"id": @"identifier",
        @"properties": @"properties",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFeature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"geometry"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _geometry = [QTGeometry fromJSONDictionary:(id)_geometry];
        if (!_geometry && dict[@"geometry"] && ![dict[@"geometry"] isKindOfClass:NSNull.class]) return nil;
        _properties = [QTProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTFeatureType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFeature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFeature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFeature.properties.allValues] mutableCopy];

    for (id jsonName in QTFeature.properties) {
        id propertyName = QTFeature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"geometry": [_geometry JSONDictionary],
        @"properties": [_properties JSONDictionary],
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTGeometry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"coordinates": @"coordinates",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGeometry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"coordinates"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTGeometryType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGeometry.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGeometry.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGeometry.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"alert": @"alert",
        @"cdi": @"cdi",
        @"code": @"code",
        @"detail": @"detail",
        @"dmin": @"dmin",
        @"felt": @"felt",
        @"gap": @"gap",
        @"ids": @"ids",
        @"mag": @"mag",
        @"magType": @"magType",
        @"mmi": @"mmi",
        @"net": @"net",
        @"nst": @"nst",
        @"place": @"place",
        @"rms": @"rms",
        @"sig": @"sig",
        @"sources": @"sources",
        @"status": @"status",
        @"time": @"time",
        @"title": @"title",
        @"tsunami": @"tsunami",
        @"type": @"type",
        @"types": @"types",
        @"tz": @"tz",
        @"updated": @"updated",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"alert"]) return nil;
        if (!dict[@"cdi"]) return nil;
        if (![dict[@"code"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"detail"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"dmin"]) return nil;
        if (!dict[@"felt"]) return nil;
        if (!dict[@"gap"]) return nil;
        if (![dict[@"ids"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mag"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"magType"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"mmi"]) return nil;
        if (![dict[@"net"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"nst"]) return nil;
        if (![dict[@"place"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"rms"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"sig"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sig"] doubleValue] != [dict[@"sig"] longLongValue]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"time"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"time"] doubleValue] != [dict[@"time"] longLongValue]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tsunami"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tsunami"] doubleValue] != [dict[@"tsunami"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"types"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tz"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tz"] doubleValue] != [dict[@"tz"] longLongValue]) return nil;
        if (![dict[@"updated"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"updated"] doubleValue] != [dict[@"updated"] longLongValue]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _magType = [QTMagType withValue:(id)_magType];
        _status = [QTStatus withValue:(id)_status];
        _type = [QTPropertiesType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTProperties.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"magType": [_magType value],
        @"status": [_status value],
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTMetadata
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"api": @"api",
        @"count": @"count",
        @"generated": @"generated",
        @"status": @"status",
        @"title": @"title",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"api"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"count"] doubleValue] != [dict[@"count"] longLongValue]) return nil;
        if (![dict[@"generated"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"generated"] doubleValue] != [dict[@"generated"] longLongValue]) return nil;
        if (![dict[@"status"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"status"] doubleValue] != [dict[@"status"] longLongValue]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMetadata.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMetadata.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTMetadata.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
