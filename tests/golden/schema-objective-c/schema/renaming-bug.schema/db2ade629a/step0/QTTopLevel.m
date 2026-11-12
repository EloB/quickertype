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

@interface QTFruit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBerry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTColor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTShape (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGeometry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCircularShape (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRectShape (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPart (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHistory (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVehicle (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSpeed (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLimit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVehicleType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTAxis
+ (NSDictionary<NSString *, QTAxis *> *)values
{
    static NSDictionary<NSString *, QTAxis *> *values;
    return values = values ? values : @{
        @"X": [[QTAxis alloc] initWithValue:@"X"],
        @"Y": [[QTAxis alloc] initWithValue:@"Y"],
        @"Z": [[QTAxis alloc] initWithValue:@"Z"],
        @"XY": [[QTAxis alloc] initWithValue:@"XY"],
        @"YZ": [[QTAxis alloc] initWithValue:@"YZ"],
        @"ZX": [[QTAxis alloc] initWithValue:@"ZX"],
    };
}

+ (QTAxis *)x { return QTAxis.values[@"X"]; }
+ (QTAxis *)y { return QTAxis.values[@"Y"]; }
+ (QTAxis *)z { return QTAxis.values[@"Z"]; }
+ (QTAxis *)xy { return QTAxis.values[@"XY"]; }
+ (QTAxis *)yz { return QTAxis.values[@"YZ"]; }
+ (QTAxis *)zx { return QTAxis.values[@"ZX"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTAxis.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTName
+ (NSDictionary<NSString *, QTName *> *)values
{
    static NSDictionary<NSString *, QTName *> *values;
    return values = values ? values : @{
        @"truck": [[QTName alloc] initWithValue:@"truck"],
        @"bus": [[QTName alloc] initWithValue:@"bus"],
        @"car": [[QTName alloc] initWithValue:@"car"],
        @"van": [[QTName alloc] initWithValue:@"van"],
        @"train": [[QTName alloc] initWithValue:@"train"],
        @"Bike": [[QTName alloc] initWithValue:@"Bike"],
        @"Aeroplane": [[QTName alloc] initWithValue:@"Aeroplane"],
        @"Jeep": [[QTName alloc] initWithValue:@"Jeep"],
        @"Trolley": [[QTName alloc] initWithValue:@"Trolley"],
    };
}

+ (QTName *)truck { return QTName.values[@"truck"]; }
+ (QTName *)bus { return QTName.values[@"bus"]; }
+ (QTName *)car { return QTName.values[@"car"]; }
+ (QTName *)van { return QTName.values[@"van"]; }
+ (QTName *)train { return QTName.values[@"train"]; }
+ (QTName *)bike { return QTName.values[@"Bike"]; }
+ (QTName *)aeroplane { return QTName.values[@"Aeroplane"]; }
+ (QTName *)jeep { return QTName.values[@"Jeep"]; }
+ (QTName *)trolley { return QTName.values[@"Trolley"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTName.values[value];
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
        @"version": @"version",
        @"fruits": @"fruits",
        @"vehicles": @"vehicles",
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
        if (dict[@"version"] && [dict[@"version"] rangeOfString:@"^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _fruits = map(_fruits, λ(id x, [QTFruit fromJSONDictionary:x]));
        _vehicles = map(_vehicles, λ(id x, [QTVehicle fromJSONDictionary:x]));
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
        @"fruits": NSNullify(map(_fruits, λ(id x, [x JSONDictionary]))),
        @"vehicles": NSNullify(map(_vehicles, λ(id x, [x JSONDictionary]))),
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

@implementation QTFruit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"apple": @"apple",
        @"berries": @"berries",
        @"orange": @"orange",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFruit alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _berries = map(_berries, λ(id x, [QTBerry fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFruit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFruit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFruit.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"berries": NSNullify(map(_berries, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTBerry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"color": @"color",
        @"name": @"name",
        @"shapes": @"shapes",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBerry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"name"] && [dict[@"name"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _color = [QTColor fromJSONDictionary:(id)_color];
        if (!_color && dict[@"color"] && ![dict[@"color"] isKindOfClass:NSNull.class]) return nil;
        _shapes = map(_shapes, λ(id x, [QTShape fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBerry.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBerry.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBerry.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"color": NSNullify([_color isKindOfClass:NSNull.class] ? nil : [_color JSONDictionary]),
        @"shapes": NSNullify(map(_shapes, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTColor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"rgb": @"rgb",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTColor alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTColor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTColor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTColor.properties.allValues];
}
@end

@implementation QTShape
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"geometry": @"geometry",
        @"history": @"history",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTShape alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _geometry = [QTGeometry fromJSONDictionary:(id)_geometry];
        if (!_geometry && dict[@"geometry"] && ![dict[@"geometry"] isKindOfClass:NSNull.class]) return nil;
        _history = [QTHistory fromJSONDictionary:(id)_history];
        if (!_history && dict[@"history"] && ![dict[@"history"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTShape.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTShape.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTShape.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"geometry": NSNullify([_geometry isKindOfClass:NSNull.class] ? nil : [_geometry JSONDictionary]),
        @"history": NSNullify([_history isKindOfClass:NSNull.class] ? nil : [_history JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTGeometry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"rectShape": @"rectShape",
        @"circularShape": @"circularShape",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGeometry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _rectShape = [QTRectShape fromJSONDictionary:(id)_rectShape];
        if (!_rectShape && dict[@"rectShape"] && ![dict[@"rectShape"] isKindOfClass:NSNull.class]) return nil;
        _circularShape = map(_circularShape, λ(id x, [QTCircularShape fromJSONDictionary:x]));
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
        @"rectShape": NSNullify([_rectShape isKindOfClass:NSNull.class] ? nil : [_rectShape JSONDictionary]),
        @"circularShape": NSNullify(map(_circularShape, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTCircularShape
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"shapeName": @"shapeName",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCircularShape alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTCircularShape.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCircularShape.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCircularShape.properties.allValues];
}
@end

@implementation QTRectShape
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"parts": @"parts",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRectShape alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _parts = map(_parts, λ(id x, [QTPart fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRectShape.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRectShape.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRectShape.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"parts": NSNullify(map(_parts, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTPart
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"depth": @"depth",
        @"length": @"length",
        @"width": @"width",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPart alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTPart.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPart.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPart.properties.allValues];
}
@end

@implementation QTHistory
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"class": @"class",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHistory alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTHistory.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHistory.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTHistory.properties.allValues];
}
@end

@implementation QTVehicle
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"brand": @"brand",
        @"id": @"identifier",
        @"speed": @"speed",
        @"subModule": @"subModule",
        @"type": @"type",
        @"year": @"year",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVehicle alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"id"] && [dict[@"id"] lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4 < 1) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _speed = [QTSpeed fromJSONDictionary:(id)_speed];
        if (!_speed && dict[@"speed"] && ![dict[@"speed"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTVehicleType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVehicle.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVehicle.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVehicle.properties.allValues] mutableCopy];

    for (id jsonName in QTVehicle.properties) {
        id propertyName = QTVehicle.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"speed": NSNullify([_speed isKindOfClass:NSNull.class] ? nil : [_speed JSONDictionary]),
        @"type": NSNullify([_type isKindOfClass:NSNull.class] ? nil : [_type JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTSpeed
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"velocity": @"velocity",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSpeed alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _velocity = [QTLimit fromJSONDictionary:(id)_velocity];
        if (!_velocity && dict[@"velocity"] && ![dict[@"velocity"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSpeed.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSpeed.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSpeed.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"velocity": NSNullify([_velocity isKindOfClass:NSNull.class] ? nil : [_velocity JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTLimit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"maximum": @"maximum",
        @"minimum": @"minimum",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLimit alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTLimit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLimit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTLimit.properties.allValues];
}
@end

@implementation QTVehicleType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
        @"width": @"width",
        @"length": @"length",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVehicleType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _width = [QTAxis withValue:(id)_width];
        if (_width == nil && dict[@"width"] && ![dict[@"width"] isKindOfClass:NSNull.class]) return nil;
        _length = [QTAxis withValue:(id)_length];
        if (_length == nil && dict[@"length"] && ![dict[@"length"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVehicleType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVehicleType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVehicleType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"name": NSNullify([_name value]),
        @"width": NSNullify([_width value]),
        @"length": NSNullify([_length value]),
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
