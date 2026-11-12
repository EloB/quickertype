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

@interface QTGeolocation (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTFall
+ (NSDictionary<NSString *, QTFall *> *)values
{
    static NSDictionary<NSString *, QTFall *> *values;
    return values = values ? values : @{
        @"Fell": [[QTFall alloc] initWithValue:@"Fell"],
        @"Found": [[QTFall alloc] initWithValue:@"Found"],
    };
}

+ (QTFall *)fell { return QTFall.values[@"Fell"]; }
+ (QTFall *)found { return QTFall.values[@"Found"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFall.values[value];
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
        @"Point": [[QTType alloc] initWithValue:@"Point"],
    };
}

+ (QTType *)point { return QTType.values[@"Point"]; }

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

@implementation QTNametype
+ (NSDictionary<NSString *, QTNametype *> *)values
{
    static NSDictionary<NSString *, QTNametype *> *values;
    return values = values ? values : @{
        @"Valid": [[QTNametype alloc] initWithValue:@"Valid"],
    };
}

+ (QTNametype *)valid { return QTNametype.values[@"Valid"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTNametype.values[value];
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
        @":@computed_region_cbhk_fwbd": @"computedRegionCbhkFwbd",
        @":@computed_region_nnqa_25f4": @"computedRegionNnqa25F4",
        @"fall": @"fall",
        @"geolocation": @"geolocation",
        @"id": @"identifier",
        @"mass": @"mass",
        @"name": @"name",
        @"nametype": @"nametype",
        @"recclass": @"recclass",
        @"reclat": @"reclat",
        @"reclong": @"reclong",
        @"year": @"year",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"fall"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"nametype"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"recclass"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _fall = [QTFall withValue:(id)_fall];
        _geolocation = [QTGeolocation fromJSONDictionary:(id)_geolocation];
        if (!_geolocation && dict[@"geolocation"] && ![dict[@"geolocation"] isKindOfClass:NSNull.class]) return nil;
        _nametype = [QTNametype withValue:(id)_nametype];
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
        @"fall": [_fall value],
        @"geolocation": NSNullify([_geolocation isKindOfClass:NSNull.class] ? nil : [_geolocation JSONDictionary]),
        @"nametype": [_nametype value],
    }];

    return dict;
}
@end

@implementation QTGeolocation
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
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGeolocation alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"coordinates"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGeolocation.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGeolocation.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGeolocation.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": [_type value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
