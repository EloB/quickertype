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

@interface QTTx (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInput (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOut (JSONConversion)
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
        @"txs": @"txs",
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
        if (![dict[@"txs"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _txs = map(_txs, λ(id x, [QTTx fromJSONDictionary:x]));
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
        @"txs": map(_txs, λ(id x, [x JSONDictionary])),
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

@implementation QTTx
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"inputs": @"inputs",
        @"double_spend": @"isDoubleSpend",
        @"lock_time": @"lockTime",
        @"out": @"out",
        @"relayed_by": @"relayedBy",
        @"size": @"size",
        @"hash": @"theHash",
        @"time": @"time",
        @"tx_index": @"txIndex",
        @"ver": @"ver",
        @"vin_sz": @"vinSz",
        @"vout_sz": @"voutSz",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTx alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"inputs"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"double_spend"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"lock_time"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"lock_time"] doubleValue] != [dict[@"lock_time"] longLongValue]) return nil;
        if (![dict[@"out"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"relayed_by"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"size"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"size"] doubleValue] != [dict[@"size"] longLongValue]) return nil;
        if (![dict[@"hash"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"time"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"time"] doubleValue] != [dict[@"time"] longLongValue]) return nil;
        if (![dict[@"tx_index"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tx_index"] doubleValue] != [dict[@"tx_index"] longLongValue]) return nil;
        if (![dict[@"ver"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ver"] doubleValue] != [dict[@"ver"] longLongValue]) return nil;
        if (![dict[@"vin_sz"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"vin_sz"] doubleValue] != [dict[@"vin_sz"] longLongValue]) return nil;
        if (![dict[@"vout_sz"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"vout_sz"] doubleValue] != [dict[@"vout_sz"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _inputs = map(_inputs, λ(id x, [QTInput fromJSONDictionary:x]));
        _out = map(_out, λ(id x, [QTOut fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTx.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTx.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTx.properties.allValues] mutableCopy];

    for (id jsonName in QTTx.properties) {
        id propertyName = QTTx.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"inputs": map(_inputs, λ(id x, [x JSONDictionary])),
        @"double_spend": _isDoubleSpend ? @YES : @NO,
        @"out": map(_out, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTInput
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"prev_out": @"prevOut",
        @"script": @"script",
        @"sequence": @"sequence",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInput alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"prev_out"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"script"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"sequence"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sequence"] doubleValue] != [dict[@"sequence"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _prevOut = [QTOut fromJSONDictionary:(id)_prevOut];
        if (!_prevOut && dict[@"prev_out"] && ![dict[@"prev_out"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInput.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInput.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTInput.properties.allValues] mutableCopy];

    for (id jsonName in QTInput.properties) {
        id propertyName = QTInput.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"prev_out": [_prevOut JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTOut
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"addr": @"addr",
        @"spent": @"isSpent",
        @"n": @"n",
        @"script": @"script",
        @"tx_index": @"txIndex",
        @"type": @"type",
        @"value": @"value",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOut alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"addr"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"spent"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"n"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"n"] doubleValue] != [dict[@"n"] longLongValue]) return nil;
        if (![dict[@"script"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"tx_index"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"tx_index"] doubleValue] != [dict[@"tx_index"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"type"] doubleValue] != [dict[@"type"] longLongValue]) return nil;
        if (![dict[@"value"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"value"] doubleValue] != [dict[@"value"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOut.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOut.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOut.properties.allValues] mutableCopy];

    for (id jsonName in QTOut.properties) {
        id propertyName = QTOut.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"spent": _isSpent ? @YES : @NO,
    }];

    return dict;
}
@end

NS_ASSUME_NONNULL_END
