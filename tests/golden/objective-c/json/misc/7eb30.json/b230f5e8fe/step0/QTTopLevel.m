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

@interface QTResult (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGroup (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTCode
+ (NSDictionary<NSString *, QTCode *> *)values
{
    static NSDictionary<NSString *, QTCode *> *values;
    return values = values ? values : @{
        @"sf": [[QTCode alloc] initWithValue:@"sf"],
    };
}

+ (QTCode *)sf { return QTCode.values[@"sf"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTCode.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTEnglish
+ (NSDictionary<NSString *, QTEnglish *> *)values
{
    static NSDictionary<NSString *, QTEnglish *> *values;
    return values = values ? values : @{
        @"SF": [[QTEnglish alloc] initWithValue:@"SF"],
    };
}

+ (QTEnglish *)sf { return QTEnglish.values[@"SF"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTEnglish.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTThai
+ (NSDictionary<NSString *, QTThai *> *)values
{
    static NSDictionary<NSString *, QTThai *> *values;
    return values = values ? values : @{
        @"เอสเอฟ": [[QTThai alloc] initWithValue:@"เอสเอฟ"],
    };
}

+ (QTThai *)เอสเอฟ { return QTThai.values[@"เอสเอฟ"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTThai.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLocation
+ (NSDictionary<NSString *, QTLocation *> *)values
{
    static NSDictionary<NSString *, QTLocation *> *values;
    return values = values ? values : @{
        @"": [[QTLocation alloc] initWithValue:@""],
        @"5th Fl. Emporium": [[QTLocation alloc] initWithValue:@"5th Fl. Emporium"],
    };
}

+ (QTLocation *)empty { return QTLocation.values[@""]; }
+ (QTLocation *)the5ThFLEmporium { return QTLocation.values[@"5th Fl. Emporium"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLocation.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTTel
+ (NSDictionary<NSString *, QTTel *> *)values
{
    static NSDictionary<NSString *, QTTel *> *values;
    return values = values ? values : @{
        @"": [[QTTel alloc] initWithValue:@""],
        @"02-268-8899": [[QTTel alloc] initWithValue:@"02-268-8899"],
    };
}

+ (QTTel *)empty { return QTTel.values[@""]; }
+ (QTTel *)the022688899 { return QTTel.values[@"02-268-8899"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTel.values[value];
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
        @"count": @"count",
        @"next": @"next",
        @"previous": @"previous",
        @"results": @"results",
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
        if (![dict[@"count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"count"] doubleValue] != [dict[@"count"] longLongValue]) return nil;
        if (![dict[@"next"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"previous"]) return nil;
        if (![dict[@"results"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _results = map(_results, λ(id x, [QTResult fromJSONDictionary:x]));
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
        @"results": map(_results, λ(id x, [x JSONDictionary])),
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

@implementation QTResult
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"code": @"code",
        @"english": @"english",
        @"group": @"group",
        @"fav": @"isFav",
        @"location": @"location",
        @"min_screens": @"minScreens",
        @"num_views": @"numViews",
        @"showtimes": @"showtimes",
        @"stars": @"stars",
        @"tel": @"tel",
        @"thai": @"thai",
        @"today_screens": @"todayScreens",
        @"url": @"url",
        @"website": @"website",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResult alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"code"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"english"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"group"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fav"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"location"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"min_screens"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"min_screens"] doubleValue] != [dict[@"min_screens"] longLongValue]) return nil;
        if (![dict[@"num_views"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"num_views"] doubleValue] != [dict[@"num_views"] longLongValue]) return nil;
        if (![dict[@"showtimes"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"stars"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"stars"] doubleValue] != [dict[@"stars"] longLongValue]) return nil;
        if (![dict[@"tel"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"thai"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"today_screens"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"today_screens"] doubleValue] != [dict[@"today_screens"] longLongValue]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"website"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _group = [QTGroup fromJSONDictionary:(id)_group];
        if (!_group && dict[@"group"] && ![dict[@"group"] isKindOfClass:NSNull.class]) return nil;
        _location = [QTLocation withValue:(id)_location];
        _tel = [QTTel withValue:(id)_tel];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTResult.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTResult.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTResult.properties.allValues] mutableCopy];

    for (id jsonName in QTResult.properties) {
        id propertyName = QTResult.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"group": [_group JSONDictionary],
        @"fav": _isFav ? @YES : @NO,
        @"location": [_location value],
        @"tel": [_tel value],
    }];

    return dict;
}
@end

@implementation QTGroup
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"code": @"code",
        @"english": @"english",
        @"thai": @"thai",
        @"website": @"website",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGroup alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"code"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"english"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"thai"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"website"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _code = [QTCode withValue:(id)_code];
        _english = [QTEnglish withValue:(id)_english];
        _thai = [QTThai withValue:(id)_thai];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGroup.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGroup.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGroup.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"code": [_code value],
        @"english": [_english value],
        @"thai": [_thai value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
