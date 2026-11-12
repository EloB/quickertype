// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTLaureate;
@class QTGender;
@class QTPrize;
@class QTAffiliationClass;
@class QTCategory;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTGender : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTGender *)male;
+ (QTGender *)female;
+ (QTGender *)org;
@end

@interface QTCategory : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTCategory *)physics;
+ (QTCategory *)chemistry;
+ (QTCategory *)peace;
+ (QTCategory *)medicine;
+ (QTCategory *)literature;
+ (QTCategory *)economics;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy) NSArray<QTLaureate *> *laureates;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTLaureate : NSObject
@property (nonatomic, copy)           NSString *born;
@property (nonatomic, nullable, copy) NSString *bornCity;
@property (nonatomic, nullable, copy) NSString *bornCountry;
@property (nonatomic, nullable, copy) NSString *bornCountryCode;
@property (nonatomic, copy)           NSString *died;
@property (nonatomic, nullable, copy) NSString *diedCity;
@property (nonatomic, nullable, copy) NSString *diedCountry;
@property (nonatomic, nullable, copy) NSString *diedCountryCode;
@property (nonatomic, nullable, copy) NSString *firstname;
@property (nonatomic, assign)         QTGender *gender;
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSArray<QTPrize *> *prizes;
@property (nonatomic, nullable, copy) NSString *surname;
@end

@interface QTPrize : NSObject
@property (nonatomic, copy)             NSArray<id> *affiliations;
@property (nonatomic, nullable, assign) QTCategory *category;
@property (nonatomic, nullable, copy)   NSString *motivation;
@property (nonatomic, nullable, copy)   NSString *overallMotivation;
@property (nonatomic, nullable, copy)   NSString *share;
@property (nonatomic, nullable, copy)   NSString *year;
@end

@interface QTAffiliationClass : NSObject
@property (nonatomic, nullable, copy) NSString *city;
@property (nonatomic, nullable, copy) NSString *country;
@property (nonatomic, nullable, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
