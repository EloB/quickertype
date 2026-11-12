// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTFacets;
@class QTResult;
@class QTCustomIncome;
@class QTStatus;
@class QTCustomIncomeType;
@class QTResultType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTStatus : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTStatus *)active;
+ (QTStatus *)inactive;
@end

@interface QTCustomIncomeType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTCustomIncomeType *)public;
+ (QTCustomIncomeType *)other;
@end

@interface QTResultType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTResultType *)financialDataNGO;
+ (QTResultType *)financialDataLawyer;
+ (QTResultType *)financialDataTradeAssociation;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) QTFacets *facets;
@property (nonatomic, assign) BOOL isPrevious;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, copy)   NSString *next;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, copy)   NSArray<QTResult *> *results;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTFacets : NSObject
@end

@interface QTResult : NSObject
@property (nonatomic, nullable, strong) NSNumber *costAbsolute;
@property (nonatomic, nullable, strong) NSNumber *costMax;
@property (nonatomic, nullable, strong) NSNumber *costMin;
@property (nonatomic, copy)             NSString *createdAt;
@property (nonatomic, copy)             NSArray<QTCustomIncome *> *customIncomes;
@property (nonatomic, nullable, copy)   id directRepCostsMax;
@property (nonatomic, nullable, copy)   id directRepCostsMin;
@property (nonatomic, copy)             NSString *endDate;
@property (nonatomic, assign)           NSInteger eurSourcesGrants;
@property (nonatomic, nullable, copy)   NSString *eurSourcesGrantsSrc;
@property (nonatomic, assign)           NSInteger eurSourcesProcurement;
@property (nonatomic, nullable, copy)   NSString *eurSourcesProcurementSrc;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, nullable, copy)   NSString *noClients;
@property (nonatomic, nullable, copy)   NSString *otherFinancialInformation;
@property (nonatomic, nullable, strong) NSNumber *otherSourcesContributions;
@property (nonatomic, nullable, strong) NSNumber *otherSourcesDonation;
@property (nonatomic, nullable, strong) NSNumber *otherSourcesTotal;
@property (nonatomic, nullable, strong) NSNumber *publicFinancingInfranational;
@property (nonatomic, nullable, strong) NSNumber *publicFinancingNational;
@property (nonatomic, nullable, strong) NSNumber *publicFinancingTotal;
@property (nonatomic, copy)             NSString *representative;
@property (nonatomic, copy)             NSString *startDate;
@property (nonatomic, assign)           QTStatus *status;
@property (nonatomic, nullable, copy)   id theNewOrganisation;
@property (nonatomic, nullable, strong) NSNumber *totalBudget;
@property (nonatomic, nullable, strong) NSNumber *turnoverAbsolute;
@property (nonatomic, nullable, strong) NSNumber *turnoverMax;
@property (nonatomic, nullable, strong) NSNumber *turnoverMin;
@property (nonatomic, assign)           QTResultType *type;
@property (nonatomic, copy)             NSString *updatedAt;
@property (nonatomic, copy)             NSString *uri;
@end

@interface QTCustomIncome : NSObject
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, copy)   NSString *createdAt;
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) QTStatus *status;
@property (nonatomic, assign) QTCustomIncomeType *type;
@property (nonatomic, copy)   NSString *updatedAt;
@property (nonatomic, copy)   NSString *uri;
@end

NS_ASSUME_NONNULL_END
