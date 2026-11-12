// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTPurpleQTTopLevel;
@class QTCountry;
@class QTID;
@class QTValue;
@class QTFluffyQTTopLevel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTID : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTID *)in;
+ (QTID *)spPopTotl;
@end

@interface QTValue : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTValue *)india;
+ (QTValue *)populationTotal;
@end

typedef NSArray<id> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTPurpleQTTopLevel : NSObject
@property (nonatomic, strong) QTCountry *country;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, copy)   NSString *decimal;
@property (nonatomic, strong) QTCountry *indicator;
@property (nonatomic, copy)   NSString *value;
@end

@interface QTCountry : NSObject
@property (nonatomic, assign) QTID *identifier;
@property (nonatomic, assign) QTValue *value;
@end

@interface QTFluffyQTTopLevel : NSObject
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, copy)   NSString *perPage;
@property (nonatomic, assign) NSInteger total;
@end

NS_ASSUME_NONNULL_END
