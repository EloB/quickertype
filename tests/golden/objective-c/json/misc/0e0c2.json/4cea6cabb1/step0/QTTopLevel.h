// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTResult;
@class QTCollection;
@class QTDetail;
@class QTDetailLanguage;
@class QTFavMovie;
@class QTImage;
@class QTType;
@class QTResultLanguage;
@class QTVideo;
@class QTVoteScore;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTDetailLanguage : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTDetailLanguage *)en;
+ (QTDetailLanguage *)th;
@end

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)poster;
+ (QTType *)backdrop;
@end

@interface QTResultLanguage : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTResultLanguage *)en;
+ (QTResultLanguage *)empty;
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
@property (nonatomic, assign)         NSInteger activeScreens;
@property (nonatomic, copy)           NSArray<QTCollection *> *collections;
@property (nonatomic, copy)           NSArray<QTDetail *> *details;
@property (nonatomic, assign)         NSInteger duration;
@property (nonatomic, strong)         QTFavMovie *favMovie;
@property (nonatomic, assign)         NSInteger identifier;
@property (nonatomic, copy)           NSArray<QTImage *> *images;
@property (nonatomic, assign)         QTResultLanguage *language;
@property (nonatomic, copy)           NSString *releaseDate;
@property (nonatomic, assign)         NSInteger stars;
@property (nonatomic, nullable, copy) NSArray *tags;
@property (nonatomic, copy)           NSString *title;
@property (nonatomic, copy)           NSArray<QTVideo *> *videos;
@property (nonatomic, strong)         QTVoteScore *voteScore;
@property (nonatomic, assign)         NSInteger watches;
@end

@interface QTCollection : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSArray<NSNumber *> *movies;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *slug;
@end

@interface QTDetail : NSObject
@property (nonatomic, copy)   NSString *cast;
@property (nonatomic, copy)   NSString *director;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) QTDetailLanguage *language;
@property (nonatomic, copy)   NSString *storyline;
@property (nonatomic, copy)   NSString *tagline;
@property (nonatomic, copy)   NSString *title;
@end

@interface QTFavMovie : NSObject
@property (nonatomic, assign) BOOL isFollow;
@property (nonatomic, assign) BOOL isStar;
@property (nonatomic, assign) BOOL isWatched;
@end

@interface QTImage : NSObject
@property (nonatomic, assign) NSInteger favs;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *thumbnail;
@property (nonatomic, assign) QTType *type;
@property (nonatomic, copy)   NSString *url;
@end

@interface QTVideo : NSObject
@property (nonatomic, copy)   NSString *kind;
@property (nonatomic, assign) QTResultLanguage *language;
@property (nonatomic, copy)   NSString *source;
@property (nonatomic, copy)   NSString *url;
@end

@interface QTVoteScore : NSObject
@property (nonatomic, assign) NSInteger avg;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger total;
@end

NS_ASSUME_NONNULL_END
