// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;
@class QTLocation;
@class QTStreet;
@class QTOutcomeStatus;

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, copy)   NSString *category;
@property (nonatomic, copy)   NSString *context;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, strong) QTLocation *location;
@property (nonatomic, copy)   NSString *locationSubtype;
@property (nonatomic, copy)   NSString *locationType;
@property (nonatomic, copy)   NSString *month;
@property (nonatomic, strong) QTOutcomeStatus *outcomeStatus;
@property (nonatomic, copy)   NSString *persistentID;
@end

@interface QTLocation : NSObject
@property (nonatomic, copy)   NSString *latitude;
@property (nonatomic, copy)   NSString *longitude;
@property (nonatomic, strong) QTStreet *street;
@end

@interface QTStreet : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@end

@interface QTOutcomeStatus : NSObject
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *date;
@end

NS_ASSUME_NONNULL_END
