// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTCRS;
@class QTCRSProperties;
@class QTFeature;
@class QTGeometry;
@class QTGeometryType;
@class QTGeometryName;
@class QTFeatureProperties;
@class QTFireBanR;
@class QTRegion;
@class QTPropertiesType;
@class QTFeatureType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTGeometryType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGeometryType *)point;
@end

@interface QTGeometryName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGeometryName *)geom;
@end

@interface QTFireBanR : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFireBanR *)northCentral;
+ (QTFireBanR *)central;
+ (QTFireBanR *)southWest;
+ (QTFireBanR *)wimmera;
+ (QTFireBanR *)northernCountry;
+ (QTFireBanR *)eastGippsland;
+ (QTFireBanR *)northEast;
+ (QTFireBanR *)mallee;
+ (QTFireBanR *)westSouthGippsland;
+ (QTFireBanR *)ballarat;
@end

@interface QTRegion : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRegion *)eastern;
+ (QTRegion *)northernMetro;
+ (QTRegion *)western;
+ (QTRegion *)southernMetro;
@end

@interface QTPropertiesType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPropertiesType *)street;
+ (QTPropertiesType *)avenue;
+ (QTPropertiesType *)road;
+ (QTPropertiesType *)highway;
+ (QTPropertiesType *)boulevard;
+ (QTPropertiesType *)court;
+ (QTPropertiesType *)way;
+ (QTPropertiesType *)drive;
+ (QTPropertiesType *)south;
+ (QTPropertiesType *)hill;
+ (QTPropertiesType *)lane;
+ (QTPropertiesType *)close;
+ (QTPropertiesType *)parade;
+ (QTPropertiesType *)typeRoad;
+ (QTPropertiesType *)place;
+ (QTPropertiesType *)rd;
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
@property (nonatomic, strong) QTCRS *crs;
@property (nonatomic, copy)   NSArray<QTFeature *> *features;
@property (nonatomic, assign) NSInteger totalFeatures;
@property (nonatomic, copy)   NSString *type;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTCRS : NSObject
@property (nonatomic, strong) QTCRSProperties *properties;
@property (nonatomic, copy)   NSString *type;
@end

@interface QTCRSProperties : NSObject
@property (nonatomic, copy) NSString *name;
@end

@interface QTFeature : NSObject
@property (nonatomic, strong) QTGeometry *geometry;
@property (nonatomic, assign) QTGeometryName *geometryName;
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, strong) QTFeatureProperties *properties;
@property (nonatomic, assign) QTFeatureType *type;
@end

@interface QTGeometry : NSObject
@property (nonatomic, copy)   NSArray<NSNumber *> *coordinates;
@property (nonatomic, assign) QTGeometryType *type;
@end

@interface QTFeatureProperties : NSObject
@property (nonatomic, copy)             NSString *division;
@property (nonatomic, assign)           double fax;
@property (nonatomic, nullable, assign) QTFireBanR *fireBanR;
@property (nonatomic, assign)           double latitude;
@property (nonatomic, copy)             NSString *localGovt;
@property (nonatomic, assign)           double longitude;
@property (nonatomic, nullable, copy)   NSString *no;
@property (nonatomic, assign)           double phone;
@property (nonatomic, assign)           NSInteger postcode;
@property (nonatomic, copy)             NSString *psa;
@property (nonatomic, assign)           QTRegion *region;
@property (nonatomic, copy)             NSString *station;
@property (nonatomic, copy)             NSString *street;
@property (nonatomic, copy)             NSString *suburb;
@property (nonatomic, nullable, assign) QTPropertiesType *type;
@end

NS_ASSUME_NONNULL_END
