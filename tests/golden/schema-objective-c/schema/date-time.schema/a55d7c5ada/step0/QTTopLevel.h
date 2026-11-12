// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTComplexUnionArrayEnum;
@class QTLocalDate;
@class QTOffsetDateTime;
@class QTOffsetTime;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTComplexUnionArrayEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTComplexUnionArrayEnum *)foo;
+ (QTComplexUnionArrayEnum *)bar;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)             NSArray<id> *complexUnionArray;
@property (nonatomic, copy)             NSString *date;
@property (nonatomic, copy)             NSString *dateTime;
@property (nonatomic, nullable, strong) QTLocalDate *localDateClass;
@property (nonatomic, nullable, strong) QTOffsetDateTime *offsetDateTimeClass;
@property (nonatomic, nullable, strong) QTOffsetTime *offsetTimeClass;
@property (nonatomic, copy)             NSString *time;
@property (nonatomic, copy)             NSArray<NSString *> *unionArray;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTLocalDate : NSObject
@end

@interface QTOffsetDateTime : NSObject
@end

@interface QTOffsetTime : NSObject
@end

NS_ASSUME_NONNULL_END
