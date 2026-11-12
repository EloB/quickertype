// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTTopLevelData;
@class QTChild;
@class QTChildData;
@class QTDistinguished;
@class QTDomain;
@class QTMediaEmbed;
@class QTPostHint;
@class QTPreview;
@class QTImage;
@class QTSource;
@class QTVariants;
@class QTGIF;
@class QTSubreddit;
@class QTSubredditID;
@class QTSubredditNamePrefixed;
@class QTSubredditType;
@class QTKind;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTDistinguished : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTDistinguished *)admin;
@end

@interface QTDomain : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTDomain *)selfAnnouncements;
+ (QTDomain *)iReddIt;
@end

@interface QTPostHint : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPostHint *)self;
+ (QTPostHint *)image;
@end

@interface QTSubreddit : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSubreddit *)announcements;
@end

@interface QTSubredditID : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSubredditID *)t52R0Ij;
@end

@interface QTSubredditNamePrefixed : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSubredditNamePrefixed *)rAnnouncements;
@end

@interface QTSubredditType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSubredditType *)restricted;
@end

@interface QTKind : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTKind *)t3;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, strong) QTTopLevelData *data;
@property (nonatomic, copy)   NSString *kind;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTTopLevelData : NSObject
@property (nonatomic, copy)           NSString *after;
@property (nonatomic, nullable, copy) id before;
@property (nonatomic, copy)           NSArray<QTChild *> *children;
@property (nonatomic, copy)           NSString *modhash;
@end

@interface QTChild : NSObject
@property (nonatomic, strong) QTChildData *data;
@property (nonatomic, assign) QTKind *kind;
@end

@interface QTChildData : NSObject
@property (nonatomic, nullable, copy)   id approvedAtUTC;
@property (nonatomic, nullable, copy)   id approvedBy;
@property (nonatomic, copy)             NSString *author;
@property (nonatomic, nullable, copy)   id authorFlairCSSClass;
@property (nonatomic, nullable, copy)   id authorFlairText;
@property (nonatomic, nullable, copy)   id bannedAtUTC;
@property (nonatomic, nullable, copy)   id bannedBy;
@property (nonatomic, assign)           double created;
@property (nonatomic, assign)           double createdUTC;
@property (nonatomic, assign)           QTDistinguished *distinguished;
@property (nonatomic, assign)           QTDomain *domain;
@property (nonatomic, assign)           NSInteger downs;
@property (nonatomic, copy)             id edited;
@property (nonatomic, assign)           NSInteger gilded;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, assign)           BOOL isArchived;
@property (nonatomic, assign)           BOOL isBrandSafe;
@property (nonatomic, assign)           BOOL isCanGild;
@property (nonatomic, assign)           BOOL isCanModPost;
@property (nonatomic, assign)           BOOL isClicked;
@property (nonatomic, assign)           BOOL isContestMode;
@property (nonatomic, assign)           BOOL isHidden;
@property (nonatomic, assign)           BOOL isHideScore;
@property (nonatomic, assign)           BOOL isLocked;
@property (nonatomic, assign)           BOOL isOver18;
@property (nonatomic, assign)           BOOL isQuarantine;
@property (nonatomic, assign)           BOOL isSaved;
@property (nonatomic, assign)           BOOL isSelf;
@property (nonatomic, assign)           BOOL isSpoiler;
@property (nonatomic, assign)           BOOL isStickied;
@property (nonatomic, assign)           BOOL isVideo;
@property (nonatomic, assign)           BOOL isVisited;
@property (nonatomic, nullable, copy)   id likes;
@property (nonatomic, nullable, copy)   id linkFlairCSSClass;
@property (nonatomic, nullable, copy)   id linkFlairText;
@property (nonatomic, nullable, copy)   id media;
@property (nonatomic, strong)           QTMediaEmbed *mediaEmbed;
@property (nonatomic, copy)             NSArray *modReports;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, assign)           NSInteger numComments;
@property (nonatomic, nullable, copy)   id numReports;
@property (nonatomic, copy)             NSString *permalink;
@property (nonatomic, nullable, assign) QTPostHint *postHint;
@property (nonatomic, nullable, strong) QTPreview *preview;
@property (nonatomic, nullable, copy)   id removalReason;
@property (nonatomic, nullable, copy)   id reportReasons;
@property (nonatomic, assign)           NSInteger score;
@property (nonatomic, nullable, copy)   id secureMedia;
@property (nonatomic, strong)           QTMediaEmbed *secureMediaEmbed;
@property (nonatomic, copy)             NSString *selftext;
@property (nonatomic, nullable, copy)   NSString *selftextHTML;
@property (nonatomic, assign)           QTSubreddit *subreddit;
@property (nonatomic, assign)           QTSubredditID *subredditID;
@property (nonatomic, assign)           QTSubredditNamePrefixed *subredditNamePrefixed;
@property (nonatomic, assign)           QTSubredditType *subredditType;
@property (nonatomic, nullable, copy)   NSString *suggestedSort;
@property (nonatomic, copy)             NSString *thumbnail;
@property (nonatomic, nullable, strong) NSNumber *thumbnailHeight;
@property (nonatomic, nullable, strong) NSNumber *thumbnailWidth;
@property (nonatomic, copy)             NSString *title;
@property (nonatomic, assign)           NSInteger ups;
@property (nonatomic, copy)             NSString *url;
@property (nonatomic, copy)             NSArray *userReports;
@property (nonatomic, nullable, copy)   id viewCount;
@end

@interface QTMediaEmbed : NSObject
@end

@interface QTPreview : NSObject
@property (nonatomic, copy)   NSArray<QTImage *> *images;
@property (nonatomic, assign) BOOL isEnabled;
@end

@interface QTImage : NSObject
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, copy)   NSArray<QTSource *> *resolutions;
@property (nonatomic, strong) QTSource *source;
@property (nonatomic, strong) QTVariants *variants;
@end

@interface QTSource : NSObject
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, assign) NSInteger width;
@end

@interface QTVariants : NSObject
@property (nonatomic, nullable, strong) QTGIF *gif;
@property (nonatomic, nullable, strong) QTGIF *mp4;
@end

@interface QTGIF : NSObject
@property (nonatomic, copy)   NSArray<QTSource *> *resolutions;
@property (nonatomic, strong) QTSource *source;
@end

NS_ASSUME_NONNULL_END
