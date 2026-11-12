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

@interface QTAdminregion (JSONConversion)
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
        @"": [[QTID alloc] initWithValue:@""],
        @"SAS": [[QTID alloc] initWithValue:@"SAS"],
        @"SSA": [[QTID alloc] initWithValue:@"SSA"],
        @"ECA": [[QTID alloc] initWithValue:@"ECA"],
        @"LAC": [[QTID alloc] initWithValue:@"LAC"],
        @"EAP": [[QTID alloc] initWithValue:@"EAP"],
        @"MNA": [[QTID alloc] initWithValue:@"MNA"],
        @"HIC": [[QTID alloc] initWithValue:@"HIC"],
        @"LIC": [[QTID alloc] initWithValue:@"LIC"],
        @"NA": [[QTID alloc] initWithValue:@"NA"],
        @"LMC": [[QTID alloc] initWithValue:@"LMC"],
        @"UMC": [[QTID alloc] initWithValue:@"UMC"],
        @"LNX": [[QTID alloc] initWithValue:@"LNX"],
        @"IDX": [[QTID alloc] initWithValue:@"IDX"],
        @"IBD": [[QTID alloc] initWithValue:@"IBD"],
        @"IDB": [[QTID alloc] initWithValue:@"IDB"],
        @"LCN": [[QTID alloc] initWithValue:@"LCN"],
        @"SSF": [[QTID alloc] initWithValue:@"SSF"],
        @"ECS": [[QTID alloc] initWithValue:@"ECS"],
        @"MEA": [[QTID alloc] initWithValue:@"MEA"],
        @"EAS": [[QTID alloc] initWithValue:@"EAS"],
        @"NAC": [[QTID alloc] initWithValue:@"NAC"],
    };
}

+ (QTID *)empty { return QTID.values[@""]; }
+ (QTID *)sas { return QTID.values[@"SAS"]; }
+ (QTID *)ssa { return QTID.values[@"SSA"]; }
+ (QTID *)eca { return QTID.values[@"ECA"]; }
+ (QTID *)lac { return QTID.values[@"LAC"]; }
+ (QTID *)eap { return QTID.values[@"EAP"]; }
+ (QTID *)mna { return QTID.values[@"MNA"]; }
+ (QTID *)hic { return QTID.values[@"HIC"]; }
+ (QTID *)lic { return QTID.values[@"LIC"]; }
+ (QTID *)na { return QTID.values[@"NA"]; }
+ (QTID *)lmc { return QTID.values[@"LMC"]; }
+ (QTID *)umc { return QTID.values[@"UMC"]; }
+ (QTID *)lnx { return QTID.values[@"LNX"]; }
+ (QTID *)idx { return QTID.values[@"IDX"]; }
+ (QTID *)ibd { return QTID.values[@"IBD"]; }
+ (QTID *)idb { return QTID.values[@"IDB"]; }
+ (QTID *)lcn { return QTID.values[@"LCN"]; }
+ (QTID *)ssf { return QTID.values[@"SSF"]; }
+ (QTID *)ecs { return QTID.values[@"ECS"]; }
+ (QTID *)mea { return QTID.values[@"MEA"]; }
+ (QTID *)eas { return QTID.values[@"EAS"]; }
+ (QTID *)nac { return QTID.values[@"NAC"]; }

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
        @"": [[QTValue alloc] initWithValue:@""],
        @"South Asia": [[QTValue alloc] initWithValue:@"South Asia"],
        @"Sub-Saharan Africa (excluding high income)": [[QTValue alloc] initWithValue:@"Sub-Saharan Africa (excluding high income)"],
        @"Europe & Central Asia (excluding high income)": [[QTValue alloc] initWithValue:@"Europe & Central Asia (excluding high income)"],
        @"Latin America & Caribbean (excluding high income)": [[QTValue alloc] initWithValue:@"Latin America & Caribbean (excluding high income)"],
        @"East Asia & Pacific (excluding high income)": [[QTValue alloc] initWithValue:@"East Asia & Pacific (excluding high income)"],
        @"Middle East & North Africa (excluding high income)": [[QTValue alloc] initWithValue:@"Middle East & North Africa (excluding high income)"],
        @"High income": [[QTValue alloc] initWithValue:@"High income"],
        @"Low income": [[QTValue alloc] initWithValue:@"Low income"],
        @"Aggregates": [[QTValue alloc] initWithValue:@"Aggregates"],
        @"Lower middle income": [[QTValue alloc] initWithValue:@"Lower middle income"],
        @"Upper middle income": [[QTValue alloc] initWithValue:@"Upper middle income"],
        @"Not classified": [[QTValue alloc] initWithValue:@"Not classified"],
        @"IDA": [[QTValue alloc] initWithValue:@"IDA"],
        @"IBRD": [[QTValue alloc] initWithValue:@"IBRD"],
        @"Blend": [[QTValue alloc] initWithValue:@"Blend"],
        @"Latin America & Caribbean ": [[QTValue alloc] initWithValue:@"Latin America & Caribbean "],
        @"Sub-Saharan Africa ": [[QTValue alloc] initWithValue:@"Sub-Saharan Africa "],
        @"Europe & Central Asia": [[QTValue alloc] initWithValue:@"Europe & Central Asia"],
        @"Middle East & North Africa": [[QTValue alloc] initWithValue:@"Middle East & North Africa"],
        @"East Asia & Pacific": [[QTValue alloc] initWithValue:@"East Asia & Pacific"],
        @"North America": [[QTValue alloc] initWithValue:@"North America"],
    };
}

+ (QTValue *)empty { return QTValue.values[@""]; }
+ (QTValue *)southAsia { return QTValue.values[@"South Asia"]; }
+ (QTValue *)subSaharanAfricaExcludingHighIncome { return QTValue.values[@"Sub-Saharan Africa (excluding high income)"]; }
+ (QTValue *)europeCentralAsiaExcludingHighIncome { return QTValue.values[@"Europe & Central Asia (excluding high income)"]; }
+ (QTValue *)latinAmericaCaribbeanExcludingHighIncome { return QTValue.values[@"Latin America & Caribbean (excluding high income)"]; }
+ (QTValue *)eastAsiaPacificExcludingHighIncome { return QTValue.values[@"East Asia & Pacific (excluding high income)"]; }
+ (QTValue *)middleEastNorthAfricaExcludingHighIncome { return QTValue.values[@"Middle East & North Africa (excluding high income)"]; }
+ (QTValue *)highIncome { return QTValue.values[@"High income"]; }
+ (QTValue *)lowIncome { return QTValue.values[@"Low income"]; }
+ (QTValue *)aggregates { return QTValue.values[@"Aggregates"]; }
+ (QTValue *)lowerMiddleIncome { return QTValue.values[@"Lower middle income"]; }
+ (QTValue *)upperMiddleIncome { return QTValue.values[@"Upper middle income"]; }
+ (QTValue *)notClassified { return QTValue.values[@"Not classified"]; }
+ (QTValue *)ida { return QTValue.values[@"IDA"]; }
+ (QTValue *)ibrd { return QTValue.values[@"IBRD"]; }
+ (QTValue *)blend { return QTValue.values[@"Blend"]; }
+ (QTValue *)latinAmericaCaribbean { return QTValue.values[@"Latin America & Caribbean "]; }
+ (QTValue *)subSaharanAfrica { return QTValue.values[@"Sub-Saharan Africa "]; }
+ (QTValue *)europeCentralAsia { return QTValue.values[@"Europe & Central Asia"]; }
+ (QTValue *)middleEastNorthAfrica { return QTValue.values[@"Middle East & North Africa"]; }
+ (QTValue *)eastAsiaPacific { return QTValue.values[@"East Asia & Pacific"]; }
+ (QTValue *)northAmerica { return QTValue.values[@"North America"]; }

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
        @"adminregion": @"adminregion",
        @"capitalCity": @"capitalCity",
        @"id": @"identifier",
        @"incomeLevel": @"incomeLevel",
        @"iso2Code": @"iso2Code",
        @"latitude": @"latitude",
        @"lendingType": @"lendingType",
        @"longitude": @"longitude",
        @"name": @"name",
        @"region": @"region",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleQTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"adminregion"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"capitalCity"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"incomeLevel"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"iso2Code"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"latitude"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"lendingType"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"longitude"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"region"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _adminregion = [QTAdminregion fromJSONDictionary:(id)_adminregion];
        if (!_adminregion && dict[@"adminregion"] && ![dict[@"adminregion"] isKindOfClass:NSNull.class]) return nil;
        _incomeLevel = [QTAdminregion fromJSONDictionary:(id)_incomeLevel];
        if (!_incomeLevel && dict[@"incomeLevel"] && ![dict[@"incomeLevel"] isKindOfClass:NSNull.class]) return nil;
        _lendingType = [QTAdminregion fromJSONDictionary:(id)_lendingType];
        if (!_lendingType && dict[@"lendingType"] && ![dict[@"lendingType"] isKindOfClass:NSNull.class]) return nil;
        _region = [QTAdminregion fromJSONDictionary:(id)_region];
        if (!_region && dict[@"region"] && ![dict[@"region"] isKindOfClass:NSNull.class]) return nil;
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

    for (id jsonName in QTPurpleQTTopLevel.properties) {
        id propertyName = QTPurpleQTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"adminregion": [_adminregion JSONDictionary],
        @"incomeLevel": [_incomeLevel JSONDictionary],
        @"lendingType": [_lendingType JSONDictionary],
        @"region": [_region JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTAdminregion
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
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAdminregion alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTAdminregion.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAdminregion.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAdminregion.properties.allValues] mutableCopy];

    for (id jsonName in QTAdminregion.properties) {
        id propertyName = QTAdminregion.properties[jsonName];
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
