// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTResult;
@class QTGroup;
@class QTCode;
@class QTEnglish;
@class QTThai;
@class QTLocation;
@class QTTel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTCode : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTCode *)sf;
@end

@interface QTEnglish : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTEnglish *)sf;
@end

@interface QTThai : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTThai *)เอสเอฟ;
@end

@interface QTLocation : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLocation *)empty;
+ (QTLocation *)the5ThFLEmporium;
@end

@interface QTTel : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTel *)empty;
+ (QTTel *)the022688899;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign)         NSInteger count;
@property (nonatomic, copy)           NSString *next;
@property (nonatomic, nullable, copy) id previous;
@property (nonatomic, copy)           NSArray<QTResult *> *results;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTResult : NSObject
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, copy)   NSString *english;
@property (nonatomic, strong) QTGroup *group;
@property (nonatomic, assign) BOOL isFav;
@property (nonatomic, assign) QTLocation *location;
@property (nonatomic, assign) NSInteger minScreens;
@property (nonatomic, assign) NSInteger numViews;
@property (nonatomic, copy)   NSString *showtimes;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, assign) QTTel *tel;
@property (nonatomic, copy)   NSString *thai;
@property (nonatomic, assign) NSInteger todayScreens;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, copy)   NSString *website;
@end

@interface QTGroup : NSObject
@property (nonatomic, assign) QTCode *code;
@property (nonatomic, assign) QTEnglish *english;
@property (nonatomic, assign) QTThai *thai;
@property (nonatomic, copy)   NSString *website;
@end

NS_ASSUME_NONNULL_END
