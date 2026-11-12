// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTOrbitClass;
@class QTPha;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTOrbitClass : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTOrbitClass *)apollo;
+ (QTOrbitClass *)amor;
+ (QTOrbitClass *)aten;
+ (QTOrbitClass *)comet;
+ (QTOrbitClass *)jupiterFamilyComet;
+ (QTOrbitClass *)halleyTypeComet;
+ (QTOrbitClass *)parabolicComet;
+ (QTOrbitClass *)orbitClassJupiterFamilyComet;
+ (QTOrbitClass *)enckeTypeComet;
@end

@interface QTPha : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPha *)y;
+ (QTPha *)n;
+ (QTPha *)nA;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, copy)           NSString *designation;
@property (nonatomic, copy)           NSString *discoveryDate;
@property (nonatomic, nullable, copy) NSString *hMag;
@property (nonatomic, copy)           NSString *iDeg;
@property (nonatomic, copy)           NSString *moidAu;
@property (nonatomic, assign)         QTOrbitClass *orbitClass;
@property (nonatomic, nullable, copy) NSString *periodYr;
@property (nonatomic, assign)         QTPha *pha;
@property (nonatomic, copy)           NSString *qAu1;
@property (nonatomic, nullable, copy) NSString *qAu2;
@end

NS_ASSUME_NONNULL_END
