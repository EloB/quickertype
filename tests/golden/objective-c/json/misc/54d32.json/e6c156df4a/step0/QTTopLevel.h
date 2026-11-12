// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTFacets;
@class QTResult;
@class QTStatus;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTStatus : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTStatus *)inactive;
+ (QTStatus *)active;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) QTFacets *facets;
@property (nonatomic, assign) BOOL isPrevious;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic, copy)   NSString *next;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, copy)   NSArray<QTResult *> *results;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTFacets : NSObject
@end

@interface QTResult : NSObject
@property (nonatomic, copy)   NSString *createdAt;
@property (nonatomic, copy)   NSString *identifier;
@property (nonatomic, copy)   NSString *personID;
@property (nonatomic, copy)   NSString *representativeID;
@property (nonatomic, assign) QTStatus *status;
@property (nonatomic, copy)   NSString *updatedAt;
@end

NS_ASSUME_NONNULL_END
