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
        @"free": @"free",
        @"intersection": @"intersection",
        @"max": @"max",
        @"min": @"min",
        @"minmax": @"minmax",
        @"minMaxIntersection": @"minMaxIntersection",
        @"minMaxUnion": @"minMaxUnion",
        @"union": @"qtTopLevelUnion",
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
        if (![dict[@"free"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"free"] doubleValue] != [dict[@"free"] longLongValue]) return nil;
        if (dict[@"intersection"] && [dict[@"intersection"] doubleValue] < 4) return nil;
        if (dict[@"intersection"] && [dict[@"intersection"] doubleValue] > 5) return nil;
        if (![dict[@"intersection"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"intersection"] doubleValue] != [dict[@"intersection"] longLongValue]) return nil;
        if (dict[@"max"] && [dict[@"max"] doubleValue] > 5) return nil;
        if (![dict[@"max"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"max"] doubleValue] != [dict[@"max"] longLongValue]) return nil;
        if (dict[@"min"] && [dict[@"min"] doubleValue] < 3) return nil;
        if (![dict[@"min"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"min"] doubleValue] != [dict[@"min"] longLongValue]) return nil;
        if (dict[@"minmax"] && [dict[@"minmax"] doubleValue] < 3) return nil;
        if (dict[@"minmax"] && [dict[@"minmax"] doubleValue] > 5) return nil;
        if (![dict[@"minmax"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"minmax"] doubleValue] != [dict[@"minmax"] longLongValue]) return nil;
        if (dict[@"minMaxIntersection"] && [dict[@"minMaxIntersection"] doubleValue] < 3) return nil;
        if (dict[@"minMaxIntersection"] && [dict[@"minMaxIntersection"] doubleValue] > 5) return nil;
        if (![dict[@"minMaxIntersection"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"minMaxIntersection"] doubleValue] != [dict[@"minMaxIntersection"] longLongValue]) return nil;
        if (![dict[@"minMaxUnion"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"minMaxUnion"] doubleValue] != [dict[@"minMaxUnion"] longLongValue]) return nil;
        if (dict[@"union"] && [dict[@"union"] doubleValue] < 3) return nil;
        if (dict[@"union"] && [dict[@"union"] doubleValue] > 6) return nil;
        if (![dict[@"union"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"union"] doubleValue] != [dict[@"union"] longLongValue]) return nil;
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
