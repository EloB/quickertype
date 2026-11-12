// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTIdentifier;
@class QTScheme;
@class QTKeyword;
@class QTLink;
@class QTNote;
@class QTOtherName;
@class QTText;
@class QTMediaType;
@class QTTitle;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTScheme : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTScheme *)spdx;
+ (QTScheme *)trove;
+ (QTScheme *)dep5;
@end

@interface QTKeyword : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTKeyword *)osiApproved;
+ (QTKeyword *)discouraged;
+ (QTKeyword *)redundant;
+ (QTKeyword *)miscellaneous;
+ (QTKeyword *)nonReusable;
+ (QTKeyword *)obsolete;
+ (QTKeyword *)popular;
+ (QTKeyword *)permissive;
+ (QTKeyword *)retired;
+ (QTKeyword *)specialPurpose;
+ (QTKeyword *)copyleft;
+ (QTKeyword *)international;
@end

@interface QTNote : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTNote *)osiPage;
+ (QTNote *)tlDRLegal;
+ (QTNote *)wikipediaPage;
+ (QTNote *)noteWikipediaPage;
+ (QTNote *)mozillaPage;
+ (QTNote *)osetFoundationPage;
@end

@interface QTMediaType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTMediaType *)textHTML;
+ (QTMediaType *)textPlain;
+ (QTMediaType *)applicationPDF;
@end

@interface QTTitle : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTitle *)html;
+ (QTTitle *)plainText;
+ (QTTitle *)pdf;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, copy)           NSString *identifier;
@property (nonatomic, copy)           NSArray<QTIdentifier *> *identifiers;
@property (nonatomic, copy)           NSArray<QTKeyword *> *keywords;
@property (nonatomic, copy)           NSArray<QTLink *> *links;
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, copy)           NSArray<QTOtherName *> *otherNames;
@property (nonatomic, nullable, copy) NSString *supersededBy;
@property (nonatomic, copy)           NSArray<QTText *> *text;
@end

@interface QTIdentifier : NSObject
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, assign) QTScheme *scheme;
@end

@interface QTLink : NSObject
@property (nonatomic, assign) QTNote *note;
@property (nonatomic, copy)   NSString *url;
@end

@interface QTOtherName : NSObject
@property (nonatomic, copy)           NSString *name;
@property (nonatomic, nullable, copy) NSString *note;
@end

@interface QTText : NSObject
@property (nonatomic, assign) QTMediaType *mediaType;
@property (nonatomic, assign) QTTitle *title;
@property (nonatomic, copy)   NSString *url;
@end

NS_ASSUME_NONNULL_END
