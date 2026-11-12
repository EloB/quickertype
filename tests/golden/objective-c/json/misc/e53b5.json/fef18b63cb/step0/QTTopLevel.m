#import "QTTopLevel.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTPurpleQTTopLevel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCountry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyQTTopLevel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTID
+ (NSDictionary<NSString *, QTID *> *)values
{
    static NSDictionary<NSString *, QTID *> *values;
    return values = values ? values : @{
        @"IN": [[QTID alloc] initWithValue:@"IN"],
        @"SP.POP.TOTL": [[QTID alloc] initWithValue:@"SP.POP.TOTL"],
    };
}

+ (QTID *)in { return QTID.values[@"IN"]; }
+ (QTID *)spPopTotl { return QTID.values[@"SP.POP.TOTL"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTID.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTValue
+ (NSDictionary<NSString *, QTValue *> *)values
{
    static NSDictionary<NSString *, QTValue *> *values;
    return values = values ? values : @{
        @"India": [[QTValue alloc] initWithValue:@"India"],
        @"Population, total": [[QTValue alloc] initWithValue:@"Population, total"],
    };
}

+ (QTValue *)india { return QTValue.values[@"India"]; }
+ (QTValue *)populationTotal { return QTValue.values[@"Population, total"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTValue.values[value];
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
        return *error ? nil : map(json, λ(id x, x));
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
        id json = topLevel;
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

@implementation QTPurpleQTTopLevel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"country": @"country",
        @"date": @"date",
        @"decimal": @"decimal",
        @"indicator": @"indicator",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleQTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"country"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"decimal"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"indicator"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"value"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _country = [QTCountry fromJSONDictionary:(id)_country];
        if (!_country && dict[@"country"] && ![dict[@"country"] isKindOfClass:NSNull.class]) return nil;
        _indicator = [QTCountry fromJSONDictionary:(id)_indicator];
        if (!_indicator && dict[@"indicator"] && ![dict[@"indicator"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleQTTopLevel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleQTTopLevel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleQTTopLevel.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"country": [_country JSONDictionary],
        @"indicator": [_indicator JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCountry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCountry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"value"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _identifier = [QTID withValue:(id)_identifier];
        _value = [QTValue withValue:(id)_value];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCountry.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCountry.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCountry.properties.allValues] mutableCopy];

    for (id jsonName in QTCountry.properties) {
        id propertyName = QTCountry.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"id": [_identifier value],
        @"value": [_value value],
    }];

    return dict;
}
@end

@implementation QTFluffyQTTopLevel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"page": @"page",
        @"pages": @"pages",
        @"per_page": @"perPage",
        @"total": @"total",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyQTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"page"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"page"] doubleValue] != [dict[@"page"] longLongValue]) return nil;
        if (![dict[@"pages"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"pages"] doubleValue] != [dict[@"pages"] longLongValue]) return nil;
        if (![dict[@"per_page"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"total"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"total"] doubleValue] != [dict[@"total"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyQTTopLevel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyQTTopLevel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyQTTopLevel.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffyQTTopLevel.properties) {
        id propertyName = QTFluffyQTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
