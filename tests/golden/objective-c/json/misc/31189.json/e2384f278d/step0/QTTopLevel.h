// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTRate;
@class QTPeriod;
@class QTRates;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)           NSString *details;
@property (nonatomic, copy)           NSArray<QTRate *> *rates;
@property (nonatomic, nullable, copy) id version;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTRate : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *countryCode;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<QTPeriod *> *periods;
@end

@interface QTPeriod : NSObject
@property (nonatomic, copy)   NSString *effectiveFrom;
@property (nonatomic, strong) QTRates *rates;
@end

@interface QTRates : NSObject
@property (nonatomic, nullable, strong) NSNumber *parking;
@property (nonatomic, nullable, strong) NSNumber *reduced;
@property (nonatomic, nullable, strong) NSNumber *reduced1;
@property (nonatomic, nullable, strong) NSNumber *reduced2;
@property (nonatomic, assign)           double standard;
@property (nonatomic, nullable, strong) NSNumber *superReduced;
@end

NS_ASSUME_NONNULL_END
