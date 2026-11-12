// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTObjectOrStringClass;
@class QTEnum;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

/// An enumeration
@interface QTEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTEnum *)foo;
+ (QTEnum *)bar;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

/// The top-level class.
/// Its description has two lines.
@interface QTTopLevel : NSObject
/// A pretty boolean
@property (nonatomic, nullable, strong) NSNumber *bar;
/// An enumeration
@property (nonatomic, assign)           QTEnum *qtTopLevelEnum;
@property (nonatomic, nullable, strong) NSNumber *foo;
@property (nonatomic, copy)             id objectOrString;
/// Either a number or a string
@property (nonatomic, copy) id qtTopLevelUnion;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTObjectOrStringClass : NSObject
/// This must not get lost
@property (nonatomic, assign) double prop;
@end

NS_ASSUME_NONNULL_END
