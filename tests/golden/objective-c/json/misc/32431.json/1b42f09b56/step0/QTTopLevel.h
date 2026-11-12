// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTFeature;
@class QTGeometry;
@class QTGeometryType;
@class QTProperties;
@class QTMagType;
@class QTStatus;
@class QTPropertiesType;
@class QTFeatureType;
@class QTMetadata;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTGeometryType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGeometryType *)point;
@end

@interface QTMagType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMagType *)md;
+ (QTMagType *)ml;
+ (QTMagType *)mb;
@end

@interface QTStatus : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTStatus *)automatic;
+ (QTStatus *)reviewed;
@end

@interface QTPropertiesType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPropertiesType *)earthquake;
@end

@interface QTFeatureType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFeatureType *)feature;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSArray<NSNumber *> *bbox;
@property (nonatomic, copy)   NSArray<QTFeature *> *features;
@property (nonatomic, strong) QTMetadata *metadata;
@property (nonatomic, copy)   NSString *type;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTFeature : NSObject
@property (nonatomic, strong) QTGeometry *geometry;
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, strong) QTProperties *properties;
@property (nonatomic, assign) QTFeatureType *type;
@end

@interface QTGeometry : NSObject
@property (nonatomic, copy)   NSArray<NSNumber *> *coordinates;
@property (nonatomic, assign) QTGeometryType *type;
@end

@interface QTProperties : NSObject
@property (nonatomic, nullable, copy)   id alert;
@property (nonatomic, nullable, copy)   id cdi;
@property (nonatomic, copy)             NSString *code;
@property (nonatomic, copy)             NSString *detail;
@property (nonatomic, nullable, strong) NSNumber *dmin;
@property (nonatomic, nullable, copy)   id felt;
@property (nonatomic, nullable, strong) NSNumber *gap;
@property (nonatomic, copy)             NSString *ids;
@property (nonatomic, assign)           double mag;
@property (nonatomic, assign)           QTMagType *magType;
@property (nonatomic, nullable, copy)   id mmi;
@property (nonatomic, copy)             NSString *net;
@property (nonatomic, nullable, strong) NSNumber *nst;
@property (nonatomic, copy)             NSString *place;
@property (nonatomic, assign)           double rms;
@property (nonatomic, assign)           NSInteger sig;
@property (nonatomic, copy)             NSString *sources;
@property (nonatomic, assign)           QTStatus *status;
@property (nonatomic, assign)           NSInteger time;
@property (nonatomic, copy)             NSString *title;
@property (nonatomic, assign)           NSInteger tsunami;
@property (nonatomic, assign)           QTPropertiesType *type;
@property (nonatomic, copy)             NSString *types;
@property (nonatomic, assign)           NSInteger tz;
@property (nonatomic, assign)           NSInteger updated;
@property (nonatomic, copy)             NSString *url;
@end

@interface QTMetadata : NSObject
@property (nonatomic, copy)   NSString *api;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger generated;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *url;
@end

NS_ASSUME_NONNULL_END
