#import "QTTopLevel.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTTopLevelElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGrant (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTopLevelMetadata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCustomFields (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTest (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONQuery (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGroup (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOrder (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSelect (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWhere (JSONConversion)
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

@interface QTMetadataRenderTypeConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleVisible (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRichRendererConfigs (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFatRow (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTColumn (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRow (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTField (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStyles (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTV1ArchivedProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAccessPoints (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTV1ArchivedPropertiesRenderTypeConfig (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyVisible (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOwner (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRatings (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTableAuthor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTDisplayType
+ (NSDictionary<NSString *, QTDisplayType *> *)values
{
    static NSDictionary<NSString *, QTDisplayType *> *values;
    return values = values ? values : @{
        @"table": [[QTDisplayType alloc] initWithValue:@"table"],
        @"data_lens": [[QTDisplayType alloc] initWithValue:@"data_lens"],
        @"fatrow": [[QTDisplayType alloc] initWithValue:@"fatrow"],
        @"page": [[QTDisplayType alloc] initWithValue:@"page"],
    };
}

+ (QTDisplayType *)table { return QTDisplayType.values[@"table"]; }
+ (QTDisplayType *)dataLens { return QTDisplayType.values[@"data_lens"]; }
+ (QTDisplayType *)fatrow { return QTDisplayType.values[@"fatrow"]; }
+ (QTDisplayType *)page { return QTDisplayType.values[@"page"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTDisplayType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTTopLevelFlag
+ (NSDictionary<NSString *, QTTopLevelFlag *> *)values
{
    static NSDictionary<NSString *, QTTopLevelFlag *> *values;
    return values = values ? values : @{
        @"default": [[QTTopLevelFlag alloc] initWithValue:@"default"],
        @"restorable": [[QTTopLevelFlag alloc] initWithValue:@"restorable"],
        @"restorePossibleForType": [[QTTopLevelFlag alloc] initWithValue:@"restorePossibleForType"],
    };
}

+ (QTTopLevelFlag *)flagDefault { return QTTopLevelFlag.values[@"default"]; }
+ (QTTopLevelFlag *)restorable { return QTTopLevelFlag.values[@"restorable"]; }
+ (QTTopLevelFlag *)restorePossibleForType { return QTTopLevelFlag.values[@"restorePossibleForType"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTopLevelFlag.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTGrantFlag
+ (NSDictionary<NSString *, QTGrantFlag *> *)values
{
    static NSDictionary<NSString *, QTGrantFlag *> *values;
    return values = values ? values : @{
        @"public": [[QTGrantFlag alloc] initWithValue:@"public"],
    };
}

+ (QTGrantFlag *)public { return QTGrantFlag.values[@"public"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGrantFlag.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTGrantType
+ (NSDictionary<NSString *, QTGrantType *> *)values
{
    static NSDictionary<NSString *, QTGrantType *> *values;
    return values = values ? values : @{
        @"viewer": [[QTGrantType alloc] initWithValue:@"viewer"],
    };
}

+ (QTGrantType *)viewer { return QTGrantType.values[@"viewer"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGrantType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTOrderColumnFieldName
+ (NSDictionary<NSString *, QTOrderColumnFieldName *> *)values
{
    static NSDictionary<NSString *, QTOrderColumnFieldName *> *values;
    return values = values ? values : @{
        @"date_received": [[QTOrderColumnFieldName alloc] initWithValue:@"date_received"],
        @"agreement_date": [[QTOrderColumnFieldName alloc] initWithValue:@"agreement_date"],
        @"in_effect_as_of_1_1_2012": [[QTOrderColumnFieldName alloc] initWithValue:@"in_effect_as_of_1_1_2012"],
    };
}

+ (QTOrderColumnFieldName *)dateReceived { return QTOrderColumnFieldName.values[@"date_received"]; }
+ (QTOrderColumnFieldName *)agreementDate { return QTOrderColumnFieldName.values[@"agreement_date"]; }
+ (QTOrderColumnFieldName *)inEffectAsOf1_1_2012 { return QTOrderColumnFieldName.values[@"in_effect_as_of_1_1_2012"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTOrderColumnFieldName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTChildColumnFieldName
+ (NSDictionary<NSString *, QTChildColumnFieldName *> *)values
{
    static NSDictionary<NSString *, QTChildColumnFieldName *> *values;
    return values = values ? values : @{
        @"product": [[QTChildColumnFieldName alloc] initWithValue:@"product"],
        @"complaint_what_happened": [[QTChildColumnFieldName alloc] initWithValue:@"complaint_what_happened"],
        @"sub_product": [[QTChildColumnFieldName alloc] initWithValue:@"sub_product"],
        @"issue": [[QTChildColumnFieldName alloc] initWithValue:@"issue"],
    };
}

+ (QTChildColumnFieldName *)product { return QTChildColumnFieldName.values[@"product"]; }
+ (QTChildColumnFieldName *)complaintWhatHappened { return QTChildColumnFieldName.values[@"complaint_what_happened"]; }
+ (QTChildColumnFieldName *)subProduct { return QTChildColumnFieldName.values[@"sub_product"]; }
+ (QTChildColumnFieldName *)issue { return QTChildColumnFieldName.values[@"issue"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTChildColumnFieldName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMetadataOperator
+ (NSDictionary<NSString *, QTMetadataOperator *> *)values
{
    static NSDictionary<NSString *, QTMetadataOperator *> *values;
    return values = values ? values : @{
        @"EQUALS": [[QTMetadataOperator alloc] initWithValue:@"EQUALS"],
        @"blank?": [[QTMetadataOperator alloc] initWithValue:@"blank?"],
    };
}

+ (QTMetadataOperator *)equals { return QTMetadataOperator.values[@"EQUALS"]; }
+ (QTMetadataOperator *)blank { return QTMetadataOperator.values[@"blank?"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMetadataOperator.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTChildOperator
+ (NSDictionary<NSString *, QTChildOperator *> *)values
{
    static NSDictionary<NSString *, QTChildOperator *> *values;
    return values = values ? values : @{
        @"EQUALS": [[QTChildOperator alloc] initWithValue:@"EQUALS"],
        @"IS_NOT_BLANK": [[QTChildOperator alloc] initWithValue:@"IS_NOT_BLANK"],
    };
}

+ (QTChildOperator *)equals { return QTChildOperator.values[@"EQUALS"]; }
+ (QTChildOperator *)isNotBlank { return QTChildOperator.values[@"IS_NOT_BLANK"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTChildOperator.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTWhereOperator
+ (NSDictionary<NSString *, QTWhereOperator *> *)values
{
    static NSDictionary<NSString *, QTWhereOperator *> *values;
    return values = values ? values : @{
        @"EQUALS": [[QTWhereOperator alloc] initWithValue:@"EQUALS"],
        @"AND": [[QTWhereOperator alloc] initWithValue:@"AND"],
    };
}

+ (QTWhereOperator *)equals { return QTWhereOperator.values[@"EQUALS"]; }
+ (QTWhereOperator *)and { return QTWhereOperator.values[@"AND"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTWhereOperator.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFieldType
+ (NSDictionary<NSString *, QTFieldType *> *)values
{
    static NSDictionary<NSString *, QTFieldType *> *values;
    return values = values ? values : @{
        @"columnLabel": [[QTFieldType alloc] initWithValue:@"columnLabel"],
        @"columnData": [[QTFieldType alloc] initWithValue:@"columnData"],
    };
}

+ (QTFieldType *)columnLabel { return QTFieldType.values[@"columnLabel"]; }
+ (QTFieldType *)columnData { return QTFieldType.values[@"columnData"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFieldType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTWidth
+ (NSDictionary<NSString *, QTWidth *> *)values
{
    static NSDictionary<NSString *, QTWidth *> *values;
    return values = values ? values : @{
        @"27%": [[QTWidth alloc] initWithValue:@"27%"],
        @"40%": [[QTWidth alloc] initWithValue:@"40%"],
        @"30%": [[QTWidth alloc] initWithValue:@"30%"],
        @"33%": [[QTWidth alloc] initWithValue:@"33%"],
    };
}

+ (QTWidth *)the27 { return QTWidth.values[@"27%"]; }
+ (QTWidth *)the40 { return QTWidth.values[@"40%"]; }
+ (QTWidth *)the30 { return QTWidth.values[@"30%"]; }
+ (QTWidth *)the33 { return QTWidth.values[@"33%"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTWidth.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTModifyingViewUid
+ (NSDictionary<NSString *, QTModifyingViewUid *> *)values
{
    static NSDictionary<NSString *, QTModifyingViewUid *> *values;
    return values = values ? values : @{
        @"s6ew-h6mp": [[QTModifyingViewUid alloc] initWithValue:@"s6ew-h6mp"],
    };
}

+ (QTModifyingViewUid *)s6EwH6Mp { return QTModifyingViewUid.values[@"s6ew-h6mp"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTModifyingViewUid.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRoleName
+ (NSDictionary<NSString *, QTRoleName *> *)values
{
    static NSDictionary<NSString *, QTRoleName *> *values;
    return values = values ? values : @{
        @"administrator": [[QTRoleName alloc] initWithValue:@"administrator"],
        @"publisher": [[QTRoleName alloc] initWithValue:@"publisher"],
    };
}

+ (QTRoleName *)administrator { return QTRoleName.values[@"administrator"]; }
+ (QTRoleName *)publisher { return QTRoleName.values[@"publisher"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRoleName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTProvenance
+ (NSDictionary<NSString *, QTProvenance *> *)values
{
    static NSDictionary<NSString *, QTProvenance *> *values;
    return values = values ? values : @{
        @"official": [[QTProvenance alloc] initWithValue:@"official"],
    };
}

+ (QTProvenance *)official { return QTProvenance.values[@"official"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTProvenance.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTPublicationStage
+ (NSDictionary<NSString *, QTPublicationStage *> *)values
{
    static NSDictionary<NSString *, QTPublicationStage *> *values;
    return values = values ? values : @{
        @"published": [[QTPublicationStage alloc] initWithValue:@"published"],
    };
}

+ (QTPublicationStage *)published { return QTPublicationStage.values[@"published"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPublicationStage.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRight
+ (NSDictionary<NSString *, QTRight *> *)values
{
    static NSDictionary<NSString *, QTRight *> *values;
    return values = values ? values : @{
        @"read": [[QTRight alloc] initWithValue:@"read"],
    };
}

+ (QTRight *)read { return QTRight.values[@"read"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRight.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTRowsUpdatedBy
+ (NSDictionary<NSString *, QTRowsUpdatedBy *> *)values
{
    static NSDictionary<NSString *, QTRowsUpdatedBy *> *values;
    return values = values ? values : @{
        @"pjxg-ve4m": [[QTRowsUpdatedBy alloc] initWithValue:@"pjxg-ve4m"],
        @"54a3-qyun": [[QTRowsUpdatedBy alloc] initWithValue:@"54a3-qyun"],
        @"9e3m-2843": [[QTRowsUpdatedBy alloc] initWithValue:@"9e3m-2843"],
        @"vvca-fr6g": [[QTRowsUpdatedBy alloc] initWithValue:@"vvca-fr6g"],
    };
}

+ (QTRowsUpdatedBy *)pjxgVe4M { return QTRowsUpdatedBy.values[@"pjxg-ve4m"]; }
+ (QTRowsUpdatedBy *)the54A3Qyun { return QTRowsUpdatedBy.values[@"54a3-qyun"]; }
+ (QTRowsUpdatedBy *)the9E3M2843 { return QTRowsUpdatedBy.values[@"9e3m-2843"]; }
+ (QTRowsUpdatedBy *)vvcaFr6G { return QTRowsUpdatedBy.values[@"vvca-fr6g"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTRowsUpdatedBy.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTViewType
+ (NSDictionary<NSString *, QTViewType *> *)values
{
    static NSDictionary<NSString *, QTViewType *> *values;
    return values = values ? values : @{
        @"tabular": [[QTViewType alloc] initWithValue:@"tabular"],
    };
}

+ (QTViewType *)tabular { return QTViewType.values[@"tabular"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTViewType.values[value];
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
        if (![json isKindOfClass:NSArray.class]) [NSException raise:@"Invalid JSON" format:@"Expected NSArray."];
        return *error ? nil : map(json, λ(id x, [QTTopLevelElement fromJSONDictionary:x]));
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
        id json = map(topLevel, λ(id x, [x JSONDictionary]));
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

@implementation QTTopLevelElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"averageRating": @"averageRating",
        @"category": @"category",
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
        @"moderationStatus": @"moderationStatus",
        @"modifyingViewUid": @"modifyingViewUid",
        @"name": @"name",
        @"numberOfComments": @"numberOfComments",
        @"oid": @"oid",
        @"owner": @"owner",
        @"provenance": @"provenance",
        @"publicationDate": @"publicationDate",
        @"publicationGroup": @"publicationGroup",
        @"publicationStage": @"publicationStage",
        @"ratings": @"ratings",
        @"resourceName": @"resourceName",
        @"rights": @"rights",
        @"rowClass": @"rowClass",
        @"rowIdentifierColumnId": @"rowIdentifierColumnID",
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
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"averageRating"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"averageRating"] doubleValue] != [dict[@"averageRating"] longLongValue]) return nil;
        if (![dict[@"createdAt"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"createdAt"] doubleValue] != [dict[@"createdAt"] longLongValue]) return nil;
        if (![dict[@"downloadCount"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"downloadCount"] doubleValue] != [dict[@"downloadCount"] longLongValue]) return nil;
        if (![dict[@"grants"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
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
        if (![dict[@"publicationGroup"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"publicationGroup"] doubleValue] != [dict[@"publicationGroup"] longLongValue]) return nil;
        if (![dict[@"publicationStage"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"rights"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"tableAuthor"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"tableId"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tableId"] doubleValue] != [dict[@"tableId"] longLongValue]) return nil;
        if (![dict[@"totalTimesRated"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalTimesRated"] doubleValue] != [dict[@"totalTimesRated"] longLongValue]) return nil;
        if (![dict[@"viewCount"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"viewCount"] doubleValue] != [dict[@"viewCount"] longLongValue]) return nil;
        if (![dict[@"viewLastModified"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"viewLastModified"] doubleValue] != [dict[@"viewLastModified"] longLongValue]) return nil;
        if (![dict[@"viewType"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _displayType = [QTDisplayType withValue:(id)_displayType];
        if (_displayType == nil && dict[@"displayType"] && ![dict[@"displayType"] isKindOfClass:NSNull.class]) return nil;
        _flags = map(_flags, λ(id x, [QTTopLevelFlag withValue:x]));
        _grants = map(_grants, λ(id x, [QTGrant fromJSONDictionary:x]));
        _metadata = [QTTopLevelMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
        _modifyingViewUid = [QTModifyingViewUid withValue:(id)_modifyingViewUid];
        if (_modifyingViewUid == nil && dict[@"modifyingViewUid"] && ![dict[@"modifyingViewUid"] isKindOfClass:NSNull.class]) return nil;
        _owner = [QTOwner fromJSONDictionary:(id)_owner];
        if (!_owner && dict[@"owner"] && ![dict[@"owner"] isKindOfClass:NSNull.class]) return nil;
        _provenance = [QTProvenance withValue:(id)_provenance];
        _publicationStage = [QTPublicationStage withValue:(id)_publicationStage];
        _ratings = [QTRatings fromJSONDictionary:(id)_ratings];
        if (!_ratings && dict[@"ratings"] && ![dict[@"ratings"] isKindOfClass:NSNull.class]) return nil;
        _rights = map(_rights, λ(id x, [QTRight withValue:x]));
        _rowsUpdatedBy = [QTRowsUpdatedBy withValue:(id)_rowsUpdatedBy];
        if (_rowsUpdatedBy == nil && dict[@"rowsUpdatedBy"] && ![dict[@"rowsUpdatedBy"] isKindOfClass:NSNull.class]) return nil;
        _tableAuthor = [QTTableAuthor fromJSONDictionary:(id)_tableAuthor];
        if (!_tableAuthor && dict[@"tableAuthor"] && ![dict[@"tableAuthor"] isKindOfClass:NSNull.class]) return nil;
        _viewType = [QTViewType withValue:(id)_viewType];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevelElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevelElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevelElement.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevelElement.properties) {
        id propertyName = QTTopLevelElement.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"displayType": NSNullify([_displayType value]),
        @"flags": NSNullify(map(_flags, λ(id x, [x value]))),
        @"grants": map(_grants, λ(id x, [x JSONDictionary])),
        @"hideFromCatalog": _isHideFromCatalog ? @YES : @NO,
        @"hideFromDataJson": _isHideFromDataJSON ? @YES : @NO,
        @"newBackend": _isNewBackend ? @YES : @NO,
        @"publicationAppendEnabled": _isPublicationAppendEnabled ? @YES : @NO,
        @"metadata": [_metadata JSONDictionary],
        @"modifyingViewUid": NSNullify([_modifyingViewUid value]),
        @"owner": [_owner JSONDictionary],
        @"provenance": [_provenance value],
        @"publicationStage": [_publicationStage value],
        @"ratings": NSNullify([_ratings isKindOfClass:NSNull.class] ? nil : [_ratings JSONDictionary]),
        @"rights": map(_rights, λ(id x, [x value])),
        @"rowsUpdatedBy": NSNullify([_rowsUpdatedBy value]),
        @"tableAuthor": [_tableAuthor JSONDictionary],
        @"viewType": [_viewType value],
    }];

    return dict;
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
        _flags = map(_flags, λ(id x, [QTGrantFlag withValue:x]));
        _type = [QTGrantType withValue:(id)_type];
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
        @"flags": map(_flags, λ(id x, [x value])),
        @"inherited": _isInherited ? @YES : @NO,
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTTopLevelMetadata
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"availableDisplayTypes": @"availableDisplayTypes",
        @"custom_fields": @"customFields",
        @"jsonQuery": @"jsonQuery",
        @"rdfClass": @"rdfClass",
        @"rdfSubject": @"rdfSubject",
        @"renderTypeConfig": @"renderTypeConfig",
        @"richRendererConfigs": @"richRendererConfigs",
        @"rowIdentifier": @"rowIdentifier",
        @"rowLabel": @"rowLabel",
        @"v1_archived_properties": @"v1ArchivedProperties",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _availableDisplayTypes = map(_availableDisplayTypes, λ(id x, [QTDisplayType withValue:x]));
        _customFields = [QTCustomFields fromJSONDictionary:(id)_customFields];
        if (!_customFields && dict[@"custom_fields"] && ![dict[@"custom_fields"] isKindOfClass:NSNull.class]) return nil;
        _jsonQuery = [QTJSONQuery fromJSONDictionary:(id)_jsonQuery];
        if (!_jsonQuery && dict[@"jsonQuery"] && ![dict[@"jsonQuery"] isKindOfClass:NSNull.class]) return nil;
        _renderTypeConfig = [QTMetadataRenderTypeConfig fromJSONDictionary:(id)_renderTypeConfig];
        if (!_renderTypeConfig && dict[@"renderTypeConfig"] && ![dict[@"renderTypeConfig"] isKindOfClass:NSNull.class]) return nil;
        _richRendererConfigs = [QTRichRendererConfigs fromJSONDictionary:(id)_richRendererConfigs];
        if (!_richRendererConfigs && dict[@"richRendererConfigs"] && ![dict[@"richRendererConfigs"] isKindOfClass:NSNull.class]) return nil;
        _v1ArchivedProperties = [QTV1ArchivedProperties fromJSONDictionary:(id)_v1ArchivedProperties];
        if (!_v1ArchivedProperties && dict[@"v1_archived_properties"] && ![dict[@"v1_archived_properties"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevelMetadata.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevelMetadata.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevelMetadata.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevelMetadata.properties) {
        id propertyName = QTTopLevelMetadata.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"availableDisplayTypes": NSNullify(map(_availableDisplayTypes, λ(id x, [x value]))),
        @"custom_fields": NSNullify([_customFields isKindOfClass:NSNull.class] ? nil : [_customFields JSONDictionary]),
        @"jsonQuery": NSNullify([_jsonQuery isKindOfClass:NSNull.class] ? nil : [_jsonQuery JSONDictionary]),
        @"renderTypeConfig": NSNullify([_renderTypeConfig isKindOfClass:NSNull.class] ? nil : [_renderTypeConfig JSONDictionary]),
        @"richRendererConfigs": NSNullify([_richRendererConfigs isKindOfClass:NSNull.class] ? nil : [_richRendererConfigs JSONDictionary]),
        @"v1_archived_properties": NSNullify([_v1ArchivedProperties isKindOfClass:NSNull.class] ? nil : [_v1ArchivedProperties JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTCustomFields
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"TEST": @"test",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCustomFields alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"TEST"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _test = [QTTest fromJSONDictionary:(id)_test];
        if (!_test && dict[@"TEST"] && ![dict[@"TEST"] isKindOfClass:NSNull.class]) return nil;
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
        @"TEST": [_test JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTTest
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"CFPB1": @"cfpb1",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTest alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"CFPB1"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTest.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTest.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTest.properties.allValues] mutableCopy];

    for (id jsonName in QTTest.properties) {
        id propertyName = QTTest.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONQuery
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"group": @"group",
        @"order": @"order",
        @"select": @"select",
        @"where": @"where",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONQuery alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _group = map(_group, λ(id x, [QTGroup fromJSONDictionary:x]));
        _order = map(_order, λ(id x, [QTOrder fromJSONDictionary:x]));
        _select = map(_select, λ(id x, [QTSelect fromJSONDictionary:x]));
        _where = [QTWhere fromJSONDictionary:(id)_where];
        if (!_where && dict[@"where"] && ![dict[@"where"] isKindOfClass:NSNull.class]) return nil;
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
        @"group": NSNullify(map(_group, λ(id x, [x JSONDictionary]))),
        @"order": NSNullify(map(_order, λ(id x, [x JSONDictionary]))),
        @"select": NSNullify(map(_select, λ(id x, [x JSONDictionary]))),
        @"where": NSNullify([_where isKindOfClass:NSNull.class] ? nil : [_where JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTGroup
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"columnFieldName": @"columnFieldName",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGroup alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"columnFieldName"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGroup.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGroup.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGroup.properties.allValues];
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
        _columnFieldName = [QTOrderColumnFieldName withValue:(id)_columnFieldName];
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
        @"columnFieldName": [_columnFieldName value],
        @"ascending": _isAscending ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTSelect
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"aggregate": @"aggregate",
        @"columnFieldName": @"columnFieldName",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSelect alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"columnFieldName"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSelect.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSelect.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSelect.properties.allValues];
}
@end

@implementation QTWhere
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"columnFieldName": @"columnFieldName",
        @"metadata": @"metadata",
        @"operator": @"operator",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWhere alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"operator"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTChild fromJSONDictionary:x]));
        _columnFieldName = [QTChildColumnFieldName withValue:(id)_columnFieldName];
        if (_columnFieldName == nil && dict[@"columnFieldName"] && ![dict[@"columnFieldName"] isKindOfClass:NSNull.class]) return nil;
        _metadata = [QTChildMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
        _operator = [QTWhereOperator withValue:(id)_operator];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWhere.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWhere.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTWhere.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"columnFieldName": NSNullify([_columnFieldName value]),
        @"metadata": NSNullify([_metadata isKindOfClass:NSNull.class] ? nil : [_metadata JSONDictionary]),
        @"operator": [_operator value],
    }];

    return dict;
}
@end

@implementation QTChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"columnFieldName": @"columnFieldName",
        @"metadata": @"metadata",
        @"operator": @"operator",
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
        if (![dict[@"columnFieldName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"operator"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _columnFieldName = [QTChildColumnFieldName withValue:(id)_columnFieldName];
        _metadata = [QTChildMetadata fromJSONDictionary:(id)_metadata];
        if (!_metadata && dict[@"metadata"] && ![dict[@"metadata"] isKindOfClass:NSNull.class]) return nil;
        _operator = [QTChildOperator withValue:(id)_operator];
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
        @"columnFieldName": [_columnFieldName value],
        @"metadata": NSNullify([_metadata isKindOfClass:NSNull.class] ? nil : [_metadata JSONDictionary]),
        @"operator": [_operator value],
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
        @"freeform": @"freeform",
        @"includeAuto": @"includeAuto",
        @"operator": @"operator",
        @"tableColumnId": @"tableColumnID",
        @"unifiedVersion": @"unifiedVersion",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChildMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _operator = [QTMetadataOperator withValue:(id)_operator];
        if (_operator == nil && dict[@"operator"] && ![dict[@"operator"] isKindOfClass:NSNull.class]) return nil;
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
        @"operator": NSNullify([_operator value]),
        @"tableColumnId": NSNullify([_tableColumnID isKindOfClass:NSNull.class] ? nil : [_tableColumnID JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTTableColumnID
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"2819740": @"the2819740",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTableColumnID alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"2819740"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"2819740"] doubleValue] != [dict[@"2819740"] longLongValue]) return nil;
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

@implementation QTMetadataRenderTypeConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"visible": @"visible",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMetadataRenderTypeConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"visible"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _visible = [QTPurpleVisible fromJSONDictionary:(id)_visible];
        if (!_visible && dict[@"visible"] && ![dict[@"visible"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMetadataRenderTypeConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMetadataRenderTypeConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMetadataRenderTypeConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"visible": [_visible JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTPurpleVisible
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"fatrow": @"fatrow",
        @"table": @"table",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleVisible alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTPurpleVisible.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleVisible.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPurpleVisible.properties.allValues];
}
@end

@implementation QTRichRendererConfigs
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"fatRow": @"fatRow",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRichRendererConfigs alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"fatRow"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _fatRow = [QTFatRow fromJSONDictionary:(id)_fatRow];
        if (!_fatRow && dict[@"fatRow"] && ![dict[@"fatRow"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRichRendererConfigs.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRichRendererConfigs.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRichRendererConfigs.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"fatRow": [_fatRow JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFatRow
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"columns": @"columns",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFatRow alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"columns"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _columns = map(_columns, λ(id x, [QTColumn fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFatRow.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFatRow.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFatRow.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"columns": map(_columns, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTColumn
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"rows": @"rows",
        @"styles": @"styles",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTColumn alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"rows"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"styles"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _rows = map(_rows, λ(id x, [QTRow fromJSONDictionary:x]));
        _styles = [QTStyles fromJSONDictionary:(id)_styles];
        if (!_styles && dict[@"styles"] && ![dict[@"styles"] isKindOfClass:NSNull.class]) return nil;
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

    [dict addEntriesFromDictionary:@{
        @"rows": map(_rows, λ(id x, [x JSONDictionary])),
        @"styles": [_styles JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTRow
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"fields": @"fields",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRow alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"fields"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _fields = map(_fields, λ(id x, [QTField fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRow.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRow.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRow.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"fields": map(_fields, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTField
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"tableColumnId": @"tableColumnID",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTField alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"tableColumnId"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tableColumnId"] doubleValue] != [dict[@"tableColumnId"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTFieldType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTField.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTField.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTField.properties.allValues] mutableCopy];

    for (id jsonName in QTField.properties) {
        id propertyName = QTField.properties[jsonName];
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

@implementation QTStyles
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStyles alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"width"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _width = [QTWidth withValue:(id)_width];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStyles.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStyles.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStyles.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"width": [_width value],
    }];

    return dict;
}
@end

@implementation QTV1ArchivedProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"accessPoints": @"accessPoints",
        @"blist_id": @"blistID",
        @"renderTypeConfig": @"renderTypeConfig",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTV1ArchivedProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"accessPoints"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"blist_id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"renderTypeConfig"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _accessPoints = [QTAccessPoints fromJSONDictionary:(id)_accessPoints];
        if (!_accessPoints && dict[@"accessPoints"] && ![dict[@"accessPoints"] isKindOfClass:NSNull.class]) return nil;
        _renderTypeConfig = [QTV1ArchivedPropertiesRenderTypeConfig fromJSONDictionary:(id)_renderTypeConfig];
        if (!_renderTypeConfig && dict[@"renderTypeConfig"] && ![dict[@"renderTypeConfig"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTV1ArchivedProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTV1ArchivedProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTV1ArchivedProperties.properties.allValues] mutableCopy];

    for (id jsonName in QTV1ArchivedProperties.properties) {
        id propertyName = QTV1ArchivedProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"accessPoints": [_accessPoints JSONDictionary],
        @"renderTypeConfig": [_renderTypeConfig JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTAccessPoints
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"new_view": @"theNewView",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAccessPoints alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"new_view"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAccessPoints.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAccessPoints.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAccessPoints.properties.allValues] mutableCopy];

    for (id jsonName in QTAccessPoints.properties) {
        id propertyName = QTAccessPoints.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTV1ArchivedPropertiesRenderTypeConfig
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"visible": @"visible",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTV1ArchivedPropertiesRenderTypeConfig alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"visible"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _visible = [QTFluffyVisible fromJSONDictionary:(id)_visible];
        if (!_visible && dict[@"visible"] && ![dict[@"visible"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTV1ArchivedPropertiesRenderTypeConfig.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTV1ArchivedPropertiesRenderTypeConfig.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTV1ArchivedPropertiesRenderTypeConfig.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"visible": [_visible JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFluffyVisible
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"href": @"isHref",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyVisible alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"href"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyVisible.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyVisible.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyVisible.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffyVisible.properties) {
        id propertyName = QTFluffyVisible.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"href": _isHref ? @YES : @NO,
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
        @"flags": @"flags",
        @"id": @"identifier",
        @"lastNotificationSeenAt": @"lastNotificationSeenAt",
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
        if (![dict[@"screenName"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _roleName = [QTRoleName withValue:(id)_roleName];
        if (_roleName == nil && dict[@"roleName"] && ![dict[@"roleName"] isKindOfClass:NSNull.class]) return nil;
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

    [dict addEntriesFromDictionary:@{
        @"roleName": NSNullify([_roleName value]),
    }];

    return dict;
}
@end

@implementation QTRatings
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"rating": @"rating",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRatings alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"rating"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"rating"] doubleValue] != [dict[@"rating"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRatings.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRatings.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRatings.properties.allValues];
}
@end

@implementation QTTableAuthor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"displayName": @"displayName",
        @"id": @"identifier",
        @"rights": @"rights",
        @"roleName": @"roleName",
        @"screenName": @"screenName",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTableAuthor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"displayName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"screenName"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _roleName = [QTRoleName withValue:(id)_roleName];
        if (_roleName == nil && dict[@"roleName"] && ![dict[@"roleName"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTableAuthor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTableAuthor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTableAuthor.properties.allValues] mutableCopy];

    for (id jsonName in QTTableAuthor.properties) {
        id propertyName = QTTableAuthor.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"roleName": NSNullify([_roleName value]),
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
