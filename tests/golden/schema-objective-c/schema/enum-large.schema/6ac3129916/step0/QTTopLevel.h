// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTCallsign;
@class QTPriority;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTCallsign : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTCallsign *)alpha;
+ (QTCallsign *)bravo;
+ (QTCallsign *)charlie;
+ (QTCallsign *)delta;
+ (QTCallsign *)echo;
+ (QTCallsign *)foxtrot;
+ (QTCallsign *)golf;
+ (QTCallsign *)hotel;
+ (QTCallsign *)india;
+ (QTCallsign *)juliett;
+ (QTCallsign *)kilo;
+ (QTCallsign *)lima;
+ (QTCallsign *)mike;
+ (QTCallsign *)november;
+ (QTCallsign *)oscar;
+ (QTCallsign *)papa;
+ (QTCallsign *)quebec;
+ (QTCallsign *)romeo;
+ (QTCallsign *)sierra;
+ (QTCallsign *)tango;
@end

@interface QTPriority : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTPriority *)low;
+ (QTPriority *)medium;
+ (QTPriority *)high;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign) QTCallsign *callsign;
@property (nonatomic, assign) QTPriority *priority;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

NS_ASSUME_NONNULL_END
