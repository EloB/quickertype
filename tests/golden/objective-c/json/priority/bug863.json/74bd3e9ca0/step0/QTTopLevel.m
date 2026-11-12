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

@interface QTFluffyQTTopLevel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTBreed
+ (NSDictionary<NSString *, QTBreed *> *)values
{
    static NSDictionary<NSString *, QTBreed *> *values;
    return values = values ? values : @{
        @"Atrox": [[QTBreed alloc] initWithValue:@"Atrox"],
        @"Solitus": [[QTBreed alloc] initWithValue:@"Solitus"],
        @"Opifex": [[QTBreed alloc] initWithValue:@"Opifex"],
        @"Nano": [[QTBreed alloc] initWithValue:@"Nano"],
    };
}

+ (QTBreed *)atrox { return QTBreed.values[@"Atrox"]; }
+ (QTBreed *)solitus { return QTBreed.values[@"Solitus"]; }
+ (QTBreed *)opifex { return QTBreed.values[@"Opifex"]; }
+ (QTBreed *)nano { return QTBreed.values[@"Nano"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTBreed.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFirstname
+ (NSDictionary<NSString *, QTFirstname *> *)values
{
    static NSDictionary<NSString *, QTFirstname *> *values;
    return values = values ? values : @{
        @"": [[QTFirstname alloc] initWithValue:@""],
        @"Chi": [[QTFirstname alloc] initWithValue:@"Chi"],
    };
}

+ (QTFirstname *)empty { return QTFirstname.values[@""]; }
+ (QTFirstname *)chi { return QTFirstname.values[@"Chi"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFirstname.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLastname
+ (NSDictionary<NSString *, QTLastname *> *)values
{
    static NSDictionary<NSString *, QTLastname *> *values;
    return values = values ? values : @{
        @"": [[QTLastname alloc] initWithValue:@""],
        @"Washko": [[QTLastname alloc] initWithValue:@"Washko"],
    };
}

+ (QTLastname *)empty { return QTLastname.values[@""]; }
+ (QTLastname *)washko { return QTLastname.values[@"Washko"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLastname.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTPvptitle
+ (NSDictionary<NSString *, QTPvptitle *> *)values
{
    static NSDictionary<NSString *, QTPvptitle *> *values;
    return values = values ? values : @{
        @"Freshman": [[QTPvptitle alloc] initWithValue:@"Freshman"],
    };
}

+ (QTPvptitle *)freshman { return QTPvptitle.values[@"Freshman"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPvptitle.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRankTitle
+ (NSDictionary<NSString *, QTRankTitle *> *)values
{
    static NSDictionary<NSString *, QTRankTitle *> *values;
    return values = values ? values : @{
        @"President": [[QTRankTitle alloc] initWithValue:@"President"],
        @"Advisor": [[QTRankTitle alloc] initWithValue:@"Advisor"],
        @"Veteran": [[QTRankTitle alloc] initWithValue:@"Veteran"],
        @"Applicant": [[QTRankTitle alloc] initWithValue:@"Applicant"],
    };
}

+ (QTRankTitle *)president { return QTRankTitle.values[@"President"]; }
+ (QTRankTitle *)advisor { return QTRankTitle.values[@"Advisor"]; }
+ (QTRankTitle *)veteran { return QTRankTitle.values[@"Veteran"]; }
+ (QTRankTitle *)applicant { return QTRankTitle.values[@"Applicant"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRankTitle.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSex
+ (NSDictionary<NSString *, QTSex *> *)values
{
    static NSDictionary<NSString *, QTSex *> *values;
    return values = values ? values : @{
        @"Neuter": [[QTSex alloc] initWithValue:@"Neuter"],
        @"Male": [[QTSex alloc] initWithValue:@"Male"],
        @"Female": [[QTSex alloc] initWithValue:@"Female"],
    };
}

+ (QTSex *)neuter { return QTSex.values[@"Neuter"]; }
+ (QTSex *)male { return QTSex.values[@"Male"]; }
+ (QTSex *)female { return QTSex.values[@"Female"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSex.values[value];
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
        @"ALIENLEVEL": @"alienlevel",
        @"BREED": @"breed",
        @"CHAR_DIMENSION": @"charDimension",
        @"CHAR_INSTANCE": @"charInstance",
        @"DEFENDER_RANK_TITLE": @"defenderRankTitle",
        @"FIRSTNAME": @"firstname",
        @"HEADID": @"headid",
        @"LASTNAME": @"lastname",
        @"LEVELX": @"levelx",
        @"NAME": @"name",
        @"PROF": @"prof",
        @"PROF_TITLE": @"profTitle",
        @"PVPRATING": @"pvprating",
        @"PVPTITLE": @"pvptitle",
        @"RANK": @"rank",
        @"RANK_TITLE": @"rankTitle",
        @"SEX": @"sex",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleQTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ALIENLEVEL"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ALIENLEVEL"] doubleValue] != [dict[@"ALIENLEVEL"] longLongValue]) return nil;
        if (![dict[@"BREED"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"CHAR_DIMENSION"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"CHAR_DIMENSION"] doubleValue] != [dict[@"CHAR_DIMENSION"] longLongValue]) return nil;
        if (![dict[@"CHAR_INSTANCE"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"CHAR_INSTANCE"] doubleValue] != [dict[@"CHAR_INSTANCE"] longLongValue]) return nil;
        if (![dict[@"DEFENDER_RANK_TITLE"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"FIRSTNAME"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"HEADID"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"HEADID"] doubleValue] != [dict[@"HEADID"] longLongValue]) return nil;
        if (![dict[@"LASTNAME"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"LEVELX"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"LEVELX"] doubleValue] != [dict[@"LEVELX"] longLongValue]) return nil;
        if (![dict[@"NAME"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"PROF"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"PROF_TITLE"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"PVPRATING"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"PVPRATING"] doubleValue] != [dict[@"PVPRATING"] longLongValue]) return nil;
        if (![dict[@"PVPTITLE"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"RANK"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"RANK"] doubleValue] != [dict[@"RANK"] longLongValue]) return nil;
        if (![dict[@"RANK_TITLE"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"SEX"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _breed = [QTBreed withValue:(id)_breed];
        _firstname = [QTFirstname withValue:(id)_firstname];
        _lastname = [QTLastname withValue:(id)_lastname];
        _pvptitle = [QTPvptitle withValue:(id)_pvptitle];
        _rankTitle = [QTRankTitle withValue:(id)_rankTitle];
        _sex = [QTSex withValue:(id)_sex];
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
        @"BREED": [_breed value],
        @"FIRSTNAME": [_firstname value],
        @"LASTNAME": [_lastname value],
        @"PVPTITLE": [_pvptitle value],
        @"RANK_TITLE": [_rankTitle value],
        @"SEX": [_sex value],
    }];

    return dict;
}
@end

@implementation QTFluffyQTTopLevel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ADVENTURERCOUNT": @"adventurercount",
        @"AGENTCOUNT": @"agentcount",
        @"ATROXCOUNT": @"atroxcount",
        @"AVGLVL": @"avglvl",
        @"BTCOUNT": @"btcount",
        @"DOCTORCOUNT": @"doctorcount",
        @"ENFCOUNT": @"enfcount",
        @"ENGINEEERCOUNT": @"engineeercount",
        @"FEMALECOUNT": @"femalecount",
        @"FIXERCOUNT": @"fixercount",
        @"GOVERNINGNAME": @"governingname",
        @"HISTORY": @"history",
        @"KEEPERCOUNT": @"keepercount",
        @"MACOUNT": @"macount",
        @"MALECOUNT": @"malecount",
        @"MAXLVL": @"maxlvl",
        @"METACOUNT": @"metacount",
        @"MINLVL": @"minlvl",
        @"MONSTERCOUNT": @"monstercount",
        @"NAME": @"name",
        @"NANOCOUNT": @"nanocount",
        @"NANORACECOUNT": @"nanoracecount",
        @"NEUTERCOUNT": @"neutercount",
        @"NUMMEMBERS": @"nummembers",
        @"OBJECTIVE": @"objective",
        @"OPIFEXCOUNT": @"opifexcount",
        @"ORG_DIMENSION": @"orgDimension",
        @"ORG_INSTANCE": @"orgInstance",
        @"DESCRIPTION": @"qtTopLevelDESCRIPTION",
        @"SHADECOUNT": @"shadecount",
        @"SIDE": @"side",
        @"SIDE_NAME": @"sideName",
        @"SOLIDERCOUNT": @"solidercount",
        @"SOLITUSCOUNT": @"solituscount",
        @"TRADERCOUNT": @"tradercount",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyQTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ADVENTURERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ADVENTURERCOUNT"] doubleValue] != [dict[@"ADVENTURERCOUNT"] longLongValue]) return nil;
        if (![dict[@"AGENTCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"AGENTCOUNT"] doubleValue] != [dict[@"AGENTCOUNT"] longLongValue]) return nil;
        if (![dict[@"ATROXCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ATROXCOUNT"] doubleValue] != [dict[@"ATROXCOUNT"] longLongValue]) return nil;
        if (![dict[@"AVGLVL"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"BTCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"BTCOUNT"] doubleValue] != [dict[@"BTCOUNT"] longLongValue]) return nil;
        if (![dict[@"DOCTORCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DOCTORCOUNT"] doubleValue] != [dict[@"DOCTORCOUNT"] longLongValue]) return nil;
        if (![dict[@"ENFCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ENFCOUNT"] doubleValue] != [dict[@"ENFCOUNT"] longLongValue]) return nil;
        if (![dict[@"ENGINEEERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ENGINEEERCOUNT"] doubleValue] != [dict[@"ENGINEEERCOUNT"] longLongValue]) return nil;
        if (![dict[@"FEMALECOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"FEMALECOUNT"] doubleValue] != [dict[@"FEMALECOUNT"] longLongValue]) return nil;
        if (![dict[@"FIXERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"FIXERCOUNT"] doubleValue] != [dict[@"FIXERCOUNT"] longLongValue]) return nil;
        if (![dict[@"GOVERNINGNAME"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"HISTORY"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"KEEPERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"KEEPERCOUNT"] doubleValue] != [dict[@"KEEPERCOUNT"] longLongValue]) return nil;
        if (![dict[@"MACOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"MACOUNT"] doubleValue] != [dict[@"MACOUNT"] longLongValue]) return nil;
        if (![dict[@"MALECOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"MALECOUNT"] doubleValue] != [dict[@"MALECOUNT"] longLongValue]) return nil;
        if (![dict[@"MAXLVL"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"MAXLVL"] doubleValue] != [dict[@"MAXLVL"] longLongValue]) return nil;
        if (![dict[@"METACOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"METACOUNT"] doubleValue] != [dict[@"METACOUNT"] longLongValue]) return nil;
        if (![dict[@"MINLVL"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"MINLVL"] doubleValue] != [dict[@"MINLVL"] longLongValue]) return nil;
        if (![dict[@"MONSTERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"MONSTERCOUNT"] doubleValue] != [dict[@"MONSTERCOUNT"] longLongValue]) return nil;
        if (![dict[@"NAME"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"NANOCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NANOCOUNT"] doubleValue] != [dict[@"NANOCOUNT"] longLongValue]) return nil;
        if (![dict[@"NANORACECOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NANORACECOUNT"] doubleValue] != [dict[@"NANORACECOUNT"] longLongValue]) return nil;
        if (![dict[@"NEUTERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NEUTERCOUNT"] doubleValue] != [dict[@"NEUTERCOUNT"] longLongValue]) return nil;
        if (![dict[@"NUMMEMBERS"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NUMMEMBERS"] doubleValue] != [dict[@"NUMMEMBERS"] longLongValue]) return nil;
        if (![dict[@"OBJECTIVE"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"OPIFEXCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"OPIFEXCOUNT"] doubleValue] != [dict[@"OPIFEXCOUNT"] longLongValue]) return nil;
        if (![dict[@"ORG_DIMENSION"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ORG_DIMENSION"] doubleValue] != [dict[@"ORG_DIMENSION"] longLongValue]) return nil;
        if (![dict[@"ORG_INSTANCE"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ORG_INSTANCE"] doubleValue] != [dict[@"ORG_INSTANCE"] longLongValue]) return nil;
        if (![dict[@"DESCRIPTION"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"SHADECOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SHADECOUNT"] doubleValue] != [dict[@"SHADECOUNT"] longLongValue]) return nil;
        if (![dict[@"SIDE"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SIDE"] doubleValue] != [dict[@"SIDE"] longLongValue]) return nil;
        if (![dict[@"SIDE_NAME"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"SOLIDERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SOLIDERCOUNT"] doubleValue] != [dict[@"SOLIDERCOUNT"] longLongValue]) return nil;
        if (![dict[@"SOLITUSCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SOLITUSCOUNT"] doubleValue] != [dict[@"SOLITUSCOUNT"] longLongValue]) return nil;
        if (![dict[@"TRADERCOUNT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"TRADERCOUNT"] doubleValue] != [dict[@"TRADERCOUNT"] longLongValue]) return nil;
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
