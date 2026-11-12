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
        @"above_i32_max": @"aboveI32Max",
        @"below_i32_min": @"belowI32Min",
        @"i32_range": @"i32Range",
        @"large_bounds": @"largeBounds",
        @"only_maximum": @"onlyMaximum",
        @"only_minimum": @"onlyMinimum",
        @"small_negative": @"smallNegative",
        @"small_positive": @"smallPositive",
        @"unbounded": @"unbounded",
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
        if (dict[@"above_i32_max"] && [dict[@"above_i32_max"] doubleValue] < 0) return nil;
        if (dict[@"above_i32_max"] && [dict[@"above_i32_max"] doubleValue] > 2147483648) return nil;
        if (![dict[@"above_i32_max"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"above_i32_max"] doubleValue] != [dict[@"above_i32_max"] longLongValue]) return nil;
        if (dict[@"below_i32_min"] && [dict[@"below_i32_min"] doubleValue] < -2147483649) return nil;
        if (dict[@"below_i32_min"] && [dict[@"below_i32_min"] doubleValue] > 0) return nil;
        if (![dict[@"below_i32_min"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"below_i32_min"] doubleValue] != [dict[@"below_i32_min"] longLongValue]) return nil;
        if (dict[@"i32_range"] && [dict[@"i32_range"] doubleValue] < -2147483648) return nil;
        if (dict[@"i32_range"] && [dict[@"i32_range"] doubleValue] > 2147483647) return nil;
        if (![dict[@"i32_range"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"i32_range"] doubleValue] != [dict[@"i32_range"] longLongValue]) return nil;
        if (dict[@"large_bounds"] && [dict[@"large_bounds"] doubleValue] < -9007199254740991) return nil;
        if (dict[@"large_bounds"] && [dict[@"large_bounds"] doubleValue] > 9007199254740991) return nil;
        if (![dict[@"large_bounds"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"large_bounds"] doubleValue] != [dict[@"large_bounds"] longLongValue]) return nil;
        if (dict[@"only_maximum"] && [dict[@"only_maximum"] doubleValue] > 0) return nil;
        if (![dict[@"only_maximum"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"only_maximum"] doubleValue] != [dict[@"only_maximum"] longLongValue]) return nil;
        if (dict[@"only_minimum"] && [dict[@"only_minimum"] doubleValue] < 0) return nil;
        if (![dict[@"only_minimum"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"only_minimum"] doubleValue] != [dict[@"only_minimum"] longLongValue]) return nil;
        if (dict[@"small_negative"] && [dict[@"small_negative"] doubleValue] < -100) return nil;
        if (dict[@"small_negative"] && [dict[@"small_negative"] doubleValue] > 0) return nil;
        if (![dict[@"small_negative"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"small_negative"] doubleValue] != [dict[@"small_negative"] longLongValue]) return nil;
        if (dict[@"small_positive"] && [dict[@"small_positive"] doubleValue] < 0) return nil;
        if (dict[@"small_positive"] && [dict[@"small_positive"] doubleValue] > 100) return nil;
        if (![dict[@"small_positive"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"small_positive"] doubleValue] != [dict[@"small_positive"] longLongValue]) return nil;
        if (![dict[@"unbounded"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"unbounded"] doubleValue] != [dict[@"unbounded"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
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

NS_ASSUME_NONNULL_END
