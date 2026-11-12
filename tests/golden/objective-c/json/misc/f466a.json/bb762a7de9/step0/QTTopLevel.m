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

@implementation QTCountry
+ (NSDictionary<NSString *, QTCountry *> *)values
{
    static NSDictionary<NSString *, QTCountry *> *values;
    return values = values ? values : @{
        @"United States": [[QTCountry alloc] initWithValue:@"United States"],
    };
}

+ (QTCountry *)unitedStates { return QTCountry.values[@"United States"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTCountry.values[value];
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
        @"age": @"age",
        @"country": @"country",
        @"females": @"females",
        @"males": @"males",
        @"total": @"total",
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
        if (![dict[@"age"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"age"] doubleValue] != [dict[@"age"] longLongValue]) return nil;
        if (![dict[@"country"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"females"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"females"] doubleValue] != [dict[@"females"] longLongValue]) return nil;
        if (![dict[@"males"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"males"] doubleValue] != [dict[@"males"] longLongValue]) return nil;
        if (![dict[@"total"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"total"] doubleValue] != [dict[@"total"] longLongValue]) return nil;
        if (![dict[@"year"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"year"] doubleValue] != [dict[@"year"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _country = [QTCountry withValue:(id)_country];
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

    [dict addEntriesFromDictionary:@{
        @"country": [_country value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
