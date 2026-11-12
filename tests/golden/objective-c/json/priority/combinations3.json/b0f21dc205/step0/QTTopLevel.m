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

@interface QTJurorClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLadronismClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLandlubberlyClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLupusClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMaslin (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMonaziteClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMonotheisticallyClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNoncontributing (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOccupationalistClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOutrivalClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPiaculumClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPneumocele (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPotwhiskyClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrefreshmanClass (JSONConversion)
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
        @"juror": @"juror",
        @"kongoni": @"kongoni",
        @"ladronism": @"ladronism",
        @"landlubberly": @"landlubberly",
        @"listener": @"listener",
        @"lupus": @"lupus",
        @"maslin": @"maslin",
        @"monazite": @"monazite",
        @"monoliteral": @"monoliteral",
        @"monotheistically": @"monotheistically",
        @"montage": @"montage",
        @"moralness": @"moralness",
        @"mowra": @"mowra",
        @"mulishly": @"mulishly",
        @"myoscope": @"myoscope",
        @"nach": @"nach",
        @"neuromastic": @"neuromastic",
        @"noncontributing": @"noncontributing",
        @"nonnervous": @"nonnervous",
        @"nonvaluation": @"nonvaluation",
        @"occupationalist": @"occupationalist",
        @"outrival": @"outrival",
        @"paleographically": @"paleographically",
        @"pamphletwise": @"pamphletwise",
        @"pediatrics": @"pediatrics",
        @"perceptive": @"perceptive",
        @"piaculum": @"piaculum",
        @"piccadilly": @"piccadilly",
        @"piffler": @"piffler",
        @"pithful": @"pithful",
        @"placuntitis": @"placuntitis",
        @"plectopterous": @"plectopterous",
        @"pneumocele": @"pneumocele",
        @"poliorcetic": @"poliorcetic",
        @"poormaster": @"poormaster",
        @"potwhisky": @"potwhisky",
        @"practicalizer": @"practicalizer",
        @"prefreshman": @"prefreshman",
        @"prehensility": @"prehensility",
        @"prevoidance": @"prevoidance",
        @"probant": @"probant",
        @"protext": @"protext",
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
        if (![dict[@"juror"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"kongoni"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"ladronism"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"landlubberly"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"listener"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"lupus"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"maslin"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"monazite"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"monoliteral"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"monotheistically"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"montage"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"moralness"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"mowra"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"mulishly"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"myoscope"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"nach"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"neuromastic"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"noncontributing"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"nonnervous"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"nonvaluation"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"occupationalist"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"outrival"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"paleographically"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"pamphletwise"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"pediatrics"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"perceptive"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"piaculum"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"piccadilly"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"piffler"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"pithful"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"placuntitis"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"plectopterous"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"pneumocele"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"poliorcetic"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"poormaster"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"potwhisky"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"practicalizer"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"prefreshman"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"prehensility"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"prevoidance"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"probant"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"protext"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _maslin = map(_maslin, λ(id x, [QTMaslin fromJSONDictionary:x]));
        _mowra = map(_mowra, λ(id x, [QTMonaziteClass fromJSONDictionary:x]));
        _noncontributing = map(_noncontributing, λ(id x, [QTNoncontributing fromJSONDictionary:x]));
        _pneumocele = map(_pneumocele, λ(id x, [QTPneumocele fromJSONDictionary:x]));
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
        @"maslin": map(_maslin, λ(id x, [x JSONDictionary])),
        @"mowra": map(_mowra, λ(id x, NSNullify([x isKindOfClass:NSNull.class] ? nil : [x JSONDictionary]))),
        @"noncontributing": map(_noncontributing, λ(id x, [x JSONDictionary])),
        @"pneumocele": map(_pneumocele, λ(id x, NSNullify([x isKindOfClass:NSNull.class] ? nil : [x JSONDictionary]))),
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

@implementation QTJurorClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"adipsy": @"adipsy",
        @"auxiliator": @"auxiliator",
        @"benda": @"benda",
        @"benjamin": @"benjamin",
        @"brandling": @"brandling",
        @"epicurishly": @"epicurishly",
        @"eremochaetous": @"eremochaetous",
        @"marten": @"marten",
        @"monocline": @"monocline",
        @"Olea": @"olea",
        @"palgat": @"palgat",
        @"pennyworth": @"pennyworth",
        @"pioury": @"pioury",
        @"pragmatistic": @"pragmatistic",
        @"stylelessness": @"stylelessness",
        @"systematical": @"systematical",
        @"thready": @"thready",
        @"uncontemporary": @"uncontemporary",
        @"uncouched": @"uncouched",
        @"uninhabitedness": @"uninhabitedness",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJurorClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"adipsy"]) return nil;
        if (!dict[@"auxiliator"]) return nil;
        if (!dict[@"benda"]) return nil;
        if (!dict[@"benjamin"]) return nil;
        if (!dict[@"brandling"]) return nil;
        if (!dict[@"epicurishly"]) return nil;
        if (!dict[@"eremochaetous"]) return nil;
        if (!dict[@"marten"]) return nil;
        if (!dict[@"monocline"]) return nil;
        if (!dict[@"Olea"]) return nil;
        if (!dict[@"palgat"]) return nil;
        if (!dict[@"pennyworth"]) return nil;
        if (!dict[@"pioury"]) return nil;
        if (!dict[@"pragmatistic"]) return nil;
        if (!dict[@"stylelessness"]) return nil;
        if (!dict[@"systematical"]) return nil;
        if (!dict[@"thready"]) return nil;
        if (!dict[@"uncontemporary"]) return nil;
        if (!dict[@"uncouched"]) return nil;
        if (!dict[@"uninhabitedness"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJurorClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJurorClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJurorClass.properties.allValues] mutableCopy];

    for (id jsonName in QTJurorClass.properties) {
        id propertyName = QTJurorClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLadronismClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"acclaimer": @"acclaimer",
        @"achree": @"achree",
        @"base": @"base",
        @"conundrumize": @"conundrumize",
        @"degerminator": @"degerminator",
        @"describable": @"describable",
        @"exasperatedly": @"exasperatedly",
        @"heroine": @"heroine",
        @"indazin": @"indazin",
        @"luteous": @"luteous",
        @"papular": @"papular",
        @"pritch": @"pritch",
        @"Prodenia": @"prodenia",
        @"seege": @"seege",
        @"shopgirl": @"shopgirl",
        @"tragedietta": @"tragedietta",
        @"unsparse": @"unsparse",
        @"uplook": @"uplook",
        @"vermiformis": @"vermiformis",
        @"whafabout": @"whafabout",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLadronismClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"acclaimer"]) return nil;
        if (!dict[@"achree"]) return nil;
        if (!dict[@"base"]) return nil;
        if (!dict[@"conundrumize"]) return nil;
        if (!dict[@"degerminator"]) return nil;
        if (!dict[@"describable"]) return nil;
        if (!dict[@"exasperatedly"]) return nil;
        if (!dict[@"heroine"]) return nil;
        if (!dict[@"indazin"]) return nil;
        if (!dict[@"luteous"]) return nil;
        if (!dict[@"papular"]) return nil;
        if (!dict[@"pritch"]) return nil;
        if (!dict[@"Prodenia"]) return nil;
        if (!dict[@"seege"]) return nil;
        if (!dict[@"shopgirl"]) return nil;
        if (!dict[@"tragedietta"]) return nil;
        if (!dict[@"unsparse"]) return nil;
        if (!dict[@"uplook"]) return nil;
        if (!dict[@"vermiformis"]) return nil;
        if (!dict[@"whafabout"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLadronismClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLadronismClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLadronismClass.properties.allValues] mutableCopy];

    for (id jsonName in QTLadronismClass.properties) {
        id propertyName = QTLadronismClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLandlubberlyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"acropoleis": @"acropoleis",
        @"aminate": @"aminate",
        @"Amyraldism": @"amyraldism",
        @"bipenniform": @"bipenniform",
        @"bugre": @"bugre",
        @"calycule": @"calycule",
        @"caoutchouc": @"caoutchouc",
        @"disprover": @"disprover",
        @"fitroot": @"fitroot",
        @"fulgently": @"fulgently",
        @"kickup": @"kickup",
        @"laevoversion": @"laevoversion",
        @"moter": @"moter",
        @"objectivity": @"objectivity",
        @"posterity": @"posterity",
        @"postnuptial": @"postnuptial",
        @"precedentary": @"precedentary",
        @"saddling": @"saddling",
        @"subcurrent": @"subcurrent",
        @"unrecriminative": @"unrecriminative",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLandlubberlyClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"acropoleis"]) return nil;
        if (!dict[@"aminate"]) return nil;
        if (!dict[@"Amyraldism"]) return nil;
        if (!dict[@"bipenniform"]) return nil;
        if (!dict[@"bugre"]) return nil;
        if (!dict[@"calycule"]) return nil;
        if (!dict[@"caoutchouc"]) return nil;
        if (!dict[@"disprover"]) return nil;
        if (!dict[@"fitroot"]) return nil;
        if (!dict[@"fulgently"]) return nil;
        if (!dict[@"kickup"]) return nil;
        if (!dict[@"laevoversion"]) return nil;
        if (!dict[@"moter"]) return nil;
        if (!dict[@"objectivity"]) return nil;
        if (!dict[@"posterity"]) return nil;
        if (!dict[@"postnuptial"]) return nil;
        if (!dict[@"precedentary"]) return nil;
        if (!dict[@"saddling"]) return nil;
        if (!dict[@"subcurrent"]) return nil;
        if (!dict[@"unrecriminative"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLandlubberlyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLandlubberlyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLandlubberlyClass.properties.allValues] mutableCopy];

    for (id jsonName in QTLandlubberlyClass.properties) {
        id propertyName = QTLandlubberlyClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLupusClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"Chlorioninae": @"chlorioninae",
        @"Corvinae": @"corvinae",
        @"Crassina": @"crassina",
        @"disdiapason": @"disdiapason",
        @"exiguity": @"exiguity",
        @"farcist": @"farcist",
        @"holographical": @"holographical",
        @"homocerc": @"homocerc",
        @"ichthyophagan": @"ichthyophagan",
        @"implacable": @"implacable",
        @"nonbookish": @"nonbookish",
        @"outshiner": @"outshiner",
        @"overweather": @"overweather",
        @"protonegroid": @"protonegroid",
        @"shallowish": @"shallowish",
        @"snoke": @"snoke",
        @"snout": @"snout",
        @"surveillance": @"surveillance",
        @"threshingtime": @"threshingtime",
        @"Thysanocarpus": @"thysanocarpus",
        @"unsignificantly": @"unsignificantly",
        @"unsnap": @"unsnap",
        @"vendible": @"vendible",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLupusClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTLupusClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLupusClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLupusClass.properties.allValues] mutableCopy];

    for (id jsonName in QTLupusClass.properties) {
        id propertyName = QTLupusClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTMaslin
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Alicant": @"alicant",
        @"antiatonement": @"antiatonement",
        @"anticorrosive": @"anticorrosive",
        @"aphidozer": @"aphidozer",
        @"Bakuninist": @"bakuninist",
        @"be": @"be",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"chub": @"chub",
        @"cuprosilicon": @"cuprosilicon",
        @"curtailedly": @"curtailedly",
        @"dellenite": @"dellenite",
        @"Dimitry": @"dimitry",
        @"disdiapason": @"disdiapason",
        @"edifying": @"edifying",
        @"ethmoiditis": @"ethmoiditis",
        @"gastralgy": @"gastralgy",
        @"goatherd": @"goatherd",
        @"hammerdress": @"hammerdress",
        @"hangfire": @"hangfire",
        @"homocerc": @"homocerc",
        @"lacunosity": @"lacunosity",
        @"longiloquence": @"longiloquence",
        @"mameliere": @"mameliere",
        @"motherless": @"motherless",
        @"nonbookish": @"nonbookish",
        @"noncorrodible": @"noncorrodible",
        @"nonsensicality": @"nonsensicality",
        @"oafishly": @"oafishly",
        @"pfund": @"pfund",
        @"preadvisory": @"preadvisory",
        @"retroflexed": @"retroflexed",
        @"saccharulmic": @"saccharulmic",
        @"scowlful": @"scowlful",
        @"secluded": @"secluded",
        @"slackage": @"slackage",
        @"sphaeridial": @"sphaeridial",
        @"spondulics": @"spondulics",
        @"subsecive": @"subsecive",
        @"swellmobsman": @"swellmobsman",
        @"trachyglossate": @"trachyglossate",
        @"trialogue": @"trialogue",
        @"unassuaged": @"unassuaged",
        @"ungross": @"ungross",
        @"unjudiciously": @"unjudiciously",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMaslin alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTMaslin.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMaslin.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMaslin.properties.allValues] mutableCopy];

    for (id jsonName in QTMaslin.properties) {
        id propertyName = QTMaslin.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTMonaziteClass
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
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMonaziteClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTMonaziteClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMonaziteClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMonaziteClass.properties.allValues] mutableCopy];

    for (id jsonName in QTMonaziteClass.properties) {
        id propertyName = QTMonaziteClass.properties[jsonName];
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

@implementation QTMonotheisticallyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"blaspheme": @"blaspheme",
        @"catharticalness": @"catharticalness",
        @"celiosalpingectomy": @"celiosalpingectomy",
        @"Chirotherium": @"chirotherium",
        @"consummativeness": @"consummativeness",
        @"disdiapason": @"disdiapason",
        @"egestive": @"egestive",
        @"enchylema": @"enchylema",
        @"gasconade": @"gasconade",
        @"holidayer": @"holidayer",
        @"homocerc": @"homocerc",
        @"intuitionalism": @"intuitionalism",
        @"lophiostomate": @"lophiostomate",
        @"nonbookish": @"nonbookish",
        @"nonvolition": @"nonvolition",
        @"palatableness": @"palatableness",
        @"pimpery": @"pimpery",
        @"previolation": @"previolation",
        @"reconveyance": @"reconveyance",
        @"registership": @"registership",
        @"rhyacolite": @"rhyacolite",
        @"smithereens": @"smithereens",
        @"superedification": @"superedification",
        @"trust": @"trust",
        @"whitestone": @"whitestone",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMonotheisticallyClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTMonotheisticallyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMonotheisticallyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMonotheisticallyClass.properties.allValues] mutableCopy];

    for (id jsonName in QTMonotheisticallyClass.properties) {
        id propertyName = QTMonotheisticallyClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNoncontributing
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"estevin": @"estevin",
        @"sparsely": @"isSparsely",
        @"jolterhead": @"jolterhead",
        @"sauternes": @"sauternes",
        @"unrequested": @"unrequested",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNoncontributing alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"estevin"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sparsely"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"jolterhead"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"sauternes"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sauternes"] doubleValue] != [dict[@"sauternes"] longLongValue]) return nil;
        if (!dict[@"unrequested"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNoncontributing.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNoncontributing.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNoncontributing.properties.allValues] mutableCopy];

    for (id jsonName in QTNoncontributing.properties) {
        id propertyName = QTNoncontributing.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"sparsely": _isSparsely ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTOccupationalistClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"beholdable": @"beholdable",
        @"brotuliform": @"brotuliform",
        @"Chimakum": @"chimakum",
        @"doodler": @"doodler",
        @"emulsin": @"emulsin",
        @"Fin": @"fin",
        @"flourishing": @"flourishing",
        @"flueless": @"flueless",
        @"furtively": @"furtively",
        @"gritter": @"gritter",
        @"interwish": @"interwish",
        @"monoxylic": @"monoxylic",
        @"myristic": @"myristic",
        @"nightwear": @"nightwear",
        @"peruser": @"peruser",
        @"theoastrological": @"theoastrological",
        @"thumby": @"thumby",
        @"tingitid": @"tingitid",
        @"trailless": @"trailless",
        @"unpocketed": @"unpocketed",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOccupationalistClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"beholdable"]) return nil;
        if (!dict[@"brotuliform"]) return nil;
        if (!dict[@"Chimakum"]) return nil;
        if (!dict[@"doodler"]) return nil;
        if (!dict[@"emulsin"]) return nil;
        if (!dict[@"Fin"]) return nil;
        if (!dict[@"flourishing"]) return nil;
        if (!dict[@"flueless"]) return nil;
        if (!dict[@"furtively"]) return nil;
        if (!dict[@"gritter"]) return nil;
        if (!dict[@"interwish"]) return nil;
        if (!dict[@"monoxylic"]) return nil;
        if (!dict[@"myristic"]) return nil;
        if (!dict[@"nightwear"]) return nil;
        if (!dict[@"peruser"]) return nil;
        if (!dict[@"theoastrological"]) return nil;
        if (!dict[@"thumby"]) return nil;
        if (!dict[@"tingitid"]) return nil;
        if (!dict[@"trailless"]) return nil;
        if (!dict[@"unpocketed"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOccupationalistClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOccupationalistClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOccupationalistClass.properties.allValues] mutableCopy];

    for (id jsonName in QTOccupationalistClass.properties) {
        id propertyName = QTOccupationalistClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTOutrivalClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"adroitly": @"adroitly",
        @"bridehood": @"bridehood",
        @"Castoroides": @"castoroides",
        @"Czechoslovak": @"czechoslovak",
        @"diagenesis": @"diagenesis",
        @"dihexahedron": @"dihexahedron",
        @"dopester": @"dopester",
        @"eumerism": @"eumerism",
        @"flyness": @"flyness",
        @"fouler": @"fouler",
        @"laudanosine": @"laudanosine",
        @"Lingulidae": @"lingulidae",
        @"minutary": @"minutary",
        @"mitra": @"mitra",
        @"opisthorchiasis": @"opisthorchiasis",
        @"pensively": @"pensively",
        @"pubigerous": @"pubigerous",
        @"rebellious": @"rebellious",
        @"recodify": @"recodify",
        @"unpaced": @"unpaced",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOutrivalClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"adroitly"]) return nil;
        if (!dict[@"bridehood"]) return nil;
        if (!dict[@"Castoroides"]) return nil;
        if (!dict[@"Czechoslovak"]) return nil;
        if (!dict[@"diagenesis"]) return nil;
        if (!dict[@"dihexahedron"]) return nil;
        if (!dict[@"dopester"]) return nil;
        if (!dict[@"eumerism"]) return nil;
        if (!dict[@"flyness"]) return nil;
        if (!dict[@"fouler"]) return nil;
        if (!dict[@"laudanosine"]) return nil;
        if (!dict[@"Lingulidae"]) return nil;
        if (!dict[@"minutary"]) return nil;
        if (!dict[@"mitra"]) return nil;
        if (!dict[@"opisthorchiasis"]) return nil;
        if (!dict[@"pensively"]) return nil;
        if (!dict[@"pubigerous"]) return nil;
        if (!dict[@"rebellious"]) return nil;
        if (!dict[@"recodify"]) return nil;
        if (!dict[@"unpaced"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOutrivalClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOutrivalClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOutrivalClass.properties.allValues] mutableCopy];

    for (id jsonName in QTOutrivalClass.properties) {
        id propertyName = QTOutrivalClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPiaculumClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"alada": @"alada",
        @"amphistomous": @"amphistomous",
        @"boysenberry": @"boysenberry",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"decardinalize": @"decardinalize",
        @"discouragement": @"discouragement",
        @"disdiapason": @"disdiapason",
        @"doitrified": @"doitrified",
        @"hexaspermous": @"hexaspermous",
        @"homocerc": @"homocerc",
        @"insinking": @"insinking",
        @"loathfulness": @"loathfulness",
        @"miasmatical": @"miasmatical",
        @"neurofibril": @"neurofibril",
        @"nonbookish": @"nonbookish",
        @"phonendoscope": @"phonendoscope",
        @"pilferment": @"pilferment",
        @"predismissory": @"predismissory",
        @"preinscription": @"preinscription",
        @"quotative": @"quotative",
        @"sienna": @"sienna",
        @"thorax": @"thorax",
        @"yachting": @"yachting",
        @"Zipper": @"zipper",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPiaculumClass alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTPiaculumClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPiaculumClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPiaculumClass.properties.allValues] mutableCopy];

    for (id jsonName in QTPiaculumClass.properties) {
        id propertyName = QTPiaculumClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPneumocele
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Carbonarism": @"carbonarism",
        @"catharticalness": @"catharticalness",
        @"Chirotherium": @"chirotherium",
        @"cineolic": @"cineolic",
        @"cobbly": @"cobbly",
        @"conchyliferous": @"conchyliferous",
        @"congregation": @"congregation",
        @"disdiapason": @"disdiapason",
        @"enterotomy": @"enterotomy",
        @"entophytal": @"entophytal",
        @"fewtrils": @"fewtrils",
        @"herem": @"herem",
        @"homocerc": @"homocerc",
        @"Koniga": @"koniga",
        @"meticulosity": @"meticulosity",
        @"Micky": @"micky",
        @"mismarriage": @"mismarriage",
        @"neurotrophic": @"neurotrophic",
        @"nonbookish": @"nonbookish",
        @"persuasively": @"persuasively",
        @"replaceable": @"replaceable",
        @"silex": @"silex",
        @"taillight": @"taillight",
        @"unjealous": @"unjealous",
        @"visitorial": @"visitorial",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPneumocele alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTPneumocele.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPneumocele.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPneumocele.properties.allValues] mutableCopy];

    for (id jsonName in QTPneumocele.properties) {
        id propertyName = QTPneumocele.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPotwhiskyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"arciform": @"arciform",
        @"cresolin": @"cresolin",
        @"disheartener": @"disheartener",
        @"disproportionable": @"disproportionable",
        @"Euchorda": @"euchorda",
        @"ferryway": @"ferryway",
        @"filamentiferous": @"filamentiferous",
        @"flemish": @"flemish",
        @"forgainst": @"forgainst",
        @"grainering": @"grainering",
        @"irrevoluble": @"irrevoluble",
        @"kindredship": @"kindredship",
        @"pinguitudinous": @"pinguitudinous",
        @"simpletonic": @"simpletonic",
        @"singsong": @"singsong",
        @"submergement": @"submergement",
        @"supraoesophagal": @"supraoesophagal",
        @"thrashel": @"thrashel",
        @"tyremesis": @"tyremesis",
        @"Yoruba": @"yoruba",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPotwhiskyClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"arciform"]) return nil;
        if (!dict[@"cresolin"]) return nil;
        if (!dict[@"disheartener"]) return nil;
        if (!dict[@"disproportionable"]) return nil;
        if (!dict[@"Euchorda"]) return nil;
        if (!dict[@"ferryway"]) return nil;
        if (!dict[@"filamentiferous"]) return nil;
        if (!dict[@"flemish"]) return nil;
        if (!dict[@"forgainst"]) return nil;
        if (!dict[@"grainering"]) return nil;
        if (!dict[@"irrevoluble"]) return nil;
        if (!dict[@"kindredship"]) return nil;
        if (!dict[@"pinguitudinous"]) return nil;
        if (!dict[@"simpletonic"]) return nil;
        if (!dict[@"singsong"]) return nil;
        if (!dict[@"submergement"]) return nil;
        if (!dict[@"supraoesophagal"]) return nil;
        if (!dict[@"thrashel"]) return nil;
        if (!dict[@"tyremesis"]) return nil;
        if (!dict[@"Yoruba"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPotwhiskyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPotwhiskyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPotwhiskyClass.properties.allValues] mutableCopy];

    for (id jsonName in QTPotwhiskyClass.properties) {
        id propertyName = QTPotwhiskyClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPrefreshmanClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"azorubine": @"azorubine",
        @"choroiditis": @"choroiditis",
        @"coagulatory": @"coagulatory",
        @"cyclorama": @"cyclorama",
        @"Dolphus": @"dolphus",
        @"duckhearted": @"duckhearted",
        @"Ficus": @"ficus",
        @"Gemaric": @"gemaric",
        @"jugation": @"jugation",
        @"myoliposis": @"myoliposis",
        @"nonnomination": @"nonnomination",
        @"palay": @"palay",
        @"pentactinal": @"pentactinal",
        @"Phaet": @"phaet",
        @"piquant": @"piquant",
        @"registration": @"registration",
        @"remancipation": @"remancipation",
        @"scutatiform": @"scutatiform",
        @"theodolite": @"theodolite",
        @"underward": @"underward",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrefreshmanClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"azorubine"]) return nil;
        if (!dict[@"choroiditis"]) return nil;
        if (!dict[@"coagulatory"]) return nil;
        if (!dict[@"cyclorama"]) return nil;
        if (!dict[@"Dolphus"]) return nil;
        if (!dict[@"duckhearted"]) return nil;
        if (!dict[@"Ficus"]) return nil;
        if (!dict[@"Gemaric"]) return nil;
        if (!dict[@"jugation"]) return nil;
        if (!dict[@"myoliposis"]) return nil;
        if (!dict[@"nonnomination"]) return nil;
        if (!dict[@"palay"]) return nil;
        if (!dict[@"pentactinal"]) return nil;
        if (!dict[@"Phaet"]) return nil;
        if (!dict[@"piquant"]) return nil;
        if (!dict[@"registration"]) return nil;
        if (!dict[@"remancipation"]) return nil;
        if (!dict[@"scutatiform"]) return nil;
        if (!dict[@"theodolite"]) return nil;
        if (!dict[@"underward"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrefreshmanClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrefreshmanClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPrefreshmanClass.properties.allValues] mutableCopy];

    for (id jsonName in QTPrefreshmanClass.properties) {
        id propertyName = QTPrefreshmanClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
