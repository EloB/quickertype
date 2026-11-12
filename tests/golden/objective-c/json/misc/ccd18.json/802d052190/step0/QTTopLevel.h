// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTStatus;
@class QTWeather;
@class QTMeta;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSString *city;
@property (nonatomic, copy)   NSString *delay;
@property (nonatomic, copy)   NSString *iata;
@property (nonatomic, copy)   NSString *icao;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *state;
@property (nonatomic, strong) QTStatus *status;
@property (nonatomic, strong) QTWeather *weather;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTStatus : NSObject
@property (nonatomic, copy) NSString *avgDelay;
@property (nonatomic, copy) NSString *closureBegin;
@property (nonatomic, copy) NSString *closureEnd;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *maxDelay;
@property (nonatomic, copy) NSString *minDelay;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, copy) NSString *trend;
@property (nonatomic, copy) NSString *type;
@end

@interface QTWeather : NSObject
@property (nonatomic, strong) QTMeta *meta;
@property (nonatomic, copy)   NSString *temp;
@property (nonatomic, assign) double visibility;
@property (nonatomic, copy)   NSString *weather;
@property (nonatomic, copy)   NSString *wind;
@end

@interface QTMeta : NSObject
@property (nonatomic, copy) NSString *credit;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, copy) NSString *url;
@end

NS_ASSUME_NONNULL_END
