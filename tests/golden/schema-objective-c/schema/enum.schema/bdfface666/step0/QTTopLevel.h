// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTOtherArr;
@class QTGve;
@class QTLvc;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTOtherArr : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTOtherArr *)foo;
+ (QTOtherArr *)bar;
+ (QTOtherArr *)otherArrIf;
@end

@interface QTGve : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGve *)good;
+ (QTGve *)neutral;
+ (QTGve *)evil;
@end

@interface QTLvc : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLvc *)lawful;
+ (QTLvc *)neutral;
+ (QTLvc *)chaotic;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, nullable, copy)   NSArray<id> *arr;
@property (nonatomic, nullable, copy)   NSString *qtTopLevelFor;
@property (nonatomic, assign)           QTGve *gve;
@property (nonatomic, nullable, assign) QTLvc *lvc;
@property (nonatomic, nullable, copy)   NSArray<QTOtherArr *> *otherArr;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

NS_ASSUME_NONNULL_END
