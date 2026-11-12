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
@class QTClass;
@class QTMaintainingAuthority;
@class QTWard;
@class QTFeatureType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTGeometryType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGeometryType *)point;
@end

@interface QTClass : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTClass *)noCodeAllocated;
+ (QTClass *)osDistrict;
+ (QTClass *)osNeighbourhood;
+ (QTClass *)osRegional;
@end

@interface QTMaintainingAuthority : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMaintainingAuthority *)cityOfBallarat;
@end

@interface QTWard : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTWard *)south;
+ (QTWard *)north;
+ (QTWard *)central;
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
@property (nonatomic, copy) NSArray<QTFeature *> *features;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTFeature : NSObject
@property (nonatomic, strong) QTGeometry *geometry;
@property (nonatomic, strong) QTProperties *properties;
@property (nonatomic, assign) QTFeatureType *type;
@end

@interface QTGeometry : NSObject
@property (nonatomic, copy)   NSArray<NSNumber *> *coordinates;
@property (nonatomic, assign) QTGeometryType *type;
@end

@interface QTProperties : NSObject
@property (nonatomic, copy)   NSString *area;
@property (nonatomic, copy)   NSString *centralAssetID;
@property (nonatomic, assign) QTClass *class;
@property (nonatomic, copy)   NSString *featureLocation;
@property (nonatomic, copy)   NSString *lat;
@property (nonatomic, assign) QTMaintainingAuthority *maintainingAuthority;
@property (nonatomic, copy)   NSString *number;
@property (nonatomic, copy)   NSString *propertiesLong;
@property (nonatomic, copy)   NSString *siteName;
@property (nonatomic, assign) QTWard *ward;
@end

NS_ASSUME_NONNULL_END
