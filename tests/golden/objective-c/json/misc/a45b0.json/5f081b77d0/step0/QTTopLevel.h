// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTCountry;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTCountry : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTCountry *)unitedStates;
@end

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) QTCountry *country;
@property (nonatomic, assign) NSInteger females;
@property (nonatomic, assign) NSInteger males;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger year;
@end

NS_ASSUME_NONNULL_END
