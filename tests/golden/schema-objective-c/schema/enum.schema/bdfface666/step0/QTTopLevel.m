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

@implementation QTOtherArr
+ (NSDictionary<NSString *, QTOtherArr *> *)values
{
    static NSDictionary<NSString *, QTOtherArr *> *values;
    return values = values ? values : @{
        @"foo": [[QTOtherArr alloc] initWithValue:@"foo"],
        @"bar": [[QTOtherArr alloc] initWithValue:@"bar"],
        @"if": [[QTOtherArr alloc] initWithValue:@"if"],
    };
}

+ (QTOtherArr *)foo { return QTOtherArr.values[@"foo"]; }
+ (QTOtherArr *)bar { return QTOtherArr.values[@"bar"]; }
+ (QTOtherArr *)otherArrIf { return QTOtherArr.values[@"if"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTOtherArr.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTGve
+ (NSDictionary<NSString *, QTGve *> *)values
{
    static NSDictionary<NSString *, QTGve *> *values;
    return values = values ? values : @{
        @"good": [[QTGve alloc] initWithValue:@"good"],
        @"neutral": [[QTGve alloc] initWithValue:@"neutral"],
        @"evil": [[QTGve alloc] initWithValue:@"evil"],
    };
}

+ (QTGve *)good { return QTGve.values[@"good"]; }
+ (QTGve *)neutral { return QTGve.values[@"neutral"]; }
+ (QTGve *)evil { return QTGve.values[@"evil"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGve.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLvc
+ (NSDictionary<NSString *, QTLvc *> *)values
{
    static NSDictionary<NSString *, QTLvc *> *values;
    return values = values ? values : @{
        @"lawful": [[QTLvc alloc] initWithValue:@"lawful"],
        @"neutral": [[QTLvc alloc] initWithValue:@"neutral"],
        @"chaotic": [[QTLvc alloc] initWithValue:@"chaotic"],
    };
}

+ (QTLvc *)lawful { return QTLvc.values[@"lawful"]; }
+ (QTLvc *)neutral { return QTLvc.values[@"neutral"]; }
+ (QTLvc *)chaotic { return QTLvc.values[@"chaotic"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLvc.values[value];
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
        @"arr": @"arr",
        @"for": @"qtTopLevelFor",
        @"gve": @"gve",
        @"lvc": @"lvc",
        @"otherArr": @"otherArr",
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
        if (![dict[@"gve"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _gve = [QTGve withValue:(id)_gve];
        _lvc = [QTLvc withValue:(id)_lvc];
        if (_lvc == nil && dict[@"lvc"] && ![dict[@"lvc"] isKindOfClass:NSNull.class]) return nil;
        _otherArr = map(_otherArr, λ(id x, [QTOtherArr withValue:x]));
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

    [dict addEntriesFromDictionary:@{
        @"gve": [_gve value],
        @"lvc": NSNullify([_lvc value]),
        @"otherArr": NSNullify(map(_otherArr, λ(id x, [x value]))),
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

NS_ASSUME_NONNULL_END
