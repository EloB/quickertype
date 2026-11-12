// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTFruit;
@class QTBerry;
@class QTColor;
@class QTShape;
@class QTGeometry;
@class QTCircularShape;
@class QTRectShape;
@class QTPart;
@class QTHistory;
@class QTVehicle;
@class QTSpeed;
@class QTLimit;
@class QTVehicleType;
@class QTAxis;
@class QTName;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTAxis : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTAxis *)x;
+ (QTAxis *)y;
+ (QTAxis *)z;
+ (QTAxis *)xy;
+ (QTAxis *)yz;
+ (QTAxis *)zx;
@end

@interface QTName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTName *)truck;
+ (QTName *)bus;
+ (QTName *)car;
+ (QTName *)van;
+ (QTName *)train;
+ (QTName *)bike;
+ (QTName *)aeroplane;
+ (QTName *)jeep;
+ (QTName *)trolley;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, nullable, copy) NSString *version;
@property (nonatomic, nullable, copy) NSArray<QTFruit *> *fruits;
@property (nonatomic, nullable, copy) NSArray<QTVehicle *> *vehicles;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTFruit : NSObject
@property (nonatomic, nullable, strong) NSNumber *apple;
@property (nonatomic, nullable, copy)   NSArray<QTBerry *> *berries;
@property (nonatomic, nullable, strong) NSNumber *orange;
@end

@interface QTBerry : NSObject
@property (nonatomic, nullable, strong) QTColor *color;
@property (nonatomic, nullable, copy)   NSString *name;
@property (nonatomic, nullable, copy)   NSArray<QTShape *> *shapes;
@end

@interface QTColor : NSObject
@property (nonatomic, nullable, strong) NSNumber *rgb;
@end

@interface QTShape : NSObject
@property (nonatomic, nullable, strong) QTGeometry *geometry;
@property (nonatomic, nullable, strong) QTHistory *history;
@end

@interface QTGeometry : NSObject
@property (nonatomic, nullable, strong) QTRectShape *rectShape;
@property (nonatomic, nullable, copy)   NSArray<QTCircularShape *> *circularShape;
@end

@interface QTCircularShape : NSObject
@property (nonatomic, nullable, copy) NSString *shapeName;
@end

@interface QTRectShape : NSObject
@property (nonatomic, nullable, copy) NSArray<QTPart *> *parts;
@end

@interface QTPart : NSObject
@property (nonatomic, nullable, copy) NSString *depth;
@property (nonatomic, nullable, copy) NSString *length;
@property (nonatomic, nullable, copy) NSString *width;
@end

@interface QTHistory : NSObject
@property (nonatomic, nullable, copy) NSString *class;
@end

@interface QTVehicle : NSObject
@property (nonatomic, nullable, copy)   NSString *brand;
@property (nonatomic, nullable, copy)   NSString *identifier;
@property (nonatomic, nullable, strong) QTSpeed *speed;
@property (nonatomic, nullable, strong) NSNumber *subModule;
@property (nonatomic, nullable, strong) QTVehicleType *type;
@property (nonatomic, nullable, copy)   NSString *year;
@end

@interface QTSpeed : NSObject
@property (nonatomic, nullable, strong) QTLimit *velocity;
@end

@interface QTLimit : NSObject
@property (nonatomic, nullable, strong) NSNumber *maximum;
@property (nonatomic, nullable, strong) NSNumber *minimum;
@end

@interface QTVehicleType : NSObject
@property (nonatomic, nullable, assign) QTName *name;
@property (nonatomic, nullable, assign) QTAxis *width;
@property (nonatomic, nullable, assign) QTAxis *length;
@end

NS_ASSUME_NONNULL_END
