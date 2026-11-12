// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTFacets;
@class QTResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) QTFacets *facets;
@property (nonatomic, assign) BOOL isNext;
@property (nonatomic, assign) BOOL isPrevious;
@property (nonatomic, assign) NSInteger limit;
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
@property (nonatomic, copy)             NSString *createdAt;
@property (nonatomic, assign)           NSInteger identifier;
@property (nonatomic, assign)           NSInteger items;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, strong) NSNumber *parent;
@property (nonatomic, copy)             NSString *updatedAt;
@property (nonatomic, copy)             NSString *uri;
@end

NS_ASSUME_NONNULL_END
