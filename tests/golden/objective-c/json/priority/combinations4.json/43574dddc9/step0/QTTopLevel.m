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

@interface QTPulpitismClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPyodermiaClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTQuebrachineClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTReimagine (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRessaut (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRewriteClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSantirClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSaxtenClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTScatty (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSisteringClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStaghunting (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStrenuosityClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTruantcyClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnimpeachablyClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnstressedClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWrothyClass (JSONConversion)
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
        @"protrusive": @"protrusive",
        @"pulpitism": @"pulpitism",
        @"pyodermia": @"pyodermia",
        @"quebrachine": @"quebrachine",
        @"querier": @"querier",
        @"rebarbative": @"rebarbative",
        @"reimagine": @"reimagine",
        @"ressaut": @"ressaut",
        @"retrocervical": @"retrocervical",
        @"revert": @"revert",
        @"rewrite": @"rewrite",
        @"saccoderm": @"saccoderm",
        @"santir": @"santir",
        @"saprophilous": @"saprophilous",
        @"saxten": @"saxten",
        @"scatty": @"scatty",
        @"scoffer": @"scoffer",
        @"scrampum": @"scrampum",
        @"semantic": @"semantic",
        @"serpentinic": @"serpentinic",
        @"shadowable": @"shadowable",
        @"sistering": @"sistering",
        @"staghunting": @"staghunting",
        @"stagmometer": @"stagmometer",
        @"stimulability": @"stimulability",
        @"strangleable": @"strangleable",
        @"strenuosity": @"strenuosity",
        @"tabaxir": @"tabaxir",
        @"talpiform": @"talpiform",
        @"thwack": @"thwack",
        @"to": @"to",
        @"tortricine": @"tortricine",
        @"truantcy": @"truantcy",
        @"turgesce": @"turgesce",
        @"unbeginning": @"unbeginning",
        @"underdunged": @"underdunged",
        @"undesirability": @"undesirability",
        @"unerasing": @"unerasing",
        @"unguentarium": @"unguentarium",
        @"unimpeachably": @"unimpeachably",
        @"unmortgaged": @"unmortgaged",
        @"unobstructed": @"unobstructed",
        @"unreceptivity": @"unreceptivity",
        @"unsatisfactoriness": @"unsatisfactoriness",
        @"unsecurity": @"unsecurity",
        @"unstressed": @"unstressed",
        @"untasked": @"untasked",
        @"unvarying": @"unvarying",
        @"vehemently": @"vehemently",
        @"warriorship": @"warriorship",
        @"whitepot": @"whitepot",
        @"wrothy": @"wrothy",
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
        if (![dict[@"protrusive"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"pulpitism"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"pyodermia"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"quebrachine"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"querier"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"rebarbative"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"reimagine"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"ressaut"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"retrocervical"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"revert"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"rewrite"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"saccoderm"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"santir"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"saprophilous"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"saxten"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"scatty"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"scoffer"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"scrampum"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"semantic"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"serpentinic"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"shadowable"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"sistering"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"staghunting"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"stagmometer"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"stimulability"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"strangleable"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"strenuosity"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"tabaxir"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"talpiform"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"thwack"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"to"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"tortricine"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"truantcy"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"turgesce"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unbeginning"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"underdunged"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"undesirability"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unerasing"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unguentarium"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unimpeachably"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unmortgaged"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unobstructed"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unreceptivity"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unsatisfactoriness"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unsecurity"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unstressed"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"untasked"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"unvarying"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"vehemently"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"warriorship"] isKindOfClass:NSDictionary.class]) return nil;
        for (id value in [dict[@"warriorship"] allValues]) if (![value isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"whitepot"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"wrothy"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _reimagine = map(_reimagine, λ(id x, [QTReimagine fromJSONDictionary:x]));
        _ressaut = [QTRessaut fromJSONDictionary:(id)_ressaut];
        if (!_ressaut && dict[@"ressaut"] && ![dict[@"ressaut"] isKindOfClass:NSNull.class]) return nil;
        _scatty = map(_scatty, λ(id x, [QTScatty fromJSONDictionary:x]));
        _staghunting = map(_staghunting, λ(id x, [QTStaghunting fromJSONDictionary:x]));
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
        @"reimagine": map(_reimagine, λ(id x, [x JSONDictionary])),
        @"ressaut": [_ressaut JSONDictionary],
        @"scatty": map(_scatty, λ(id x, NSNullify([x isKindOfClass:NSNull.class] ? nil : [x JSONDictionary]))),
        @"staghunting": map(_staghunting, λ(id x, [x JSONDictionary])),
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

@implementation QTPulpitismClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"abnet": @"abnet",
        @"buckhorn": @"buckhorn",
        @"calciform": @"calciform",
        @"chelophore": @"chelophore",
        @"cogitation": @"cogitation",
        @"decreeable": @"decreeable",
        @"despicable": @"despicable",
        @"isodiazo": @"isodiazo",
        @"jadedly": @"jadedly",
        @"leptochlorite": @"leptochlorite",
        @"nursling": @"nursling",
        @"palamedean": @"palamedean",
        @"photoheliograph": @"photoheliograph",
        @"pipewood": @"pipewood",
        @"roberd": @"roberd",
        @"statable": @"statable",
        @"superassume": @"superassume",
        @"syllabe": @"syllabe",
        @"toughhead": @"toughhead",
        @"underburn": @"underburn",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPulpitismClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"abnet"]) return nil;
        if (!dict[@"buckhorn"]) return nil;
        if (!dict[@"calciform"]) return nil;
        if (!dict[@"chelophore"]) return nil;
        if (!dict[@"cogitation"]) return nil;
        if (!dict[@"decreeable"]) return nil;
        if (!dict[@"despicable"]) return nil;
        if (!dict[@"isodiazo"]) return nil;
        if (!dict[@"jadedly"]) return nil;
        if (!dict[@"leptochlorite"]) return nil;
        if (!dict[@"nursling"]) return nil;
        if (!dict[@"palamedean"]) return nil;
        if (!dict[@"photoheliograph"]) return nil;
        if (!dict[@"pipewood"]) return nil;
        if (!dict[@"roberd"]) return nil;
        if (!dict[@"statable"]) return nil;
        if (!dict[@"superassume"]) return nil;
        if (!dict[@"syllabe"]) return nil;
        if (!dict[@"toughhead"]) return nil;
        if (!dict[@"underburn"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPulpitismClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPulpitismClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPulpitismClass.properties.allValues];
}
@end

@implementation QTPyodermiaClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aphoristically": @"aphoristically",
        @"apophyllous": @"apophyllous",
        @"cognize": @"cognize",
        @"dermonosology": @"dermonosology",
        @"Gyppo": @"gyppo",
        @"ither": @"ither",
        @"juglandaceous": @"juglandaceous",
        @"litho": @"litho",
        @"macropterous": @"macropterous",
        @"photographer": @"photographer",
        @"romancing": @"romancing",
        @"rumness": @"rumness",
        @"somniloquist": @"somniloquist",
        @"stressfully": @"stressfully",
        @"tactically": @"tactically",
        @"tracheophony": @"tracheophony",
        @"unappositely": @"unappositely",
        @"unclothedly": @"unclothedly",
        @"unimplied": @"unimplied",
        @"unsyncopated": @"unsyncopated",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPyodermiaClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"aphoristically"]) return nil;
        if (!dict[@"apophyllous"]) return nil;
        if (!dict[@"cognize"]) return nil;
        if (!dict[@"dermonosology"]) return nil;
        if (!dict[@"Gyppo"]) return nil;
        if (!dict[@"ither"]) return nil;
        if (!dict[@"juglandaceous"]) return nil;
        if (!dict[@"litho"]) return nil;
        if (!dict[@"macropterous"]) return nil;
        if (!dict[@"photographer"]) return nil;
        if (!dict[@"romancing"]) return nil;
        if (!dict[@"rumness"]) return nil;
        if (!dict[@"somniloquist"]) return nil;
        if (!dict[@"stressfully"]) return nil;
        if (!dict[@"tactically"]) return nil;
        if (!dict[@"tracheophony"]) return nil;
        if (!dict[@"unappositely"]) return nil;
        if (!dict[@"unclothedly"]) return nil;
        if (!dict[@"unimplied"]) return nil;
        if (!dict[@"unsyncopated"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPyodermiaClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPyodermiaClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPyodermiaClass.properties.allValues] mutableCopy];

    for (id jsonName in QTPyodermiaClass.properties) {
        id propertyName = QTPyodermiaClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTQuebrachineClass
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
    return [dict isKindOfClass:NSDictionary.class] ? [[QTQuebrachineClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTQuebrachineClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTQuebrachineClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTQuebrachineClass.properties.allValues] mutableCopy];

    for (id jsonName in QTQuebrachineClass.properties) {
        id propertyName = QTQuebrachineClass.properties[jsonName];
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

@implementation QTReimagine
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"adducible": @"adducible",
        @"anabolin": @"anabolin",
        @"brainy": @"brainy",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"chrysamine": @"chrysamine",
        @"disdiapason": @"disdiapason",
        @"fluxweed": @"fluxweed",
        @"glaucine": @"glaucine",
        @"grobianism": @"grobianism",
        @"Hermo": @"hermo",
        @"hieroglyphist": @"hieroglyphist",
        @"homocerc": @"homocerc",
        @"icteroid": @"icteroid",
        @"immortal": @"immortal",
        @"impetulant": @"impetulant",
        @"irrigate": @"irrigate",
        @"myxedema": @"myxedema",
        @"nonbookish": @"nonbookish",
        @"onyx": @"onyx",
        @"repasser": @"repasser",
        @"septomarginal": @"septomarginal",
        @"subdie": @"subdie",
        @"tibiometatarsal": @"tibiometatarsal",
        @"waltzlike": @"waltzlike",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTReimagine alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTReimagine.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTReimagine.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTReimagine.properties.allValues] mutableCopy];

    for (id jsonName in QTReimagine.properties) {
        id propertyName = QTReimagine.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTRessaut
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"apperceptive": @"apperceptive",
        @"cuttoo": @"cuttoo",
        @"douser": @"douser",
        @"drinkproof": @"drinkproof",
        @"forementioned": @"forementioned",
        @"Freesia": @"freesia",
        @"Genevieve": @"genevieve",
        @"hyperdiabolical": @"hyperdiabolical",
        @"hypocone": @"hypocone",
        @"irreverentially": @"irreverentially",
        @"jumart": @"jumart",
        @"Mimosaceae": @"mimosaceae",
        @"mollicrush": @"mollicrush",
        @"nedder": @"nedder",
        @"retinasphalt": @"retinasphalt",
        @"sough": @"sough",
        @"steading": @"steading",
        @"Theopaschitism": @"theopaschitism",
        @"undurableness": @"undurableness",
        @"unmingleable": @"unmingleable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRessaut alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"apperceptive"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"cuttoo"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"douser"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"drinkproof"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"forementioned"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Freesia"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Genevieve"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"hyperdiabolical"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"hypocone"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"irreverentially"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"jumart"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Mimosaceae"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mollicrush"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"nedder"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"retinasphalt"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sough"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"steading"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Theopaschitism"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"undurableness"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"unmingleable"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRessaut.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRessaut.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRessaut.properties.allValues] mutableCopy];

    for (id jsonName in QTRessaut.properties) {
        id propertyName = QTRessaut.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTRewriteClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"accountancy": @"accountancy",
        @"cacotrophic": @"cacotrophic",
        @"contest": @"contest",
        @"couthily": @"couthily",
        @"falculate": @"falculate",
        @"foreseize": @"foreseize",
        @"Hyades": @"hyades",
        @"lemnad": @"lemnad",
        @"monotheistically": @"monotheistically",
        @"nonflying": @"nonflying",
        @"Ptenoglossa": @"ptenoglossa",
        @"repatch": @"repatch",
        @"rodman": @"rodman",
        @"strung": @"strung",
        @"titmal": @"titmal",
        @"twalpennyworth": @"twalpennyworth",
        @"unblamable": @"unblamable",
        @"vertical": @"vertical",
        @"Whiggification": @"whiggification",
        @"yardman": @"yardman",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRewriteClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"accountancy"]) return nil;
        if (!dict[@"cacotrophic"]) return nil;
        if (!dict[@"contest"]) return nil;
        if (!dict[@"couthily"]) return nil;
        if (!dict[@"falculate"]) return nil;
        if (!dict[@"foreseize"]) return nil;
        if (!dict[@"Hyades"]) return nil;
        if (!dict[@"lemnad"]) return nil;
        if (!dict[@"monotheistically"]) return nil;
        if (!dict[@"nonflying"]) return nil;
        if (!dict[@"Ptenoglossa"]) return nil;
        if (!dict[@"repatch"]) return nil;
        if (!dict[@"rodman"]) return nil;
        if (!dict[@"strung"]) return nil;
        if (!dict[@"titmal"]) return nil;
        if (!dict[@"twalpennyworth"]) return nil;
        if (!dict[@"unblamable"]) return nil;
        if (!dict[@"vertical"]) return nil;
        if (!dict[@"Whiggification"]) return nil;
        if (!dict[@"yardman"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRewriteClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRewriteClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRewriteClass.properties.allValues] mutableCopy];

    for (id jsonName in QTRewriteClass.properties) {
        id propertyName = QTRewriteClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSantirClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"admiredly": @"admiredly",
        @"demicaponier": @"demicaponier",
        @"epitympanic": @"epitympanic",
        @"investitor": @"investitor",
        @"lupiform": @"lupiform",
        @"monoflagellate": @"monoflagellate",
        @"paleoethnic": @"paleoethnic",
        @"prediscountable": @"prediscountable",
        @"rhetoricals": @"rhetoricals",
        @"roomth": @"roomth",
        @"saccharose": @"saccharose",
        @"septonasal": @"septonasal",
        @"serpenticide": @"serpenticide",
        @"setarious": @"setarious",
        @"spaework": @"spaework",
        @"stylite": @"stylite",
        @"Suessiones": @"suessiones",
        @"timelily": @"timelily",
        @"unprofaned": @"unprofaned",
        @"vorticular": @"vorticular",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSantirClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"admiredly"]) return nil;
        if (!dict[@"demicaponier"]) return nil;
        if (!dict[@"epitympanic"]) return nil;
        if (!dict[@"investitor"]) return nil;
        if (!dict[@"lupiform"]) return nil;
        if (!dict[@"monoflagellate"]) return nil;
        if (!dict[@"paleoethnic"]) return nil;
        if (!dict[@"prediscountable"]) return nil;
        if (!dict[@"rhetoricals"]) return nil;
        if (!dict[@"roomth"]) return nil;
        if (!dict[@"saccharose"]) return nil;
        if (!dict[@"septonasal"]) return nil;
        if (!dict[@"serpenticide"]) return nil;
        if (!dict[@"setarious"]) return nil;
        if (!dict[@"spaework"]) return nil;
        if (!dict[@"stylite"]) return nil;
        if (!dict[@"Suessiones"]) return nil;
        if (!dict[@"timelily"]) return nil;
        if (!dict[@"unprofaned"]) return nil;
        if (!dict[@"vorticular"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSantirClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSantirClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSantirClass.properties.allValues] mutableCopy];

    for (id jsonName in QTSantirClass.properties) {
        id propertyName = QTSantirClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSaxtenClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"algarrobilla": @"algarrobilla",
        @"bowgrace": @"bowgrace",
        @"catharticalness": @"catharticalness",
        @"Centaurid": @"centaurid",
        @"Chirotherium": @"chirotherium",
        @"disdiapason": @"disdiapason",
        @"flix": @"flix",
        @"germanely": @"germanely",
        @"homocerc": @"homocerc",
        @"inhume": @"inhume",
        @"lepidote": @"lepidote",
        @"megalochirous": @"megalochirous",
        @"ninepenny": @"ninepenny",
        @"nonbookish": @"nonbookish",
        @"nondeist": @"nondeist",
        @"nymphaeaceous": @"nymphaeaceous",
        @"parietofrontal": @"parietofrontal",
        @"sancyite": @"sancyite",
        @"subjectivist": @"subjectivist",
        @"tibiad": @"tibiad",
        @"transonic": @"transonic",
        @"tripetalous": @"tripetalous",
        @"trunchman": @"trunchman",
        @"urger": @"urger",
        @"withdrawnness": @"withdrawnness",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSaxtenClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTSaxtenClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSaxtenClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSaxtenClass.properties.allValues] mutableCopy];

    for (id jsonName in QTSaxtenClass.properties) {
        id propertyName = QTSaxtenClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTScatty
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aeriferous": @"aeriferous",
        @"antical": @"antical",
        @"antighostism": @"antighostism",
        @"arcanum": @"arcanum",
        @"autotrophy": @"autotrophy",
        @"baronial": @"baronial",
        @"caffeine": @"caffeine",
        @"gorgoniacean": @"gorgoniacean",
        @"heroical": @"heroical",
        @"hydropical": @"hydropical",
        @"mechanology": @"mechanology",
        @"musicopoetic": @"musicopoetic",
        @"officiality": @"officiality",
        @"oftentimes": @"oftentimes",
        @"ophthalmotonometer": @"ophthalmotonometer",
        @"reflectively": @"reflectively",
        @"springer": @"springer",
        @"Tabasco": @"tabasco",
        @"teleianthous": @"teleianthous",
        @"uncombated": @"uncombated",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTScatty alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"aeriferous"]) return nil;
        if (!dict[@"antical"]) return nil;
        if (!dict[@"antighostism"]) return nil;
        if (!dict[@"arcanum"]) return nil;
        if (!dict[@"autotrophy"]) return nil;
        if (!dict[@"baronial"]) return nil;
        if (!dict[@"caffeine"]) return nil;
        if (!dict[@"gorgoniacean"]) return nil;
        if (!dict[@"heroical"]) return nil;
        if (!dict[@"hydropical"]) return nil;
        if (!dict[@"mechanology"]) return nil;
        if (!dict[@"musicopoetic"]) return nil;
        if (!dict[@"officiality"]) return nil;
        if (!dict[@"oftentimes"]) return nil;
        if (!dict[@"ophthalmotonometer"]) return nil;
        if (!dict[@"reflectively"]) return nil;
        if (!dict[@"springer"]) return nil;
        if (!dict[@"Tabasco"]) return nil;
        if (!dict[@"teleianthous"]) return nil;
        if (!dict[@"uncombated"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTScatty.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTScatty.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTScatty.properties.allValues] mutableCopy];

    for (id jsonName in QTScatty.properties) {
        id propertyName = QTScatty.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSisteringClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"amphicarpic": @"amphicarpic",
        @"Chianti": @"chianti",
        @"frigorific": @"frigorific",
        @"Haplomi": @"haplomi",
        @"hyperkinesis": @"hyperkinesis",
        @"laudable": @"laudable",
        @"madwoman": @"madwoman",
        @"maimedly": @"maimedly",
        @"Micropterygidae": @"micropterygidae",
        @"microrhabdus": @"microrhabdus",
        @"nondense": @"nondense",
        @"phlebemphraxis": @"phlebemphraxis",
        @"redsear": @"redsear",
        @"schismatical": @"schismatical",
        @"tartryl": @"tartryl",
        @"unabhorred": @"unabhorred",
        @"undeliberateness": @"undeliberateness",
        @"unmixable": @"unmixable",
        @"untruckling": @"untruckling",
        @"vineal": @"vineal",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSisteringClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"amphicarpic"]) return nil;
        if (!dict[@"Chianti"]) return nil;
        if (!dict[@"frigorific"]) return nil;
        if (!dict[@"Haplomi"]) return nil;
        if (!dict[@"hyperkinesis"]) return nil;
        if (!dict[@"laudable"]) return nil;
        if (!dict[@"madwoman"]) return nil;
        if (!dict[@"maimedly"]) return nil;
        if (!dict[@"Micropterygidae"]) return nil;
        if (!dict[@"microrhabdus"]) return nil;
        if (!dict[@"nondense"]) return nil;
        if (!dict[@"phlebemphraxis"]) return nil;
        if (!dict[@"redsear"]) return nil;
        if (!dict[@"schismatical"]) return nil;
        if (!dict[@"tartryl"]) return nil;
        if (!dict[@"unabhorred"]) return nil;
        if (!dict[@"undeliberateness"]) return nil;
        if (!dict[@"unmixable"]) return nil;
        if (!dict[@"untruckling"]) return nil;
        if (!dict[@"vineal"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSisteringClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSisteringClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSisteringClass.properties.allValues] mutableCopy];

    for (id jsonName in QTSisteringClass.properties) {
        id propertyName = QTSisteringClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStaghunting
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"calorimetric": @"calorimetric",
        @"canid": @"canid",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"disdiapason": @"disdiapason",
        @"ditriglyphic": @"ditriglyphic",
        @"floriferousness": @"floriferousness",
        @"gamelike": @"gamelike",
        @"grig": @"grig",
        @"homocerc": @"homocerc",
        @"interloan": @"interloan",
        @"lithotomy": @"lithotomy",
        @"loric": @"loric",
        @"membranocoriaceous": @"membranocoriaceous",
        @"membranogenic": @"membranogenic",
        @"nonbookish": @"nonbookish",
        @"overtrump": @"overtrump",
        @"scotino": @"scotino",
        @"seasonable": @"seasonable",
        @"sephen": @"sephen",
        @"stigmarioid": @"stigmarioid",
        @"tired": @"tired",
        @"trifid": @"trifid",
        @"undefeatedly": @"undefeatedly",
        @"ungirlish": @"ungirlish",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStaghunting alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTStaghunting.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStaghunting.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStaghunting.properties.allValues] mutableCopy];

    for (id jsonName in QTStaghunting.properties) {
        id propertyName = QTStaghunting.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStrenuosityClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bliss": @"bliss",
        @"buccate": @"buccate",
        @"bulletproof": @"bulletproof",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"crumblingness": @"crumblingness",
        @"disdiapason": @"disdiapason",
        @"engagedly": @"engagedly",
        @"fightable": @"fightable",
        @"hoariness": @"hoariness",
        @"homocerc": @"homocerc",
        @"hypopodium": @"hypopodium",
        @"luxurist": @"luxurist",
        @"mechanician": @"mechanician",
        @"nonbookish": @"nonbookish",
        @"Onopordon": @"onopordon",
        @"podgily": @"podgily",
        @"reformableness": @"reformableness",
        @"scatterbrains": @"scatterbrains",
        @"seminuria": @"seminuria",
        @"Sodomite": @"sodomite",
        @"tramp": @"tramp",
        @"undueness": @"undueness",
        @"worthily": @"worthily",
        @"Yankeeist": @"yankeeist",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStrenuosityClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTStrenuosityClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStrenuosityClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStrenuosityClass.properties.allValues] mutableCopy];

    for (id jsonName in QTStrenuosityClass.properties) {
        id propertyName = QTStrenuosityClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTruantcyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"alfiona": @"alfiona",
        @"ascaridiasis": @"ascaridiasis",
        @"bungey": @"bungey",
        @"catharticalness": @"catharticalness",
        @"ceroxyle": @"ceroxyle",
        @"Chirotherium": @"chirotherium",
        @"chorology": @"chorology",
        @"disdiapason": @"disdiapason",
        @"enmarble": @"enmarble",
        @"Epeira": @"epeira",
        @"Eurylaimi": @"eurylaimi",
        @"germination": @"germination",
        @"hallelujah": @"hallelujah",
        @"homocerc": @"homocerc",
        @"lev": @"lev",
        @"mouthing": @"mouthing",
        @"nonbookish": @"nonbookish",
        @"philliloo": @"philliloo",
        @"planetal": @"planetal",
        @"poney": @"poney",
        @"punctualist": @"punctualist",
        @"returnlessly": @"returnlessly",
        @"skelder": @"skelder",
        @"windwaywardly": @"windwaywardly",
        @"Yuman": @"yuman",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTruantcyClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTTruantcyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTruantcyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTruantcyClass.properties.allValues] mutableCopy];

    for (id jsonName in QTTruantcyClass.properties) {
        id propertyName = QTTruantcyClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUnimpeachablyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"acerin": @"acerin",
        @"Bobadil": @"bobadil",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"chlorophylligenous": @"chlorophylligenous",
        @"conversational": @"conversational",
        @"demiowl": @"demiowl",
        @"disdiapason": @"disdiapason",
        @"ectorhinal": @"ectorhinal",
        @"gamblesomeness": @"gamblesomeness",
        @"homocerc": @"homocerc",
        @"irrorate": @"irrorate",
        @"kindergartening": @"kindergartening",
        @"lateritic": @"lateritic",
        @"mespil": @"mespil",
        @"misconfiguration": @"misconfiguration",
        @"nonbookish": @"nonbookish",
        @"planometry": @"planometry",
        @"Quiina": @"quiina",
        @"Robert": @"robert",
        @"rot": @"rot",
        @"subcinctorium": @"subcinctorium",
        @"tussocker": @"tussocker",
        @"ultraproud": @"ultraproud",
        @"unsuggestedness": @"unsuggestedness",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnimpeachablyClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTUnimpeachablyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnimpeachablyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUnimpeachablyClass.properties.allValues] mutableCopy];

    for (id jsonName in QTUnimpeachablyClass.properties) {
        id propertyName = QTUnimpeachablyClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUnstressedClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Alain": @"alain",
        @"Amphirhina": @"amphirhina",
        @"antimachinery": @"antimachinery",
        @"coldish": @"coldish",
        @"crantara": @"crantara",
        @"distinguishing": @"distinguishing",
        @"elytroposis": @"elytroposis",
        @"gentianwort": @"gentianwort",
        @"heliosis": @"heliosis",
        @"instrumental": @"instrumental",
        @"introinflection": @"introinflection",
        @"kala": @"kala",
        @"Lincolnian": @"lincolnian",
        @"metad": @"metad",
        @"Sarcophilus": @"sarcophilus",
        @"swingingly": @"swingingly",
        @"unconformity": @"unconformity",
        @"undecreed": @"undecreed",
        @"venerable": @"venerable",
        @"vowellessness": @"vowellessness",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnstressedClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"Alain"]) return nil;
        if (!dict[@"Amphirhina"]) return nil;
        if (!dict[@"antimachinery"]) return nil;
        if (!dict[@"coldish"]) return nil;
        if (!dict[@"crantara"]) return nil;
        if (!dict[@"distinguishing"]) return nil;
        if (!dict[@"elytroposis"]) return nil;
        if (!dict[@"gentianwort"]) return nil;
        if (!dict[@"heliosis"]) return nil;
        if (!dict[@"instrumental"]) return nil;
        if (!dict[@"introinflection"]) return nil;
        if (!dict[@"kala"]) return nil;
        if (!dict[@"Lincolnian"]) return nil;
        if (!dict[@"metad"]) return nil;
        if (!dict[@"Sarcophilus"]) return nil;
        if (!dict[@"swingingly"]) return nil;
        if (!dict[@"unconformity"]) return nil;
        if (!dict[@"undecreed"]) return nil;
        if (!dict[@"venerable"]) return nil;
        if (!dict[@"vowellessness"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUnstressedClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnstressedClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUnstressedClass.properties.allValues] mutableCopy];

    for (id jsonName in QTUnstressedClass.properties) {
        id propertyName = QTUnstressedClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTWrothyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Aeschynanthus": @"aeschynanthus",
        @"aquiferous": @"aquiferous",
        @"cheapener": @"cheapener",
        @"enumeration": @"enumeration",
        @"Ephesine": @"ephesine",
        @"escadrille": @"escadrille",
        @"estrous": @"estrous",
        @"interestedly": @"interestedly",
        @"katakinetomer": @"katakinetomer",
        @"mortification": @"mortification",
        @"morula": @"morula",
        @"orthosymmetrical": @"orthosymmetrical",
        @"overbark": @"overbark",
        @"politist": @"politist",
        @"qualified": @"qualified",
        @"sphenomalar": @"sphenomalar",
        @"throatful": @"throatful",
        @"transhumance": @"transhumance",
        @"triandrian": @"triandrian",
        @"unbooked": @"unbooked",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWrothyClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"Aeschynanthus"]) return nil;
        if (!dict[@"aquiferous"]) return nil;
        if (!dict[@"cheapener"]) return nil;
        if (!dict[@"enumeration"]) return nil;
        if (!dict[@"Ephesine"]) return nil;
        if (!dict[@"escadrille"]) return nil;
        if (!dict[@"estrous"]) return nil;
        if (!dict[@"interestedly"]) return nil;
        if (!dict[@"katakinetomer"]) return nil;
        if (!dict[@"mortification"]) return nil;
        if (!dict[@"morula"]) return nil;
        if (!dict[@"orthosymmetrical"]) return nil;
        if (!dict[@"overbark"]) return nil;
        if (!dict[@"politist"]) return nil;
        if (!dict[@"qualified"]) return nil;
        if (!dict[@"sphenomalar"]) return nil;
        if (!dict[@"throatful"]) return nil;
        if (!dict[@"transhumance"]) return nil;
        if (!dict[@"triandrian"]) return nil;
        if (!dict[@"unbooked"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWrothyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWrothyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTWrothyClass.properties.allValues] mutableCopy];

    for (id jsonName in QTWrothyClass.properties) {
        id propertyName = QTWrothyClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
