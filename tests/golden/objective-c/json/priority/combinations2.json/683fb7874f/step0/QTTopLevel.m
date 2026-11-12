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

@interface QTAlleviateClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRebecca (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAmphithyron (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAnkeeClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAnsarieClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChytridiaceaeClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDiscordiaClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGryphosaurusClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLaviniaClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOskarClass (JSONConversion)
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
        @"Abranchiata": @"abranchiata",
        @"academe": @"academe",
        @"acquirable": @"acquirable",
        @"aerometry": @"aerometry",
        @"alexin": @"alexin",
        @"alleviate": @"alleviate",
        @"amaas": @"amaas",
        @"ambassage": @"ambassage",
        @"amphithyron": @"amphithyron",
        @"Andriana": @"andriana",
        @"ankee": @"ankee",
        @"annihilator": @"annihilator",
        @"annulose": @"annulose",
        @"Ansarie": @"ansarie",
        @"aphasia": @"aphasia",
        @"asprawl": @"asprawl",
        @"attractive": @"attractive",
        @"barksome": @"barksome",
        @"bedesman": @"bedesman",
        @"belard": @"belard",
        @"bocking": @"bocking",
        @"brawlingly": @"brawlingly",
        @"brookie": @"brookie",
        @"bumboatman": @"bumboatman",
        @"bystreet": @"bystreet",
        @"calaverite": @"calaverite",
        @"catallactic": @"catallactic",
        @"cemental": @"cemental",
        @"Chytridiaceae": @"chytridiaceae",
        @"Discordia": @"discordia",
        @"Endomyces": @"endomyces",
        @"Epinephelidae": @"epinephelidae",
        @"Eupatorium": @"eupatorium",
        @"Gryphosaurus": @"gryphosaurus",
        @"Rigsmal": @"isRigsmal",
        @"Koryak": @"koryak",
        @"Lavinia": @"lavinia",
        @"Oskar": @"oskar",
        @"Rebecca": @"rebecca",
        @"Rhomboganoidei": @"rhomboganoidei",
        @"Ruellia": @"ruellia",
        @"School": @"school",
        @"Shakespearolater": @"shakespearolater",
        @"Svan": @"svan",
        @"Wayao": @"wayao",
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
        if (![dict[@"Abranchiata"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"academe"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"acquirable"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"aerometry"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"alexin"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"alleviate"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"amaas"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"ambassage"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"amphithyron"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Andriana"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"ankee"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"annihilator"] isKindOfClass:NSArray.class]) return nil;
        if (!dict[@"annulose"]) return nil;
        if (![dict[@"Ansarie"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"aphasia"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"asprawl"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"attractive"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"barksome"] isKindOfClass:NSDictionary.class]) return nil;
        for (id value in [dict[@"barksome"] allValues]) if (![value isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"bedesman"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"belard"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"bocking"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"brawlingly"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"brookie"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"bumboatman"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"bystreet"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"calaverite"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"catallactic"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"cemental"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Chytridiaceae"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Discordia"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Endomyces"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Epinephelidae"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Eupatorium"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Gryphosaurus"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Rigsmal"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"Koryak"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Lavinia"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Oskar"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Rebecca"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Rhomboganoidei"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Ruellia"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"School"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Shakespearolater"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Svan"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"Wayao"] isKindOfClass:NSDictionary.class]) return nil;
        for (id value in [dict[@"Wayao"] allValues]) if (![value isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _amphithyron = map(_amphithyron, λ(id x, [QTAmphithyron fromJSONDictionary:x]));
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
        @"amphithyron": map(_amphithyron, λ(id x, NSNullify([x isKindOfClass:NSNull.class] ? nil : [x JSONDictionary]))),
        @"Rigsmal": _isRigsmal ? @YES : @NO,
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

@implementation QTAlleviateClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"apriori": @"apriori",
        @"beggarer": @"beggarer",
        @"brokenheartedly": @"brokenheartedly",
        @"debilitation": @"debilitation",
        @"frike": @"frike",
        @"gastrolith": @"gastrolith",
        @"Hulsean": @"hulsean",
        @"orthocentric": @"orthocentric",
        @"petaly": @"petaly",
        @"probudgeting": @"probudgeting",
        @"reacquire": @"reacquire",
        @"scow": @"scow",
        @"shutoff": @"shutoff",
        @"subcontiguous": @"subcontiguous",
        @"suffumigate": @"suffumigate",
        @"transformable": @"transformable",
        @"uncoroneted": @"uncoroneted",
        @"unparking": @"unparking",
        @"unvarnishedness": @"unvarnishedness",
        @"wherewithal": @"wherewithal",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAlleviateClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"apriori"]) return nil;
        if (!dict[@"beggarer"]) return nil;
        if (!dict[@"brokenheartedly"]) return nil;
        if (!dict[@"debilitation"]) return nil;
        if (!dict[@"frike"]) return nil;
        if (!dict[@"gastrolith"]) return nil;
        if (!dict[@"Hulsean"]) return nil;
        if (!dict[@"orthocentric"]) return nil;
        if (!dict[@"petaly"]) return nil;
        if (!dict[@"probudgeting"]) return nil;
        if (!dict[@"reacquire"]) return nil;
        if (!dict[@"scow"]) return nil;
        if (!dict[@"shutoff"]) return nil;
        if (!dict[@"subcontiguous"]) return nil;
        if (!dict[@"suffumigate"]) return nil;
        if (!dict[@"transformable"]) return nil;
        if (!dict[@"uncoroneted"]) return nil;
        if (!dict[@"unparking"]) return nil;
        if (!dict[@"unvarnishedness"]) return nil;
        if (!dict[@"wherewithal"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAlleviateClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAlleviateClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAlleviateClass.properties.allValues] mutableCopy];

    for (id jsonName in QTAlleviateClass.properties) {
        id propertyName = QTAlleviateClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTRebecca
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
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRebecca alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTRebecca.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRebecca.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRebecca.properties.allValues] mutableCopy];

    for (id jsonName in QTRebecca.properties) {
        id propertyName = QTRebecca.properties[jsonName];
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

@implementation QTAmphithyron
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"akroasis": @"akroasis",
        @"antiphonical": @"antiphonical",
        @"basebred": @"basebred",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"conductometric": @"conductometric",
        @"disdiapason": @"disdiapason",
        @"ensilation": @"ensilation",
        @"eyebolt": @"eyebolt",
        @"fistulated": @"fistulated",
        @"heteropod": @"heteropod",
        @"homocerc": @"homocerc",
        @"Juniperus": @"juniperus",
        @"labyrinthically": @"labyrinthically",
        @"martyrization": @"martyrization",
        @"mispolicy": @"mispolicy",
        @"multipara": @"multipara",
        @"Nazirite": @"nazirite",
        @"nonbookish": @"nonbookish",
        @"possessorial": @"possessorial",
        @"shamed": @"shamed",
        @"shelfworn": @"shelfworn",
        @"stagnum": @"stagnum",
        @"Those": @"those",
        @"undecimal": @"undecimal",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAmphithyron alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTAmphithyron.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAmphithyron.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAmphithyron.properties.allValues] mutableCopy];

    for (id jsonName in QTAmphithyron.properties) {
        id propertyName = QTAmphithyron.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAnkeeClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Anomoean": @"anomoean",
        @"barleyhood": @"barleyhood",
        @"befriender": @"befriender",
        @"brutishness": @"brutishness",
        @"cephalalgy": @"cephalalgy",
        @"cirurgian": @"cirurgian",
        @"conventionally": @"conventionally",
        @"jackshay": @"jackshay",
        @"milammeter": @"milammeter",
        @"Naja": @"naja",
        @"ombrological": @"ombrological",
        @"phonasthenia": @"phonasthenia",
        @"retrievableness": @"retrievableness",
        @"snakily": @"snakily",
        @"swot": @"swot",
        @"tartlet": @"tartlet",
        @"thiofuran": @"thiofuran",
        @"tracheophone": @"tracheophone",
        @"tuglike": @"tuglike",
        @"unscratchingly": @"unscratchingly",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAnkeeClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"Anomoean"]) return nil;
        if (!dict[@"barleyhood"]) return nil;
        if (!dict[@"befriender"]) return nil;
        if (!dict[@"brutishness"]) return nil;
        if (!dict[@"cephalalgy"]) return nil;
        if (!dict[@"cirurgian"]) return nil;
        if (!dict[@"conventionally"]) return nil;
        if (!dict[@"jackshay"]) return nil;
        if (!dict[@"milammeter"]) return nil;
        if (!dict[@"Naja"]) return nil;
        if (!dict[@"ombrological"]) return nil;
        if (!dict[@"phonasthenia"]) return nil;
        if (!dict[@"retrievableness"]) return nil;
        if (!dict[@"snakily"]) return nil;
        if (!dict[@"swot"]) return nil;
        if (!dict[@"tartlet"]) return nil;
        if (!dict[@"thiofuran"]) return nil;
        if (!dict[@"tracheophone"]) return nil;
        if (!dict[@"tuglike"]) return nil;
        if (!dict[@"unscratchingly"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAnkeeClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAnkeeClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAnkeeClass.properties.allValues] mutableCopy];

    for (id jsonName in QTAnkeeClass.properties) {
        id propertyName = QTAnkeeClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAnsarieClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"accension": @"accension",
        @"Alida": @"alida",
        @"asteria": @"asteria",
        @"beriberic": @"beriberic",
        @"edgebone": @"edgebone",
        @"gastrodialysis": @"gastrodialysis",
        @"geographic": @"geographic",
        @"Ictonyx": @"ictonyx",
        @"metrocele": @"metrocele",
        @"misgraft": @"misgraft",
        @"monteith": @"monteith",
        @"notcher": @"notcher",
        @"prorestriction": @"prorestriction",
        @"Ramist": @"ramist",
        @"throatlet": @"throatlet",
        @"unfair": @"unfair",
        @"unsynonymous": @"unsynonymous",
        @"water": @"water",
        @"zestfully": @"zestfully",
        @"zincic": @"zincic",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAnsarieClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"accension"]) return nil;
        if (!dict[@"Alida"]) return nil;
        if (!dict[@"asteria"]) return nil;
        if (!dict[@"beriberic"]) return nil;
        if (!dict[@"edgebone"]) return nil;
        if (!dict[@"gastrodialysis"]) return nil;
        if (!dict[@"geographic"]) return nil;
        if (!dict[@"Ictonyx"]) return nil;
        if (!dict[@"metrocele"]) return nil;
        if (!dict[@"misgraft"]) return nil;
        if (!dict[@"monteith"]) return nil;
        if (!dict[@"notcher"]) return nil;
        if (!dict[@"prorestriction"]) return nil;
        if (!dict[@"Ramist"]) return nil;
        if (!dict[@"throatlet"]) return nil;
        if (!dict[@"unfair"]) return nil;
        if (!dict[@"unsynonymous"]) return nil;
        if (!dict[@"water"]) return nil;
        if (!dict[@"zestfully"]) return nil;
        if (!dict[@"zincic"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAnsarieClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAnsarieClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAnsarieClass.properties.allValues] mutableCopy];

    for (id jsonName in QTAnsarieClass.properties) {
        id propertyName = QTAnsarieClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTChytridiaceaeClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Batidaceae": @"batidaceae",
        @"Brechites": @"brechites",
        @"codespairer": @"codespairer",
        @"Emery": @"emery",
        @"enervative": @"enervative",
        @"excriminate": @"excriminate",
        @"goshenite": @"goshenite",
        @"grime": @"grime",
        @"gritten": @"gritten",
        @"hectorly": @"hectorly",
        @"intermediation": @"intermediation",
        @"meeterly": @"meeterly",
        @"Narraganset": @"narraganset",
        @"onymatic": @"onymatic",
        @"paddlecock": @"paddlecock",
        @"thana": @"thana",
        @"thornily": @"thornily",
        @"uckia": @"uckia",
        @"unmettle": @"unmettle",
        @"vorticellid": @"vorticellid",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChytridiaceaeClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"Batidaceae"]) return nil;
        if (!dict[@"Brechites"]) return nil;
        if (!dict[@"codespairer"]) return nil;
        if (!dict[@"Emery"]) return nil;
        if (!dict[@"enervative"]) return nil;
        if (!dict[@"excriminate"]) return nil;
        if (!dict[@"goshenite"]) return nil;
        if (!dict[@"grime"]) return nil;
        if (!dict[@"gritten"]) return nil;
        if (!dict[@"hectorly"]) return nil;
        if (!dict[@"intermediation"]) return nil;
        if (!dict[@"meeterly"]) return nil;
        if (!dict[@"Narraganset"]) return nil;
        if (!dict[@"onymatic"]) return nil;
        if (!dict[@"paddlecock"]) return nil;
        if (!dict[@"thana"]) return nil;
        if (!dict[@"thornily"]) return nil;
        if (!dict[@"uckia"]) return nil;
        if (!dict[@"unmettle"]) return nil;
        if (!dict[@"vorticellid"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChytridiaceaeClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChytridiaceaeClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChytridiaceaeClass.properties.allValues] mutableCopy];

    for (id jsonName in QTChytridiaceaeClass.properties) {
        id propertyName = QTChytridiaceaeClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDiscordiaClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Altaic": @"altaic",
        @"amoristic": @"amoristic",
        @"blennophthalmia": @"blennophthalmia",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"disciplinability": @"disciplinability",
        @"disdiapason": @"disdiapason",
        @"goofer": @"goofer",
        @"homocerc": @"homocerc",
        @"laryngograph": @"laryngograph",
        @"leucitis": @"leucitis",
        @"lymphocyst": @"lymphocyst",
        @"microcosmology": @"microcosmology",
        @"nauseation": @"nauseation",
        @"nonbookish": @"nonbookish",
        @"Patarin": @"patarin",
        @"preliberal": @"preliberal",
        @"prettifier": @"prettifier",
        @"rangework": @"rangework",
        @"redient": @"redient",
        @"subfusiform": @"subfusiform",
        @"suicidical": @"suicidical",
        @"swow": @"swow",
        @"wastrel": @"wastrel",
        @"wingle": @"wingle",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDiscordiaClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTDiscordiaClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDiscordiaClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDiscordiaClass.properties.allValues] mutableCopy];

    for (id jsonName in QTDiscordiaClass.properties) {
        id propertyName = QTDiscordiaClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTGryphosaurusClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"amissibility": @"amissibility",
        @"Burushaski": @"burushaski",
        @"citronin": @"citronin",
        @"coplaintiff": @"coplaintiff",
        @"disquisitionary": @"disquisitionary",
        @"enoplan": @"enoplan",
        @"faintness": @"faintness",
        @"hebetomy": @"hebetomy",
        @"islandry": @"islandry",
        @"lameduck": @"lameduck",
        @"overbattle": @"overbattle",
        @"overinterested": @"overinterested",
        @"phrenologic": @"phrenologic",
        @"rainband": @"rainband",
        @"shiningly": @"shiningly",
        @"stamineous": @"stamineous",
        @"subscapularis": @"subscapularis",
        @"Tahami": @"tahami",
        @"undaubed": @"undaubed",
        @"underntime": @"underntime",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGryphosaurusClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"amissibility"]) return nil;
        if (!dict[@"Burushaski"]) return nil;
        if (!dict[@"citronin"]) return nil;
        if (!dict[@"coplaintiff"]) return nil;
        if (!dict[@"disquisitionary"]) return nil;
        if (!dict[@"enoplan"]) return nil;
        if (!dict[@"faintness"]) return nil;
        if (!dict[@"hebetomy"]) return nil;
        if (!dict[@"islandry"]) return nil;
        if (!dict[@"lameduck"]) return nil;
        if (!dict[@"overbattle"]) return nil;
        if (!dict[@"overinterested"]) return nil;
        if (!dict[@"phrenologic"]) return nil;
        if (!dict[@"rainband"]) return nil;
        if (!dict[@"shiningly"]) return nil;
        if (!dict[@"stamineous"]) return nil;
        if (!dict[@"subscapularis"]) return nil;
        if (!dict[@"Tahami"]) return nil;
        if (!dict[@"undaubed"]) return nil;
        if (!dict[@"underntime"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGryphosaurusClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGryphosaurusClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGryphosaurusClass.properties.allValues] mutableCopy];

    for (id jsonName in QTGryphosaurusClass.properties) {
        id propertyName = QTGryphosaurusClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLaviniaClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"agitable": @"agitable",
        @"asininity": @"asininity",
        @"benefiter": @"benefiter",
        @"bronzelike": @"bronzelike",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"cholesteatomatous": @"cholesteatomatous",
        @"deprivement": @"deprivement",
        @"disdiapason": @"disdiapason",
        @"flippantness": @"flippantness",
        @"fogproof": @"fogproof",
        @"homocerc": @"homocerc",
        @"merrymeeting": @"merrymeeting",
        @"nonbookish": @"nonbookish",
        @"overcareful": @"overcareful",
        @"panaris": @"panaris",
        @"preacceptance": @"preacceptance",
        @"quinoxaline": @"quinoxaline",
        @"sig": @"sig",
        @"superconfusion": @"superconfusion",
        @"Tacana": @"tacana",
        @"tillotter": @"tillotter",
        @"tranquillize": @"tranquillize",
        @"unquestionable": @"unquestionable",
        @"uproute": @"uproute",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLaviniaClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTLaviniaClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLaviniaClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLaviniaClass.properties.allValues] mutableCopy];

    for (id jsonName in QTLaviniaClass.properties) {
        id propertyName = QTLaviniaClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTOskarClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Acrobates": @"acrobates",
        @"beanshooter": @"beanshooter",
        @"bearhound": @"bearhound",
        @"Cayuga": @"cayuga",
        @"guarneri": @"guarneri",
        @"hypochondriacism": @"hypochondriacism",
        @"indication": @"indication",
        @"jaculative": @"jaculative",
        @"nagana": @"nagana",
        @"Netherlandish": @"netherlandish",
        @"noctivagous": @"noctivagous",
        @"nonphysiological": @"nonphysiological",
        @"praxis": @"praxis",
        @"provision": @"provision",
        @"subterhuman": @"subterhuman",
        @"sunlit": @"sunlit",
        @"syncraniate": @"syncraniate",
        @"teachment": @"teachment",
        @"unmutinous": @"unmutinous",
        @"unstoppable": @"unstoppable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOskarClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"Acrobates"]) return nil;
        if (!dict[@"beanshooter"]) return nil;
        if (!dict[@"bearhound"]) return nil;
        if (!dict[@"Cayuga"]) return nil;
        if (!dict[@"guarneri"]) return nil;
        if (!dict[@"hypochondriacism"]) return nil;
        if (!dict[@"indication"]) return nil;
        if (!dict[@"jaculative"]) return nil;
        if (!dict[@"nagana"]) return nil;
        if (!dict[@"Netherlandish"]) return nil;
        if (!dict[@"noctivagous"]) return nil;
        if (!dict[@"nonphysiological"]) return nil;
        if (!dict[@"praxis"]) return nil;
        if (!dict[@"provision"]) return nil;
        if (!dict[@"subterhuman"]) return nil;
        if (!dict[@"sunlit"]) return nil;
        if (!dict[@"syncraniate"]) return nil;
        if (!dict[@"teachment"]) return nil;
        if (!dict[@"unmutinous"]) return nil;
        if (!dict[@"unstoppable"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOskarClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOskarClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOskarClass.properties.allValues] mutableCopy];

    for (id jsonName in QTOskarClass.properties) {
        id propertyName = QTOskarClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
