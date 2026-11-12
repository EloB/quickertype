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

@interface QTIdentifier (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLink (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOtherName (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTText (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTScheme
+ (NSDictionary<NSString *, QTScheme *> *)values
{
    static NSDictionary<NSString *, QTScheme *> *values;
    return values = values ? values : @{
        @"SPDX": [[QTScheme alloc] initWithValue:@"SPDX"],
        @"Trove": [[QTScheme alloc] initWithValue:@"Trove"],
        @"DEP5": [[QTScheme alloc] initWithValue:@"DEP5"],
    };
}

+ (QTScheme *)spdx { return QTScheme.values[@"SPDX"]; }
+ (QTScheme *)trove { return QTScheme.values[@"Trove"]; }
+ (QTScheme *)dep5 { return QTScheme.values[@"DEP5"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTScheme.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTKeyword
+ (NSDictionary<NSString *, QTKeyword *> *)values
{
    static NSDictionary<NSString *, QTKeyword *> *values;
    return values = values ? values : @{
        @"osi-approved": [[QTKeyword alloc] initWithValue:@"osi-approved"],
        @"discouraged": [[QTKeyword alloc] initWithValue:@"discouraged"],
        @"redundant": [[QTKeyword alloc] initWithValue:@"redundant"],
        @"miscellaneous": [[QTKeyword alloc] initWithValue:@"miscellaneous"],
        @"non-reusable": [[QTKeyword alloc] initWithValue:@"non-reusable"],
        @"obsolete": [[QTKeyword alloc] initWithValue:@"obsolete"],
        @"popular": [[QTKeyword alloc] initWithValue:@"popular"],
        @"permissive": [[QTKeyword alloc] initWithValue:@"permissive"],
        @"retired": [[QTKeyword alloc] initWithValue:@"retired"],
        @"special-purpose": [[QTKeyword alloc] initWithValue:@"special-purpose"],
        @"copyleft": [[QTKeyword alloc] initWithValue:@"copyleft"],
        @"international": [[QTKeyword alloc] initWithValue:@"international"],
    };
}

+ (QTKeyword *)osiApproved { return QTKeyword.values[@"osi-approved"]; }
+ (QTKeyword *)discouraged { return QTKeyword.values[@"discouraged"]; }
+ (QTKeyword *)redundant { return QTKeyword.values[@"redundant"]; }
+ (QTKeyword *)miscellaneous { return QTKeyword.values[@"miscellaneous"]; }
+ (QTKeyword *)nonReusable { return QTKeyword.values[@"non-reusable"]; }
+ (QTKeyword *)obsolete { return QTKeyword.values[@"obsolete"]; }
+ (QTKeyword *)popular { return QTKeyword.values[@"popular"]; }
+ (QTKeyword *)permissive { return QTKeyword.values[@"permissive"]; }
+ (QTKeyword *)retired { return QTKeyword.values[@"retired"]; }
+ (QTKeyword *)specialPurpose { return QTKeyword.values[@"special-purpose"]; }
+ (QTKeyword *)copyleft { return QTKeyword.values[@"copyleft"]; }
+ (QTKeyword *)international { return QTKeyword.values[@"international"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTKeyword.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTNote
+ (NSDictionary<NSString *, QTNote *> *)values
{
    static NSDictionary<NSString *, QTNote *> *values;
    return values = values ? values : @{
        @"OSI Page": [[QTNote alloc] initWithValue:@"OSI Page"],
        @"tl;dr legal": [[QTNote alloc] initWithValue:@"tl;dr legal"],
        @"Wikipedia page": [[QTNote alloc] initWithValue:@"Wikipedia page"],
        @"Wikipedia Page": [[QTNote alloc] initWithValue:@"Wikipedia Page"],
        @"Mozilla Page": [[QTNote alloc] initWithValue:@"Mozilla Page"],
        @"OSET Foundation Page": [[QTNote alloc] initWithValue:@"OSET Foundation Page"],
    };
}

+ (QTNote *)osiPage { return QTNote.values[@"OSI Page"]; }
+ (QTNote *)tlDRLegal { return QTNote.values[@"tl;dr legal"]; }
+ (QTNote *)wikipediaPage { return QTNote.values[@"Wikipedia page"]; }
+ (QTNote *)noteWikipediaPage { return QTNote.values[@"Wikipedia Page"]; }
+ (QTNote *)mozillaPage { return QTNote.values[@"Mozilla Page"]; }
+ (QTNote *)osetFoundationPage { return QTNote.values[@"OSET Foundation Page"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTNote.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTMediaType
+ (NSDictionary<NSString *, QTMediaType *> *)values
{
    static NSDictionary<NSString *, QTMediaType *> *values;
    return values = values ? values : @{
        @"text/html": [[QTMediaType alloc] initWithValue:@"text/html"],
        @"text/plain": [[QTMediaType alloc] initWithValue:@"text/plain"],
        @"application/pdf": [[QTMediaType alloc] initWithValue:@"application/pdf"],
    };
}

+ (QTMediaType *)textHTML { return QTMediaType.values[@"text/html"]; }
+ (QTMediaType *)textPlain { return QTMediaType.values[@"text/plain"]; }
+ (QTMediaType *)applicationPDF { return QTMediaType.values[@"application/pdf"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTMediaType.values[value];
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
        @"HTML": [[QTTitle alloc] initWithValue:@"HTML"],
        @"Plain Text": [[QTTitle alloc] initWithValue:@"Plain Text"],
        @"PDF": [[QTTitle alloc] initWithValue:@"PDF"],
    };
}

+ (QTTitle *)html { return QTTitle.values[@"HTML"]; }
+ (QTTitle *)plainText { return QTTitle.values[@"Plain Text"]; }
+ (QTTitle *)pdf { return QTTitle.values[@"PDF"]; }

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
        @"id": @"identifier",
        @"identifiers": @"identifiers",
        @"keywords": @"keywords",
        @"links": @"links",
        @"name": @"name",
        @"other_names": @"otherNames",
        @"superseded_by": @"supersededBy",
        @"text": @"text",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"identifiers"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"keywords"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"links"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"other_names"] isKindOfClass:NSArray.class]) return nil;
        if (!dict[@"superseded_by"]) return nil;
        if (![dict[@"text"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _identifiers = map(_identifiers, λ(id x, [QTIdentifier fromJSONDictionary:x]));
        _keywords = map(_keywords, λ(id x, [QTKeyword withValue:x]));
        _links = map(_links, λ(id x, [QTLink fromJSONDictionary:x]));
        _otherNames = map(_otherNames, λ(id x, [QTOtherName fromJSONDictionary:x]));
        _text = map(_text, λ(id x, [QTText fromJSONDictionary:x]));
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
        @"identifiers": map(_identifiers, λ(id x, [x JSONDictionary])),
        @"keywords": map(_keywords, λ(id x, [x value])),
        @"links": map(_links, λ(id x, [x JSONDictionary])),
        @"other_names": map(_otherNames, λ(id x, [x JSONDictionary])),
        @"text": map(_text, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTIdentifier
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"identifier": @"identifier",
        @"scheme": @"scheme",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIdentifier alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"identifier"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"scheme"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _scheme = [QTScheme withValue:(id)_scheme];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIdentifier.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIdentifier.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIdentifier.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"scheme": [_scheme value],
    }];

    return dict;
}
@end

@implementation QTLink
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"note": @"note",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLink alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"note"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _note = [QTNote withValue:(id)_note];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLink.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLink.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLink.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"note": [_note value],
    }];

    return dict;
}
@end

@implementation QTOtherName
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
        @"note": @"note",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOtherName alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"name"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"note"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOtherName.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOtherName.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOtherName.properties.allValues];
}
@end

@implementation QTText
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"media_type": @"mediaType",
        @"title": @"title",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTText alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"media_type"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _mediaType = [QTMediaType withValue:(id)_mediaType];
        _title = [QTTitle withValue:(id)_title];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTText.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTText.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTText.properties.allValues] mutableCopy];

    for (id jsonName in QTText.properties) {
        id propertyName = QTText.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"media_type": [_mediaType value],
        @"title": [_title value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
