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
@class QTAddImprov;
@class QTFundingBa;
@class QTLevelAccu;
@class QTMaterial;
@class QTMiSymbolo;
@class QTStatus;
@class QTPropertiesType;
@class QTFeatureType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTGeometryType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGeometryType *)multiPolygon;
@end

@interface QTGeometryName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGeometryName *)geom;
@end

@interface QTAddImprov : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTAddImprov *)f;
+ (QTAddImprov *)addImprovF;
+ (QTAddImprov *)t;
@end

@interface QTFundingBa : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFundingBa *)nonGCCC;
+ (QTFundingBa *)capex;
+ (QTFundingBa *)initial;
+ (QTFundingBa *)contribute;
@end

@interface QTLevelAccu : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLevelAccu *)gpsCorrected10M;
+ (QTLevelAccu *)approx;
+ (QTLevelAccu *)gpsCOrrected10M;
@end

@interface QTMaterial : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMaterial *)gravel;
+ (QTMaterial *)concrete;
+ (QTMaterial *)bitumen;
+ (QTMaterial *)interlockConcBlock;
+ (QTMaterial *)other;
+ (QTMaterial *)earth;
@end

@interface QTMiSymbolo : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMiSymbolo *)pen2265535Brush1016777215;
@end

@interface QTStatus : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTStatus *)current;
@end

@interface QTPropertiesType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPropertiesType *)boatRamp;
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
@property (nonatomic, copy)   NSArray<NSArray<NSArray<NSArray<NSNumber *> *> *> *> *coordinates;
@property (nonatomic, assign) QTGeometryType *type;
@end

@interface QTFeatureProperties : NSObject
@property (nonatomic, nullable, assign) QTAddImprov *addImprov;
@property (nonatomic, assign)           double area;
@property (nonatomic, copy)             NSString *assetNumb;
@property (nonatomic, nullable, copy)   NSString *comments;
@property (nonatomic, assign)           NSInteger condition;
@property (nonatomic, nullable, copy)   NSString *constructi;
@property (nonatomic, nullable, copy)   id createdate;
@property (nonatomic, nullable, copy)   id createuser;
@property (nonatomic, nullable, copy)   id disposalD;
@property (nonatomic, copy)             NSString *documents;
@property (nonatomic, nullable, copy)   NSString *drawingNu;
@property (nonatomic, nullable, copy)   NSString *fileNumbe;
@property (nonatomic, nullable, copy)   NSString *folderNum;
@property (nonatomic, nullable, assign) QTFundingBa *fundingBa;
@property (nonatomic, assign)           NSInteger historicC;
@property (nonatomic, copy)             NSString *inspection;
@property (nonatomic, nullable, copy)   id inspectors;
@property (nonatomic, nullable, copy)   id lastUpdat;
@property (nonatomic, nullable, assign) QTLevelAccu *levelAccu;
@property (nonatomic, assign)           QTMaterial *material;
@property (nonatomic, assign)           NSInteger miPrinx;
@property (nonatomic, assign)           QTMiSymbolo *miSymbolo;
@property (nonatomic, assign)           NSInteger numberLAN;
@property (nonatomic, nullable, copy)   NSString *owner;
@property (nonatomic, nullable, assign) QTLevelAccu *positional;
@property (nonatomic, nullable, copy)   NSString *projectNu;
@property (nonatomic, assign)           NSInteger recID;
@property (nonatomic, nullable, copy)   NSString *recordCre;
@property (nonatomic, assign)           double shapeArea;
@property (nonatomic, assign)           double shapeLeng;
@property (nonatomic, assign)           QTStatus *status;
@property (nonatomic, nullable, copy)   id surveyNum;
@property (nonatomic, assign)           double toeRl;
@property (nonatomic, assign)           double topRl;
@property (nonatomic, nullable, assign) QTPropertiesType *type;
@property (nonatomic, copy)             NSString *updateDAT;
@property (nonatomic, nullable, copy)   id updatedate;
@property (nonatomic, nullable, copy)   id updateuser;
@end

NS_ASSUME_NONNULL_END
