// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = QTTopLevelFromJSON(json, NSUTF8Encoding, &error);

#import <Foundation/Foundation.h>

@class QTTopLevelElement;

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<QTTopLevelElement *> QTTopLevel;

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevelElement : NSObject
@property (nonatomic, nullable, copy) NSString *birthDate;
@property (nonatomic, assign)         NSInteger genderTypeID;
@property (nonatomic, assign)         BOOL isBirthDateIsProtected;
@property (nonatomic, copy)           NSString *notes;
@property (nonatomic, copy)           NSString *parliamentaryName;
@property (nonatomic, assign)         NSInteger personID;
@property (nonatomic, copy)           NSString *photoURL;
@property (nonatomic, copy)           NSString *preferredName;
@end

NS_ASSUME_NONNULL_END
