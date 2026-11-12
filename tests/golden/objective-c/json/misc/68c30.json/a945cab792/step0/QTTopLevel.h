// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTTx;
@class QTInput;
@class QTOut;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy) NSArray<QTTx *> *txs;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTTx : NSObject
@property (nonatomic, copy)   NSArray<QTInput *> *inputs;
@property (nonatomic, assign) BOOL isDoubleSpend;
@property (nonatomic, assign) NSInteger lockTime;
@property (nonatomic, copy)   NSArray<QTOut *> *out;
@property (nonatomic, copy)   NSString *relayedBy;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, copy)   NSString *theHash;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger txIndex;
@property (nonatomic, assign) NSInteger ver;
@property (nonatomic, assign) NSInteger vinSz;
@property (nonatomic, assign) NSInteger voutSz;
@end

@interface QTInput : NSObject
@property (nonatomic, strong) QTOut *prevOut;
@property (nonatomic, copy)   NSString *script;
@property (nonatomic, assign) NSInteger sequence;
@end

@interface QTOut : NSObject
@property (nonatomic, copy)   NSString *addr;
@property (nonatomic, assign) BOOL isSpent;
@property (nonatomic, assign) NSInteger n;
@property (nonatomic, copy)   NSString *script;
@property (nonatomic, assign) NSInteger txIndex;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger value;
@end

NS_ASSUME_NONNULL_END
