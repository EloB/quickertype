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

@interface QTCerographClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChemotherapeuticClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCimeliaClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCoadjustClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCredulityClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDeruralizeClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDiaereseClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEncrust (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFagginglyClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFenkClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFlagmakingClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHemocoeleClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInteracinar (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
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
        @"centrodesmose": @"centrodesmose",
        @"cerograph": @"cerograph",
        @"chemotherapeutics": @"chemotherapeutics",
        @"cimelia": @"cimelia",
        @"citrated": @"citrated",
        @"clinodome": @"clinodome",
        @"coadjust": @"coadjust",
        @"consilience": @"consilience",
        @"constructor": @"constructor",
        @"continuative": @"continuative",
        @"credulity": @"credulity",
        @"creviced": @"creviced",
        @"cubiculum": @"cubiculum",
        @"deruralize": @"deruralize",
        @"diaereses": @"diaereses",
        @"dissolution": @"dissolution",
        @"downstroke": @"downstroke",
        @"electrotautomerism": @"electrotautomerism",
        @"eleutheromania": @"eleutheromania",
        @"encrust": @"encrust",
        @"entomoid": @"entomoid",
        @"epipaleolithic": @"epipaleolithic",
        @"expropriable": @"expropriable",
        @"faggingly": @"faggingly",
        @"fenks": @"fenks",
        @"flagmaking": @"flagmaking",
        @"fluorometer": @"fluorometer",
        @"fulsome": @"fulsome",
        @"fuzzy": @"fuzzy",
        @"gardenwards": @"gardenwards",
        @"generalissimo": @"generalissimo",
        @"habeas": @"habeas",
        @"hemicrystalline": @"hemicrystalline",
        @"hemocoele": @"hemocoele",
        @"hoister": @"hoister",
        @"hyperpiesis": @"hyperpiesis",
        @"hyppish": @"hyppish",
        @"idealizer": @"idealizer",
        @"incrustator": @"incrustator",
        @"intentiveness": @"intentiveness",
        @"interacinar": @"interacinar",
        @"intercorrelation": @"intercorrelation",
        @"jacutinga": @"jacutinga",
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
        if (![dict[@"centrodesmose"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"cerograph"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"chemotherapeutics"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"cimelia"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"citrated"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"citrated"] doubleValue] != [dict[@"citrated"] longLongValue]) return nil;
        if (![dict[@"clinodome"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"coadjust"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"consilience"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"constructor"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"continuative"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"credulity"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"creviced"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"cubiculum"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"deruralize"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"diaereses"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"dissolution"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"downstroke"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"electrotautomerism"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"eleutheromania"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"encrust"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"entomoid"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"epipaleolithic"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"expropriable"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"faggingly"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"fenks"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"flagmaking"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"fluorometer"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"fulsome"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"fuzzy"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"gardenwards"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"generalissimo"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"habeas"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"hemicrystalline"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"hemocoele"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"hoister"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"hyperpiesis"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"hyppish"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"idealizer"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"incrustator"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"intentiveness"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"interacinar"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"intercorrelation"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"jacutinga"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _encrust = [QTEncrust fromJSONDictionary:(id)_encrust];
        if (!_encrust && dict[@"encrust"] && ![dict[@"encrust"] isKindOfClass:NSNull.class]) return nil;
        _interacinar = [QTInteracinar fromJSONDictionary:(id)_interacinar];
        if (!_interacinar && dict[@"interacinar"] && ![dict[@"interacinar"] isKindOfClass:NSNull.class]) return nil;
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
        @"encrust": [_encrust JSONDictionary],
        @"interacinar": [_interacinar JSONDictionary],
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

@implementation QTCerographClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"apotropaion": @"apotropaion",
        @"casuary": @"casuary",
        @"creaker": @"creaker",
        @"disqualification": @"disqualification",
        @"imperatorious": @"imperatorious",
        @"impermeabilize": @"impermeabilize",
        @"metastoma": @"metastoma",
        @"noctidiurnal": @"noctidiurnal",
        @"nonreserve": @"nonreserve",
        @"ophthalmotonometry": @"ophthalmotonometry",
        @"pailful": @"pailful",
        @"pigfish": @"pigfish",
        @"pongee": @"pongee",
        @"prosodical": @"prosodical",
        @"scrofuloderm": @"scrofuloderm",
        @"storekeeping": @"storekeeping",
        @"therologist": @"therologist",
        @"Tolowa": @"tolowa",
        @"tradeful": @"tradeful",
        @"unriveting": @"unriveting",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCerographClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"apotropaion"]) return nil;
        if (!dict[@"casuary"]) return nil;
        if (!dict[@"creaker"]) return nil;
        if (!dict[@"disqualification"]) return nil;
        if (!dict[@"imperatorious"]) return nil;
        if (!dict[@"impermeabilize"]) return nil;
        if (!dict[@"metastoma"]) return nil;
        if (!dict[@"noctidiurnal"]) return nil;
        if (!dict[@"nonreserve"]) return nil;
        if (!dict[@"ophthalmotonometry"]) return nil;
        if (!dict[@"pailful"]) return nil;
        if (!dict[@"pigfish"]) return nil;
        if (!dict[@"pongee"]) return nil;
        if (!dict[@"prosodical"]) return nil;
        if (!dict[@"scrofuloderm"]) return nil;
        if (!dict[@"storekeeping"]) return nil;
        if (!dict[@"therologist"]) return nil;
        if (!dict[@"Tolowa"]) return nil;
        if (!dict[@"tradeful"]) return nil;
        if (!dict[@"unriveting"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCerographClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCerographClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCerographClass.properties.allValues] mutableCopy];

    for (id jsonName in QTCerographClass.properties) {
        id propertyName = QTCerographClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTChemotherapeuticClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"angioneurotic": @"angioneurotic",
        @"availment": @"availment",
        @"bladelet": @"bladelet",
        @"catharticalness": @"catharticalness",
        @"caulis": @"caulis",
        @"chalcus": @"chalcus",
        @"Chirotherium": @"chirotherium",
        @"disdiapason": @"disdiapason",
        @"enteradenological": @"enteradenological",
        @"homocerc": @"homocerc",
        @"imporosity": @"imporosity",
        @"insistently": @"insistently",
        @"intraparietal": @"intraparietal",
        @"ivied": @"ivied",
        @"Maureen": @"maureen",
        @"nonbookish": @"nonbookish",
        @"nostochine": @"nostochine",
        @"nutcracker": @"nutcracker",
        @"ofttimes": @"ofttimes",
        @"phenocryst": @"phenocryst",
        @"precoincident": @"precoincident",
        @"ramiferous": @"ramiferous",
        @"stagmometer": @"stagmometer",
        @"tetherball": @"tetherball",
        @"unshy": @"unshy",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChemotherapeuticClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTChemotherapeuticClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChemotherapeuticClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChemotherapeuticClass.properties.allValues] mutableCopy];

    for (id jsonName in QTChemotherapeuticClass.properties) {
        id propertyName = QTChemotherapeuticClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCimeliaClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"disdiapason": @"disdiapason",
        @"homocerc": @"isHomocerc",
        @"nonbookish": @"nonbookish",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCimeliaClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"catharticalness"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"Chirotherium"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Chirotherium"] doubleValue] != [dict[@"Chirotherium"] longLongValue]) return nil;
        if (![dict[@"disdiapason"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"homocerc"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"nonbookish"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCimeliaClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCimeliaClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCimeliaClass.properties.allValues] mutableCopy];

    for (id jsonName in QTCimeliaClass.properties) {
        id propertyName = QTCimeliaClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"homocerc": _isHomocerc ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTCoadjustClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"amidosulphonal": @"amidosulphonal",
        @"Benny": @"benny",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"disdiapason": @"disdiapason",
        @"ensnare": @"ensnare",
        @"homocerc": @"homocerc",
        @"hybridizer": @"hybridizer",
        @"leastwise": @"leastwise",
        @"lof": @"lof",
        @"monkhood": @"monkhood",
        @"Netherlandish": @"netherlandish",
        @"nonbookish": @"nonbookish",
        @"peonism": @"peonism",
        @"Phonelescope": @"phonelescope",
        @"porphyrogeniture": @"porphyrogeniture",
        @"preindemnify": @"preindemnify",
        @"rosal": @"rosal",
        @"scalenous": @"scalenous",
        @"scopine": @"scopine",
        @"Sedaceae": @"sedaceae",
        @"suberinize": @"suberinize",
        @"symbiot": @"symbiot",
        @"tablefellow": @"tablefellow",
        @"unchargeable": @"unchargeable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCoadjustClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTCoadjustClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCoadjustClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCoadjustClass.properties.allValues] mutableCopy];

    for (id jsonName in QTCoadjustClass.properties) {
        id propertyName = QTCoadjustClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCredulityClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ammonolytic": @"ammonolytic",
        @"bushmaster": @"bushmaster",
        @"considering": @"considering",
        @"consuetudinary": @"consuetudinary",
        @"embarras": @"embarras",
        @"fineness": @"fineness",
        @"flaithship": @"flaithship",
        @"Flavia": @"flavia",
        @"gruffly": @"gruffly",
        @"Hedychium": @"hedychium",
        @"leadwort": @"leadwort",
        @"overseriously": @"overseriously",
        @"parabola": @"parabola",
        @"pectinatodenticulate": @"pectinatodenticulate",
        @"Popean": @"popean",
        @"pornocrat": @"pornocrat",
        @"quadrisect": @"quadrisect",
        @"seriality": @"seriality",
        @"vamphorn": @"vamphorn",
        @"wharp": @"wharp",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCredulityClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"ammonolytic"]) return nil;
        if (!dict[@"bushmaster"]) return nil;
        if (!dict[@"considering"]) return nil;
        if (!dict[@"consuetudinary"]) return nil;
        if (!dict[@"embarras"]) return nil;
        if (!dict[@"fineness"]) return nil;
        if (!dict[@"flaithship"]) return nil;
        if (!dict[@"Flavia"]) return nil;
        if (!dict[@"gruffly"]) return nil;
        if (!dict[@"Hedychium"]) return nil;
        if (!dict[@"leadwort"]) return nil;
        if (!dict[@"overseriously"]) return nil;
        if (!dict[@"parabola"]) return nil;
        if (!dict[@"pectinatodenticulate"]) return nil;
        if (!dict[@"Popean"]) return nil;
        if (!dict[@"pornocrat"]) return nil;
        if (!dict[@"quadrisect"]) return nil;
        if (!dict[@"seriality"]) return nil;
        if (!dict[@"vamphorn"]) return nil;
        if (!dict[@"wharp"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCredulityClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCredulityClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCredulityClass.properties.allValues] mutableCopy];

    for (id jsonName in QTCredulityClass.properties) {
        id propertyName = QTCredulityClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDeruralizeClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bockerel": @"bockerel",
        @"boulder": @"boulder",
        @"churrus": @"churrus",
        @"counterdigged": @"counterdigged",
        @"dialogite": @"dialogite",
        @"digenic": @"digenic",
        @"dunbird": @"dunbird",
        @"ergatogyne": @"ergatogyne",
        @"fiendful": @"fiendful",
        @"jackrod": @"jackrod",
        @"Jehovistic": @"jehovistic",
        @"Paninean": @"paninean",
        @"panther": @"panther",
        @"placentigerous": @"placentigerous",
        @"Romney": @"romney",
        @"sparm": @"sparm",
        @"tocsin": @"tocsin",
        @"unnicked": @"unnicked",
        @"unstavable": @"unstavable",
        @"windfirm": @"windfirm",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDeruralizeClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"bockerel"]) return nil;
        if (!dict[@"boulder"]) return nil;
        if (!dict[@"churrus"]) return nil;
        if (!dict[@"counterdigged"]) return nil;
        if (!dict[@"dialogite"]) return nil;
        if (!dict[@"digenic"]) return nil;
        if (!dict[@"dunbird"]) return nil;
        if (!dict[@"ergatogyne"]) return nil;
        if (!dict[@"fiendful"]) return nil;
        if (!dict[@"jackrod"]) return nil;
        if (!dict[@"Jehovistic"]) return nil;
        if (!dict[@"Paninean"]) return nil;
        if (!dict[@"panther"]) return nil;
        if (!dict[@"placentigerous"]) return nil;
        if (!dict[@"Romney"]) return nil;
        if (!dict[@"sparm"]) return nil;
        if (!dict[@"tocsin"]) return nil;
        if (!dict[@"unnicked"]) return nil;
        if (!dict[@"unstavable"]) return nil;
        if (!dict[@"windfirm"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDeruralizeClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDeruralizeClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDeruralizeClass.properties.allValues] mutableCopy];

    for (id jsonName in QTDeruralizeClass.properties) {
        id propertyName = QTDeruralizeClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDiaereseClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Amoreuxia": @"amoreuxia",
        @"ani": @"ani",
        @"bernicle": @"bernicle",
        @"blackwasher": @"blackwasher",
        @"blowhard": @"blowhard",
        @"broma": @"broma",
        @"closecross": @"closecross",
        @"congregationalism": @"congregationalism",
        @"grayly": @"grayly",
        @"historically": @"historically",
        @"hoast": @"hoast",
        @"irretentive": @"irretentive",
        @"parcener": @"parcener",
        @"pedder": @"pedder",
        @"pseudoanatomic": @"pseudoanatomic",
        @"rhizocarpian": @"rhizocarpian",
        @"samel": @"samel",
        @"silker": @"silker",
        @"subdentated": @"subdentated",
        @"subobscure": @"subobscure",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDiaereseClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"Amoreuxia"]) return nil;
        if (!dict[@"ani"]) return nil;
        if (!dict[@"bernicle"]) return nil;
        if (!dict[@"blackwasher"]) return nil;
        if (!dict[@"blowhard"]) return nil;
        if (!dict[@"broma"]) return nil;
        if (!dict[@"closecross"]) return nil;
        if (!dict[@"congregationalism"]) return nil;
        if (!dict[@"grayly"]) return nil;
        if (!dict[@"historically"]) return nil;
        if (!dict[@"hoast"]) return nil;
        if (!dict[@"irretentive"]) return nil;
        if (!dict[@"parcener"]) return nil;
        if (!dict[@"pedder"]) return nil;
        if (!dict[@"pseudoanatomic"]) return nil;
        if (!dict[@"rhizocarpian"]) return nil;
        if (!dict[@"samel"]) return nil;
        if (!dict[@"silker"]) return nil;
        if (!dict[@"subdentated"]) return nil;
        if (!dict[@"subobscure"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDiaereseClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDiaereseClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDiaereseClass.properties.allValues] mutableCopy];

    for (id jsonName in QTDiaereseClass.properties) {
        id propertyName = QTDiaereseClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTEncrust
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comradely": @"comradely",
        @"diacanthous": @"diacanthous",
        @"feminineness": @"feminineness",
        @"gossamered": @"gossamered",
        @"Hibernia": @"hibernia",
        @"Hibiscus": @"hibiscus",
        @"Lepidosauria": @"lepidosauria",
        @"lollingly": @"lollingly",
        @"manager": @"manager",
        @"mechanic": @"mechanic",
        @"overminuteness": @"overminuteness",
        @"papelonne": @"papelonne",
        @"plebification": @"plebification",
        @"pugmiller": @"pugmiller",
        @"recoveror": @"recoveror",
        @"spermatoblastic": @"spermatoblastic",
        @"Syllidae": @"syllidae",
        @"ungyved": @"ungyved",
        @"whirlabout": @"whirlabout",
        @"woodenware": @"woodenware",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEncrust alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"comradely"]) return nil;
        if (!dict[@"diacanthous"]) return nil;
        if (!dict[@"feminineness"]) return nil;
        if (!dict[@"gossamered"]) return nil;
        if (!dict[@"Hibernia"]) return nil;
        if (!dict[@"Hibiscus"]) return nil;
        if (!dict[@"Lepidosauria"]) return nil;
        if (!dict[@"lollingly"]) return nil;
        if (!dict[@"manager"]) return nil;
        if (!dict[@"mechanic"]) return nil;
        if (!dict[@"overminuteness"]) return nil;
        if (!dict[@"papelonne"]) return nil;
        if (!dict[@"plebification"]) return nil;
        if (!dict[@"pugmiller"]) return nil;
        if (!dict[@"recoveror"]) return nil;
        if (!dict[@"spermatoblastic"]) return nil;
        if (!dict[@"Syllidae"]) return nil;
        if (!dict[@"ungyved"]) return nil;
        if (!dict[@"whirlabout"]) return nil;
        if (!dict[@"woodenware"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEncrust.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEncrust.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEncrust.properties.allValues] mutableCopy];

    for (id jsonName in QTEncrust.properties) {
        id propertyName = QTEncrust.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFagginglyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"abranchian": @"abranchian",
        @"aculeiform": @"aculeiform",
        @"adiaphoristic": @"adiaphoristic",
        @"adoptionism": @"adoptionism",
        @"Anglic": @"anglic",
        @"antrotomy": @"antrotomy",
        @"coerciveness": @"coerciveness",
        @"decorist": @"decorist",
        @"duckhood": @"duckhood",
        @"Heteromeri": @"heteromeri",
        @"hypochnose": @"hypochnose",
        @"lochage": @"lochage",
        @"melee": @"melee",
        @"nonconformitant": @"nonconformitant",
        @"Poinsettia": @"poinsettia",
        @"putatively": @"putatively",
        @"semivolatile": @"semivolatile",
        @"soleas": @"soleas",
        @"unfastenable": @"unfastenable",
        @"unmillinered": @"unmillinered",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFagginglyClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"abranchian"]) return nil;
        if (!dict[@"aculeiform"]) return nil;
        if (!dict[@"adiaphoristic"]) return nil;
        if (!dict[@"adoptionism"]) return nil;
        if (!dict[@"Anglic"]) return nil;
        if (!dict[@"antrotomy"]) return nil;
        if (!dict[@"coerciveness"]) return nil;
        if (!dict[@"decorist"]) return nil;
        if (!dict[@"duckhood"]) return nil;
        if (!dict[@"Heteromeri"]) return nil;
        if (!dict[@"hypochnose"]) return nil;
        if (!dict[@"lochage"]) return nil;
        if (!dict[@"melee"]) return nil;
        if (!dict[@"nonconformitant"]) return nil;
        if (!dict[@"Poinsettia"]) return nil;
        if (!dict[@"putatively"]) return nil;
        if (!dict[@"semivolatile"]) return nil;
        if (!dict[@"soleas"]) return nil;
        if (!dict[@"unfastenable"]) return nil;
        if (!dict[@"unmillinered"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFagginglyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFagginglyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFagginglyClass.properties.allValues] mutableCopy];

    for (id jsonName in QTFagginglyClass.properties) {
        id propertyName = QTFagginglyClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFenkClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"apoise": @"apoise",
        @"astronomize": @"astronomize",
        @"cockhorse": @"cockhorse",
        @"copular": @"copular",
        @"Dagomba": @"dagomba",
        @"draffy": @"draffy",
        @"foreigner": @"foreigner",
        @"Guyandot": @"guyandot",
        @"neurogliosis": @"neurogliosis",
        @"osmious": @"osmious",
        @"palpitate": @"palpitate",
        @"rebukeable": @"rebukeable",
        @"Reinwardtia": @"reinwardtia",
        @"reservatory": @"reservatory",
        @"scalt": @"scalt",
        @"scripturalize": @"scripturalize",
        @"tintometer": @"tintometer",
        @"Tritoness": @"tritoness",
        @"undergrade": @"undergrade",
        @"undermountain": @"undermountain",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFenkClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"apoise"]) return nil;
        if (!dict[@"astronomize"]) return nil;
        if (!dict[@"cockhorse"]) return nil;
        if (!dict[@"copular"]) return nil;
        if (!dict[@"Dagomba"]) return nil;
        if (!dict[@"draffy"]) return nil;
        if (!dict[@"foreigner"]) return nil;
        if (!dict[@"Guyandot"]) return nil;
        if (!dict[@"neurogliosis"]) return nil;
        if (!dict[@"osmious"]) return nil;
        if (!dict[@"palpitate"]) return nil;
        if (!dict[@"rebukeable"]) return nil;
        if (!dict[@"Reinwardtia"]) return nil;
        if (!dict[@"reservatory"]) return nil;
        if (!dict[@"scalt"]) return nil;
        if (!dict[@"scripturalize"]) return nil;
        if (!dict[@"tintometer"]) return nil;
        if (!dict[@"Tritoness"]) return nil;
        if (!dict[@"undergrade"]) return nil;
        if (!dict[@"undermountain"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFenkClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFenkClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFenkClass.properties.allValues] mutableCopy];

    for (id jsonName in QTFenkClass.properties) {
        id propertyName = QTFenkClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFlagmakingClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"albarco": @"albarco",
        @"Bunodonta": @"bunodonta",
        @"hornify": @"hornify",
        @"Hydrocorisae": @"hydrocorisae",
        @"hypoglossus": @"hypoglossus",
        @"inexpiably": @"inexpiably",
        @"ingratitude": @"ingratitude",
        @"ladyfly": @"ladyfly",
        @"medicament": @"medicament",
        @"monogrammatic": @"monogrammatic",
        @"nobbut": @"nobbut",
        @"Notacanthidae": @"notacanthidae",
        @"polyplacophore": @"polyplacophore",
        @"proexercise": @"proexercise",
        @"protoplast": @"protoplast",
        @"puzzling": @"puzzling",
        @"splanchnoskeleton": @"splanchnoskeleton",
        @"unloveliness": @"unloveliness",
        @"unquarantined": @"unquarantined",
        @"unrenounceable": @"unrenounceable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFlagmakingClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"albarco"]) return nil;
        if (!dict[@"Bunodonta"]) return nil;
        if (!dict[@"hornify"]) return nil;
        if (!dict[@"Hydrocorisae"]) return nil;
        if (!dict[@"hypoglossus"]) return nil;
        if (!dict[@"inexpiably"]) return nil;
        if (!dict[@"ingratitude"]) return nil;
        if (!dict[@"ladyfly"]) return nil;
        if (!dict[@"medicament"]) return nil;
        if (!dict[@"monogrammatic"]) return nil;
        if (!dict[@"nobbut"]) return nil;
        if (!dict[@"Notacanthidae"]) return nil;
        if (!dict[@"polyplacophore"]) return nil;
        if (!dict[@"proexercise"]) return nil;
        if (!dict[@"protoplast"]) return nil;
        if (!dict[@"puzzling"]) return nil;
        if (!dict[@"splanchnoskeleton"]) return nil;
        if (!dict[@"unloveliness"]) return nil;
        if (!dict[@"unquarantined"]) return nil;
        if (!dict[@"unrenounceable"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFlagmakingClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFlagmakingClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFlagmakingClass.properties.allValues] mutableCopy];

    for (id jsonName in QTFlagmakingClass.properties) {
        id propertyName = QTFlagmakingClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTHemocoeleClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"acrogamy": @"acrogamy",
        @"amelification": @"amelification",
        @"autobiographic": @"autobiographic",
        @"berat": @"berat",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"disdiapason": @"disdiapason",
        @"disproportionably": @"disproportionably",
        @"erythrite": @"erythrite",
        @"graphic": @"graphic",
        @"hepatological": @"hepatological",
        @"homocerc": @"homocerc",
        @"incommensurably": @"incommensurably",
        @"misaffirm": @"misaffirm",
        @"nonbookish": @"nonbookish",
        @"pocketbook": @"pocketbook",
        @"sclerometric": @"sclerometric",
        @"stambouline": @"stambouline",
        @"stickpin": @"stickpin",
        @"tubulure": @"tubulure",
        @"undelated": @"undelated",
        @"unsalt": @"unsalt",
        @"untutelar": @"untutelar",
        @"vagrant": @"vagrant",
        @"Walt": @"walt",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHemocoeleClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTHemocoeleClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHemocoeleClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTHemocoeleClass.properties.allValues] mutableCopy];

    for (id jsonName in QTHemocoeleClass.properties) {
        id propertyName = QTHemocoeleClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTInteracinar
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"assapan": @"assapan",
        @"benefactorship": @"isBenefactorship",
        @"triseriatim": @"triseriatim",
        @"tubbing": @"tubbing",
        @"untrimmed": @"untrimmed",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInteracinar alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"assapan"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"benefactorship"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"triseriatim"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tubbing"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tubbing"] doubleValue] != [dict[@"tubbing"] longLongValue]) return nil;
        if (!dict[@"untrimmed"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInteracinar.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInteracinar.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTInteracinar.properties.allValues] mutableCopy];

    for (id jsonName in QTInteracinar.properties) {
        id propertyName = QTInteracinar.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"benefactorship": _isBenefactorship ? @YES : @NO,
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
