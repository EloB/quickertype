// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTFall;
@class QTGeolocation;
@class QTType;
@class QTNametype;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTFall : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFall *)fell;
+ (QTFall *)found;
@end

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)point;
@end

@interface QTNametype : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTNametype *)valid;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, nullable, copy)   NSString *computedRegionCbhkFwbd;
@property (nonatomic, nullable, copy)   NSString *computedRegionNnqa25F4;
@property (nonatomic, assign)           QTFall *fall;
@property (nonatomic, nullable, strong) QTGeolocation *geolocation;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, nullable, copy)   NSString *mass;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, assign)           QTNametype *nametype;
@property (nonatomic, copy)             NSString *recclass;
@property (nonatomic, nullable, copy)   NSString *reclat;
@property (nonatomic, nullable, copy)   NSString *reclong;
@property (nonatomic, nullable, copy)   NSString *year;
@end

@interface QTGeolocation : NSObject
@property (nonatomic, copy)   NSArray<NSNumber *> *coordinates;
@property (nonatomic, assign) QTType *type;
@end

NS_ASSUME_NONNULL_END
