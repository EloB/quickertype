// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTResults;
@class QTSeries;
@class QTDatum;
@class QTFootnote;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSArray *message;
@property (nonatomic, assign) NSInteger responseTime;
@property (nonatomic, strong) QTResults *results;
@property (nonatomic, copy)   NSString *status;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTResults : NSObject
@property (nonatomic, copy) NSArray<QTSeries *> *series;
@end

@interface QTSeries : NSObject
@property (nonatomic, copy) NSArray<QTDatum *> *data;
@property (nonatomic, copy) NSString *seriesID;
@end

@interface QTDatum : NSObject
@property (nonatomic, copy) NSArray<QTFootnote *> *footnotes;
@property (nonatomic, copy) NSString *period;
@property (nonatomic, copy) NSString *periodName;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *year;
@end

@interface QTFootnote : NSObject
@property (nonatomic, nullable, copy) NSString *code;
@property (nonatomic, nullable, copy) NSString *text;
@end

NS_ASSUME_NONNULL_END
