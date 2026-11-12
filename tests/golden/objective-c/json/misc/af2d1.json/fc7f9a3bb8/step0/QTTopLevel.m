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

@interface QTCRS (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCRSProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFeature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGeometry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFeatureProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTGeometryType
+ (NSDictionary<NSString *, QTGeometryType *> *)values
{
    static NSDictionary<NSString *, QTGeometryType *> *values;
    return values = values ? values : @{
        @"MultiPolygon": [[QTGeometryType alloc] initWithValue:@"MultiPolygon"],
    };
}

+ (QTGeometryType *)multiPolygon { return QTGeometryType.values[@"MultiPolygon"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGeometryType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTGeometryName
+ (NSDictionary<NSString *, QTGeometryName *> *)values
{
    static NSDictionary<NSString *, QTGeometryName *> *values;
    return values = values ? values : @{
        @"geom": [[QTGeometryName alloc] initWithValue:@"geom"],
    };
}

+ (QTGeometryName *)geom { return QTGeometryName.values[@"geom"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTGeometryName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTAddImprov
+ (NSDictionary<NSString *, QTAddImprov *> *)values
{
    static NSDictionary<NSString *, QTAddImprov *> *values;
    return values = values ? values : @{
        @"f": [[QTAddImprov alloc] initWithValue:@"f"],
        @"F": [[QTAddImprov alloc] initWithValue:@"F"],
        @"t": [[QTAddImprov alloc] initWithValue:@"t"],
    };
}

+ (QTAddImprov *)f { return QTAddImprov.values[@"f"]; }
+ (QTAddImprov *)addImprovF { return QTAddImprov.values[@"F"]; }
+ (QTAddImprov *)t { return QTAddImprov.values[@"t"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTAddImprov.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFundingBa
+ (NSDictionary<NSString *, QTFundingBa *> *)values
{
    static NSDictionary<NSString *, QTFundingBa *> *values;
    return values = values ? values : @{
        @"Non GCCC": [[QTFundingBa alloc] initWithValue:@"Non GCCC"],
        @"Capex": [[QTFundingBa alloc] initWithValue:@"Capex"],
        @"Initial": [[QTFundingBa alloc] initWithValue:@"Initial"],
        @"Contribute": [[QTFundingBa alloc] initWithValue:@"Contribute"],
    };
}

+ (QTFundingBa *)nonGCCC { return QTFundingBa.values[@"Non GCCC"]; }
+ (QTFundingBa *)capex { return QTFundingBa.values[@"Capex"]; }
+ (QTFundingBa *)initial { return QTFundingBa.values[@"Initial"]; }
+ (QTFundingBa *)contribute { return QTFundingBa.values[@"Contribute"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFundingBa.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTLevelAccu
+ (NSDictionary<NSString *, QTLevelAccu *> *)values
{
    static NSDictionary<NSString *, QTLevelAccu *> *values;
    return values = values ? values : @{
        @"GPS Corrected 1.0M": [[QTLevelAccu alloc] initWithValue:@"GPS Corrected 1.0M"],
        @"APPROX": [[QTLevelAccu alloc] initWithValue:@"APPROX"],
        @"GPS COrrected 1.0M": [[QTLevelAccu alloc] initWithValue:@"GPS COrrected 1.0M"],
    };
}

+ (QTLevelAccu *)gpsCorrected10M { return QTLevelAccu.values[@"GPS Corrected 1.0M"]; }
+ (QTLevelAccu *)approx { return QTLevelAccu.values[@"APPROX"]; }
+ (QTLevelAccu *)gpsCOrrected10M { return QTLevelAccu.values[@"GPS COrrected 1.0M"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLevelAccu.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMaterial
+ (NSDictionary<NSString *, QTMaterial *> *)values
{
    static NSDictionary<NSString *, QTMaterial *> *values;
    return values = values ? values : @{
        @"Gravel": [[QTMaterial alloc] initWithValue:@"Gravel"],
        @"Concrete": [[QTMaterial alloc] initWithValue:@"Concrete"],
        @"Bitumen": [[QTMaterial alloc] initWithValue:@"Bitumen"],
        @"Interlock Conc Block": [[QTMaterial alloc] initWithValue:@"Interlock Conc Block"],
        @"Other": [[QTMaterial alloc] initWithValue:@"Other"],
        @"Earth": [[QTMaterial alloc] initWithValue:@"Earth"],
    };
}

+ (QTMaterial *)gravel { return QTMaterial.values[@"Gravel"]; }
+ (QTMaterial *)concrete { return QTMaterial.values[@"Concrete"]; }
+ (QTMaterial *)bitumen { return QTMaterial.values[@"Bitumen"]; }
+ (QTMaterial *)interlockConcBlock { return QTMaterial.values[@"Interlock Conc Block"]; }
+ (QTMaterial *)other { return QTMaterial.values[@"Other"]; }
+ (QTMaterial *)earth { return QTMaterial.values[@"Earth"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMaterial.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMiSymbolo
+ (NSDictionary<NSString *, QTMiSymbolo *> *)values
{
    static NSDictionary<NSString *, QTMiSymbolo *> *values;
    return values = values ? values : @{
        @"Pen (2, 2, 65535) Brush (1, 0, 16777215)": [[QTMiSymbolo alloc] initWithValue:@"Pen (2, 2, 65535) Brush (1, 0, 16777215)"],
    };
}

+ (QTMiSymbolo *)pen2265535Brush1016777215 { return QTMiSymbolo.values[@"Pen (2, 2, 65535) Brush (1, 0, 16777215)"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMiSymbolo.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTStatus
+ (NSDictionary<NSString *, QTStatus *> *)values
{
    static NSDictionary<NSString *, QTStatus *> *values;
    return values = values ? values : @{
        @"CURRENT": [[QTStatus alloc] initWithValue:@"CURRENT"],
    };
}

+ (QTStatus *)current { return QTStatus.values[@"CURRENT"]; }

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

@implementation QTPropertiesType
+ (NSDictionary<NSString *, QTPropertiesType *> *)values
{
    static NSDictionary<NSString *, QTPropertiesType *> *values;
    return values = values ? values : @{
        @"Boat Ramp": [[QTPropertiesType alloc] initWithValue:@"Boat Ramp"],
    };
}

+ (QTPropertiesType *)boatRamp { return QTPropertiesType.values[@"Boat Ramp"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPropertiesType.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFeatureType
+ (NSDictionary<NSString *, QTFeatureType *> *)values
{
    static NSDictionary<NSString *, QTFeatureType *> *values;
    return values = values ? values : @{
        @"Feature": [[QTFeatureType alloc] initWithValue:@"Feature"],
    };
}

+ (QTFeatureType *)feature { return QTFeatureType.values[@"Feature"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFeatureType.values[value];
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
        @"crs": @"crs",
        @"features": @"features",
        @"totalFeatures": @"totalFeatures",
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
        if (![dict[@"crs"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"features"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"totalFeatures"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"totalFeatures"] doubleValue] != [dict[@"totalFeatures"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _crs = [QTCRS fromJSONDictionary:(id)_crs];
        if (!_crs && dict[@"crs"] && ![dict[@"crs"] isKindOfClass:NSNull.class]) return nil;
        _features = map(_features, λ(id x, [QTFeature fromJSONDictionary:x]));
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
        @"crs": [_crs JSONDictionary],
        @"features": map(_features, λ(id x, [x JSONDictionary])),
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

@implementation QTCRS
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"properties": @"properties",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCRS alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _properties = [QTCRSProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCRS.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCRS.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCRS.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"properties": [_properties JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCRSProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCRSProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCRSProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCRSProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCRSProperties.properties.allValues];
}
@end

@implementation QTFeature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"geometry": @"geometry",
        @"geometry_name": @"geometryName",
        @"id": @"identifier",
        @"properties": @"properties",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFeature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"geometry"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"geometry_name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"properties"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _geometry = [QTGeometry fromJSONDictionary:(id)_geometry];
        if (!_geometry && dict[@"geometry"] && ![dict[@"geometry"] isKindOfClass:NSNull.class]) return nil;
        _geometryName = [QTGeometryName withValue:(id)_geometryName];
        _properties = [QTFeatureProperties fromJSONDictionary:(id)_properties];
        if (!_properties && dict[@"properties"] && ![dict[@"properties"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTFeatureType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFeature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFeature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFeature.properties.allValues] mutableCopy];

    for (id jsonName in QTFeature.properties) {
        id propertyName = QTFeature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"geometry": [_geometry JSONDictionary],
        @"geometry_name": [_geometryName value],
        @"properties": [_properties JSONDictionary],
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTGeometry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"coordinates": @"coordinates",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGeometry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"coordinates"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTGeometryType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGeometry.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGeometry.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGeometry.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTFeatureProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"add_improv": @"addImprov",
        @"area_": @"area",
        @"asset_numb": @"assetNumb",
        @"comments": @"comments",
        @"condition": @"condition",
        @"constructi": @"constructi",
        @"createdate": @"createdate",
        @"createuser": @"createuser",
        @"disposal_d": @"disposalD",
        @"documents": @"documents",
        @"drawing_nu": @"drawingNu",
        @"file_numbe": @"fileNumbe",
        @"folder_num": @"folderNum",
        @"funding_ba": @"fundingBa",
        @"historic_c": @"historicC",
        @"inspection": @"inspection",
        @"inspectors": @"inspectors",
        @"last_updat": @"lastUpdat",
        @"level_accu": @"levelAccu",
        @"material": @"material",
        @"mi_prinx": @"miPrinx",
        @"mi_symbolo": @"miSymbolo",
        @"number_lan": @"numberLAN",
        @"owner": @"owner",
        @"positional": @"positional",
        @"project_nu": @"projectNu",
        @"rec_id": @"recID",
        @"record_cre": @"recordCre",
        @"shape_area": @"shapeArea",
        @"shape_leng": @"shapeLeng",
        @"status": @"status",
        @"survey_num": @"surveyNum",
        @"toe_rl": @"toeRl",
        @"top_rl": @"topRl",
        @"type": @"type",
        @"update_dat": @"updateDAT",
        @"updatedate": @"updatedate",
        @"updateuser": @"updateuser",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFeatureProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"add_improv"]) return nil;
        if (![dict[@"area_"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"asset_numb"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"comments"]) return nil;
        if (![dict[@"condition"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"condition"] doubleValue] != [dict[@"condition"] longLongValue]) return nil;
        if (!dict[@"constructi"]) return nil;
        if (!dict[@"createdate"]) return nil;
        if (!dict[@"createuser"]) return nil;
        if (!dict[@"disposal_d"]) return nil;
        if (![dict[@"documents"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"drawing_nu"]) return nil;
        if (!dict[@"file_numbe"]) return nil;
        if (!dict[@"folder_num"]) return nil;
        if (!dict[@"funding_ba"]) return nil;
        if (![dict[@"historic_c"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"historic_c"] doubleValue] != [dict[@"historic_c"] longLongValue]) return nil;
        if (![dict[@"inspection"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"inspectors"]) return nil;
        if (!dict[@"last_updat"]) return nil;
        if (!dict[@"level_accu"]) return nil;
        if (![dict[@"material"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"mi_prinx"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"mi_prinx"] doubleValue] != [dict[@"mi_prinx"] longLongValue]) return nil;
        if (![dict[@"mi_symbolo"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"number_lan"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"number_lan"] doubleValue] != [dict[@"number_lan"] longLongValue]) return nil;
        if (!dict[@"owner"]) return nil;
        if (!dict[@"positional"]) return nil;
        if (!dict[@"project_nu"]) return nil;
        if (![dict[@"rec_id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"rec_id"] doubleValue] != [dict[@"rec_id"] longLongValue]) return nil;
        if (!dict[@"record_cre"]) return nil;
        if (![dict[@"shape_area"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"shape_leng"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"status"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"survey_num"]) return nil;
        if (![dict[@"toe_rl"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"top_rl"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"type"]) return nil;
        if (![dict[@"update_dat"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"updatedate"]) return nil;
        if (!dict[@"updateuser"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _addImprov = [QTAddImprov withValue:(id)_addImprov];
        if (_addImprov == nil && dict[@"add_improv"] && ![dict[@"add_improv"] isKindOfClass:NSNull.class]) return nil;
        _fundingBa = [QTFundingBa withValue:(id)_fundingBa];
        if (_fundingBa == nil && dict[@"funding_ba"] && ![dict[@"funding_ba"] isKindOfClass:NSNull.class]) return nil;
        _levelAccu = [QTLevelAccu withValue:(id)_levelAccu];
        if (_levelAccu == nil && dict[@"level_accu"] && ![dict[@"level_accu"] isKindOfClass:NSNull.class]) return nil;
        _material = [QTMaterial withValue:(id)_material];
        _miSymbolo = [QTMiSymbolo withValue:(id)_miSymbolo];
        _positional = [QTLevelAccu withValue:(id)_positional];
        if (_positional == nil && dict[@"positional"] && ![dict[@"positional"] isKindOfClass:NSNull.class]) return nil;
        _status = [QTStatus withValue:(id)_status];
        _type = [QTPropertiesType withValue:(id)_type];
        if (_type == nil && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFeatureProperties.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFeatureProperties.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFeatureProperties.properties.allValues] mutableCopy];

    for (id jsonName in QTFeatureProperties.properties) {
        id propertyName = QTFeatureProperties.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"add_improv": NSNullify([_addImprov value]),
        @"funding_ba": NSNullify([_fundingBa value]),
        @"level_accu": NSNullify([_levelAccu value]),
        @"material": [_material value],
        @"mi_symbolo": [_miSymbolo value],
        @"positional": NSNullify([_positional value]),
        @"status": [_status value],
        @"type": NSNullify([_type value]),
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
