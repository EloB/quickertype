// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTDatum;
@class QTImages;
@class QTDownsized;
@class QTDownsizedSmall;
@class QTFixedHeight;
@class QTLooping;
@class QTRating;
@class QTType;
@class QTUser;
@class QTUsername;
@class QTMeta;
@class QTPagination;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTRating : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRating *)g;
+ (QTRating *)pg;
@end

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)gif;
@end

@interface QTUsername : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTUsername *)cheezburger;
+ (QTUsername *)empty;
+ (QTUsername *)natgeowild;
+ (QTUsername *)nowthis;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSArray<QTDatum *> *data;
@property (nonatomic, strong) QTMeta *meta;
@property (nonatomic, strong) QTPagination *pagination;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTDatum : NSObject
@property (nonatomic, copy)             NSString *bitlyGIFURL;
@property (nonatomic, copy)             NSString *bitlyURL;
@property (nonatomic, copy)             NSString *contentURL;
@property (nonatomic, copy)             NSString *embedURL;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, strong)           QTImages *images;
@property (nonatomic, copy)             NSString *importDatetime;
@property (nonatomic, assign)           NSInteger isIndexable;
@property (nonatomic, assign)           QTRating *rating;
@property (nonatomic, copy)             NSString *slug;
@property (nonatomic, copy)             NSString *source;
@property (nonatomic, copy)             NSString *sourcePostURL;
@property (nonatomic, copy)             NSString *sourceTLD;
@property (nonatomic, copy)             NSString *trendingDatetime;
@property (nonatomic, assign)           QTType *type;
@property (nonatomic, copy)             NSString *url;
@property (nonatomic, nullable, strong) QTUser *user;
@property (nonatomic, assign)           QTUsername *username;
@end

@interface QTImages : NSObject
@property (nonatomic, strong)           QTDownsized *downsized;
@property (nonatomic, strong)           QTDownsized *downsizedLarge;
@property (nonatomic, strong)           QTDownsized *downsizedMedium;
@property (nonatomic, strong)           QTDownsizedSmall *downsizedSmall;
@property (nonatomic, strong)           QTDownsized *downsizedStill;
@property (nonatomic, strong)           QTFixedHeight *fixedHeight;
@property (nonatomic, strong)           QTFixedHeight *fixedHeightDownsampled;
@property (nonatomic, strong)           QTFixedHeight *fixedHeightSmall;
@property (nonatomic, strong)           QTDownsized *fixedHeightSmallStill;
@property (nonatomic, strong)           QTDownsized *fixedHeightStill;
@property (nonatomic, strong)           QTFixedHeight *fixedWidth;
@property (nonatomic, strong)           QTFixedHeight *fixedWidthDownsampled;
@property (nonatomic, strong)           QTFixedHeight *fixedWidthSmall;
@property (nonatomic, strong)           QTDownsized *fixedWidthSmallStill;
@property (nonatomic, strong)           QTDownsized *fixedWidthStill;
@property (nonatomic, strong)           QTLooping *looping;
@property (nonatomic, strong)           QTFixedHeight *original;
@property (nonatomic, strong)           QTDownsizedSmall *originalMp4;
@property (nonatomic, strong)           QTDownsized *originalStill;
@property (nonatomic, strong)           QTDownsizedSmall *preview;
@property (nonatomic, strong)           QTDownsized *previewGIF;
@property (nonatomic, strong)           QTDownsized *previewWebp;
@property (nonatomic, nullable, strong) QTDownsized *the480WStill;
@end

@interface QTDownsized : NSObject
@property (nonatomic, copy)           NSString *height;
@property (nonatomic, nullable, copy) NSString *size;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, copy)           NSString *width;
@end

@interface QTDownsizedSmall : NSObject
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *mp4;
@property (nonatomic, copy) NSString *mp4Size;
@property (nonatomic, copy) NSString *width;
@end

@interface QTFixedHeight : NSObject
@property (nonatomic, nullable, copy) NSString *frames;
@property (nonatomic, copy)           NSString *height;
@property (nonatomic, nullable, copy) NSString *mp4;
@property (nonatomic, nullable, copy) NSString *mp4Size;
@property (nonatomic, copy)           NSString *size;
@property (nonatomic, nullable, copy) NSString *theHash;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, copy)           NSString *webp;
@property (nonatomic, copy)           NSString *webpSize;
@property (nonatomic, copy)           NSString *width;
@end

@interface QTLooping : NSObject
@property (nonatomic, copy) NSString *mp4;
@property (nonatomic, copy) NSString *mp4Size;
@end

@interface QTUser : NSObject
@property (nonatomic, copy)   NSString *avatarURL;
@property (nonatomic, copy)   NSString *bannerURL;
@property (nonatomic, copy)   NSString *displayName;
@property (nonatomic, copy)   NSString *profileURL;
@property (nonatomic, copy)   NSString *twitter;
@property (nonatomic, assign) QTUsername *username;
@end

@interface QTMeta : NSObject
@property (nonatomic, copy)   NSString *msg;
@property (nonatomic, copy)   NSString *responseID;
@property (nonatomic, assign) NSInteger status;
@end

@interface QTPagination : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger totalCount;
@end

NS_ASSUME_NONNULL_END
