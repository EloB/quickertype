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

@interface QTFacets (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTResult (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCustomIncome (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTStatus
+ (NSDictionary<NSString *, QTStatus *> *)values
{
    static NSDictionary<NSString *, QTStatus *> *values;
    return values = values ? values : @{
        @"active": [[QTStatus alloc] initWithValue:@"active"],
        @"inactive": [[QTStatus alloc] initWithValue:@"inactive"],
    };
}

+ (QTStatus *)active { return QTStatus.values[@"active"]; }
+ (QTStatus *)inactive { return QTStatus.values[@"inactive"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTStatus.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTCustomIncomeType
+ (NSDictionary<NSString *, QTCustomIncomeType *> *)values
{
    static NSDictionary<NSString *, QTCustomIncomeType *> *values;
    return values = values ? values : @{
        @"public": [[QTCustomIncomeType alloc] initWithValue:@"public"],
        @"other": [[QTCustomIncomeType alloc] initWithValue:@"other"],
    };
}

+ (QTCustomIncomeType *)public { return QTCustomIncomeType.values[@"public"]; }
+ (QTCustomIncomeType *)other { return QTCustomIncomeType.values[@"other"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTCustomIncomeType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTResultType
+ (NSDictionary<NSString *, QTResultType *> *)values
{
    static NSDictionary<NSString *, QTResultType *> *values;
    return values = values ? values : @{
        @"FinancialDataNGO": [[QTResultType alloc] initWithValue:@"FinancialDataNGO"],
        @"FinancialDataLawyer": [[QTResultType alloc] initWithValue:@"FinancialDataLawyer"],
        @"FinancialDataTradeAssociation": [[QTResultType alloc] initWithValue:@"FinancialDataTradeAssociation"],
    };
}

+ (QTResultType *)financialDataNGO { return QTResultType.values[@"FinancialDataNGO"]; }
+ (QTResultType *)financialDataLawyer { return QTResultType.values[@"FinancialDataLawyer"]; }
+ (QTResultType *)financialDataTradeAssociation { return QTResultType.values[@"FinancialDataTradeAssociation"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTResultType.values[value];
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
        @"facets": @"facets",
        @"previous": @"isPrevious",
        @"limit": @"limit",
        @"next": @"next",
        @"offset": @"offset",
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
        if (![dict[@"facets"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"previous"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"limit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"limit"] doubleValue] != [dict[@"limit"] longLongValue]) return nil;
        if (![dict[@"next"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"offset"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"offset"] doubleValue] != [dict[@"offset"] longLongValue]) return nil;
        if (![dict[@"results"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _facets = [QTFacets fromJSONDictionary:(id)_facets];
        if (!_facets && dict[@"facets"] && ![dict[@"facets"] isKindOfClass:NSNull.class]) return nil;
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

    for (id jsonName in QTTopLevel.properties) {
        id propertyName = QTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"facets": [_facets JSONDictionary],
        @"previous": _isPrevious ? @YES : @NO,
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

@implementation QTFacets
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFacets alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFacets.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFacets.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFacets.properties.allValues];
}
@end

@implementation QTResult
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"cost_absolute": @"costAbsolute",
        @"cost_max": @"costMax",
        @"cost_min": @"costMin",
        @"created_at": @"createdAt",
        @"customIncomes": @"customIncomes",
        @"direct_rep_costs_max": @"directRepCostsMax",
        @"direct_rep_costs_min": @"directRepCostsMin",
        @"end_date": @"endDate",
        @"eur_sources_grants": @"eurSourcesGrants",
        @"eur_sources_grants_src": @"eurSourcesGrantsSrc",
        @"eur_sources_procurement": @"eurSourcesProcurement",
        @"eur_sources_procurement_src": @"eurSourcesProcurementSrc",
        @"id": @"identifier",
        @"no_clients": @"noClients",
        @"other_financial_information": @"otherFinancialInformation",
        @"other_sources_contributions": @"otherSourcesContributions",
        @"other_sources_donation": @"otherSourcesDonation",
        @"other_sources_total": @"otherSourcesTotal",
        @"public_financing_infranational": @"publicFinancingInfranational",
        @"public_financing_national": @"publicFinancingNational",
        @"public_financing_total": @"publicFinancingTotal",
        @"representative": @"representative",
        @"start_date": @"startDate",
        @"status": @"status",
        @"new_organisation": @"theNewOrganisation",
        @"total_budget": @"totalBudget",
        @"turnover_absolute": @"turnoverAbsolute",
        @"turnover_max": @"turnoverMax",
        @"turnover_min": @"turnoverMin",
        @"type": @"type",
        @"updated_at": @"updatedAt",
        @"uri": @"uri",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResult alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"cost_absolute"]) return nil;
        if (!dict[@"cost_max"]) return nil;
        if (!dict[@"cost_min"]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"customIncomes"] isKindOfClass:NSArray.class]) return nil;
        if (!dict[@"direct_rep_costs_max"]) return nil;
        if (!dict[@"direct_rep_costs_min"]) return nil;
        if (dict[@"end_date"] && [dict[@"end_date"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"end_date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"eur_sources_grants"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"eur_sources_grants"] doubleValue] != [dict[@"eur_sources_grants"] longLongValue]) return nil;
        if (!dict[@"eur_sources_grants_src"]) return nil;
        if (![dict[@"eur_sources_procurement"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"eur_sources_procurement"] doubleValue] != [dict[@"eur_sources_procurement"] longLongValue]) return nil;
        if (!dict[@"eur_sources_procurement_src"]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"no_clients"]) return nil;
        if (!dict[@"other_financial_information"]) return nil;
        if (!dict[@"other_sources_contributions"]) return nil;
        if (!dict[@"other_sources_donation"]) return nil;
        if (!dict[@"other_sources_total"]) return nil;
        if (!dict[@"public_financing_infranational"]) return nil;
        if (!dict[@"public_financing_national"]) return nil;
        if (!dict[@"public_financing_total"]) return nil;
        if (![dict[@"representative"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"start_date"] && [dict[@"start_date"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"start_date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"new_organisation"]) return nil;
        if (!dict[@"total_budget"]) return nil;
        if (!dict[@"turnover_absolute"]) return nil;
        if (!dict[@"turnover_max"]) return nil;
        if (!dict[@"turnover_min"]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"uri"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _customIncomes = map(_customIncomes, λ(id x, [QTCustomIncome fromJSONDictionary:x]));
        _status = [QTStatus withValue:(id)_status];
        _type = [QTResultType withValue:(id)_type];
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
        @"customIncomes": map(_customIncomes, λ(id x, [x JSONDictionary])),
        @"status": [_status value],
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTCustomIncome
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"amount": @"amount",
        @"created_at": @"createdAt",
        @"id": @"identifier",
        @"name": @"name",
        @"status": @"status",
        @"type": @"type",
        @"updated_at": @"updatedAt",
        @"uri": @"uri",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCustomIncome alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"amount"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"amount"] doubleValue] != [dict[@"amount"] longLongValue]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"uri"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _status = [QTStatus withValue:(id)_status];
        _type = [QTCustomIncomeType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCustomIncome.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCustomIncome.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCustomIncome.properties.allValues] mutableCopy];

    for (id jsonName in QTCustomIncome.properties) {
        id propertyName = QTCustomIncome.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"status": [_status value],
        @"type": [_type value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
