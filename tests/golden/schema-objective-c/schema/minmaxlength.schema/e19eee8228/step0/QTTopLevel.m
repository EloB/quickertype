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
        @"intersection": @"intersection",
        @"inUnion": @"inUnion",
        @"maxlength": @"maxlength",
        @"minlength": @"minlength",
        @"minMaxIntersection": @"minMaxIntersection",
        @"minmaxlength": @"minmaxlength",
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
        if (dict[@"intersection"] && [dict[@"intersection"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < 4) return nil;
        if ([dict[@"intersection"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 > 5) return nil;
        if (![dict[@"intersection"] isKindOfClass:NSString.class]) return nil;
        if ([dict[@"maxlength"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 > 5) return nil;
        if (![dict[@"maxlength"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"minlength"] && [dict[@"minlength"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < 3) return nil;
        if (![dict[@"minlength"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"minMaxIntersection"] && [dict[@"minMaxIntersection"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < 3) return nil;
        if ([dict[@"minMaxIntersection"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 > 5) return nil;
        if (![dict[@"minMaxIntersection"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"minmaxlength"] && [dict[@"minmaxlength"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < 3) return nil;
        if ([dict[@"minmaxlength"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 > 5) return nil;
        if (![dict[@"minmaxlength"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"minMaxUnion"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"union"] && [dict[@"union"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < 3) return nil;
        if ([dict[@"union"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 > 6) return nil;
        if (![dict[@"union"] isKindOfClass:NSString.class]) return nil;
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
