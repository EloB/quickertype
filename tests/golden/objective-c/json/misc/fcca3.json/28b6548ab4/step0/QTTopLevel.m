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

@interface QTView (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTColumn (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCachedContents (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTop (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFormat (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGrant (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTViewMetadata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAttachment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCustomFields (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCommonCore (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDatasetInformation (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDatasetSummary (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDisclaimers (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFilterCondition (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChildMetadata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTableColumnID (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFilterConditionMetadata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONQuery (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOrder (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRenderTypeConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVisible (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOwner (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTQuery (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOrderBy (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExpression (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTTypeName
+ (NSDictionary<NSString *, QTTypeName *> *)values
{
    static NSDictionary<NSString *, QTTypeName *> *values;
    return values = values ? values : @{
        @"meta_data": [[QTTypeName alloc] initWithValue:@"meta_data"],
        @"number": [[QTTypeName alloc] initWithValue:@"number"],
        @"text": [[QTTypeName alloc] initWithValue:@"text"],
    };
}

+ (QTTypeName *)metaData { return QTTypeName.values[@"meta_data"]; }
+ (QTTypeName *)number { return QTTypeName.values[@"number"]; }
+ (QTTypeName *)text { return QTTypeName.values[@"text"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTypeName.values[value];
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
        @"data": @"data",
        @"meta": @"meta",
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
        if (![dict[@"data"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"meta"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _meta = [QTMeta fromJSONDictionary:(id)_meta];
        if (!_meta && dict[@"meta"] && ![dict[@"meta"] isKindOfClass:NSNull.class]) return nil;
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
        @"view": @"view",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMeta alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"view"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _view = [QTView fromJSONDictionary:(id)_view];
        if (!_view && dict[@"view"] && ![dict[@"view"] isKindOfClass:NSNull.class]) return nil;
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

    [dict addEntriesFromDictionary:@{
        @"view": [_view JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTView
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"attribution": @"attribution",
        @"averageRating": @"averageRating",
        @"category": @"category",
        @"columns": @"columns",
        @"createdAt": @"createdAt",
        @"displayType": @"displayType",
        @"downloadCount": @"downloadCount",
        @"flags": @"flags",
        @"grants": @"grants",
        @"id": @"identifier",
        @"indexUpdatedAt": @"indexUpdatedAt",
        @"hideFromCatalog": @"isHideFromCatalog",
        @"hideFromDataJson": @"isHideFromDataJSON",
        @"newBackend": @"isNewBackend",
        @"publicationAppendEnabled": @"isPublicationAppendEnabled",
        @"locale": @"locale",
        @"metadata": @"metadata",
        @"name": @"name",
        @"numberOfComments": @"numberOfComments",
        @"oid": @"oid",
        @"owner": @"owner",
        @"provenance": @"provenance",
        @"publicationDate": @"publicationDate",
        @"publicationGroup": @"publicationGroup",
        @"publicationStage": @"publicationStage",
        @"query": @"query",
        @"rights": @"rights",
        @"rowsUpdatedAt": @"rowsUpdatedAt",
        @"rowsUpdatedBy": @"rowsUpdatedBy",
        @"tableAuthor": @"tableAuthor",
        @"tableId": @"tableID",
        @"tags": @"tags",
        @"description": @"theDescription",
        @"totalTimesRated": @"totalTimesRated",
        @"viewCount": @"viewCount",
        @"viewLastModified": @"viewLastModified",
        @"viewType": @"viewType",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTView alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"attribution"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"averageRating"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"averageRating"] doubleValue] != [dict[@"averageRating"] longLongValue]) return nil;
        if (![dict[@"category"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"columns"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"createdAt"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"createdAt"] doubleValue] != [dict[@"createdAt"] longLongValue]) return nil;
        if (![dict[@"displayType"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"downloadCount"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"downloadCount"] doubleValue] != [dict[@"downloadCount"] longLongValue]) return nil;
        if (![dict[@"flags"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"grants"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"indexUpdatedAt"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"indexUpdatedAt"] doubleValue] != [dict[@"indexUpdatedAt"] longLongValue]) return nil;
        if (![dict[@"hideFromCatalog"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"hideFromDataJson"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"newBackend"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"publicationAppendEnabled"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"locale"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"metadata"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"numberOfComments"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"numberOfComments"] doubleValue] != [dict[@"numberOfComments"] longLongValue]) return nil;
        if (![dict[@"oid"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"oid"] doubleValue] != [dict[@"oid"] longLongValue]) return nil;
        if (![dict[@"owner"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"provenance"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"publicationDate"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"publicationDate"] doubleValue] != [dict[@"publicationDate"] longLongValue]) return nil;
        if (![dict[@"publicationGroup"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"publicationGroup"] doubleValue] != [dict[@"publicationGroup"] longLongValue]) return nil;
        if (![dict[@"publicationStage"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"query"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"rights"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"rowsUpdatedAt"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"rowsUpdatedAt"] doubleValue] != [dict[@"rowsUpdatedAt"] longLongValue]) return nil;
        if (![dict[@"rowsUpdatedBy"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tableAuthor"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"tableId"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tableId"] doubleValue] != [dict[@"tableId"] longLongValue]) return nil;
        if (![dict[@"tags"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"description"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"totalTimesRated"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalTimesRated"] doubleValue] != [dict[@"totalTimesRated"] longLongValue]) return nil;
        if (![dict[@"viewCount"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"viewCount"] doubleValue] != [dict[@"viewCount"] longLongValue]) return nil;
        if (![dict[@"viewLastModified"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"viewLastModified"] doubleValue] != [dict[@"viewLastModified"] longLongValue]) return nil;
        if (![dict[@"viewType"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _columns = map(_columns, λ(id x, [QTColumn fromJSONDictionary:x]));
        _grants = map(_grants, λ(id x, [QTGrant fromJSONDictionary:x]));
        _metadata = [QTViewMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
        _owner = [QTOwner fromJSONDictionary:(id)_owner];
        if (!_owner && dict[@"owner"] && ![dict[@"owner"] isKindOfClass:NSNull.class]) return nil;
        _query = [QTQuery fromJSONDictionary:(id)_query];
        if (!_query && dict[@"query"] && ![dict[@"query"] isKindOfClass:NSNull.class]) return nil;
        _tableAuthor = [QTOwner fromJSONDictionary:(id)_tableAuthor];
        if (!_tableAuthor && dict[@"tableAuthor"] && ![dict[@"tableAuthor"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTView.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTView.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTView.properties.allValues] mutableCopy];

    for (id jsonName in QTView.properties) {
        id propertyName = QTView.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"columns": map(_columns, λ(id x, [x JSONDictionary])),
        @"grants": map(_grants, λ(id x, [x JSONDictionary])),
        @"hideFromCatalog": _isHideFromCatalog ? @YES : @NO,
        @"hideFromDataJson": _isHideFromDataJSON ? @YES : @NO,
        @"newBackend": _isNewBackend ? @YES : @NO,
        @"publicationAppendEnabled": _isPublicationAppendEnabled ? @YES : @NO,
        @"metadata": [_metadata JSONDictionary],
        @"owner": [_owner JSONDictionary],
        @"query": [_query JSONDictionary],
        @"tableAuthor": [_tableAuthor JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTColumn
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"cachedContents": @"cachedContents",
        @"dataTypeName": @"dataTypeName",
        @"fieldName": @"fieldName",
        @"flags": @"flags",
        @"format": @"format",
        @"id": @"identifier",
        @"name": @"name",
        @"position": @"position",
        @"renderTypeName": @"renderTypeName",
        @"tableColumnId": @"tableColumnID",
        @"description": @"theDescription",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTColumn alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dataTypeName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"fieldName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"format"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"position"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"position"] doubleValue] != [dict[@"position"] longLongValue]) return nil;
        if (![dict[@"renderTypeName"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _cachedContents = [QTCachedContents fromJSONDictionary:(id)_cachedContents];
        if (!_cachedContents && dict[@"cachedContents"] && ![dict[@"cachedContents"] isKindOfClass:NSNull.class]) return nil;
        _dataTypeName = [QTTypeName withValue:(id)_dataTypeName];
        _format = [QTFormat fromJSONDictionary:(id)_format];
        if (!_format && dict[@"format"] && ![dict[@"format"] isKindOfClass:NSNull.class]) return nil;
        _renderTypeName = [QTTypeName withValue:(id)_renderTypeName];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTColumn.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTColumn.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTColumn.properties.allValues] mutableCopy];

    for (id jsonName in QTColumn.properties) {
        id propertyName = QTColumn.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"cachedContents": NSNullify([_cachedContents isKindOfClass:NSNull.class] ? nil : [_cachedContents JSONDictionary]),
        @"dataTypeName": [_dataTypeName value],
        @"format": [_format JSONDictionary],
        @"renderTypeName": [_renderTypeName value],
    }];

    return dict;
}
@end

@implementation QTCachedContents
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"average": @"average",
        @"largest": @"largest",
        @"non_null": @"nonNull",
        @"null": @"null",
        @"smallest": @"smallest",
        @"sum": @"sum",
        @"top": @"top",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCachedContents alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"largest"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"non_null"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"non_null"] doubleValue] != [dict[@"non_null"] longLongValue]) return nil;
        if (![dict[@"null"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"null"] doubleValue] != [dict[@"null"] longLongValue]) return nil;
        if (![dict[@"smallest"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"top"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _top = map(_top, λ(id x, [QTTop fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCachedContents.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCachedContents.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCachedContents.properties.allValues] mutableCopy];

    for (id jsonName in QTCachedContents.properties) {
        id propertyName = QTCachedContents.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"top": map(_top, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTTop
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"count": @"count",
        @"item": @"item",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTop alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"count"] doubleValue] != [dict[@"count"] longLongValue]) return nil;
        if (![dict[@"item"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTop.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTop.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTop.properties.allValues];
}
@end

@implementation QTFormat
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"align": @"align",
        @"noCommas": @"noCommas",
        @"precisionStyle": @"precisionStyle",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFormat alloc] initWithJSONDictionary:dict] : nil;
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
    return [self dictionaryWithValuesForKeys:QTFormat.properties.allValues];
}
@end

@implementation QTGrant
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"flags": @"flags",
        @"inherited": @"isInherited",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGrant alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"inherited"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGrant.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGrant.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGrant.properties.allValues] mutableCopy];

    for (id jsonName in QTGrant.properties) {
        id propertyName = QTGrant.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"inherited": _isInherited ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTViewMetadata
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"attachments": @"attachments",
        @"availableDisplayTypes": @"availableDisplayTypes",
        @"custom_fields": @"customFields",
        @"filterCondition": @"filterCondition",
        @"jsonQuery": @"jsonQuery",
        @"rdfSubject": @"rdfSubject",
        @"renderTypeConfig": @"renderTypeConfig",
        @"rowLabel": @"rowLabel",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTViewMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"attachments"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"availableDisplayTypes"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"custom_fields"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"filterCondition"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"jsonQuery"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"rdfSubject"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"renderTypeConfig"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"rowLabel"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _attachments = map(_attachments, λ(id x, [QTAttachment fromJSONDictionary:x]));
        _customFields = [QTCustomFields fromJSONDictionary:(id)_customFields];
        if (!_customFields && dict[@"custom_fields"] && ![dict[@"custom_fields"] isKindOfClass:NSNull.class]) return nil;
        _filterCondition = [QTFilterCondition fromJSONDictionary:(id)_filterCondition];
        if (!_filterCondition && dict[@"filterCondition"] && ![dict[@"filterCondition"] isKindOfClass:NSNull.class]) return nil;
        _jsonQuery = [QTJSONQuery fromJSONDictionary:(id)_jsonQuery];
        if (!_jsonQuery && dict[@"jsonQuery"] && ![dict[@"jsonQuery"] isKindOfClass:NSNull.class]) return nil;
        _renderTypeConfig = [QTRenderTypeConfig fromJSONDictionary:(id)_renderTypeConfig];
        if (!_renderTypeConfig && dict[@"renderTypeConfig"] && ![dict[@"renderTypeConfig"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTViewMetadata.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTViewMetadata.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTViewMetadata.properties.allValues] mutableCopy];

    for (id jsonName in QTViewMetadata.properties) {
        id propertyName = QTViewMetadata.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"attachments": map(_attachments, λ(id x, [x JSONDictionary])),
        @"custom_fields": [_customFields JSONDictionary],
        @"filterCondition": [_filterCondition JSONDictionary],
        @"jsonQuery": [_jsonQuery JSONDictionary],
        @"renderTypeConfig": [_renderTypeConfig JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTAttachment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"assetId": @"assetID",
        @"blobId": @"blobID",
        @"filename": @"filename",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAttachment alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"assetId"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"blobId"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"filename"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAttachment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAttachment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAttachment.properties.allValues] mutableCopy];

    for (id jsonName in QTAttachment.properties) {
        id propertyName = QTAttachment.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCustomFields
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Common Core": @"commonCore",
        @"Dataset Information": @"datasetInformation",
        @"Dataset Summary": @"datasetSummary",
        @"Disclaimers": @"disclaimers",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCustomFields alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Common Core"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Dataset Information"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Dataset Summary"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Disclaimers"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _commonCore = [QTCommonCore fromJSONDictionary:(id)_commonCore];
        if (!_commonCore && dict[@"Common Core"] && ![dict[@"Common Core"] isKindOfClass:NSNull.class]) return nil;
        _datasetInformation = [QTDatasetInformation fromJSONDictionary:(id)_datasetInformation];
        if (!_datasetInformation && dict[@"Dataset Information"] && ![dict[@"Dataset Information"] isKindOfClass:NSNull.class]) return nil;
        _datasetSummary = [QTDatasetSummary fromJSONDictionary:(id)_datasetSummary];
        if (!_datasetSummary && dict[@"Dataset Summary"] && ![dict[@"Dataset Summary"] isKindOfClass:NSNull.class]) return nil;
        _disclaimers = [QTDisclaimers fromJSONDictionary:(id)_disclaimers];
        if (!_disclaimers && dict[@"Disclaimers"] && ![dict[@"Disclaimers"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCustomFields.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCustomFields.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCustomFields.properties.allValues] mutableCopy];

    for (id jsonName in QTCustomFields.properties) {
        id propertyName = QTCustomFields.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"Common Core": [_commonCore JSONDictionary],
        @"Dataset Information": [_datasetInformation JSONDictionary],
        @"Dataset Summary": [_datasetSummary JSONDictionary],
        @"Disclaimers": [_disclaimers JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCommonCore
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Contact Email": @"contactEmail",
        @"Contact Name": @"contactName",
        @"Publisher": @"publisher",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCommonCore alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Contact Email"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Contact Name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Publisher"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCommonCore.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCommonCore.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCommonCore.properties.allValues] mutableCopy];

    for (id jsonName in QTCommonCore.properties) {
        id propertyName = QTCommonCore.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDatasetInformation
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Agency": @"agency",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDatasetInformation alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Agency"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDatasetInformation.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDatasetInformation.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDatasetInformation.properties.allValues] mutableCopy];

    for (id jsonName in QTDatasetInformation.properties) {
        id propertyName = QTDatasetInformation.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDatasetSummary
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Contact Information": @"contactInformation",
        @"Coverage": @"coverage",
        @"Granularity": @"granularity",
        @"Organization": @"organization",
        @"Posting Frequency": @"postingFrequency",
        @"Time Period": @"timePeriod",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDatasetSummary alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Contact Information"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Coverage"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Granularity"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Organization"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Posting Frequency"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Time Period"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDatasetSummary.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDatasetSummary.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDatasetSummary.properties.allValues] mutableCopy];

    for (id jsonName in QTDatasetSummary.properties) {
        id propertyName = QTDatasetSummary.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDisclaimers
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Disclaimer": @"disclaimer",
        @"Limitations": @"limitations",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDisclaimers alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Disclaimer"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"Limitations"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDisclaimers.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDisclaimers.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDisclaimers.properties.allValues] mutableCopy];

    for (id jsonName in QTDisclaimers.properties) {
        id propertyName = QTDisclaimers.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFilterCondition
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"metadata": @"metadata",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFilterCondition alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"children"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"metadata"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"value"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTChild fromJSONDictionary:x]));
        _metadata = [QTFilterConditionMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFilterCondition.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFilterCondition.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFilterCondition.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"children": map(_children, λ(id x, [x JSONDictionary])),
        @"metadata": [_metadata JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"metadata": @"metadata",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"metadata"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"value"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _metadata = [QTChildMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChild.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"metadata": [_metadata JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTChildMetadata
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"customValues": @"customValues",
        @"operator": @"operator",
        @"tableColumnId": @"tableColumnID",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChildMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"customValues"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"operator"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tableColumnId"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _tableColumnID = [QTTableColumnID fromJSONDictionary:(id)_tableColumnID];
        if (!_tableColumnID && dict[@"tableColumnId"] && ![dict[@"tableColumnId"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChildMetadata.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChildMetadata.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChildMetadata.properties.allValues] mutableCopy];

    for (id jsonName in QTChildMetadata.properties) {
        id propertyName = QTChildMetadata.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"tableColumnId": [_tableColumnID JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTTableColumnID
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"703610": @"the703610",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTableColumnID alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"703610"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"703610"] doubleValue] != [dict[@"703610"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTableColumnID.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTableColumnID.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTableColumnID.properties.allValues] mutableCopy];

    for (id jsonName in QTTableColumnID.properties) {
        id propertyName = QTTableColumnID.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFilterConditionMetadata
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"advanced": @"isAdvanced",
        @"unifiedVersion": @"unifiedVersion",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFilterConditionMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"advanced"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"unifiedVersion"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"unifiedVersion"] doubleValue] != [dict[@"unifiedVersion"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFilterConditionMetadata.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFilterConditionMetadata.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFilterConditionMetadata.properties.allValues] mutableCopy];

    for (id jsonName in QTFilterConditionMetadata.properties) {
        id propertyName = QTFilterConditionMetadata.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"advanced": _isAdvanced ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTJSONQuery
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"order": @"order",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONQuery alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"order"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _order = map(_order, λ(id x, [QTOrder fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONQuery.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONQuery.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONQuery.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"order": map(_order, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTOrder
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"columnFieldName": @"columnFieldName",
        @"ascending": @"isAscending",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOrder alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"columnFieldName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"ascending"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOrder.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOrder.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOrder.properties.allValues] mutableCopy];

    for (id jsonName in QTOrder.properties) {
        id propertyName = QTOrder.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"ascending": _isAscending ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTRenderTypeConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"visible": @"visible",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRenderTypeConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"visible"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _visible = [QTVisible fromJSONDictionary:(id)_visible];
        if (!_visible && dict[@"visible"] && ![dict[@"visible"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRenderTypeConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRenderTypeConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRenderTypeConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"visible": [_visible JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTVisible
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"table": @"isTable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVisible alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"table"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVisible.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVisible.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVisible.properties.allValues] mutableCopy];

    for (id jsonName in QTVisible.properties) {
        id propertyName = QTVisible.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"table": _isTable ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTOwner
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"displayName": @"displayName",
        @"id": @"identifier",
        @"profileImageUrlLarge": @"profileImageURLLarge",
        @"profileImageUrlMedium": @"profileImageURLMedium",
        @"profileImageUrlSmall": @"profileImageURLSmall",
        @"rights": @"rights",
        @"roleName": @"roleName",
        @"screenName": @"screenName",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOwner alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"displayName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"profileImageUrlLarge"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"profileImageUrlMedium"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"profileImageUrlSmall"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"rights"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"roleName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"screenName"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOwner.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOwner.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOwner.properties.allValues] mutableCopy];

    for (id jsonName in QTOwner.properties) {
        id propertyName = QTOwner.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTQuery
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"orderBys": @"orderBys",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTQuery alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"orderBys"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _orderBys = map(_orderBys, λ(id x, [QTOrderBy fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTQuery.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTQuery.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTQuery.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"orderBys": map(_orderBys, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTOrderBy
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"expression": @"expression",
        @"ascending": @"isAscending",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOrderBy alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"expression"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ascending"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _expression = [QTExpression fromJSONDictionary:(id)_expression];
        if (!_expression && dict[@"expression"] && ![dict[@"expression"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOrderBy.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOrderBy.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOrderBy.properties.allValues] mutableCopy];

    for (id jsonName in QTOrderBy.properties) {
        id propertyName = QTOrderBy.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"expression": [_expression JSONDictionary],
        @"ascending": _isAscending ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTExpression
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"columnId": @"columnID",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExpression alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"columnId"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"columnId"] doubleValue] != [dict[@"columnId"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExpression.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExpression.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTExpression.properties.allValues] mutableCopy];

    for (id jsonName in QTExpression.properties) {
        id propertyName = QTExpression.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
