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

@interface QTCRS (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCRSProperties (JSONConversion)
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

@interface QTFeatureProperties (JSONConversion)
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

@implementation QTGeometryName
+ (NSDictionary<NSString *, QTGeometryName *> *)values
{
    static NSDictionary<NSString *, QTGeometryName *> *values;
    return values = values ? values : @{
        @"geom": [[QTGeometryName alloc] initWithValue:@"geom"],
    };
}

+ (QTGeometryName *)geom { return QTGeometryName.values[@"geom"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGeometryName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFireBanR
+ (NSDictionary<NSString *, QTFireBanR *> *)values
{
    static NSDictionary<NSString *, QTFireBanR *> *values;
    return values = values ? values : @{
        @"North Central": [[QTFireBanR alloc] initWithValue:@"North Central"],
        @"Central": [[QTFireBanR alloc] initWithValue:@"Central"],
        @"South West": [[QTFireBanR alloc] initWithValue:@"South West"],
        @"Wimmera": [[QTFireBanR alloc] initWithValue:@"Wimmera"],
        @"Northern Country": [[QTFireBanR alloc] initWithValue:@"Northern Country"],
        @"East Gippsland": [[QTFireBanR alloc] initWithValue:@"East Gippsland"],
        @"North East": [[QTFireBanR alloc] initWithValue:@"North East"],
        @"Mallee": [[QTFireBanR alloc] initWithValue:@"Mallee"],
        @"West &South Gippsland": [[QTFireBanR alloc] initWithValue:@"West &South Gippsland"],
        @"Ballarat": [[QTFireBanR alloc] initWithValue:@"Ballarat"],
    };
}

+ (QTFireBanR *)northCentral { return QTFireBanR.values[@"North Central"]; }
+ (QTFireBanR *)central { return QTFireBanR.values[@"Central"]; }
+ (QTFireBanR *)southWest { return QTFireBanR.values[@"South West"]; }
+ (QTFireBanR *)wimmera { return QTFireBanR.values[@"Wimmera"]; }
+ (QTFireBanR *)northernCountry { return QTFireBanR.values[@"Northern Country"]; }
+ (QTFireBanR *)eastGippsland { return QTFireBanR.values[@"East Gippsland"]; }
+ (QTFireBanR *)northEast { return QTFireBanR.values[@"North East"]; }
+ (QTFireBanR *)mallee { return QTFireBanR.values[@"Mallee"]; }
+ (QTFireBanR *)westSouthGippsland { return QTFireBanR.values[@"West &South Gippsland"]; }
+ (QTFireBanR *)ballarat { return QTFireBanR.values[@"Ballarat"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFireBanR.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRegion
+ (NSDictionary<NSString *, QTRegion *> *)values
{
    static NSDictionary<NSString *, QTRegion *> *values;
    return values = values ? values : @{
        @"Eastern": [[QTRegion alloc] initWithValue:@"Eastern"],
        @"Northern Metro": [[QTRegion alloc] initWithValue:@"Northern Metro"],
        @"Western": [[QTRegion alloc] initWithValue:@"Western"],
        @"Southern Metro": [[QTRegion alloc] initWithValue:@"Southern Metro"],
    };
}

+ (QTRegion *)eastern { return QTRegion.values[@"Eastern"]; }
+ (QTRegion *)northernMetro { return QTRegion.values[@"Northern Metro"]; }
+ (QTRegion *)western { return QTRegion.values[@"Western"]; }
+ (QTRegion *)southernMetro { return QTRegion.values[@"Southern Metro"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRegion.values[value];
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
        @"STREET": [[QTPropertiesType alloc] initWithValue:@"STREET"],
        @"AVENUE": [[QTPropertiesType alloc] initWithValue:@"AVENUE"],
        @"ROAD": [[QTPropertiesType alloc] initWithValue:@"ROAD"],
        @"HIGHWAY": [[QTPropertiesType alloc] initWithValue:@"HIGHWAY"],
        @"BOULEVARD": [[QTPropertiesType alloc] initWithValue:@"BOULEVARD"],
        @"COURT": [[QTPropertiesType alloc] initWithValue:@"COURT"],
        @"WAY": [[QTPropertiesType alloc] initWithValue:@"WAY"],
        @"DRIVE": [[QTPropertiesType alloc] initWithValue:@"DRIVE"],
        @"SOUTH": [[QTPropertiesType alloc] initWithValue:@"SOUTH"],
        @"HILL": [[QTPropertiesType alloc] initWithValue:@"HILL"],
        @"LANE": [[QTPropertiesType alloc] initWithValue:@"LANE"],
        @"CLOSE": [[QTPropertiesType alloc] initWithValue:@"CLOSE"],
        @"PARADE": [[QTPropertiesType alloc] initWithValue:@"PARADE"],
        @"Road": [[QTPropertiesType alloc] initWithValue:@"Road"],
        @"PLACE": [[QTPropertiesType alloc] initWithValue:@"PLACE"],
        @"RD": [[QTPropertiesType alloc] initWithValue:@"RD"],
    };
}

+ (QTPropertiesType *)street { return QTPropertiesType.values[@"STREET"]; }
+ (QTPropertiesType *)avenue { return QTPropertiesType.values[@"AVENUE"]; }
+ (QTPropertiesType *)road { return QTPropertiesType.values[@"ROAD"]; }
+ (QTPropertiesType *)highway { return QTPropertiesType.values[@"HIGHWAY"]; }
+ (QTPropertiesType *)boulevard { return QTPropertiesType.values[@"BOULEVARD"]; }
+ (QTPropertiesType *)court { return QTPropertiesType.values[@"COURT"]; }
+ (QTPropertiesType *)way { return QTPropertiesType.values[@"WAY"]; }
+ (QTPropertiesType *)drive { return QTPropertiesType.values[@"DRIVE"]; }
+ (QTPropertiesType *)south { return QTPropertiesType.values[@"SOUTH"]; }
+ (QTPropertiesType *)hill { return QTPropertiesType.values[@"HILL"]; }
+ (QTPropertiesType *)lane { return QTPropertiesType.values[@"LANE"]; }
+ (QTPropertiesType *)close { return QTPropertiesType.values[@"CLOSE"]; }
+ (QTPropertiesType *)parade { return QTPropertiesType.values[@"PARADE"]; }
+ (QTPropertiesType *)typeRoad { return QTPropertiesType.values[@"Road"]; }
+ (QTPropertiesType *)place { return QTPropertiesType.values[@"PLACE"]; }
+ (QTPropertiesType *)rd { return QTPropertiesType.values[@"RD"]; }

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
        @"crs": @"crs",
        @"features": @"features",
        @"totalFeatures": @"totalFeatures",
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
        if (![dict[@"crs"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"features"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"totalFeatures"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalFeatures"] doubleValue] != [dict[@"totalFeatures"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _crs = [QTCRS fromJSONDictionary:(id)_crs];
        if (!_crs && dict[@"crs"] && ![dict[@"crs"] isKindOfClass:NSNull.class]) return nil;
        _features = map(_features, λ(id x, [QTFeature fromJSONDictionary:x]));
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
        @"crs": [_crs JSONDictionary],
        @"features": map(_features, λ(id x, [x JSONDictionary])),
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

@implementation QTCRS
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"properties": @"properties",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCRS alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _properties = [QTCRSProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCRS.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCRS.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCRS.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"properties": [_properties JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCRSProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCRSProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCRSProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCRSProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCRSProperties.properties.allValues];
}
@end

@implementation QTFeature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"geometry": @"geometry",
        @"geometry_name": @"geometryName",
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
        if (![dict[@"geometry_name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _geometry = [QTGeometry fromJSONDictionary:(id)_geometry];
        if (!_geometry && dict[@"geometry"] && ![dict[@"geometry"] isKindOfClass:NSNull.class]) return nil;
        _geometryName = [QTGeometryName withValue:(id)_geometryName];
        _properties = [QTFeatureProperties fromJSONDictionary:(id)_properties];
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
        @"geometry_name": [_geometryName value],
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

@implementation QTFeatureProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"division": @"division",
        @"fax": @"fax",
        @"fire_ban_r": @"fireBanR",
        @"latitude": @"latitude",
        @"local_govt": @"localGovt",
        @"longitude": @"longitude",
        @"no": @"no",
        @"phone": @"phone",
        @"postcode": @"postcode",
        @"psa": @"psa",
        @"region": @"region",
        @"station": @"station",
        @"street": @"street",
        @"suburb": @"suburb",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFeatureProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"division"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"fax"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"fire_ban_r"]) return nil;
        if (![dict[@"latitude"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"local_govt"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"longitude"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"no"]) return nil;
        if (![dict[@"phone"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"postcode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"postcode"] doubleValue] != [dict[@"postcode"] longLongValue]) return nil;
        if (![dict[@"psa"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"region"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"station"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"street"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"suburb"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"type"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _fireBanR = [QTFireBanR withValue:(id)_fireBanR];
        if (_fireBanR == nil && dict[@"fire_ban_r"] && ![dict[@"fire_ban_r"] isKindOfClass:NSNull.class]) return nil;
        _region = [QTRegion withValue:(id)_region];
        _type = [QTPropertiesType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFeatureProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFeatureProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFeatureProperties.properties.allValues] mutableCopy];

    for (id jsonName in QTFeatureProperties.properties) {
        id propertyName = QTFeatureProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"fire_ban_r": NSNullify([_fireBanR value]),
        @"region": [_region value],
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
