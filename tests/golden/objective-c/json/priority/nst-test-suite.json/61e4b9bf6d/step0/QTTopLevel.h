// To parse this JSON:
//
//   NSError *error;
//   QTTopLevel *topLevel = [QTTopLevel fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTTopLevel;
@class QTJSON;
@class QTYObjectBasicJSON;
@class QTYObjectEmptyKeyJSON;
@class QTYObjectEscapedNullInKeyJSON;
@class QTYObjectExtremeNumbersJSON;
@class QTYObjectJSON;
@class QTYObjectLongStringsJSON;
@class QTX;
@class QTYObjectSimpleJSON;
@class QTYObjectStringUnicodeJSON;
@class QTYObjectWithNewlinesJSON;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Top-level marshaling functions

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error);
QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error);
NSData     *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error);
NSString   *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error);

#pragma mark - Object interfaces

@interface QTTopLevel : NSObject
@property (nonatomic, assign)         BOOL isYStructureLonelyFalseJSON;
@property (nonatomic, assign)         BOOL isYStructureLonelyTrueJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *qtTopLevelYNumber0E1JSON;
@property (nonatomic, copy)           NSArray<NSArray *> *yArrayArraysWithSpacesJSON;
@property (nonatomic, copy)           NSArray *yArrayEmptyJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yArrayEmptyStringJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yArrayEndingWithNewlineJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yArrayFalseJSON;
@property (nonatomic, copy)           NSArray<id> *yArrayHeterogeneousJSON;
@property (nonatomic, copy)           NSArray *yArrayNullJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yArrayWith1_AndNewlineJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yArrayWithLeadingSpaceJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yArrayWithSeveralNullJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yArrayWithTrailingSpaceJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumber0E1JSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberAfterSpaceJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberDoubleCloseToZeroJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberIntWithExpJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberMinusZeroJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberNegativeIntJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberNegativeOneJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberNegativeZeroJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberRealCapitalEJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberRealCapitalENegExpJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberRealCapitalEPosExpJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberRealExponentJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberRealFractionExponentJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberRealNegExpJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberRealPosExponentJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberSimpleIntJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yNumberSimpleRealJSON;
@property (nonatomic, strong)         QTYObjectBasicJSON *yObjectBasicJSON;
@property (nonatomic, strong)         QTJSON *yObjectEmptyJSON;
@property (nonatomic, strong)         QTYObjectEmptyKeyJSON *yObjectEmptyKeyJSON;
@property (nonatomic, strong)         QTYObjectEscapedNullInKeyJSON *yObjectEscapedNullInKeyJSON;
@property (nonatomic, strong)         QTYObjectExtremeNumbersJSON *yObjectExtremeNumbersJSON;
@property (nonatomic, strong)         QTYObjectJSON *yObjectJSON;
@property (nonatomic, strong)         QTYObjectLongStringsJSON *yObjectLongStringsJSON;
@property (nonatomic, strong)         QTYObjectSimpleJSON *yObjectSimpleJSON;
@property (nonatomic, strong)         QTYObjectStringUnicodeJSON *yObjectStringUnicodeJSON;
@property (nonatomic, strong)         QTYObjectWithNewlinesJSON *yObjectWithNewlinesJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yString1_2_3_BytesUTF8_SequencesJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringAcceptedSurrogatePairJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringAcceptedSurrogatePairsJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringAllowedEscapesJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringBackslashAndUEscapedZeroJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringBackslashDoublequotesJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringCommentsJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringDoubleEscapeAJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringDoubleEscapeNJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringEscapedControlCharacterJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringEscapedNoncharacterJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringInArrayJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringInArrayWithLeadingSpaceJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringLastSurrogates1_And2JSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringNbspUescapedJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringNonCharacterInUTF8_U10FFFFJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringNonCharacterInUTF8_U1FFFFJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringNonCharacterInUTF8_UFFFFJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringNullEscapeJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringOneByteUTF8JSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringPiJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringSimpleASCIIJSON;
@property (nonatomic, copy)           NSString *yStringSpaceJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringThreeByteUTF8JSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringTwoByteUTF8JSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringU2028_LineSepJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringU2029_ParSepJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUEscapeJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUescapedNewlineJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnescapedCharDeleteJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicode2JSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeEscapedBackslashJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeEscapedDoubleQuoteJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeU10FFFENoncharJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeU1FFFENoncharJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeU200BZEROWIDTHSPACEJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeU2064_InvisiblePlusJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeUFDD0NoncharJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUnicodeUFFFENoncharJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringUtf8JSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStringWithDelCharacterJSON;
@property (nonatomic, assign)         NSInteger yStructureLonelyIntJSON;
@property (nonatomic, assign)         double yStructureLonelyNegativeRealJSON;
@property (nonatomic, nullable, copy) id yStructureLonelyNullJSON;
@property (nonatomic, copy)           NSString *yStructureLonelyStringJSON;
@property (nonatomic, copy)           NSString *yStructureStringEmptyJSON;
@property (nonatomic, copy)           NSArray<NSString *> *yStructureTrailingNewlineJSON;
@property (nonatomic, copy)           NSArray<NSNumber *> *yStructureTrueInArrayJSON;
@property (nonatomic, copy)           NSArray *yStructureWhitespaceArrayJSON;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTJSON : NSObject
@end

@interface QTYObjectBasicJSON : NSObject
@property (nonatomic, copy) NSString *asd;
@end

@interface QTYObjectEmptyKeyJSON : NSObject
@property (nonatomic, assign) NSInteger empty;
@end

@interface QTYObjectEscapedNullInKeyJSON : NSObject
@property (nonatomic, assign) NSInteger fooBar;
@end

@interface QTYObjectExtremeNumbersJSON : NSObject
@property (nonatomic, assign) double max;
@property (nonatomic, assign) double min;
@end

@interface QTYObjectJSON : NSObject
@property (nonatomic, copy) NSString *asd;
@property (nonatomic, copy) NSString *dfg;
@end

@interface QTYObjectLongStringsJSON : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSArray<QTX *> *x;
@end

@interface QTX : NSObject
@property (nonatomic, copy) NSString *identifier;
@end

@interface QTYObjectSimpleJSON : NSObject
@property (nonatomic, copy) NSArray *a;
@end

@interface QTYObjectStringUnicodeJSON : NSObject
@property (nonatomic, copy) NSString *title;
@end

@interface QTYObjectWithNewlinesJSON : NSObject
@property (nonatomic, copy) NSString *a;
@end

NS_ASSUME_NONNULL_END
