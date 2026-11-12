// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelValue;

NS_ASSUME_NONNULL_BEGIN

typedef NSDictionary<NSString *, QTTopLevelValue *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelValue : NSObject
@property (nonatomic, copy)   NSString *channelID;
@property (nonatomic, copy)   NSString *channelName;
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, assign) NSInteger emoticonSet;
@property (nonatomic, assign) NSInteger identifier;
@end

NS_ASSUME_NONNULL_END
