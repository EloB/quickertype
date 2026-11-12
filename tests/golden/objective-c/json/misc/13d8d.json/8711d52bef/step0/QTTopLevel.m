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

@interface QTLocation (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStreet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOutcomeStatus (JSONConversion)
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
        @"category": @"category",
        @"context": @"context",
        @"id": @"identifier",
        @"location": @"location",
        @"location_subtype": @"locationSubtype",
        @"location_type": @"locationType",
        @"month": @"month",
        @"outcome_status": @"outcomeStatus",
        @"persistent_id": @"persistentID",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"category"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"context"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"location"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"location_subtype"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"location_type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"month"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"outcome_status"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"persistent_id"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _location = [QTLocation fromJSONDictionary:(id)_location];
        if (!_location && dict[@"location"] && ![dict[@"location"] isKindOfClass:NSNull.class]) return nil;
        _outcomeStatus = [QTOutcomeStatus fromJSONDictionary:(id)_outcomeStatus];
        if (!_outcomeStatus && dict[@"outcome_status"] && ![dict[@"outcome_status"] isKindOfClass:NSNull.class]) return nil;
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
        @"location": [_location JSONDictionary],
        @"outcome_status": [_outcomeStatus JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTLocation
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"latitude": @"latitude",
        @"longitude": @"longitude",
        @"street": @"street",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLocation alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"latitude"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"longitude"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"street"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _street = [QTStreet fromJSONDictionary:(id)_street];
        if (!_street && dict[@"street"] && ![dict[@"street"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLocation.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLocation.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLocation.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"street": [_street JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTStreet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStreet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStreet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStreet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStreet.properties.allValues] mutableCopy];

    for (id jsonName in QTStreet.properties) {
        id propertyName = QTStreet.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTOutcomeStatus
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"category": @"category",
        @"date": @"date",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOutcomeStatus alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"category"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"date"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOutcomeStatus.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOutcomeStatus.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOutcomeStatus.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
