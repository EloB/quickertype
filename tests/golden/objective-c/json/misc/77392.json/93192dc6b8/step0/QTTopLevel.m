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

@implementation QTOrbitClass
+ (NSDictionary<NSString *, QTOrbitClass *> *)values
{
    static NSDictionary<NSString *, QTOrbitClass *> *values;
    return values = values ? values : @{
        @"Apollo": [[QTOrbitClass alloc] initWithValue:@"Apollo"],
        @"Amor": [[QTOrbitClass alloc] initWithValue:@"Amor"],
        @"Aten": [[QTOrbitClass alloc] initWithValue:@"Aten"],
        @"Comet": [[QTOrbitClass alloc] initWithValue:@"Comet"],
        @"Jupiter-family Comet": [[QTOrbitClass alloc] initWithValue:@"Jupiter-family Comet"],
        @"Halley-type Comet*": [[QTOrbitClass alloc] initWithValue:@"Halley-type Comet*"],
        @"Parabolic Comet": [[QTOrbitClass alloc] initWithValue:@"Parabolic Comet"],
        @"Jupiter-family Comet*": [[QTOrbitClass alloc] initWithValue:@"Jupiter-family Comet*"],
        @"Encke-type Comet": [[QTOrbitClass alloc] initWithValue:@"Encke-type Comet"],
    };
}

+ (QTOrbitClass *)apollo { return QTOrbitClass.values[@"Apollo"]; }
+ (QTOrbitClass *)amor { return QTOrbitClass.values[@"Amor"]; }
+ (QTOrbitClass *)aten { return QTOrbitClass.values[@"Aten"]; }
+ (QTOrbitClass *)comet { return QTOrbitClass.values[@"Comet"]; }
+ (QTOrbitClass *)jupiterFamilyComet { return QTOrbitClass.values[@"Jupiter-family Comet"]; }
+ (QTOrbitClass *)halleyTypeComet { return QTOrbitClass.values[@"Halley-type Comet*"]; }
+ (QTOrbitClass *)parabolicComet { return QTOrbitClass.values[@"Parabolic Comet"]; }
+ (QTOrbitClass *)orbitClassJupiterFamilyComet { return QTOrbitClass.values[@"Jupiter-family Comet*"]; }
+ (QTOrbitClass *)enckeTypeComet { return QTOrbitClass.values[@"Encke-type Comet"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTOrbitClass.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTPha
+ (NSDictionary<NSString *, QTPha *> *)values
{
    static NSDictionary<NSString *, QTPha *> *values;
    return values = values ? values : @{
        @"Y": [[QTPha alloc] initWithValue:@"Y"],
        @"N": [[QTPha alloc] initWithValue:@"N"],
        @"n/a": [[QTPha alloc] initWithValue:@"n/a"],
    };
}

+ (QTPha *)y { return QTPha.values[@"Y"]; }
+ (QTPha *)n { return QTPha.values[@"N"]; }
+ (QTPha *)nA { return QTPha.values[@"n/a"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPha.values[value];
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
        @"designation": @"designation",
        @"discovery_date": @"discoveryDate",
        @"h_mag": @"hMag",
        @"i_deg": @"iDeg",
        @"moid_au": @"moidAu",
        @"orbit_class": @"orbitClass",
        @"period_yr": @"periodYr",
        @"pha": @"pha",
        @"q_au_1": @"qAu1",
        @"q_au_2": @"qAu2",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"designation"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"discovery_date"] && [dict[@"discovery_date"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"discovery_date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"i_deg"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"moid_au"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"orbit_class"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"pha"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"q_au_1"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _orbitClass = [QTOrbitClass withValue:(id)_orbitClass];
        _pha = [QTPha withValue:(id)_pha];
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
        @"orbit_class": [_orbitClass value],
        @"pha": [_pha value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
