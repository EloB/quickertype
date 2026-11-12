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

@interface QTFile (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTLanguage
+ (NSDictionary<NSString *, QTLanguage *> *)values
{
    static NSDictionary<NSString *, QTLanguage *> *values;
    return values = values ? values : @{
        @"Markdown": [[QTLanguage alloc] initWithValue:@"Markdown"],
    };
}

+ (QTLanguage *)markdown { return QTLanguage.values[@"Markdown"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTLanguage.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTType
+ (NSDictionary<NSString *, QTType *> *)values
{
    static NSDictionary<NSString *, QTType *> *values;
    return values = values ? values : @{
        @"text/plain": [[QTType alloc] initWithValue:@"text/plain"],
    };
}

+ (QTType *)textPlain { return QTType.values[@"text/plain"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTType.values[value];
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
        @"comments": @"comments",
        @"comments_url": @"commentsURL",
        @"commits_url": @"commitsURL",
        @"created_at": @"createdAt",
        @"files": @"files",
        @"forks_url": @"forksURL",
        @"git_pull_url": @"gitPullURL",
        @"git_push_url": @"gitPushURL",
        @"html_url": @"htmlURL",
        @"id": @"identifier",
        @"public": @"isPublic",
        @"truncated": @"isTruncated",
        @"description": @"theDescription",
        @"updated_at": @"updatedAt",
        @"url": @"url",
        @"user": @"user",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelElement alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"comments"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"comments"] doubleValue] != [dict[@"comments"] longLongValue]) return nil;
        if (![dict[@"comments_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"commits_url"] isKindOfClass:NSString.class]) return nil;
        if (dict[@"created_at"] && [dict[@"created_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"created_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"files"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"forks_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"git_pull_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"git_push_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"html_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"public"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"truncated"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"description"]) return nil;
        if (dict[@"updated_at"] && [dict[@"updated_at"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"updated_at"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"url"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"user"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _files = map(_files, λ(id x, [QTFile fromJSONDictionary:x]));
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
        @"files": map(_files, λ(id x, [x JSONDictionary])),
        @"public": _isPublic ? @YES : @NO,
        @"truncated": _isTruncated ? @YES : @NO,
    }];

    return dict;
}
@end

@implementation QTFile
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"filename": @"filename",
        @"language": @"language",
        @"raw_url": @"rawURL",
        @"size": @"size",
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFile alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"filename"] isKindOfClass:NSString.class]) return nil;
        if (!dict[@"language"]) return nil;
        if (![dict[@"raw_url"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"size"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"size"] doubleValue] != [dict[@"size"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _language = [QTLanguage withValue:(id)_language];
        if (_language == nil && dict[@"language"] && ![dict[@"language"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType withValue:(id)_type];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFile.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFile.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFile.properties.allValues] mutableCopy];

    for (id jsonName in QTFile.properties) {
        id propertyName = QTFile.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"language": NSNullify([_language value]),
        @"type": [_type value],
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
