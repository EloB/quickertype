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

@interface QTOthermatch (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTeam (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPbp (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTScorer (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTime (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTm (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLds (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSBlocks (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPl (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTComp (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTShot (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTotallds (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTLeaddatumEnum
+ (NSDictionary<NSString *, QTLeaddatumEnum *> *)values
{
    static NSDictionary<NSString *, QTLeaddatumEnum *> *values;
    return values = values ? values : @{
        @"": [[QTLeaddatumEnum alloc] initWithValue:@""],
        @"P1": [[QTLeaddatumEnum alloc] initWithValue:@"P1"],
        @"P2": [[QTLeaddatumEnum alloc] initWithValue:@"P2"],
        @"P3": [[QTLeaddatumEnum alloc] initWithValue:@"P3"],
        @"P4": [[QTLeaddatumEnum alloc] initWithValue:@"P4"],
    };
}

+ (QTLeaddatumEnum *)empty { return QTLeaddatumEnum.values[@""]; }
+ (QTLeaddatumEnum *)p1 { return QTLeaddatumEnum.values[@"P1"]; }
+ (QTLeaddatumEnum *)p2 { return QTLeaddatumEnum.values[@"P2"]; }
+ (QTLeaddatumEnum *)p3 { return QTLeaddatumEnum.values[@"P3"]; }
+ (QTLeaddatumEnum *)p4 { return QTLeaddatumEnum.values[@"P4"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLeaddatumEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTPerType
+ (NSDictionary<NSString *, QTPerType *> *)values
{
    static NSDictionary<NSString *, QTPerType *> *values;
    return values = values ? values : @{
        @"REGULAR": [[QTPerType alloc] initWithValue:@"REGULAR"],
    };
}

+ (QTPerType *)regular { return QTPerType.values[@"REGULAR"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPerType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTActionType
+ (NSDictionary<NSString *, QTActionType *> *)values
{
    static NSDictionary<NSString *, QTActionType *> *values;
    return values = values ? values : @{
        @"game": [[QTActionType alloc] initWithValue:@"game"],
        @"period": [[QTActionType alloc] initWithValue:@"period"],
        @"3pt": [[QTActionType alloc] initWithValue:@"3pt"],
        @"2pt": [[QTActionType alloc] initWithValue:@"2pt"],
        @"rebound": [[QTActionType alloc] initWithValue:@"rebound"],
        @"timeout": [[QTActionType alloc] initWithValue:@"timeout"],
        @"foulon": [[QTActionType alloc] initWithValue:@"foulon"],
        @"foul": [[QTActionType alloc] initWithValue:@"foul"],
        @"assist": [[QTActionType alloc] initWithValue:@"assist"],
        @"substitution": [[QTActionType alloc] initWithValue:@"substitution"],
        @"freethrow": [[QTActionType alloc] initWithValue:@"freethrow"],
        @"steal": [[QTActionType alloc] initWithValue:@"steal"],
        @"turnover": [[QTActionType alloc] initWithValue:@"turnover"],
        @"block": [[QTActionType alloc] initWithValue:@"block"],
        @"jumpball": [[QTActionType alloc] initWithValue:@"jumpball"],
    };
}

+ (QTActionType *)game { return QTActionType.values[@"game"]; }
+ (QTActionType *)period { return QTActionType.values[@"period"]; }
+ (QTActionType *)the3Pt { return QTActionType.values[@"3pt"]; }
+ (QTActionType *)the2Pt { return QTActionType.values[@"2pt"]; }
+ (QTActionType *)rebound { return QTActionType.values[@"rebound"]; }
+ (QTActionType *)timeout { return QTActionType.values[@"timeout"]; }
+ (QTActionType *)foulon { return QTActionType.values[@"foulon"]; }
+ (QTActionType *)foul { return QTActionType.values[@"foul"]; }
+ (QTActionType *)assist { return QTActionType.values[@"assist"]; }
+ (QTActionType *)substitution { return QTActionType.values[@"substitution"]; }
+ (QTActionType *)freethrow { return QTActionType.values[@"freethrow"]; }
+ (QTActionType *)steal { return QTActionType.values[@"steal"]; }
+ (QTActionType *)turnover { return QTActionType.values[@"turnover"]; }
+ (QTActionType *)block { return QTActionType.values[@"block"]; }
+ (QTActionType *)jumpball { return QTActionType.values[@"jumpball"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTActionType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFamilyNameInitial
+ (NSDictionary<NSString *, QTFamilyNameInitial *> *)values
{
    static NSDictionary<NSString *, QTFamilyNameInitial *> *values;
    return values = values ? values : @{
        @"R": [[QTFamilyNameInitial alloc] initWithValue:@"R"],
        @"M": [[QTFamilyNameInitial alloc] initWithValue:@"M"],
        @"s": [[QTFamilyNameInitial alloc] initWithValue:@"s"],
        @"C": [[QTFamilyNameInitial alloc] initWithValue:@"C"],
        @"O": [[QTFamilyNameInitial alloc] initWithValue:@"O"],
        @"W": [[QTFamilyNameInitial alloc] initWithValue:@"W"],
        @"A": [[QTFamilyNameInitial alloc] initWithValue:@"A"],
        @"P": [[QTFamilyNameInitial alloc] initWithValue:@"P"],
        @"V": [[QTFamilyNameInitial alloc] initWithValue:@"V"],
        @"I": [[QTFamilyNameInitial alloc] initWithValue:@"I"],
        @"J": [[QTFamilyNameInitial alloc] initWithValue:@"J"],
        @"S": [[QTFamilyNameInitial alloc] initWithValue:@"S"],
        @"H": [[QTFamilyNameInitial alloc] initWithValue:@"H"],
        @"B": [[QTFamilyNameInitial alloc] initWithValue:@"B"],
    };
}

+ (QTFamilyNameInitial *)r { return QTFamilyNameInitial.values[@"R"]; }
+ (QTFamilyNameInitial *)m { return QTFamilyNameInitial.values[@"M"]; }
+ (QTFamilyNameInitial *)s { return QTFamilyNameInitial.values[@"s"]; }
+ (QTFamilyNameInitial *)c { return QTFamilyNameInitial.values[@"C"]; }
+ (QTFamilyNameInitial *)o { return QTFamilyNameInitial.values[@"O"]; }
+ (QTFamilyNameInitial *)w { return QTFamilyNameInitial.values[@"W"]; }
+ (QTFamilyNameInitial *)a { return QTFamilyNameInitial.values[@"A"]; }
+ (QTFamilyNameInitial *)p { return QTFamilyNameInitial.values[@"P"]; }
+ (QTFamilyNameInitial *)v { return QTFamilyNameInitial.values[@"V"]; }
+ (QTFamilyNameInitial *)i { return QTFamilyNameInitial.values[@"I"]; }
+ (QTFamilyNameInitial *)j { return QTFamilyNameInitial.values[@"J"]; }
+ (QTFamilyNameInitial *)familyNameInitialS { return QTFamilyNameInitial.values[@"S"]; }
+ (QTFamilyNameInitial *)h { return QTFamilyNameInitial.values[@"H"]; }
+ (QTFamilyNameInitial *)b { return QTFamilyNameInitial.values[@"B"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFamilyNameInitial.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFirstNameInitial
+ (NSDictionary<NSString *, QTFirstNameInitial *> *)values
{
    static NSDictionary<NSString *, QTFirstNameInitial *> *values;
    return values = values ? values : @{
        @"D": [[QTFirstNameInitial alloc] initWithValue:@"D"],
        @"J": [[QTFirstNameInitial alloc] initWithValue:@"J"],
        @"T": [[QTFirstNameInitial alloc] initWithValue:@"T"],
        @"C": [[QTFirstNameInitial alloc] initWithValue:@"C"],
        @"O": [[QTFirstNameInitial alloc] initWithValue:@"O"],
        @"H": [[QTFirstNameInitial alloc] initWithValue:@"H"],
        @"L": [[QTFirstNameInitial alloc] initWithValue:@"L"],
        @"A": [[QTFirstNameInitial alloc] initWithValue:@"A"],
        @"K": [[QTFirstNameInitial alloc] initWithValue:@"K"],
        @"R": [[QTFirstNameInitial alloc] initWithValue:@"R"],
        @"B": [[QTFirstNameInitial alloc] initWithValue:@"B"],
        @"N": [[QTFirstNameInitial alloc] initWithValue:@"N"],
    };
}

+ (QTFirstNameInitial *)d { return QTFirstNameInitial.values[@"D"]; }
+ (QTFirstNameInitial *)j { return QTFirstNameInitial.values[@"J"]; }
+ (QTFirstNameInitial *)t { return QTFirstNameInitial.values[@"T"]; }
+ (QTFirstNameInitial *)c { return QTFirstNameInitial.values[@"C"]; }
+ (QTFirstNameInitial *)o { return QTFirstNameInitial.values[@"O"]; }
+ (QTFirstNameInitial *)h { return QTFirstNameInitial.values[@"H"]; }
+ (QTFirstNameInitial *)l { return QTFirstNameInitial.values[@"L"]; }
+ (QTFirstNameInitial *)a { return QTFirstNameInitial.values[@"A"]; }
+ (QTFirstNameInitial *)k { return QTFirstNameInitial.values[@"K"]; }
+ (QTFirstNameInitial *)r { return QTFirstNameInitial.values[@"R"]; }
+ (QTFirstNameInitial *)b { return QTFirstNameInitial.values[@"B"]; }
+ (QTFirstNameInitial *)n { return QTFirstNameInitial.values[@"N"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFirstNameInitial.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTScoreboardName
+ (NSDictionary<NSString *, QTScoreboardName *> *)values
{
    static NSDictionary<NSString *, QTScoreboardName *> *values;
    return values = values ? values : @{
        @"": [[QTScoreboardName alloc] initWithValue:@""],
        @"T. s": [[QTScoreboardName alloc] initWithValue:@"T. s"],
        @"R. Ihata": [[QTScoreboardName alloc] initWithValue:@"R. Ihata"],
        @"D. Jones": [[QTScoreboardName alloc] initWithValue:@"D. Jones"],
        @"B. Valentine": [[QTScoreboardName alloc] initWithValue:@"B. Valentine"],
    };
}

+ (QTScoreboardName *)empty { return QTScoreboardName.values[@""]; }
+ (QTScoreboardName *)tS { return QTScoreboardName.values[@"T. s"]; }
+ (QTScoreboardName *)rIhata { return QTScoreboardName.values[@"R. Ihata"]; }
+ (QTScoreboardName *)dJones { return QTScoreboardName.values[@"D. Jones"]; }
+ (QTScoreboardName *)bValentine { return QTScoreboardName.values[@"B. Valentine"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTScoreboardName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSubType
+ (NSDictionary<NSString *, QTSubType *> *)values
{
    static NSDictionary<NSString *, QTSubType *> *values;
    return values = values ? values : @{
        @"jumpshot": [[QTSubType alloc] initWithValue:@"jumpshot"],
        @"layup": [[QTSubType alloc] initWithValue:@"layup"],
        @"dunk": [[QTSubType alloc] initWithValue:@"dunk"],
    };
}

+ (QTSubType *)jumpshot { return QTSubType.values[@"jumpshot"]; }
+ (QTSubType *)layup { return QTSubType.values[@"layup"]; }
+ (QTSubType *)dunk { return QTSubType.values[@"dunk"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSubType.values[value];
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
        @"attendance": @"attendance",
        @"clock": @"clock",
        @"disableMatch": @"disableMatch",
        @"inOT": @"inOT",
        @"leaddata": @"leaddata",
        @"officials_referee1": @"officialsReferee1",
        @"officials_referee2": @"officialsReferee2",
        @"officials_referee3": @"officialsReferee3",
        @"othermatches": @"othermatches",
        @"pbp": @"pbp",
        @"period": @"period",
        @"periodLengthOVERTIME": @"periodLengthOVERTIME",
        @"periodLengthREGULAR": @"periodLengthREGULAR",
        @"periodType": @"periodType",
        @"periodsMax": @"periodsMax",
        @"scorers": @"scorers",
        @"timeline": @"timeline",
        @"tm": @"tm",
        @"totalTimeAdded": @"totalTimeAdded",
        @"totallds": @"totallds",
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
        if (![dict[@"attendance"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"attendance"] doubleValue] != [dict[@"attendance"] longLongValue]) return nil;
        if (![dict[@"clock"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"disableMatch"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"disableMatch"] doubleValue] != [dict[@"disableMatch"] longLongValue]) return nil;
        if (![dict[@"inOT"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"inOT"] doubleValue] != [dict[@"inOT"] longLongValue]) return nil;
        if (![dict[@"leaddata"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"officials_referee1"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"officials_referee2"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"officials_referee3"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"othermatches"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"pbp"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"period"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"period"] doubleValue] != [dict[@"period"] longLongValue]) return nil;
        if (![dict[@"periodLengthOVERTIME"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"periodLengthOVERTIME"] doubleValue] != [dict[@"periodLengthOVERTIME"] longLongValue]) return nil;
        if (![dict[@"periodLengthREGULAR"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"periodLengthREGULAR"] doubleValue] != [dict[@"periodLengthREGULAR"] longLongValue]) return nil;
        if (![dict[@"periodType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"periodsMax"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"periodsMax"] doubleValue] != [dict[@"periodsMax"] longLongValue]) return nil;
        if (![dict[@"scorers"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"timeline"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"tm"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"totalTimeAdded"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalTimeAdded"] doubleValue] != [dict[@"totalTimeAdded"] longLongValue]) return nil;
        if (![dict[@"totallds"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _othermatches = map(_othermatches, λ(id x, [QTOthermatch fromJSONDictionary:x]));
        _pbp = map(_pbp, λ(id x, [QTPbp fromJSONDictionary:x]));
        _periodType = [QTPerType withValue:(id)_periodType];
        _scorers = map(_scorers, λ(id x, map(x, λ(id x, [QTScorer fromJSONDictionary:x]))));
        _tm = map(_tm, λ(id x, [QTTm fromJSONDictionary:x]));
        _totallds = [QTTotallds fromJSONDictionary:(id)_totallds];
        if (!_totallds && dict[@"totallds"] && ![dict[@"totallds"] isKindOfClass:NSNull.class]) return nil;
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
        @"othermatches": map(_othermatches, λ(id x, [x JSONDictionary])),
        @"pbp": map(_pbp, λ(id x, [x JSONDictionary])),
        @"periodType": [_periodType value],
        @"scorers": map(_scorers, λ(id x, map(x, λ(id x, [x JSONDictionary])))),
        @"tm": map(_tm, λ(id x, [x JSONDictionary])),
        @"totallds": [_totallds JSONDictionary],
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

@implementation QTOthermatch
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"clock": @"clock",
        @"competitionName": @"competitionName",
        @"id": @"identifier",
        @"period": @"period",
        @"periodType": @"periodType",
        @"team1": @"team1",
        @"team1Name": @"team1Name",
        @"team1Score": @"team1Score",
        @"team2": @"team2",
        @"team2Name": @"team2Name",
        @"team2Score": @"team2Score",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOthermatch alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"clock"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"competitionName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"period"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"period"] doubleValue] != [dict[@"period"] longLongValue]) return nil;
        if (![dict[@"periodType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"team1"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"team1Name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"team1Score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"team1Score"] doubleValue] != [dict[@"team1Score"] longLongValue]) return nil;
        if (![dict[@"team2"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"team2Name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"team2Score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"team2Score"] doubleValue] != [dict[@"team2Score"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _periodType = [QTPerType withValue:(id)_periodType];
        _team1 = [QTTeam fromJSONDictionary:(id)_team1];
        if (!_team1 && dict[@"team1"] && ![dict[@"team1"] isKindOfClass:NSNull.class]) return nil;
        _team2 = [QTTeam fromJSONDictionary:(id)_team2];
        if (!_team2 && dict[@"team2"] && ![dict[@"team2"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOthermatch.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOthermatch.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOthermatch.properties.allValues] mutableCopy];

    for (id jsonName in QTOthermatch.properties) {
        id propertyName = QTOthermatch.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"periodType": [_periodType value],
        @"team1": [_team1 JSONDictionary],
        @"team2": [_team2 JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTTeam
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"teamCode": @"teamCode",
        @"teamCodeInternational": @"teamCodeInternational",
        @"teamName": @"teamName",
        @"teamNameInternational": @"teamNameInternational",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTeam alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"teamCode"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"teamCodeInternational"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"teamName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"teamNameInternational"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTeam.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTeam.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTeam.properties.allValues];
}
@end

@implementation QTPbp
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"actionType": @"actionType",
        @"familyName": @"familyName",
        @"familyNameInitial": @"familyNameInitial",
        @"firstName": @"firstName",
        @"firstNameInitial": @"firstNameInitial",
        @"gt": @"gt",
        @"internationalFamilyName": @"internationalFamilyName",
        @"internationalFamilyNameInitial": @"internationalFamilyNameInitial",
        @"internationalFirstName": @"internationalFirstName",
        @"internationalFirstNameInitial": @"internationalFirstNameInitial",
        @"lead": @"lead",
        @"period": @"period",
        @"periodType": @"periodType",
        @"player": @"player",
        @"pno": @"pno",
        @"qualifier": @"qualifier",
        @"s1": @"s1",
        @"s2": @"s2",
        @"scoreboardName": @"scoreboardName",
        @"scoring": @"scoring",
        @"shirtNumber": @"shirtNumber",
        @"subType": @"subType",
        @"success": @"success",
        @"tno": @"tno",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPbp alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"actionType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"gt"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"lead"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"lead"] doubleValue] != [dict[@"lead"] longLongValue]) return nil;
        if (![dict[@"period"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"period"] doubleValue] != [dict[@"period"] longLongValue]) return nil;
        if (![dict[@"periodType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"player"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"pno"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"pno"] doubleValue] != [dict[@"pno"] longLongValue]) return nil;
        if (![dict[@"qualifier"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"s1"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"s1"] doubleValue] != [dict[@"s1"] longLongValue]) return nil;
        if (![dict[@"s2"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"s2"] doubleValue] != [dict[@"s2"] longLongValue]) return nil;
        if (![dict[@"scoring"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"scoring"] doubleValue] != [dict[@"scoring"] longLongValue]) return nil;
        if (![dict[@"shirtNumber"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"success"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"success"] doubleValue] != [dict[@"success"] longLongValue]) return nil;
        if (![dict[@"tno"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tno"] doubleValue] != [dict[@"tno"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _actionType = [QTActionType withValue:(id)_actionType];
        _familyNameInitial = [QTFamilyNameInitial withValue:(id)_familyNameInitial];
        if (_familyNameInitial == nil && dict[@"familyNameInitial"] && ![dict[@"familyNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _firstNameInitial = [QTFirstNameInitial withValue:(id)_firstNameInitial];
        if (_firstNameInitial == nil && dict[@"firstNameInitial"] && ![dict[@"firstNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _internationalFamilyNameInitial = [QTFamilyNameInitial withValue:(id)_internationalFamilyNameInitial];
        if (_internationalFamilyNameInitial == nil && dict[@"internationalFamilyNameInitial"] && ![dict[@"internationalFamilyNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _internationalFirstNameInitial = [QTFirstNameInitial withValue:(id)_internationalFirstNameInitial];
        if (_internationalFirstNameInitial == nil && dict[@"internationalFirstNameInitial"] && ![dict[@"internationalFirstNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _periodType = [QTPerType withValue:(id)_periodType];
        _scoreboardName = [QTScoreboardName withValue:(id)_scoreboardName];
        if (_scoreboardName == nil && dict[@"scoreboardName"] && ![dict[@"scoreboardName"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPbp.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPbp.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPbp.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"actionType": [_actionType value],
        @"familyNameInitial": NSNullify([_familyNameInitial value]),
        @"firstNameInitial": NSNullify([_firstNameInitial value]),
        @"internationalFamilyNameInitial": NSNullify([_internationalFamilyNameInitial value]),
        @"internationalFirstNameInitial": NSNullify([_internationalFirstNameInitial value]),
        @"periodType": [_periodType value],
        @"scoreboardName": NSNullify([_scoreboardName value]),
    }];

    return dict;
}
@end

@implementation QTScorer
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"familyName": @"familyName",
        @"familyNameInitial": @"familyNameInitial",
        @"firstName": @"firstName",
        @"firstNameInitial": @"firstNameInitial",
        @"gt": @"gt",
        @"internationalFamilyName": @"internationalFamilyName",
        @"internationalFamilyNameInitial": @"internationalFamilyNameInitial",
        @"internationalFirstName": @"internationalFirstName",
        @"internationalFirstNameInitial": @"internationalFirstNameInitial",
        @"name": @"name",
        @"per": @"per",
        @"perType": @"perType",
        @"player": @"player",
        @"pno": @"pno",
        @"scoreboardName": @"scoreboardName",
        @"shirtNumber": @"shirtNumber",
        @"summary": @"summary",
        @"times": @"times",
        @"tno": @"tno",
        @"tot": @"tot",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTScorer alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"pno"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"pno"] doubleValue] != [dict[@"pno"] longLongValue]) return nil;
        if (![dict[@"shirtNumber"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tno"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tno"] doubleValue] != [dict[@"tno"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _familyNameInitial = [QTFamilyNameInitial withValue:(id)_familyNameInitial];
        if (_familyNameInitial == nil && dict[@"familyNameInitial"] && ![dict[@"familyNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _firstNameInitial = [QTFirstNameInitial withValue:(id)_firstNameInitial];
        if (_firstNameInitial == nil && dict[@"firstNameInitial"] && ![dict[@"firstNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _internationalFamilyNameInitial = [QTFamilyNameInitial withValue:(id)_internationalFamilyNameInitial];
        if (_internationalFamilyNameInitial == nil && dict[@"internationalFamilyNameInitial"] && ![dict[@"internationalFamilyNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _internationalFirstNameInitial = [QTFirstNameInitial withValue:(id)_internationalFirstNameInitial];
        if (_internationalFirstNameInitial == nil && dict[@"internationalFirstNameInitial"] && ![dict[@"internationalFirstNameInitial"] isKindOfClass:NSNull.class]) return nil;
        _perType = [QTPerType withValue:(id)_perType];
        if (_perType == nil && dict[@"perType"] && ![dict[@"perType"] isKindOfClass:NSNull.class]) return nil;
        _scoreboardName = [QTScoreboardName withValue:(id)_scoreboardName];
        if (_scoreboardName == nil && dict[@"scoreboardName"] && ![dict[@"scoreboardName"] isKindOfClass:NSNull.class]) return nil;
        _times = map(_times, λ(id x, [QTTime fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTScorer.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTScorer.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTScorer.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"familyNameInitial": NSNullify([_familyNameInitial value]),
        @"firstNameInitial": NSNullify([_firstNameInitial value]),
        @"internationalFamilyNameInitial": NSNullify([_internationalFamilyNameInitial value]),
        @"internationalFirstNameInitial": NSNullify([_internationalFirstNameInitial value]),
        @"perType": NSNullify([_perType value]),
        @"scoreboardName": NSNullify([_scoreboardName value]),
        @"times": NSNullify(map(_times, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTTime
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"gt": @"gt",
        @"per": @"per",
        @"perType": @"perType",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTime alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"gt"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"per"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"per"] doubleValue] != [dict[@"per"] longLongValue]) return nil;
        if (![dict[@"perType"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _perType = [QTPerType withValue:(id)_perType];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTime.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTime.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTime.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"perType": [_perType value],
    }];

    return dict;
}
@end

@implementation QTTm
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"code": @"code",
        @"codeInternational": @"codeInternational",
        @"fouls": @"fouls",
        @"full_score": @"fullScore",
        @"lds": @"lds",
        @"logo": @"logo",
        @"name": @"name",
        @"nameInternational": @"nameInternational",
        @"p1_score": @"p1Score",
        @"p2_score": @"p2Score",
        @"p3_score": @"p3Score",
        @"p4_score": @"p4Score",
        @"pl": @"pl",
        @"score": @"score",
        @"scoring": @"scoring",
        @"shortName": @"shortName",
        @"shortNameInternational": @"shortNameInternational",
        @"shot": @"shot",
        @"timeouts": @"timeouts",
        @"tot_eff_1": @"totEFF1",
        @"tot_eff_2": @"totEFF2",
        @"tot_eff_3": @"totEFF3",
        @"tot_eff_4": @"totEFF4",
        @"tot_eff_5": @"totEFF5",
        @"tot_eff_6": @"totEFF6",
        @"tot_eff_7": @"totEFF7",
        @"tot_sAssists": @"totSAssists",
        @"tot_sBenchPoints": @"totSBenchPoints",
        @"tot_sBiggestLead": @"totSBiggestLead",
        @"tot_sBiggestScoringRun": @"totSBiggestScoringRun",
        @"tot_sBlocks": @"totSBlocks",
        @"tot_sBlocksReceived": @"totSBlocksReceived",
        @"tot_sFieldGoalsAttempted": @"totSFieldGoalsAttempted",
        @"tot_sFieldGoalsMade": @"totSFieldGoalsMade",
        @"tot_sFieldGoalsPercentage": @"totSFieldGoalsPercentage",
        @"tot_sFoulsOn": @"totSFoulsOn",
        @"tot_sFoulsPersonal": @"totSFoulsPersonal",
        @"tot_sFoulsTeam": @"totSFoulsTeam",
        @"tot_sFreeThrowsAttempted": @"totSFreeThrowsAttempted",
        @"tot_sFreeThrowsMade": @"totSFreeThrowsMade",
        @"tot_sFreeThrowsPercentage": @"totSFreeThrowsPercentage",
        @"tot_sLeadChanges": @"totSLeadChanges",
        @"tot_sMinutes": @"totSMinutes",
        @"tot_sPoints": @"totSPoints",
        @"tot_sPointsFastBreak": @"totSPointsFastBreak",
        @"tot_sPointsFromTurnovers": @"totSPointsFromTurnovers",
        @"tot_sPointsInThePaint": @"totSPointsInThePaint",
        @"tot_sPointsSecondChance": @"totSPointsSecondChance",
        @"tot_sReboundsDefensive": @"totSReboundsDefensive",
        @"tot_sReboundsOffensive": @"totSReboundsOffensive",
        @"tot_sReboundsTeam": @"totSReboundsTeam",
        @"tot_sReboundsTeamDefensive": @"totSReboundsTeamDefensive",
        @"tot_sReboundsTeamOffensive": @"totSReboundsTeamOffensive",
        @"tot_sReboundsTotal": @"totSReboundsTotal",
        @"tot_sSteals": @"totSSteals",
        @"tot_sThreePointersAttempted": @"totSThreePointersAttempted",
        @"tot_sThreePointersMade": @"totSThreePointersMade",
        @"tot_sThreePointersPercentage": @"totSThreePointersPercentage",
        @"tot_sTimeLeading": @"totSTimeLeading",
        @"tot_sTimesScoresLevel": @"totSTimesScoresLevel",
        @"tot_sTurnovers": @"totSTurnovers",
        @"tot_sTurnoversTeam": @"totSTurnoversTeam",
        @"tot_sTwoPointersAttempted": @"totSTwoPointersAttempted",
        @"tot_sTwoPointersMade": @"totSTwoPointersMade",
        @"tot_sTwoPointersPercentage": @"totSTwoPointersPercentage",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTm alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"code"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"codeInternational"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"fouls"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"fouls"] doubleValue] != [dict[@"fouls"] longLongValue]) return nil;
        if (![dict[@"full_score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"full_score"] doubleValue] != [dict[@"full_score"] longLongValue]) return nil;
        if (![dict[@"lds"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"logo"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"nameInternational"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"p1_score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"p1_score"] doubleValue] != [dict[@"p1_score"] longLongValue]) return nil;
        if (![dict[@"p2_score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"p2_score"] doubleValue] != [dict[@"p2_score"] longLongValue]) return nil;
        if (![dict[@"p3_score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"p3_score"] doubleValue] != [dict[@"p3_score"] longLongValue]) return nil;
        if (![dict[@"p4_score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"p4_score"] doubleValue] != [dict[@"p4_score"] longLongValue]) return nil;
        if (![dict[@"pl"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"score"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"score"] doubleValue] != [dict[@"score"] longLongValue]) return nil;
        if (![dict[@"scoring"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"shortName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"shortNameInternational"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"shot"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"timeouts"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"timeouts"] doubleValue] != [dict[@"timeouts"] longLongValue]) return nil;
        if (![dict[@"tot_eff_1"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_eff_1"] doubleValue] != [dict[@"tot_eff_1"] longLongValue]) return nil;
        if (![dict[@"tot_eff_2"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_eff_2"] doubleValue] != [dict[@"tot_eff_2"] longLongValue]) return nil;
        if (![dict[@"tot_eff_3"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"tot_eff_4"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_eff_4"] doubleValue] != [dict[@"tot_eff_4"] longLongValue]) return nil;
        if (![dict[@"tot_eff_5"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_eff_5"] doubleValue] != [dict[@"tot_eff_5"] longLongValue]) return nil;
        if (![dict[@"tot_eff_6"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_eff_6"] doubleValue] != [dict[@"tot_eff_6"] longLongValue]) return nil;
        if (![dict[@"tot_eff_7"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_eff_7"] doubleValue] != [dict[@"tot_eff_7"] longLongValue]) return nil;
        if (![dict[@"tot_sAssists"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sAssists"] doubleValue] != [dict[@"tot_sAssists"] longLongValue]) return nil;
        if (![dict[@"tot_sBenchPoints"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sBenchPoints"] doubleValue] != [dict[@"tot_sBenchPoints"] longLongValue]) return nil;
        if (![dict[@"tot_sBiggestLead"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sBiggestLead"] doubleValue] != [dict[@"tot_sBiggestLead"] longLongValue]) return nil;
        if (![dict[@"tot_sBiggestScoringRun"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sBiggestScoringRun"] doubleValue] != [dict[@"tot_sBiggestScoringRun"] longLongValue]) return nil;
        if (![dict[@"tot_sBlocks"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sBlocks"] doubleValue] != [dict[@"tot_sBlocks"] longLongValue]) return nil;
        if (![dict[@"tot_sBlocksReceived"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sBlocksReceived"] doubleValue] != [dict[@"tot_sBlocksReceived"] longLongValue]) return nil;
        if (![dict[@"tot_sFieldGoalsAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFieldGoalsAttempted"] doubleValue] != [dict[@"tot_sFieldGoalsAttempted"] longLongValue]) return nil;
        if (![dict[@"tot_sFieldGoalsMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFieldGoalsMade"] doubleValue] != [dict[@"tot_sFieldGoalsMade"] longLongValue]) return nil;
        if (![dict[@"tot_sFieldGoalsPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFieldGoalsPercentage"] doubleValue] != [dict[@"tot_sFieldGoalsPercentage"] longLongValue]) return nil;
        if (![dict[@"tot_sFoulsOn"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFoulsOn"] doubleValue] != [dict[@"tot_sFoulsOn"] longLongValue]) return nil;
        if (![dict[@"tot_sFoulsPersonal"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFoulsPersonal"] doubleValue] != [dict[@"tot_sFoulsPersonal"] longLongValue]) return nil;
        if (![dict[@"tot_sFoulsTeam"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFoulsTeam"] doubleValue] != [dict[@"tot_sFoulsTeam"] longLongValue]) return nil;
        if (![dict[@"tot_sFreeThrowsAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFreeThrowsAttempted"] doubleValue] != [dict[@"tot_sFreeThrowsAttempted"] longLongValue]) return nil;
        if (![dict[@"tot_sFreeThrowsMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFreeThrowsMade"] doubleValue] != [dict[@"tot_sFreeThrowsMade"] longLongValue]) return nil;
        if (![dict[@"tot_sFreeThrowsPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sFreeThrowsPercentage"] doubleValue] != [dict[@"tot_sFreeThrowsPercentage"] longLongValue]) return nil;
        if (![dict[@"tot_sLeadChanges"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sLeadChanges"] doubleValue] != [dict[@"tot_sLeadChanges"] longLongValue]) return nil;
        if (![dict[@"tot_sMinutes"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sMinutes"] doubleValue] != [dict[@"tot_sMinutes"] longLongValue]) return nil;
        if (![dict[@"tot_sPoints"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sPoints"] doubleValue] != [dict[@"tot_sPoints"] longLongValue]) return nil;
        if (![dict[@"tot_sPointsFastBreak"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sPointsFastBreak"] doubleValue] != [dict[@"tot_sPointsFastBreak"] longLongValue]) return nil;
        if (![dict[@"tot_sPointsFromTurnovers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sPointsFromTurnovers"] doubleValue] != [dict[@"tot_sPointsFromTurnovers"] longLongValue]) return nil;
        if (![dict[@"tot_sPointsInThePaint"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sPointsInThePaint"] doubleValue] != [dict[@"tot_sPointsInThePaint"] longLongValue]) return nil;
        if (![dict[@"tot_sPointsSecondChance"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sPointsSecondChance"] doubleValue] != [dict[@"tot_sPointsSecondChance"] longLongValue]) return nil;
        if (![dict[@"tot_sReboundsDefensive"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sReboundsDefensive"] doubleValue] != [dict[@"tot_sReboundsDefensive"] longLongValue]) return nil;
        if (![dict[@"tot_sReboundsOffensive"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sReboundsOffensive"] doubleValue] != [dict[@"tot_sReboundsOffensive"] longLongValue]) return nil;
        if (![dict[@"tot_sReboundsTeam"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sReboundsTeam"] doubleValue] != [dict[@"tot_sReboundsTeam"] longLongValue]) return nil;
        if (![dict[@"tot_sReboundsTeamDefensive"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sReboundsTeamDefensive"] doubleValue] != [dict[@"tot_sReboundsTeamDefensive"] longLongValue]) return nil;
        if (![dict[@"tot_sReboundsTeamOffensive"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sReboundsTeamOffensive"] doubleValue] != [dict[@"tot_sReboundsTeamOffensive"] longLongValue]) return nil;
        if (![dict[@"tot_sReboundsTotal"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sReboundsTotal"] doubleValue] != [dict[@"tot_sReboundsTotal"] longLongValue]) return nil;
        if (![dict[@"tot_sSteals"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sSteals"] doubleValue] != [dict[@"tot_sSteals"] longLongValue]) return nil;
        if (![dict[@"tot_sThreePointersAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sThreePointersAttempted"] doubleValue] != [dict[@"tot_sThreePointersAttempted"] longLongValue]) return nil;
        if (![dict[@"tot_sThreePointersMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sThreePointersMade"] doubleValue] != [dict[@"tot_sThreePointersMade"] longLongValue]) return nil;
        if (![dict[@"tot_sThreePointersPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sThreePointersPercentage"] doubleValue] != [dict[@"tot_sThreePointersPercentage"] longLongValue]) return nil;
        if (![dict[@"tot_sTimeLeading"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"tot_sTimesScoresLevel"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sTimesScoresLevel"] doubleValue] != [dict[@"tot_sTimesScoresLevel"] longLongValue]) return nil;
        if (![dict[@"tot_sTurnovers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sTurnovers"] doubleValue] != [dict[@"tot_sTurnovers"] longLongValue]) return nil;
        if (![dict[@"tot_sTurnoversTeam"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sTurnoversTeam"] doubleValue] != [dict[@"tot_sTurnoversTeam"] longLongValue]) return nil;
        if (![dict[@"tot_sTwoPointersAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sTwoPointersAttempted"] doubleValue] != [dict[@"tot_sTwoPointersAttempted"] longLongValue]) return nil;
        if (![dict[@"tot_sTwoPointersMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sTwoPointersMade"] doubleValue] != [dict[@"tot_sTwoPointersMade"] longLongValue]) return nil;
        if (![dict[@"tot_sTwoPointersPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tot_sTwoPointersPercentage"] doubleValue] != [dict[@"tot_sTwoPointersPercentage"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _lds = [QTLds fromJSONDictionary:(id)_lds];
        if (!_lds && dict[@"lds"] && ![dict[@"lds"] isKindOfClass:NSNull.class]) return nil;
        _pl = map(_pl, λ(id x, [QTPl fromJSONDictionary:x]));
        _scoring = map(_scoring, λ(id x, [QTScorer fromJSONDictionary:x]));
        _shot = map(_shot, λ(id x, [QTShot fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTm.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTm.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTm.properties.allValues] mutableCopy];

    for (id jsonName in QTTm.properties) {
        id propertyName = QTTm.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"lds": [_lds JSONDictionary],
        @"pl": map(_pl, λ(id x, [x JSONDictionary])),
        @"scoring": map(_scoring, λ(id x, [x JSONDictionary])),
        @"shot": map(_shot, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTLds
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"sAssists": @"sAssists",
        @"sBlocks": @"sBlocks",
        @"sPoints": @"sPoints",
        @"sReboundsTotal": @"sReboundsTotal",
        @"sSteals": @"sSteals",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLds alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"sAssists"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sBlocks"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sPoints"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sReboundsTotal"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sSteals"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _sAssists = map(_sAssists, λ(id x, [QTScorer fromJSONDictionary:x]));
        _sBlocks = [QTSBlocks fromJSONDictionary:(id)_sBlocks];
        if (!_sBlocks && dict[@"sBlocks"] && ![dict[@"sBlocks"] isKindOfClass:NSNull.class]) return nil;
        _sPoints = map(_sPoints, λ(id x, [QTScorer fromJSONDictionary:x]));
        _sReboundsTotal = map(_sReboundsTotal, λ(id x, [QTScorer fromJSONDictionary:x]));
        _sSteals = map(_sSteals, λ(id x, [QTScorer fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLds.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLds.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLds.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"sAssists": map(_sAssists, λ(id x, [x JSONDictionary])),
        @"sBlocks": [_sBlocks JSONDictionary],
        @"sPoints": map(_sPoints, λ(id x, [x JSONDictionary])),
        @"sReboundsTotal": map(_sReboundsTotal, λ(id x, [x JSONDictionary])),
        @"sSteals": map(_sSteals, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTSBlocks
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"1": @"the1",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSBlocks alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"1"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _the1 = [QTScorer fromJSONDictionary:(id)_the1];
        if (!_the1 && dict[@"1"] && ![dict[@"1"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSBlocks.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSBlocks.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSBlocks.properties.allValues] mutableCopy];

    for (id jsonName in QTSBlocks.properties) {
        id propertyName = QTSBlocks.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"1": [_the1 JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTPl
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"active": @"active",
        @"captain": @"captain",
        @"comp": @"comp",
        @"eff_1": @"eff1",
        @"eff_2": @"eff2",
        @"eff_3": @"eff3",
        @"eff_4": @"eff4",
        @"eff_5": @"eff5",
        @"eff_6": @"eff6",
        @"eff_7": @"eff7",
        @"familyName": @"familyName",
        @"familyNameInitial": @"familyNameInitial",
        @"firstName": @"firstName",
        @"firstNameInitial": @"firstNameInitial",
        @"internationalFamilyName": @"internationalFamilyName",
        @"internationalFamilyNameInitial": @"internationalFamilyNameInitial",
        @"internationalFirstName": @"internationalFirstName",
        @"internationalFirstNameInitial": @"internationalFirstNameInitial",
        @"name": @"name",
        @"playingPosition": @"playingPosition",
        @"sAssists": @"sAssists",
        @"sBlocks": @"sBlocks",
        @"sBlocksReceived": @"sBlocksReceived",
        @"sFieldGoalsAttempted": @"sFieldGoalsAttempted",
        @"sFieldGoalsMade": @"sFieldGoalsMade",
        @"sFieldGoalsPercentage": @"sFieldGoalsPercentage",
        @"sFoulsOn": @"sFoulsOn",
        @"sFoulsPersonal": @"sFoulsPersonal",
        @"sFreeThrowsAttempted": @"sFreeThrowsAttempted",
        @"sFreeThrowsMade": @"sFreeThrowsMade",
        @"sFreeThrowsPercentage": @"sFreeThrowsPercentage",
        @"sMinutes": @"sMinutes",
        @"sPlusMinusPoints": @"sPlusMinusPoints",
        @"sPoints": @"sPoints",
        @"sPointsFastBreak": @"sPointsFastBreak",
        @"sPointsInThePaint": @"sPointsInThePaint",
        @"sPointsSecondChance": @"sPointsSecondChance",
        @"sReboundsDefensive": @"sReboundsDefensive",
        @"sReboundsOffensive": @"sReboundsOffensive",
        @"sReboundsTotal": @"sReboundsTotal",
        @"sSteals": @"sSteals",
        @"sThreePointersAttempted": @"sThreePointersAttempted",
        @"sThreePointersMade": @"sThreePointersMade",
        @"sThreePointersPercentage": @"sThreePointersPercentage",
        @"sTurnovers": @"sTurnovers",
        @"sTwoPointersAttempted": @"sTwoPointersAttempted",
        @"sTwoPointersMade": @"sTwoPointersMade",
        @"sTwoPointersPercentage": @"sTwoPointersPercentage",
        @"shirtNumber": @"shirtNumber",
        @"starter": @"starter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPl alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"active"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"active"] doubleValue] != [dict[@"active"] longLongValue]) return nil;
        if (![dict[@"eff_1"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"eff_1"] doubleValue] != [dict[@"eff_1"] longLongValue]) return nil;
        if (![dict[@"eff_2"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"eff_2"] doubleValue] != [dict[@"eff_2"] longLongValue]) return nil;
        if (![dict[@"eff_3"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"eff_4"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"eff_5"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"eff_5"] doubleValue] != [dict[@"eff_5"] longLongValue]) return nil;
        if (![dict[@"eff_6"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"eff_6"] doubleValue] != [dict[@"eff_6"] longLongValue]) return nil;
        if (![dict[@"eff_7"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"eff_7"] doubleValue] != [dict[@"eff_7"] longLongValue]) return nil;
        if (![dict[@"familyName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"familyNameInitial"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"firstName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"firstNameInitial"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"internationalFamilyName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"internationalFamilyNameInitial"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"internationalFirstName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"internationalFirstNameInitial"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"playingPosition"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sAssists"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sAssists"] doubleValue] != [dict[@"sAssists"] longLongValue]) return nil;
        if (![dict[@"sBlocks"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sBlocks"] doubleValue] != [dict[@"sBlocks"] longLongValue]) return nil;
        if (![dict[@"sBlocksReceived"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sBlocksReceived"] doubleValue] != [dict[@"sBlocksReceived"] longLongValue]) return nil;
        if (![dict[@"sFieldGoalsAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFieldGoalsAttempted"] doubleValue] != [dict[@"sFieldGoalsAttempted"] longLongValue]) return nil;
        if (![dict[@"sFieldGoalsMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFieldGoalsMade"] doubleValue] != [dict[@"sFieldGoalsMade"] longLongValue]) return nil;
        if (![dict[@"sFieldGoalsPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFieldGoalsPercentage"] doubleValue] != [dict[@"sFieldGoalsPercentage"] longLongValue]) return nil;
        if (![dict[@"sFoulsOn"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFoulsOn"] doubleValue] != [dict[@"sFoulsOn"] longLongValue]) return nil;
        if (![dict[@"sFoulsPersonal"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFoulsPersonal"] doubleValue] != [dict[@"sFoulsPersonal"] longLongValue]) return nil;
        if (![dict[@"sFreeThrowsAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFreeThrowsAttempted"] doubleValue] != [dict[@"sFreeThrowsAttempted"] longLongValue]) return nil;
        if (![dict[@"sFreeThrowsMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFreeThrowsMade"] doubleValue] != [dict[@"sFreeThrowsMade"] longLongValue]) return nil;
        if (![dict[@"sFreeThrowsPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sFreeThrowsPercentage"] doubleValue] != [dict[@"sFreeThrowsPercentage"] longLongValue]) return nil;
        if (![dict[@"sPlusMinusPoints"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sPlusMinusPoints"] doubleValue] != [dict[@"sPlusMinusPoints"] longLongValue]) return nil;
        if (![dict[@"sPoints"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sPoints"] doubleValue] != [dict[@"sPoints"] longLongValue]) return nil;
        if (![dict[@"sPointsFastBreak"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sPointsFastBreak"] doubleValue] != [dict[@"sPointsFastBreak"] longLongValue]) return nil;
        if (![dict[@"sPointsInThePaint"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sPointsInThePaint"] doubleValue] != [dict[@"sPointsInThePaint"] longLongValue]) return nil;
        if (![dict[@"sPointsSecondChance"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sPointsSecondChance"] doubleValue] != [dict[@"sPointsSecondChance"] longLongValue]) return nil;
        if (![dict[@"sReboundsDefensive"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sReboundsDefensive"] doubleValue] != [dict[@"sReboundsDefensive"] longLongValue]) return nil;
        if (![dict[@"sReboundsOffensive"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sReboundsOffensive"] doubleValue] != [dict[@"sReboundsOffensive"] longLongValue]) return nil;
        if (![dict[@"sReboundsTotal"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sReboundsTotal"] doubleValue] != [dict[@"sReboundsTotal"] longLongValue]) return nil;
        if (![dict[@"sSteals"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sSteals"] doubleValue] != [dict[@"sSteals"] longLongValue]) return nil;
        if (![dict[@"sThreePointersAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sThreePointersAttempted"] doubleValue] != [dict[@"sThreePointersAttempted"] longLongValue]) return nil;
        if (![dict[@"sThreePointersMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sThreePointersMade"] doubleValue] != [dict[@"sThreePointersMade"] longLongValue]) return nil;
        if (![dict[@"sThreePointersPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sThreePointersPercentage"] doubleValue] != [dict[@"sThreePointersPercentage"] longLongValue]) return nil;
        if (![dict[@"sTurnovers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sTurnovers"] doubleValue] != [dict[@"sTurnovers"] longLongValue]) return nil;
        if (![dict[@"sTwoPointersAttempted"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sTwoPointersAttempted"] doubleValue] != [dict[@"sTwoPointersAttempted"] longLongValue]) return nil;
        if (![dict[@"sTwoPointersMade"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sTwoPointersMade"] doubleValue] != [dict[@"sTwoPointersMade"] longLongValue]) return nil;
        if (![dict[@"sTwoPointersPercentage"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sTwoPointersPercentage"] doubleValue] != [dict[@"sTwoPointersPercentage"] longLongValue]) return nil;
        if (![dict[@"shirtNumber"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"starter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"starter"] doubleValue] != [dict[@"starter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comp = [QTComp fromJSONDictionary:(id)_comp];
        if (!_comp && dict[@"comp"] && ![dict[@"comp"] isKindOfClass:NSNull.class]) return nil;
        _familyNameInitial = [QTFamilyNameInitial withValue:(id)_familyNameInitial];
        _firstNameInitial = [QTFirstNameInitial withValue:(id)_firstNameInitial];
        _internationalFamilyNameInitial = [QTFamilyNameInitial withValue:(id)_internationalFamilyNameInitial];
        _internationalFirstNameInitial = [QTFirstNameInitial withValue:(id)_internationalFirstNameInitial];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPl.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPl.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPl.properties.allValues] mutableCopy];

    for (id jsonName in QTPl.properties) {
        id propertyName = QTPl.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comp": NSNullify([_comp isKindOfClass:NSNull.class] ? nil : [_comp JSONDictionary]),
        @"familyNameInitial": [_familyNameInitial value],
        @"firstNameInitial": [_firstNameInitial value],
        @"internationalFamilyNameInitial": [_internationalFamilyNameInitial value],
        @"internationalFirstNameInitial": [_internationalFirstNameInitial value],
    }];

    return dict;
}
@end

@implementation QTComp
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"sAssistsAverage": @"sAssistsAverage",
        @"sMinutesAverage": @"sMinutesAverage",
        @"sPointsAverage": @"sPointsAverage",
        @"sReboundsTotalAverage": @"sReboundsTotalAverage",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTComp alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"sAssistsAverage"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"sMinutesAverage"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sPointsAverage"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"sReboundsTotalAverage"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTComp.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTComp.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTComp.properties.allValues];
}
@end

@implementation QTShot
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"actionType": @"actionType",
        @"p": @"p",
        @"per": @"per",
        @"perType": @"perType",
        @"player": @"player",
        @"pno": @"pno",
        @"r": @"r",
        @"shirtNumber": @"shirtNumber",
        @"subType": @"subType",
        @"tno": @"tno",
        @"x": @"x",
        @"y": @"y",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTShot alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"actionType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"p"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"p"] doubleValue] != [dict[@"p"] longLongValue]) return nil;
        if (![dict[@"per"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"per"] doubleValue] != [dict[@"per"] longLongValue]) return nil;
        if (![dict[@"perType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"player"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"pno"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"pno"] doubleValue] != [dict[@"pno"] longLongValue]) return nil;
        if (![dict[@"r"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"r"] doubleValue] != [dict[@"r"] longLongValue]) return nil;
        if (![dict[@"shirtNumber"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"subType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tno"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tno"] doubleValue] != [dict[@"tno"] longLongValue]) return nil;
        if (![dict[@"x"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"x"] doubleValue] != [dict[@"x"] longLongValue]) return nil;
        if (![dict[@"y"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"y"] doubleValue] != [dict[@"y"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _actionType = [QTActionType withValue:(id)_actionType];
        _perType = [QTPerType withValue:(id)_perType];
        _subType = [QTSubType withValue:(id)_subType];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTShot.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTShot.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTShot.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"actionType": [_actionType value],
        @"perType": [_perType value],
        @"subType": [_subType value],
    }];

    return dict;
}
@end

@implementation QTTotallds
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"sAssists": @"sAssists",
        @"sBlocks": @"sBlocks",
        @"sPoints": @"sPoints",
        @"sReboundsTotal": @"sReboundsTotal",
        @"sSteals": @"sSteals",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTotallds alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"sAssists"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sBlocks"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sPoints"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sReboundsTotal"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sSteals"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _sAssists = map(_sAssists, λ(id x, [QTScorer fromJSONDictionary:x]));
        _sBlocks = map(_sBlocks, λ(id x, [QTScorer fromJSONDictionary:x]));
        _sPoints = map(_sPoints, λ(id x, [QTScorer fromJSONDictionary:x]));
        _sReboundsTotal = map(_sReboundsTotal, λ(id x, [QTScorer fromJSONDictionary:x]));
        _sSteals = map(_sSteals, λ(id x, [QTScorer fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTotallds.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTotallds.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTotallds.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"sAssists": map(_sAssists, λ(id x, [x JSONDictionary])),
        @"sBlocks": map(_sBlocks, λ(id x, [x JSONDictionary])),
        @"sPoints": map(_sPoints, λ(id x, [x JSONDictionary])),
        @"sReboundsTotal": map(_sReboundsTotal, λ(id x, [x JSONDictionary])),
        @"sSteals": map(_sSteals, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
