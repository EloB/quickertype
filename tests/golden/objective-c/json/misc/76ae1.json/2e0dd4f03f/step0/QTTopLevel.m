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

@interface QTDefinitions (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTArticle (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProperty (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDeMinimis (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDeMinimisProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFAQ (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFAQProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTReport (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTReportProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTaxonomy (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTaxonomyProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInfo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPaths (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBusinessServiceProvidersSearchClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBusinessServiceProvidersSearchGet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTParameter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleResponses (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurple200 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTItemsClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConsolidatedScreeningListSearchClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConsolidatedScreeningListSearchGet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyResponses (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffy200 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleSchema (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTFormatEnum
+ (NSDictionary<NSString *, QTFormatEnum *> *)values
{
    static NSDictionary<NSString *, QTFormatEnum *> *values;
    return values = values ? values : @{
        @"string": [[QTFormatEnum alloc] initWithValue:@"string"],
    };
}

+ (QTFormatEnum *)string { return QTFormatEnum.values[@"string"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFormatEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTIn
+ (NSDictionary<NSString *, QTIn *> *)values
{
    static NSDictionary<NSString *, QTIn *> *values;
    return values = values ? values : @{
        @"query": [[QTIn alloc] initWithValue:@"query"],
    };
}

+ (QTIn *)query { return QTIn.values[@"query"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTIn.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSchemaType
+ (NSDictionary<NSString *, QTSchemaType *> *)values
{
    static NSDictionary<NSString *, QTSchemaType *> *values;
    return values = values ? values : @{
        @"array": [[QTSchemaType alloc] initWithValue:@"array"],
    };
}

+ (QTSchemaType *)array { return QTSchemaType.values[@"array"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSchemaType.values[value];
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
        @"basePath": @"basePath",
        @"definitions": @"definitions",
        @"host": @"host",
        @"info": @"info",
        @"paths": @"paths",
        @"produces": @"produces",
        @"schemes": @"schemes",
        @"swagger": @"swagger",
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
        if (![dict[@"basePath"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"definitions"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"host"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"info"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"paths"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"produces"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"schemes"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"swagger"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _definitions = [QTDefinitions fromJSONDictionary:(id)_definitions];
        if (!_definitions && dict[@"definitions"] && ![dict[@"definitions"] isKindOfClass:NSNull.class]) return nil;
        _info = [QTInfo fromJSONDictionary:(id)_info];
        if (!_info && dict[@"info"] && ![dict[@"info"] isKindOfClass:NSNull.class]) return nil;
        _paths = [QTPaths fromJSONDictionary:(id)_paths];
        if (!_paths && dict[@"paths"] && ![dict[@"paths"] isKindOfClass:NSNull.class]) return nil;
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
        @"definitions": [_definitions JSONDictionary],
        @"info": [_info JSONDictionary],
        @"paths": [_paths JSONDictionary],
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

@implementation QTDefinitions
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Article": @"article",
        @"Center": @"center",
        @"DeMinimis": @"deMinimis",
        @"Event": @"event",
        @"FAQ": @"faq",
        @"Lead": @"lead",
        @"List": @"list",
        @"MarketIntelligence": @"marketIntelligence",
        @"Office": @"office",
        @"Provider": @"provider",
        @"Rate": @"rate",
        @"Report": @"report",
        @"Taxonomy": @"taxonomy",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDefinitions alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Article"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Center"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DeMinimis"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Event"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"FAQ"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Lead"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"List"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"MarketIntelligence"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Office"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Provider"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Rate"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Report"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Taxonomy"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _article = [QTArticle fromJSONDictionary:(id)_article];
        if (!_article && dict[@"Article"] && ![dict[@"Article"] isKindOfClass:NSNull.class]) return nil;
        _center = [QTArticle fromJSONDictionary:(id)_center];
        if (!_center && dict[@"Center"] && ![dict[@"Center"] isKindOfClass:NSNull.class]) return nil;
        _deMinimis = [QTDeMinimis fromJSONDictionary:(id)_deMinimis];
        if (!_deMinimis && dict[@"DeMinimis"] && ![dict[@"DeMinimis"] isKindOfClass:NSNull.class]) return nil;
        _event = [QTArticle fromJSONDictionary:(id)_event];
        if (!_event && dict[@"Event"] && ![dict[@"Event"] isKindOfClass:NSNull.class]) return nil;
        _faq = [QTFAQ fromJSONDictionary:(id)_faq];
        if (!_faq && dict[@"FAQ"] && ![dict[@"FAQ"] isKindOfClass:NSNull.class]) return nil;
        _lead = [QTArticle fromJSONDictionary:(id)_lead];
        if (!_lead && dict[@"Lead"] && ![dict[@"Lead"] isKindOfClass:NSNull.class]) return nil;
        _list = [QTArticle fromJSONDictionary:(id)_list];
        if (!_list && dict[@"List"] && ![dict[@"List"] isKindOfClass:NSNull.class]) return nil;
        _marketIntelligence = [QTArticle fromJSONDictionary:(id)_marketIntelligence];
        if (!_marketIntelligence && dict[@"MarketIntelligence"] && ![dict[@"MarketIntelligence"] isKindOfClass:NSNull.class]) return nil;
        _office = [QTArticle fromJSONDictionary:(id)_office];
        if (!_office && dict[@"Office"] && ![dict[@"Office"] isKindOfClass:NSNull.class]) return nil;
        _provider = [QTArticle fromJSONDictionary:(id)_provider];
        if (!_provider && dict[@"Provider"] && ![dict[@"Provider"] isKindOfClass:NSNull.class]) return nil;
        _rate = [QTArticle fromJSONDictionary:(id)_rate];
        if (!_rate && dict[@"Rate"] && ![dict[@"Rate"] isKindOfClass:NSNull.class]) return nil;
        _report = [QTReport fromJSONDictionary:(id)_report];
        if (!_report && dict[@"Report"] && ![dict[@"Report"] isKindOfClass:NSNull.class]) return nil;
        _taxonomy = [QTTaxonomy fromJSONDictionary:(id)_taxonomy];
        if (!_taxonomy && dict[@"Taxonomy"] && ![dict[@"Taxonomy"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDefinitions.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDefinitions.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDefinitions.properties.allValues] mutableCopy];

    for (id jsonName in QTDefinitions.properties) {
        id propertyName = QTDefinitions.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"Article": [_article JSONDictionary],
        @"Center": [_center JSONDictionary],
        @"DeMinimis": [_deMinimis JSONDictionary],
        @"Event": [_event JSONDictionary],
        @"FAQ": [_faq JSONDictionary],
        @"Lead": [_lead JSONDictionary],
        @"List": [_list JSONDictionary],
        @"MarketIntelligence": [_marketIntelligence JSONDictionary],
        @"Office": [_office JSONDictionary],
        @"Provider": [_provider JSONDictionary],
        @"Rate": [_rate JSONDictionary],
        @"Report": [_report JSONDictionary],
        @"Taxonomy": [_taxonomy JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTArticle
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"properties": @"properties",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTArticle alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _properties = map(_properties, λ(id x, [QTProperty fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTArticle.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTArticle.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTArticle.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"properties": map(_properties, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTProperty
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"description": @"theDescription",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProperty alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTFormatEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProperty.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProperty.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTProperty.properties.allValues] mutableCopy];

    for (id jsonName in QTProperty.properties) {
        id propertyName = QTProperty.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTDeMinimis
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"properties": @"properties",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDeMinimis alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _properties = [QTDeMinimisProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDeMinimis.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDeMinimis.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDeMinimis.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"properties": [_properties JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTDeMinimisProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"countries": @"countries",
        @"country": @"country",
        @"de_minimis_currency": @"deMinimisCurrency",
        @"de_minimis_value": @"deMinimisValue",
        @"notes": @"notes",
        @"vat_amount": @"vatAmount",
        @"vat_currency": @"vatCurrency",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDeMinimisProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"countries"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"country"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"de_minimis_currency"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"de_minimis_value"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"notes"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"vat_amount"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"vat_currency"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _countries = [QTProperty fromJSONDictionary:(id)_countries];
        if (!_countries && dict[@"countries"] && ![dict[@"countries"] isKindOfClass:NSNull.class]) return nil;
        _country = [QTProperty fromJSONDictionary:(id)_country];
        if (!_country && dict[@"country"] && ![dict[@"country"] isKindOfClass:NSNull.class]) return nil;
        _deMinimisCurrency = [QTProperty fromJSONDictionary:(id)_deMinimisCurrency];
        if (!_deMinimisCurrency && dict[@"de_minimis_currency"] && ![dict[@"de_minimis_currency"] isKindOfClass:NSNull.class]) return nil;
        _deMinimisValue = [QTProperty fromJSONDictionary:(id)_deMinimisValue];
        if (!_deMinimisValue && dict[@"de_minimis_value"] && ![dict[@"de_minimis_value"] isKindOfClass:NSNull.class]) return nil;
        _notes = [QTProperty fromJSONDictionary:(id)_notes];
        if (!_notes && dict[@"notes"] && ![dict[@"notes"] isKindOfClass:NSNull.class]) return nil;
        _vatAmount = [QTProperty fromJSONDictionary:(id)_vatAmount];
        if (!_vatAmount && dict[@"vat_amount"] && ![dict[@"vat_amount"] isKindOfClass:NSNull.class]) return nil;
        _vatCurrency = [QTProperty fromJSONDictionary:(id)_vatCurrency];
        if (!_vatCurrency && dict[@"vat_currency"] && ![dict[@"vat_currency"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDeMinimisProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDeMinimisProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDeMinimisProperties.properties.allValues] mutableCopy];

    for (id jsonName in QTDeMinimisProperties.properties) {
        id propertyName = QTDeMinimisProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"countries": [_countries JSONDictionary],
        @"country": [_country JSONDictionary],
        @"de_minimis_currency": [_deMinimisCurrency JSONDictionary],
        @"de_minimis_value": [_deMinimisValue JSONDictionary],
        @"notes": [_notes JSONDictionary],
        @"vat_amount": [_vatAmount JSONDictionary],
        @"vat_currency": [_vatCurrency JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFAQ
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"properties": @"properties",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFAQ alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _properties = [QTFAQProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFAQ.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFAQ.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFAQ.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"properties": [_properties JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFAQProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"answer": @"answer",
        @"countries": @"countries",
        @"first_published_date": @"firstPublishedDate",
        @"id": @"identifier",
        @"industries": @"industries",
        @"last_published_date": @"lastPublishedDate",
        @"question": @"question",
        @"topics": @"topics",
        @"trade_regions": @"tradeRegions",
        @"url": @"url",
        @"world_regions": @"worldRegions",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFAQProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"answer"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"countries"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"first_published_date"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"industries"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"last_published_date"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"question"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"topics"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"trade_regions"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"world_regions"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _answer = [QTProperty fromJSONDictionary:(id)_answer];
        if (!_answer && dict[@"answer"] && ![dict[@"answer"] isKindOfClass:NSNull.class]) return nil;
        _countries = [QTProperty fromJSONDictionary:(id)_countries];
        if (!_countries && dict[@"countries"] && ![dict[@"countries"] isKindOfClass:NSNull.class]) return nil;
        _firstPublishedDate = [QTProperty fromJSONDictionary:(id)_firstPublishedDate];
        if (!_firstPublishedDate && dict[@"first_published_date"] && ![dict[@"first_published_date"] isKindOfClass:NSNull.class]) return nil;
        _identifier = [QTProperty fromJSONDictionary:(id)_identifier];
        if (!_identifier && dict[@"id"] && ![dict[@"id"] isKindOfClass:NSNull.class]) return nil;
        _industries = [QTProperty fromJSONDictionary:(id)_industries];
        if (!_industries && dict[@"industries"] && ![dict[@"industries"] isKindOfClass:NSNull.class]) return nil;
        _lastPublishedDate = [QTProperty fromJSONDictionary:(id)_lastPublishedDate];
        if (!_lastPublishedDate && dict[@"last_published_date"] && ![dict[@"last_published_date"] isKindOfClass:NSNull.class]) return nil;
        _question = [QTProperty fromJSONDictionary:(id)_question];
        if (!_question && dict[@"question"] && ![dict[@"question"] isKindOfClass:NSNull.class]) return nil;
        _topics = [QTProperty fromJSONDictionary:(id)_topics];
        if (!_topics && dict[@"topics"] && ![dict[@"topics"] isKindOfClass:NSNull.class]) return nil;
        _tradeRegions = [QTProperty fromJSONDictionary:(id)_tradeRegions];
        if (!_tradeRegions && dict[@"trade_regions"] && ![dict[@"trade_regions"] isKindOfClass:NSNull.class]) return nil;
        _url = [QTProperty fromJSONDictionary:(id)_url];
        if (!_url && dict[@"url"] && ![dict[@"url"] isKindOfClass:NSNull.class]) return nil;
        _worldRegions = [QTProperty fromJSONDictionary:(id)_worldRegions];
        if (!_worldRegions && dict[@"world_regions"] && ![dict[@"world_regions"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFAQProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFAQProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFAQProperties.properties.allValues] mutableCopy];

    for (id jsonName in QTFAQProperties.properties) {
        id propertyName = QTFAQProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"answer": [_answer JSONDictionary],
        @"countries": [_countries JSONDictionary],
        @"first_published_date": [_firstPublishedDate JSONDictionary],
        @"id": [_identifier JSONDictionary],
        @"industries": [_industries JSONDictionary],
        @"last_published_date": [_lastPublishedDate JSONDictionary],
        @"question": [_question JSONDictionary],
        @"topics": [_topics JSONDictionary],
        @"trade_regions": [_tradeRegions JSONDictionary],
        @"url": [_url JSONDictionary],
        @"world_regions": [_worldRegions JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTReport
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"properties": @"properties",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTReport alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _properties = [QTReportProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTReport.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTReport.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTReport.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"properties": [_properties JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTReportProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"countries": @"countries",
        @"expiration_date": @"expirationDate",
        @"id": @"identifier",
        @"industries": @"industries",
        @"ita_industries": @"itaIndustries",
        @"report_type": @"reportType",
        @"description": @"theDescription",
        @"title": @"title",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTReportProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"countries"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"expiration_date"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"industries"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ita_industries"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"report_type"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _countries = [QTProperty fromJSONDictionary:(id)_countries];
        if (!_countries && dict[@"countries"] && ![dict[@"countries"] isKindOfClass:NSNull.class]) return nil;
        _expirationDate = [QTProperty fromJSONDictionary:(id)_expirationDate];
        if (!_expirationDate && dict[@"expiration_date"] && ![dict[@"expiration_date"] isKindOfClass:NSNull.class]) return nil;
        _identifier = [QTProperty fromJSONDictionary:(id)_identifier];
        if (!_identifier && dict[@"id"] && ![dict[@"id"] isKindOfClass:NSNull.class]) return nil;
        _industries = [QTProperty fromJSONDictionary:(id)_industries];
        if (!_industries && dict[@"industries"] && ![dict[@"industries"] isKindOfClass:NSNull.class]) return nil;
        _itaIndustries = [QTProperty fromJSONDictionary:(id)_itaIndustries];
        if (!_itaIndustries && dict[@"ita_industries"] && ![dict[@"ita_industries"] isKindOfClass:NSNull.class]) return nil;
        _reportType = [QTProperty fromJSONDictionary:(id)_reportType];
        if (!_reportType && dict[@"report_type"] && ![dict[@"report_type"] isKindOfClass:NSNull.class]) return nil;
        _theDescription = [QTProperty fromJSONDictionary:(id)_theDescription];
        if (!_theDescription && dict[@"description"] && ![dict[@"description"] isKindOfClass:NSNull.class]) return nil;
        _title = [QTProperty fromJSONDictionary:(id)_title];
        if (!_title && dict[@"title"] && ![dict[@"title"] isKindOfClass:NSNull.class]) return nil;
        _url = [QTProperty fromJSONDictionary:(id)_url];
        if (!_url && dict[@"url"] && ![dict[@"url"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTReportProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTReportProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTReportProperties.properties.allValues] mutableCopy];

    for (id jsonName in QTReportProperties.properties) {
        id propertyName = QTReportProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"countries": [_countries JSONDictionary],
        @"expiration_date": [_expirationDate JSONDictionary],
        @"id": [_identifier JSONDictionary],
        @"industries": [_industries JSONDictionary],
        @"ita_industries": [_itaIndustries JSONDictionary],
        @"report_type": [_reportType JSONDictionary],
        @"description": [_theDescription JSONDictionary],
        @"title": [_title JSONDictionary],
        @"url": [_url JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTTaxonomy
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"properties": @"properties",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTaxonomy alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _properties = [QTTaxonomyProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTaxonomy.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTaxonomy.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTaxonomy.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"properties": [_properties JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTTaxonomyProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"annotations": @"annotations",
        @"datatype_properties": @"datatypeProperties",
        @"id": @"identifier",
        @"label": @"label",
        @"sub_class_of": @"subClassOf",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTaxonomyProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"annotations"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"datatype_properties"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"label"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sub_class_of"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _annotations = [QTProperty fromJSONDictionary:(id)_annotations];
        if (!_annotations && dict[@"annotations"] && ![dict[@"annotations"] isKindOfClass:NSNull.class]) return nil;
        _datatypeProperties = [QTProperty fromJSONDictionary:(id)_datatypeProperties];
        if (!_datatypeProperties && dict[@"datatype_properties"] && ![dict[@"datatype_properties"] isKindOfClass:NSNull.class]) return nil;
        _identifier = [QTProperty fromJSONDictionary:(id)_identifier];
        if (!_identifier && dict[@"id"] && ![dict[@"id"] isKindOfClass:NSNull.class]) return nil;
        _label = [QTProperty fromJSONDictionary:(id)_label];
        if (!_label && dict[@"label"] && ![dict[@"label"] isKindOfClass:NSNull.class]) return nil;
        _subClassOf = [QTProperty fromJSONDictionary:(id)_subClassOf];
        if (!_subClassOf && dict[@"sub_class_of"] && ![dict[@"sub_class_of"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTProperty fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTaxonomyProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTaxonomyProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTaxonomyProperties.properties.allValues] mutableCopy];

    for (id jsonName in QTTaxonomyProperties.properties) {
        id propertyName = QTTaxonomyProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"annotations": [_annotations JSONDictionary],
        @"datatype_properties": [_datatypeProperties JSONDictionary],
        @"id": [_identifier JSONDictionary],
        @"label": [_label JSONDictionary],
        @"sub_class_of": [_subClassOf JSONDictionary],
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTInfo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"description": @"theDescription",
        @"title": @"title",
        @"version": @"version",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInfo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"version"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInfo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInfo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTInfo.properties.allValues] mutableCopy];

    for (id jsonName in QTInfo.properties) {
        id propertyName = QTInfo.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPaths
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"/business_service_providers/search": @"businessServiceProvidersSearch",
        @"/consolidated_screening_list/search": @"consolidatedScreeningListSearch",
        @"/de_minimis/search": @"deMinimisSearch",
        @"/ita_faqs/search": @"itaFaqsSearch",
        @"/ita_office_locations/search": @"itaOfficeLocationsSearch",
        @"/ita_taxonomies/search": @"itaTaxonomiesSearch",
        @"/ita_zipcode_to_post/search": @"itaZipcodeToPostSearch",
        @"/market_intelligence/search": @"marketIntelligenceSearch",
        @"/market_research_library/search": @"marketResearchLibrarySearch",
        @"/tariff_rates/search": @"tariffRatesSearch",
        @"/trade_articles/search": @"tradeArticlesSearch",
        @"/trade_events/search": @"tradeEventsSearch",
        @"/trade_leads/search": @"tradeLeadsSearch",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPaths alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"/business_service_providers/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/consolidated_screening_list/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/de_minimis/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/ita_faqs/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/ita_office_locations/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/ita_taxonomies/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/ita_zipcode_to_post/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/market_intelligence/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/market_research_library/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/tariff_rates/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/trade_articles/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/trade_events/search"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"/trade_leads/search"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _businessServiceProvidersSearch = [QTBusinessServiceProvidersSearchClass fromJSONDictionary:(id)_businessServiceProvidersSearch];
        if (!_businessServiceProvidersSearch && dict[@"/business_service_providers/search"] && ![dict[@"/business_service_providers/search"] isKindOfClass:NSNull.class]) return nil;
        _consolidatedScreeningListSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_consolidatedScreeningListSearch];
        if (!_consolidatedScreeningListSearch && dict[@"/consolidated_screening_list/search"] && ![dict[@"/consolidated_screening_list/search"] isKindOfClass:NSNull.class]) return nil;
        _deMinimisSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_deMinimisSearch];
        if (!_deMinimisSearch && dict[@"/de_minimis/search"] && ![dict[@"/de_minimis/search"] isKindOfClass:NSNull.class]) return nil;
        _itaFaqsSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_itaFaqsSearch];
        if (!_itaFaqsSearch && dict[@"/ita_faqs/search"] && ![dict[@"/ita_faqs/search"] isKindOfClass:NSNull.class]) return nil;
        _itaOfficeLocationsSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_itaOfficeLocationsSearch];
        if (!_itaOfficeLocationsSearch && dict[@"/ita_office_locations/search"] && ![dict[@"/ita_office_locations/search"] isKindOfClass:NSNull.class]) return nil;
        _itaTaxonomiesSearch = [QTBusinessServiceProvidersSearchClass fromJSONDictionary:(id)_itaTaxonomiesSearch];
        if (!_itaTaxonomiesSearch && dict[@"/ita_taxonomies/search"] && ![dict[@"/ita_taxonomies/search"] isKindOfClass:NSNull.class]) return nil;
        _itaZipcodeToPostSearch = [QTBusinessServiceProvidersSearchClass fromJSONDictionary:(id)_itaZipcodeToPostSearch];
        if (!_itaZipcodeToPostSearch && dict[@"/ita_zipcode_to_post/search"] && ![dict[@"/ita_zipcode_to_post/search"] isKindOfClass:NSNull.class]) return nil;
        _marketIntelligenceSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_marketIntelligenceSearch];
        if (!_marketIntelligenceSearch && dict[@"/market_intelligence/search"] && ![dict[@"/market_intelligence/search"] isKindOfClass:NSNull.class]) return nil;
        _marketResearchLibrarySearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_marketResearchLibrarySearch];
        if (!_marketResearchLibrarySearch && dict[@"/market_research_library/search"] && ![dict[@"/market_research_library/search"] isKindOfClass:NSNull.class]) return nil;
        _tariffRatesSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_tariffRatesSearch];
        if (!_tariffRatesSearch && dict[@"/tariff_rates/search"] && ![dict[@"/tariff_rates/search"] isKindOfClass:NSNull.class]) return nil;
        _tradeArticlesSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_tradeArticlesSearch];
        if (!_tradeArticlesSearch && dict[@"/trade_articles/search"] && ![dict[@"/trade_articles/search"] isKindOfClass:NSNull.class]) return nil;
        _tradeEventsSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_tradeEventsSearch];
        if (!_tradeEventsSearch && dict[@"/trade_events/search"] && ![dict[@"/trade_events/search"] isKindOfClass:NSNull.class]) return nil;
        _tradeLeadsSearch = [QTConsolidatedScreeningListSearchClass fromJSONDictionary:(id)_tradeLeadsSearch];
        if (!_tradeLeadsSearch && dict[@"/trade_leads/search"] && ![dict[@"/trade_leads/search"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPaths.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPaths.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPaths.properties.allValues] mutableCopy];

    for (id jsonName in QTPaths.properties) {
        id propertyName = QTPaths.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"/business_service_providers/search": [_businessServiceProvidersSearch JSONDictionary],
        @"/consolidated_screening_list/search": [_consolidatedScreeningListSearch JSONDictionary],
        @"/de_minimis/search": [_deMinimisSearch JSONDictionary],
        @"/ita_faqs/search": [_itaFaqsSearch JSONDictionary],
        @"/ita_office_locations/search": [_itaOfficeLocationsSearch JSONDictionary],
        @"/ita_taxonomies/search": [_itaTaxonomiesSearch JSONDictionary],
        @"/ita_zipcode_to_post/search": [_itaZipcodeToPostSearch JSONDictionary],
        @"/market_intelligence/search": [_marketIntelligenceSearch JSONDictionary],
        @"/market_research_library/search": [_marketResearchLibrarySearch JSONDictionary],
        @"/tariff_rates/search": [_tariffRatesSearch JSONDictionary],
        @"/trade_articles/search": [_tradeArticlesSearch JSONDictionary],
        @"/trade_events/search": [_tradeEventsSearch JSONDictionary],
        @"/trade_leads/search": [_tradeLeadsSearch JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTBusinessServiceProvidersSearchClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"get": @"get",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBusinessServiceProvidersSearchClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"get"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _get = [QTBusinessServiceProvidersSearchGet fromJSONDictionary:(id)_get];
        if (!_get && dict[@"get"] && ![dict[@"get"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBusinessServiceProvidersSearchClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBusinessServiceProvidersSearchClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBusinessServiceProvidersSearchClass.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"get": [_get JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTBusinessServiceProvidersSearchGet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"parameters": @"parameters",
        @"responses": @"responses",
        @"summary": @"summary",
        @"tags": @"tags",
        @"description": @"theDescription",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBusinessServiceProvidersSearchGet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"parameters"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"responses"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"summary"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tags"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _parameters = map(_parameters, λ(id x, [QTParameter fromJSONDictionary:x]));
        _responses = [QTPurpleResponses fromJSONDictionary:(id)_responses];
        if (!_responses && dict[@"responses"] && ![dict[@"responses"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBusinessServiceProvidersSearchGet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBusinessServiceProvidersSearchGet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBusinessServiceProvidersSearchGet.properties.allValues] mutableCopy];

    for (id jsonName in QTBusinessServiceProvidersSearchGet.properties) {
        id propertyName = QTBusinessServiceProvidersSearchGet.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"parameters": map(_parameters, λ(id x, [x JSONDictionary])),
        @"responses": [_responses JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTParameter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"format": @"format",
        @"in": @"in",
        @"required": @"isRequired",
        @"name": @"name",
        @"description": @"theDescription",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTParameter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"format"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"in"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"required"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _format = [QTFormatEnum withValue:(id)_format];
        _in = [QTIn withValue:(id)_in];
        _type = [QTFormatEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTParameter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTParameter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTParameter.properties.allValues] mutableCopy];

    for (id jsonName in QTParameter.properties) {
        id propertyName = QTParameter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"format": [_format value],
        @"in": [_in value],
        @"required": _isRequired ? @YES : @NO,
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTPurpleResponses
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"200": @"the200",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleResponses alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"200"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _the200 = [QTPurple200 fromJSONDictionary:(id)_the200];
        if (!_the200 && dict[@"200"] && ![dict[@"200"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleResponses.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleResponses.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleResponses.properties.allValues] mutableCopy];

    for (id jsonName in QTPurpleResponses.properties) {
        id propertyName = QTPurpleResponses.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"200": [_the200 JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTPurple200
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"schema": @"schema",
        @"description": @"theDescription",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurple200 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"schema"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _schema = [QTItemsClass fromJSONDictionary:(id)_schema];
        if (!_schema && dict[@"schema"] && ![dict[@"schema"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurple200.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurple200.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurple200.properties.allValues] mutableCopy];

    for (id jsonName in QTPurple200.properties) {
        id propertyName = QTPurple200.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"schema": [_schema JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTItemsClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"$ref": @"ref",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTItemsClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"$ref"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTItemsClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTItemsClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTItemsClass.properties.allValues] mutableCopy];

    for (id jsonName in QTItemsClass.properties) {
        id propertyName = QTItemsClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTConsolidatedScreeningListSearchClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"get": @"get",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConsolidatedScreeningListSearchClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"get"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _get = [QTConsolidatedScreeningListSearchGet fromJSONDictionary:(id)_get];
        if (!_get && dict[@"get"] && ![dict[@"get"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConsolidatedScreeningListSearchClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConsolidatedScreeningListSearchClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConsolidatedScreeningListSearchClass.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"get": [_get JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTConsolidatedScreeningListSearchGet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"parameters": @"parameters",
        @"responses": @"responses",
        @"summary": @"summary",
        @"tags": @"tags",
        @"description": @"theDescription",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConsolidatedScreeningListSearchGet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"parameters"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"responses"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"summary"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tags"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _parameters = map(_parameters, λ(id x, [QTParameter fromJSONDictionary:x]));
        _responses = [QTFluffyResponses fromJSONDictionary:(id)_responses];
        if (!_responses && dict[@"responses"] && ![dict[@"responses"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConsolidatedScreeningListSearchGet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConsolidatedScreeningListSearchGet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConsolidatedScreeningListSearchGet.properties.allValues] mutableCopy];

    for (id jsonName in QTConsolidatedScreeningListSearchGet.properties) {
        id propertyName = QTConsolidatedScreeningListSearchGet.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"parameters": map(_parameters, λ(id x, [x JSONDictionary])),
        @"responses": [_responses JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFluffyResponses
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"200": @"the200",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyResponses alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"200"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _the200 = [QTFluffy200 fromJSONDictionary:(id)_the200];
        if (!_the200 && dict[@"200"] && ![dict[@"200"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyResponses.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyResponses.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyResponses.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffyResponses.properties) {
        id propertyName = QTFluffyResponses.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"200": [_the200 JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFluffy200
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"schema": @"schema",
        @"description": @"theDescription",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffy200 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"schema"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _schema = [QTPurpleSchema fromJSONDictionary:(id)_schema];
        if (!_schema && dict[@"schema"] && ![dict[@"schema"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffy200.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffy200.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffy200.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffy200.properties) {
        id propertyName = QTFluffy200.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"schema": [_schema JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTPurpleSchema
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"items": @"items",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleSchema alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"items"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _items = [QTItemsClass fromJSONDictionary:(id)_items];
        if (!_items && dict[@"items"] && ![dict[@"items"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTSchemaType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleSchema.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleSchema.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleSchema.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"items": [_items JSONDictionary],
        @"type": [_type value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
