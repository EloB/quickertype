// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTTopLevelBla;
@class QTEmpty;
@class QTFoo;
@class QTFooBla;
@class QTEmptyClass;
@class QTThisIsAToughOne;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, strong) QTTopLevelBla *bla;
@property (nonatomic, strong) QTEmpty *empty;
@property (nonatomic, strong) QTFoo *foo;
@property (nonatomic, assign) NSInteger qtTopLevel;
@property (nonatomic, strong) QTEmptyClass *qtTopLevelEmpty;
@property (nonatomic, strong) QTThisIsAToughOne *thisIsAToughOne;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTTopLevelBla : NSObject
@property (nonatomic, assign) NSInteger bar;
@end

@interface QTEmpty : NSObject
@property (nonatomic, assign) NSInteger x;
@end

@interface QTFoo : NSObject
@property (nonatomic, strong) QTFooBla *bla;
@property (nonatomic, assign) NSInteger empty;
@property (nonatomic, assign) NSInteger foo;
@end

@interface QTFooBla : NSObject
@end

@interface QTEmptyClass : NSObject
@property (nonatomic, assign) NSInteger y;
@end

@interface QTThisIsAToughOne : NSObject
@property (nonatomic, assign) NSInteger empty;
@property (nonatomic, assign) NSInteger thisIsAToughOne;
@end

NS_ASSUME_NONNULL_END
