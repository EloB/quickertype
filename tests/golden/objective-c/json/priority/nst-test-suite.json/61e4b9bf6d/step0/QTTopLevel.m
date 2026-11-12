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

@interface QTJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectBasicJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectEmptyKeyJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectEscapedNullInKeyJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectExtremeNumbersJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectLongStringsJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTX (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectSimpleJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectStringUnicodeJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTYObjectWithNewlinesJSON (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
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
        @"y_structure_lonely_false.json": @"isYStructureLonelyFalseJSON",
        @"y_structure_lonely_true.json": @"isYStructureLonelyTrueJSON",
        @"y_number_0e1.json": @"qtTopLevelYNumber0E1JSON",
        @"y_array_arraysWithSpaces.json": @"yArrayArraysWithSpacesJSON",
        @"y_array_empty.json": @"yArrayEmptyJSON",
        @"y_array_empty-string.json": @"yArrayEmptyStringJSON",
        @"y_array_ending_with_newline.json": @"yArrayEndingWithNewlineJSON",
        @"y_array_false.json": @"yArrayFalseJSON",
        @"y_array_heterogeneous.json": @"yArrayHeterogeneousJSON",
        @"y_array_null.json": @"yArrayNullJSON",
        @"y_array_with_1_and_newline.json": @"yArrayWith1_AndNewlineJSON",
        @"y_array_with_leading_space.json": @"yArrayWithLeadingSpaceJSON",
        @"y_array_with_several_null.json": @"yArrayWithSeveralNullJSON",
        @"y_array_with_trailing_space.json": @"yArrayWithTrailingSpaceJSON",
        @"y_number_0e+1.json": @"yNumber0E1JSON",
        @"y_number_after_space.json": @"yNumberAfterSpaceJSON",
        @"y_number_double_close_to_zero.json": @"yNumberDoubleCloseToZeroJSON",
        @"y_number_int_with_exp.json": @"yNumberIntWithExpJSON",
        @"y_number.json": @"yNumberJSON",
        @"y_number_minus_zero.json": @"yNumberMinusZeroJSON",
        @"y_number_negative_int.json": @"yNumberNegativeIntJSON",
        @"y_number_negative_one.json": @"yNumberNegativeOneJSON",
        @"y_number_negative_zero.json": @"yNumberNegativeZeroJSON",
        @"y_number_real_capital_e.json": @"yNumberRealCapitalEJSON",
        @"y_number_real_capital_e_neg_exp.json": @"yNumberRealCapitalENegExpJSON",
        @"y_number_real_capital_e_pos_exp.json": @"yNumberRealCapitalEPosExpJSON",
        @"y_number_real_exponent.json": @"yNumberRealExponentJSON",
        @"y_number_real_fraction_exponent.json": @"yNumberRealFractionExponentJSON",
        @"y_number_real_neg_exp.json": @"yNumberRealNegExpJSON",
        @"y_number_real_pos_exponent.json": @"yNumberRealPosExponentJSON",
        @"y_number_simple_int.json": @"yNumberSimpleIntJSON",
        @"y_number_simple_real.json": @"yNumberSimpleRealJSON",
        @"y_object_basic.json": @"yObjectBasicJSON",
        @"y_object_empty.json": @"yObjectEmptyJSON",
        @"y_object_empty_key.json": @"yObjectEmptyKeyJSON",
        @"y_object_escaped_null_in_key.json": @"yObjectEscapedNullInKeyJSON",
        @"y_object_extreme_numbers.json": @"yObjectExtremeNumbersJSON",
        @"y_object.json": @"yObjectJSON",
        @"y_object_long_strings.json": @"yObjectLongStringsJSON",
        @"y_object_simple.json": @"yObjectSimpleJSON",
        @"y_object_string_unicode.json": @"yObjectStringUnicodeJSON",
        @"y_object_with_newlines.json": @"yObjectWithNewlinesJSON",
        @"y_string_1_2_3_bytes_UTF-8_sequences.json": @"yString1_2_3_BytesUTF8_SequencesJSON",
        @"y_string_accepted_surrogate_pair.json": @"yStringAcceptedSurrogatePairJSON",
        @"y_string_accepted_surrogate_pairs.json": @"yStringAcceptedSurrogatePairsJSON",
        @"y_string_allowed_escapes.json": @"yStringAllowedEscapesJSON",
        @"y_string_backslash_and_u_escaped_zero.json": @"yStringBackslashAndUEscapedZeroJSON",
        @"y_string_backslash_doublequotes.json": @"yStringBackslashDoublequotesJSON",
        @"y_string_comments.json": @"yStringCommentsJSON",
        @"y_string_double_escape_a.json": @"yStringDoubleEscapeAJSON",
        @"y_string_double_escape_n.json": @"yStringDoubleEscapeNJSON",
        @"y_string_escaped_control_character.json": @"yStringEscapedControlCharacterJSON",
        @"y_string_escaped_noncharacter.json": @"yStringEscapedNoncharacterJSON",
        @"y_string_in_array.json": @"yStringInArrayJSON",
        @"y_string_in_array_with_leading_space.json": @"yStringInArrayWithLeadingSpaceJSON",
        @"y_string_last_surrogates_1_and_2.json": @"yStringLastSurrogates1_And2JSON",
        @"y_string_nbsp_uescaped.json": @"yStringNbspUescapedJSON",
        @"y_string_nonCharacterInUTF-8_U+10FFFF.json": @"yStringNonCharacterInUTF8_U10FFFFJSON",
        @"y_string_nonCharacterInUTF-8_U+1FFFF.json": @"yStringNonCharacterInUTF8_U1FFFFJSON",
        @"y_string_nonCharacterInUTF-8_U+FFFF.json": @"yStringNonCharacterInUTF8_UFFFFJSON",
        @"y_string_null_escape.json": @"yStringNullEscapeJSON",
        @"y_string_one-byte-utf-8.json": @"yStringOneByteUTF8JSON",
        @"y_string_pi.json": @"yStringPiJSON",
        @"y_string_simple_ascii.json": @"yStringSimpleASCIIJSON",
        @"y_string_space.json": @"yStringSpaceJSON",
        @"y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json": @"yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON",
        @"y_string_three-byte-utf-8.json": @"yStringThreeByteUTF8JSON",
        @"y_string_two-byte-utf-8.json": @"yStringTwoByteUTF8JSON",
        @"y_string_u+2028_line_sep.json": @"yStringU2028_LineSepJSON",
        @"y_string_u+2029_par_sep.json": @"yStringU2029_ParSepJSON",
        @"y_string_uEscape.json": @"yStringUEscapeJSON",
        @"y_string_uescaped_newline.json": @"yStringUescapedNewlineJSON",
        @"y_string_unescaped_char_delete.json": @"yStringUnescapedCharDeleteJSON",
        @"y_string_unicode_2.json": @"yStringUnicode2JSON",
        @"y_string_unicodeEscapedBackslash.json": @"yStringUnicodeEscapedBackslashJSON",
        @"y_string_unicode_escaped_double_quote.json": @"yStringUnicodeEscapedDoubleQuoteJSON",
        @"y_string_unicode.json": @"yStringUnicodeJSON",
        @"y_string_unicode_U+10FFFE_nonchar.json": @"yStringUnicodeU10FFFENoncharJSON",
        @"y_string_unicode_U+1FFFE_nonchar.json": @"yStringUnicodeU1FFFENoncharJSON",
        @"y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json": @"yStringUnicodeU200BZEROWIDTHSPACEJSON",
        @"y_string_unicode_U+2064_invisible_plus.json": @"yStringUnicodeU2064_InvisiblePlusJSON",
        @"y_string_unicode_U+FDD0_nonchar.json": @"yStringUnicodeUFDD0NoncharJSON",
        @"y_string_unicode_U+FFFE_nonchar.json": @"yStringUnicodeUFFFENoncharJSON",
        @"y_string_utf8.json": @"yStringUtf8JSON",
        @"y_string_with_del_character.json": @"yStringWithDelCharacterJSON",
        @"y_structure_lonely_int.json": @"yStructureLonelyIntJSON",
        @"y_structure_lonely_negative_real.json": @"yStructureLonelyNegativeRealJSON",
        @"y_structure_lonely_null.json": @"yStructureLonelyNullJSON",
        @"y_structure_lonely_string.json": @"yStructureLonelyStringJSON",
        @"y_structure_string_empty.json": @"yStructureStringEmptyJSON",
        @"y_structure_trailing_newline.json": @"yStructureTrailingNewlineJSON",
        @"y_structure_true_in_array.json": @"yStructureTrueInArrayJSON",
        @"y_structure_whitespace_array.json": @"yStructureWhitespaceArrayJSON",
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
        if (![dict[@"y_structure_lonely_false.json"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"y_structure_lonely_true.json"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"y_number_0e1.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_arraysWithSpaces.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_empty.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_empty-string.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_ending_with_newline.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_false.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_heterogeneous.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_null.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_with_1_and_newline.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_with_leading_space.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_with_several_null.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_array_with_trailing_space.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_0e+1.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_after_space.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_double_close_to_zero.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_int_with_exp.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_minus_zero.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_negative_int.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_negative_one.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_negative_zero.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_real_capital_e.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_real_capital_e_neg_exp.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_real_capital_e_pos_exp.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_real_exponent.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_real_fraction_exponent.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_real_neg_exp.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_real_pos_exponent.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_simple_int.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_number_simple_real.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_object_basic.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_empty.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_empty_key.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_escaped_null_in_key.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_extreme_numbers.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_long_strings.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_simple.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_string_unicode.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_object_with_newlines.json"] isKindOfClass:NSDictionary.class]) return nil;
        if (![dict[@"y_string_1_2_3_bytes_UTF-8_sequences.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_accepted_surrogate_pair.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_accepted_surrogate_pairs.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_allowed_escapes.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_backslash_and_u_escaped_zero.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_backslash_doublequotes.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_comments.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_double_escape_a.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_double_escape_n.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_escaped_control_character.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_escaped_noncharacter.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_in_array.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_in_array_with_leading_space.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_last_surrogates_1_and_2.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_nbsp_uescaped.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_nonCharacterInUTF-8_U+10FFFF.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_nonCharacterInUTF-8_U+1FFFF.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_nonCharacterInUTF-8_U+FFFF.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_null_escape.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_one-byte-utf-8.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_pi.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_simple_ascii.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_space.json"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_three-byte-utf-8.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_two-byte-utf-8.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_u+2028_line_sep.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_u+2029_par_sep.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_uEscape.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_uescaped_newline.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unescaped_char_delete.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_2.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicodeEscapedBackslash.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_escaped_double_quote.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_U+10FFFE_nonchar.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_U+1FFFE_nonchar.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_U+2064_invisible_plus.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_U+FDD0_nonchar.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_unicode_U+FFFE_nonchar.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_utf8.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_string_with_del_character.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_structure_lonely_int.json"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"y_structure_lonely_int.json"] doubleValue] != [dict[@"y_structure_lonely_int.json"] longLongValue]) return nil;
        if (![dict[@"y_structure_lonely_negative_real.json"] isKindOfClass:NSNumber.class]) return nil;
        if (!dict[@"y_structure_lonely_null.json"]) return nil;
        if (![dict[@"y_structure_lonely_string.json"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"y_structure_string_empty.json"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"y_structure_trailing_newline.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_structure_true_in_array.json"] isKindOfClass:NSArray.class]) return nil;
        if (![dict[@"y_structure_whitespace_array.json"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _yObjectBasicJSON = [QTYObjectBasicJSON fromJSONDictionary:(id)_yObjectBasicJSON];
        if (!_yObjectBasicJSON && dict[@"y_object_basic.json"] && ![dict[@"y_object_basic.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectEmptyJSON = [QTJSON fromJSONDictionary:(id)_yObjectEmptyJSON];
        if (!_yObjectEmptyJSON && dict[@"y_object_empty.json"] && ![dict[@"y_object_empty.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectEmptyKeyJSON = [QTYObjectEmptyKeyJSON fromJSONDictionary:(id)_yObjectEmptyKeyJSON];
        if (!_yObjectEmptyKeyJSON && dict[@"y_object_empty_key.json"] && ![dict[@"y_object_empty_key.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectEscapedNullInKeyJSON = [QTYObjectEscapedNullInKeyJSON fromJSONDictionary:(id)_yObjectEscapedNullInKeyJSON];
        if (!_yObjectEscapedNullInKeyJSON && dict[@"y_object_escaped_null_in_key.json"] && ![dict[@"y_object_escaped_null_in_key.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectExtremeNumbersJSON = [QTYObjectExtremeNumbersJSON fromJSONDictionary:(id)_yObjectExtremeNumbersJSON];
        if (!_yObjectExtremeNumbersJSON && dict[@"y_object_extreme_numbers.json"] && ![dict[@"y_object_extreme_numbers.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectJSON = [QTYObjectJSON fromJSONDictionary:(id)_yObjectJSON];
        if (!_yObjectJSON && dict[@"y_object.json"] && ![dict[@"y_object.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectLongStringsJSON = [QTYObjectLongStringsJSON fromJSONDictionary:(id)_yObjectLongStringsJSON];
        if (!_yObjectLongStringsJSON && dict[@"y_object_long_strings.json"] && ![dict[@"y_object_long_strings.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectSimpleJSON = [QTYObjectSimpleJSON fromJSONDictionary:(id)_yObjectSimpleJSON];
        if (!_yObjectSimpleJSON && dict[@"y_object_simple.json"] && ![dict[@"y_object_simple.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectStringUnicodeJSON = [QTYObjectStringUnicodeJSON fromJSONDictionary:(id)_yObjectStringUnicodeJSON];
        if (!_yObjectStringUnicodeJSON && dict[@"y_object_string_unicode.json"] && ![dict[@"y_object_string_unicode.json"] isKindOfClass:NSNull.class]) return nil;
        _yObjectWithNewlinesJSON = [QTYObjectWithNewlinesJSON fromJSONDictionary:(id)_yObjectWithNewlinesJSON];
        if (!_yObjectWithNewlinesJSON && dict[@"y_object_with_newlines.json"] && ![dict[@"y_object_with_newlines.json"] isKindOfClass:NSNull.class]) return nil;
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

    for (id jsonName in QTTopLevel.properties) {
        id propertyName = QTTopLevel.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"y_structure_lonely_false.json": _isYStructureLonelyFalseJSON ? @YES : @NO,
        @"y_structure_lonely_true.json": _isYStructureLonelyTrueJSON ? @YES : @NO,
        @"y_object_basic.json": [_yObjectBasicJSON JSONDictionary],
        @"y_object_empty.json": [_yObjectEmptyJSON JSONDictionary],
        @"y_object_empty_key.json": [_yObjectEmptyKeyJSON JSONDictionary],
        @"y_object_escaped_null_in_key.json": [_yObjectEscapedNullInKeyJSON JSONDictionary],
        @"y_object_extreme_numbers.json": [_yObjectExtremeNumbersJSON JSONDictionary],
        @"y_object.json": [_yObjectJSON JSONDictionary],
        @"y_object_long_strings.json": [_yObjectLongStringsJSON JSONDictionary],
        @"y_object_simple.json": [_yObjectSimpleJSON JSONDictionary],
        @"y_object_string_unicode.json": [_yObjectStringUnicodeJSON JSONDictionary],
        @"y_object_with_newlines.json": [_yObjectWithNewlinesJSON JSONDictionary],
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

@implementation QTJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
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

@implementation QTYObjectBasicJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"asd": @"asd",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectBasicJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"asd"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectBasicJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectBasicJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTYObjectBasicJSON.properties.allValues];
}
@end

@implementation QTYObjectEmptyKeyJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"": @"empty",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectEmptyKeyJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@""] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@""] doubleValue] != [dict[@""] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectEmptyKeyJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectEmptyKeyJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTYObjectEmptyKeyJSON.properties.allValues] mutableCopy];

    for (id jsonName in QTYObjectEmptyKeyJSON.properties) {
        id propertyName = QTYObjectEmptyKeyJSON.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTYObjectEscapedNullInKeyJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"foo\000bar": @"fooBar",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectEscapedNullInKeyJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"foo\000bar"] isKindOfClass:NSNumber.class]) return nil;
        if ([dict[@"foo\000bar"] doubleValue] != [dict[@"foo\000bar"] longLongValue]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectEscapedNullInKeyJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectEscapedNullInKeyJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTYObjectEscapedNullInKeyJSON.properties.allValues] mutableCopy];

    for (id jsonName in QTYObjectEscapedNullInKeyJSON.properties) {
        id propertyName = QTYObjectEscapedNullInKeyJSON.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTYObjectExtremeNumbersJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"max": @"max",
        @"min": @"min",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectExtremeNumbersJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"max"] isKindOfClass:NSNumber.class]) return nil;
        if (![dict[@"min"] isKindOfClass:NSNumber.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectExtremeNumbersJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectExtremeNumbersJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTYObjectExtremeNumbersJSON.properties.allValues];
}
@end

@implementation QTYObjectJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"asd": @"asd",
        @"dfg": @"dfg",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"asd"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"dfg"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTYObjectJSON.properties.allValues];
}
@end

@implementation QTYObjectLongStringsJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
        @"x": @"x",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectLongStringsJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        if (![dict[@"x"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
        _x = map(_x, λ(id x, [QTX fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectLongStringsJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectLongStringsJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTYObjectLongStringsJSON.properties.allValues] mutableCopy];

    for (id jsonName in QTYObjectLongStringsJSON.properties) {
        id propertyName = QTYObjectLongStringsJSON.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"x": map(_x, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTX
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"identifier",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTX alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"id"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTX.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTX.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTX.properties.allValues] mutableCopy];

    for (id jsonName in QTX.properties) {
        id propertyName = QTX.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    return dict;
}
@end

@implementation QTYObjectSimpleJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"a": @"a",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectSimpleJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"a"] isKindOfClass:NSArray.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectSimpleJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectSimpleJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTYObjectSimpleJSON.properties.allValues];
}
@end

@implementation QTYObjectStringUnicodeJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"title": @"title",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectStringUnicodeJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"title"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectStringUnicodeJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectStringUnicodeJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTYObjectStringUnicodeJSON.properties.allValues];
}
@end

@implementation QTYObjectWithNewlinesJSON
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"a": @"a",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return [dict isKindOfClass:NSDictionary.class] ? [[QTYObjectWithNewlinesJSON alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        if (![dict[@"a"] isKindOfClass:NSString.class]) return nil;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTYObjectWithNewlinesJSON.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTYObjectWithNewlinesJSON.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTYObjectWithNewlinesJSON.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
