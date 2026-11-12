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

@interface QTCategory (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLinkElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLinkLink (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCategoryThumbnail (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDetails (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEonandyear (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTXmlschematype (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProductElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProductProduct (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCurrency (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRating (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUseraveragerating (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSpecification (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFormat (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFormatsClass (JSONConversion)
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
        @"category": @"category",
        @"details": @"details",
        @"schk": @"isSchk",
        @"match": @"match",
        @"page": @"page",
        @"product": @"product",
        @"totallooseoffers": @"totallooseoffers",
        @"totalpages": @"totalpages",
        @"totalresultsavailable": @"totalresultsavailable",
        @"totalresultsreturned": @"totalresultsreturned",
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
        if (![dict[@"category"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"details"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"schk"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"match"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"page"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"page"] doubleValue] != [dict[@"page"] longLongValue]) return nil;
        if (![dict[@"product"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"totallooseoffers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totallooseoffers"] doubleValue] != [dict[@"totallooseoffers"] longLongValue]) return nil;
        if (![dict[@"totalpages"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalpages"] doubleValue] != [dict[@"totalpages"] longLongValue]) return nil;
        if (![dict[@"totalresultsavailable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalresultsavailable"] doubleValue] != [dict[@"totalresultsavailable"] longLongValue]) return nil;
        if (![dict[@"totalresultsreturned"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalresultsreturned"] doubleValue] != [dict[@"totalresultsreturned"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _category = [QTCategory fromJSONDictionary:(id)_category];
        if (!_category && dict[@"category"] && ![dict[@"category"] isKindOfClass:NSNull.class]) return nil;
        _details = [QTDetails fromJSONDictionary:(id)_details];
        if (!_details && dict[@"details"] && ![dict[@"details"] isKindOfClass:NSNull.class]) return nil;
        _product = map(_product, λ(id x, [QTProductElement fromJSONDictionary:x]));
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
        @"category": [_category JSONDictionary],
        @"details": [_details JSONDictionary],
        @"schk": _isSchk ? @YES : @NO,
        @"product": map(_product, λ(id x, [x JSONDictionary])),
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

@implementation QTCategory
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"concatenatecategoryname": @"isConcatenatecategoryname",
        @"hasoffer": @"isHasoffer",
        @"isfinal": @"isIsfinal",
        @"links": @"links",
        @"name": @"name",
        @"parentcategoryid": @"parentcategoryid",
        @"thumbnail": @"thumbnail",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCategory alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"concatenatecategoryname"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"hasoffer"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"isfinal"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"links"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"parentcategoryid"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"parentcategoryid"] doubleValue] != [dict[@"parentcategoryid"] longLongValue]) return nil;
        if (![dict[@"thumbnail"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _links = map(_links, λ(id x, [QTLinkElement fromJSONDictionary:x]));
        _thumbnail = [QTCategoryThumbnail fromJSONDictionary:(id)_thumbnail];
        if (!_thumbnail && dict[@"thumbnail"] && ![dict[@"thumbnail"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCategory.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCategory.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCategory.properties.allValues] mutableCopy];

    for (id jsonName in QTCategory.properties) {
        id propertyName = QTCategory.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"concatenatecategoryname": _isConcatenatecategoryname ? @YES : @NO,
        @"hasoffer": _isHasoffer ? @YES : @NO,
        @"isfinal": _isIsfinal ? @YES : @NO,
        @"links": map(_links, λ(id x, [x JSONDictionary])),
        @"thumbnail": [_thumbnail JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTLinkElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"link": @"link",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLinkElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"link"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _link = [QTLinkLink fromJSONDictionary:(id)_link];
        if (!_link && dict[@"link"] && ![dict[@"link"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLinkElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLinkElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLinkElement.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"link": [_link JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTLinkLink
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"type": @"type",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLinkLink alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLinkLink.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLinkLink.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTLinkLink.properties.allValues];
}
@end

@implementation QTCategoryThumbnail
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCategoryThumbnail alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCategoryThumbnail.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCategoryThumbnail.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCategoryThumbnail.properties.allValues];
}
@end

@implementation QTDetails
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"applicationid": @"applicationid",
        @"applicationversion": @"applicationversion",
        @"code": @"code",
        @"date": @"date",
        @"elapsedtime": @"elapsedtime",
        @"message": @"message",
        @"status": @"status",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDetails alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"applicationid"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"applicationversion"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"code"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"code"] doubleValue] != [dict[@"code"] longLongValue]) return nil;
        if (![dict[@"date"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"elapsedtime"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"elapsedtime"] doubleValue] != [dict[@"elapsedtime"] longLongValue]) return nil;
        if (![dict[@"message"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _date = [QTDate fromJSONDictionary:(id)_date];
        if (!_date && dict[@"date"] && ![dict[@"date"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDetails.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDetails.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDetails.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"date": [_date JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTDate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"day": @"day",
        @"eonandyear": @"eonandyear",
        @"hour": @"hour",
        @"valid": @"isValid",
        @"millisecond": @"millisecond",
        @"minute": @"minute",
        @"month": @"month",
        @"second": @"second",
        @"timezone": @"timezone",
        @"xmlschematype": @"xmlschematype",
        @"year": @"year",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"day"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"day"] doubleValue] != [dict[@"day"] longLongValue]) return nil;
        if (![dict[@"eonandyear"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"hour"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"hour"] doubleValue] != [dict[@"hour"] longLongValue]) return nil;
        if (![dict[@"valid"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"millisecond"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"millisecond"] doubleValue] != [dict[@"millisecond"] longLongValue]) return nil;
        if (![dict[@"minute"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"minute"] doubleValue] != [dict[@"minute"] longLongValue]) return nil;
        if (![dict[@"month"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"month"] doubleValue] != [dict[@"month"] longLongValue]) return nil;
        if (![dict[@"second"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"second"] doubleValue] != [dict[@"second"] longLongValue]) return nil;
        if (![dict[@"timezone"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"timezone"] doubleValue] != [dict[@"timezone"] longLongValue]) return nil;
        if (![dict[@"xmlschematype"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"year"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"year"] doubleValue] != [dict[@"year"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _eonandyear = [QTEonandyear fromJSONDictionary:(id)_eonandyear];
        if (!_eonandyear && dict[@"eonandyear"] && ![dict[@"eonandyear"] isKindOfClass:NSNull.class]) return nil;
        _xmlschematype = [QTXmlschematype fromJSONDictionary:(id)_xmlschematype];
        if (!_xmlschematype && dict[@"xmlschematype"] && ![dict[@"xmlschematype"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDate.properties.allValues] mutableCopy];

    for (id jsonName in QTDate.properties) {
        id propertyName = QTDate.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"eonandyear": [_eonandyear JSONDictionary],
        @"valid": _isValid ? @YES : @NO,
        @"xmlschematype": [_xmlschematype JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTEonandyear
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"lowestsetbit": @"lowestsetbit",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEonandyear alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"lowestsetbit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"lowestsetbit"] doubleValue] != [dict[@"lowestsetbit"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEonandyear.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEonandyear.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTEonandyear.properties.allValues];
}
@end

@implementation QTXmlschematype
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"localpart": @"localpart",
        @"namespaceuri": @"namespaceuri",
        @"prefix": @"prefix",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTXmlschematype alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"localpart"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"namespaceuri"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"prefix"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTXmlschematype.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTXmlschematype.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTXmlschematype.properties.allValues];
}
@end

@implementation QTProductElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"product": @"product",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProductElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"product"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _product = [QTProductProduct fromJSONDictionary:(id)_product];
        if (!_product && dict[@"product"] && ![dict[@"product"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProductElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProductElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTProductElement.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"product": [_product JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTProductProduct
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"categoryid": @"categoryid",
        @"currency": @"currency",
        @"id": @"identifier",
        @"eco": @"isEco",
        @"fulldescription": @"isFulldescription",
        @"hasmetasearch": @"isHasmetasearch",
        @"links": @"links",
        @"numoffers": @"numoffers",
        @"pricemax": @"pricemax",
        @"pricemin": @"pricemin",
        @"productname": @"productname",
        @"quantity": @"quantity",
        @"rating": @"rating",
        @"specification": @"specification",
        @"thumbnail": @"thumbnail",
        @"totalsellers": @"totalsellers",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProductProduct alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"categoryid"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"categoryid"] doubleValue] != [dict[@"categoryid"] longLongValue]) return nil;
        if (![dict[@"currency"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"eco"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"fulldescription"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"hasmetasearch"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"links"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"numoffers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"numoffers"] doubleValue] != [dict[@"numoffers"] longLongValue]) return nil;
        if (![dict[@"pricemax"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"pricemin"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"productname"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"quantity"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"quantity"] doubleValue] != [dict[@"quantity"] longLongValue]) return nil;
        if (![dict[@"rating"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"specification"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"thumbnail"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"totalsellers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalsellers"] doubleValue] != [dict[@"totalsellers"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _currency = [QTCurrency fromJSONDictionary:(id)_currency];
        if (!_currency && dict[@"currency"] && ![dict[@"currency"] isKindOfClass:NSNull.class]) return nil;
        _links = map(_links, λ(id x, [QTLinkElement fromJSONDictionary:x]));
        _rating = [QTRating fromJSONDictionary:(id)_rating];
        if (!_rating && dict[@"rating"] && ![dict[@"rating"] isKindOfClass:NSNull.class]) return nil;
        _specification = [QTSpecification fromJSONDictionary:(id)_specification];
        if (!_specification && dict[@"specification"] && ![dict[@"specification"] isKindOfClass:NSNull.class]) return nil;
        _thumbnail = [QTFormatsClass fromJSONDictionary:(id)_thumbnail];
        if (!_thumbnail && dict[@"thumbnail"] && ![dict[@"thumbnail"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProductProduct.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProductProduct.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTProductProduct.properties.allValues] mutableCopy];

    for (id jsonName in QTProductProduct.properties) {
        id propertyName = QTProductProduct.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"currency": [_currency JSONDictionary],
        @"eco": _isEco ? @YES : @NO,
        @"fulldescription": _isFulldescription ? @YES : @NO,
        @"hasmetasearch": _isHasmetasearch ? @YES : @NO,
        @"links": map(_links, λ(id x, [x JSONDictionary])),
        @"rating": [_rating JSONDictionary],
        @"specification": [_specification JSONDictionary],
        @"thumbnail": [_thumbnail JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCurrency
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"abbreviation": @"abbreviation",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCurrency alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"abbreviation"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCurrency.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCurrency.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCurrency.properties.allValues];
}
@end

@implementation QTRating
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"useraveragerating": @"useraveragerating",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRating alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"useraveragerating"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _useraveragerating = [QTUseraveragerating fromJSONDictionary:(id)_useraveragerating];
        if (!_useraveragerating && dict[@"useraveragerating"] && ![dict[@"useraveragerating"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRating.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRating.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRating.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"useraveragerating": [_useraveragerating JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTUseraveragerating
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"links": @"links",
        @"numcomments": @"numcomments",
        @"rating": @"rating",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUseraveragerating alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"links"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"numcomments"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"numcomments"] doubleValue] != [dict[@"numcomments"] longLongValue]) return nil;
        if (![dict[@"rating"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _links = map(_links, λ(id x, [QTLinkElement fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUseraveragerating.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUseraveragerating.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUseraveragerating.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"links": map(_links, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTSpecification
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"links": @"links",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSpecification alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"links"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _links = map(_links, λ(id x, [QTLinkElement fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSpecification.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSpecification.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSpecification.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"links": map(_links, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTFormat
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"formats": @"formats",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFormat alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"formats"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _formats = [QTFormatsClass fromJSONDictionary:(id)_formats];
        if (!_formats && dict[@"formats"] && ![dict[@"formats"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFormat.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFormat.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFormat.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"formats": [_formats JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFormatsClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"formats": @"formats",
        @"height": @"height",
        @"url": @"url",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFormatsClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"height"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"height"] doubleValue] != [dict[@"height"] longLongValue]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"width"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"width"] doubleValue] != [dict[@"width"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _formats = map(_formats, λ(id x, [QTFormat fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFormatsClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFormatsClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFormatsClass.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"formats": NSNullify(map(_formats, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
