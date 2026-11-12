// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTData;
@class QTAddReactionPayload;
@class QTReaction;
@class QTReactionContent;
@class QTReactable;
@class QTError;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTReactionContent : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTReactionContent *)thumbsUp;
+ (QTReactionContent *)thumbsDown;
+ (QTReactionContent *)laugh;
+ (QTReactionContent *)hooray;
+ (QTReactionContent *)confused;
+ (QTReactionContent *)heart;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, nullable, strong) QTData *data;
@property (nonatomic, nullable, copy)   NSArray<QTError *> *errors;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTData : NSObject
@property (nonatomic, nullable, strong) QTAddReactionPayload *addReaction;
@end

@interface QTAddReactionPayload : NSObject
@property (nonatomic, nullable, copy) NSString *clientMutationID;
@property (nonatomic, strong)         QTReaction *reaction;
@property (nonatomic, strong)         QTReactable *subject;
@end

@interface QTReaction : NSObject
@property (nonatomic, assign) QTReactionContent *content;
@end

@interface QTReactable : NSObject
@property (nonatomic, assign)         BOOL isViewerCanReact;
@property (nonatomic, nullable, copy) NSArray<QTReaction *> *reactionGroups;
@end

@interface QTError : NSObject
@property (nonatomic, copy) NSString *message;
@end

NS_ASSUME_NONNULL_END
