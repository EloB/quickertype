// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTQuery;
@class QTResults;
@class QTChannel;
@class QTAstronomy;
@class QTAtmosphere;
@class QTImage;
@class QTItem;
@class QTCondition;
@class QTText;
@class QTForecast;
@class QTGUID;
@class QTLocation;
@class QTUnits;
@class QTWind;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTText : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTText *)mostlySunny;
+ (QTText *)sunny;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, strong) QTQuery *query;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTQuery : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy)   NSString *created;
@property (nonatomic, copy)   NSString *lang;
@property (nonatomic, strong) QTResults *results;
@end

@interface QTResults : NSObject
@property (nonatomic, strong) QTChannel *channel;
@end

@interface QTChannel : NSObject
@property (nonatomic, strong) QTAstronomy *astronomy;
@property (nonatomic, strong) QTAtmosphere *atmosphere;
@property (nonatomic, strong) QTImage *image;
@property (nonatomic, strong) QTItem *item;
@property (nonatomic, copy)   NSString *language;
@property (nonatomic, copy)   NSString *lastBuildDate;
@property (nonatomic, copy)   NSString *link;
@property (nonatomic, strong) QTLocation *location;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *ttl;
@property (nonatomic, strong) QTUnits *units;
@property (nonatomic, strong) QTWind *wind;
@end

@interface QTAstronomy : NSObject
@property (nonatomic, copy) NSString *sunrise;
@property (nonatomic, copy) NSString *sunset;
@end

@interface QTAtmosphere : NSObject
@property (nonatomic, copy) NSString *humidity;
@property (nonatomic, copy) NSString *pressure;
@property (nonatomic, copy) NSString *rising;
@property (nonatomic, copy) NSString *visibility;
@end

@interface QTImage : NSObject
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *width;
@end

@interface QTItem : NSObject
@property (nonatomic, strong) QTCondition *condition;
@property (nonatomic, copy)   NSArray<QTForecast *> *forecast;
@property (nonatomic, strong) QTGUID *guid;
@property (nonatomic, copy)   NSString *itemLong;
@property (nonatomic, copy)   NSString *lat;
@property (nonatomic, copy)   NSString *link;
@property (nonatomic, copy)   NSString *pubDate;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *title;
@end

@interface QTCondition : NSObject
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, copy)   NSString *temp;
@property (nonatomic, assign) QTText *text;
@end

@interface QTForecast : NSObject
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, copy)   NSString *date;
@property (nonatomic, copy)   NSString *day;
@property (nonatomic, copy)   NSString *high;
@property (nonatomic, copy)   NSString *low;
@property (nonatomic, assign) QTText *text;
@end

@interface QTGUID : NSObject
@property (nonatomic, copy) NSString *isPermaLink;
@end

@interface QTLocation : NSObject
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *region;
@end

@interface QTUnits : NSObject
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *pressure;
@property (nonatomic, copy) NSString *speed;
@property (nonatomic, copy) NSString *temperature;
@end

@interface QTWind : NSObject
@property (nonatomic, copy) NSString *chill;
@property (nonatomic, copy) NSString *direction;
@property (nonatomic, copy) NSString *speed;
@end

NS_ASSUME_NONNULL_END
