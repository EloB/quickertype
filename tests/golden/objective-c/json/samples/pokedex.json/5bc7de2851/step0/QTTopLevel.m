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

@interface QTPokemon (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEvolution (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTEgg
+ (NSDictionary<NSString *, QTEgg *> *)values
{
    static NSDictionary<NSString *, QTEgg *> *values;
    return values = values ? values : @{
        @"2 km": [[QTEgg alloc] initWithValue:@"2 km"],
        @"Not in Eggs": [[QTEgg alloc] initWithValue:@"Not in Eggs"],
        @"5 km": [[QTEgg alloc] initWithValue:@"5 km"],
        @"10 km": [[QTEgg alloc] initWithValue:@"10 km"],
        @"Omanyte Candy": [[QTEgg alloc] initWithValue:@"Omanyte Candy"],
    };
}

+ (QTEgg *)the2KM { return QTEgg.values[@"2 km"]; }
+ (QTEgg *)notInEggs { return QTEgg.values[@"Not in Eggs"]; }
+ (QTEgg *)the5KM { return QTEgg.values[@"5 km"]; }
+ (QTEgg *)the10KM { return QTEgg.values[@"10 km"]; }
+ (QTEgg *)omanyteCandy { return QTEgg.values[@"Omanyte Candy"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTEgg.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTType
+ (NSDictionary<NSString *, QTType *> *)values
{
    static NSDictionary<NSString *, QTType *> *values;
    return values = values ? values : @{
        @"Fire": [[QTType alloc] initWithValue:@"Fire"],
        @"Ice": [[QTType alloc] initWithValue:@"Ice"],
        @"Flying": [[QTType alloc] initWithValue:@"Flying"],
        @"Psychic": [[QTType alloc] initWithValue:@"Psychic"],
        @"Water": [[QTType alloc] initWithValue:@"Water"],
        @"Ground": [[QTType alloc] initWithValue:@"Ground"],
        @"Rock": [[QTType alloc] initWithValue:@"Rock"],
        @"Electric": [[QTType alloc] initWithValue:@"Electric"],
        @"Grass": [[QTType alloc] initWithValue:@"Grass"],
        @"Fighting": [[QTType alloc] initWithValue:@"Fighting"],
        @"Poison": [[QTType alloc] initWithValue:@"Poison"],
        @"Bug": [[QTType alloc] initWithValue:@"Bug"],
        @"Fairy": [[QTType alloc] initWithValue:@"Fairy"],
        @"Ghost": [[QTType alloc] initWithValue:@"Ghost"],
        @"Dark": [[QTType alloc] initWithValue:@"Dark"],
        @"Steel": [[QTType alloc] initWithValue:@"Steel"],
        @"Dragon": [[QTType alloc] initWithValue:@"Dragon"],
        @"Normal": [[QTType alloc] initWithValue:@"Normal"],
    };
}

+ (QTType *)fire { return QTType.values[@"Fire"]; }
+ (QTType *)ice { return QTType.values[@"Ice"]; }
+ (QTType *)flying { return QTType.values[@"Flying"]; }
+ (QTType *)psychic { return QTType.values[@"Psychic"]; }
+ (QTType *)water { return QTType.values[@"Water"]; }
+ (QTType *)ground { return QTType.values[@"Ground"]; }
+ (QTType *)rock { return QTType.values[@"Rock"]; }
+ (QTType *)electric { return QTType.values[@"Electric"]; }
+ (QTType *)grass { return QTType.values[@"Grass"]; }
+ (QTType *)fighting { return QTType.values[@"Fighting"]; }
+ (QTType *)poison { return QTType.values[@"Poison"]; }
+ (QTType *)bug { return QTType.values[@"Bug"]; }
+ (QTType *)fairy { return QTType.values[@"Fairy"]; }
+ (QTType *)ghost { return QTType.values[@"Ghost"]; }
+ (QTType *)dark { return QTType.values[@"Dark"]; }
+ (QTType *)steel { return QTType.values[@"Steel"]; }
+ (QTType *)dragon { return QTType.values[@"Dragon"]; }
+ (QTType *)normal { return QTType.values[@"Normal"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTType.values[value];
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
        @"pokemon": @"pokemon",
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
        if (![dict[@"pokemon"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _pokemon = map(_pokemon, λ(id x, [QTPokemon fromJSONDictionary:x]));
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
        @"pokemon": map(_pokemon, λ(id x, [x JSONDictionary])),
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

@implementation QTPokemon
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"avg_spawns": @"avgSpawns",
        @"candy": @"candy",
        @"candy_count": @"candyCount",
        @"egg": @"egg",
        @"height": @"height",
        @"id": @"identifier",
        @"img": @"img",
        @"multipliers": @"multipliers",
        @"name": @"name",
        @"next_evolution": @"nextEvolution",
        @"num": @"num",
        @"prev_evolution": @"prevEvolution",
        @"spawn_chance": @"spawnChance",
        @"spawn_time": @"spawnTime",
        @"type": @"type",
        @"weaknesses": @"weaknesses",
        @"weight": @"weight",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPokemon alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"avg_spawns"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"candy"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"egg"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"height"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"img"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"multipliers"]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"num"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"spawn_chance"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"spawn_time"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"weaknesses"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"weight"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _egg = [QTEgg withValue:(id)_egg];
        _nextEvolution = map(_nextEvolution, λ(id x, [QTEvolution fromJSONDictionary:x]));
        _prevEvolution = map(_prevEvolution, λ(id x, [QTEvolution fromJSONDictionary:x]));
        _type = map(_type, λ(id x, [QTType withValue:x]));
        _weaknesses = map(_weaknesses, λ(id x, [QTType withValue:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPokemon.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPokemon.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPokemon.properties.allValues] mutableCopy];

    for (id jsonName in QTPokemon.properties) {
        id propertyName = QTPokemon.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"egg": [_egg value],
        @"next_evolution": NSNullify(map(_nextEvolution, λ(id x, [x JSONDictionary]))),
        @"prev_evolution": NSNullify(map(_prevEvolution, λ(id x, [x JSONDictionary]))),
        @"type": map(_type, λ(id x, [x value])),
        @"weaknesses": map(_weaknesses, λ(id x, [x value])),
    }];

    return dict;
}
@end

@implementation QTEvolution
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
        @"num": @"num",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEvolution alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"num"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEvolution.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEvolution.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTEvolution.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
