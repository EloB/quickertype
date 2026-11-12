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

@interface QTFacets (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTResult (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTStatus
+ (NSDictionary<NSString *, QTStatus *> *)values
{
    static NSDictionary<NSString *, QTStatus *> *values;
    return values = values ? values : @{
        @"active": [[QTStatus alloc] initWithValue:@"active"],
        @"inactive": [[QTStatus alloc] initWithValue:@"inactive"],
    };
}

+ (QTStatus *)active { return QTStatus.values[@"active"]; }
+ (QTStatus *)inactive { return QTStatus.values[@"inactive"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTStatus.values[value];
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
        @"count": @"count",
        @"facets": @"facets",
        @"previous": @"isPrevious",
        @"limit": @"limit",
        @"next": @"next",
        @"offset": @"offset",
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
        if (![dict[@"count"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"count"] doubleValue] != [dict[@"count"] longLongValue]) return nil;
        if (![dict[@"facets"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"previous"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"limit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"limit"] doubleValue] != [dict[@"limit"] longLongValue]) return nil;
        if (![dict[@"next"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"offset"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"offset"] doubleValue] != [dict[@"offset"] longLongValue]) return nil;
        if (![dict[@"results"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _facets = [QTFacets fromJSONDictionary:(id)_facets];
        if (!_facets && dict[@"facets"] && ![dict[@"facets"] isKindOfClass:NSNull.class]) return nil;
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

    for (id jsonName in QTTopLevel.properties) {
        id propertyName = QTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"facets": [_facets JSONDictionary],
        @"previous": _isPrevious ? @YES : @NO,
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

@implementation QTFacets
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFacets alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTFacets.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFacets.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFacets.properties.allValues];
}
@end

@implementation QTResult
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"acronym": @"acronym",
        @"activity_consult_committees": @"activityConsultCommittees",
        @"activity_eu_legislative": @"activityEuLegislative",
        @"activity_expert_groups": @"activityExpertGroups",
        @"activity_high_level_groups": @"activityHighLevelGroups",
        @"activity_industry_forums": @"activityIndustryForums",
        @"activity_inter_groups": @"activityInterGroups",
        @"activity_other": @"activityOther",
        @"activity_relevant_comm": @"activityRelevantComm",
        @"be_office_country": @"beOfficeCountry",
        @"be_office_lat": @"beOfficeLat",
        @"be_office_lon": @"beOfficeLon",
        @"be_office_phone": @"beOfficePhone",
        @"be_office_post_code": @"beOfficePostCode",
        @"be_office_postbox": @"beOfficePostbox",
        @"be_office_street": @"beOfficeStreet",
        @"be_office_town": @"beOfficeTown",
        @"code_of_conduct": @"codeOfConduct",
        @"contact_country": @"contactCountry",
        @"created_at": @"createdAt",
        @"entity": @"entity",
        @"goals": @"goals",
        @"head": @"head",
        @"head_office_country": @"headOfficeCountry",
        @"head_office_lat": @"headOfficeLat",
        @"head_office_lon": @"headOfficeLon",
        @"head_office_phone": @"headOfficePhone",
        @"head_office_post_code": @"headOfficePostCode",
        @"head_office_postbox": @"headOfficePostbox",
        @"head_office_street": @"headOfficeStreet",
        @"head_office_town": @"headOfficeTown",
        @"identification_code": @"identificationCode",
        @"id": @"identifier",
        @"info_members": @"infoMembers",
        @"last_update_date": @"lastUpdateDate",
        @"legal": @"legal",
        @"legal_status": @"legalStatus",
        @"main_category": @"mainCategory",
        @"main_category_title": @"mainCategoryTitle",
        @"members": @"members",
        @"members_100": @"members100",
        @"members_25": @"members25",
        @"members_50": @"members50",
        @"members_75": @"members75",
        @"members_fte": @"membersFte",
        @"name": @"name",
        @"native_name": @"nativeName",
        @"networking": @"networking",
        @"number_of_natural_persons": @"numberOfNaturalPersons",
        @"other_code_of_conduct": @"otherCodeOfConduct",
        @"registration_date": @"registrationDate",
        @"status": @"status",
        @"structure_members": @"structureMembers",
        @"sub_category": @"subCategory",
        @"sub_category_title": @"subCategoryTitle",
        @"updated_at": @"updatedAt",
        @"uri": @"uri",
        @"web_site_url": @"webSiteURL",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTResult alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"acronym"]) return nil;
        if (![dict[@"activity_consult_committees"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"activity_eu_legislative"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"activity_expert_groups"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"activity_high_level_groups"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"activity_industry_forums"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"activity_inter_groups"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"activity_other"]) return nil;
        if (![dict[@"activity_relevant_comm"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"code_of_conduct"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"contact_country"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"contact_country"] doubleValue] != [dict[@"contact_country"] longLongValue]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"entity"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"goals"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"head"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"head_office_country"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"head_office_lat"]) return nil;
        if (!dict[@"head_office_lon"]) return nil;
        if (![dict[@"head_office_phone"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"head_office_post_code"]) return nil;
        if (!dict[@"head_office_postbox"]) return nil;
        if (![dict[@"head_office_street"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"head_office_town"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"identification_code"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"info_members"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"last_update_date"] && [dict[@"last_update_date"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"last_update_date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"legal"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"legal_status"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"main_category"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"main_category"] doubleValue] != [dict[@"main_category"] longLongValue]) return nil;
        if (![dict[@"main_category_title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"members"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"members"] doubleValue] != [dict[@"members"] longLongValue]) return nil;
        if (!dict[@"members_100"]) return nil;
        if (!dict[@"members_25"]) return nil;
        if (!dict[@"members_50"]) return nil;
        if (!dict[@"members_75"]) return nil;
        if (![dict[@"members_fte"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"native_name"]) return nil;
        if (!dict[@"networking"]) return nil;
        if (!dict[@"number_of_natural_persons"]) return nil;
        if (!dict[@"other_code_of_conduct"]) return nil;
        if (dict[@"registration_date"] && [dict[@"registration_date"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"registration_date"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"structure_members"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sub_category"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sub_category"] doubleValue] != [dict[@"sub_category"] longLongValue]) return nil;
        if (![dict[@"sub_category_title"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"uri"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"web_site_url"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _status = [QTStatus withValue:(id)_status];
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
        @"status": [_status value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
