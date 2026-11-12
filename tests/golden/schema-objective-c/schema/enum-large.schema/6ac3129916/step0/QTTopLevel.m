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

@implementation QTCallsign
+ (NSDictionary<NSString *, QTCallsign *> *)values
{
    static NSDictionary<NSString *, QTCallsign *> *values;
    return values = values ? values : @{
        @"alpha": [[QTCallsign alloc] initWithValue:@"alpha"],
        @"bravo": [[QTCallsign alloc] initWithValue:@"bravo"],
        @"charlie": [[QTCallsign alloc] initWithValue:@"charlie"],
        @"delta": [[QTCallsign alloc] initWithValue:@"delta"],
        @"echo": [[QTCallsign alloc] initWithValue:@"echo"],
        @"foxtrot": [[QTCallsign alloc] initWithValue:@"foxtrot"],
        @"golf": [[QTCallsign alloc] initWithValue:@"golf"],
        @"hotel": [[QTCallsign alloc] initWithValue:@"hotel"],
        @"india": [[QTCallsign alloc] initWithValue:@"india"],
        @"juliett": [[QTCallsign alloc] initWithValue:@"juliett"],
        @"kilo": [[QTCallsign alloc] initWithValue:@"kilo"],
        @"lima": [[QTCallsign alloc] initWithValue:@"lima"],
        @"mike": [[QTCallsign alloc] initWithValue:@"mike"],
        @"november": [[QTCallsign alloc] initWithValue:@"november"],
        @"oscar": [[QTCallsign alloc] initWithValue:@"oscar"],
        @"papa": [[QTCallsign alloc] initWithValue:@"papa"],
        @"quebec": [[QTCallsign alloc] initWithValue:@"quebec"],
        @"romeo": [[QTCallsign alloc] initWithValue:@"romeo"],
        @"sierra": [[QTCallsign alloc] initWithValue:@"sierra"],
        @"tango": [[QTCallsign alloc] initWithValue:@"tango"],
    };
}

+ (QTCallsign *)alpha { return QTCallsign.values[@"alpha"]; }
+ (QTCallsign *)bravo { return QTCallsign.values[@"bravo"]; }
+ (QTCallsign *)charlie { return QTCallsign.values[@"charlie"]; }
+ (QTCallsign *)delta { return QTCallsign.values[@"delta"]; }
+ (QTCallsign *)echo { return QTCallsign.values[@"echo"]; }
+ (QTCallsign *)foxtrot { return QTCallsign.values[@"foxtrot"]; }
+ (QTCallsign *)golf { return QTCallsign.values[@"golf"]; }
+ (QTCallsign *)hotel { return QTCallsign.values[@"hotel"]; }
+ (QTCallsign *)india { return QTCallsign.values[@"india"]; }
+ (QTCallsign *)juliett { return QTCallsign.values[@"juliett"]; }
+ (QTCallsign *)kilo { return QTCallsign.values[@"kilo"]; }
+ (QTCallsign *)lima { return QTCallsign.values[@"lima"]; }
+ (QTCallsign *)mike { return QTCallsign.values[@"mike"]; }
+ (QTCallsign *)november { return QTCallsign.values[@"november"]; }
+ (QTCallsign *)oscar { return QTCallsign.values[@"oscar"]; }
+ (QTCallsign *)papa { return QTCallsign.values[@"papa"]; }
+ (QTCallsign *)quebec { return QTCallsign.values[@"quebec"]; }
+ (QTCallsign *)romeo { return QTCallsign.values[@"romeo"]; }
+ (QTCallsign *)sierra { return QTCallsign.values[@"sierra"]; }
+ (QTCallsign *)tango { return QTCallsign.values[@"tango"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTCallsign.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

@implementation QTPriority
+ (NSDictionary<NSString *, QTPriority *> *)values
{
    static NSDictionary<NSString *, QTPriority *> *values;
    return values = values ? values : @{
        @"low": [[QTPriority alloc] initWithValue:@"low"],
        @"medium": [[QTPriority alloc] initWithValue:@"medium"],
        @"high": [[QTPriority alloc] initWithValue:@"high"],
    };
}

+ (QTPriority *)low { return QTPriority.values[@"low"]; }
+ (QTPriority *)medium { return QTPriority.values[@"medium"]; }
+ (QTPriority *)high { return QTPriority.values[@"high"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTPriority.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

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
        @"callsign": @"callsign",
        @"priority": @"priority",
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
        if (![dict[@"callsign"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"priority"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _callsign = [QTCallsign withValue:(id)_callsign];
        _priority = [QTPriority withValue:(id)_priority];
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
        @"callsign": [_callsign value],
        @"priority": [_priority value],
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

NS_ASSUME_NONNULL_END
