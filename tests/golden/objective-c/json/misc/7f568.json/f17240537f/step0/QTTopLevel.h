// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTFile;
@class QTLanguage;
@class QTType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTLanguage : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLanguage *)markdown;
@end

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)textPlain;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, assign)         NSInteger comments;
@property (nonatomic, copy)           NSString *commentsURL;
@property (nonatomic, copy)           NSString *commitsURL;
@property (nonatomic, copy)           NSString *createdAt;
@property (nonatomic, copy)           NSDictionary<NSString *, QTFile *> *files;
@property (nonatomic, copy)           NSString *forksURL;
@property (nonatomic, copy)           NSString *gitPullURL;
@property (nonatomic, copy)           NSString *gitPushURL;
@property (nonatomic, copy)           NSString *htmlURL;
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, assign)         BOOL isPublic;
@property (nonatomic, assign)         BOOL isTruncated;
@property (nonatomic, nullable, copy) NSString *theDescription;
@property (nonatomic, copy)           NSString *updatedAt;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, nullable, copy) id user;
@end

@interface QTFile : NSObject
@property (nonatomic, copy)             NSString *filename;
@property (nonatomic, nullable, assign) QTLanguage *language;
@property (nonatomic, copy)             NSString *rawURL;
@property (nonatomic, assign)           NSInteger size;
@property (nonatomic, assign)           QTType *type;
@end

NS_ASSUME_NONNULL_END
