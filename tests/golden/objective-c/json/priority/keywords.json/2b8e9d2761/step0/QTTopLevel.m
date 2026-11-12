#import "QTTopLevel.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTTopLevel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObj1 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAbstract (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAlignas (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAlignof (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAnd (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAndEq (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAny (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTArray (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTArrayNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAs (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAssert (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAssociatedtype (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAssociativity (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAsync (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAtomicCancel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAtomicCommit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAtomicNoexcept (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAwait (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBase (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBitand (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBitor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBoolean (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBooleanNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBycopy (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTByref (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTByte (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCalendar (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCatch (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChan (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChar16T (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChar32T (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChecked (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTClone (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCoAwait (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCoReturn (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCoYield (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCodable (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCodingKey (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCodingKeys (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCompl (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTComplex (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConcept (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConsole (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConstCast (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConstexpr (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConstructor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConvenience (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConvert (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConverter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEmpty (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImaginery (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTASM (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAnyClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAtomic (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTAuto (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBool (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBoolClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBreak (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCase (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTChar (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTClassClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTConst (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTContinue (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObj1Bool (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObj2 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTCultureInfo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDateFormatter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDateOnly (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDateOnlyConverter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDateParseHandling (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDateTime (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDateTimeStyles (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDebugger (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDecimal (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDeclare (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDecltype (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDecodeString (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDecoder (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDecodingError (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDefer (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDeinit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDelegate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDelete (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDeserializationFeature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDict (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDictionary (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDidSet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDoubleNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDynamic (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDynamicCast (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTElif (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEncodeQuickType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEncoder (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEnumValues (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEqualityContract (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEquatable (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEvent (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExcept (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTException (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExplicit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExport (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExposing (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExtends (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExtension (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFallthrough (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFileprivate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFinal (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFinally (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFixed (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTForeach (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFormatException (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFriend (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFrom (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFromDict (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFromJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFunc (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDefault (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTDouble (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTElse (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTEnum (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTExtern (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFalse (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFloat (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFalseClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObj3 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFunction (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGlobal (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGuard (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHasOwnProperty (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHashable (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHasher (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTID (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImp (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImplements (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImplicit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTImport (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIn (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIndirect (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInfix (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInout (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInstanceof (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIntNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInterface (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInternal (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIs (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTISODateTimeOffsetConverter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIterable (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJdec (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJenc (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJpipe (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONAny (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONCodingKey (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONConverter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONDecoder (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONEncoder (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONException (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONGenerator (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONNull (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONParser (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONReader (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONSerializer (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONToken (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONTokenType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTJSONWriter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLambda (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLazy (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLeft (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTList (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLocalDate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLocale (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLock (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLongNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMap (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMapEntry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMarshalJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMetadataPropertyHandling (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTModule (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGoto (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIf (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInline (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInt (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTLong (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTHashCode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTInit (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObj4 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMutable (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMutating (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNamespace (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNative (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNewtonsoft (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNo (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNoSuchMethod (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNoexcept (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNone (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNonlocal (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNonmutating (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNot (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNotEq (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNSError (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNSObject (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNSString (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNull (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNullNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNullptr (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNumber (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNil (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNonatomic (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNoneClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNullClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProtocolClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRegister (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObject (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObjectMapper (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObjectNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObjectReader (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObjectWriter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOf (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOffsetDateTime (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOffsetTime (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOneway (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOpen (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOperator (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOptional (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOr (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOrEq (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOut (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTOverride (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPackage (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTParams (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPort (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPostfix (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrecedence (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrefix (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrint (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrintMembers (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrintf (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrivate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProtected (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProtocol (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPublic (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTQuicktype (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRaise (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRange (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTReadonly (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRegExp (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTReinterpretCast (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTNew (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObj5 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTKSerializer (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRestrict (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRetain (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTReturn (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSelfClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTShort (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSigned (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSizeof (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStatic (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStruct (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSwitch (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTrue (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTPrimitiveKind (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRepeat (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRequire (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRequired (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRequires (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRethrows (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRight (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTRuntimeType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTS (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSbyte (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSealed (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSel (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSelect (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSelf (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSendable (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSerialDescriptor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSerialName (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSerializable (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSerializationFeature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSerialize (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSerializerProvider (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSimpleModule (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStackalloc (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStandards (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStaticAssert (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStaticCast (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStdDeserializer (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStdSerializer (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTStrictfp (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTString (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSubscript (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSuper (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSymbol (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSynchronized (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTSystem (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTemplate (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTextNode (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTrueClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTThen (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTThis (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTThreadLocal (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTThrow (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTThrows (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTimeOnly (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTimeOnlyConverter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTimeZone (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTToDict (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTToJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTToString (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTopLevelClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTransient (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTObj6 (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypeClass (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypedef (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypeof (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnion (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnsigned (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVoid (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVolatile (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWhile (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTType (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypealias (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypeid (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTTypename (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUint (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUlong (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnchecked (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUndefined (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnmarshalJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnowned (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUnsafe (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUseSerializers (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUshort (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUsing (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUtf8JSONReader (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUtf8JSONWriter (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTUUID (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVar (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTVirtual (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWcharT (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWeak (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWhere (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWillSet (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTWith (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTXor (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTXorEq (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYes (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYield (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@implementation QTEnumValue
+ (NSDictionary<NSString *, QTEnumValue *> *)values
{
    static NSDictionary<NSString *, QTEnumValue *> *values;
    return values = values ? values : @{
        @"ready": [[QTEnumValue alloc] initWithValue:@"ready"],
        @"done": [[QTEnumValue alloc] initWithValue:@"done"],
    };
}

+ (QTEnumValue *)ready { return QTEnumValue.values[@"ready"]; }
+ (QTEnumValue *)done { return QTEnumValue.values[@"done"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTEnumValue.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
            result = [NSMutableArray arrayWithCapacity:[(NSArray *)collection count]];
            for (id x in collection) [result addObject:NSNullify(f(x))];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
            result = [NSMutableDictionary dictionaryWithCapacity:[(NSDictionary *)collection count]];
            for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

QTTopLevel *_Nullable QTTopLevelFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [QTTopLevel fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

QTTopLevel *_Nullable QTTopLevelFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return QTTopLevelFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable QTTopLevelToData(QTTopLevel *topLevel, NSError **error)
{
    @try {
        id json = [topLevel JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingFragmentsAllowed error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable QTTopLevelToJSON(QTTopLevel *topLevel, NSStringEncoding encoding, NSError **error)
{
    NSData *data = QTTopLevelToData(topLevel, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation QTTopLevel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dummy": @"dummy",
        @"obj1": @"obj1",
        @"obj2": @"obj2",
        @"obj3": @"obj3",
        @"obj4": @"obj4",
        @"obj5": @"obj5",
        @"obj6": @"obj6",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return QTTopLevelFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dummy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dummy"] doubleValue] != [dict[@"dummy"] longLongValue]) return nil;
        if (![dict[@"obj1"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"obj2"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"obj3"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"obj4"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"obj5"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"obj6"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _obj1 = [QTObj1 fromJSONDictionary:(id)_obj1];
        if (!_obj1 && dict[@"obj1"] && ![dict[@"obj1"] isKindOfClass:NSNull.class]) return nil;
        _obj2 = [QTObj2 fromJSONDictionary:(id)_obj2];
        if (!_obj2 && dict[@"obj2"] && ![dict[@"obj2"] isKindOfClass:NSNull.class]) return nil;
        _obj3 = [QTObj3 fromJSONDictionary:(id)_obj3];
        if (!_obj3 && dict[@"obj3"] && ![dict[@"obj3"] isKindOfClass:NSNull.class]) return nil;
        _obj4 = [QTObj4 fromJSONDictionary:(id)_obj4];
        if (!_obj4 && dict[@"obj4"] && ![dict[@"obj4"] isKindOfClass:NSNull.class]) return nil;
        _obj5 = [QTObj5 fromJSONDictionary:(id)_obj5];
        if (!_obj5 && dict[@"obj5"] && ![dict[@"obj5"] isKindOfClass:NSNull.class]) return nil;
        _obj6 = [QTObj6 fromJSONDictionary:(id)_obj6];
        if (!_obj6 && dict[@"obj6"] && ![dict[@"obj6"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevel.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"obj1": [_obj1 JSONDictionary],
        @"obj2": [_obj2 JSONDictionary],
        @"obj3": [_obj3 JSONDictionary],
        @"obj4": [_obj4 JSONDictionary],
        @"obj5": [_obj5 JSONDictionary],
        @"obj6": [_obj6 JSONDictionary],
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return QTTopLevelToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTTopLevelToJSON(self, encoding, error);
}
@end

@implementation QTObj1
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"abstract": @"abstract",
        @"alignas": @"alignas",
        @"alignof": @"alignof",
        @"and": @"and",
        @"and_eq": @"andEq",
        @"Any": @"any",
        @"array": @"array",
        @"ArrayNode": @"arrayNode",
        @"as": @"as",
        @"assert": @"assert",
        @"associatedtype": @"associatedtype",
        @"associativity": @"associativity",
        @"async": @"async",
        @"atomic_cancel": @"atomicCancel",
        @"atomic_commit": @"atomicCommit",
        @"atomic_noexcept": @"atomicNoexcept",
        @"await": @"await",
        @"base": @"base",
        @"bitand": @"bitand",
        @"bitor": @"bitor",
        @"boolean": @"boolean",
        @"BooleanNode": @"booleanNode",
        @"bycopy": @"bycopy",
        @"byref": @"byref",
        @"byte": @"byte",
        @"Calendar": @"calendar",
        @"catch": @"catch",
        @"chan": @"chan",
        @"char16_t": @"char16T",
        @"char32_t": @"char32T",
        @"checked": @"checked",
        @"Class": @"class",
        @"clone": @"clone",
        @"co_await": @"coAwait",
        @"co_return": @"coReturn",
        @"co_yield": @"coYield",
        @"Codable": @"codable",
        @"CodingKey": @"codingKey",
        @"CodingKeys": @"codingKeys",
        @"compl": @"compl",
        @"_Complex": @"complex",
        @"concept": @"concept",
        @"console": @"console",
        @"const_cast": @"constCast",
        @"constexpr": @"constexpr",
        @"constructor": @"constructor",
        @"convenience": @"convenience",
        @"convert": @"convert",
        @"converter": @"converter",
        @"dummy": @"dummy",
        @"_": @"empty",
        @"_Imaginery": @"imaginery",
        @"asm": @"obj1ASM",
        @"any": @"obj1Any",
        @"atomic": @"obj1Atomic",
        @"auto": @"obj1Auto",
        @"BOOL": @"obj1BOOL",
        @"_Bool": @"obj1Bool",
        @"break": @"obj1Break",
        @"case": @"obj1Case",
        @"char": @"obj1Char",
        @"class": @"obj1Class",
        @"const": @"obj1Const",
        @"continue": @"obj1Continue",
        @"bool": @"theBool",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObj1 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"abstract"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"alignas"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"alignof"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"and"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"and_eq"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Any"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"array"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ArrayNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"as"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"assert"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"associatedtype"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"associativity"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"async"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"atomic_cancel"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"atomic_commit"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"atomic_noexcept"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"await"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"base"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"bitand"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"bitor"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"boolean"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"BooleanNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"bycopy"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"byref"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"byte"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Calendar"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"catch"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"chan"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"char16_t"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"char32_t"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"checked"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Class"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"clone"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"co_await"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"co_return"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"co_yield"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Codable"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"CodingKey"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"CodingKeys"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"compl"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"_Complex"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"concept"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"console"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"const_cast"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"constexpr"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"constructor"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"convenience"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"convert"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"converter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"dummy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dummy"] doubleValue] != [dict[@"dummy"] longLongValue]) return nil;
        if (![dict[@"_"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"_Imaginery"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"asm"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"any"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"atomic"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"auto"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"BOOL"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"_Bool"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"break"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"case"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"char"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"class"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"const"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"continue"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"bool"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _abstract = [QTAbstract fromJSONDictionary:(id)_abstract];
        if (!_abstract && dict[@"abstract"] && ![dict[@"abstract"] isKindOfClass:NSNull.class]) return nil;
        _alignas = [QTAlignas fromJSONDictionary:(id)_alignas];
        if (!_alignas && dict[@"alignas"] && ![dict[@"alignas"] isKindOfClass:NSNull.class]) return nil;
        _alignof = [QTAlignof fromJSONDictionary:(id)_alignof];
        if (!_alignof && dict[@"alignof"] && ![dict[@"alignof"] isKindOfClass:NSNull.class]) return nil;
        _and = [QTAnd fromJSONDictionary:(id)_and];
        if (!_and && dict[@"and"] && ![dict[@"and"] isKindOfClass:NSNull.class]) return nil;
        _andEq = [QTAndEq fromJSONDictionary:(id)_andEq];
        if (!_andEq && dict[@"and_eq"] && ![dict[@"and_eq"] isKindOfClass:NSNull.class]) return nil;
        _any = [QTAny fromJSONDictionary:(id)_any];
        if (!_any && dict[@"Any"] && ![dict[@"Any"] isKindOfClass:NSNull.class]) return nil;
        _array = [QTArray fromJSONDictionary:(id)_array];
        if (!_array && dict[@"array"] && ![dict[@"array"] isKindOfClass:NSNull.class]) return nil;
        _arrayNode = [QTArrayNode fromJSONDictionary:(id)_arrayNode];
        if (!_arrayNode && dict[@"ArrayNode"] && ![dict[@"ArrayNode"] isKindOfClass:NSNull.class]) return nil;
        _as = [QTAs fromJSONDictionary:(id)_as];
        if (!_as && dict[@"as"] && ![dict[@"as"] isKindOfClass:NSNull.class]) return nil;
        _assert = [QTAssert fromJSONDictionary:(id)_assert];
        if (!_assert && dict[@"assert"] && ![dict[@"assert"] isKindOfClass:NSNull.class]) return nil;
        _associatedtype = [QTAssociatedtype fromJSONDictionary:(id)_associatedtype];
        if (!_associatedtype && dict[@"associatedtype"] && ![dict[@"associatedtype"] isKindOfClass:NSNull.class]) return nil;
        _associativity = [QTAssociativity fromJSONDictionary:(id)_associativity];
        if (!_associativity && dict[@"associativity"] && ![dict[@"associativity"] isKindOfClass:NSNull.class]) return nil;
        _async = [QTAsync fromJSONDictionary:(id)_async];
        if (!_async && dict[@"async"] && ![dict[@"async"] isKindOfClass:NSNull.class]) return nil;
        _atomicCancel = [QTAtomicCancel fromJSONDictionary:(id)_atomicCancel];
        if (!_atomicCancel && dict[@"atomic_cancel"] && ![dict[@"atomic_cancel"] isKindOfClass:NSNull.class]) return nil;
        _atomicCommit = [QTAtomicCommit fromJSONDictionary:(id)_atomicCommit];
        if (!_atomicCommit && dict[@"atomic_commit"] && ![dict[@"atomic_commit"] isKindOfClass:NSNull.class]) return nil;
        _atomicNoexcept = [QTAtomicNoexcept fromJSONDictionary:(id)_atomicNoexcept];
        if (!_atomicNoexcept && dict[@"atomic_noexcept"] && ![dict[@"atomic_noexcept"] isKindOfClass:NSNull.class]) return nil;
        _await = [QTAwait fromJSONDictionary:(id)_await];
        if (!_await && dict[@"await"] && ![dict[@"await"] isKindOfClass:NSNull.class]) return nil;
        _base = [QTBase fromJSONDictionary:(id)_base];
        if (!_base && dict[@"base"] && ![dict[@"base"] isKindOfClass:NSNull.class]) return nil;
        _bitand = [QTBitand fromJSONDictionary:(id)_bitand];
        if (!_bitand && dict[@"bitand"] && ![dict[@"bitand"] isKindOfClass:NSNull.class]) return nil;
        _bitor = [QTBitor fromJSONDictionary:(id)_bitor];
        if (!_bitor && dict[@"bitor"] && ![dict[@"bitor"] isKindOfClass:NSNull.class]) return nil;
        _boolean = [QTBoolean fromJSONDictionary:(id)_boolean];
        if (!_boolean && dict[@"boolean"] && ![dict[@"boolean"] isKindOfClass:NSNull.class]) return nil;
        _booleanNode = [QTBooleanNode fromJSONDictionary:(id)_booleanNode];
        if (!_booleanNode && dict[@"BooleanNode"] && ![dict[@"BooleanNode"] isKindOfClass:NSNull.class]) return nil;
        _bycopy = [QTBycopy fromJSONDictionary:(id)_bycopy];
        if (!_bycopy && dict[@"bycopy"] && ![dict[@"bycopy"] isKindOfClass:NSNull.class]) return nil;
        _byref = [QTByref fromJSONDictionary:(id)_byref];
        if (!_byref && dict[@"byref"] && ![dict[@"byref"] isKindOfClass:NSNull.class]) return nil;
        _byte = [QTByte fromJSONDictionary:(id)_byte];
        if (!_byte && dict[@"byte"] && ![dict[@"byte"] isKindOfClass:NSNull.class]) return nil;
        _calendar = [QTCalendar fromJSONDictionary:(id)_calendar];
        if (!_calendar && dict[@"Calendar"] && ![dict[@"Calendar"] isKindOfClass:NSNull.class]) return nil;
        _catch = [QTCatch fromJSONDictionary:(id)_catch];
        if (!_catch && dict[@"catch"] && ![dict[@"catch"] isKindOfClass:NSNull.class]) return nil;
        _chan = [QTChan fromJSONDictionary:(id)_chan];
        if (!_chan && dict[@"chan"] && ![dict[@"chan"] isKindOfClass:NSNull.class]) return nil;
        _char16T = [QTChar16T fromJSONDictionary:(id)_char16T];
        if (!_char16T && dict[@"char16_t"] && ![dict[@"char16_t"] isKindOfClass:NSNull.class]) return nil;
        _char32T = [QTChar32T fromJSONDictionary:(id)_char32T];
        if (!_char32T && dict[@"char32_t"] && ![dict[@"char32_t"] isKindOfClass:NSNull.class]) return nil;
        _checked = [QTChecked fromJSONDictionary:(id)_checked];
        if (!_checked && dict[@"checked"] && ![dict[@"checked"] isKindOfClass:NSNull.class]) return nil;
        _class = [QTClass fromJSONDictionary:(id)_class];
        if (!_class && dict[@"Class"] && ![dict[@"Class"] isKindOfClass:NSNull.class]) return nil;
        _clone = [QTClone fromJSONDictionary:(id)_clone];
        if (!_clone && dict[@"clone"] && ![dict[@"clone"] isKindOfClass:NSNull.class]) return nil;
        _coAwait = [QTCoAwait fromJSONDictionary:(id)_coAwait];
        if (!_coAwait && dict[@"co_await"] && ![dict[@"co_await"] isKindOfClass:NSNull.class]) return nil;
        _coReturn = [QTCoReturn fromJSONDictionary:(id)_coReturn];
        if (!_coReturn && dict[@"co_return"] && ![dict[@"co_return"] isKindOfClass:NSNull.class]) return nil;
        _coYield = [QTCoYield fromJSONDictionary:(id)_coYield];
        if (!_coYield && dict[@"co_yield"] && ![dict[@"co_yield"] isKindOfClass:NSNull.class]) return nil;
        _codable = [QTCodable fromJSONDictionary:(id)_codable];
        if (!_codable && dict[@"Codable"] && ![dict[@"Codable"] isKindOfClass:NSNull.class]) return nil;
        _codingKey = [QTCodingKey fromJSONDictionary:(id)_codingKey];
        if (!_codingKey && dict[@"CodingKey"] && ![dict[@"CodingKey"] isKindOfClass:NSNull.class]) return nil;
        _codingKeys = [QTCodingKeys fromJSONDictionary:(id)_codingKeys];
        if (!_codingKeys && dict[@"CodingKeys"] && ![dict[@"CodingKeys"] isKindOfClass:NSNull.class]) return nil;
        _compl = [QTCompl fromJSONDictionary:(id)_compl];
        if (!_compl && dict[@"compl"] && ![dict[@"compl"] isKindOfClass:NSNull.class]) return nil;
        _complex = [QTComplex fromJSONDictionary:(id)_complex];
        if (!_complex && dict[@"_Complex"] && ![dict[@"_Complex"] isKindOfClass:NSNull.class]) return nil;
        _concept = [QTConcept fromJSONDictionary:(id)_concept];
        if (!_concept && dict[@"concept"] && ![dict[@"concept"] isKindOfClass:NSNull.class]) return nil;
        _console = [QTConsole fromJSONDictionary:(id)_console];
        if (!_console && dict[@"console"] && ![dict[@"console"] isKindOfClass:NSNull.class]) return nil;
        _constCast = [QTConstCast fromJSONDictionary:(id)_constCast];
        if (!_constCast && dict[@"const_cast"] && ![dict[@"const_cast"] isKindOfClass:NSNull.class]) return nil;
        _constexpr = [QTConstexpr fromJSONDictionary:(id)_constexpr];
        if (!_constexpr && dict[@"constexpr"] && ![dict[@"constexpr"] isKindOfClass:NSNull.class]) return nil;
        _constructor = [QTConstructor fromJSONDictionary:(id)_constructor];
        if (!_constructor && dict[@"constructor"] && ![dict[@"constructor"] isKindOfClass:NSNull.class]) return nil;
        _convenience = [QTConvenience fromJSONDictionary:(id)_convenience];
        if (!_convenience && dict[@"convenience"] && ![dict[@"convenience"] isKindOfClass:NSNull.class]) return nil;
        _convert = [QTConvert fromJSONDictionary:(id)_convert];
        if (!_convert && dict[@"convert"] && ![dict[@"convert"] isKindOfClass:NSNull.class]) return nil;
        _converter = [QTConverter fromJSONDictionary:(id)_converter];
        if (!_converter && dict[@"converter"] && ![dict[@"converter"] isKindOfClass:NSNull.class]) return nil;
        _empty = [QTEmpty fromJSONDictionary:(id)_empty];
        if (!_empty && dict[@"_"] && ![dict[@"_"] isKindOfClass:NSNull.class]) return nil;
        _imaginery = [QTImaginery fromJSONDictionary:(id)_imaginery];
        if (!_imaginery && dict[@"_Imaginery"] && ![dict[@"_Imaginery"] isKindOfClass:NSNull.class]) return nil;
        _obj1ASM = [QTASM fromJSONDictionary:(id)_obj1ASM];
        if (!_obj1ASM && dict[@"asm"] && ![dict[@"asm"] isKindOfClass:NSNull.class]) return nil;
        _obj1Any = [QTAnyClass fromJSONDictionary:(id)_obj1Any];
        if (!_obj1Any && dict[@"any"] && ![dict[@"any"] isKindOfClass:NSNull.class]) return nil;
        _obj1Atomic = [QTAtomic fromJSONDictionary:(id)_obj1Atomic];
        if (!_obj1Atomic && dict[@"atomic"] && ![dict[@"atomic"] isKindOfClass:NSNull.class]) return nil;
        _obj1Auto = [QTAuto fromJSONDictionary:(id)_obj1Auto];
        if (!_obj1Auto && dict[@"auto"] && ![dict[@"auto"] isKindOfClass:NSNull.class]) return nil;
        _obj1BOOL = [QTBool fromJSONDictionary:(id)_obj1BOOL];
        if (!_obj1BOOL && dict[@"BOOL"] && ![dict[@"BOOL"] isKindOfClass:NSNull.class]) return nil;
        _obj1Bool = [QTBoolClass fromJSONDictionary:(id)_obj1Bool];
        if (!_obj1Bool && dict[@"_Bool"] && ![dict[@"_Bool"] isKindOfClass:NSNull.class]) return nil;
        _obj1Break = [QTBreak fromJSONDictionary:(id)_obj1Break];
        if (!_obj1Break && dict[@"break"] && ![dict[@"break"] isKindOfClass:NSNull.class]) return nil;
        _obj1Case = [QTCase fromJSONDictionary:(id)_obj1Case];
        if (!_obj1Case && dict[@"case"] && ![dict[@"case"] isKindOfClass:NSNull.class]) return nil;
        _obj1Char = [QTChar fromJSONDictionary:(id)_obj1Char];
        if (!_obj1Char && dict[@"char"] && ![dict[@"char"] isKindOfClass:NSNull.class]) return nil;
        _obj1Class = [QTClassClass fromJSONDictionary:(id)_obj1Class];
        if (!_obj1Class && dict[@"class"] && ![dict[@"class"] isKindOfClass:NSNull.class]) return nil;
        _obj1Const = [QTConst fromJSONDictionary:(id)_obj1Const];
        if (!_obj1Const && dict[@"const"] && ![dict[@"const"] isKindOfClass:NSNull.class]) return nil;
        _obj1Continue = [QTContinue fromJSONDictionary:(id)_obj1Continue];
        if (!_obj1Continue && dict[@"continue"] && ![dict[@"continue"] isKindOfClass:NSNull.class]) return nil;
        _theBool = [QTObj1Bool fromJSONDictionary:(id)_theBool];
        if (!_theBool && dict[@"bool"] && ![dict[@"bool"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObj1.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObj1.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObj1.properties.allValues] mutableCopy];

    for (id jsonName in QTObj1.properties) {
        id propertyName = QTObj1.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"abstract": [_abstract JSONDictionary],
        @"alignas": [_alignas JSONDictionary],
        @"alignof": [_alignof JSONDictionary],
        @"and": [_and JSONDictionary],
        @"and_eq": [_andEq JSONDictionary],
        @"Any": [_any JSONDictionary],
        @"array": [_array JSONDictionary],
        @"ArrayNode": [_arrayNode JSONDictionary],
        @"as": [_as JSONDictionary],
        @"assert": [_assert JSONDictionary],
        @"associatedtype": [_associatedtype JSONDictionary],
        @"associativity": [_associativity JSONDictionary],
        @"async": [_async JSONDictionary],
        @"atomic_cancel": [_atomicCancel JSONDictionary],
        @"atomic_commit": [_atomicCommit JSONDictionary],
        @"atomic_noexcept": [_atomicNoexcept JSONDictionary],
        @"await": [_await JSONDictionary],
        @"base": [_base JSONDictionary],
        @"bitand": [_bitand JSONDictionary],
        @"bitor": [_bitor JSONDictionary],
        @"boolean": [_boolean JSONDictionary],
        @"BooleanNode": [_booleanNode JSONDictionary],
        @"bycopy": [_bycopy JSONDictionary],
        @"byref": [_byref JSONDictionary],
        @"byte": [_byte JSONDictionary],
        @"Calendar": [_calendar JSONDictionary],
        @"catch": [_catch JSONDictionary],
        @"chan": [_chan JSONDictionary],
        @"char16_t": [_char16T JSONDictionary],
        @"char32_t": [_char32T JSONDictionary],
        @"checked": [_checked JSONDictionary],
        @"Class": [_class JSONDictionary],
        @"clone": [_clone JSONDictionary],
        @"co_await": [_coAwait JSONDictionary],
        @"co_return": [_coReturn JSONDictionary],
        @"co_yield": [_coYield JSONDictionary],
        @"Codable": [_codable JSONDictionary],
        @"CodingKey": [_codingKey JSONDictionary],
        @"CodingKeys": [_codingKeys JSONDictionary],
        @"compl": [_compl JSONDictionary],
        @"_Complex": [_complex JSONDictionary],
        @"concept": [_concept JSONDictionary],
        @"console": [_console JSONDictionary],
        @"const_cast": [_constCast JSONDictionary],
        @"constexpr": [_constexpr JSONDictionary],
        @"constructor": [_constructor JSONDictionary],
        @"convenience": [_convenience JSONDictionary],
        @"convert": [_convert JSONDictionary],
        @"converter": [_converter JSONDictionary],
        @"_": [_empty JSONDictionary],
        @"_Imaginery": [_imaginery JSONDictionary],
        @"asm": [_obj1ASM JSONDictionary],
        @"any": [_obj1Any JSONDictionary],
        @"atomic": [_obj1Atomic JSONDictionary],
        @"auto": [_obj1Auto JSONDictionary],
        @"BOOL": [_obj1BOOL JSONDictionary],
        @"_Bool": [_obj1Bool JSONDictionary],
        @"break": [_obj1Break JSONDictionary],
        @"case": [_obj1Case JSONDictionary],
        @"char": [_obj1Char JSONDictionary],
        @"class": [_obj1Class JSONDictionary],
        @"const": [_obj1Const JSONDictionary],
        @"continue": [_obj1Continue JSONDictionary],
        @"bool": [_theBool JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTAbstract
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"abstract": @"abstract",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAbstract alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"abstract"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"abstract"] doubleValue] != [dict[@"abstract"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAbstract.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAbstract.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAbstract.properties.allValues];
}
@end

@implementation QTAlignas
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"alignas": @"alignas",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAlignas alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"alignas"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"alignas"] doubleValue] != [dict[@"alignas"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAlignas.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAlignas.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAlignas.properties.allValues];
}
@end

@implementation QTAlignof
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"alignof": @"alignof",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAlignof alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"alignof"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"alignof"] doubleValue] != [dict[@"alignof"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAlignof.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAlignof.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAlignof.properties.allValues];
}
@end

@implementation QTAnd
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"and": @"and",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAnd alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"and"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"and"] doubleValue] != [dict[@"and"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAnd.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAnd.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAnd.properties.allValues];
}
@end

@implementation QTAndEq
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"and_eq": @"andEq",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAndEq alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"and_eq"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"and_eq"] doubleValue] != [dict[@"and_eq"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAndEq.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAndEq.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAndEq.properties.allValues] mutableCopy];

    for (id jsonName in QTAndEq.properties) {
        id propertyName = QTAndEq.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAny
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Any": @"any",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAny alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Any"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Any"] doubleValue] != [dict[@"Any"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAny.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAny.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAny.properties.allValues] mutableCopy];

    for (id jsonName in QTAny.properties) {
        id propertyName = QTAny.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTArray
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"array": @"array",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTArray alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"array"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"array"] doubleValue] != [dict[@"array"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTArray.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTArray.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTArray.properties.allValues];
}
@end

@implementation QTArrayNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ArrayNode": @"arrayNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTArrayNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ArrayNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ArrayNode"] doubleValue] != [dict[@"ArrayNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTArrayNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTArrayNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTArrayNode.properties.allValues] mutableCopy];

    for (id jsonName in QTArrayNode.properties) {
        id propertyName = QTArrayNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAs
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"as": @"as",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAs alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"as"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"as"] doubleValue] != [dict[@"as"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAs.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAs.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAs.properties.allValues];
}
@end

@implementation QTAssert
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"assert": @"assert",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAssert alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"assert"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"assert"] doubleValue] != [dict[@"assert"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAssert.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAssert.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAssert.properties.allValues];
}
@end

@implementation QTAssociatedtype
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"associatedtype": @"associatedtype",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAssociatedtype alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"associatedtype"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"associatedtype"] doubleValue] != [dict[@"associatedtype"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAssociatedtype.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAssociatedtype.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAssociatedtype.properties.allValues];
}
@end

@implementation QTAssociativity
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"associativity": @"associativity",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAssociativity alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"associativity"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"associativity"] doubleValue] != [dict[@"associativity"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAssociativity.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAssociativity.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAssociativity.properties.allValues];
}
@end

@implementation QTAsync
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"async": @"async",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAsync alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"async"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"async"] doubleValue] != [dict[@"async"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAsync.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAsync.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAsync.properties.allValues];
}
@end

@implementation QTAtomicCancel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"atomic_cancel": @"atomicCancel",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAtomicCancel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"atomic_cancel"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"atomic_cancel"] doubleValue] != [dict[@"atomic_cancel"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAtomicCancel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAtomicCancel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAtomicCancel.properties.allValues] mutableCopy];

    for (id jsonName in QTAtomicCancel.properties) {
        id propertyName = QTAtomicCancel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAtomicCommit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"atomic_commit": @"atomicCommit",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAtomicCommit alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"atomic_commit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"atomic_commit"] doubleValue] != [dict[@"atomic_commit"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAtomicCommit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAtomicCommit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAtomicCommit.properties.allValues] mutableCopy];

    for (id jsonName in QTAtomicCommit.properties) {
        id propertyName = QTAtomicCommit.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAtomicNoexcept
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"atomic_noexcept": @"atomicNoexcept",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAtomicNoexcept alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"atomic_noexcept"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"atomic_noexcept"] doubleValue] != [dict[@"atomic_noexcept"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAtomicNoexcept.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAtomicNoexcept.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAtomicNoexcept.properties.allValues] mutableCopy];

    for (id jsonName in QTAtomicNoexcept.properties) {
        id propertyName = QTAtomicNoexcept.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAwait
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"await": @"await",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAwait alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"await"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"await"] doubleValue] != [dict[@"await"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAwait.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAwait.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAwait.properties.allValues];
}
@end

@implementation QTBase
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"base": @"base",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBase alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"base"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"base"] doubleValue] != [dict[@"base"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBase.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBase.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTBase.properties.allValues];
}
@end

@implementation QTBitand
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bitand": @"bitand",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBitand alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"bitand"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"bitand"] doubleValue] != [dict[@"bitand"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBitand.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBitand.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTBitand.properties.allValues];
}
@end

@implementation QTBitor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bitor": @"bitor",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBitor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"bitor"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"bitor"] doubleValue] != [dict[@"bitor"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBitor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBitor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTBitor.properties.allValues];
}
@end

@implementation QTBoolean
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"boolean": @"boolean",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBoolean alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"boolean"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"boolean"] doubleValue] != [dict[@"boolean"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBoolean.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBoolean.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTBoolean.properties.allValues];
}
@end

@implementation QTBooleanNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"BooleanNode": @"booleanNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBooleanNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"BooleanNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"BooleanNode"] doubleValue] != [dict[@"BooleanNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBooleanNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBooleanNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBooleanNode.properties.allValues] mutableCopy];

    for (id jsonName in QTBooleanNode.properties) {
        id propertyName = QTBooleanNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTBycopy
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bycopy": @"bycopy",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBycopy alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"bycopy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"bycopy"] doubleValue] != [dict[@"bycopy"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBycopy.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBycopy.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTBycopy.properties.allValues];
}
@end

@implementation QTByref
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"byref": @"byref",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTByref alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"byref"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"byref"] doubleValue] != [dict[@"byref"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTByref.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTByref.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTByref.properties.allValues];
}
@end

@implementation QTByte
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"byte": @"byte",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTByte alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"byte"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"byte"] doubleValue] != [dict[@"byte"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTByte.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTByte.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTByte.properties.allValues];
}
@end

@implementation QTCalendar
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Calendar": @"calendar",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCalendar alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Calendar"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Calendar"] doubleValue] != [dict[@"Calendar"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCalendar.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCalendar.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCalendar.properties.allValues] mutableCopy];

    for (id jsonName in QTCalendar.properties) {
        id propertyName = QTCalendar.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCatch
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"catch": @"catch",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCatch alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"catch"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"catch"] doubleValue] != [dict[@"catch"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCatch.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCatch.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCatch.properties.allValues];
}
@end

@implementation QTChan
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"chan": @"chan",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChan alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"chan"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"chan"] doubleValue] != [dict[@"chan"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChan.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChan.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTChan.properties.allValues];
}
@end

@implementation QTChar16T
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"char16_t": @"char16T",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChar16T alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"char16_t"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"char16_t"] doubleValue] != [dict[@"char16_t"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChar16T.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChar16T.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChar16T.properties.allValues] mutableCopy];

    for (id jsonName in QTChar16T.properties) {
        id propertyName = QTChar16T.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTChar32T
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"char32_t": @"char32T",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChar32T alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"char32_t"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"char32_t"] doubleValue] != [dict[@"char32_t"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChar32T.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChar32T.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChar32T.properties.allValues] mutableCopy];

    for (id jsonName in QTChar32T.properties) {
        id propertyName = QTChar32T.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTChecked
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"checked": @"checked",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChecked alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"checked"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"checked"] doubleValue] != [dict[@"checked"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChecked.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChecked.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTChecked.properties.allValues];
}
@end

@implementation QTClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Class": @"class",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Class"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Class"] doubleValue] != [dict[@"Class"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTClass.properties.allValues] mutableCopy];

    for (id jsonName in QTClass.properties) {
        id propertyName = QTClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTClone
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"clone": @"clone",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTClone alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"clone"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"clone"] doubleValue] != [dict[@"clone"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTClone.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTClone.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTClone.properties.allValues];
}
@end

@implementation QTCoAwait
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"co_await": @"coAwait",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCoAwait alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"co_await"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"co_await"] doubleValue] != [dict[@"co_await"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCoAwait.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCoAwait.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCoAwait.properties.allValues] mutableCopy];

    for (id jsonName in QTCoAwait.properties) {
        id propertyName = QTCoAwait.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCoReturn
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"co_return": @"coReturn",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCoReturn alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"co_return"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"co_return"] doubleValue] != [dict[@"co_return"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCoReturn.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCoReturn.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCoReturn.properties.allValues] mutableCopy];

    for (id jsonName in QTCoReturn.properties) {
        id propertyName = QTCoReturn.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCoYield
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"co_yield": @"coYield",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCoYield alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"co_yield"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"co_yield"] doubleValue] != [dict[@"co_yield"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCoYield.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCoYield.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCoYield.properties.allValues] mutableCopy];

    for (id jsonName in QTCoYield.properties) {
        id propertyName = QTCoYield.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCodable
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Codable": @"codable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCodable alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Codable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Codable"] doubleValue] != [dict[@"Codable"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCodable.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCodable.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCodable.properties.allValues] mutableCopy];

    for (id jsonName in QTCodable.properties) {
        id propertyName = QTCodable.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCodingKey
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"CodingKey": @"codingKey",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCodingKey alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"CodingKey"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"CodingKey"] doubleValue] != [dict[@"CodingKey"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCodingKey.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCodingKey.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCodingKey.properties.allValues] mutableCopy];

    for (id jsonName in QTCodingKey.properties) {
        id propertyName = QTCodingKey.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCodingKeys
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"CodingKeys": @"codingKeys",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCodingKeys alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"CodingKeys"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"CodingKeys"] doubleValue] != [dict[@"CodingKeys"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCodingKeys.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCodingKeys.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCodingKeys.properties.allValues] mutableCopy];

    for (id jsonName in QTCodingKeys.properties) {
        id propertyName = QTCodingKeys.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCompl
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"compl": @"compl",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCompl alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"compl"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"compl"] doubleValue] != [dict[@"compl"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCompl.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCompl.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTCompl.properties.allValues];
}
@end

@implementation QTComplex
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"_Complex": @"complex",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTComplex alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"_Complex"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"_Complex"] doubleValue] != [dict[@"_Complex"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTComplex.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTComplex.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTComplex.properties.allValues] mutableCopy];

    for (id jsonName in QTComplex.properties) {
        id propertyName = QTComplex.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTConcept
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"concept": @"concept",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConcept alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"concept"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"concept"] doubleValue] != [dict[@"concept"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConcept.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConcept.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConcept.properties.allValues];
}
@end

@implementation QTConsole
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"console": @"console",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConsole alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"console"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"console"] doubleValue] != [dict[@"console"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConsole.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConsole.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConsole.properties.allValues];
}
@end

@implementation QTConstCast
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"const_cast": @"constCast",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConstCast alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"const_cast"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"const_cast"] doubleValue] != [dict[@"const_cast"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConstCast.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConstCast.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConstCast.properties.allValues] mutableCopy];

    for (id jsonName in QTConstCast.properties) {
        id propertyName = QTConstCast.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTConstexpr
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"constexpr": @"constexpr",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConstexpr alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"constexpr"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"constexpr"] doubleValue] != [dict[@"constexpr"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConstexpr.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConstexpr.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConstexpr.properties.allValues];
}
@end

@implementation QTConstructor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"constructor": @"constructor",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConstructor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"constructor"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"constructor"] doubleValue] != [dict[@"constructor"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConstructor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConstructor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConstructor.properties.allValues];
}
@end

@implementation QTConvenience
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"convenience": @"convenience",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConvenience alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"convenience"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"convenience"] doubleValue] != [dict[@"convenience"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConvenience.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConvenience.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConvenience.properties.allValues];
}
@end

@implementation QTConvert
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"convert": @"convert",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConvert alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"convert"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"convert"] doubleValue] != [dict[@"convert"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConvert.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConvert.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConvert.properties.allValues];
}
@end

@implementation QTConverter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"converter": @"converter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConverter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"converter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"converter"] doubleValue] != [dict[@"converter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConverter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConverter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTConverter.properties.allValues];
}
@end

@implementation QTEmpty
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"_": @"empty",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEmpty alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"_"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"_"] doubleValue] != [dict[@"_"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEmpty.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEmpty.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEmpty.properties.allValues] mutableCopy];

    for (id jsonName in QTEmpty.properties) {
        id propertyName = QTEmpty.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTImaginery
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"_Imaginery": @"imaginery",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImaginery alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"_Imaginery"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"_Imaginery"] doubleValue] != [dict[@"_Imaginery"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTImaginery.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTImaginery.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTImaginery.properties.allValues] mutableCopy];

    for (id jsonName in QTImaginery.properties) {
        id propertyName = QTImaginery.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTASM
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"asm": @"asmASM",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTASM alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"asm"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"asm"] doubleValue] != [dict[@"asm"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTASM.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTASM.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTASM.properties.allValues] mutableCopy];

    for (id jsonName in QTASM.properties) {
        id propertyName = QTASM.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAnyClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"any": @"any",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAnyClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"any"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"any"] doubleValue] != [dict[@"any"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAnyClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAnyClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTAnyClass.properties.allValues];
}
@end

@implementation QTAtomic
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"atomic": @"atomicAtomic",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAtomic alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"atomic"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"atomic"] doubleValue] != [dict[@"atomic"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAtomic.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAtomic.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAtomic.properties.allValues] mutableCopy];

    for (id jsonName in QTAtomic.properties) {
        id propertyName = QTAtomic.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTAuto
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"auto": @"autoAuto",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTAuto alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"auto"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"auto"] doubleValue] != [dict[@"auto"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTAuto.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTAuto.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTAuto.properties.allValues] mutableCopy];

    for (id jsonName in QTAuto.properties) {
        id propertyName = QTAuto.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTBool
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"BOOL": @"boolBool",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBool alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"BOOL"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"BOOL"] doubleValue] != [dict[@"BOOL"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBool.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBool.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBool.properties.allValues] mutableCopy];

    for (id jsonName in QTBool.properties) {
        id propertyName = QTBool.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTBoolClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"_Bool": @"boolBool",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBoolClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"_Bool"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"_Bool"] doubleValue] != [dict[@"_Bool"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBoolClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBoolClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBoolClass.properties.allValues] mutableCopy];

    for (id jsonName in QTBoolClass.properties) {
        id propertyName = QTBoolClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTBreak
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"break": @"breakBreak",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTBreak alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"break"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"break"] doubleValue] != [dict[@"break"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBreak.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBreak.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBreak.properties.allValues] mutableCopy];

    for (id jsonName in QTBreak.properties) {
        id propertyName = QTBreak.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTCase
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"case": @"caseCase",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCase alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"case"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"case"] doubleValue] != [dict[@"case"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCase.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCase.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCase.properties.allValues] mutableCopy];

    for (id jsonName in QTCase.properties) {
        id propertyName = QTCase.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTChar
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"char": @"charChar",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTChar alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"char"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"char"] doubleValue] != [dict[@"char"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTChar.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTChar.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTChar.properties.allValues] mutableCopy];

    for (id jsonName in QTChar.properties) {
        id propertyName = QTChar.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTClassClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"class": @"class",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTClassClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"class"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"class"] doubleValue] != [dict[@"class"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTClassClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTClassClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTClassClass.properties.allValues];
}
@end

@implementation QTConst
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"const": @"constConst",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTConst alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"const"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"const"] doubleValue] != [dict[@"const"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTConst.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTConst.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTConst.properties.allValues] mutableCopy];

    for (id jsonName in QTConst.properties) {
        id propertyName = QTConst.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTContinue
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"continue": @"continueContinue",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTContinue alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"continue"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"continue"] doubleValue] != [dict[@"continue"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTContinue.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTContinue.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTContinue.properties.allValues] mutableCopy];

    for (id jsonName in QTContinue.properties) {
        id propertyName = QTContinue.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObj1Bool
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"bool": @"boolBool",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObj1Bool alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"bool"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"bool"] doubleValue] != [dict[@"bool"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObj1Bool.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObj1Bool.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObj1Bool.properties.allValues] mutableCopy];

    for (id jsonName in QTObj1Bool.properties) {
        id propertyName = QTObj1Bool.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObj2
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"CultureInfo": @"cultureInfo",
        @"date": @"date",
        @"DateFormatter": @"dateFormatter",
        @"DateOnly": @"dateOnly",
        @"DateOnlyConverter": @"dateOnlyConverter",
        @"date_parse_handling": @"dateParseHandling",
        @"DateTime": @"dateTime",
        @"DateTimeStyles": @"dateTimeStyles",
        @"debugger": @"debugger",
        @"decimal": @"decimal",
        @"declare": @"declare",
        @"decltype": @"decltype",
        @"decode_string": @"decodeString",
        @"Decoder": @"decoder",
        @"DecodingError": @"decodingError",
        @"def": @"def",
        @"defer": @"defer",
        @"deinit": @"deinit",
        @"del": @"del",
        @"delegate": @"delegate",
        @"delete": @"delete",
        @"DeserializationFeature": @"deserializationFeature",
        @"dict": @"dict",
        @"dictionary": @"dictionary",
        @"didSet": @"didSet",
        @"DoubleNode": @"doubleNode",
        @"dummy": @"dummy",
        @"dynamic": @"dynamic",
        @"dynamic_cast": @"dynamicCast",
        @"elif": @"elif",
        @"encode_quick_type": @"encodeQuickType",
        @"Encoder": @"encoder",
        @"EnumValues": @"enumValues",
        @"equalityContract": @"equalityContract",
        @"Equatable": @"equatable",
        @"event": @"event",
        @"except": @"except",
        @"exception": @"exception",
        @"explicit": @"explicit",
        @"export": @"export",
        @"exposing": @"exposing",
        @"extends": @"extends",
        @"extension": @"extension",
        @"fallthrough": @"fallthrough",
        @"fileprivate": @"fileprivate",
        @"final": @"final",
        @"finally": @"finally",
        @"fixed": @"fixed",
        @"foreach": @"foreach",
        @"FormatException": @"formatException",
        @"friend": @"friend",
        @"from": @"from",
        @"from_dict": @"fromDict",
        @"from_json": @"fromJSON",
        @"func": @"func",
        @"default": @"obj2Default",
        @"do": @"obj2Do",
        @"double": @"obj2Double",
        @"else": @"obj2Else",
        @"enum": @"obj2Enum",
        @"extern": @"obj2Extern",
        @"False": @"obj2False",
        @"float": @"obj2Float",
        @"for": @"obj2For",
        @"false": @"theFalse",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObj2 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"CultureInfo"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"date"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DateFormatter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DateOnly"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DateOnlyConverter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"date_parse_handling"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DateTime"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DateTimeStyles"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"debugger"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"decimal"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"declare"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"decltype"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"decode_string"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Decoder"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DecodingError"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"def"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"defer"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"deinit"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"del"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"delegate"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"delete"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DeserializationFeature"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"dict"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"dictionary"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"didSet"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"DoubleNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"dummy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dummy"] doubleValue] != [dict[@"dummy"] longLongValue]) return nil;
        if (![dict[@"dynamic"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"dynamic_cast"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"elif"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"encode_quick_type"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Encoder"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"EnumValues"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"equalityContract"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Equatable"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"event"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"except"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"exception"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"explicit"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"export"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"exposing"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"extends"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"extension"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fallthrough"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fileprivate"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"final"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"finally"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"fixed"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"foreach"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"FormatException"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"friend"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"from"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"from_dict"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"from_json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"func"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"default"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"do"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"double"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"else"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"enum"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"extern"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"False"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"float"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"for"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"false"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _cultureInfo = [QTCultureInfo fromJSONDictionary:(id)_cultureInfo];
        if (!_cultureInfo && dict[@"CultureInfo"] && ![dict[@"CultureInfo"] isKindOfClass:NSNull.class]) return nil;
        _date = [QTDate fromJSONDictionary:(id)_date];
        if (!_date && dict[@"date"] && ![dict[@"date"] isKindOfClass:NSNull.class]) return nil;
        _dateFormatter = [QTDateFormatter fromJSONDictionary:(id)_dateFormatter];
        if (!_dateFormatter && dict[@"DateFormatter"] && ![dict[@"DateFormatter"] isKindOfClass:NSNull.class]) return nil;
        _dateOnly = [QTDateOnly fromJSONDictionary:(id)_dateOnly];
        if (!_dateOnly && dict[@"DateOnly"] && ![dict[@"DateOnly"] isKindOfClass:NSNull.class]) return nil;
        _dateOnlyConverter = [QTDateOnlyConverter fromJSONDictionary:(id)_dateOnlyConverter];
        if (!_dateOnlyConverter && dict[@"DateOnlyConverter"] && ![dict[@"DateOnlyConverter"] isKindOfClass:NSNull.class]) return nil;
        _dateParseHandling = [QTDateParseHandling fromJSONDictionary:(id)_dateParseHandling];
        if (!_dateParseHandling && dict[@"date_parse_handling"] && ![dict[@"date_parse_handling"] isKindOfClass:NSNull.class]) return nil;
        _dateTime = [QTDateTime fromJSONDictionary:(id)_dateTime];
        if (!_dateTime && dict[@"DateTime"] && ![dict[@"DateTime"] isKindOfClass:NSNull.class]) return nil;
        _dateTimeStyles = [QTDateTimeStyles fromJSONDictionary:(id)_dateTimeStyles];
        if (!_dateTimeStyles && dict[@"DateTimeStyles"] && ![dict[@"DateTimeStyles"] isKindOfClass:NSNull.class]) return nil;
        _debugger = [QTDebugger fromJSONDictionary:(id)_debugger];
        if (!_debugger && dict[@"debugger"] && ![dict[@"debugger"] isKindOfClass:NSNull.class]) return nil;
        _decimal = [QTDecimal fromJSONDictionary:(id)_decimal];
        if (!_decimal && dict[@"decimal"] && ![dict[@"decimal"] isKindOfClass:NSNull.class]) return nil;
        _declare = [QTDeclare fromJSONDictionary:(id)_declare];
        if (!_declare && dict[@"declare"] && ![dict[@"declare"] isKindOfClass:NSNull.class]) return nil;
        _decltype = [QTDecltype fromJSONDictionary:(id)_decltype];
        if (!_decltype && dict[@"decltype"] && ![dict[@"decltype"] isKindOfClass:NSNull.class]) return nil;
        _decodeString = [QTDecodeString fromJSONDictionary:(id)_decodeString];
        if (!_decodeString && dict[@"decode_string"] && ![dict[@"decode_string"] isKindOfClass:NSNull.class]) return nil;
        _decoder = [QTDecoder fromJSONDictionary:(id)_decoder];
        if (!_decoder && dict[@"Decoder"] && ![dict[@"Decoder"] isKindOfClass:NSNull.class]) return nil;
        _decodingError = [QTDecodingError fromJSONDictionary:(id)_decodingError];
        if (!_decodingError && dict[@"DecodingError"] && ![dict[@"DecodingError"] isKindOfClass:NSNull.class]) return nil;
        _def = [QTDef fromJSONDictionary:(id)_def];
        if (!_def && dict[@"def"] && ![dict[@"def"] isKindOfClass:NSNull.class]) return nil;
        _defer = [QTDefer fromJSONDictionary:(id)_defer];
        if (!_defer && dict[@"defer"] && ![dict[@"defer"] isKindOfClass:NSNull.class]) return nil;
        _deinit = [QTDeinit fromJSONDictionary:(id)_deinit];
        if (!_deinit && dict[@"deinit"] && ![dict[@"deinit"] isKindOfClass:NSNull.class]) return nil;
        _del = [QTDel fromJSONDictionary:(id)_del];
        if (!_del && dict[@"del"] && ![dict[@"del"] isKindOfClass:NSNull.class]) return nil;
        _delegate = [QTDelegate fromJSONDictionary:(id)_delegate];
        if (!_delegate && dict[@"delegate"] && ![dict[@"delegate"] isKindOfClass:NSNull.class]) return nil;
        _delete = [QTDelete fromJSONDictionary:(id)_delete];
        if (!_delete && dict[@"delete"] && ![dict[@"delete"] isKindOfClass:NSNull.class]) return nil;
        _deserializationFeature = [QTDeserializationFeature fromJSONDictionary:(id)_deserializationFeature];
        if (!_deserializationFeature && dict[@"DeserializationFeature"] && ![dict[@"DeserializationFeature"] isKindOfClass:NSNull.class]) return nil;
        _dict = [QTDict fromJSONDictionary:(id)_dict];
        if (!_dict && dict[@"dict"] && ![dict[@"dict"] isKindOfClass:NSNull.class]) return nil;
        _dictionary = [QTDictionary fromJSONDictionary:(id)_dictionary];
        if (!_dictionary && dict[@"dictionary"] && ![dict[@"dictionary"] isKindOfClass:NSNull.class]) return nil;
        _didSet = [QTDidSet fromJSONDictionary:(id)_didSet];
        if (!_didSet && dict[@"didSet"] && ![dict[@"didSet"] isKindOfClass:NSNull.class]) return nil;
        _doubleNode = [QTDoubleNode fromJSONDictionary:(id)_doubleNode];
        if (!_doubleNode && dict[@"DoubleNode"] && ![dict[@"DoubleNode"] isKindOfClass:NSNull.class]) return nil;
        _dynamic = [QTDynamic fromJSONDictionary:(id)_dynamic];
        if (!_dynamic && dict[@"dynamic"] && ![dict[@"dynamic"] isKindOfClass:NSNull.class]) return nil;
        _dynamicCast = [QTDynamicCast fromJSONDictionary:(id)_dynamicCast];
        if (!_dynamicCast && dict[@"dynamic_cast"] && ![dict[@"dynamic_cast"] isKindOfClass:NSNull.class]) return nil;
        _elif = [QTElif fromJSONDictionary:(id)_elif];
        if (!_elif && dict[@"elif"] && ![dict[@"elif"] isKindOfClass:NSNull.class]) return nil;
        _encodeQuickType = [QTEncodeQuickType fromJSONDictionary:(id)_encodeQuickType];
        if (!_encodeQuickType && dict[@"encode_quick_type"] && ![dict[@"encode_quick_type"] isKindOfClass:NSNull.class]) return nil;
        _encoder = [QTEncoder fromJSONDictionary:(id)_encoder];
        if (!_encoder && dict[@"Encoder"] && ![dict[@"Encoder"] isKindOfClass:NSNull.class]) return nil;
        _enumValues = [QTEnumValues fromJSONDictionary:(id)_enumValues];
        if (!_enumValues && dict[@"EnumValues"] && ![dict[@"EnumValues"] isKindOfClass:NSNull.class]) return nil;
        _equalityContract = [QTEqualityContract fromJSONDictionary:(id)_equalityContract];
        if (!_equalityContract && dict[@"equalityContract"] && ![dict[@"equalityContract"] isKindOfClass:NSNull.class]) return nil;
        _equatable = [QTEquatable fromJSONDictionary:(id)_equatable];
        if (!_equatable && dict[@"Equatable"] && ![dict[@"Equatable"] isKindOfClass:NSNull.class]) return nil;
        _event = [QTEvent fromJSONDictionary:(id)_event];
        if (!_event && dict[@"event"] && ![dict[@"event"] isKindOfClass:NSNull.class]) return nil;
        _except = [QTExcept fromJSONDictionary:(id)_except];
        if (!_except && dict[@"except"] && ![dict[@"except"] isKindOfClass:NSNull.class]) return nil;
        _exception = [QTException fromJSONDictionary:(id)_exception];
        if (!_exception && dict[@"exception"] && ![dict[@"exception"] isKindOfClass:NSNull.class]) return nil;
        _explicit = [QTExplicit fromJSONDictionary:(id)_explicit];
        if (!_explicit && dict[@"explicit"] && ![dict[@"explicit"] isKindOfClass:NSNull.class]) return nil;
        _export = [QTExport fromJSONDictionary:(id)_export];
        if (!_export && dict[@"export"] && ![dict[@"export"] isKindOfClass:NSNull.class]) return nil;
        _exposing = [QTExposing fromJSONDictionary:(id)_exposing];
        if (!_exposing && dict[@"exposing"] && ![dict[@"exposing"] isKindOfClass:NSNull.class]) return nil;
        _extends = [QTExtends fromJSONDictionary:(id)_extends];
        if (!_extends && dict[@"extends"] && ![dict[@"extends"] isKindOfClass:NSNull.class]) return nil;
        _extension = [QTExtension fromJSONDictionary:(id)_extension];
        if (!_extension && dict[@"extension"] && ![dict[@"extension"] isKindOfClass:NSNull.class]) return nil;
        _fallthrough = [QTFallthrough fromJSONDictionary:(id)_fallthrough];
        if (!_fallthrough && dict[@"fallthrough"] && ![dict[@"fallthrough"] isKindOfClass:NSNull.class]) return nil;
        _fileprivate = [QTFileprivate fromJSONDictionary:(id)_fileprivate];
        if (!_fileprivate && dict[@"fileprivate"] && ![dict[@"fileprivate"] isKindOfClass:NSNull.class]) return nil;
        _final = [QTFinal fromJSONDictionary:(id)_final];
        if (!_final && dict[@"final"] && ![dict[@"final"] isKindOfClass:NSNull.class]) return nil;
        _finally = [QTFinally fromJSONDictionary:(id)_finally];
        if (!_finally && dict[@"finally"] && ![dict[@"finally"] isKindOfClass:NSNull.class]) return nil;
        _fixed = [QTFixed fromJSONDictionary:(id)_fixed];
        if (!_fixed && dict[@"fixed"] && ![dict[@"fixed"] isKindOfClass:NSNull.class]) return nil;
        _foreach = [QTForeach fromJSONDictionary:(id)_foreach];
        if (!_foreach && dict[@"foreach"] && ![dict[@"foreach"] isKindOfClass:NSNull.class]) return nil;
        _formatException = [QTFormatException fromJSONDictionary:(id)_formatException];
        if (!_formatException && dict[@"FormatException"] && ![dict[@"FormatException"] isKindOfClass:NSNull.class]) return nil;
        _friend = [QTFriend fromJSONDictionary:(id)_friend];
        if (!_friend && dict[@"friend"] && ![dict[@"friend"] isKindOfClass:NSNull.class]) return nil;
        _from = [QTFrom fromJSONDictionary:(id)_from];
        if (!_from && dict[@"from"] && ![dict[@"from"] isKindOfClass:NSNull.class]) return nil;
        _fromDict = [QTFromDict fromJSONDictionary:(id)_fromDict];
        if (!_fromDict && dict[@"from_dict"] && ![dict[@"from_dict"] isKindOfClass:NSNull.class]) return nil;
        _fromJSON = [QTFromJSON fromJSONDictionary:(id)_fromJSON];
        if (!_fromJSON && dict[@"from_json"] && ![dict[@"from_json"] isKindOfClass:NSNull.class]) return nil;
        _func = [QTFunc fromJSONDictionary:(id)_func];
        if (!_func && dict[@"func"] && ![dict[@"func"] isKindOfClass:NSNull.class]) return nil;
        _obj2Default = [QTDefault fromJSONDictionary:(id)_obj2Default];
        if (!_obj2Default && dict[@"default"] && ![dict[@"default"] isKindOfClass:NSNull.class]) return nil;
        _obj2Do = [QTDo fromJSONDictionary:(id)_obj2Do];
        if (!_obj2Do && dict[@"do"] && ![dict[@"do"] isKindOfClass:NSNull.class]) return nil;
        _obj2Double = [QTDouble fromJSONDictionary:(id)_obj2Double];
        if (!_obj2Double && dict[@"double"] && ![dict[@"double"] isKindOfClass:NSNull.class]) return nil;
        _obj2Else = [QTElse fromJSONDictionary:(id)_obj2Else];
        if (!_obj2Else && dict[@"else"] && ![dict[@"else"] isKindOfClass:NSNull.class]) return nil;
        _obj2Enum = [QTEnum fromJSONDictionary:(id)_obj2Enum];
        if (!_obj2Enum && dict[@"enum"] && ![dict[@"enum"] isKindOfClass:NSNull.class]) return nil;
        _obj2Extern = [QTExtern fromJSONDictionary:(id)_obj2Extern];
        if (!_obj2Extern && dict[@"extern"] && ![dict[@"extern"] isKindOfClass:NSNull.class]) return nil;
        _obj2False = [QTFalse fromJSONDictionary:(id)_obj2False];
        if (!_obj2False && dict[@"False"] && ![dict[@"False"] isKindOfClass:NSNull.class]) return nil;
        _obj2Float = [QTFloat fromJSONDictionary:(id)_obj2Float];
        if (!_obj2Float && dict[@"float"] && ![dict[@"float"] isKindOfClass:NSNull.class]) return nil;
        _obj2For = [QTFor fromJSONDictionary:(id)_obj2For];
        if (!_obj2For && dict[@"for"] && ![dict[@"for"] isKindOfClass:NSNull.class]) return nil;
        _theFalse = [QTFalseClass fromJSONDictionary:(id)_theFalse];
        if (!_theFalse && dict[@"false"] && ![dict[@"false"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObj2.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObj2.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObj2.properties.allValues] mutableCopy];

    for (id jsonName in QTObj2.properties) {
        id propertyName = QTObj2.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"CultureInfo": [_cultureInfo JSONDictionary],
        @"date": [_date JSONDictionary],
        @"DateFormatter": [_dateFormatter JSONDictionary],
        @"DateOnly": [_dateOnly JSONDictionary],
        @"DateOnlyConverter": [_dateOnlyConverter JSONDictionary],
        @"date_parse_handling": [_dateParseHandling JSONDictionary],
        @"DateTime": [_dateTime JSONDictionary],
        @"DateTimeStyles": [_dateTimeStyles JSONDictionary],
        @"debugger": [_debugger JSONDictionary],
        @"decimal": [_decimal JSONDictionary],
        @"declare": [_declare JSONDictionary],
        @"decltype": [_decltype JSONDictionary],
        @"decode_string": [_decodeString JSONDictionary],
        @"Decoder": [_decoder JSONDictionary],
        @"DecodingError": [_decodingError JSONDictionary],
        @"def": [_def JSONDictionary],
        @"defer": [_defer JSONDictionary],
        @"deinit": [_deinit JSONDictionary],
        @"del": [_del JSONDictionary],
        @"delegate": [_delegate JSONDictionary],
        @"delete": [_delete JSONDictionary],
        @"DeserializationFeature": [_deserializationFeature JSONDictionary],
        @"dict": [_dict JSONDictionary],
        @"dictionary": [_dictionary JSONDictionary],
        @"didSet": [_didSet JSONDictionary],
        @"DoubleNode": [_doubleNode JSONDictionary],
        @"dynamic": [_dynamic JSONDictionary],
        @"dynamic_cast": [_dynamicCast JSONDictionary],
        @"elif": [_elif JSONDictionary],
        @"encode_quick_type": [_encodeQuickType JSONDictionary],
        @"Encoder": [_encoder JSONDictionary],
        @"EnumValues": [_enumValues JSONDictionary],
        @"equalityContract": [_equalityContract JSONDictionary],
        @"Equatable": [_equatable JSONDictionary],
        @"event": [_event JSONDictionary],
        @"except": [_except JSONDictionary],
        @"exception": [_exception JSONDictionary],
        @"explicit": [_explicit JSONDictionary],
        @"export": [_export JSONDictionary],
        @"exposing": [_exposing JSONDictionary],
        @"extends": [_extends JSONDictionary],
        @"extension": [_extension JSONDictionary],
        @"fallthrough": [_fallthrough JSONDictionary],
        @"fileprivate": [_fileprivate JSONDictionary],
        @"final": [_final JSONDictionary],
        @"finally": [_finally JSONDictionary],
        @"fixed": [_fixed JSONDictionary],
        @"foreach": [_foreach JSONDictionary],
        @"FormatException": [_formatException JSONDictionary],
        @"friend": [_friend JSONDictionary],
        @"from": [_from JSONDictionary],
        @"from_dict": [_fromDict JSONDictionary],
        @"from_json": [_fromJSON JSONDictionary],
        @"func": [_func JSONDictionary],
        @"default": [_obj2Default JSONDictionary],
        @"do": [_obj2Do JSONDictionary],
        @"double": [_obj2Double JSONDictionary],
        @"else": [_obj2Else JSONDictionary],
        @"enum": [_obj2Enum JSONDictionary],
        @"extern": [_obj2Extern JSONDictionary],
        @"False": [_obj2False JSONDictionary],
        @"float": [_obj2Float JSONDictionary],
        @"for": [_obj2For JSONDictionary],
        @"false": [_theFalse JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTCultureInfo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"CultureInfo": @"cultureInfo",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTCultureInfo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"CultureInfo"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"CultureInfo"] doubleValue] != [dict[@"CultureInfo"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTCultureInfo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTCultureInfo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTCultureInfo.properties.allValues] mutableCopy];

    for (id jsonName in QTCultureInfo.properties) {
        id propertyName = QTCultureInfo.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"date": @"date",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"date"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"date"] doubleValue] != [dict[@"date"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDate.properties.allValues];
}
@end

@implementation QTDateFormatter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DateFormatter": @"dateFormatter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDateFormatter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"DateFormatter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DateFormatter"] doubleValue] != [dict[@"DateFormatter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDateFormatter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDateFormatter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDateFormatter.properties.allValues] mutableCopy];

    for (id jsonName in QTDateFormatter.properties) {
        id propertyName = QTDateFormatter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDateOnly
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DateOnly": @"dateOnly",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDateOnly alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"DateOnly"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DateOnly"] doubleValue] != [dict[@"DateOnly"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDateOnly.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDateOnly.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDateOnly.properties.allValues] mutableCopy];

    for (id jsonName in QTDateOnly.properties) {
        id propertyName = QTDateOnly.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDateOnlyConverter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DateOnlyConverter": @"dateOnlyConverter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDateOnlyConverter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"DateOnlyConverter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DateOnlyConverter"] doubleValue] != [dict[@"DateOnlyConverter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDateOnlyConverter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDateOnlyConverter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDateOnlyConverter.properties.allValues] mutableCopy];

    for (id jsonName in QTDateOnlyConverter.properties) {
        id propertyName = QTDateOnlyConverter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDateParseHandling
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"date_parse_handling": @"dateParseHandling",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDateParseHandling alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"date_parse_handling"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"date_parse_handling"] doubleValue] != [dict[@"date_parse_handling"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDateParseHandling.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDateParseHandling.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDateParseHandling.properties.allValues] mutableCopy];

    for (id jsonName in QTDateParseHandling.properties) {
        id propertyName = QTDateParseHandling.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDateTime
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DateTime": @"dateTime",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDateTime alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"DateTime"] && [dict[@"DateTime"] rangeOfString:@"^[0-9]{4}-[0-9]{2}-[0-9]{2}T" options:NSRegularExpressionSearch].location == NSNotFound) return nil;
        if (![dict[@"DateTime"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDateTime.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDateTime.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDateTime.properties.allValues] mutableCopy];

    for (id jsonName in QTDateTime.properties) {
        id propertyName = QTDateTime.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDateTimeStyles
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DateTimeStyles": @"dateTimeStyles",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDateTimeStyles alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"DateTimeStyles"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DateTimeStyles"] doubleValue] != [dict[@"DateTimeStyles"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDateTimeStyles.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDateTimeStyles.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDateTimeStyles.properties.allValues] mutableCopy];

    for (id jsonName in QTDateTimeStyles.properties) {
        id propertyName = QTDateTimeStyles.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDebugger
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"debugger": @"debugger",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDebugger alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"debugger"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"debugger"] doubleValue] != [dict[@"debugger"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDebugger.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDebugger.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDebugger.properties.allValues];
}
@end

@implementation QTDecimal
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"decimal": @"decimal",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDecimal alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"decimal"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"decimal"] doubleValue] != [dict[@"decimal"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDecimal.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDecimal.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDecimal.properties.allValues];
}
@end

@implementation QTDeclare
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"declare": @"declare",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDeclare alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"declare"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"declare"] doubleValue] != [dict[@"declare"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDeclare.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDeclare.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDeclare.properties.allValues];
}
@end

@implementation QTDecltype
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"decltype": @"decltype",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDecltype alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"decltype"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"decltype"] doubleValue] != [dict[@"decltype"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDecltype.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDecltype.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDecltype.properties.allValues];
}
@end

@implementation QTDecodeString
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"decode_string": @"decodeString",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDecodeString alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"decode_string"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"decode_string"] doubleValue] != [dict[@"decode_string"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDecodeString.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDecodeString.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDecodeString.properties.allValues] mutableCopy];

    for (id jsonName in QTDecodeString.properties) {
        id propertyName = QTDecodeString.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDecoder
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Decoder": @"decoder",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDecoder alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Decoder"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Decoder"] doubleValue] != [dict[@"Decoder"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDecoder.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDecoder.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDecoder.properties.allValues] mutableCopy];

    for (id jsonName in QTDecoder.properties) {
        id propertyName = QTDecoder.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDecodingError
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DecodingError": @"decodingError",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDecodingError alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"DecodingError"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DecodingError"] doubleValue] != [dict[@"DecodingError"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDecodingError.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDecodingError.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDecodingError.properties.allValues] mutableCopy];

    for (id jsonName in QTDecodingError.properties) {
        id propertyName = QTDecodingError.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"def": @"def",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"def"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"def"] doubleValue] != [dict[@"def"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDef.properties.allValues];
}
@end

@implementation QTDefer
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"defer": @"defer",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDefer alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"defer"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"defer"] doubleValue] != [dict[@"defer"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDefer.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDefer.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDefer.properties.allValues];
}
@end

@implementation QTDeinit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"deinit": @"deinit",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDeinit alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"deinit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"deinit"] doubleValue] != [dict[@"deinit"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDeinit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDeinit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDeinit.properties.allValues];
}
@end

@implementation QTDel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"del": @"del",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"del"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"del"] doubleValue] != [dict[@"del"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDel.properties.allValues];
}
@end

@implementation QTDelegate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"delegate": @"delegate",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDelegate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"delegate"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"delegate"] doubleValue] != [dict[@"delegate"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDelegate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDelegate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDelegate.properties.allValues];
}
@end

@implementation QTDelete
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"delete": @"delete",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDelete alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"delete"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"delete"] doubleValue] != [dict[@"delete"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDelete.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDelete.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDelete.properties.allValues];
}
@end

@implementation QTDeserializationFeature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DeserializationFeature": @"deserializationFeature",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDeserializationFeature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"DeserializationFeature"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DeserializationFeature"] doubleValue] != [dict[@"DeserializationFeature"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDeserializationFeature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDeserializationFeature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDeserializationFeature.properties.allValues] mutableCopy];

    for (id jsonName in QTDeserializationFeature.properties) {
        id propertyName = QTDeserializationFeature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDict
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dict": @"dict",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDict alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dict"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dict"] doubleValue] != [dict[@"dict"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDict.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDict.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDict.properties.allValues];
}
@end

@implementation QTDictionary
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dictionary": @"dictionary",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDictionary alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dictionary"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dictionary"] doubleValue] != [dict[@"dictionary"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDictionary.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDictionary.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDictionary.properties.allValues];
}
@end

@implementation QTDidSet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"didSet": @"didSet",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDidSet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"didSet"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"didSet"] doubleValue] != [dict[@"didSet"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDidSet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDidSet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDidSet.properties.allValues];
}
@end

@implementation QTDoubleNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"DoubleNode": @"doubleNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDoubleNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"DoubleNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"DoubleNode"] doubleValue] != [dict[@"DoubleNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDoubleNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDoubleNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDoubleNode.properties.allValues] mutableCopy];

    for (id jsonName in QTDoubleNode.properties) {
        id propertyName = QTDoubleNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDynamic
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dynamic": @"dynamic",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDynamic alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dynamic"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dynamic"] doubleValue] != [dict[@"dynamic"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDynamic.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDynamic.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTDynamic.properties.allValues];
}
@end

@implementation QTDynamicCast
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dynamic_cast": @"dynamicCast",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDynamicCast alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dynamic_cast"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dynamic_cast"] doubleValue] != [dict[@"dynamic_cast"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDynamicCast.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDynamicCast.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDynamicCast.properties.allValues] mutableCopy];

    for (id jsonName in QTDynamicCast.properties) {
        id propertyName = QTDynamicCast.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTElif
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"elif": @"elif",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTElif alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"elif"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"elif"] doubleValue] != [dict[@"elif"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTElif.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTElif.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTElif.properties.allValues];
}
@end

@implementation QTEncodeQuickType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"encode_quick_type": @"encodeQuickType",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEncodeQuickType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"encode_quick_type"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"encode_quick_type"] doubleValue] != [dict[@"encode_quick_type"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEncodeQuickType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEncodeQuickType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEncodeQuickType.properties.allValues] mutableCopy];

    for (id jsonName in QTEncodeQuickType.properties) {
        id propertyName = QTEncodeQuickType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTEncoder
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Encoder": @"encoder",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEncoder alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Encoder"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Encoder"] doubleValue] != [dict[@"Encoder"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEncoder.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEncoder.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEncoder.properties.allValues] mutableCopy];

    for (id jsonName in QTEncoder.properties) {
        id propertyName = QTEncoder.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTEnumValues
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"EnumValues": @"enumValues",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEnumValues alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"EnumValues"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _enumValues = map(_enumValues, λ(id x, [QTEnumValue withValue:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEnumValues.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEnumValues.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEnumValues.properties.allValues] mutableCopy];

    for (id jsonName in QTEnumValues.properties) {
        id propertyName = QTEnumValues.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"EnumValues": map(_enumValues, λ(id x, [x value])),
    }];

    return dict;
}
@end

@implementation QTEqualityContract
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"equalityContract": @"equalityContract",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEqualityContract alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"equalityContract"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"equalityContract"] doubleValue] != [dict[@"equalityContract"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEqualityContract.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEqualityContract.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTEqualityContract.properties.allValues];
}
@end

@implementation QTEquatable
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Equatable": @"equatable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEquatable alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Equatable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Equatable"] doubleValue] != [dict[@"Equatable"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEquatable.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEquatable.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEquatable.properties.allValues] mutableCopy];

    for (id jsonName in QTEquatable.properties) {
        id propertyName = QTEquatable.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTEvent
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"event": @"event",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEvent alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"event"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"event"] doubleValue] != [dict[@"event"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEvent.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEvent.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTEvent.properties.allValues];
}
@end

@implementation QTExcept
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"except": @"except",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExcept alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"except"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"except"] doubleValue] != [dict[@"except"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExcept.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExcept.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExcept.properties.allValues];
}
@end

@implementation QTException
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"exception": @"exception",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTException alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"exception"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"exception"] doubleValue] != [dict[@"exception"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTException.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTException.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTException.properties.allValues];
}
@end

@implementation QTExplicit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"explicit": @"explicit",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExplicit alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"explicit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"explicit"] doubleValue] != [dict[@"explicit"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExplicit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExplicit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExplicit.properties.allValues];
}
@end

@implementation QTExport
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"export": @"export",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExport alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"export"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"export"] doubleValue] != [dict[@"export"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExport.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExport.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExport.properties.allValues];
}
@end

@implementation QTExposing
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"exposing": @"exposing",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExposing alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"exposing"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"exposing"] doubleValue] != [dict[@"exposing"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExposing.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExposing.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExposing.properties.allValues];
}
@end

@implementation QTExtends
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"extends": @"extends",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExtends alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"extends"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"extends"] doubleValue] != [dict[@"extends"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExtends.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExtends.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExtends.properties.allValues];
}
@end

@implementation QTExtension
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"extension": @"extension",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExtension alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"extension"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"extension"] doubleValue] != [dict[@"extension"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExtension.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExtension.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTExtension.properties.allValues];
}
@end

@implementation QTFallthrough
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"fallthrough": @"fallthrough",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFallthrough alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"fallthrough"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"fallthrough"] doubleValue] != [dict[@"fallthrough"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFallthrough.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFallthrough.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFallthrough.properties.allValues];
}
@end

@implementation QTFileprivate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"fileprivate": @"fileprivate",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFileprivate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"fileprivate"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"fileprivate"] doubleValue] != [dict[@"fileprivate"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFileprivate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFileprivate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFileprivate.properties.allValues];
}
@end

@implementation QTFinal
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"final": @"final",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFinal alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"final"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"final"] doubleValue] != [dict[@"final"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFinal.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFinal.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFinal.properties.allValues];
}
@end

@implementation QTFinally
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"finally": @"finally",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFinally alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"finally"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"finally"] doubleValue] != [dict[@"finally"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFinally.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFinally.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFinally.properties.allValues];
}
@end

@implementation QTFixed
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"fixed": @"fixed",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFixed alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"fixed"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"fixed"] doubleValue] != [dict[@"fixed"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFixed.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFixed.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFixed.properties.allValues];
}
@end

@implementation QTForeach
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"foreach": @"foreach",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTForeach alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"foreach"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"foreach"] doubleValue] != [dict[@"foreach"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTForeach.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTForeach.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTForeach.properties.allValues];
}
@end

@implementation QTFormatException
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"FormatException": @"formatException",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFormatException alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"FormatException"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"FormatException"] doubleValue] != [dict[@"FormatException"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFormatException.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFormatException.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFormatException.properties.allValues] mutableCopy];

    for (id jsonName in QTFormatException.properties) {
        id propertyName = QTFormatException.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFriend
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"friend": @"friend",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFriend alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"friend"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"friend"] doubleValue] != [dict[@"friend"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFriend.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFriend.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFriend.properties.allValues];
}
@end

@implementation QTFrom
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"from": @"from",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFrom alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"from"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"from"] doubleValue] != [dict[@"from"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFrom.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFrom.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFrom.properties.allValues];
}
@end

@implementation QTFromDict
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"from_dict": @"fromDict",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFromDict alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"from_dict"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"from_dict"] doubleValue] != [dict[@"from_dict"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFromDict.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFromDict.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFromDict.properties.allValues] mutableCopy];

    for (id jsonName in QTFromDict.properties) {
        id propertyName = QTFromDict.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFromJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"from_json": @"fromJSON",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFromJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"from_json"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"from_json"] doubleValue] != [dict[@"from_json"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFromJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFromJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFromJSON.properties.allValues] mutableCopy];

    for (id jsonName in QTFromJSON.properties) {
        id propertyName = QTFromJSON.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFunc
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"func": @"func",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFunc alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"func"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"func"] doubleValue] != [dict[@"func"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFunc.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFunc.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFunc.properties.allValues];
}
@end

@implementation QTDefault
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"default": @"defaultDefault",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDefault alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"default"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"default"] doubleValue] != [dict[@"default"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDefault.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDefault.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDefault.properties.allValues] mutableCopy];

    for (id jsonName in QTDefault.properties) {
        id propertyName = QTDefault.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"do": @"doDo",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"do"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"do"] doubleValue] != [dict[@"do"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDo.properties.allValues] mutableCopy];

    for (id jsonName in QTDo.properties) {
        id propertyName = QTDo.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTDouble
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"double": @"doubleDouble",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTDouble alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"double"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"double"] doubleValue] != [dict[@"double"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTDouble.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTDouble.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTDouble.properties.allValues] mutableCopy];

    for (id jsonName in QTDouble.properties) {
        id propertyName = QTDouble.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTElse
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"else": @"elseElse",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTElse alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"else"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"else"] doubleValue] != [dict[@"else"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTElse.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTElse.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTElse.properties.allValues] mutableCopy];

    for (id jsonName in QTElse.properties) {
        id propertyName = QTElse.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTEnum
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"enum": @"enumEnum",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTEnum alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"enum"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"enum"] doubleValue] != [dict[@"enum"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTEnum.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTEnum.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEnum.properties.allValues] mutableCopy];

    for (id jsonName in QTEnum.properties) {
        id propertyName = QTEnum.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTExtern
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"extern": @"externExtern",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTExtern alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"extern"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"extern"] doubleValue] != [dict[@"extern"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTExtern.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTExtern.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTExtern.properties.allValues] mutableCopy];

    for (id jsonName in QTExtern.properties) {
        id propertyName = QTExtern.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFalse
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"False": @"falseFalse",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFalse alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"False"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"False"] doubleValue] != [dict[@"False"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFalse.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFalse.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFalse.properties.allValues] mutableCopy];

    for (id jsonName in QTFalse.properties) {
        id propertyName = QTFalse.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFloat
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"float": @"floatFloat",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFloat alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"float"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"float"] doubleValue] != [dict[@"float"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFloat.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFloat.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFloat.properties.allValues] mutableCopy];

    for (id jsonName in QTFloat.properties) {
        id propertyName = QTFloat.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"for": @"forFor",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"for"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"for"] doubleValue] != [dict[@"for"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFor.properties.allValues] mutableCopy];

    for (id jsonName in QTFor.properties) {
        id propertyName = QTFor.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTFalseClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"false": @"falseFalse",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFalseClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"false"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"false"] doubleValue] != [dict[@"false"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFalseClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFalseClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFalseClass.properties.allValues] mutableCopy];

    for (id jsonName in QTFalseClass.properties) {
        id propertyName = QTFalseClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObj3
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dummy": @"dummy",
        @"function": @"function",
        @"get": @"get",
        @"global": @"global",
        @"go": @"go",
        @"guard": @"guard",
        @"hasOwnProperty": @"hasOwnProperty",
        @"Hashable": @"hashable",
        @"Hasher": @"hasher",
        @"id": @"identifier",
        @"IMP": @"imp",
        @"implements": @"implements",
        @"implicit": @"implicit",
        @"import": @"import",
        @"in": @"in",
        @"indirect": @"indirect",
        @"infix": @"infix",
        @"inout": @"inout",
        @"instanceof": @"instanceof",
        @"IntNode": @"intNode",
        @"interface": @"interface",
        @"internal": @"internal",
        @"is": @"is",
        @"IsoDateTimeOffsetConverter": @"isoDateTimeOffsetConverter",
        @"iterable": @"iterable",
        @"jdec": @"jdec",
        @"jenc": @"jenc",
        @"jpipe": @"jpipe",
        @"json": @"json",
        @"JSONAny": @"jsonAny",
        @"JSONCodingKey": @"jsonCodingKey",
        @"json_converter": @"jsonConverter",
        @"JSONDecoder": @"jsonDecoder",
        @"JSONEncoder": @"jsonEncoder",
        @"JsonException": @"jsonException",
        @"JsonGenerator": @"jsonGenerator",
        @"JsonNode": @"jsonNode",
        @"JSONNull": @"jsonNull",
        @"JsonParser": @"jsonParser",
        @"JsonReader": @"jsonReader",
        @"json_serializer": @"jsonSerializer",
        @"json_token": @"jsonToken",
        @"JsonTokenType": @"jsonTokenType",
        @"json_writer": @"jsonWriter",
        @"lambda": @"lambda",
        @"lazy": @"lazy",
        @"left": @"left",
        @"let": @"let",
        @"list": @"list",
        @"LocalDate": @"localDate",
        @"Locale": @"locale",
        @"lock": @"lock",
        @"LongNode": @"longNode",
        @"map": @"map",
        @"MapEntry": @"mapEntry",
        @"MarshalJSON": @"marshalJSON",
        @"metadata_property_handling": @"metadataPropertyHandling",
        @"module": @"module",
        @"goto": @"obj3Goto",
        @"if": @"obj3If",
        @"inline": @"obj3Inline",
        @"int": @"obj3Int",
        @"long": @"obj3Long",
        @"hashCode": @"theHashCode",
        @"init": @"theInit",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObj3 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dummy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dummy"] doubleValue] != [dict[@"dummy"] longLongValue]) return nil;
        if (![dict[@"function"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"get"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"global"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"go"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"guard"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"hasOwnProperty"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Hashable"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Hasher"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"id"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"IMP"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"implements"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"implicit"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"import"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"in"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"indirect"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"infix"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"inout"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"instanceof"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"IntNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"interface"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"internal"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"is"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"IsoDateTimeOffsetConverter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"iterable"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"jdec"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"jenc"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"jpipe"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JSONAny"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JSONCodingKey"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"json_converter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JSONDecoder"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JSONEncoder"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JsonException"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JsonGenerator"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JsonNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JSONNull"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JsonParser"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JsonReader"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"json_serializer"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"json_token"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"JsonTokenType"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"json_writer"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"lambda"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"lazy"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"left"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"let"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"list"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"LocalDate"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Locale"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"lock"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"LongNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"map"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"MapEntry"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"MarshalJSON"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"metadata_property_handling"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"module"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"goto"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"if"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"inline"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"int"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"long"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"hashCode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"init"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _function = [QTFunction fromJSONDictionary:(id)_function];
        if (!_function && dict[@"function"] && ![dict[@"function"] isKindOfClass:NSNull.class]) return nil;
        _get = [QTGet fromJSONDictionary:(id)_get];
        if (!_get && dict[@"get"] && ![dict[@"get"] isKindOfClass:NSNull.class]) return nil;
        _global = [QTGlobal fromJSONDictionary:(id)_global];
        if (!_global && dict[@"global"] && ![dict[@"global"] isKindOfClass:NSNull.class]) return nil;
        _go = [QTGo fromJSONDictionary:(id)_go];
        if (!_go && dict[@"go"] && ![dict[@"go"] isKindOfClass:NSNull.class]) return nil;
        _guard = [QTGuard fromJSONDictionary:(id)_guard];
        if (!_guard && dict[@"guard"] && ![dict[@"guard"] isKindOfClass:NSNull.class]) return nil;
        _hasOwnProperty = [QTHasOwnProperty fromJSONDictionary:(id)_hasOwnProperty];
        if (!_hasOwnProperty && dict[@"hasOwnProperty"] && ![dict[@"hasOwnProperty"] isKindOfClass:NSNull.class]) return nil;
        _hashable = [QTHashable fromJSONDictionary:(id)_hashable];
        if (!_hashable && dict[@"Hashable"] && ![dict[@"Hashable"] isKindOfClass:NSNull.class]) return nil;
        _hasher = [QTHasher fromJSONDictionary:(id)_hasher];
        if (!_hasher && dict[@"Hasher"] && ![dict[@"Hasher"] isKindOfClass:NSNull.class]) return nil;
        _identifier = [QTID fromJSONDictionary:(id)_identifier];
        if (!_identifier && dict[@"id"] && ![dict[@"id"] isKindOfClass:NSNull.class]) return nil;
        _imp = [QTImp fromJSONDictionary:(id)_imp];
        if (!_imp && dict[@"IMP"] && ![dict[@"IMP"] isKindOfClass:NSNull.class]) return nil;
        _implements = [QTImplements fromJSONDictionary:(id)_implements];
        if (!_implements && dict[@"implements"] && ![dict[@"implements"] isKindOfClass:NSNull.class]) return nil;
        _implicit = [QTImplicit fromJSONDictionary:(id)_implicit];
        if (!_implicit && dict[@"implicit"] && ![dict[@"implicit"] isKindOfClass:NSNull.class]) return nil;
        _import = [QTImport fromJSONDictionary:(id)_import];
        if (!_import && dict[@"import"] && ![dict[@"import"] isKindOfClass:NSNull.class]) return nil;
        _in = [QTIn fromJSONDictionary:(id)_in];
        if (!_in && dict[@"in"] && ![dict[@"in"] isKindOfClass:NSNull.class]) return nil;
        _indirect = [QTIndirect fromJSONDictionary:(id)_indirect];
        if (!_indirect && dict[@"indirect"] && ![dict[@"indirect"] isKindOfClass:NSNull.class]) return nil;
        _infix = [QTInfix fromJSONDictionary:(id)_infix];
        if (!_infix && dict[@"infix"] && ![dict[@"infix"] isKindOfClass:NSNull.class]) return nil;
        _inout = [QTInout fromJSONDictionary:(id)_inout];
        if (!_inout && dict[@"inout"] && ![dict[@"inout"] isKindOfClass:NSNull.class]) return nil;
        _instanceof = [QTInstanceof fromJSONDictionary:(id)_instanceof];
        if (!_instanceof && dict[@"instanceof"] && ![dict[@"instanceof"] isKindOfClass:NSNull.class]) return nil;
        _intNode = [QTIntNode fromJSONDictionary:(id)_intNode];
        if (!_intNode && dict[@"IntNode"] && ![dict[@"IntNode"] isKindOfClass:NSNull.class]) return nil;
        _interface = [QTInterface fromJSONDictionary:(id)_interface];
        if (!_interface && dict[@"interface"] && ![dict[@"interface"] isKindOfClass:NSNull.class]) return nil;
        _internal = [QTInternal fromJSONDictionary:(id)_internal];
        if (!_internal && dict[@"internal"] && ![dict[@"internal"] isKindOfClass:NSNull.class]) return nil;
        _is = [QTIs fromJSONDictionary:(id)_is];
        if (!_is && dict[@"is"] && ![dict[@"is"] isKindOfClass:NSNull.class]) return nil;
        _isoDateTimeOffsetConverter = [QTISODateTimeOffsetConverter fromJSONDictionary:(id)_isoDateTimeOffsetConverter];
        if (!_isoDateTimeOffsetConverter && dict[@"IsoDateTimeOffsetConverter"] && ![dict[@"IsoDateTimeOffsetConverter"] isKindOfClass:NSNull.class]) return nil;
        _iterable = [QTIterable fromJSONDictionary:(id)_iterable];
        if (!_iterable && dict[@"iterable"] && ![dict[@"iterable"] isKindOfClass:NSNull.class]) return nil;
        _jdec = [QTJdec fromJSONDictionary:(id)_jdec];
        if (!_jdec && dict[@"jdec"] && ![dict[@"jdec"] isKindOfClass:NSNull.class]) return nil;
        _jenc = [QTJenc fromJSONDictionary:(id)_jenc];
        if (!_jenc && dict[@"jenc"] && ![dict[@"jenc"] isKindOfClass:NSNull.class]) return nil;
        _jpipe = [QTJpipe fromJSONDictionary:(id)_jpipe];
        if (!_jpipe && dict[@"jpipe"] && ![dict[@"jpipe"] isKindOfClass:NSNull.class]) return nil;
        _json = [QTJSON fromJSONDictionary:(id)_json];
        if (!_json && dict[@"json"] && ![dict[@"json"] isKindOfClass:NSNull.class]) return nil;
        _jsonAny = [QTJSONAny fromJSONDictionary:(id)_jsonAny];
        if (!_jsonAny && dict[@"JSONAny"] && ![dict[@"JSONAny"] isKindOfClass:NSNull.class]) return nil;
        _jsonCodingKey = [QTJSONCodingKey fromJSONDictionary:(id)_jsonCodingKey];
        if (!_jsonCodingKey && dict[@"JSONCodingKey"] && ![dict[@"JSONCodingKey"] isKindOfClass:NSNull.class]) return nil;
        _jsonConverter = [QTJSONConverter fromJSONDictionary:(id)_jsonConverter];
        if (!_jsonConverter && dict[@"json_converter"] && ![dict[@"json_converter"] isKindOfClass:NSNull.class]) return nil;
        _jsonDecoder = [QTJSONDecoder fromJSONDictionary:(id)_jsonDecoder];
        if (!_jsonDecoder && dict[@"JSONDecoder"] && ![dict[@"JSONDecoder"] isKindOfClass:NSNull.class]) return nil;
        _jsonEncoder = [QTJSONEncoder fromJSONDictionary:(id)_jsonEncoder];
        if (!_jsonEncoder && dict[@"JSONEncoder"] && ![dict[@"JSONEncoder"] isKindOfClass:NSNull.class]) return nil;
        _jsonException = [QTJSONException fromJSONDictionary:(id)_jsonException];
        if (!_jsonException && dict[@"JsonException"] && ![dict[@"JsonException"] isKindOfClass:NSNull.class]) return nil;
        _jsonGenerator = [QTJSONGenerator fromJSONDictionary:(id)_jsonGenerator];
        if (!_jsonGenerator && dict[@"JsonGenerator"] && ![dict[@"JsonGenerator"] isKindOfClass:NSNull.class]) return nil;
        _jsonNode = [QTJSONNode fromJSONDictionary:(id)_jsonNode];
        if (!_jsonNode && dict[@"JsonNode"] && ![dict[@"JsonNode"] isKindOfClass:NSNull.class]) return nil;
        _jsonNull = [QTJSONNull fromJSONDictionary:(id)_jsonNull];
        if (!_jsonNull && dict[@"JSONNull"] && ![dict[@"JSONNull"] isKindOfClass:NSNull.class]) return nil;
        _jsonParser = [QTJSONParser fromJSONDictionary:(id)_jsonParser];
        if (!_jsonParser && dict[@"JsonParser"] && ![dict[@"JsonParser"] isKindOfClass:NSNull.class]) return nil;
        _jsonReader = [QTJSONReader fromJSONDictionary:(id)_jsonReader];
        if (!_jsonReader && dict[@"JsonReader"] && ![dict[@"JsonReader"] isKindOfClass:NSNull.class]) return nil;
        _jsonSerializer = [QTJSONSerializer fromJSONDictionary:(id)_jsonSerializer];
        if (!_jsonSerializer && dict[@"json_serializer"] && ![dict[@"json_serializer"] isKindOfClass:NSNull.class]) return nil;
        _jsonToken = [QTJSONToken fromJSONDictionary:(id)_jsonToken];
        if (!_jsonToken && dict[@"json_token"] && ![dict[@"json_token"] isKindOfClass:NSNull.class]) return nil;
        _jsonTokenType = [QTJSONTokenType fromJSONDictionary:(id)_jsonTokenType];
        if (!_jsonTokenType && dict[@"JsonTokenType"] && ![dict[@"JsonTokenType"] isKindOfClass:NSNull.class]) return nil;
        _jsonWriter = [QTJSONWriter fromJSONDictionary:(id)_jsonWriter];
        if (!_jsonWriter && dict[@"json_writer"] && ![dict[@"json_writer"] isKindOfClass:NSNull.class]) return nil;
        _lambda = [QTLambda fromJSONDictionary:(id)_lambda];
        if (!_lambda && dict[@"lambda"] && ![dict[@"lambda"] isKindOfClass:NSNull.class]) return nil;
        _lazy = [QTLazy fromJSONDictionary:(id)_lazy];
        if (!_lazy && dict[@"lazy"] && ![dict[@"lazy"] isKindOfClass:NSNull.class]) return nil;
        _left = [QTLeft fromJSONDictionary:(id)_left];
        if (!_left && dict[@"left"] && ![dict[@"left"] isKindOfClass:NSNull.class]) return nil;
        _let = [QTLet fromJSONDictionary:(id)_let];
        if (!_let && dict[@"let"] && ![dict[@"let"] isKindOfClass:NSNull.class]) return nil;
        _list = [QTList fromJSONDictionary:(id)_list];
        if (!_list && dict[@"list"] && ![dict[@"list"] isKindOfClass:NSNull.class]) return nil;
        _localDate = [QTLocalDate fromJSONDictionary:(id)_localDate];
        if (!_localDate && dict[@"LocalDate"] && ![dict[@"LocalDate"] isKindOfClass:NSNull.class]) return nil;
        _locale = [QTLocale fromJSONDictionary:(id)_locale];
        if (!_locale && dict[@"Locale"] && ![dict[@"Locale"] isKindOfClass:NSNull.class]) return nil;
        _lock = [QTLock fromJSONDictionary:(id)_lock];
        if (!_lock && dict[@"lock"] && ![dict[@"lock"] isKindOfClass:NSNull.class]) return nil;
        _longNode = [QTLongNode fromJSONDictionary:(id)_longNode];
        if (!_longNode && dict[@"LongNode"] && ![dict[@"LongNode"] isKindOfClass:NSNull.class]) return nil;
        _map = [QTMap fromJSONDictionary:(id)_map];
        if (!_map && dict[@"map"] && ![dict[@"map"] isKindOfClass:NSNull.class]) return nil;
        _mapEntry = [QTMapEntry fromJSONDictionary:(id)_mapEntry];
        if (!_mapEntry && dict[@"MapEntry"] && ![dict[@"MapEntry"] isKindOfClass:NSNull.class]) return nil;
        _marshalJSON = [QTMarshalJSON fromJSONDictionary:(id)_marshalJSON];
        if (!_marshalJSON && dict[@"MarshalJSON"] && ![dict[@"MarshalJSON"] isKindOfClass:NSNull.class]) return nil;
        _metadataPropertyHandling = [QTMetadataPropertyHandling fromJSONDictionary:(id)_metadataPropertyHandling];
        if (!_metadataPropertyHandling && dict[@"metadata_property_handling"] && ![dict[@"metadata_property_handling"] isKindOfClass:NSNull.class]) return nil;
        _module = [QTModule fromJSONDictionary:(id)_module];
        if (!_module && dict[@"module"] && ![dict[@"module"] isKindOfClass:NSNull.class]) return nil;
        _obj3Goto = [QTGoto fromJSONDictionary:(id)_obj3Goto];
        if (!_obj3Goto && dict[@"goto"] && ![dict[@"goto"] isKindOfClass:NSNull.class]) return nil;
        _obj3If = [QTIf fromJSONDictionary:(id)_obj3If];
        if (!_obj3If && dict[@"if"] && ![dict[@"if"] isKindOfClass:NSNull.class]) return nil;
        _obj3Inline = [QTInline fromJSONDictionary:(id)_obj3Inline];
        if (!_obj3Inline && dict[@"inline"] && ![dict[@"inline"] isKindOfClass:NSNull.class]) return nil;
        _obj3Int = [QTInt fromJSONDictionary:(id)_obj3Int];
        if (!_obj3Int && dict[@"int"] && ![dict[@"int"] isKindOfClass:NSNull.class]) return nil;
        _obj3Long = [QTLong fromJSONDictionary:(id)_obj3Long];
        if (!_obj3Long && dict[@"long"] && ![dict[@"long"] isKindOfClass:NSNull.class]) return nil;
        _theHashCode = [QTHashCode fromJSONDictionary:(id)_theHashCode];
        if (!_theHashCode && dict[@"hashCode"] && ![dict[@"hashCode"] isKindOfClass:NSNull.class]) return nil;
        _theInit = [QTInit fromJSONDictionary:(id)_theInit];
        if (!_theInit && dict[@"init"] && ![dict[@"init"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObj3.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObj3.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObj3.properties.allValues] mutableCopy];

    for (id jsonName in QTObj3.properties) {
        id propertyName = QTObj3.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"function": [_function JSONDictionary],
        @"get": [_get JSONDictionary],
        @"global": [_global JSONDictionary],
        @"go": [_go JSONDictionary],
        @"guard": [_guard JSONDictionary],
        @"hasOwnProperty": [_hasOwnProperty JSONDictionary],
        @"Hashable": [_hashable JSONDictionary],
        @"Hasher": [_hasher JSONDictionary],
        @"id": [_identifier JSONDictionary],
        @"IMP": [_imp JSONDictionary],
        @"implements": [_implements JSONDictionary],
        @"implicit": [_implicit JSONDictionary],
        @"import": [_import JSONDictionary],
        @"in": [_in JSONDictionary],
        @"indirect": [_indirect JSONDictionary],
        @"infix": [_infix JSONDictionary],
        @"inout": [_inout JSONDictionary],
        @"instanceof": [_instanceof JSONDictionary],
        @"IntNode": [_intNode JSONDictionary],
        @"interface": [_interface JSONDictionary],
        @"internal": [_internal JSONDictionary],
        @"is": [_is JSONDictionary],
        @"IsoDateTimeOffsetConverter": [_isoDateTimeOffsetConverter JSONDictionary],
        @"iterable": [_iterable JSONDictionary],
        @"jdec": [_jdec JSONDictionary],
        @"jenc": [_jenc JSONDictionary],
        @"jpipe": [_jpipe JSONDictionary],
        @"json": [_json JSONDictionary],
        @"JSONAny": [_jsonAny JSONDictionary],
        @"JSONCodingKey": [_jsonCodingKey JSONDictionary],
        @"json_converter": [_jsonConverter JSONDictionary],
        @"JSONDecoder": [_jsonDecoder JSONDictionary],
        @"JSONEncoder": [_jsonEncoder JSONDictionary],
        @"JsonException": [_jsonException JSONDictionary],
        @"JsonGenerator": [_jsonGenerator JSONDictionary],
        @"JsonNode": [_jsonNode JSONDictionary],
        @"JSONNull": [_jsonNull JSONDictionary],
        @"JsonParser": [_jsonParser JSONDictionary],
        @"JsonReader": [_jsonReader JSONDictionary],
        @"json_serializer": [_jsonSerializer JSONDictionary],
        @"json_token": [_jsonToken JSONDictionary],
        @"JsonTokenType": [_jsonTokenType JSONDictionary],
        @"json_writer": [_jsonWriter JSONDictionary],
        @"lambda": [_lambda JSONDictionary],
        @"lazy": [_lazy JSONDictionary],
        @"left": [_left JSONDictionary],
        @"let": [_let JSONDictionary],
        @"list": [_list JSONDictionary],
        @"LocalDate": [_localDate JSONDictionary],
        @"Locale": [_locale JSONDictionary],
        @"lock": [_lock JSONDictionary],
        @"LongNode": [_longNode JSONDictionary],
        @"map": [_map JSONDictionary],
        @"MapEntry": [_mapEntry JSONDictionary],
        @"MarshalJSON": [_marshalJSON JSONDictionary],
        @"metadata_property_handling": [_metadataPropertyHandling JSONDictionary],
        @"module": [_module JSONDictionary],
        @"goto": [_obj3Goto JSONDictionary],
        @"if": [_obj3If JSONDictionary],
        @"inline": [_obj3Inline JSONDictionary],
        @"int": [_obj3Int JSONDictionary],
        @"long": [_obj3Long JSONDictionary],
        @"hashCode": [_theHashCode JSONDictionary],
        @"init": [_theInit JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTFunction
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"function": @"function",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTFunction alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"function"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"function"] doubleValue] != [dict[@"function"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFunction.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTFunction.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTFunction.properties.allValues];
}
@end

@implementation QTGet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"get": @"get",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"get"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"get"] doubleValue] != [dict[@"get"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGet.properties.allValues];
}
@end

@implementation QTGlobal
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"global": @"global",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGlobal alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"global"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"global"] doubleValue] != [dict[@"global"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGlobal.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGlobal.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGlobal.properties.allValues];
}
@end

@implementation QTGo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"go": @"go",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"go"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"go"] doubleValue] != [dict[@"go"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGo.properties.allValues];
}
@end

@implementation QTGuard
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"guard": @"guard",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGuard alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"guard"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"guard"] doubleValue] != [dict[@"guard"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGuard.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGuard.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGuard.properties.allValues];
}
@end

@implementation QTHasOwnProperty
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"hasOwnProperty": @"hasOwnProperty",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHasOwnProperty alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"hasOwnProperty"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"hasOwnProperty"] doubleValue] != [dict[@"hasOwnProperty"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTHasOwnProperty.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHasOwnProperty.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTHasOwnProperty.properties.allValues];
}
@end

@implementation QTHashable
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Hashable": @"hashable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHashable alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Hashable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Hashable"] doubleValue] != [dict[@"Hashable"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTHashable.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHashable.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTHashable.properties.allValues] mutableCopy];

    for (id jsonName in QTHashable.properties) {
        id propertyName = QTHashable.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTHasher
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Hasher": @"hasher",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHasher alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Hasher"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Hasher"] doubleValue] != [dict[@"Hasher"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTHasher.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHasher.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTHasher.properties.allValues] mutableCopy];

    for (id jsonName in QTHasher.properties) {
        id propertyName = QTHasher.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTID
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTID alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"id"] doubleValue] != [dict[@"id"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTID.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTID.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTID.properties.allValues] mutableCopy];

    for (id jsonName in QTID.properties) {
        id propertyName = QTID.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTImp
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"IMP": @"imp",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImp alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"IMP"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"IMP"] doubleValue] != [dict[@"IMP"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTImp.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTImp.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTImp.properties.allValues] mutableCopy];

    for (id jsonName in QTImp.properties) {
        id propertyName = QTImp.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTImplements
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"implements": @"implements",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImplements alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"implements"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"implements"] doubleValue] != [dict[@"implements"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTImplements.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTImplements.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTImplements.properties.allValues];
}
@end

@implementation QTImplicit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"implicit": @"implicit",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImplicit alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"implicit"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"implicit"] doubleValue] != [dict[@"implicit"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTImplicit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTImplicit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTImplicit.properties.allValues];
}
@end

@implementation QTImport
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"import": @"import",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTImport alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"import"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"import"] doubleValue] != [dict[@"import"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTImport.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTImport.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTImport.properties.allValues];
}
@end

@implementation QTIn
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"in": @"in",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIn alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"in"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"in"] doubleValue] != [dict[@"in"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIn.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIn.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIn.properties.allValues];
}
@end

@implementation QTIndirect
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"indirect": @"indirect",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIndirect alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"indirect"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"indirect"] doubleValue] != [dict[@"indirect"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIndirect.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIndirect.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIndirect.properties.allValues];
}
@end

@implementation QTInfix
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"infix": @"infix",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInfix alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"infix"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"infix"] doubleValue] != [dict[@"infix"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInfix.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInfix.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTInfix.properties.allValues];
}
@end

@implementation QTInout
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"inout": @"inout",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInout alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"inout"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"inout"] doubleValue] != [dict[@"inout"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInout.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInout.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTInout.properties.allValues];
}
@end

@implementation QTInstanceof
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"instanceof": @"instanceof",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInstanceof alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"instanceof"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"instanceof"] doubleValue] != [dict[@"instanceof"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInstanceof.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInstanceof.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTInstanceof.properties.allValues];
}
@end

@implementation QTIntNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"IntNode": @"intNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIntNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"IntNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"IntNode"] doubleValue] != [dict[@"IntNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIntNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIntNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIntNode.properties.allValues] mutableCopy];

    for (id jsonName in QTIntNode.properties) {
        id propertyName = QTIntNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTInterface
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"interface": @"interface",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInterface alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"interface"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"interface"] doubleValue] != [dict[@"interface"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInterface.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInterface.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTInterface.properties.allValues];
}
@end

@implementation QTInternal
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"internal": @"internal",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInternal alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"internal"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"internal"] doubleValue] != [dict[@"internal"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInternal.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInternal.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTInternal.properties.allValues];
}
@end

@implementation QTIs
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"is": @"is",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIs alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"is"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"is"] doubleValue] != [dict[@"is"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIs.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIs.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIs.properties.allValues];
}
@end

@implementation QTISODateTimeOffsetConverter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"IsoDateTimeOffsetConverter": @"isoDateTimeOffsetConverter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTISODateTimeOffsetConverter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"IsoDateTimeOffsetConverter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"IsoDateTimeOffsetConverter"] doubleValue] != [dict[@"IsoDateTimeOffsetConverter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTISODateTimeOffsetConverter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTISODateTimeOffsetConverter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTISODateTimeOffsetConverter.properties.allValues] mutableCopy];

    for (id jsonName in QTISODateTimeOffsetConverter.properties) {
        id propertyName = QTISODateTimeOffsetConverter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTIterable
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"iterable": @"iterable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIterable alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"iterable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"iterable"] doubleValue] != [dict[@"iterable"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIterable.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIterable.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIterable.properties.allValues];
}
@end

@implementation QTJdec
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"jdec": @"jdec",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJdec alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"jdec"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"jdec"] doubleValue] != [dict[@"jdec"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJdec.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJdec.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTJdec.properties.allValues];
}
@end

@implementation QTJenc
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"jenc": @"jenc",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJenc alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"jenc"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"jenc"] doubleValue] != [dict[@"jenc"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJenc.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJenc.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTJenc.properties.allValues];
}
@end

@implementation QTJpipe
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"jpipe": @"jpipe",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJpipe alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"jpipe"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"jpipe"] doubleValue] != [dict[@"jpipe"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJpipe.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJpipe.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTJpipe.properties.allValues];
}
@end

@implementation QTJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"json": @"json",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"json"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"json"] doubleValue] != [dict[@"json"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTJSON.properties.allValues];
}
@end

@implementation QTJSONAny
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JSONAny": @"jsonAny",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONAny alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (!dict[@"JSONAny"]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONAny.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONAny.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONAny.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONAny.properties) {
        id propertyName = QTJSONAny.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONCodingKey
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JSONCodingKey": @"jsonCodingKey",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONCodingKey alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JSONCodingKey"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JSONCodingKey"] doubleValue] != [dict[@"JSONCodingKey"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONCodingKey.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONCodingKey.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONCodingKey.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONCodingKey.properties) {
        id propertyName = QTJSONCodingKey.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONConverter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"json_converter": @"jsonConverter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONConverter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"json_converter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"json_converter"] doubleValue] != [dict[@"json_converter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONConverter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONConverter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONConverter.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONConverter.properties) {
        id propertyName = QTJSONConverter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONDecoder
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JSONDecoder": @"jsonDecoder",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONDecoder alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JSONDecoder"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JSONDecoder"] doubleValue] != [dict[@"JSONDecoder"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONDecoder.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONDecoder.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONDecoder.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONDecoder.properties) {
        id propertyName = QTJSONDecoder.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONEncoder
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JSONEncoder": @"jsonEncoder",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONEncoder alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JSONEncoder"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JSONEncoder"] doubleValue] != [dict[@"JSONEncoder"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONEncoder.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONEncoder.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONEncoder.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONEncoder.properties) {
        id propertyName = QTJSONEncoder.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONException
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JsonException": @"jsonException",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONException alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JsonException"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JsonException"] doubleValue] != [dict[@"JsonException"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONException.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONException.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONException.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONException.properties) {
        id propertyName = QTJSONException.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONGenerator
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JsonGenerator": @"jsonGenerator",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONGenerator alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JsonGenerator"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JsonGenerator"] doubleValue] != [dict[@"JsonGenerator"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONGenerator.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONGenerator.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONGenerator.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONGenerator.properties) {
        id propertyName = QTJSONGenerator.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JsonNode": @"jsonNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JsonNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JsonNode"] doubleValue] != [dict[@"JsonNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONNode.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONNode.properties) {
        id propertyName = QTJSONNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONNull
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JSONNull": @"jsonNull",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONNull alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JSONNull"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JSONNull"] doubleValue] != [dict[@"JSONNull"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONNull.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONNull.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONNull.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONNull.properties) {
        id propertyName = QTJSONNull.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONParser
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JsonParser": @"jsonParser",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONParser alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JsonParser"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JsonParser"] doubleValue] != [dict[@"JsonParser"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONParser.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONParser.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONParser.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONParser.properties) {
        id propertyName = QTJSONParser.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONReader
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JsonReader": @"jsonReader",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONReader alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JsonReader"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JsonReader"] doubleValue] != [dict[@"JsonReader"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONReader.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONReader.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONReader.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONReader.properties) {
        id propertyName = QTJSONReader.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONSerializer
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"json_serializer": @"jsonSerializer",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONSerializer alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"json_serializer"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"json_serializer"] doubleValue] != [dict[@"json_serializer"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONSerializer.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONSerializer.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONSerializer.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONSerializer.properties) {
        id propertyName = QTJSONSerializer.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONToken
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"json_token": @"jsonToken",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONToken alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"json_token"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"json_token"] doubleValue] != [dict[@"json_token"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONToken.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONToken.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONToken.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONToken.properties) {
        id propertyName = QTJSONToken.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONTokenType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"JsonTokenType": @"jsonTokenType",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONTokenType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"JsonTokenType"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"JsonTokenType"] doubleValue] != [dict[@"JsonTokenType"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONTokenType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONTokenType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONTokenType.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONTokenType.properties) {
        id propertyName = QTJSONTokenType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTJSONWriter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"json_writer": @"jsonWriter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSONWriter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"json_writer"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"json_writer"] doubleValue] != [dict[@"json_writer"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTJSONWriter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTJSONWriter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTJSONWriter.properties.allValues] mutableCopy];

    for (id jsonName in QTJSONWriter.properties) {
        id propertyName = QTJSONWriter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLambda
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"lambda": @"lambda",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLambda alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"lambda"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"lambda"] doubleValue] != [dict[@"lambda"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLambda.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLambda.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTLambda.properties.allValues];
}
@end

@implementation QTLazy
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"lazy": @"lazy",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLazy alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"lazy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"lazy"] doubleValue] != [dict[@"lazy"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLazy.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLazy.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTLazy.properties.allValues];
}
@end

@implementation QTLeft
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"left": @"left",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLeft alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"left"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"left"] doubleValue] != [dict[@"left"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLeft.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLeft.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTLeft.properties.allValues];
}
@end

@implementation QTLet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"let": @"let",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"let"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"let"] doubleValue] != [dict[@"let"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTLet.properties.allValues];
}
@end

@implementation QTList
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"list": @"list",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTList alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"list"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"list"] doubleValue] != [dict[@"list"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTList.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTList.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTList.properties.allValues];
}
@end

@implementation QTLocalDate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"LocalDate": @"localDate",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLocalDate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"LocalDate"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"LocalDate"] doubleValue] != [dict[@"LocalDate"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLocalDate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLocalDate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLocalDate.properties.allValues] mutableCopy];

    for (id jsonName in QTLocalDate.properties) {
        id propertyName = QTLocalDate.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLocale
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Locale": @"locale",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLocale alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Locale"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Locale"] doubleValue] != [dict[@"Locale"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLocale.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLocale.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLocale.properties.allValues] mutableCopy];

    for (id jsonName in QTLocale.properties) {
        id propertyName = QTLocale.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLock
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"lock": @"lock",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLock alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"lock"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"lock"] doubleValue] != [dict[@"lock"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLock.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLock.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTLock.properties.allValues];
}
@end

@implementation QTLongNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"LongNode": @"longNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLongNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"LongNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"LongNode"] doubleValue] != [dict[@"LongNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLongNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLongNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLongNode.properties.allValues] mutableCopy];

    for (id jsonName in QTLongNode.properties) {
        id propertyName = QTLongNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTMap
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"map": @"map",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMap alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"map"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"map"] doubleValue] != [dict[@"map"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMap.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMap.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTMap.properties.allValues];
}
@end

@implementation QTMapEntry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"MapEntry": @"mapEntry",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMapEntry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"MapEntry"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"MapEntry"] doubleValue] != [dict[@"MapEntry"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMapEntry.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMapEntry.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMapEntry.properties.allValues] mutableCopy];

    for (id jsonName in QTMapEntry.properties) {
        id propertyName = QTMapEntry.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTMarshalJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"MarshalJSON": @"marshalJSON",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMarshalJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"MarshalJSON"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"MarshalJSON"] doubleValue] != [dict[@"MarshalJSON"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMarshalJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMarshalJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMarshalJSON.properties.allValues] mutableCopy];

    for (id jsonName in QTMarshalJSON.properties) {
        id propertyName = QTMarshalJSON.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTMetadataPropertyHandling
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"metadata_property_handling": @"metadataPropertyHandling",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMetadataPropertyHandling alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"metadata_property_handling"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"metadata_property_handling"] doubleValue] != [dict[@"metadata_property_handling"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMetadataPropertyHandling.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMetadataPropertyHandling.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTMetadataPropertyHandling.properties.allValues] mutableCopy];

    for (id jsonName in QTMetadataPropertyHandling.properties) {
        id propertyName = QTMetadataPropertyHandling.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTModule
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"module": @"module",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTModule alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"module"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"module"] doubleValue] != [dict[@"module"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTModule.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTModule.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTModule.properties.allValues];
}
@end

@implementation QTGoto
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"goto": @"gotoGoto",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTGoto alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"goto"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"goto"] doubleValue] != [dict[@"goto"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTGoto.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTGoto.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTGoto.properties.allValues] mutableCopy];

    for (id jsonName in QTGoto.properties) {
        id propertyName = QTGoto.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTIf
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"if": @"ifIf",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTIf alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"if"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"if"] doubleValue] != [dict[@"if"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIf.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIf.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTIf.properties.allValues] mutableCopy];

    for (id jsonName in QTIf.properties) {
        id propertyName = QTIf.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTInline
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"inline": @"inlineInline",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInline alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"inline"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"inline"] doubleValue] != [dict[@"inline"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInline.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInline.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTInline.properties.allValues] mutableCopy];

    for (id jsonName in QTInline.properties) {
        id propertyName = QTInline.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTInt
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"int": @"intInt",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInt alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"int"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"int"] doubleValue] != [dict[@"int"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInt.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInt.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTInt.properties.allValues] mutableCopy];

    for (id jsonName in QTInt.properties) {
        id propertyName = QTInt.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTLong
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"long": @"longLong",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTLong alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"long"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"long"] doubleValue] != [dict[@"long"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTLong.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTLong.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTLong.properties.allValues] mutableCopy];

    for (id jsonName in QTLong.properties) {
        id propertyName = QTLong.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTHashCode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"hashCode": @"theHashCode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTHashCode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"hashCode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"hashCode"] doubleValue] != [dict[@"hashCode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTHashCode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTHashCode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTHashCode.properties.allValues] mutableCopy];

    for (id jsonName in QTHashCode.properties) {
        id propertyName = QTHashCode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTInit
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"init": @"theInit",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTInit alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"init"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"init"] doubleValue] != [dict[@"init"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTInit.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTInit.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTInit.properties.allValues] mutableCopy];

    for (id jsonName in QTInit.properties) {
        id propertyName = QTInit.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObj4
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dummy": @"dummy",
        @"mutable": @"mutable",
        @"mutating": @"mutating",
        @"namespace": @"namespace",
        @"native": @"native",
        @"newtonsoft": @"newtonsoft",
        @"NO": @"no",
        @"noSuchMethod": @"noSuchMethod",
        @"noexcept": @"noexcept",
        @"None": @"none",
        @"nonlocal": @"nonlocal",
        @"nonmutating": @"nonmutating",
        @"not": @"not",
        @"not_eq": @"notEq",
        @"NSError": @"nsError",
        @"NSObject": @"nsObject",
        @"NSString": @"nsString",
        @"NULL": @"null",
        @"NullNode": @"nullNode",
        @"nullptr": @"nullptr",
        @"number": @"number",
        @"nil": @"obj4Nil",
        @"nonatomic": @"obj4Nonatomic",
        @"none": @"obj4None",
        @"null": @"obj4Null",
        @"protocol": @"obj4Protocol",
        @"register": @"obj4Register",
        @"object": @"object",
        @"ObjectMapper": @"objectMapper",
        @"ObjectNode": @"objectNode",
        @"ObjectReader": @"objectReader",
        @"ObjectWriter": @"objectWriter",
        @"of": @"of",
        @"OffsetDateTime": @"offsetDateTime",
        @"OffsetTime": @"offsetTime",
        @"oneway": @"oneway",
        @"open": @"open",
        @"operator": @"operator",
        @"optional": @"optional",
        @"or": @"or",
        @"or_eq": @"orEq",
        @"out": @"out",
        @"override": @"override",
        @"package": @"package",
        @"params": @"params",
        @"pass": @"pass",
        @"port": @"port",
        @"postfix": @"postfix",
        @"precedence": @"precedence",
        @"prefix": @"prefix",
        @"print": @"print",
        @"printMembers": @"printMembers",
        @"printf": @"printf",
        @"private": @"private",
        @"protected": @"protected",
        @"Protocol": @"protocol",
        @"public": @"public",
        @"quicktype": @"quicktype",
        @"raise": @"raise",
        @"range": @"range",
        @"readonly": @"readonly",
        @"ref": @"ref",
        @"RegExp": @"regExp",
        @"reinterpret_cast": @"reinterpretCast",
        @"new": @"theNew",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObj4 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dummy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dummy"] doubleValue] != [dict[@"dummy"] longLongValue]) return nil;
        if (![dict[@"mutable"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"mutating"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"namespace"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"native"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"newtonsoft"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"NO"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"noSuchMethod"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"noexcept"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"None"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"nonlocal"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"nonmutating"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"not"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"not_eq"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"NSError"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"NSObject"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"NSString"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"NULL"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"NullNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"nullptr"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"number"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"nil"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"nonatomic"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"none"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"null"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"protocol"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"register"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"object"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ObjectMapper"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ObjectNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ObjectReader"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ObjectWriter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"of"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"OffsetDateTime"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"OffsetTime"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"oneway"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"open"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"operator"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"optional"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"or"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"or_eq"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"out"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"override"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"package"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"params"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"pass"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"port"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"postfix"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"precedence"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"prefix"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"print"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"printMembers"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"printf"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"private"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"protected"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Protocol"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"public"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"quicktype"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"raise"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"range"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"readonly"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ref"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"RegExp"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"reinterpret_cast"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"new"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _mutable = [QTMutable fromJSONDictionary:(id)_mutable];
        if (!_mutable && dict[@"mutable"] && ![dict[@"mutable"] isKindOfClass:NSNull.class]) return nil;
        _mutating = [QTMutating fromJSONDictionary:(id)_mutating];
        if (!_mutating && dict[@"mutating"] && ![dict[@"mutating"] isKindOfClass:NSNull.class]) return nil;
        _namespace = [QTNamespace fromJSONDictionary:(id)_namespace];
        if (!_namespace && dict[@"namespace"] && ![dict[@"namespace"] isKindOfClass:NSNull.class]) return nil;
        _native = [QTNative fromJSONDictionary:(id)_native];
        if (!_native && dict[@"native"] && ![dict[@"native"] isKindOfClass:NSNull.class]) return nil;
        _newtonsoft = [QTNewtonsoft fromJSONDictionary:(id)_newtonsoft];
        if (!_newtonsoft && dict[@"newtonsoft"] && ![dict[@"newtonsoft"] isKindOfClass:NSNull.class]) return nil;
        _no = [QTNo fromJSONDictionary:(id)_no];
        if (!_no && dict[@"NO"] && ![dict[@"NO"] isKindOfClass:NSNull.class]) return nil;
        _noSuchMethod = [QTNoSuchMethod fromJSONDictionary:(id)_noSuchMethod];
        if (!_noSuchMethod && dict[@"noSuchMethod"] && ![dict[@"noSuchMethod"] isKindOfClass:NSNull.class]) return nil;
        _noexcept = [QTNoexcept fromJSONDictionary:(id)_noexcept];
        if (!_noexcept && dict[@"noexcept"] && ![dict[@"noexcept"] isKindOfClass:NSNull.class]) return nil;
        _none = [QTNone fromJSONDictionary:(id)_none];
        if (!_none && dict[@"None"] && ![dict[@"None"] isKindOfClass:NSNull.class]) return nil;
        _nonlocal = [QTNonlocal fromJSONDictionary:(id)_nonlocal];
        if (!_nonlocal && dict[@"nonlocal"] && ![dict[@"nonlocal"] isKindOfClass:NSNull.class]) return nil;
        _nonmutating = [QTNonmutating fromJSONDictionary:(id)_nonmutating];
        if (!_nonmutating && dict[@"nonmutating"] && ![dict[@"nonmutating"] isKindOfClass:NSNull.class]) return nil;
        _not = [QTNot fromJSONDictionary:(id)_not];
        if (!_not && dict[@"not"] && ![dict[@"not"] isKindOfClass:NSNull.class]) return nil;
        _notEq = [QTNotEq fromJSONDictionary:(id)_notEq];
        if (!_notEq && dict[@"not_eq"] && ![dict[@"not_eq"] isKindOfClass:NSNull.class]) return nil;
        _nsError = [QTNSError fromJSONDictionary:(id)_nsError];
        if (!_nsError && dict[@"NSError"] && ![dict[@"NSError"] isKindOfClass:NSNull.class]) return nil;
        _nsObject = [QTNSObject fromJSONDictionary:(id)_nsObject];
        if (!_nsObject && dict[@"NSObject"] && ![dict[@"NSObject"] isKindOfClass:NSNull.class]) return nil;
        _nsString = [QTNSString fromJSONDictionary:(id)_nsString];
        if (!_nsString && dict[@"NSString"] && ![dict[@"NSString"] isKindOfClass:NSNull.class]) return nil;
        _null = [QTNull fromJSONDictionary:(id)_null];
        if (!_null && dict[@"NULL"] && ![dict[@"NULL"] isKindOfClass:NSNull.class]) return nil;
        _nullNode = [QTNullNode fromJSONDictionary:(id)_nullNode];
        if (!_nullNode && dict[@"NullNode"] && ![dict[@"NullNode"] isKindOfClass:NSNull.class]) return nil;
        _nullptr = [QTNullptr fromJSONDictionary:(id)_nullptr];
        if (!_nullptr && dict[@"nullptr"] && ![dict[@"nullptr"] isKindOfClass:NSNull.class]) return nil;
        _number = [QTNumber fromJSONDictionary:(id)_number];
        if (!_number && dict[@"number"] && ![dict[@"number"] isKindOfClass:NSNull.class]) return nil;
        _obj4Nil = [QTNil fromJSONDictionary:(id)_obj4Nil];
        if (!_obj4Nil && dict[@"nil"] && ![dict[@"nil"] isKindOfClass:NSNull.class]) return nil;
        _obj4Nonatomic = [QTNonatomic fromJSONDictionary:(id)_obj4Nonatomic];
        if (!_obj4Nonatomic && dict[@"nonatomic"] && ![dict[@"nonatomic"] isKindOfClass:NSNull.class]) return nil;
        _obj4None = [QTNoneClass fromJSONDictionary:(id)_obj4None];
        if (!_obj4None && dict[@"none"] && ![dict[@"none"] isKindOfClass:NSNull.class]) return nil;
        _obj4Null = [QTNullClass fromJSONDictionary:(id)_obj4Null];
        if (!_obj4Null && dict[@"null"] && ![dict[@"null"] isKindOfClass:NSNull.class]) return nil;
        _obj4Protocol = [QTProtocolClass fromJSONDictionary:(id)_obj4Protocol];
        if (!_obj4Protocol && dict[@"protocol"] && ![dict[@"protocol"] isKindOfClass:NSNull.class]) return nil;
        _obj4Register = [QTRegister fromJSONDictionary:(id)_obj4Register];
        if (!_obj4Register && dict[@"register"] && ![dict[@"register"] isKindOfClass:NSNull.class]) return nil;
        _object = [QTObject fromJSONDictionary:(id)_object];
        if (!_object && dict[@"object"] && ![dict[@"object"] isKindOfClass:NSNull.class]) return nil;
        _objectMapper = [QTObjectMapper fromJSONDictionary:(id)_objectMapper];
        if (!_objectMapper && dict[@"ObjectMapper"] && ![dict[@"ObjectMapper"] isKindOfClass:NSNull.class]) return nil;
        _objectNode = [QTObjectNode fromJSONDictionary:(id)_objectNode];
        if (!_objectNode && dict[@"ObjectNode"] && ![dict[@"ObjectNode"] isKindOfClass:NSNull.class]) return nil;
        _objectReader = [QTObjectReader fromJSONDictionary:(id)_objectReader];
        if (!_objectReader && dict[@"ObjectReader"] && ![dict[@"ObjectReader"] isKindOfClass:NSNull.class]) return nil;
        _objectWriter = [QTObjectWriter fromJSONDictionary:(id)_objectWriter];
        if (!_objectWriter && dict[@"ObjectWriter"] && ![dict[@"ObjectWriter"] isKindOfClass:NSNull.class]) return nil;
        _of = [QTOf fromJSONDictionary:(id)_of];
        if (!_of && dict[@"of"] && ![dict[@"of"] isKindOfClass:NSNull.class]) return nil;
        _offsetDateTime = [QTOffsetDateTime fromJSONDictionary:(id)_offsetDateTime];
        if (!_offsetDateTime && dict[@"OffsetDateTime"] && ![dict[@"OffsetDateTime"] isKindOfClass:NSNull.class]) return nil;
        _offsetTime = [QTOffsetTime fromJSONDictionary:(id)_offsetTime];
        if (!_offsetTime && dict[@"OffsetTime"] && ![dict[@"OffsetTime"] isKindOfClass:NSNull.class]) return nil;
        _oneway = [QTOneway fromJSONDictionary:(id)_oneway];
        if (!_oneway && dict[@"oneway"] && ![dict[@"oneway"] isKindOfClass:NSNull.class]) return nil;
        _open = [QTOpen fromJSONDictionary:(id)_open];
        if (!_open && dict[@"open"] && ![dict[@"open"] isKindOfClass:NSNull.class]) return nil;
        _operator = [QTOperator fromJSONDictionary:(id)_operator];
        if (!_operator && dict[@"operator"] && ![dict[@"operator"] isKindOfClass:NSNull.class]) return nil;
        _optional = [QTOptional fromJSONDictionary:(id)_optional];
        if (!_optional && dict[@"optional"] && ![dict[@"optional"] isKindOfClass:NSNull.class]) return nil;
        _or = [QTOr fromJSONDictionary:(id)_or];
        if (!_or && dict[@"or"] && ![dict[@"or"] isKindOfClass:NSNull.class]) return nil;
        _orEq = [QTOrEq fromJSONDictionary:(id)_orEq];
        if (!_orEq && dict[@"or_eq"] && ![dict[@"or_eq"] isKindOfClass:NSNull.class]) return nil;
        _out = [QTOut fromJSONDictionary:(id)_out];
        if (!_out && dict[@"out"] && ![dict[@"out"] isKindOfClass:NSNull.class]) return nil;
        _override = [QTOverride fromJSONDictionary:(id)_override];
        if (!_override && dict[@"override"] && ![dict[@"override"] isKindOfClass:NSNull.class]) return nil;
        _package = [QTPackage fromJSONDictionary:(id)_package];
        if (!_package && dict[@"package"] && ![dict[@"package"] isKindOfClass:NSNull.class]) return nil;
        _params = [QTParams fromJSONDictionary:(id)_params];
        if (!_params && dict[@"params"] && ![dict[@"params"] isKindOfClass:NSNull.class]) return nil;
        _pass = [QTPass fromJSONDictionary:(id)_pass];
        if (!_pass && dict[@"pass"] && ![dict[@"pass"] isKindOfClass:NSNull.class]) return nil;
        _port = [QTPort fromJSONDictionary:(id)_port];
        if (!_port && dict[@"port"] && ![dict[@"port"] isKindOfClass:NSNull.class]) return nil;
        _postfix = [QTPostfix fromJSONDictionary:(id)_postfix];
        if (!_postfix && dict[@"postfix"] && ![dict[@"postfix"] isKindOfClass:NSNull.class]) return nil;
        _precedence = [QTPrecedence fromJSONDictionary:(id)_precedence];
        if (!_precedence && dict[@"precedence"] && ![dict[@"precedence"] isKindOfClass:NSNull.class]) return nil;
        _prefix = [QTPrefix fromJSONDictionary:(id)_prefix];
        if (!_prefix && dict[@"prefix"] && ![dict[@"prefix"] isKindOfClass:NSNull.class]) return nil;
        _print = [QTPrint fromJSONDictionary:(id)_print];
        if (!_print && dict[@"print"] && ![dict[@"print"] isKindOfClass:NSNull.class]) return nil;
        _printMembers = [QTPrintMembers fromJSONDictionary:(id)_printMembers];
        if (!_printMembers && dict[@"printMembers"] && ![dict[@"printMembers"] isKindOfClass:NSNull.class]) return nil;
        _printf = [QTPrintf fromJSONDictionary:(id)_printf];
        if (!_printf && dict[@"printf"] && ![dict[@"printf"] isKindOfClass:NSNull.class]) return nil;
        _private = [QTPrivate fromJSONDictionary:(id)_private];
        if (!_private && dict[@"private"] && ![dict[@"private"] isKindOfClass:NSNull.class]) return nil;
        _protected = [QTProtected fromJSONDictionary:(id)_protected];
        if (!_protected && dict[@"protected"] && ![dict[@"protected"] isKindOfClass:NSNull.class]) return nil;
        _protocol = [QTProtocol fromJSONDictionary:(id)_protocol];
        if (!_protocol && dict[@"Protocol"] && ![dict[@"Protocol"] isKindOfClass:NSNull.class]) return nil;
        _public = [QTPublic fromJSONDictionary:(id)_public];
        if (!_public && dict[@"public"] && ![dict[@"public"] isKindOfClass:NSNull.class]) return nil;
        _quicktype = [QTQuicktype fromJSONDictionary:(id)_quicktype];
        if (!_quicktype && dict[@"quicktype"] && ![dict[@"quicktype"] isKindOfClass:NSNull.class]) return nil;
        _raise = [QTRaise fromJSONDictionary:(id)_raise];
        if (!_raise && dict[@"raise"] && ![dict[@"raise"] isKindOfClass:NSNull.class]) return nil;
        _range = [QTRange fromJSONDictionary:(id)_range];
        if (!_range && dict[@"range"] && ![dict[@"range"] isKindOfClass:NSNull.class]) return nil;
        _readonly = [QTReadonly fromJSONDictionary:(id)_readonly];
        if (!_readonly && dict[@"readonly"] && ![dict[@"readonly"] isKindOfClass:NSNull.class]) return nil;
        _ref = [QTRef fromJSONDictionary:(id)_ref];
        if (!_ref && dict[@"ref"] && ![dict[@"ref"] isKindOfClass:NSNull.class]) return nil;
        _regExp = [QTRegExp fromJSONDictionary:(id)_regExp];
        if (!_regExp && dict[@"RegExp"] && ![dict[@"RegExp"] isKindOfClass:NSNull.class]) return nil;
        _reinterpretCast = [QTReinterpretCast fromJSONDictionary:(id)_reinterpretCast];
        if (!_reinterpretCast && dict[@"reinterpret_cast"] && ![dict[@"reinterpret_cast"] isKindOfClass:NSNull.class]) return nil;
        _theNew = [QTNew fromJSONDictionary:(id)_theNew];
        if (!_theNew && dict[@"new"] && ![dict[@"new"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObj4.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObj4.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObj4.properties.allValues] mutableCopy];

    for (id jsonName in QTObj4.properties) {
        id propertyName = QTObj4.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"mutable": [_mutable JSONDictionary],
        @"mutating": [_mutating JSONDictionary],
        @"namespace": [_namespace JSONDictionary],
        @"native": [_native JSONDictionary],
        @"newtonsoft": [_newtonsoft JSONDictionary],
        @"NO": [_no JSONDictionary],
        @"noSuchMethod": [_noSuchMethod JSONDictionary],
        @"noexcept": [_noexcept JSONDictionary],
        @"None": [_none JSONDictionary],
        @"nonlocal": [_nonlocal JSONDictionary],
        @"nonmutating": [_nonmutating JSONDictionary],
        @"not": [_not JSONDictionary],
        @"not_eq": [_notEq JSONDictionary],
        @"NSError": [_nsError JSONDictionary],
        @"NSObject": [_nsObject JSONDictionary],
        @"NSString": [_nsString JSONDictionary],
        @"NULL": [_null JSONDictionary],
        @"NullNode": [_nullNode JSONDictionary],
        @"nullptr": [_nullptr JSONDictionary],
        @"number": [_number JSONDictionary],
        @"nil": [_obj4Nil JSONDictionary],
        @"nonatomic": [_obj4Nonatomic JSONDictionary],
        @"none": [_obj4None JSONDictionary],
        @"null": [_obj4Null JSONDictionary],
        @"protocol": [_obj4Protocol JSONDictionary],
        @"register": [_obj4Register JSONDictionary],
        @"object": [_object JSONDictionary],
        @"ObjectMapper": [_objectMapper JSONDictionary],
        @"ObjectNode": [_objectNode JSONDictionary],
        @"ObjectReader": [_objectReader JSONDictionary],
        @"ObjectWriter": [_objectWriter JSONDictionary],
        @"of": [_of JSONDictionary],
        @"OffsetDateTime": [_offsetDateTime JSONDictionary],
        @"OffsetTime": [_offsetTime JSONDictionary],
        @"oneway": [_oneway JSONDictionary],
        @"open": [_open JSONDictionary],
        @"operator": [_operator JSONDictionary],
        @"optional": [_optional JSONDictionary],
        @"or": [_or JSONDictionary],
        @"or_eq": [_orEq JSONDictionary],
        @"out": [_out JSONDictionary],
        @"override": [_override JSONDictionary],
        @"package": [_package JSONDictionary],
        @"params": [_params JSONDictionary],
        @"pass": [_pass JSONDictionary],
        @"port": [_port JSONDictionary],
        @"postfix": [_postfix JSONDictionary],
        @"precedence": [_precedence JSONDictionary],
        @"prefix": [_prefix JSONDictionary],
        @"print": [_print JSONDictionary],
        @"printMembers": [_printMembers JSONDictionary],
        @"printf": [_printf JSONDictionary],
        @"private": [_private JSONDictionary],
        @"protected": [_protected JSONDictionary],
        @"Protocol": [_protocol JSONDictionary],
        @"public": [_public JSONDictionary],
        @"quicktype": [_quicktype JSONDictionary],
        @"raise": [_raise JSONDictionary],
        @"range": [_range JSONDictionary],
        @"readonly": [_readonly JSONDictionary],
        @"ref": [_ref JSONDictionary],
        @"RegExp": [_regExp JSONDictionary],
        @"reinterpret_cast": [_reinterpretCast JSONDictionary],
        @"new": [_theNew JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTMutable
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"mutable": @"mutable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMutable alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"mutable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"mutable"] doubleValue] != [dict[@"mutable"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMutable.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMutable.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTMutable.properties.allValues];
}
@end

@implementation QTMutating
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"mutating": @"mutating",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTMutating alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"mutating"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"mutating"] doubleValue] != [dict[@"mutating"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTMutating.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTMutating.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTMutating.properties.allValues];
}
@end

@implementation QTNamespace
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"namespace": @"namespace",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNamespace alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"namespace"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"namespace"] doubleValue] != [dict[@"namespace"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNamespace.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNamespace.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNamespace.properties.allValues];
}
@end

@implementation QTNative
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"native": @"native",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNative alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"native"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"native"] doubleValue] != [dict[@"native"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNative.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNative.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNative.properties.allValues];
}
@end

@implementation QTNewtonsoft
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"newtonsoft": @"newtonsoft",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNewtonsoft alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"newtonsoft"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"newtonsoft"] doubleValue] != [dict[@"newtonsoft"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNewtonsoft.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNewtonsoft.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNewtonsoft.properties.allValues];
}
@end

@implementation QTNo
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"NO": @"no",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNo alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"NO"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NO"] doubleValue] != [dict[@"NO"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNo.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNo.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNo.properties.allValues] mutableCopy];

    for (id jsonName in QTNo.properties) {
        id propertyName = QTNo.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNoSuchMethod
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"noSuchMethod": @"noSuchMethod",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNoSuchMethod alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"noSuchMethod"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"noSuchMethod"] doubleValue] != [dict[@"noSuchMethod"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNoSuchMethod.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNoSuchMethod.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNoSuchMethod.properties.allValues];
}
@end

@implementation QTNoexcept
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"noexcept": @"noexcept",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNoexcept alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"noexcept"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"noexcept"] doubleValue] != [dict[@"noexcept"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNoexcept.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNoexcept.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNoexcept.properties.allValues];
}
@end

@implementation QTNone
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"None": @"none",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNone alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"None"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"None"] doubleValue] != [dict[@"None"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNone.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNone.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNone.properties.allValues] mutableCopy];

    for (id jsonName in QTNone.properties) {
        id propertyName = QTNone.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNonlocal
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"nonlocal": @"nonlocal",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNonlocal alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"nonlocal"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"nonlocal"] doubleValue] != [dict[@"nonlocal"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNonlocal.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNonlocal.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNonlocal.properties.allValues];
}
@end

@implementation QTNonmutating
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"nonmutating": @"nonmutating",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNonmutating alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"nonmutating"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"nonmutating"] doubleValue] != [dict[@"nonmutating"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNonmutating.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNonmutating.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNonmutating.properties.allValues];
}
@end

@implementation QTNot
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"not": @"not",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNot alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"not"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"not"] doubleValue] != [dict[@"not"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNot.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNot.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNot.properties.allValues];
}
@end

@implementation QTNotEq
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"not_eq": @"notEq",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNotEq alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"not_eq"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"not_eq"] doubleValue] != [dict[@"not_eq"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNotEq.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNotEq.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNotEq.properties.allValues] mutableCopy];

    for (id jsonName in QTNotEq.properties) {
        id propertyName = QTNotEq.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNSError
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"NSError": @"nsError",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNSError alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"NSError"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NSError"] doubleValue] != [dict[@"NSError"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNSError.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNSError.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNSError.properties.allValues] mutableCopy];

    for (id jsonName in QTNSError.properties) {
        id propertyName = QTNSError.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNSObject
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"NSObject": @"nsObject",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNSObject alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"NSObject"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NSObject"] doubleValue] != [dict[@"NSObject"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNSObject.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNSObject.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNSObject.properties.allValues] mutableCopy];

    for (id jsonName in QTNSObject.properties) {
        id propertyName = QTNSObject.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNSString
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"NSString": @"nsString",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNSString alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"NSString"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NSString"] doubleValue] != [dict[@"NSString"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNSString.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNSString.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNSString.properties.allValues] mutableCopy];

    for (id jsonName in QTNSString.properties) {
        id propertyName = QTNSString.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNull
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"NULL": @"null",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNull alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"NULL"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NULL"] doubleValue] != [dict[@"NULL"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNull.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNull.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNull.properties.allValues] mutableCopy];

    for (id jsonName in QTNull.properties) {
        id propertyName = QTNull.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNullNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"NullNode": @"nullNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNullNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"NullNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"NullNode"] doubleValue] != [dict[@"NullNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNullNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNullNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNullNode.properties.allValues] mutableCopy];

    for (id jsonName in QTNullNode.properties) {
        id propertyName = QTNullNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNullptr
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"nullptr": @"nullptr",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNullptr alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"nullptr"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"nullptr"] doubleValue] != [dict[@"nullptr"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNullptr.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNullptr.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNullptr.properties.allValues];
}
@end

@implementation QTNumber
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"number": @"number",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNumber alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"number"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"number"] doubleValue] != [dict[@"number"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNumber.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNumber.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNumber.properties.allValues];
}
@end

@implementation QTNil
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"nil": @"nilNil",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNil alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"nil"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"nil"] doubleValue] != [dict[@"nil"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNil.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNil.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNil.properties.allValues] mutableCopy];

    for (id jsonName in QTNil.properties) {
        id propertyName = QTNil.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNonatomic
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"nonatomic": @"nonatomicNonatomic",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNonatomic alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"nonatomic"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"nonatomic"] doubleValue] != [dict[@"nonatomic"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNonatomic.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNonatomic.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNonatomic.properties.allValues] mutableCopy];

    for (id jsonName in QTNonatomic.properties) {
        id propertyName = QTNonatomic.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNoneClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"none": @"none",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNoneClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"none"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"none"] doubleValue] != [dict[@"none"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNoneClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNoneClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNoneClass.properties.allValues];
}
@end

@implementation QTNullClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"null": @"null",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNullClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"null"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"null"] doubleValue] != [dict[@"null"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNullClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNullClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTNullClass.properties.allValues];
}
@end

@implementation QTProtocolClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"protocol": @"protocol",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProtocolClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"protocol"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"protocol"] doubleValue] != [dict[@"protocol"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProtocolClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProtocolClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTProtocolClass.properties.allValues];
}
@end

@implementation QTRegister
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"register": @"registerRegister",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRegister alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"register"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"register"] doubleValue] != [dict[@"register"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRegister.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRegister.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRegister.properties.allValues] mutableCopy];

    for (id jsonName in QTRegister.properties) {
        id propertyName = QTRegister.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObject
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"object": @"object",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObject alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"object"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"object"] doubleValue] != [dict[@"object"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObject.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObject.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTObject.properties.allValues];
}
@end

@implementation QTObjectMapper
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ObjectMapper": @"objectMapper",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObjectMapper alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ObjectMapper"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ObjectMapper"] doubleValue] != [dict[@"ObjectMapper"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObjectMapper.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObjectMapper.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObjectMapper.properties.allValues] mutableCopy];

    for (id jsonName in QTObjectMapper.properties) {
        id propertyName = QTObjectMapper.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObjectNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ObjectNode": @"objectNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObjectNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ObjectNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ObjectNode"] doubleValue] != [dict[@"ObjectNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObjectNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObjectNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObjectNode.properties.allValues] mutableCopy];

    for (id jsonName in QTObjectNode.properties) {
        id propertyName = QTObjectNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObjectReader
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ObjectReader": @"objectReader",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObjectReader alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ObjectReader"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ObjectReader"] doubleValue] != [dict[@"ObjectReader"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObjectReader.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObjectReader.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObjectReader.properties.allValues] mutableCopy];

    for (id jsonName in QTObjectReader.properties) {
        id propertyName = QTObjectReader.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObjectWriter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ObjectWriter": @"objectWriter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObjectWriter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ObjectWriter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ObjectWriter"] doubleValue] != [dict[@"ObjectWriter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObjectWriter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObjectWriter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObjectWriter.properties.allValues] mutableCopy];

    for (id jsonName in QTObjectWriter.properties) {
        id propertyName = QTObjectWriter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTOf
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"of": @"of",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOf alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"of"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"of"] doubleValue] != [dict[@"of"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOf.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOf.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOf.properties.allValues];
}
@end

@implementation QTOffsetDateTime
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"OffsetDateTime": @"offsetDateTime",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOffsetDateTime alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"OffsetDateTime"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"OffsetDateTime"] doubleValue] != [dict[@"OffsetDateTime"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOffsetDateTime.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOffsetDateTime.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOffsetDateTime.properties.allValues] mutableCopy];

    for (id jsonName in QTOffsetDateTime.properties) {
        id propertyName = QTOffsetDateTime.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTOffsetTime
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"OffsetTime": @"offsetTime",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOffsetTime alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"OffsetTime"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"OffsetTime"] doubleValue] != [dict[@"OffsetTime"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOffsetTime.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOffsetTime.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOffsetTime.properties.allValues] mutableCopy];

    for (id jsonName in QTOffsetTime.properties) {
        id propertyName = QTOffsetTime.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTOneway
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"oneway": @"oneway",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOneway alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"oneway"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"oneway"] doubleValue] != [dict[@"oneway"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOneway.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOneway.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOneway.properties.allValues];
}
@end

@implementation QTOpen
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"open": @"open",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOpen alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"open"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"open"] doubleValue] != [dict[@"open"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOpen.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOpen.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOpen.properties.allValues];
}
@end

@implementation QTOperator
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"operator": @"operator",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOperator alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"operator"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"operator"] doubleValue] != [dict[@"operator"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOperator.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOperator.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOperator.properties.allValues];
}
@end

@implementation QTOptional
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"optional": @"optional",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOptional alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"optional"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"optional"] doubleValue] != [dict[@"optional"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOptional.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOptional.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOptional.properties.allValues];
}
@end

@implementation QTOr
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"or": @"or",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOr alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"or"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"or"] doubleValue] != [dict[@"or"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOr.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOr.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOr.properties.allValues];
}
@end

@implementation QTOrEq
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"or_eq": @"orEq",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOrEq alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"or_eq"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"or_eq"] doubleValue] != [dict[@"or_eq"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOrEq.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOrEq.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTOrEq.properties.allValues] mutableCopy];

    for (id jsonName in QTOrEq.properties) {
        id propertyName = QTOrEq.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTOut
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"out": @"out",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOut alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"out"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"out"] doubleValue] != [dict[@"out"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOut.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOut.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOut.properties.allValues];
}
@end

@implementation QTOverride
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"override": @"override",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTOverride alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"override"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"override"] doubleValue] != [dict[@"override"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTOverride.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTOverride.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTOverride.properties.allValues];
}
@end

@implementation QTPackage
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"package": @"package",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPackage alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"package"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"package"] doubleValue] != [dict[@"package"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPackage.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPackage.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPackage.properties.allValues];
}
@end

@implementation QTParams
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"params": @"params",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTParams alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"params"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"params"] doubleValue] != [dict[@"params"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTParams.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTParams.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTParams.properties.allValues];
}
@end

@implementation QTPass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"pass": @"pass",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"pass"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"pass"] doubleValue] != [dict[@"pass"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPass.properties.allValues];
}
@end

@implementation QTPort
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"port": @"port",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPort alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"port"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"port"] doubleValue] != [dict[@"port"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPort.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPort.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPort.properties.allValues];
}
@end

@implementation QTPostfix
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"postfix": @"postfix",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPostfix alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"postfix"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"postfix"] doubleValue] != [dict[@"postfix"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPostfix.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPostfix.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPostfix.properties.allValues];
}
@end

@implementation QTPrecedence
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"precedence": @"precedence",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrecedence alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"precedence"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"precedence"] doubleValue] != [dict[@"precedence"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrecedence.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrecedence.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPrecedence.properties.allValues];
}
@end

@implementation QTPrefix
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"prefix": @"prefix",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrefix alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"prefix"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"prefix"] doubleValue] != [dict[@"prefix"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrefix.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrefix.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPrefix.properties.allValues];
}
@end

@implementation QTPrint
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"print": @"print",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrint alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"print"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"print"] doubleValue] != [dict[@"print"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrint.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrint.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPrint.properties.allValues];
}
@end

@implementation QTPrintMembers
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"printMembers": @"printMembers",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrintMembers alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"printMembers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"printMembers"] doubleValue] != [dict[@"printMembers"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrintMembers.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrintMembers.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPrintMembers.properties.allValues];
}
@end

@implementation QTPrintf
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"printf": @"printf",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrintf alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"printf"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"printf"] doubleValue] != [dict[@"printf"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrintf.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrintf.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPrintf.properties.allValues];
}
@end

@implementation QTPrivate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"private": @"private",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrivate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"private"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"private"] doubleValue] != [dict[@"private"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrivate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrivate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPrivate.properties.allValues];
}
@end

@implementation QTProtected
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"protected": @"protected",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProtected alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"protected"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"protected"] doubleValue] != [dict[@"protected"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProtected.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProtected.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTProtected.properties.allValues];
}
@end

@implementation QTProtocol
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Protocol": @"protocol",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTProtocol alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Protocol"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Protocol"] doubleValue] != [dict[@"Protocol"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTProtocol.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTProtocol.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTProtocol.properties.allValues] mutableCopy];

    for (id jsonName in QTProtocol.properties) {
        id propertyName = QTProtocol.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPublic
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"public": @"public",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPublic alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"public"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"public"] doubleValue] != [dict[@"public"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPublic.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPublic.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTPublic.properties.allValues];
}
@end

@implementation QTQuicktype
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"quicktype": @"quicktype",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTQuicktype alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"quicktype"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"quicktype"] doubleValue] != [dict[@"quicktype"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTQuicktype.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTQuicktype.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTQuicktype.properties.allValues];
}
@end

@implementation QTRaise
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"raise": @"raise",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRaise alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"raise"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"raise"] doubleValue] != [dict[@"raise"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRaise.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRaise.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRaise.properties.allValues];
}
@end

@implementation QTRange
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"range": @"range",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRange alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"range"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"range"] doubleValue] != [dict[@"range"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRange.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRange.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRange.properties.allValues];
}
@end

@implementation QTReadonly
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"readonly": @"readonly",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTReadonly alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"readonly"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"readonly"] doubleValue] != [dict[@"readonly"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTReadonly.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTReadonly.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTReadonly.properties.allValues];
}
@end

@implementation QTRef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ref": @"ref",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ref"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ref"] doubleValue] != [dict[@"ref"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRef.properties.allValues];
}
@end

@implementation QTRegExp
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"RegExp": @"regExp",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRegExp alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (dict[@"RegExp"] && ![[NSUUID alloc] initWithUUIDString:dict[@"RegExp"]]) return nil;
        if (![dict[@"RegExp"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRegExp.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRegExp.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRegExp.properties.allValues] mutableCopy];

    for (id jsonName in QTRegExp.properties) {
        id propertyName = QTRegExp.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTReinterpretCast
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"reinterpret_cast": @"reinterpretCast",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTReinterpretCast alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"reinterpret_cast"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"reinterpret_cast"] doubleValue] != [dict[@"reinterpret_cast"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTReinterpretCast.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTReinterpretCast.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTReinterpretCast.properties.allValues] mutableCopy];

    for (id jsonName in QTReinterpretCast.properties) {
        id propertyName = QTReinterpretCast.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTNew
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"new": @"theNew",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTNew alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"new"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"new"] doubleValue] != [dict[@"new"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTNew.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTNew.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTNew.properties.allValues] mutableCopy];

    for (id jsonName in QTNew.properties) {
        id propertyName = QTNew.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTObj5
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dummy": @"dummy",
        @"KSerializer": @"kSerializer",
        @"restrict": @"obj5Restrict",
        @"retain": @"obj5Retain",
        @"return": @"obj5Return",
        @"self": @"obj5Self",
        @"short": @"obj5Short",
        @"signed": @"obj5Signed",
        @"sizeof": @"obj5Sizeof",
        @"static": @"obj5Static",
        @"struct": @"obj5Struct",
        @"switch": @"obj5Switch",
        @"True": @"obj5True",
        @"PrimitiveKind": @"primitiveKind",
        @"repeat": @"repeat",
        @"require": @"require",
        @"required": @"required",
        @"requires": @"requires",
        @"rethrows": @"rethrows",
        @"right": @"right",
        @"runtimeType": @"runtimeType",
        @"s": @"s",
        @"sbyte": @"sbyte",
        @"sealed": @"sealed",
        @"SEL": @"sel",
        @"select": @"select",
        @"Self": @"self",
        @"Sendable": @"sendable",
        @"SerialDescriptor": @"serialDescriptor",
        @"SerialName": @"serialName",
        @"Serializable": @"serializable",
        @"SerializationFeature": @"serializationFeature",
        @"serialize": @"serialize",
        @"SerializerProvider": @"serializerProvider",
        @"set": @"set",
        @"SimpleModule": @"simpleModule",
        @"stackalloc": @"stackalloc",
        @"Standards": @"standards",
        @"static_assert": @"staticAssert",
        @"static_cast": @"staticCast",
        @"StdDeserializer": @"stdDeserializer",
        @"StdSerializer": @"stdSerializer",
        @"strictfp": @"strictfp",
        @"string": @"string",
        @"subscript": @"subscript",
        @"super": @"super",
        @"symbol": @"symbol",
        @"synchronized": @"synchronized",
        @"system": @"system",
        @"template": @"template",
        @"TextNode": @"textNode",
        @"true": @"theTrue",
        @"then": @"then",
        @"this": @"this",
        @"thread_local": @"threadLocal",
        @"throw": @"throw",
        @"throws": @"throws",
        @"TimeOnly": @"timeOnly",
        @"TimeOnlyConverter": @"timeOnlyConverter",
        @"TimeZone": @"timeZone",
        @"to_dict": @"toDict",
        @"to_json": @"toJSON",
        @"toString": @"toString",
        @"top_level": @"topLevel",
        @"transient": @"transient",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObj5 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dummy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dummy"] doubleValue] != [dict[@"dummy"] longLongValue]) return nil;
        if (![dict[@"KSerializer"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"restrict"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"retain"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"return"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"self"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"short"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"signed"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sizeof"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"static"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"struct"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"switch"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"True"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"PrimitiveKind"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"repeat"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"require"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"required"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"requires"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"rethrows"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"right"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"runtimeType"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"s"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sbyte"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"sealed"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"SEL"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"select"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Self"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Sendable"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"SerialDescriptor"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"SerialName"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Serializable"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"SerializationFeature"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"serialize"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"SerializerProvider"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"set"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"SimpleModule"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"stackalloc"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Standards"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"static_assert"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"static_cast"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"StdDeserializer"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"StdSerializer"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"strictfp"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"string"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"subscript"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"super"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"symbol"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"synchronized"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"system"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"template"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"TextNode"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"true"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"then"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"this"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"thread_local"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"throw"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"throws"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"TimeOnly"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"TimeOnlyConverter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"TimeZone"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"to_dict"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"to_json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"toString"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"top_level"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"transient"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _kSerializer = [QTKSerializer fromJSONDictionary:(id)_kSerializer];
        if (!_kSerializer && dict[@"KSerializer"] && ![dict[@"KSerializer"] isKindOfClass:NSNull.class]) return nil;
        _obj5Restrict = [QTRestrict fromJSONDictionary:(id)_obj5Restrict];
        if (!_obj5Restrict && dict[@"restrict"] && ![dict[@"restrict"] isKindOfClass:NSNull.class]) return nil;
        _obj5Retain = [QTRetain fromJSONDictionary:(id)_obj5Retain];
        if (!_obj5Retain && dict[@"retain"] && ![dict[@"retain"] isKindOfClass:NSNull.class]) return nil;
        _obj5Return = [QTReturn fromJSONDictionary:(id)_obj5Return];
        if (!_obj5Return && dict[@"return"] && ![dict[@"return"] isKindOfClass:NSNull.class]) return nil;
        _obj5Self = [QTSelfClass fromJSONDictionary:(id)_obj5Self];
        if (!_obj5Self && dict[@"self"] && ![dict[@"self"] isKindOfClass:NSNull.class]) return nil;
        _obj5Short = [QTShort fromJSONDictionary:(id)_obj5Short];
        if (!_obj5Short && dict[@"short"] && ![dict[@"short"] isKindOfClass:NSNull.class]) return nil;
        _obj5Signed = [QTSigned fromJSONDictionary:(id)_obj5Signed];
        if (!_obj5Signed && dict[@"signed"] && ![dict[@"signed"] isKindOfClass:NSNull.class]) return nil;
        _obj5Sizeof = [QTSizeof fromJSONDictionary:(id)_obj5Sizeof];
        if (!_obj5Sizeof && dict[@"sizeof"] && ![dict[@"sizeof"] isKindOfClass:NSNull.class]) return nil;
        _obj5Static = [QTStatic fromJSONDictionary:(id)_obj5Static];
        if (!_obj5Static && dict[@"static"] && ![dict[@"static"] isKindOfClass:NSNull.class]) return nil;
        _obj5Struct = [QTStruct fromJSONDictionary:(id)_obj5Struct];
        if (!_obj5Struct && dict[@"struct"] && ![dict[@"struct"] isKindOfClass:NSNull.class]) return nil;
        _obj5Switch = [QTSwitch fromJSONDictionary:(id)_obj5Switch];
        if (!_obj5Switch && dict[@"switch"] && ![dict[@"switch"] isKindOfClass:NSNull.class]) return nil;
        _obj5True = [QTTrue fromJSONDictionary:(id)_obj5True];
        if (!_obj5True && dict[@"True"] && ![dict[@"True"] isKindOfClass:NSNull.class]) return nil;
        _primitiveKind = [QTPrimitiveKind fromJSONDictionary:(id)_primitiveKind];
        if (!_primitiveKind && dict[@"PrimitiveKind"] && ![dict[@"PrimitiveKind"] isKindOfClass:NSNull.class]) return nil;
        _repeat = [QTRepeat fromJSONDictionary:(id)_repeat];
        if (!_repeat && dict[@"repeat"] && ![dict[@"repeat"] isKindOfClass:NSNull.class]) return nil;
        _require = [QTRequire fromJSONDictionary:(id)_require];
        if (!_require && dict[@"require"] && ![dict[@"require"] isKindOfClass:NSNull.class]) return nil;
        _required = [QTRequired fromJSONDictionary:(id)_required];
        if (!_required && dict[@"required"] && ![dict[@"required"] isKindOfClass:NSNull.class]) return nil;
        _requires = [QTRequires fromJSONDictionary:(id)_requires];
        if (!_requires && dict[@"requires"] && ![dict[@"requires"] isKindOfClass:NSNull.class]) return nil;
        _rethrows = [QTRethrows fromJSONDictionary:(id)_rethrows];
        if (!_rethrows && dict[@"rethrows"] && ![dict[@"rethrows"] isKindOfClass:NSNull.class]) return nil;
        _right = [QTRight fromJSONDictionary:(id)_right];
        if (!_right && dict[@"right"] && ![dict[@"right"] isKindOfClass:NSNull.class]) return nil;
        _runtimeType = [QTRuntimeType fromJSONDictionary:(id)_runtimeType];
        if (!_runtimeType && dict[@"runtimeType"] && ![dict[@"runtimeType"] isKindOfClass:NSNull.class]) return nil;
        _s = [QTS fromJSONDictionary:(id)_s];
        if (!_s && dict[@"s"] && ![dict[@"s"] isKindOfClass:NSNull.class]) return nil;
        _sbyte = [QTSbyte fromJSONDictionary:(id)_sbyte];
        if (!_sbyte && dict[@"sbyte"] && ![dict[@"sbyte"] isKindOfClass:NSNull.class]) return nil;
        _sealed = [QTSealed fromJSONDictionary:(id)_sealed];
        if (!_sealed && dict[@"sealed"] && ![dict[@"sealed"] isKindOfClass:NSNull.class]) return nil;
        _sel = [QTSel fromJSONDictionary:(id)_sel];
        if (!_sel && dict[@"SEL"] && ![dict[@"SEL"] isKindOfClass:NSNull.class]) return nil;
        _select = [QTSelect fromJSONDictionary:(id)_select];
        if (!_select && dict[@"select"] && ![dict[@"select"] isKindOfClass:NSNull.class]) return nil;
        _self = [QTSelf fromJSONDictionary:(id)_self];
        if (!_self && dict[@"Self"] && ![dict[@"Self"] isKindOfClass:NSNull.class]) return nil;
        _sendable = [QTSendable fromJSONDictionary:(id)_sendable];
        if (!_sendable && dict[@"Sendable"] && ![dict[@"Sendable"] isKindOfClass:NSNull.class]) return nil;
        _serialDescriptor = [QTSerialDescriptor fromJSONDictionary:(id)_serialDescriptor];
        if (!_serialDescriptor && dict[@"SerialDescriptor"] && ![dict[@"SerialDescriptor"] isKindOfClass:NSNull.class]) return nil;
        _serialName = [QTSerialName fromJSONDictionary:(id)_serialName];
        if (!_serialName && dict[@"SerialName"] && ![dict[@"SerialName"] isKindOfClass:NSNull.class]) return nil;
        _serializable = [QTSerializable fromJSONDictionary:(id)_serializable];
        if (!_serializable && dict[@"Serializable"] && ![dict[@"Serializable"] isKindOfClass:NSNull.class]) return nil;
        _serializationFeature = [QTSerializationFeature fromJSONDictionary:(id)_serializationFeature];
        if (!_serializationFeature && dict[@"SerializationFeature"] && ![dict[@"SerializationFeature"] isKindOfClass:NSNull.class]) return nil;
        _serialize = [QTSerialize fromJSONDictionary:(id)_serialize];
        if (!_serialize && dict[@"serialize"] && ![dict[@"serialize"] isKindOfClass:NSNull.class]) return nil;
        _serializerProvider = [QTSerializerProvider fromJSONDictionary:(id)_serializerProvider];
        if (!_serializerProvider && dict[@"SerializerProvider"] && ![dict[@"SerializerProvider"] isKindOfClass:NSNull.class]) return nil;
        _set = [QTSet fromJSONDictionary:(id)_set];
        if (!_set && dict[@"set"] && ![dict[@"set"] isKindOfClass:NSNull.class]) return nil;
        _simpleModule = [QTSimpleModule fromJSONDictionary:(id)_simpleModule];
        if (!_simpleModule && dict[@"SimpleModule"] && ![dict[@"SimpleModule"] isKindOfClass:NSNull.class]) return nil;
        _stackalloc = [QTStackalloc fromJSONDictionary:(id)_stackalloc];
        if (!_stackalloc && dict[@"stackalloc"] && ![dict[@"stackalloc"] isKindOfClass:NSNull.class]) return nil;
        _standards = [QTStandards fromJSONDictionary:(id)_standards];
        if (!_standards && dict[@"Standards"] && ![dict[@"Standards"] isKindOfClass:NSNull.class]) return nil;
        _staticAssert = [QTStaticAssert fromJSONDictionary:(id)_staticAssert];
        if (!_staticAssert && dict[@"static_assert"] && ![dict[@"static_assert"] isKindOfClass:NSNull.class]) return nil;
        _staticCast = [QTStaticCast fromJSONDictionary:(id)_staticCast];
        if (!_staticCast && dict[@"static_cast"] && ![dict[@"static_cast"] isKindOfClass:NSNull.class]) return nil;
        _stdDeserializer = [QTStdDeserializer fromJSONDictionary:(id)_stdDeserializer];
        if (!_stdDeserializer && dict[@"StdDeserializer"] && ![dict[@"StdDeserializer"] isKindOfClass:NSNull.class]) return nil;
        _stdSerializer = [QTStdSerializer fromJSONDictionary:(id)_stdSerializer];
        if (!_stdSerializer && dict[@"StdSerializer"] && ![dict[@"StdSerializer"] isKindOfClass:NSNull.class]) return nil;
        _strictfp = [QTStrictfp fromJSONDictionary:(id)_strictfp];
        if (!_strictfp && dict[@"strictfp"] && ![dict[@"strictfp"] isKindOfClass:NSNull.class]) return nil;
        _string = [QTString fromJSONDictionary:(id)_string];
        if (!_string && dict[@"string"] && ![dict[@"string"] isKindOfClass:NSNull.class]) return nil;
        _subscript = [QTSubscript fromJSONDictionary:(id)_subscript];
        if (!_subscript && dict[@"subscript"] && ![dict[@"subscript"] isKindOfClass:NSNull.class]) return nil;
        _super = [QTSuper fromJSONDictionary:(id)_super];
        if (!_super && dict[@"super"] && ![dict[@"super"] isKindOfClass:NSNull.class]) return nil;
        _symbol = [QTSymbol fromJSONDictionary:(id)_symbol];
        if (!_symbol && dict[@"symbol"] && ![dict[@"symbol"] isKindOfClass:NSNull.class]) return nil;
        _synchronized = [QTSynchronized fromJSONDictionary:(id)_synchronized];
        if (!_synchronized && dict[@"synchronized"] && ![dict[@"synchronized"] isKindOfClass:NSNull.class]) return nil;
        _system = [QTSystem fromJSONDictionary:(id)_system];
        if (!_system && dict[@"system"] && ![dict[@"system"] isKindOfClass:NSNull.class]) return nil;
        _template = [QTTemplate fromJSONDictionary:(id)_template];
        if (!_template && dict[@"template"] && ![dict[@"template"] isKindOfClass:NSNull.class]) return nil;
        _textNode = [QTTextNode fromJSONDictionary:(id)_textNode];
        if (!_textNode && dict[@"TextNode"] && ![dict[@"TextNode"] isKindOfClass:NSNull.class]) return nil;
        _theTrue = [QTTrueClass fromJSONDictionary:(id)_theTrue];
        if (!_theTrue && dict[@"true"] && ![dict[@"true"] isKindOfClass:NSNull.class]) return nil;
        _then = [QTThen fromJSONDictionary:(id)_then];
        if (!_then && dict[@"then"] && ![dict[@"then"] isKindOfClass:NSNull.class]) return nil;
        _this = [QTThis fromJSONDictionary:(id)_this];
        if (!_this && dict[@"this"] && ![dict[@"this"] isKindOfClass:NSNull.class]) return nil;
        _threadLocal = [QTThreadLocal fromJSONDictionary:(id)_threadLocal];
        if (!_threadLocal && dict[@"thread_local"] && ![dict[@"thread_local"] isKindOfClass:NSNull.class]) return nil;
        _throw = [QTThrow fromJSONDictionary:(id)_throw];
        if (!_throw && dict[@"throw"] && ![dict[@"throw"] isKindOfClass:NSNull.class]) return nil;
        _throws = [QTThrows fromJSONDictionary:(id)_throws];
        if (!_throws && dict[@"throws"] && ![dict[@"throws"] isKindOfClass:NSNull.class]) return nil;
        _timeOnly = [QTTimeOnly fromJSONDictionary:(id)_timeOnly];
        if (!_timeOnly && dict[@"TimeOnly"] && ![dict[@"TimeOnly"] isKindOfClass:NSNull.class]) return nil;
        _timeOnlyConverter = [QTTimeOnlyConverter fromJSONDictionary:(id)_timeOnlyConverter];
        if (!_timeOnlyConverter && dict[@"TimeOnlyConverter"] && ![dict[@"TimeOnlyConverter"] isKindOfClass:NSNull.class]) return nil;
        _timeZone = [QTTimeZone fromJSONDictionary:(id)_timeZone];
        if (!_timeZone && dict[@"TimeZone"] && ![dict[@"TimeZone"] isKindOfClass:NSNull.class]) return nil;
        _toDict = [QTToDict fromJSONDictionary:(id)_toDict];
        if (!_toDict && dict[@"to_dict"] && ![dict[@"to_dict"] isKindOfClass:NSNull.class]) return nil;
        _toJSON = [QTToJSON fromJSONDictionary:(id)_toJSON];
        if (!_toJSON && dict[@"to_json"] && ![dict[@"to_json"] isKindOfClass:NSNull.class]) return nil;
        _toString = [QTToString fromJSONDictionary:(id)_toString];
        if (!_toString && dict[@"toString"] && ![dict[@"toString"] isKindOfClass:NSNull.class]) return nil;
        _topLevel = [QTTopLevelClass fromJSONDictionary:(id)_topLevel];
        if (!_topLevel && dict[@"top_level"] && ![dict[@"top_level"] isKindOfClass:NSNull.class]) return nil;
        _transient = [QTTransient fromJSONDictionary:(id)_transient];
        if (!_transient && dict[@"transient"] && ![dict[@"transient"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObj5.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObj5.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObj5.properties.allValues] mutableCopy];

    for (id jsonName in QTObj5.properties) {
        id propertyName = QTObj5.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"KSerializer": [_kSerializer JSONDictionary],
        @"restrict": [_obj5Restrict JSONDictionary],
        @"retain": [_obj5Retain JSONDictionary],
        @"return": [_obj5Return JSONDictionary],
        @"self": [_obj5Self JSONDictionary],
        @"short": [_obj5Short JSONDictionary],
        @"signed": [_obj5Signed JSONDictionary],
        @"sizeof": [_obj5Sizeof JSONDictionary],
        @"static": [_obj5Static JSONDictionary],
        @"struct": [_obj5Struct JSONDictionary],
        @"switch": [_obj5Switch JSONDictionary],
        @"True": [_obj5True JSONDictionary],
        @"PrimitiveKind": [_primitiveKind JSONDictionary],
        @"repeat": [_repeat JSONDictionary],
        @"require": [_require JSONDictionary],
        @"required": [_required JSONDictionary],
        @"requires": [_requires JSONDictionary],
        @"rethrows": [_rethrows JSONDictionary],
        @"right": [_right JSONDictionary],
        @"runtimeType": [_runtimeType JSONDictionary],
        @"s": [_s JSONDictionary],
        @"sbyte": [_sbyte JSONDictionary],
        @"sealed": [_sealed JSONDictionary],
        @"SEL": [_sel JSONDictionary],
        @"select": [_select JSONDictionary],
        @"Self": [_self JSONDictionary],
        @"Sendable": [_sendable JSONDictionary],
        @"SerialDescriptor": [_serialDescriptor JSONDictionary],
        @"SerialName": [_serialName JSONDictionary],
        @"Serializable": [_serializable JSONDictionary],
        @"SerializationFeature": [_serializationFeature JSONDictionary],
        @"serialize": [_serialize JSONDictionary],
        @"SerializerProvider": [_serializerProvider JSONDictionary],
        @"set": [_set JSONDictionary],
        @"SimpleModule": [_simpleModule JSONDictionary],
        @"stackalloc": [_stackalloc JSONDictionary],
        @"Standards": [_standards JSONDictionary],
        @"static_assert": [_staticAssert JSONDictionary],
        @"static_cast": [_staticCast JSONDictionary],
        @"StdDeserializer": [_stdDeserializer JSONDictionary],
        @"StdSerializer": [_stdSerializer JSONDictionary],
        @"strictfp": [_strictfp JSONDictionary],
        @"string": [_string JSONDictionary],
        @"subscript": [_subscript JSONDictionary],
        @"super": [_super JSONDictionary],
        @"symbol": [_symbol JSONDictionary],
        @"synchronized": [_synchronized JSONDictionary],
        @"system": [_system JSONDictionary],
        @"template": [_template JSONDictionary],
        @"TextNode": [_textNode JSONDictionary],
        @"true": [_theTrue JSONDictionary],
        @"then": [_then JSONDictionary],
        @"this": [_this JSONDictionary],
        @"thread_local": [_threadLocal JSONDictionary],
        @"throw": [_throw JSONDictionary],
        @"throws": [_throws JSONDictionary],
        @"TimeOnly": [_timeOnly JSONDictionary],
        @"TimeOnlyConverter": [_timeOnlyConverter JSONDictionary],
        @"TimeZone": [_timeZone JSONDictionary],
        @"to_dict": [_toDict JSONDictionary],
        @"to_json": [_toJSON JSONDictionary],
        @"toString": [_toString JSONDictionary],
        @"top_level": [_topLevel JSONDictionary],
        @"transient": [_transient JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTKSerializer
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"KSerializer": @"kSerializer",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTKSerializer alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"KSerializer"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"KSerializer"] doubleValue] != [dict[@"KSerializer"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTKSerializer.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTKSerializer.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTKSerializer.properties.allValues] mutableCopy];

    for (id jsonName in QTKSerializer.properties) {
        id propertyName = QTKSerializer.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTRestrict
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"restrict": @"restrictRestrict",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRestrict alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"restrict"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"restrict"] doubleValue] != [dict[@"restrict"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRestrict.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRestrict.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRestrict.properties.allValues] mutableCopy];

    for (id jsonName in QTRestrict.properties) {
        id propertyName = QTRestrict.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTRetain
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"retain": @"retainRetain",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRetain alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"retain"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"retain"] doubleValue] != [dict[@"retain"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRetain.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRetain.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTRetain.properties.allValues] mutableCopy];

    for (id jsonName in QTRetain.properties) {
        id propertyName = QTRetain.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTReturn
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"return": @"returnReturn",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTReturn alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"return"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"return"] doubleValue] != [dict[@"return"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTReturn.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTReturn.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTReturn.properties.allValues] mutableCopy];

    for (id jsonName in QTReturn.properties) {
        id propertyName = QTReturn.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSelfClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"self": @"self",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSelfClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"self"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"self"] doubleValue] != [dict[@"self"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSelfClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSelfClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSelfClass.properties.allValues];
}
@end

@implementation QTShort
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"short": @"shortShort",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTShort alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"short"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"short"] doubleValue] != [dict[@"short"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTShort.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTShort.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTShort.properties.allValues] mutableCopy];

    for (id jsonName in QTShort.properties) {
        id propertyName = QTShort.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSigned
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"signed": @"signedSigned",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSigned alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"signed"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"signed"] doubleValue] != [dict[@"signed"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSigned.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSigned.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSigned.properties.allValues] mutableCopy];

    for (id jsonName in QTSigned.properties) {
        id propertyName = QTSigned.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSizeof
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"sizeof": @"sizeofSizeof",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSizeof alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"sizeof"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sizeof"] doubleValue] != [dict[@"sizeof"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSizeof.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSizeof.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSizeof.properties.allValues] mutableCopy];

    for (id jsonName in QTSizeof.properties) {
        id propertyName = QTSizeof.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStatic
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"static": @"staticStatic",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStatic alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"static"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"static"] doubleValue] != [dict[@"static"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStatic.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStatic.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStatic.properties.allValues] mutableCopy];

    for (id jsonName in QTStatic.properties) {
        id propertyName = QTStatic.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStruct
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"struct": @"structStruct",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStruct alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"struct"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"struct"] doubleValue] != [dict[@"struct"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStruct.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStruct.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStruct.properties.allValues] mutableCopy];

    for (id jsonName in QTStruct.properties) {
        id propertyName = QTStruct.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSwitch
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"switch": @"switchSwitch",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSwitch alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"switch"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"switch"] doubleValue] != [dict[@"switch"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSwitch.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSwitch.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSwitch.properties.allValues] mutableCopy];

    for (id jsonName in QTSwitch.properties) {
        id propertyName = QTSwitch.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTrue
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"True": @"trueTrue",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTrue alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"True"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"True"] doubleValue] != [dict[@"True"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTrue.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTrue.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTrue.properties.allValues] mutableCopy];

    for (id jsonName in QTTrue.properties) {
        id propertyName = QTTrue.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTPrimitiveKind
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"PrimitiveKind": @"primitiveKind",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTPrimitiveKind alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"PrimitiveKind"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"PrimitiveKind"] doubleValue] != [dict[@"PrimitiveKind"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTPrimitiveKind.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTPrimitiveKind.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTPrimitiveKind.properties.allValues] mutableCopy];

    for (id jsonName in QTPrimitiveKind.properties) {
        id propertyName = QTPrimitiveKind.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTRepeat
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"repeat": @"repeat",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRepeat alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"repeat"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"repeat"] doubleValue] != [dict[@"repeat"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRepeat.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRepeat.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRepeat.properties.allValues];
}
@end

@implementation QTRequire
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"require": @"require",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRequire alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"require"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"require"] doubleValue] != [dict[@"require"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRequire.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRequire.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRequire.properties.allValues];
}
@end

@implementation QTRequired
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"required": @"required",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRequired alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"required"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"required"] doubleValue] != [dict[@"required"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRequired.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRequired.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRequired.properties.allValues];
}
@end

@implementation QTRequires
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"requires": @"requires",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRequires alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"requires"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"requires"] doubleValue] != [dict[@"requires"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRequires.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRequires.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRequires.properties.allValues];
}
@end

@implementation QTRethrows
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"rethrows": @"rethrows",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRethrows alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"rethrows"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"rethrows"] doubleValue] != [dict[@"rethrows"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRethrows.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRethrows.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRethrows.properties.allValues];
}
@end

@implementation QTRight
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"right": @"right",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRight alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"right"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"right"] doubleValue] != [dict[@"right"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRight.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRight.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRight.properties.allValues];
}
@end

@implementation QTRuntimeType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"runtimeType": @"runtimeType",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTRuntimeType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"runtimeType"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"runtimeType"] doubleValue] != [dict[@"runtimeType"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTRuntimeType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTRuntimeType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTRuntimeType.properties.allValues];
}
@end

@implementation QTS
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"s": @"s",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTS alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"s"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"s"] doubleValue] != [dict[@"s"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTS.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTS.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTS.properties.allValues];
}
@end

@implementation QTSbyte
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"sbyte": @"sbyte",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSbyte alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"sbyte"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sbyte"] doubleValue] != [dict[@"sbyte"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSbyte.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSbyte.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSbyte.properties.allValues];
}
@end

@implementation QTSealed
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"sealed": @"sealed",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSealed alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"sealed"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"sealed"] doubleValue] != [dict[@"sealed"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSealed.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSealed.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSealed.properties.allValues];
}
@end

@implementation QTSel
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"SEL": @"sel",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSel alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"SEL"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SEL"] doubleValue] != [dict[@"SEL"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSel.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSel.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSel.properties.allValues] mutableCopy];

    for (id jsonName in QTSel.properties) {
        id propertyName = QTSel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSelect
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"select": @"select",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSelect alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"select"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"select"] doubleValue] != [dict[@"select"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSelect.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSelect.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSelect.properties.allValues];
}
@end

@implementation QTSelf
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Self": @"self",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSelf alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Self"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Self"] doubleValue] != [dict[@"Self"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSelf.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSelf.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSelf.properties.allValues] mutableCopy];

    for (id jsonName in QTSelf.properties) {
        id propertyName = QTSelf.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSendable
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Sendable": @"sendable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSendable alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Sendable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Sendable"] doubleValue] != [dict[@"Sendable"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSendable.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSendable.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSendable.properties.allValues] mutableCopy];

    for (id jsonName in QTSendable.properties) {
        id propertyName = QTSendable.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSerialDescriptor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"SerialDescriptor": @"serialDescriptor",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSerialDescriptor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"SerialDescriptor"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SerialDescriptor"] doubleValue] != [dict[@"SerialDescriptor"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSerialDescriptor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSerialDescriptor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSerialDescriptor.properties.allValues] mutableCopy];

    for (id jsonName in QTSerialDescriptor.properties) {
        id propertyName = QTSerialDescriptor.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSerialName
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"SerialName": @"serialName",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSerialName alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"SerialName"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SerialName"] doubleValue] != [dict[@"SerialName"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSerialName.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSerialName.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSerialName.properties.allValues] mutableCopy];

    for (id jsonName in QTSerialName.properties) {
        id propertyName = QTSerialName.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSerializable
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Serializable": @"serializable",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSerializable alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Serializable"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Serializable"] doubleValue] != [dict[@"Serializable"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSerializable.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSerializable.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSerializable.properties.allValues] mutableCopy];

    for (id jsonName in QTSerializable.properties) {
        id propertyName = QTSerializable.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSerializationFeature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"SerializationFeature": @"serializationFeature",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSerializationFeature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"SerializationFeature"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SerializationFeature"] doubleValue] != [dict[@"SerializationFeature"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSerializationFeature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSerializationFeature.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSerializationFeature.properties.allValues] mutableCopy];

    for (id jsonName in QTSerializationFeature.properties) {
        id propertyName = QTSerializationFeature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSerialize
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"serialize": @"serialize",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSerialize alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"serialize"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"serialize"] doubleValue] != [dict[@"serialize"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSerialize.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSerialize.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSerialize.properties.allValues];
}
@end

@implementation QTSerializerProvider
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"SerializerProvider": @"serializerProvider",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSerializerProvider alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"SerializerProvider"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SerializerProvider"] doubleValue] != [dict[@"SerializerProvider"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSerializerProvider.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSerializerProvider.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSerializerProvider.properties.allValues] mutableCopy];

    for (id jsonName in QTSerializerProvider.properties) {
        id propertyName = QTSerializerProvider.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTSet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"set": @"set",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"set"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"set"] doubleValue] != [dict[@"set"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSet.properties.allValues];
}
@end

@implementation QTSimpleModule
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"SimpleModule": @"simpleModule",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSimpleModule alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"SimpleModule"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"SimpleModule"] doubleValue] != [dict[@"SimpleModule"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSimpleModule.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSimpleModule.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTSimpleModule.properties.allValues] mutableCopy];

    for (id jsonName in QTSimpleModule.properties) {
        id propertyName = QTSimpleModule.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStackalloc
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"stackalloc": @"stackalloc",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStackalloc alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"stackalloc"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"stackalloc"] doubleValue] != [dict[@"stackalloc"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStackalloc.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStackalloc.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTStackalloc.properties.allValues];
}
@end

@implementation QTStandards
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Standards": @"standards",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStandards alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Standards"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Standards"] doubleValue] != [dict[@"Standards"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStandards.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStandards.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStandards.properties.allValues] mutableCopy];

    for (id jsonName in QTStandards.properties) {
        id propertyName = QTStandards.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStaticAssert
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"static_assert": @"staticAssert",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStaticAssert alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"static_assert"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"static_assert"] doubleValue] != [dict[@"static_assert"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStaticAssert.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStaticAssert.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStaticAssert.properties.allValues] mutableCopy];

    for (id jsonName in QTStaticAssert.properties) {
        id propertyName = QTStaticAssert.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStaticCast
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"static_cast": @"staticCast",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStaticCast alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"static_cast"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"static_cast"] doubleValue] != [dict[@"static_cast"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStaticCast.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStaticCast.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStaticCast.properties.allValues] mutableCopy];

    for (id jsonName in QTStaticCast.properties) {
        id propertyName = QTStaticCast.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStdDeserializer
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"StdDeserializer": @"stdDeserializer",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStdDeserializer alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"StdDeserializer"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"StdDeserializer"] doubleValue] != [dict[@"StdDeserializer"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStdDeserializer.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStdDeserializer.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStdDeserializer.properties.allValues] mutableCopy];

    for (id jsonName in QTStdDeserializer.properties) {
        id propertyName = QTStdDeserializer.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStdSerializer
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"StdSerializer": @"stdSerializer",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStdSerializer alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"StdSerializer"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"StdSerializer"] doubleValue] != [dict[@"StdSerializer"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStdSerializer.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStdSerializer.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTStdSerializer.properties.allValues] mutableCopy];

    for (id jsonName in QTStdSerializer.properties) {
        id propertyName = QTStdSerializer.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTStrictfp
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"strictfp": @"strictfp",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTStrictfp alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"strictfp"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"strictfp"] doubleValue] != [dict[@"strictfp"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTStrictfp.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTStrictfp.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTStrictfp.properties.allValues];
}
@end

@implementation QTString
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"string": @"string",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTString alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"string"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"string"] doubleValue] != [dict[@"string"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTString.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTString.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTString.properties.allValues];
}
@end

@implementation QTSubscript
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"subscript": @"subscript",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSubscript alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"subscript"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"subscript"] doubleValue] != [dict[@"subscript"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSubscript.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSubscript.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSubscript.properties.allValues];
}
@end

@implementation QTSuper
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"super": @"super",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSuper alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"super"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"super"] doubleValue] != [dict[@"super"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSuper.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSuper.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSuper.properties.allValues];
}
@end

@implementation QTSymbol
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"symbol": @"symbol",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSymbol alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"symbol"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"symbol"] doubleValue] != [dict[@"symbol"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSymbol.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSymbol.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSymbol.properties.allValues];
}
@end

@implementation QTSynchronized
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"synchronized": @"synchronized",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSynchronized alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"synchronized"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"synchronized"] doubleValue] != [dict[@"synchronized"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSynchronized.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSynchronized.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSynchronized.properties.allValues];
}
@end

@implementation QTSystem
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"system": @"system",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTSystem alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"system"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"system"] doubleValue] != [dict[@"system"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTSystem.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTSystem.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTSystem.properties.allValues];
}
@end

@implementation QTTemplate
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"template": @"template",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTemplate alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"template"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"template"] doubleValue] != [dict[@"template"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTemplate.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTemplate.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTemplate.properties.allValues];
}
@end

@implementation QTTextNode
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"TextNode": @"textNode",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTextNode alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"TextNode"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"TextNode"] doubleValue] != [dict[@"TextNode"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTextNode.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTextNode.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTextNode.properties.allValues] mutableCopy];

    for (id jsonName in QTTextNode.properties) {
        id propertyName = QTTextNode.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTrueClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"true": @"trueTrue",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTrueClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"true"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"true"] doubleValue] != [dict[@"true"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTrueClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTrueClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTrueClass.properties.allValues] mutableCopy];

    for (id jsonName in QTTrueClass.properties) {
        id propertyName = QTTrueClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTThen
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"then": @"then",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTThen alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"then"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"then"] doubleValue] != [dict[@"then"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTThen.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTThen.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTThen.properties.allValues];
}
@end

@implementation QTThis
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"this": @"this",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTThis alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"this"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"this"] doubleValue] != [dict[@"this"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTThis.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTThis.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTThis.properties.allValues];
}
@end

@implementation QTThreadLocal
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"thread_local": @"threadLocal",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTThreadLocal alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"thread_local"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"thread_local"] doubleValue] != [dict[@"thread_local"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTThreadLocal.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTThreadLocal.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTThreadLocal.properties.allValues] mutableCopy];

    for (id jsonName in QTThreadLocal.properties) {
        id propertyName = QTThreadLocal.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTThrow
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"throw": @"throw",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTThrow alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"throw"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"throw"] doubleValue] != [dict[@"throw"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTThrow.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTThrow.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTThrow.properties.allValues];
}
@end

@implementation QTThrows
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"throws": @"throws",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTThrows alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"throws"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"throws"] doubleValue] != [dict[@"throws"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTThrows.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTThrows.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTThrows.properties.allValues];
}
@end

@implementation QTTimeOnly
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"TimeOnly": @"timeOnly",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTimeOnly alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"TimeOnly"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"TimeOnly"] doubleValue] != [dict[@"TimeOnly"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTimeOnly.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTimeOnly.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTimeOnly.properties.allValues] mutableCopy];

    for (id jsonName in QTTimeOnly.properties) {
        id propertyName = QTTimeOnly.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTimeOnlyConverter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"TimeOnlyConverter": @"timeOnlyConverter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTimeOnlyConverter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"TimeOnlyConverter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"TimeOnlyConverter"] doubleValue] != [dict[@"TimeOnlyConverter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTimeOnlyConverter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTimeOnlyConverter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTimeOnlyConverter.properties.allValues] mutableCopy];

    for (id jsonName in QTTimeOnlyConverter.properties) {
        id propertyName = QTTimeOnlyConverter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTimeZone
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"TimeZone": @"timeZone",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTimeZone alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"TimeZone"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"TimeZone"] doubleValue] != [dict[@"TimeZone"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTimeZone.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTimeZone.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTimeZone.properties.allValues] mutableCopy];

    for (id jsonName in QTTimeZone.properties) {
        id propertyName = QTTimeZone.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTToDict
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"to_dict": @"toDict",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTToDict alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"to_dict"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"to_dict"] doubleValue] != [dict[@"to_dict"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTToDict.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTToDict.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTToDict.properties.allValues] mutableCopy];

    for (id jsonName in QTToDict.properties) {
        id propertyName = QTToDict.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTToJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"to_json": @"toJSON",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTToJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"to_json"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"to_json"] doubleValue] != [dict[@"to_json"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTToJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTToJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTToJSON.properties.allValues] mutableCopy];

    for (id jsonName in QTToJSON.properties) {
        id propertyName = QTToJSON.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTToString
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"toString": @"toString",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTToString alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"toString"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"toString"] doubleValue] != [dict[@"toString"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTToString.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTToString.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTToString.properties.allValues];
}
@end

@implementation QTTopLevelClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"top_level": @"topLevel",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTopLevelClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"top_level"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"top_level"] doubleValue] != [dict[@"top_level"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTopLevelClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTopLevelClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTopLevelClass.properties.allValues] mutableCopy];

    for (id jsonName in QTTopLevelClass.properties) {
        id propertyName = QTTopLevelClass.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTransient
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"transient": @"transient",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTransient alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"transient"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"transient"] doubleValue] != [dict[@"transient"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTransient.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTransient.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTransient.properties.allValues];
}
@end

@implementation QTObj6
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"dummy": @"dummy",
        @"type": @"obj6Type",
        @"typedef": @"obj6Typedef",
        @"typeof": @"obj6Typeof",
        @"union": @"obj6Union",
        @"unsigned": @"obj6Unsigned",
        @"void": @"obj6Void",
        @"volatile": @"obj6Volatile",
        @"while": @"obj6While",
        @"try": @"try",
        @"Type": @"type",
        @"typealias": @"typealias",
        @"typeid": @"typeid",
        @"typename": @"typename",
        @"uint": @"uint",
        @"ulong": @"ulong",
        @"unchecked": @"unchecked",
        @"undefined": @"undefined",
        @"UnmarshalJSON": @"unmarshalJSON",
        @"unowned": @"unowned",
        @"unsafe": @"unsafe",
        @"UseSerializers": @"useSerializers",
        @"ushort": @"ushort",
        @"using": @"using",
        @"Utf8JsonReader": @"utf8JSONReader",
        @"Utf8JsonWriter": @"utf8JSONWriter",
        @"UUID": @"uuid",
        @"var": @"var",
        @"virtual": @"virtual",
        @"wchar_t": @"wcharT",
        @"weak": @"weak",
        @"where": @"where",
        @"willSet": @"willSet",
        @"with": @"with",
        @"xor": @"xor",
        @"xor_eq": @"xorEq",
        @"YES": @"yes",
        @"yield": @"yield",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTObj6 alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"dummy"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"dummy"] doubleValue] != [dict[@"dummy"] longLongValue]) return nil;
        if (![dict[@"type"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"typedef"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"typeof"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"union"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"unsigned"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"void"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"volatile"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"while"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"try"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Type"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"typealias"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"typeid"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"typename"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"uint"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ulong"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"unchecked"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"undefined"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"UnmarshalJSON"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"unowned"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"unsafe"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"UseSerializers"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"ushort"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"using"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Utf8JsonReader"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"Utf8JsonWriter"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"UUID"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"var"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"virtual"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"wchar_t"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"weak"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"where"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"willSet"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"with"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"xor"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"xor_eq"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"YES"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"yield"] isKindOfClass:NSDictionary.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _obj6Type = [QTTypeClass fromJSONDictionary:(id)_obj6Type];
        if (!_obj6Type && dict[@"type"] && ![dict[@"type"] isKindOfClass:NSNull.class]) return nil;
        _obj6Typedef = [QTTypedef fromJSONDictionary:(id)_obj6Typedef];
        if (!_obj6Typedef && dict[@"typedef"] && ![dict[@"typedef"] isKindOfClass:NSNull.class]) return nil;
        _obj6Typeof = [QTTypeof fromJSONDictionary:(id)_obj6Typeof];
        if (!_obj6Typeof && dict[@"typeof"] && ![dict[@"typeof"] isKindOfClass:NSNull.class]) return nil;
        _obj6Union = [QTUnion fromJSONDictionary:(id)_obj6Union];
        if (!_obj6Union && dict[@"union"] && ![dict[@"union"] isKindOfClass:NSNull.class]) return nil;
        _obj6Unsigned = [QTUnsigned fromJSONDictionary:(id)_obj6Unsigned];
        if (!_obj6Unsigned && dict[@"unsigned"] && ![dict[@"unsigned"] isKindOfClass:NSNull.class]) return nil;
        _obj6Void = [QTVoid fromJSONDictionary:(id)_obj6Void];
        if (!_obj6Void && dict[@"void"] && ![dict[@"void"] isKindOfClass:NSNull.class]) return nil;
        _obj6Volatile = [QTVolatile fromJSONDictionary:(id)_obj6Volatile];
        if (!_obj6Volatile && dict[@"volatile"] && ![dict[@"volatile"] isKindOfClass:NSNull.class]) return nil;
        _obj6While = [QTWhile fromJSONDictionary:(id)_obj6While];
        if (!_obj6While && dict[@"while"] && ![dict[@"while"] isKindOfClass:NSNull.class]) return nil;
        _try = [QTTry fromJSONDictionary:(id)_try];
        if (!_try && dict[@"try"] && ![dict[@"try"] isKindOfClass:NSNull.class]) return nil;
        _type = [QTType fromJSONDictionary:(id)_type];
        if (!_type && dict[@"Type"] && ![dict[@"Type"] isKindOfClass:NSNull.class]) return nil;
        _typealias = [QTTypealias fromJSONDictionary:(id)_typealias];
        if (!_typealias && dict[@"typealias"] && ![dict[@"typealias"] isKindOfClass:NSNull.class]) return nil;
        _typeid = [QTTypeid fromJSONDictionary:(id)_typeid];
        if (!_typeid && dict[@"typeid"] && ![dict[@"typeid"] isKindOfClass:NSNull.class]) return nil;
        _typename = [QTTypename fromJSONDictionary:(id)_typename];
        if (!_typename && dict[@"typename"] && ![dict[@"typename"] isKindOfClass:NSNull.class]) return nil;
        _uint = [QTUint fromJSONDictionary:(id)_uint];
        if (!_uint && dict[@"uint"] && ![dict[@"uint"] isKindOfClass:NSNull.class]) return nil;
        _ulong = [QTUlong fromJSONDictionary:(id)_ulong];
        if (!_ulong && dict[@"ulong"] && ![dict[@"ulong"] isKindOfClass:NSNull.class]) return nil;
        _unchecked = [QTUnchecked fromJSONDictionary:(id)_unchecked];
        if (!_unchecked && dict[@"unchecked"] && ![dict[@"unchecked"] isKindOfClass:NSNull.class]) return nil;
        _undefined = [QTUndefined fromJSONDictionary:(id)_undefined];
        if (!_undefined && dict[@"undefined"] && ![dict[@"undefined"] isKindOfClass:NSNull.class]) return nil;
        _unmarshalJSON = [QTUnmarshalJSON fromJSONDictionary:(id)_unmarshalJSON];
        if (!_unmarshalJSON && dict[@"UnmarshalJSON"] && ![dict[@"UnmarshalJSON"] isKindOfClass:NSNull.class]) return nil;
        _unowned = [QTUnowned fromJSONDictionary:(id)_unowned];
        if (!_unowned && dict[@"unowned"] && ![dict[@"unowned"] isKindOfClass:NSNull.class]) return nil;
        _unsafe = [QTUnsafe fromJSONDictionary:(id)_unsafe];
        if (!_unsafe && dict[@"unsafe"] && ![dict[@"unsafe"] isKindOfClass:NSNull.class]) return nil;
        _useSerializers = [QTUseSerializers fromJSONDictionary:(id)_useSerializers];
        if (!_useSerializers && dict[@"UseSerializers"] && ![dict[@"UseSerializers"] isKindOfClass:NSNull.class]) return nil;
        _ushort = [QTUshort fromJSONDictionary:(id)_ushort];
        if (!_ushort && dict[@"ushort"] && ![dict[@"ushort"] isKindOfClass:NSNull.class]) return nil;
        _using = [QTUsing fromJSONDictionary:(id)_using];
        if (!_using && dict[@"using"] && ![dict[@"using"] isKindOfClass:NSNull.class]) return nil;
        _utf8JSONReader = [QTUtf8JSONReader fromJSONDictionary:(id)_utf8JSONReader];
        if (!_utf8JSONReader && dict[@"Utf8JsonReader"] && ![dict[@"Utf8JsonReader"] isKindOfClass:NSNull.class]) return nil;
        _utf8JSONWriter = [QTUtf8JSONWriter fromJSONDictionary:(id)_utf8JSONWriter];
        if (!_utf8JSONWriter && dict[@"Utf8JsonWriter"] && ![dict[@"Utf8JsonWriter"] isKindOfClass:NSNull.class]) return nil;
        _uuid = [QTUUID fromJSONDictionary:(id)_uuid];
        if (!_uuid && dict[@"UUID"] && ![dict[@"UUID"] isKindOfClass:NSNull.class]) return nil;
        _var = [QTVar fromJSONDictionary:(id)_var];
        if (!_var && dict[@"var"] && ![dict[@"var"] isKindOfClass:NSNull.class]) return nil;
        _virtual = [QTVirtual fromJSONDictionary:(id)_virtual];
        if (!_virtual && dict[@"virtual"] && ![dict[@"virtual"] isKindOfClass:NSNull.class]) return nil;
        _wcharT = [QTWcharT fromJSONDictionary:(id)_wcharT];
        if (!_wcharT && dict[@"wchar_t"] && ![dict[@"wchar_t"] isKindOfClass:NSNull.class]) return nil;
        _weak = [QTWeak fromJSONDictionary:(id)_weak];
        if (!_weak && dict[@"weak"] && ![dict[@"weak"] isKindOfClass:NSNull.class]) return nil;
        _where = [QTWhere fromJSONDictionary:(id)_where];
        if (!_where && dict[@"where"] && ![dict[@"where"] isKindOfClass:NSNull.class]) return nil;
        _willSet = [QTWillSet fromJSONDictionary:(id)_willSet];
        if (!_willSet && dict[@"willSet"] && ![dict[@"willSet"] isKindOfClass:NSNull.class]) return nil;
        _with = [QTWith fromJSONDictionary:(id)_with];
        if (!_with && dict[@"with"] && ![dict[@"with"] isKindOfClass:NSNull.class]) return nil;
        _xor = [QTXor fromJSONDictionary:(id)_xor];
        if (!_xor && dict[@"xor"] && ![dict[@"xor"] isKindOfClass:NSNull.class]) return nil;
        _xorEq = [QTXorEq fromJSONDictionary:(id)_xorEq];
        if (!_xorEq && dict[@"xor_eq"] && ![dict[@"xor_eq"] isKindOfClass:NSNull.class]) return nil;
        _yes = [QTYes fromJSONDictionary:(id)_yes];
        if (!_yes && dict[@"YES"] && ![dict[@"YES"] isKindOfClass:NSNull.class]) return nil;
        _yield = [QTYield fromJSONDictionary:(id)_yield];
        if (!_yield && dict[@"yield"] && ![dict[@"yield"] isKindOfClass:NSNull.class]) return nil;
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTObj6.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTObj6.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTObj6.properties.allValues] mutableCopy];

    for (id jsonName in QTObj6.properties) {
        id propertyName = QTObj6.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"type": [_obj6Type JSONDictionary],
        @"typedef": [_obj6Typedef JSONDictionary],
        @"typeof": [_obj6Typeof JSONDictionary],
        @"union": [_obj6Union JSONDictionary],
        @"unsigned": [_obj6Unsigned JSONDictionary],
        @"void": [_obj6Void JSONDictionary],
        @"volatile": [_obj6Volatile JSONDictionary],
        @"while": [_obj6While JSONDictionary],
        @"try": [_try JSONDictionary],
        @"Type": [_type JSONDictionary],
        @"typealias": [_typealias JSONDictionary],
        @"typeid": [_typeid JSONDictionary],
        @"typename": [_typename JSONDictionary],
        @"uint": [_uint JSONDictionary],
        @"ulong": [_ulong JSONDictionary],
        @"unchecked": [_unchecked JSONDictionary],
        @"undefined": [_undefined JSONDictionary],
        @"UnmarshalJSON": [_unmarshalJSON JSONDictionary],
        @"unowned": [_unowned JSONDictionary],
        @"unsafe": [_unsafe JSONDictionary],
        @"UseSerializers": [_useSerializers JSONDictionary],
        @"ushort": [_ushort JSONDictionary],
        @"using": [_using JSONDictionary],
        @"Utf8JsonReader": [_utf8JSONReader JSONDictionary],
        @"Utf8JsonWriter": [_utf8JSONWriter JSONDictionary],
        @"UUID": [_uuid JSONDictionary],
        @"var": [_var JSONDictionary],
        @"virtual": [_virtual JSONDictionary],
        @"wchar_t": [_wcharT JSONDictionary],
        @"weak": [_weak JSONDictionary],
        @"where": [_where JSONDictionary],
        @"willSet": [_willSet JSONDictionary],
        @"with": [_with JSONDictionary],
        @"xor": [_xor JSONDictionary],
        @"xor_eq": [_xorEq JSONDictionary],
        @"YES": [_yes JSONDictionary],
        @"yield": [_yield JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTTypeClass
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypeClass alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"type"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"type"] doubleValue] != [dict[@"type"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypeClass.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypeClass.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTypeClass.properties.allValues];
}
@end

@implementation QTTypedef
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"typedef": @"typedefTypedef",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypedef alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"typedef"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"typedef"] doubleValue] != [dict[@"typedef"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypedef.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypedef.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTypedef.properties.allValues] mutableCopy];

    for (id jsonName in QTTypedef.properties) {
        id propertyName = QTTypedef.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTypeof
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"typeof": @"typeofTypeof",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypeof alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"typeof"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"typeof"] doubleValue] != [dict[@"typeof"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypeof.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypeof.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTTypeof.properties.allValues] mutableCopy];

    for (id jsonName in QTTypeof.properties) {
        id propertyName = QTTypeof.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUnion
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"union": @"unionUnion",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnion alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"union"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"union"] doubleValue] != [dict[@"union"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUnion.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnion.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUnion.properties.allValues] mutableCopy];

    for (id jsonName in QTUnion.properties) {
        id propertyName = QTUnion.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUnsigned
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"unsigned": @"unsignedUnsigned",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnsigned alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"unsigned"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"unsigned"] doubleValue] != [dict[@"unsigned"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUnsigned.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnsigned.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUnsigned.properties.allValues] mutableCopy];

    for (id jsonName in QTUnsigned.properties) {
        id propertyName = QTUnsigned.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTVoid
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"void": @"voidVoid",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVoid alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"void"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"void"] doubleValue] != [dict[@"void"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVoid.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVoid.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVoid.properties.allValues] mutableCopy];

    for (id jsonName in QTVoid.properties) {
        id propertyName = QTVoid.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTVolatile
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"volatile": @"volatileVolatile",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVolatile alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"volatile"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"volatile"] doubleValue] != [dict[@"volatile"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVolatile.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVolatile.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTVolatile.properties.allValues] mutableCopy];

    for (id jsonName in QTVolatile.properties) {
        id propertyName = QTVolatile.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTWhile
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"while": @"whileWhile",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWhile alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"while"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"while"] doubleValue] != [dict[@"while"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWhile.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWhile.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTWhile.properties.allValues] mutableCopy];

    for (id jsonName in QTWhile.properties) {
        id propertyName = QTWhile.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"try": @"try",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"try"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"try"] doubleValue] != [dict[@"try"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTry.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTry.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTry.properties.allValues];
}
@end

@implementation QTType
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Type": @"type",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTType alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Type"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Type"] doubleValue] != [dict[@"Type"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTType.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTType.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTType.properties.allValues] mutableCopy];

    for (id jsonName in QTType.properties) {
        id propertyName = QTType.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTTypealias
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"typealias": @"typealias",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypealias alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"typealias"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"typealias"] doubleValue] != [dict[@"typealias"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypealias.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypealias.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTypealias.properties.allValues];
}
@end

@implementation QTTypeid
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"typeid": @"typeid",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypeid alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"typeid"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"typeid"] doubleValue] != [dict[@"typeid"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypeid.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypeid.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTypeid.properties.allValues];
}
@end

@implementation QTTypename
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"typename": @"typename",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTTypename alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"typename"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"typename"] doubleValue] != [dict[@"typename"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTTypename.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTTypename.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTTypename.properties.allValues];
}
@end

@implementation QTUint
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"uint": @"uint",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUint alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"uint"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"uint"] doubleValue] != [dict[@"uint"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUint.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUint.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUint.properties.allValues];
}
@end

@implementation QTUlong
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ulong": @"ulong",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUlong alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ulong"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ulong"] doubleValue] != [dict[@"ulong"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUlong.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUlong.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUlong.properties.allValues];
}
@end

@implementation QTUnchecked
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"unchecked": @"unchecked",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnchecked alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"unchecked"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"unchecked"] doubleValue] != [dict[@"unchecked"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUnchecked.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnchecked.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUnchecked.properties.allValues];
}
@end

@implementation QTUndefined
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"undefined": @"undefined",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUndefined alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"undefined"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"undefined"] doubleValue] != [dict[@"undefined"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUndefined.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUndefined.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUndefined.properties.allValues];
}
@end

@implementation QTUnmarshalJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"UnmarshalJSON": @"unmarshalJSON",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnmarshalJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"UnmarshalJSON"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"UnmarshalJSON"] doubleValue] != [dict[@"UnmarshalJSON"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUnmarshalJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnmarshalJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUnmarshalJSON.properties.allValues] mutableCopy];

    for (id jsonName in QTUnmarshalJSON.properties) {
        id propertyName = QTUnmarshalJSON.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUnowned
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"unowned": @"unowned",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnowned alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"unowned"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"unowned"] doubleValue] != [dict[@"unowned"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUnowned.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnowned.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUnowned.properties.allValues];
}
@end

@implementation QTUnsafe
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"unsafe": @"unsafe",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUnsafe alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"unsafe"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"unsafe"] doubleValue] != [dict[@"unsafe"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUnsafe.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUnsafe.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUnsafe.properties.allValues];
}
@end

@implementation QTUseSerializers
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"UseSerializers": @"useSerializers",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUseSerializers alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"UseSerializers"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"UseSerializers"] doubleValue] != [dict[@"UseSerializers"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUseSerializers.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUseSerializers.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUseSerializers.properties.allValues] mutableCopy];

    for (id jsonName in QTUseSerializers.properties) {
        id propertyName = QTUseSerializers.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUshort
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"ushort": @"ushort",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUshort alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"ushort"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"ushort"] doubleValue] != [dict[@"ushort"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUshort.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUshort.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUshort.properties.allValues];
}
@end

@implementation QTUsing
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"using": @"using",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUsing alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"using"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"using"] doubleValue] != [dict[@"using"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUsing.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUsing.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTUsing.properties.allValues];
}
@end

@implementation QTUtf8JSONReader
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Utf8JsonReader": @"utf8JSONReader",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUtf8JSONReader alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Utf8JsonReader"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Utf8JsonReader"] doubleValue] != [dict[@"Utf8JsonReader"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUtf8JSONReader.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUtf8JSONReader.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUtf8JSONReader.properties.allValues] mutableCopy];

    for (id jsonName in QTUtf8JSONReader.properties) {
        id propertyName = QTUtf8JSONReader.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUtf8JSONWriter
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"Utf8JsonWriter": @"utf8JSONWriter",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUtf8JSONWriter alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"Utf8JsonWriter"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"Utf8JsonWriter"] doubleValue] != [dict[@"Utf8JsonWriter"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUtf8JSONWriter.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUtf8JSONWriter.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUtf8JSONWriter.properties.allValues] mutableCopy];

    for (id jsonName in QTUtf8JSONWriter.properties) {
        id propertyName = QTUtf8JSONWriter.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTUUID
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"UUID": @"uuid",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTUUID alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"UUID"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"UUID"] doubleValue] != [dict[@"UUID"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTUUID.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTUUID.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTUUID.properties.allValues] mutableCopy];

    for (id jsonName in QTUUID.properties) {
        id propertyName = QTUUID.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTVar
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"var": @"var",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVar alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"var"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"var"] doubleValue] != [dict[@"var"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVar.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVar.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTVar.properties.allValues];
}
@end

@implementation QTVirtual
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"virtual": @"virtual",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTVirtual alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"virtual"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"virtual"] doubleValue] != [dict[@"virtual"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTVirtual.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTVirtual.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTVirtual.properties.allValues];
}
@end

@implementation QTWcharT
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"wchar_t": @"wcharT",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWcharT alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"wchar_t"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"wchar_t"] doubleValue] != [dict[@"wchar_t"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWcharT.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWcharT.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTWcharT.properties.allValues] mutableCopy];

    for (id jsonName in QTWcharT.properties) {
        id propertyName = QTWcharT.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTWeak
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"weak": @"weak",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWeak alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"weak"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"weak"] doubleValue] != [dict[@"weak"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWeak.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWeak.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTWeak.properties.allValues];
}
@end

@implementation QTWhere
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"where": @"where",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWhere alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"where"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"where"] doubleValue] != [dict[@"where"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWhere.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWhere.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTWhere.properties.allValues];
}
@end

@implementation QTWillSet
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"willSet": @"willSet",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWillSet alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"willSet"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"willSet"] doubleValue] != [dict[@"willSet"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWillSet.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWillSet.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTWillSet.properties.allValues];
}
@end

@implementation QTWith
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"with": @"with",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTWith alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"with"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"with"] doubleValue] != [dict[@"with"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTWith.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTWith.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTWith.properties.allValues];
}
@end

@implementation QTXor
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"xor": @"xor",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTXor alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"xor"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"xor"] doubleValue] != [dict[@"xor"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTXor.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTXor.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTXor.properties.allValues];
}
@end

@implementation QTXorEq
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"xor_eq": @"xorEq",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTXorEq alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"xor_eq"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"xor_eq"] doubleValue] != [dict[@"xor_eq"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTXorEq.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTXorEq.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTXorEq.properties.allValues] mutableCopy];

    for (id jsonName in QTXorEq.properties) {
        id propertyName = QTXorEq.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTYes
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"YES": @"yes",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYes alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"YES"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"YES"] doubleValue] != [dict[@"YES"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYes.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYes.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTYes.properties.allValues] mutableCopy];

    for (id jsonName in QTYes.properties) {
        id propertyName = QTYes.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTYield
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"yield": @"yield",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYield alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"yield"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"yield"] doubleValue] != [dict[@"yield"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYield.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYield.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTYield.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
