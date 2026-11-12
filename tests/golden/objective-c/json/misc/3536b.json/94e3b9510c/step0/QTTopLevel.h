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
@class QTText;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTScheme : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTScheme *)spdx;
+ (QTScheme *)dep5;
+ (QTScheme *)trove;
@end

@interface QTKeyword : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTKeyword *)discouraged;
+ (QTKeyword *)obsolete;
+ (QTKeyword *)osiApproved;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSArray<QTIdentifier *> *identifiers;
@property (nonatomic, copy) NSArray<QTKeyword *> *keywords;
@property (nonatomic, copy) NSArray<QTLink *> *links;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *otherNames;
@property (nonatomic, copy) NSString *supersededBy;
@property (nonatomic, copy) NSArray<QTText *> *text;
@end

@interface QTIdentifier : NSObject
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, assign) QTScheme *scheme;
@end

@interface QTLink : NSObject
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *url;
@end

@interface QTText : NSObject
@property (nonatomic, copy) NSString *mediaType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@end

NS_ASSUME_NONNULL_END
