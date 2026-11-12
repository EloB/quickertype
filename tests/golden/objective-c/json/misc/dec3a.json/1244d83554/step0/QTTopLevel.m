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

@interface QTMetadata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTResponseInfo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTResultset (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTResult (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHiringOrg (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLocation (JSONConversion)
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
        @"metadata": @"metadata",
        @"results": @"results",
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
        if (![dict[@"metadata"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"results"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _metadata = [QTMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
        _results = map(_results, λ(id x, [QTResult fromJSONDictionary:x]));
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
        @"metadata": [_metadata JSONDictionary],
        @"results": map(_results, λ(id x, [x JSONDictionary])),
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

@implementation QTMetadata
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"executionTime": @"executionTime",
        @"responseInfo": @"responseInfo",
        @"resultset": @"resultset",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"executionTime"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"responseInfo"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"resultset"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _responseInfo = [QTResponseInfo fromJSONDictionary:(id)_responseInfo];
        if (!_responseInfo && dict[@"responseInfo"] && ![dict[@"responseInfo"] isKindOfClass:NSNull.class]) return nil;
        _resultset = [QTResultset fromJSONDictionary:(id)_resultset];
        if (!_resultset && dict[@"resultset"] && ![dict[@"resultset"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMetadata.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMetadata.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMetadata.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"responseInfo": [_responseInfo JSONDictionary],
        @"resultset": [_resultset JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTResponseInfo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"developerMessage": @"developerMessage",
        @"status": @"status",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResponseInfo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"developerMessage"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"status"] doubleValue] != [dict[@"status"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTResponseInfo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTResponseInfo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTResponseInfo.properties.allValues];
}
@end

@implementation QTResultset
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"count": @"count",
        @"page": @"page",
        @"pagesize": @"pagesize",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResultset alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"count"] doubleValue] != [dict[@"count"] longLongValue]) return nil;
        if (![dict[@"page"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"page"] doubleValue] != [dict[@"page"] longLongValue]) return nil;
        if (![dict[@"pagesize"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"pagesize"] doubleValue] != [dict[@"pagesize"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTResultset.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTResultset.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTResultset.properties.allValues];
}
@end

@implementation QTResult
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"about_office": @"aboutOffice",
        @"application_process": @"applicationProcess",
        @"body": @"body",
        @"changed": @"changed",
        @"created": @"created",
        @"deadline": @"deadline",
        @"hiring_office": @"hiringOffice",
        @"hiring_org": @"hiringOrg",
        @"job_id": @"jobID",
        @"language": @"language",
        @"location": @"location",
        @"num_positions": @"numPositions",
        @"position": @"position",
        @"practice_area": @"practiceArea",
        @"qualifications": @"qualifications",
        @"relocation_expenses": @"relocationExpenses",
        @"salary": @"salary",
        @"title": @"title",
        @"travel": @"travel",
        @"url": @"url",
        @"uuid": @"uuid",
        @"vuuid": @"vuuid",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResult alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"about_office"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"application_process"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"body"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"changed"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"created"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"deadline"]) return nil;
        if (!dict[@"hiring_office"]) return nil;
        if (![dict[@"hiring_org"] isKindOfClass:NSDictionary.class]) return nil;
        if (!dict[@"job_id"]) return nil;
        if (![dict[@"language"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"location"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"num_positions"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"position"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"practice_area"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"qualifications"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"relocation_expenses"]) return nil;
        if (![dict[@"salary"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"travel"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"uuid"] && ![[NSUUID alloc] initWithUUIDString:dict[@"uuid"]]) return nil;
        if (![dict[@"uuid"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"vuuid"] && ![[NSUUID alloc] initWithUUIDString:dict[@"vuuid"]]) return nil;
        if (![dict[@"vuuid"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _hiringOrg = [QTHiringOrg fromJSONDictionary:(id)_hiringOrg];
        if (!_hiringOrg && dict[@"hiring_org"] && ![dict[@"hiring_org"] isKindOfClass:NSNull.class]) return nil;
        _location = [QTLocation fromJSONDictionary:(id)_location];
        if (!_location && dict[@"location"] && ![dict[@"location"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTResult.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTResult.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTResult.properties.allValues] mutableCopy];

    for (id jsonName in QTResult.properties) {
        id propertyName = QTResult.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"hiring_org": [_hiringOrg JSONDictionary],
        @"location": [_location JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTHiringOrg
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
        @"uuid": @"uuid",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHiringOrg alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"uuid"] && ![[NSUUID alloc] initWithUUIDString:dict[@"uuid"]]) return nil;
        if (![dict[@"uuid"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTHiringOrg.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHiringOrg.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTHiringOrg.properties.allValues];
}
@end

@implementation QTLocation
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"administrative_area": @"administrativeArea",
        @"country": @"country",
        @"fax_number": @"faxNumber",
        @"locality": @"locality",
        @"mobile_number": @"mobileNumber",
        @"phone_number": @"phoneNumber",
        @"phone_number_extension": @"phoneNumberExtension",
        @"postal_code": @"postalCode",
        @"sub_premise": @"subPremise",
        @"thoroughfare": @"thoroughfare",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLocation alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"administrative_area"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"country"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"fax_number"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"locality"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mobile_number"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"phone_number"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"phone_number_extension"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"postal_code"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"sub_premise"]) return nil;
        if (![dict[@"thoroughfare"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLocation.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLocation.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLocation.properties.allValues] mutableCopy];

    for (id jsonName in QTLocation.properties) {
        id propertyName = QTLocation.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

NS_ASSUME_NONNULL_END
