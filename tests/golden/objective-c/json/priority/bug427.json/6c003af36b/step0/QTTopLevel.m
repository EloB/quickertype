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

@interface QTTopLevelChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTentacledChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleFlags (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleSignature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGetSignatureFlags (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGetSignatureType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndexSignatureElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGetSignatureChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGetSignature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTElementType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyFlags (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSource (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGetSignatureComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGroup (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGetSignatureParameter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTentacledComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTentacledFlags (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTentacledType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleDeclaration (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypeElement (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStickyComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTag (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStickyFlags (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExtendedBy (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffySignature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndigoFlags (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleParameter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStickyType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndigoType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyDeclaration (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStickyChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndecentType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndexSignature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHilariousType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTentacledSignature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndigoComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyParameter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPurpleTypeArgument (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndecentFlags (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStickySignature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTentacledParameter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAmbitiousType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTentacledDeclaration (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndigoChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCunningType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMagentaType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStickyDeclaration (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndecentChild (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFriskyType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndigoDeclaration (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFluffyTypeArgument (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypeParameter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMischievousType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndecentComment (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTPurpleKindString
+ (NSDictionary<NSString *, QTPurpleKindString *> *)values
{
    static NSDictionary<NSString *, QTPurpleKindString *> *values;
    return values = values ? values : @{
        @"Variable": [[QTPurpleKindString alloc] initWithValue:@"Variable"],
        @"Function": [[QTPurpleKindString alloc] initWithValue:@"Function"],
        @"Property": [[QTPurpleKindString alloc] initWithValue:@"Property"],
        @"Method": [[QTPurpleKindString alloc] initWithValue:@"Method"],
        @"Constructor": [[QTPurpleKindString alloc] initWithValue:@"Constructor"],
        @"Accessor": [[QTPurpleKindString alloc] initWithValue:@"Accessor"],
        @"Enumeration member": [[QTPurpleKindString alloc] initWithValue:@"Enumeration member"],
        @"Module": [[QTPurpleKindString alloc] initWithValue:@"Module"],
        @"Object literal": [[QTPurpleKindString alloc] initWithValue:@"Object literal"],
    };
}

+ (QTPurpleKindString *)variable { return QTPurpleKindString.values[@"Variable"]; }
+ (QTPurpleKindString *)function { return QTPurpleKindString.values[@"Function"]; }
+ (QTPurpleKindString *)property { return QTPurpleKindString.values[@"Property"]; }
+ (QTPurpleKindString *)method { return QTPurpleKindString.values[@"Method"]; }
+ (QTPurpleKindString *)constructor { return QTPurpleKindString.values[@"Constructor"]; }
+ (QTPurpleKindString *)accessor { return QTPurpleKindString.values[@"Accessor"]; }
+ (QTPurpleKindString *)enumerationMember { return QTPurpleKindString.values[@"Enumeration member"]; }
+ (QTPurpleKindString *)module { return QTPurpleKindString.values[@"Module"]; }
+ (QTPurpleKindString *)objectLiteral { return QTPurpleKindString.values[@"Object literal"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPurpleKindString.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTSignatureKindString
+ (NSDictionary<NSString *, QTSignatureKindString *> *)values
{
    static NSDictionary<NSString *, QTSignatureKindString *> *values;
    return values = values ? values : @{
        @"Call signature": [[QTSignatureKindString alloc] initWithValue:@"Call signature"],
        @"Constructor signature": [[QTSignatureKindString alloc] initWithValue:@"Constructor signature"],
    };
}

+ (QTSignatureKindString *)callSignature { return QTSignatureKindString.values[@"Call signature"]; }
+ (QTSignatureKindString *)constructorSignature { return QTSignatureKindString.values[@"Constructor signature"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTSignatureKindString.values[value];
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
        @"string": [[QTName alloc] initWithValue:@"string"],
        @"number": [[QTName alloc] initWithValue:@"number"],
        @"void": [[QTName alloc] initWithValue:@"void"],
        @"T": [[QTName alloc] initWithValue:@"T"],
        @"boolean": [[QTName alloc] initWithValue:@"boolean"],
        @"BaseClass": [[QTName alloc] initWithValue:@"BaseClass"],
        @"any": [[QTName alloc] initWithValue:@"any"],
        @"Array": [[QTName alloc] initWithValue:@"Array"],
        @"MyNumber": [[QTName alloc] initWithValue:@"MyNumber"],
    };
}

+ (QTName *)string { return QTName.values[@"string"]; }
+ (QTName *)number { return QTName.values[@"number"]; }
+ (QTName *)nameVoid { return QTName.values[@"void"]; }
+ (QTName *)t { return QTName.values[@"T"]; }
+ (QTName *)boolean { return QTName.values[@"boolean"]; }
+ (QTName *)baseClass { return QTName.values[@"BaseClass"]; }
+ (QTName *)any { return QTName.values[@"any"]; }
+ (QTName *)array { return QTName.values[@"Array"]; }
+ (QTName *)myNumber { return QTName.values[@"MyNumber"]; }

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

@implementation QTTypeEnum
+ (NSDictionary<NSString *, QTTypeEnum *> *)values
{
    static NSDictionary<NSString *, QTTypeEnum *> *values;
    return values = values ? values : @{
        @"intrinsic": [[QTTypeEnum alloc] initWithValue:@"intrinsic"],
        @"reflection": [[QTTypeEnum alloc] initWithValue:@"reflection"],
        @"array": [[QTTypeEnum alloc] initWithValue:@"array"],
        @"reference": [[QTTypeEnum alloc] initWithValue:@"reference"],
        @"typeParameter": [[QTTypeEnum alloc] initWithValue:@"typeParameter"],
        @"tuple": [[QTTypeEnum alloc] initWithValue:@"tuple"],
        @"union": [[QTTypeEnum alloc] initWithValue:@"union"],
        @"stringLiteral": [[QTTypeEnum alloc] initWithValue:@"stringLiteral"],
    };
}

+ (QTTypeEnum *)intrinsic { return QTTypeEnum.values[@"intrinsic"]; }
+ (QTTypeEnum *)reflection { return QTTypeEnum.values[@"reflection"]; }
+ (QTTypeEnum *)array { return QTTypeEnum.values[@"array"]; }
+ (QTTypeEnum *)reference { return QTTypeEnum.values[@"reference"]; }
+ (QTTypeEnum *)typeParameter { return QTTypeEnum.values[@"typeParameter"]; }
+ (QTTypeEnum *)tuple { return QTTypeEnum.values[@"tuple"]; }
+ (QTTypeEnum *)typeUnion { return QTTypeEnum.values[@"union"]; }
+ (QTTypeEnum *)stringLiteral { return QTTypeEnum.values[@"stringLiteral"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTypeEnum.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFileName
+ (NSDictionary<NSString *, QTFileName *> *)values
{
    static NSDictionary<NSString *, QTFileName *> *values;
    return values = values ? values : @{
        @"modules.ts": [[QTFileName alloc] initWithValue:@"modules.ts"],
        @"classes.ts": [[QTFileName alloc] initWithValue:@"classes.ts"],
        @"flattened.ts": [[QTFileName alloc] initWithValue:@"flattened.ts"],
        @"access.ts": [[QTFileName alloc] initWithValue:@"access.ts"],
        @"default-export.ts": [[QTFileName alloc] initWithValue:@"default-export.ts"],
        @"enumerations.ts": [[QTFileName alloc] initWithValue:@"enumerations.ts"],
        @"functions.ts": [[QTFileName alloc] initWithValue:@"functions.ts"],
        @"generics.ts": [[QTFileName alloc] initWithValue:@"generics.ts"],
        @"single-export.ts": [[QTFileName alloc] initWithValue:@"single-export.ts"],
        @"typescript-1.3.ts": [[QTFileName alloc] initWithValue:@"typescript-1.3.ts"],
        @"typescript-1.4.ts": [[QTFileName alloc] initWithValue:@"typescript-1.4.ts"],
        @"typescript-1.5.ts": [[QTFileName alloc] initWithValue:@"typescript-1.5.ts"],
        @"variables.ts": [[QTFileName alloc] initWithValue:@"variables.ts"],
    };
}

+ (QTFileName *)modulesTs { return QTFileName.values[@"modules.ts"]; }
+ (QTFileName *)classesTs { return QTFileName.values[@"classes.ts"]; }
+ (QTFileName *)flattenedTs { return QTFileName.values[@"flattened.ts"]; }
+ (QTFileName *)accessTs { return QTFileName.values[@"access.ts"]; }
+ (QTFileName *)defaultExportTs { return QTFileName.values[@"default-export.ts"]; }
+ (QTFileName *)enumerationsTs { return QTFileName.values[@"enumerations.ts"]; }
+ (QTFileName *)functionsTs { return QTFileName.values[@"functions.ts"]; }
+ (QTFileName *)genericsTs { return QTFileName.values[@"generics.ts"]; }
+ (QTFileName *)singleExportTs { return QTFileName.values[@"single-export.ts"]; }
+ (QTFileName *)typescript13Ts { return QTFileName.values[@"typescript-1.3.ts"]; }
+ (QTFileName *)typescript14Ts { return QTFileName.values[@"typescript-1.4.ts"]; }
+ (QTFileName *)typescript15Ts { return QTFileName.values[@"typescript-1.5.ts"]; }
+ (QTFileName *)variablesTs { return QTFileName.values[@"variables.ts"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFileName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTParameterKindString
+ (NSDictionary<NSString *, QTParameterKindString *> *)values
{
    static NSDictionary<NSString *, QTParameterKindString *> *values;
    return values = values ? values : @{
        @"Parameter": [[QTParameterKindString alloc] initWithValue:@"Parameter"],
    };
}

+ (QTParameterKindString *)parameter { return QTParameterKindString.values[@"Parameter"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTParameterKindString.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTFluffyKindString
+ (NSDictionary<NSString *, QTFluffyKindString *> *)values
{
    static NSDictionary<NSString *, QTFluffyKindString *> *values;
    return values = values ? values : @{
        @"Module": [[QTFluffyKindString alloc] initWithValue:@"Module"],
        @"Class": [[QTFluffyKindString alloc] initWithValue:@"Class"],
        @"Variable": [[QTFluffyKindString alloc] initWithValue:@"Variable"],
        @"Function": [[QTFluffyKindString alloc] initWithValue:@"Function"],
        @"Interface": [[QTFluffyKindString alloc] initWithValue:@"Interface"],
        @"Enumeration": [[QTFluffyKindString alloc] initWithValue:@"Enumeration"],
        @"Object literal": [[QTFluffyKindString alloc] initWithValue:@"Object literal"],
        @"Type alias": [[QTFluffyKindString alloc] initWithValue:@"Type alias"],
    };
}

+ (QTFluffyKindString *)module { return QTFluffyKindString.values[@"Module"]; }
+ (QTFluffyKindString *)class { return QTFluffyKindString.values[@"Class"]; }
+ (QTFluffyKindString *)variable { return QTFluffyKindString.values[@"Variable"]; }
+ (QTFluffyKindString *)function { return QTFluffyKindString.values[@"Function"]; }
+ (QTFluffyKindString *)interface { return QTFluffyKindString.values[@"Interface"]; }
+ (QTFluffyKindString *)enumeration { return QTFluffyKindString.values[@"Enumeration"]; }
+ (QTFluffyKindString *)objectLiteral { return QTFluffyKindString.values[@"Object literal"]; }
+ (QTFluffyKindString *)typeAlias { return QTFluffyKindString.values[@"Type alias"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTFluffyKindString.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTTentacledKindString
+ (NSDictionary<NSString *, QTTentacledKindString *> *)values
{
    static NSDictionary<NSString *, QTTentacledKindString *> *values;
    return values = values ? values : @{
        @"External module": [[QTTentacledKindString alloc] initWithValue:@"External module"],
    };
}

+ (QTTentacledKindString *)externalModule { return QTTentacledKindString.values[@"External module"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTTentacledKindString.values[value];
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
        @"children": @"children",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"kind": @"kind",
        @"name": @"name",
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
        if (![dict[@"children"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"groups"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTTopLevelChild fromJSONDictionary:x]));
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
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
        @"children": map(_children, λ(id x, [x JSONDictionary])),
        @"flags": [_flags JSONDictionary],
        @"groups": map(_groups, λ(id x, [x JSONDictionary])),
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

@implementation QTTopLevelChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"comment": @"comment",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"originalName": @"originalName",
        @"sources": @"sources",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"children"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"groups"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"originalName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTPurpleChild fromJSONDictionary:x]));
        _comment = [QTIndecentComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTPurpleFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _kindString = [QTTentacledKindString withValue:(id)_kindString];
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevelChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevelChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevelChild.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevelChild.properties) {
        id propertyName = QTTopLevelChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": map(_children, λ(id x, [x JSONDictionary])),
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"groups": map(_groups, λ(id x, [x JSONDictionary])),
        @"kindString": [_kindString value],
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTPurpleChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"comment": @"comment",
        @"defaultValue": @"defaultValue",
        @"extendedBy": @"extendedBy",
        @"extendedTypes": @"extendedTypes",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"implementedBy": @"implementedBy",
        @"implementedTypes": @"implementedTypes",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"signatures": @"signatures",
        @"sources": @"sources",
        @"type": @"type",
        @"typeParameter": @"typeParameter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTFluffyChild fromJSONDictionary:x]));
        _comment = [QTStickyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _extendedBy = map(_extendedBy, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
        _extendedTypes = map(_extendedTypes, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
        _flags = [QTIndecentFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _implementedBy = map(_implementedBy, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
        _implementedTypes = map(_implementedTypes, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
        _kindString = [QTFluffyKindString withValue:(id)_kindString];
        _signatures = map(_signatures, λ(id x, [QTStickySignature fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTMagentaType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
        _typeParameter = map(_typeParameter, λ(id x, [QTTypeParameter fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleChild.properties.allValues] mutableCopy];

    for (id jsonName in QTPurpleChild.properties) {
        id propertyName = QTPurpleChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"extendedBy": NSNullify(map(_extendedBy, λ(id x, [x JSONDictionary]))),
        @"extendedTypes": NSNullify(map(_extendedTypes, λ(id x, [x JSONDictionary]))),
        @"flags": [_flags JSONDictionary],
        @"groups": NSNullify(map(_groups, λ(id x, [x JSONDictionary]))),
        @"implementedBy": NSNullify(map(_implementedBy, λ(id x, [x JSONDictionary]))),
        @"implementedTypes": NSNullify(map(_implementedTypes, λ(id x, [x JSONDictionary]))),
        @"kindString": [_kindString value],
        @"signatures": NSNullify(map(_signatures, λ(id x, [x JSONDictionary]))),
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
        @"type": NSNullify([_type isKindOfClass:NSNull.class] ? nil : [_type JSONDictionary]),
        @"typeParameter": NSNullify(map(_typeParameter, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTFluffyChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"comment": @"comment",
        @"defaultValue": @"defaultValue",
        @"flags": @"flags",
        @"getSignature": @"getSignature",
        @"groups": @"groups",
        @"id": @"identifier",
        @"implementationOf": @"implementationOf",
        @"inheritedFrom": @"inheritedFrom",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"overwrites": @"overwrites",
        @"setSignature": @"setSignature",
        @"signatures": @"signatures",
        @"sources": @"sources",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTTentacledChild fromJSONDictionary:x]));
        _comment = [QTStickyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTStickyFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _getSignature = [QTGetSignature fromJSONDictionary:(id)_getSignature];
        if (!_getSignature && dict[@"getSignature"] && ![dict[@"getSignature"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _implementationOf = [QTExtendedBy fromJSONDictionary:(id)_implementationOf];
        if (!_implementationOf && dict[@"implementationOf"] && ![dict[@"implementationOf"] isKindOfClass:NSNull.class]) return nil;
        _inheritedFrom = [QTExtendedBy fromJSONDictionary:(id)_inheritedFrom];
        if (!_inheritedFrom && dict[@"inheritedFrom"] && ![dict[@"inheritedFrom"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTPurpleKindString withValue:(id)_kindString];
        _overwrites = [QTExtendedBy fromJSONDictionary:(id)_overwrites];
        if (!_overwrites && dict[@"overwrites"] && ![dict[@"overwrites"] isKindOfClass:NSNull.class]) return nil;
        _setSignature = [QTGetSignature fromJSONDictionary:(id)_setSignature];
        if (!_setSignature && dict[@"setSignature"] && ![dict[@"setSignature"] isKindOfClass:NSNull.class]) return nil;
        _signatures = map(_signatures, λ(id x, [QTFluffySignature fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTIndigoType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyChild.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffyChild.properties) {
        id propertyName = QTFluffyChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"getSignature": NSNullify([_getSignature isKindOfClass:NSNull.class] ? nil : [_getSignature JSONDictionary]),
        @"groups": NSNullify(map(_groups, λ(id x, [x JSONDictionary]))),
        @"implementationOf": NSNullify([_implementationOf isKindOfClass:NSNull.class] ? nil : [_implementationOf JSONDictionary]),
        @"inheritedFrom": NSNullify([_inheritedFrom isKindOfClass:NSNull.class] ? nil : [_inheritedFrom JSONDictionary]),
        @"kindString": [_kindString value],
        @"overwrites": NSNullify([_overwrites isKindOfClass:NSNull.class] ? nil : [_overwrites JSONDictionary]),
        @"setSignature": NSNullify([_setSignature isKindOfClass:NSNull.class] ? nil : [_setSignature JSONDictionary]),
        @"signatures": NSNullify(map(_signatures, λ(id x, [x JSONDictionary]))),
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
        @"type": NSNullify([_type isKindOfClass:NSNull.class] ? nil : [_type JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTTentacledChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"defaultValue": @"defaultValue",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"signatures": @"signatures",
        @"sources": @"sources",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTentacledChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTPurpleComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTPurpleFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTPurpleKindString withValue:(id)_kindString];
        _signatures = map(_signatures, λ(id x, [QTPurpleSignature fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTTypeElement fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTentacledChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTentacledChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTentacledChild.properties.allValues] mutableCopy];

    for (id jsonName in QTTentacledChild.properties) {
        id propertyName = QTTentacledChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"signatures": NSNullify(map(_signatures, λ(id x, [x JSONDictionary]))),
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
        @"type": NSNullify([_type isKindOfClass:NSNull.class] ? nil : [_type JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTPurpleComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"shortText": @"shortText",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleComment alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"shortText"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPurpleComment.properties.allValues];
}
@end

@implementation QTPurpleFlags
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"isExported": @"isExported",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleFlags alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTPurpleFlags.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleFlags.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPurpleFlags.properties.allValues];
}
@end

@implementation QTPurpleSignature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"parameters": @"parameters",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleSignature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"parameters"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTPurpleComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTSignatureKindString withValue:(id)_kindString];
        _parameters = map(_parameters, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _type = [QTTentacledType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleSignature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleSignature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleSignature.properties.allValues] mutableCopy];

    for (id jsonName in QTPurpleSignature.properties) {
        id propertyName = QTPurpleSignature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"parameters": map(_parameters, λ(id x, [x JSONDictionary])),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTGetSignatureFlags
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGetSignatureFlags alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTGetSignatureFlags.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGetSignatureFlags.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGetSignatureFlags.properties.allValues];
}
@end

@implementation QTGetSignatureType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"elementType": @"elementType",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGetSignatureType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTGetSignature fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _elementType = [QTElementType fromJSONDictionary:(id)_elementType];
        if (!_elementType && dict[@"elementType"] && ![dict[@"elementType"] isKindOfClass:NSNull.class]) return nil;
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGetSignatureType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGetSignatureType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGetSignatureType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"elementType": NSNullify([_elementType isKindOfClass:NSNull.class] ? nil : [_elementType JSONDictionary]),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTIndexSignatureElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"parameters": @"parameters",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndexSignatureElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _parameters = map(_parameters, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _type = [QTPurpleType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndexSignatureElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndexSignatureElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndexSignatureElement.properties.allValues] mutableCopy];

    for (id jsonName in QTIndexSignatureElement.properties) {
        id propertyName = QTIndexSignatureElement.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"flags": [_flags JSONDictionary],
        @"parameters": NSNullify(map(_parameters, λ(id x, [x JSONDictionary]))),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTPurpleType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTGetSignature fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTGetSignatureChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"sources": @"sources",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGetSignatureChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTFluffyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTFluffyFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTPurpleKindString withValue:(id)_kindString];
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTPurpleType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGetSignatureChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGetSignatureChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGetSignatureChild.properties.allValues] mutableCopy];

    for (id jsonName in QTGetSignatureChild.properties) {
        id propertyName = QTGetSignatureChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTGetSignature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"comment": @"comment",
        @"defaultValue": @"defaultValue",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"parameters": @"parameters",
        @"signatures": @"signatures",
        @"sources": @"sources",
        @"type": @"type",
        @"typeParameter": @"typeParameter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGetSignature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTGetSignatureChild fromJSONDictionary:x]));
        _comment = [QTGetSignatureComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _parameters = map(_parameters, λ(id x, [QTGetSignatureParameter fromJSONDictionary:x]));
        _signatures = map(_signatures, λ(id x, [QTIndexSignatureElement fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTGetSignatureType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
        _typeParameter = map(_typeParameter, λ(id x, [QTGetSignature fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGetSignature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGetSignature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGetSignature.properties.allValues] mutableCopy];

    for (id jsonName in QTGetSignature.properties) {
        id propertyName = QTGetSignature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"groups": NSNullify(map(_groups, λ(id x, [x JSONDictionary]))),
        @"parameters": NSNullify(map(_parameters, λ(id x, [x JSONDictionary]))),
        @"signatures": NSNullify(map(_signatures, λ(id x, [x JSONDictionary]))),
        @"sources": NSNullify(map(_sources, λ(id x, [x JSONDictionary]))),
        @"type": NSNullify([_type isKindOfClass:NSNull.class] ? nil : [_type JSONDictionary]),
        @"typeParameter": NSNullify(map(_typeParameter, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTElementType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTElementType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _name = [QTName withValue:(id)_name];
        _type = [QTTypeEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTElementType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTElementType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTElementType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"name": [_name value],
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTFluffyComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyComment alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"text"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFluffyComment.properties.allValues];
}
@end

@implementation QTFluffyFlags
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"isOptional": @"isOptional",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyFlags alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTFluffyFlags.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyFlags.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFluffyFlags.properties.allValues];
}
@end

@implementation QTSource
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"character": @"character",
        @"fileName": @"fileName",
        @"line": @"line",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSource alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"character"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"character"] doubleValue] != [dict[@"character"] longLongValue]) return nil;
        if (![dict[@"fileName"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"line"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"line"] doubleValue] != [dict[@"line"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _fileName = [QTFileName withValue:(id)_fileName];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSource.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSource.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSource.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"fileName": [_fileName value],
    }];

    return dict;
}
@end

@implementation QTGetSignatureComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"returns": @"returns",
        @"shortText": @"shortText",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGetSignatureComment alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTGetSignatureComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGetSignatureComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGetSignatureComment.properties.allValues];
}
@end

@implementation QTGroup
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"kind": @"kind",
        @"title": @"title",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGroup alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"children"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
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

@implementation QTGetSignatureParameter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGetSignatureParameter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTTentacledComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTTentacledFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTParameterKindString withValue:(id)_kindString];
        _type = [QTFluffyType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGetSignatureParameter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGetSignatureParameter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGetSignatureParameter.properties.allValues] mutableCopy];

    for (id jsonName in QTGetSignatureParameter.properties) {
        id propertyName = QTGetSignatureParameter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTTentacledComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"shortText": @"shortText",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTentacledComment alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTTentacledComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTentacledComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTentacledComment.properties.allValues];
}
@end

@implementation QTTentacledFlags
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"isOptional": @"isOptional",
        @"isRest": @"isREST",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTentacledFlags alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTTentacledFlags.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTentacledFlags.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTentacledFlags.properties.allValues] mutableCopy];

    for (id jsonName in QTTentacledFlags.properties) {
        id propertyName = QTTentacledFlags.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFluffyType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"elementType": @"elementType",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _elementType = [QTElementType fromJSONDictionary:(id)_elementType];
        if (!_elementType && dict[@"elementType"] && ![dict[@"elementType"] isKindOfClass:NSNull.class]) return nil;
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTElementType fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"elementType": NSNullify([_elementType isKindOfClass:NSNull.class] ? nil : [_elementType JSONDictionary]),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTTentacledType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTentacledType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTPurpleDeclaration fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTentacledType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTentacledType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTentacledType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTPurpleDeclaration
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleDeclaration alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"children"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"groups"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleDeclaration.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleDeclaration.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleDeclaration.properties.allValues] mutableCopy];

    for (id jsonName in QTPurpleDeclaration.properties) {
        id propertyName = QTPurpleDeclaration.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": map(_children, λ(id x, [x JSONDictionary])),
        @"flags": [_flags JSONDictionary],
        @"groups": map(_groups, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTTypeElement
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"elementType": @"elementType",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypeElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTGetSignature fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _elementType = [QTElementType fromJSONDictionary:(id)_elementType];
        if (!_elementType && dict[@"elementType"] && ![dict[@"elementType"] isKindOfClass:NSNull.class]) return nil;
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTElementType fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypeElement.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypeElement.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTypeElement.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"elementType": NSNullify([_elementType isKindOfClass:NSNull.class] ? nil : [_elementType JSONDictionary]),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTStickyComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"returns": @"returns",
        @"shortText": @"shortText",
        @"tags": @"tags",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStickyComment alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _tags = map(_tags, λ(id x, [QTTag fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStickyComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStickyComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStickyComment.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"tags": NSNullify(map(_tags, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTTag
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"tag": @"tag",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTag alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"tag"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"text"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTag.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTag.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTag.properties.allValues];
}
@end

@implementation QTStickyFlags
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"isAbstract": @"isAbstract",
        @"isConstructorProperty": @"isConstructorProperty",
        @"isExported": @"isExported",
        @"isPrivate": @"isPrivate",
        @"isProtected": @"isProtected",
        @"isPublic": @"isPublic",
        @"isStatic": @"isStatic",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStickyFlags alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTStickyFlags.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStickyFlags.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTStickyFlags.properties.allValues];
}
@end

@implementation QTExtendedBy
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"constraint": @"constraint",
        @"id": @"identifier",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExtendedBy alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _constraint = [QTExtendedBy fromJSONDictionary:(id)_constraint];
        if (!_constraint && dict[@"constraint"] && ![dict[@"constraint"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExtendedBy.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExtendedBy.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTExtendedBy.properties.allValues] mutableCopy];

    for (id jsonName in QTExtendedBy.properties) {
        id propertyName = QTExtendedBy.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"constraint": NSNullify([_constraint isKindOfClass:NSNull.class] ? nil : [_constraint JSONDictionary]),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTFluffySignature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"implementationOf": @"implementationOf",
        @"inheritedFrom": @"inheritedFrom",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"overwrites": @"overwrites",
        @"parameters": @"parameters",
        @"type": @"type",
        @"typeParameter": @"typeParameter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffySignature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTStickyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTIndigoFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _implementationOf = [QTExtendedBy fromJSONDictionary:(id)_implementationOf];
        if (!_implementationOf && dict[@"implementationOf"] && ![dict[@"implementationOf"] isKindOfClass:NSNull.class]) return nil;
        _inheritedFrom = [QTExtendedBy fromJSONDictionary:(id)_inheritedFrom];
        if (!_inheritedFrom && dict[@"inheritedFrom"] && ![dict[@"inheritedFrom"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTSignatureKindString withValue:(id)_kindString];
        _overwrites = [QTExtendedBy fromJSONDictionary:(id)_overwrites];
        if (!_overwrites && dict[@"overwrites"] && ![dict[@"overwrites"] isKindOfClass:NSNull.class]) return nil;
        _parameters = map(_parameters, λ(id x, [QTPurpleParameter fromJSONDictionary:x]));
        _type = [QTExtendedBy fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
        _typeParameter = map(_typeParameter, λ(id x, [QTGetSignature fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffySignature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffySignature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffySignature.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffySignature.properties) {
        id propertyName = QTFluffySignature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"implementationOf": NSNullify([_implementationOf isKindOfClass:NSNull.class] ? nil : [_implementationOf JSONDictionary]),
        @"inheritedFrom": NSNullify([_inheritedFrom isKindOfClass:NSNull.class] ? nil : [_inheritedFrom JSONDictionary]),
        @"kindString": [_kindString value],
        @"overwrites": NSNullify([_overwrites isKindOfClass:NSNull.class] ? nil : [_overwrites JSONDictionary]),
        @"parameters": NSNullify(map(_parameters, λ(id x, [x JSONDictionary]))),
        @"type": [_type JSONDictionary],
        @"typeParameter": NSNullify(map(_typeParameter, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTIndigoFlags
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"isPrivate": @"isPrivate",
        @"isProtected": @"isProtected",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndigoFlags alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTIndigoFlags.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndigoFlags.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIndigoFlags.properties.allValues];
}
@end

@implementation QTPurpleParameter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleParameter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTTentacledComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTParameterKindString withValue:(id)_kindString];
        _type = [QTStickyType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleParameter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleParameter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleParameter.properties.allValues] mutableCopy];

    for (id jsonName in QTPurpleParameter.properties) {
        id propertyName = QTPurpleParameter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTStickyType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"constraint": @"constraint",
        @"declaration": @"declaration",
        @"elementType": @"elementType",
        @"elements": @"elements",
        @"id": @"identifier",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStickyType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _constraint = [QTExtendedBy fromJSONDictionary:(id)_constraint];
        if (!_constraint && dict[@"constraint"] && ![dict[@"constraint"] isKindOfClass:NSNull.class]) return nil;
        _declaration = [QTGetSignature fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _elementType = [QTElementType fromJSONDictionary:(id)_elementType];
        if (!_elementType && dict[@"elementType"] && ![dict[@"elementType"] isKindOfClass:NSNull.class]) return nil;
        _elements = map(_elements, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTElementType fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStickyType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStickyType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStickyType.properties.allValues] mutableCopy];

    for (id jsonName in QTStickyType.properties) {
        id propertyName = QTStickyType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"constraint": NSNullify([_constraint isKindOfClass:NSNull.class] ? nil : [_constraint JSONDictionary]),
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"elementType": NSNullify([_elementType isKindOfClass:NSNull.class] ? nil : [_elementType JSONDictionary]),
        @"elements": NSNullify(map(_elements, λ(id x, [x JSONDictionary]))),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTIndigoType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"constraint": @"constraint",
        @"declaration": @"declaration",
        @"elementType": @"elementType",
        @"elements": @"elements",
        @"id": @"identifier",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
        @"types": @"types",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndigoType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _constraint = [QTExtendedBy fromJSONDictionary:(id)_constraint];
        if (!_constraint && dict[@"constraint"] && ![dict[@"constraint"] isKindOfClass:NSNull.class]) return nil;
        _declaration = [QTFluffyDeclaration fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _elementType = [QTExtendedBy fromJSONDictionary:(id)_elementType];
        if (!_elementType && dict[@"elementType"] && ![dict[@"elementType"] isKindOfClass:NSNull.class]) return nil;
        _elements = map(_elements, λ(id x, [QTElementType fromJSONDictionary:x]));
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTPurpleTypeArgument fromJSONDictionary:x]));
        _types = map(_types, λ(id x, [QTTypeElement fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndigoType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndigoType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndigoType.properties.allValues] mutableCopy];

    for (id jsonName in QTIndigoType.properties) {
        id propertyName = QTIndigoType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"constraint": NSNullify([_constraint isKindOfClass:NSNull.class] ? nil : [_constraint JSONDictionary]),
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"elementType": NSNullify([_elementType isKindOfClass:NSNull.class] ? nil : [_elementType JSONDictionary]),
        @"elements": NSNullify(map(_elements, λ(id x, [x JSONDictionary]))),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
        @"types": NSNullify(map(_types, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTFluffyDeclaration
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"indexSignature": @"indexSignature",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"signatures": @"signatures",
        @"sources": @"sources",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyDeclaration alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTStickyChild fromJSONDictionary:x]));
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _indexSignature = [QTIndexSignature fromJSONDictionary:(id)_indexSignature];
        if (!_indexSignature && dict[@"indexSignature"] && ![dict[@"indexSignature"] isKindOfClass:NSNull.class]) return nil;
        _signatures = map(_signatures, λ(id x, [QTTentacledSignature fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyDeclaration.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyDeclaration.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyDeclaration.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffyDeclaration.properties) {
        id propertyName = QTFluffyDeclaration.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"flags": [_flags JSONDictionary],
        @"groups": NSNullify(map(_groups, λ(id x, [x JSONDictionary]))),
        @"indexSignature": NSNullify([_indexSignature isKindOfClass:NSNull.class] ? nil : [_indexSignature JSONDictionary]),
        @"signatures": NSNullify(map(_signatures, λ(id x, [x JSONDictionary]))),
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTStickyChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"sources": @"sources",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStickyChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTFluffyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTFluffyFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTPurpleKindString withValue:(id)_kindString];
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTIndecentType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStickyChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStickyChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStickyChild.properties.allValues] mutableCopy];

    for (id jsonName in QTStickyChild.properties) {
        id propertyName = QTStickyChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTIndecentType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"elements": @"elements",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndecentType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTGetSignature fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _elements = map(_elements, λ(id x, [QTElementType fromJSONDictionary:x]));
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndecentType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndecentType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndecentType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"elements": NSNullify(map(_elements, λ(id x, [x JSONDictionary]))),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTIndexSignature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"parameters": @"parameters",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndexSignature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"parameters"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _parameters = map(_parameters, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _type = [QTHilariousType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndexSignature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndexSignature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndexSignature.properties.allValues] mutableCopy];

    for (id jsonName in QTIndexSignature.properties) {
        id propertyName = QTIndexSignature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"flags": [_flags JSONDictionary],
        @"parameters": map(_parameters, λ(id x, [x JSONDictionary])),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTHilariousType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHilariousType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"declaration"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTGetSignature fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTHilariousType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHilariousType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTHilariousType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"declaration": [_declaration JSONDictionary],
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTTentacledSignature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"parameters": @"parameters",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTentacledSignature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTIndigoComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTSignatureKindString withValue:(id)_kindString];
        _parameters = map(_parameters, λ(id x, [QTFluffyParameter fromJSONDictionary:x]));
        _type = [QTExtendedBy fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTentacledSignature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTentacledSignature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTentacledSignature.properties.allValues] mutableCopy];

    for (id jsonName in QTTentacledSignature.properties) {
        id propertyName = QTTentacledSignature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"parameters": NSNullify(map(_parameters, λ(id x, [x JSONDictionary]))),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTIndigoComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"returns": @"returns",
        @"shortText": @"shortText",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndigoComment alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"returns"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"shortText"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndigoComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndigoComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIndigoComment.properties.allValues];
}
@end

@implementation QTFluffyParameter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"sources": @"sources",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyParameter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTFluffyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTFluffyFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTElementType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyParameter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyParameter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyParameter.properties.allValues] mutableCopy];

    for (id jsonName in QTFluffyParameter.properties) {
        id propertyName = QTFluffyParameter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"sources": NSNullify(map(_sources, λ(id x, [x JSONDictionary]))),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTPurpleTypeArgument
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"operator": @"operator",
        @"target": @"target",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPurpleTypeArgument alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"operator"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"target"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _target = [QTElementType fromJSONDictionary:(id)_target];
        if (!_target && dict[@"target"] && ![dict[@"target"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPurpleTypeArgument.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPurpleTypeArgument.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPurpleTypeArgument.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"target": [_target JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTIndecentFlags
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"hasExportAssignment": @"hasExportAssignment",
        @"isAbstract": @"isAbstract",
        @"isConst": @"isConst",
        @"isExported": @"isExported",
        @"isLet": @"isLet",
        @"isPrivate": @"isPrivate",
        @"isProtected": @"isProtected",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndecentFlags alloc] initWithJSONDictionary:dict] : nil;
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
    id resolved = QTIndecentFlags.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndecentFlags.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIndecentFlags.properties.allValues];
}
@end

@implementation QTStickySignature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"parameters": @"parameters",
        @"type": @"type",
        @"typeParameter": @"typeParameter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStickySignature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"comment"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTStickyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTIndigoFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTSignatureKindString withValue:(id)_kindString];
        _parameters = map(_parameters, λ(id x, [QTTentacledParameter fromJSONDictionary:x]));
        _type = [QTCunningType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
        _typeParameter = map(_typeParameter, λ(id x, [QTGetSignature fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStickySignature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStickySignature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStickySignature.properties.allValues] mutableCopy];

    for (id jsonName in QTStickySignature.properties) {
        id propertyName = QTStickySignature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": [_comment JSONDictionary],
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"parameters": NSNullify(map(_parameters, λ(id x, [x JSONDictionary]))),
        @"type": [_type JSONDictionary],
        @"typeParameter": NSNullify(map(_typeParameter, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTTentacledParameter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"defaultValue": @"defaultValue",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"originalName": @"originalName",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTentacledParameter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTTentacledComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTTentacledFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTParameterKindString withValue:(id)_kindString];
        _type = [QTAmbitiousType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTentacledParameter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTentacledParameter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTentacledParameter.properties.allValues] mutableCopy];

    for (id jsonName in QTTentacledParameter.properties) {
        id propertyName = QTTentacledParameter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTAmbitiousType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"elementType": @"elementType",
        @"id": @"identifier",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAmbitiousType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTTentacledDeclaration fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _elementType = [QTElementType fromJSONDictionary:(id)_elementType];
        if (!_elementType && dict[@"elementType"] && ![dict[@"elementType"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTElementType fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAmbitiousType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAmbitiousType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAmbitiousType.properties.allValues] mutableCopy];

    for (id jsonName in QTAmbitiousType.properties) {
        id propertyName = QTAmbitiousType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"elementType": NSNullify([_elementType isKindOfClass:NSNull.class] ? nil : [_elementType JSONDictionary]),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTTentacledDeclaration
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"indexSignature": @"indexSignature",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"signatures": @"signatures",
        @"sources": @"sources",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTentacledDeclaration alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTIndigoChild fromJSONDictionary:x]));
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _indexSignature = [QTIndexSignatureElement fromJSONDictionary:(id)_indexSignature];
        if (!_indexSignature && dict[@"indexSignature"] && ![dict[@"indexSignature"] isKindOfClass:NSNull.class]) return nil;
        _signatures = map(_signatures, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTentacledDeclaration.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTentacledDeclaration.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTentacledDeclaration.properties.allValues] mutableCopy];

    for (id jsonName in QTTentacledDeclaration.properties) {
        id propertyName = QTTentacledDeclaration.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"flags": [_flags JSONDictionary],
        @"groups": NSNullify(map(_groups, λ(id x, [x JSONDictionary]))),
        @"indexSignature": NSNullify([_indexSignature isKindOfClass:NSNull.class] ? nil : [_indexSignature JSONDictionary]),
        @"signatures": NSNullify(map(_signatures, λ(id x, [x JSONDictionary]))),
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTIndigoChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"defaultValue": @"defaultValue",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"sources": @"sources",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndigoChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"comment"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTFluffyComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTFluffyFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTPurpleKindString withValue:(id)_kindString];
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTIndecentType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndigoChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndigoChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndigoChild.properties.allValues] mutableCopy];

    for (id jsonName in QTIndigoChild.properties) {
        id propertyName = QTIndigoChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": [_comment JSONDictionary],
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCunningType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"id": @"identifier",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCunningType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTPurpleDeclaration fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTElementType fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCunningType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCunningType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCunningType.properties.allValues] mutableCopy];

    for (id jsonName in QTCunningType.properties) {
        id propertyName = QTCunningType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTMagentaType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"elementType": @"elementType",
        @"elements": @"elements",
        @"id": @"identifier",
        @"name": @"name",
        @"type": @"type",
        @"typeArguments": @"typeArguments",
        @"types": @"types",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMagentaType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTStickyDeclaration fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _elementType = [QTElementType fromJSONDictionary:(id)_elementType];
        if (!_elementType && dict[@"elementType"] && ![dict[@"elementType"] isKindOfClass:NSNull.class]) return nil;
        _elements = map(_elements, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
        _type = [QTTypeEnum withValue:(id)_type];
        _typeArguments = map(_typeArguments, λ(id x, [QTFluffyTypeArgument fromJSONDictionary:x]));
        _types = map(_types, λ(id x, [QTExtendedBy fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMagentaType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMagentaType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMagentaType.properties.allValues] mutableCopy];

    for (id jsonName in QTMagentaType.properties) {
        id propertyName = QTMagentaType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"elementType": NSNullify([_elementType isKindOfClass:NSNull.class] ? nil : [_elementType JSONDictionary]),
        @"elements": NSNullify(map(_elements, λ(id x, [x JSONDictionary]))),
        @"type": [_type value],
        @"typeArguments": NSNullify(map(_typeArguments, λ(id x, [x JSONDictionary]))),
        @"types": NSNullify(map(_types, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

@implementation QTStickyDeclaration
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"signatures": @"signatures",
        @"sources": @"sources",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStickyDeclaration alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"signatures"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTIndecentChild fromJSONDictionary:x]));
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _signatures = map(_signatures, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStickyDeclaration.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStickyDeclaration.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStickyDeclaration.properties.allValues] mutableCopy];

    for (id jsonName in QTStickyDeclaration.properties) {
        id propertyName = QTStickyDeclaration.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"flags": [_flags JSONDictionary],
        @"groups": NSNullify(map(_groups, λ(id x, [x JSONDictionary]))),
        @"signatures": map(_signatures, λ(id x, [x JSONDictionary])),
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTIndecentChild
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"sources": @"sources",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndecentChild alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _flags = [QTFluffyFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _kindString = [QTPurpleKindString withValue:(id)_kindString];
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
        _type = [QTFriskyType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndecentChild.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndecentChild.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndecentChild.properties.allValues] mutableCopy];

    for (id jsonName in QTIndecentChild.properties) {
        id propertyName = QTIndecentChild.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"flags": [_flags JSONDictionary],
        @"kindString": [_kindString value],
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFriskyType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declaration": @"declaration",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFriskyType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _declaration = [QTIndigoDeclaration fromJSONDictionary:(id)_declaration];
        if (!_declaration && dict[@"declaration"] && ![dict[@"declaration"] isKindOfClass:NSNull.class]) return nil;
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTTypeEnum withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFriskyType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFriskyType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFriskyType.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"declaration": NSNullify([_declaration isKindOfClass:NSNull.class] ? nil : [_declaration JSONDictionary]),
        @"name": NSNullify([_name value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

@implementation QTIndigoDeclaration
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"children": @"children",
        @"flags": @"flags",
        @"groups": @"groups",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"signatures": @"signatures",
        @"sources": @"sources",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndigoDeclaration alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sources"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _children = map(_children, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _groups = map(_groups, λ(id x, [QTGroup fromJSONDictionary:x]));
        _signatures = map(_signatures, λ(id x, [QTGetSignature fromJSONDictionary:x]));
        _sources = map(_sources, λ(id x, [QTSource fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndigoDeclaration.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndigoDeclaration.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndigoDeclaration.properties.allValues] mutableCopy];

    for (id jsonName in QTIndigoDeclaration.properties) {
        id propertyName = QTIndigoDeclaration.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"children": NSNullify(map(_children, λ(id x, [x JSONDictionary]))),
        @"flags": [_flags JSONDictionary],
        @"groups": NSNullify(map(_groups, λ(id x, [x JSONDictionary]))),
        @"signatures": NSNullify(map(_signatures, λ(id x, [x JSONDictionary]))),
        @"sources": map(_sources, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTFluffyTypeArgument
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"type": @"type",
        @"types": @"types",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFluffyTypeArgument alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"types"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _type = [QTTypeEnum withValue:(id)_type];
        _types = map(_types, λ(id x, [QTElementType fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFluffyTypeArgument.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFluffyTypeArgument.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFluffyTypeArgument.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"type": [_type value],
        @"types": map(_types, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTTypeParameter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"comment": @"comment",
        @"flags": @"flags",
        @"id": @"identifier",
        @"kind": @"kind",
        @"kindString": @"kindString",
        @"name": @"name",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypeParameter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"flags"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        if (![dict[@"kind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"kind"] doubleValue] != [dict[@"kind"] longLongValue]) return nil;
        if (![dict[@"kindString"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _comment = [QTPurpleComment fromJSONDictionary:(id)_comment];
        if (!_comment && dict[@"comment"] && ![dict[@"comment"] isKindOfClass:NSNull.class]) return nil;
        _flags = [QTGetSignatureFlags fromJSONDictionary:(id)_flags];
        if (!_flags && dict[@"flags"] && ![dict[@"flags"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTMischievousType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypeParameter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypeParameter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTypeParameter.properties.allValues] mutableCopy];

    for (id jsonName in QTTypeParameter.properties) {
        id propertyName = QTTypeParameter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"comment": NSNullify([_comment isKindOfClass:NSNull.class] ? nil : [_comment JSONDictionary]),
        @"flags": [_flags JSONDictionary],
        @"type": NSNullify([_type isKindOfClass:NSNull.class] ? nil : [_type JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTMischievousType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"name": @"name",
        @"operator": @"operator",
        @"target": @"target",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMischievousType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _name = [QTName withValue:(id)_name];
        if (_name == nil && dict[@"name"] && ![dict[@"name"] isKindOfClass:NSNull.class]) return nil;
        _target = [QTElementType fromJSONDictionary:(id)_target];
        if (!_target && dict[@"target"] && ![dict[@"target"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMischievousType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMischievousType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMischievousType.properties.allValues] mutableCopy];

    for (id jsonName in QTMischievousType.properties) {
        id propertyName = QTMischievousType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"name": NSNullify([_name value]),
        @"target": NSNullify([_target isKindOfClass:NSNull.class] ? nil : [_target JSONDictionary]),
    }];

    return dict;
}
@end

@implementation QTIndecentComment
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"shortText": @"shortText",
        @"tags": @"tags",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndecentComment alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"shortText"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _tags = map(_tags, λ(id x, [QTTag fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndecentComment.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndecentComment.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIndecentComment.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"tags": NSNullify(map(_tags, λ(id x, [x JSONDictionary]))),
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
