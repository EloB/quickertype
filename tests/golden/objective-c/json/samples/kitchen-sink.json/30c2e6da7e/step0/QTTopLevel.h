// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTDifferentThingClass;
@class QTPersonElement;
@class QTPurplePerson;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)           NSString *dateValue;
@property (nonatomic, copy)           NSArray<id> *differentThings;
@property (nonatomic, assign)         double doubleValue;
@property (nonatomic, assign)         NSInteger intValue;
@property (nonatomic, assign)         BOOL isBooleanValue;
@property (nonatomic, copy)           NSDictionary<NSString *, NSNumber *> *mapValue;
@property (nonatomic, nullable, copy) id nameWithSpaces;
@property (nonatomic, nullable, copy) id nullValue;
@property (nonatomic, copy)           NSDictionary<NSString *, NSNumber *> *nullableMapValue;
@property (nonatomic, copy)           NSArray<QTPersonElement *> *people;
@property (nonatomic, strong)         QTPurplePerson *person;
@property (nonatomic, copy)           NSString *stringValue;
@property (nonatomic, copy)           NSArray<NSArray<id> *> *tuples;
@property (nonatomic, copy)           NSString *uuidValue;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTDifferentThingClass : NSObject
@property (nonatomic, copy) NSString *name;
@end

@interface QTPersonElement : NSObject
@property (nonatomic, copy)             id intOrString;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, strong) NSNumber *optionalValue;
@end

@interface QTPurplePerson : NSObject
@property (nonatomic, assign) NSInteger intOrString;
@property (nonatomic, copy)   NSString *name;
@end

NS_ASSUME_NONNULL_END
