// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevel;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTTopLevel : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTTopLevel *)one;
+ (QTTopLevel *)three;
+ (QTTopLevel *)two;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

NS_ASSUME_NONNULL_END
