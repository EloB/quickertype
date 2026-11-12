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

@interface QTMeta (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObject (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExtra (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPerson (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTParty
+ (NSDictionary<NSString *, QTParty *> *)values
{
    static NSDictionary<NSString *, QTParty *> *values;
    return values = values ? values : @{
        @"Republican": [[QTParty alloc] initWithValue:@"Republican"],
        @"Democrat": [[QTParty alloc] initWithValue:@"Democrat"],
        @"Independent": [[QTParty alloc] initWithValue:@"Independent"],
    };
}

+ (QTParty *)republican { return QTParty.values[@"Republican"]; }
+ (QTParty *)democrat { return QTParty.values[@"Democrat"]; }
+ (QTParty *)independent { return QTParty.values[@"Independent"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTParty.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTGender
+ (NSDictionary<NSString *, QTGender *> *)values
{
    static NSDictionary<NSString *, QTGender *> *values;
    return values = values ? values : @{
        @"male": [[QTGender alloc] initWithValue:@"male"],
        @"female": [[QTGender alloc] initWithValue:@"female"],
    };
}

+ (QTGender *)male { return QTGender.values[@"male"]; }
+ (QTGender *)female { return QTGender.values[@"female"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGender.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTGenderLabel
+ (NSDictionary<NSString *, QTGenderLabel *> *)values
{
    static NSDictionary<NSString *, QTGenderLabel *> *values;
    return values = values ? values : @{
        @"Male": [[QTGenderLabel alloc] initWithValue:@"Male"],
        @"Female": [[QTGenderLabel alloc] initWithValue:@"Female"],
    };
}

+ (QTGenderLabel *)male { return QTGenderLabel.values[@"Male"]; }
+ (QTGenderLabel *)female { return QTGenderLabel.values[@"Female"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGenderLabel.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTNamemod
+ (NSDictionary<NSString *, QTNamemod *> *)values
{
    static NSDictionary<NSString *, QTNamemod *> *values;
    return values = values ? values : @{
        @"": [[QTNamemod alloc] initWithValue:@""],
        @"III": [[QTNamemod alloc] initWithValue:@"III"],
        @"Jr.": [[QTNamemod alloc] initWithValue:@"Jr."],
    };
}

+ (QTNamemod *)empty { return QTNamemod.values[@""]; }
+ (QTNamemod *)iii { return QTNamemod.values[@"III"]; }
+ (QTNamemod *)jr { return QTNamemod.values[@"Jr."]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTNamemod.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRoleType
+ (NSDictionary<NSString *, QTRoleType *> *)values
{
    static NSDictionary<NSString *, QTRoleType *> *values;
    return values = values ? values : @{
        @"senator": [[QTRoleType alloc] initWithValue:@"senator"],
    };
}

+ (QTRoleType *)senator { return QTRoleType.values[@"senator"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRoleType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRoleTypeLabel
+ (NSDictionary<NSString *, QTRoleTypeLabel *> *)values
{
    static NSDictionary<NSString *, QTRoleTypeLabel *> *values;
    return values = values ? values : @{
        @"Senator": [[QTRoleTypeLabel alloc] initWithValue:@"Senator"],
    };
}

+ (QTRoleTypeLabel *)senator { return QTRoleTypeLabel.values[@"Senator"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRoleTypeLabel.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSenatorClass
+ (NSDictionary<NSString *, QTSenatorClass *> *)values
{
    static NSDictionary<NSString *, QTSenatorClass *> *values;
    return values = values ? values : @{
        @"class2": [[QTSenatorClass alloc] initWithValue:@"class2"],
        @"class1": [[QTSenatorClass alloc] initWithValue:@"class1"],
        @"class3": [[QTSenatorClass alloc] initWithValue:@"class3"],
    };
}

+ (QTSenatorClass *)class2 { return QTSenatorClass.values[@"class2"]; }
+ (QTSenatorClass *)class1 { return QTSenatorClass.values[@"class1"]; }
+ (QTSenatorClass *)class3 { return QTSenatorClass.values[@"class3"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSenatorClass.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSenatorClassLabel
+ (NSDictionary<NSString *, QTSenatorClassLabel *> *)values
{
    static NSDictionary<NSString *, QTSenatorClassLabel *> *values;
    return values = values ? values : @{
        @"Class 2": [[QTSenatorClassLabel alloc] initWithValue:@"Class 2"],
        @"Class 1": [[QTSenatorClassLabel alloc] initWithValue:@"Class 1"],
        @"Class 3": [[QTSenatorClassLabel alloc] initWithValue:@"Class 3"],
    };
}

+ (QTSenatorClassLabel *)class2 { return QTSenatorClassLabel.values[@"Class 2"]; }
+ (QTSenatorClassLabel *)class1 { return QTSenatorClassLabel.values[@"Class 1"]; }
+ (QTSenatorClassLabel *)class3 { return QTSenatorClassLabel.values[@"Class 3"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSenatorClassLabel.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSenatorRank
+ (NSDictionary<NSString *, QTSenatorRank *> *)values
{
    static NSDictionary<NSString *, QTSenatorRank *> *values;
    return values = values ? values : @{
        @"senior": [[QTSenatorRank alloc] initWithValue:@"senior"],
        @"junior": [[QTSenatorRank alloc] initWithValue:@"junior"],
    };
}

+ (QTSenatorRank *)senior { return QTSenatorRank.values[@"senior"]; }
+ (QTSenatorRank *)junior { return QTSenatorRank.values[@"junior"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSenatorRank.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSenatorRankLabel
+ (NSDictionary<NSString *, QTSenatorRankLabel *> *)values
{
    static NSDictionary<NSString *, QTSenatorRankLabel *> *values;
    return values = values ? values : @{
        @"Senior": [[QTSenatorRankLabel alloc] initWithValue:@"Senior"],
        @"Junior": [[QTSenatorRankLabel alloc] initWithValue:@"Junior"],
    };
}

+ (QTSenatorRankLabel *)senior { return QTSenatorRankLabel.values[@"Senior"]; }
+ (QTSenatorRankLabel *)junior { return QTSenatorRankLabel.values[@"Junior"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSenatorRankLabel.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTTitle
+ (NSDictionary<NSString *, QTTitle *> *)values
{
    static NSDictionary<NSString *, QTTitle *> *values;
    return values = values ? values : @{
        @"Sen.": [[QTTitle alloc] initWithValue:@"Sen."],
    };
}

+ (QTTitle *)sen { return QTTitle.values[@"Sen."]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTitle.values[value];
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
        @"meta": @"meta",
        @"objects": @"objects",
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
        if (![dict[@"meta"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"objects"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _meta = [QTMeta fromJSONDictionary:(id)_meta];
        if (!_meta && dict[@"meta"] && ![dict[@"meta"] isKindOfClass:NSNull.class]) return nil;
        _objects = map(_objects, λ(id x, [QTObject fromJSONDictionary:x]));
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
        @"meta": [_meta JSONDictionary],
        @"objects": map(_objects, λ(id x, [x JSONDictionary])),
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

@implementation QTMeta
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"limit": @"limit",
        @"offset": @"offset",
        @"total_count": @"totalCount",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMeta alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"limit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"limit"] doubleValue] != [dict[@"limit"] longLongValue]) return nil;
        if (![dict[@"offset"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"offset"] doubleValue] != [dict[@"offset"] longLongValue]) return nil;
        if (![dict[@"total_count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"total_count"] doubleValue] != [dict[@"total_count"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMeta.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMeta.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMeta.properties.allValues] mutableCopy];

    for (id jsonName in QTMeta.properties) {
        id propertyName = QTMeta.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObject
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"caucus": @"caucus",
        @"congress_numbers": @"congressNumbers",
        @"district": @"district",
        @"enddate": @"enddate",
        @"extra": @"extra",
        @"id": @"identifier",
        @"current": @"isCurrent",
        @"leadership_title": @"leadershipTitle",
        @"party": @"party",
        @"person": @"person",
        @"phone": @"phone",
        @"role_type": @"roleType",
        @"role_type_label": @"roleTypeLabel",
        @"senator_class": @"senatorClass",
        @"senator_class_label": @"senatorClassLabel",
        @"senator_rank": @"senatorRank",
        @"senator_rank_label": @"senatorRankLabel",
        @"startdate": @"startdate",
        @"state": @"state",
        @"description": @"theDescription",
        @"title": @"title",
        @"title_long": @"titleLong",
        @"website": @"website",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObject alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"caucus"]) return nil;
        if (![dict[@"congress_numbers"] isKindOfClass:NSArray.class]) return nil;
        if (!dict[@"district"]) return nil;
        if (![dict[@"enddate"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"extra"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"current"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"leadership_title"]) return nil;
        if (![dict[@"party"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"person"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"phone"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"role_type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"role_type_label"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"senator_class"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"senator_class_label"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"senator_rank"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"senator_rank_label"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"startdate"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"state"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title_long"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"website"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _caucus = [QTParty withValue:(id)_caucus];
        if (_caucus == nil && dict[@"caucus"] && ![dict[@"caucus"] isKindOfClass:NSNull.class]) return nil;
        _extra = [QTExtra fromJSONDictionary:(id)_extra];
        if (!_extra && dict[@"extra"] && ![dict[@"extra"] isKindOfClass:NSNull.class]) return nil;
        _party = [QTParty withValue:(id)_party];
        _person = [QTPerson fromJSONDictionary:(id)_person];
        if (!_person && dict[@"person"] && ![dict[@"person"] isKindOfClass:NSNull.class]) return nil;
        _roleType = [QTRoleType withValue:(id)_roleType];
        _roleTypeLabel = [QTRoleTypeLabel withValue:(id)_roleTypeLabel];
        _senatorClass = [QTSenatorClass withValue:(id)_senatorClass];
        _senatorClassLabel = [QTSenatorClassLabel withValue:(id)_senatorClassLabel];
        _senatorRank = [QTSenatorRank withValue:(id)_senatorRank];
        _senatorRankLabel = [QTSenatorRankLabel withValue:(id)_senatorRankLabel];
        _title = [QTTitle withValue:(id)_title];
        _titleLong = [QTRoleTypeLabel withValue:(id)_titleLong];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObject.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObject.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObject.properties.allValues] mutableCopy];

    for (id jsonName in QTObject.properties) {
        id propertyName = QTObject.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"caucus": NSNullify([_caucus value]),
        @"extra": [_extra JSONDictionary],
        @"current": _isCurrent ? @YES : @NO,
        @"party": [_party value],
        @"person": [_person JSONDictionary],
        @"role_type": [_roleType value],
        @"role_type_label": [_roleTypeLabel value],
        @"senator_class": [_senatorClass value],
        @"senator_class_label": [_senatorClassLabel value],
        @"senator_rank": [_senatorRank value],
        @"senator_rank_label": [_senatorRankLabel value],
        @"title": [_title value],
        @"title_long": [_titleLong value],
    }];

    return dict;
}
@end

@implementation QTExtra
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"address": @"address",
        @"contact_form": @"contactForm",
        @"fax": @"fax",
        @"office": @"office",
        @"rss_url": @"rssURL",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExtra alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"address"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"contact_form"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"office"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExtra.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExtra.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTExtra.properties.allValues] mutableCopy];

    for (id jsonName in QTExtra.properties) {
        id propertyName = QTExtra.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPerson
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bioguideid": @"bioguideid",
        @"birthday": @"birthday",
        @"cspanid": @"cspanid",
        @"firstname": @"firstname",
        @"gender": @"gender",
        @"gender_label": @"genderLabel",
        @"id": @"identifier",
        @"lastname": @"lastname",
        @"link": @"link",
        @"middlename": @"middlename",
        @"name": @"name",
        @"namemod": @"namemod",
        @"nickname": @"nickname",
        @"osid": @"osid",
        @"pvsid": @"pvsid",
        @"sortname": @"sortname",
        @"twitterid": @"twitterid",
        @"youtubeid": @"youtubeid",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPerson alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"bioguideid"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"birthday"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"cspanid"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"cspanid"] doubleValue] != [dict[@"cspanid"] longLongValue]) return nil;
        if (![dict[@"firstname"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"gender"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"gender_label"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"lastname"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"link"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"middlename"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"namemod"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"nickname"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"osid"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"pvsid"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sortname"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"twitterid"]) return nil;
        if (!dict[@"youtubeid"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _gender = [QTGender withValue:(id)_gender];
        _genderLabel = [QTGenderLabel withValue:(id)_genderLabel];
        _namemod = [QTNamemod withValue:(id)_namemod];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPerson.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPerson.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPerson.properties.allValues] mutableCopy];

    for (id jsonName in QTPerson.properties) {
        id propertyName = QTPerson.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"gender": [_gender value],
        @"gender_label": [_genderLabel value],
        @"namemod": [_namemod value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
