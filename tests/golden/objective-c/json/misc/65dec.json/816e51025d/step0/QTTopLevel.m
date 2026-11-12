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

@interface QTCard (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLegalityElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRuling (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTColorIdentity
+ (NSDictionary<NSString *, QTColorIdentity *> *)values
{
    static NSDictionary<NSString *, QTColorIdentity *> *values;
    return values = values ? values : @{
        @"W": [[QTColorIdentity alloc] initWithValue:@"W"],
        @"R": [[QTColorIdentity alloc] initWithValue:@"R"],
        @"B": [[QTColorIdentity alloc] initWithValue:@"B"],
        @"G": [[QTColorIdentity alloc] initWithValue:@"G"],
        @"U": [[QTColorIdentity alloc] initWithValue:@"U"],
    };
}

+ (QTColorIdentity *)w { return QTColorIdentity.values[@"W"]; }
+ (QTColorIdentity *)r { return QTColorIdentity.values[@"R"]; }
+ (QTColorIdentity *)b { return QTColorIdentity.values[@"B"]; }
+ (QTColorIdentity *)g { return QTColorIdentity.values[@"G"]; }
+ (QTColorIdentity *)u { return QTColorIdentity.values[@"U"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTColorIdentity.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTWatermark
+ (NSDictionary<NSString *, QTWatermark *> *)values
{
    static NSDictionary<NSString *, QTWatermark *> *values;
    return values = values ? values : @{
        @"White": [[QTWatermark alloc] initWithValue:@"White"],
        @"Red": [[QTWatermark alloc] initWithValue:@"Red"],
        @"Black": [[QTWatermark alloc] initWithValue:@"Black"],
        @"Green": [[QTWatermark alloc] initWithValue:@"Green"],
        @"Blue": [[QTWatermark alloc] initWithValue:@"Blue"],
    };
}

+ (QTWatermark *)white { return QTWatermark.values[@"White"]; }
+ (QTWatermark *)red { return QTWatermark.values[@"Red"]; }
+ (QTWatermark *)black { return QTWatermark.values[@"Black"]; }
+ (QTWatermark *)green { return QTWatermark.values[@"Green"]; }
+ (QTWatermark *)blue { return QTWatermark.values[@"Blue"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTWatermark.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLayout
+ (NSDictionary<NSString *, QTLayout *> *)values
{
    static NSDictionary<NSString *, QTLayout *> *values;
    return values = values ? values : @{
        @"normal": [[QTLayout alloc] initWithValue:@"normal"],
    };
}

+ (QTLayout *)normal { return QTLayout.values[@"normal"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLayout.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLegalityEnum
+ (NSDictionary<NSString *, QTLegalityEnum *> *)values
{
    static NSDictionary<NSString *, QTLegalityEnum *> *values;
    return values = values ? values : @{
        @"Legal": [[QTLegalityEnum alloc] initWithValue:@"Legal"],
        @"Banned": [[QTLegalityEnum alloc] initWithValue:@"Banned"],
        @"Restricted": [[QTLegalityEnum alloc] initWithValue:@"Restricted"],
    };
}

+ (QTLegalityEnum *)legal { return QTLegalityEnum.values[@"Legal"]; }
+ (QTLegalityEnum *)banned { return QTLegalityEnum.values[@"Banned"]; }
+ (QTLegalityEnum *)restricted { return QTLegalityEnum.values[@"Restricted"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLegalityEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRarity
+ (NSDictionary<NSString *, QTRarity *> *)values
{
    static NSDictionary<NSString *, QTRarity *> *values;
    return values = values ? values : @{
        @"Uncommon": [[QTRarity alloc] initWithValue:@"Uncommon"],
        @"Rare": [[QTRarity alloc] initWithValue:@"Rare"],
        @"Common": [[QTRarity alloc] initWithValue:@"Common"],
        @"Basic Land": [[QTRarity alloc] initWithValue:@"Basic Land"],
    };
}

+ (QTRarity *)uncommon { return QTRarity.values[@"Uncommon"]; }
+ (QTRarity *)rare { return QTRarity.values[@"Rare"]; }
+ (QTRarity *)common { return QTRarity.values[@"Common"]; }
+ (QTRarity *)basicLand { return QTRarity.values[@"Basic Land"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRarity.values[value];
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
        @"Creature": [[QTType alloc] initWithValue:@"Creature"],
        @"Artifact": [[QTType alloc] initWithValue:@"Artifact"],
        @"Instant": [[QTType alloc] initWithValue:@"Instant"],
        @"Land": [[QTType alloc] initWithValue:@"Land"],
        @"Enchantment": [[QTType alloc] initWithValue:@"Enchantment"],
        @"Sorcery": [[QTType alloc] initWithValue:@"Sorcery"],
    };
}

+ (QTType *)creature { return QTType.values[@"Creature"]; }
+ (QTType *)artifact { return QTType.values[@"Artifact"]; }
+ (QTType *)instant { return QTType.values[@"Instant"]; }
+ (QTType *)land { return QTType.values[@"Land"]; }
+ (QTType *)enchantment { return QTType.values[@"Enchantment"]; }
+ (QTType *)sorcery { return QTType.values[@"Sorcery"]; }

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
        @"booster": @"booster",
        @"border": @"border",
        @"cards": @"cards",
        @"code": @"code",
        @"gathererCode": @"gathererCode",
        @"magicCardsInfoCode": @"magicCardsInfoCode",
        @"mkm_id": @"mkmID",
        @"mkm_name": @"mkmName",
        @"name": @"name",
        @"releaseDate": @"releaseDate",
        @"type": @"type",
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
        if (![dict[@"booster"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"border"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"cards"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"code"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"gathererCode"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"magicCardsInfoCode"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mkm_id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"mkm_id"] doubleValue] != [dict[@"mkm_id"] longLongValue]) return nil;
        if (![dict[@"mkm_name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"releaseDate"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _cards = map(_cards, λ(id x, [QTCard fromJSONDictionary:x]));
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
        @"cards": map(_cards, λ(id x, [x JSONDictionary])),
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

@implementation QTCard
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"artist": @"artist",
        @"cmc": @"cmc",
        @"colorIdentity": @"colorIdentity",
        @"colors": @"colors",
        @"flavor": @"flavor",
        @"id": @"identifier",
        @"imageName": @"imageName",
        @"layout": @"layout",
        @"legalities": @"legalities",
        @"manaCost": @"manaCost",
        @"mciNumber": @"mciNumber",
        @"multiverseid": @"multiverseid",
        @"name": @"name",
        @"originalText": @"originalText",
        @"originalType": @"originalType",
        @"power": @"power",
        @"printings": @"printings",
        @"rarity": @"rarity",
        @"reserved": @"reserved",
        @"rulings": @"rulings",
        @"subtypes": @"subtypes",
        @"supertypes": @"supertypes",
        @"text": @"text",
        @"toughness": @"toughness",
        @"type": @"type",
        @"types": @"types",
        @"variations": @"variations",
        @"watermark": @"watermark",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCard alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"artist"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"cmc"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"cmc"] doubleValue] != [dict[@"cmc"] longLongValue]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"imageName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"layout"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"legalities"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"multiverseid"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"multiverseid"] doubleValue] != [dict[@"multiverseid"] longLongValue]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"originalText"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"originalType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"printings"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"rarity"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"types"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _colorIdentity = map(_colorIdentity, λ(id x, [QTColorIdentity withValue:x]));
        _colors = map(_colors, λ(id x, [QTWatermark withValue:x]));
        _layout = [QTLayout withValue:(id)_layout];
        _legalities = map(_legalities, λ(id x, [QTLegalityElement fromJSONDictionary:x]));
        _rarity = [QTRarity withValue:(id)_rarity];
        _rulings = map(_rulings, λ(id x, [QTRuling fromJSONDictionary:x]));
        _types = map(_types, λ(id x, [QTType withValue:x]));
        _watermark = [QTWatermark withValue:(id)_watermark];
        if (_watermark == nil && dict[@"watermark"] && ![dict[@"watermark"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCard.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCard.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCard.properties.allValues] mutableCopy];

    for (id jsonName in QTCard.properties) {
        id propertyName = QTCard.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"colorIdentity": NSNullify(map(_colorIdentity, λ(id x, [x value]))),
        @"colors": NSNullify(map(_colors, λ(id x, [x value]))),
        @"layout": [_layout value],
        @"legalities": map(_legalities, λ(id x, [x JSONDictionary])),
        @"rarity": [_rarity value],
        @"rulings": NSNullify(map(_rulings, λ(id x, [x JSONDictionary]))),
        @"types": map(_types, λ(id x, [x value])),
        @"watermark": NSNullify([_watermark value]),
    }];

    return dict;
}
@end

@implementation QTLegalityElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"format": @"format",
        @"legality": @"legality",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLegalityElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"format"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"legality"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _legality = [QTLegalityEnum withValue:(id)_legality];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLegalityElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLegalityElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLegalityElement.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"legality": [_legality value],
    }];

    return dict;
}
@end

@implementation QTRuling
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"date": @"date",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRuling alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"text"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRuling.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRuling.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRuling.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
