// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTPurpleQTTopLevel;
@class QTAdminregion;
@class QTID;
@class QTValue;
@class QTFluffyQTTopLevel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTID : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTID *)empty;
+ (QTID *)sas;
+ (QTID *)ssa;
+ (QTID *)eca;
+ (QTID *)lac;
+ (QTID *)eap;
+ (QTID *)mna;
+ (QTID *)hic;
+ (QTID *)lic;
+ (QTID *)na;
+ (QTID *)lmc;
+ (QTID *)umc;
+ (QTID *)lnx;
+ (QTID *)idx;
+ (QTID *)ibd;
+ (QTID *)idb;
+ (QTID *)lcn;
+ (QTID *)ssf;
+ (QTID *)ecs;
+ (QTID *)mea;
+ (QTID *)eas;
+ (QTID *)nac;
@end

@interface QTValue : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTValue *)empty;
+ (QTValue *)southAsia;
+ (QTValue *)subSaharanAfricaExcludingHighIncome;
+ (QTValue *)europeCentralAsiaExcludingHighIncome;
+ (QTValue *)latinAmericaCaribbeanExcludingHighIncome;
+ (QTValue *)eastAsiaPacificExcludingHighIncome;
+ (QTValue *)middleEastNorthAfricaExcludingHighIncome;
+ (QTValue *)highIncome;
+ (QTValue *)lowIncome;
+ (QTValue *)aggregates;
+ (QTValue *)lowerMiddleIncome;
+ (QTValue *)upperMiddleIncome;
+ (QTValue *)notClassified;
+ (QTValue *)ida;
+ (QTValue *)ibrd;
+ (QTValue *)blend;
+ (QTValue *)latinAmericaCaribbean;
+ (QTValue *)subSaharanAfrica;
+ (QTValue *)europeCentralAsia;
+ (QTValue *)middleEastNorthAfrica;
+ (QTValue *)eastAsiaPacific;
+ (QTValue *)northAmerica;
@end

typedef NSArray<id> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTPurpleQTTopLevel : NSObject
@property (nonatomic, strong) QTAdminregion *adminregion;
@property (nonatomic, copy)   NSString *capitalCity;
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, strong) QTAdminregion *incomeLevel;
@property (nonatomic, copy)   NSString *iso2Code;
@property (nonatomic, copy)   NSString *latitude;
@property (nonatomic, strong) QTAdminregion *lendingType;
@property (nonatomic, copy)   NSString *longitude;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) QTAdminregion *region;
@end

@interface QTAdminregion : NSObject
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
