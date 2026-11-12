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

@implementation QTClass
+ (NSDictionary<NSString *, QTClass *> *)values
{
    static NSDictionary<NSString *, QTClass *> *values;
    return values = values ? values : @{
        @"No Code Allocated": [[QTClass alloc] initWithValue:@"No Code Allocated"],
        @"OS-District": [[QTClass alloc] initWithValue:@"OS-District"],
        @"OS-Neighbourhood": [[QTClass alloc] initWithValue:@"OS-Neighbourhood"],
        @"OS-Regional": [[QTClass alloc] initWithValue:@"OS-Regional"],
    };
}

+ (QTClass *)noCodeAllocated { return QTClass.values[@"No Code Allocated"]; }
+ (QTClass *)osDistrict { return QTClass.values[@"OS-District"]; }
+ (QTClass *)osNeighbourhood { return QTClass.values[@"OS-Neighbourhood"]; }
+ (QTClass *)osRegional { return QTClass.values[@"OS-Regional"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTClass.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMaintainingAuthority
+ (NSDictionary<NSString *, QTMaintainingAuthority *> *)values
{
    static NSDictionary<NSString *, QTMaintainingAuthority *> *values;
    return values = values ? values : @{
        @"City of Ballarat": [[QTMaintainingAuthority alloc] initWithValue:@"City of Ballarat"],
    };
}

+ (QTMaintainingAuthority *)cityOfBallarat { return QTMaintainingAuthority.values[@"City of Ballarat"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMaintainingAuthority.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTWard
+ (NSDictionary<NSString *, QTWard *> *)values
{
    static NSDictionary<NSString *, QTWard *> *values;
    return values = values ? values : @{
        @"South": [[QTWard alloc] initWithValue:@"South"],
        @"North": [[QTWard alloc] initWithValue:@"North"],
        @"Central": [[QTWard alloc] initWithValue:@"Central"],
    };
}

+ (QTWard *)south { return QTWard.values[@"South"]; }
+ (QTWard *)north { return QTWard.values[@"North"]; }
+ (QTWard *)central { return QTWard.values[@"Central"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTWard.values[value];
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
        @"features": @"features",
        @"name": @"name",
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
        if (![dict[@"features"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
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

@implementation QTFeature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"geometry": @"geometry",
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
        @"Area": @"area",
        @"Central Asset ID": @"centralAssetID",
        @"Class": @"class",
        @"Feature Location": @"featureLocation",
        @"lat": @"lat",
        @"Maintaining Authority": @"maintainingAuthority",
        @"Number": @"number",
        @"long": @"propertiesLong",
        @"Site Name": @"siteName",
        @"Ward": @"ward",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Area"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Central Asset ID"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Class"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Feature Location"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"lat"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Maintaining Authority"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Number"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"long"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Site Name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Ward"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _class = [QTClass withValue:(id)_class];
        _maintainingAuthority = [QTMaintainingAuthority withValue:(id)_maintainingAuthority];
        _ward = [QTWard withValue:(id)_ward];
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

    for (id jsonName in QTProperties.properties) {
        id propertyName = QTProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"Class": [_class value],
        @"Maintaining Authority": [_maintainingAuthority value],
        @"Ward": [_ward value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
