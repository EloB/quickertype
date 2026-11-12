// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTBooster;
@class QTCard;
@class QTColorIdentity;
@class QTColor;
@class QTLayout;
@class QTLegalityElement;
@class QTFormat;
@class QTLegalityEnum;
@class QTRarity;
@class QTRuling;
@class QTSupertype;
@class QTType;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTBooster : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTBooster *)rare;
+ (QTBooster *)uncommon;
+ (QTBooster *)common;
@end

@interface QTColorIdentity : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTColorIdentity *)u;
+ (QTColorIdentity *)b;
+ (QTColorIdentity *)w;
+ (QTColorIdentity *)g;
+ (QTColorIdentity *)r;
@end

@interface QTColor : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTColor *)blue;
+ (QTColor *)black;
+ (QTColor *)white;
+ (QTColor *)green;
+ (QTColor *)red;
@end

@interface QTLayout : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLayout *)normal;
@end

@interface QTFormat : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTFormat *)commander;
+ (QTFormat *)legacy;
+ (QTFormat *)modern;
+ (QTFormat *)vintage;
+ (QTFormat *)timeSpiralBlock;
+ (QTFormat *)ravnicaBlock;
+ (QTFormat *)iceAgeBlock;
+ (QTFormat *)tempestBlock;
+ (QTFormat *)onslaughtBlock;
+ (QTFormat *)masquesBlock;
+ (QTFormat *)mirageBlock;
+ (QTFormat *)urzaBlock;
+ (QTFormat *)scarsOfMirrodinBlock;
+ (QTFormat *)mirrodinBlock;
+ (QTFormat *)amonkhetBlock;
+ (QTFormat *)battleForZendikarBlock;
+ (QTFormat *)innistradBlock;
+ (QTFormat *)invasionBlock;
+ (QTFormat *)kaladeshBlock;
+ (QTFormat *)kamigawaBlock;
+ (QTFormat *)khansOfTarkirBlock;
+ (QTFormat *)lorwynShadowmoorBlock;
+ (QTFormat *)odysseyBlock;
+ (QTFormat *)returnToRavnicaBlock;
+ (QTFormat *)shadowsOverInnistradBlock;
+ (QTFormat *)shardsOfAlaraBlock;
+ (QTFormat *)standard;
+ (QTFormat *)therosBlock;
+ (QTFormat *)unSets;
+ (QTFormat *)zendikarBlock;
@end

@interface QTLegalityEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTLegalityEnum *)legal;
+ (QTLegalityEnum *)banned;
+ (QTLegalityEnum *)restricted;
@end

@interface QTRarity : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTRarity *)uncommon;
+ (QTRarity *)rare;
+ (QTRarity *)common;
+ (QTRarity *)basicLand;
@end

@interface QTSupertype : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTSupertype *)basic;
@end

@interface QTType : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTType *)creature;
+ (QTType *)instant;
+ (QTType *)enchantment;
+ (QTType *)artifact;
+ (QTType *)sorcery;
+ (QTType *)land;
@end

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, copy)   NSArray<QTBooster *> *booster;
@property (nonatomic, copy)   NSString *border;
@property (nonatomic, copy)   NSArray<QTCard *> *cards;
@property (nonatomic, copy)   NSString *code;
@property (nonatomic, copy)   NSString *gathererCode;
@property (nonatomic, copy)   NSString *magicCardsInfoCode;
@property (nonatomic, assign) NSInteger mkmID;
@property (nonatomic, copy)   NSString *mkmName;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *releaseDate;
@property (nonatomic, copy)   NSString *type;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTCard : NSObject
@property (nonatomic, copy)             NSString *artist;
@property (nonatomic, assign)           NSInteger cmc;
@property (nonatomic, nullable, copy)   NSArray<QTColorIdentity *> *colorIdentity;
@property (nonatomic, nullable, copy)   NSArray<QTColor *> *colors;
@property (nonatomic, nullable, copy)   NSString *flavor;
@property (nonatomic, copy)             NSString *identifier;
@property (nonatomic, copy)             NSString *imageName;
@property (nonatomic, assign)           QTLayout *layout;
@property (nonatomic, copy)             NSArray<QTLegalityElement *> *legalities;
@property (nonatomic, nullable, copy)   NSString *manaCost;
@property (nonatomic, nullable, copy)   NSString *mciNumber;
@property (nonatomic, assign)           NSInteger multiverseid;
@property (nonatomic, copy)             NSString *name;
@property (nonatomic, nullable, copy)   NSString *originalText;
@property (nonatomic, copy)             NSString *originalType;
@property (nonatomic, nullable, copy)   NSString *power;
@property (nonatomic, copy)             NSArray<NSString *> *printings;
@property (nonatomic, assign)           QTRarity *rarity;
@property (nonatomic, nullable, strong) NSNumber *reserved;
@property (nonatomic, nullable, copy)   NSArray<QTRuling *> *rulings;
@property (nonatomic, nullable, copy)   NSArray<NSString *> *subtypes;
@property (nonatomic, nullable, copy)   NSArray<QTSupertype *> *supertypes;
@property (nonatomic, nullable, copy)   NSString *text;
@property (nonatomic, nullable, copy)   NSString *toughness;
@property (nonatomic, copy)             NSString *type;
@property (nonatomic, copy)             NSArray<QTType *> *types;
@property (nonatomic, nullable, copy)   NSArray<NSNumber *> *variations;
@end

@interface QTLegalityElement : NSObject
@property (nonatomic, assign) QTFormat *format;
@property (nonatomic, assign) QTLegalityEnum *legality;
@end

@interface QTRuling : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *text;
@end

NS_ASSUME_NONNULL_END
