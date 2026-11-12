{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , JSON (..)
    , YObjectBasicJSON (..)
    , YObjectEmptyKeyJSON (..)
    , YObjectEscapedNullInKeyJSON (..)
    , YObjectExtremeNumbersJSON (..)
    , YObjectJSON (..)
    , YObjectLongStringsJSON (..)
    , X (..)
    , YObjectSimpleJSON (..)
    , YObjectStringUnicodeJSON (..)
    , YObjectWithNewlinesJSON (..)
    , YArrayHeterogeneousJSON (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { quickTypeYNumber0E1JSONQuickType :: [Double]
    , yArrayArraysWithSpacesJSONQuickType :: [([Value])]
    , yArrayEmptyJSONQuickType :: [Value]
    , yArrayEmptyStringJSONQuickType :: [Text]
    , yArrayEndingWithNewlineJSONQuickType :: [Text]
    , yArrayFalseJSONQuickType :: [Bool]
    , yArrayHeterogeneousJSONQuickType :: [YArrayHeterogeneousJSON]
    , yArrayNullJSONQuickType :: [(Maybe Text)]
    , yArrayWith1_AndNewlineJSONQuickType :: [Int]
    , yArrayWithLeadingSpaceJSONQuickType :: [Int]
    , yArrayWithSeveralNullJSONQuickType :: [(Maybe Int)]
    , yArrayWithTrailingSpaceJSONQuickType :: [Int]
    , yNumber0E1JSONQuickType :: [Double]
    , yNumberAfterSpaceJSONQuickType :: [Int]
    , yNumberDoubleCloseToZeroJSONQuickType :: [Double]
    , yNumberIntWithExpJSONQuickType :: [Double]
    , yNumberJSONQuickType :: [Double]
    , yNumberMinusZeroJSONQuickType :: [Int]
    , yNumberNegativeIntJSONQuickType :: [Int]
    , yNumberNegativeOneJSONQuickType :: [Int]
    , yNumberNegativeZeroJSONQuickType :: [Int]
    , yNumberRealCapitalEJSONQuickType :: [Double]
    , yNumberRealCapitalENegExpJSONQuickType :: [Double]
    , yNumberRealCapitalEPosExpJSONQuickType :: [Double]
    , yNumberRealExponentJSONQuickType :: [Double]
    , yNumberRealFractionExponentJSONQuickType :: [Double]
    , yNumberRealNegExpJSONQuickType :: [Double]
    , yNumberRealPosExponentJSONQuickType :: [Double]
    , yNumberSimpleIntJSONQuickType :: [Int]
    , yNumberSimpleRealJSONQuickType :: [Double]
    , yObjectBasicJSONQuickType :: YObjectBasicJSON
    , yObjectEmptyJSONQuickType :: JSON
    , yObjectEmptyKeyJSONQuickType :: YObjectEmptyKeyJSON
    , yObjectEscapedNullInKeyJSONQuickType :: YObjectEscapedNullInKeyJSON
    , yObjectExtremeNumbersJSONQuickType :: YObjectExtremeNumbersJSON
    , yObjectJSONQuickType :: YObjectJSON
    , yObjectLongStringsJSONQuickType :: YObjectLongStringsJSON
    , yObjectSimpleJSONQuickType :: YObjectSimpleJSON
    , yObjectStringUnicodeJSONQuickType :: YObjectStringUnicodeJSON
    , yObjectWithNewlinesJSONQuickType :: YObjectWithNewlinesJSON
    , yString1_2_3_BytesUTF8_SequencesJSONQuickType :: [Text]
    , yStringAcceptedSurrogatePairJSONQuickType :: [Text]
    , yStringAcceptedSurrogatePairsJSONQuickType :: [Text]
    , yStringAllowedEscapesJSONQuickType :: [Text]
    , yStringBackslashAndUEscapedZeroJSONQuickType :: [Text]
    , yStringBackslashDoublequotesJSONQuickType :: [Text]
    , yStringCommentsJSONQuickType :: [Text]
    , yStringDoubleEscapeAJSONQuickType :: [Text]
    , yStringDoubleEscapeNJSONQuickType :: [Text]
    , yStringEscapedControlCharacterJSONQuickType :: [Text]
    , yStringEscapedNoncharacterJSONQuickType :: [Text]
    , yStringInArrayJSONQuickType :: [Text]
    , yStringInArrayWithLeadingSpaceJSONQuickType :: [Text]
    , yStringLastSurrogates1_And2JSONQuickType :: [Text]
    , yStringNbspUescapedJSONQuickType :: [Text]
    , yStringNonCharacterInUTF8_U10FFFFJSONQuickType :: [Text]
    , yStringNonCharacterInUTF8_U1FFFFJSONQuickType :: [Text]
    , yStringNonCharacterInUTF8_UFFFFJSONQuickType :: [Text]
    , yStringNullEscapeJSONQuickType :: [Text]
    , yStringOneByteUTF8JSONQuickType :: [Text]
    , yStringPiJSONQuickType :: [Text]
    , yStringSimpleASCIIJSONQuickType :: [Text]
    , yStringSpaceJSONQuickType :: Text
    , yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSONQuickType :: [Text]
    , yStringThreeByteUTF8JSONQuickType :: [Text]
    , yStringTwoByteUTF8JSONQuickType :: [Text]
    , yStringU2028_LineSepJSONQuickType :: [Text]
    , yStringU2029_ParSepJSONQuickType :: [Text]
    , yStringUEscapeJSONQuickType :: [Text]
    , yStringUescapedNewlineJSONQuickType :: [Text]
    , yStringUnescapedCharDeleteJSONQuickType :: [Text]
    , yStringUnicode2JSONQuickType :: [Text]
    , yStringUnicodeEscapedBackslashJSONQuickType :: [Text]
    , yStringUnicodeEscapedDoubleQuoteJSONQuickType :: [Text]
    , yStringUnicodeJSONQuickType :: [Text]
    , yStringUnicodeU10FFFENoncharJSONQuickType :: [Text]
    , yStringUnicodeU1FFFENoncharJSONQuickType :: [Text]
    , yStringUnicodeU200BZEROWIDTHSPACEJSONQuickType :: [Text]
    , yStringUnicodeU2064_InvisiblePlusJSONQuickType :: [Text]
    , yStringUnicodeUFDD0NoncharJSONQuickType :: [Text]
    , yStringUnicodeUFFFENoncharJSONQuickType :: [Text]
    , yStringUtf8JSONQuickType :: [Text]
    , yStringWithDelCharacterJSONQuickType :: [Text]
    , yStructureLonelyFalseJSONQuickType :: Bool
    , yStructureLonelyIntJSONQuickType :: Int
    , yStructureLonelyNegativeRealJSONQuickType :: Double
    , yStructureLonelyNullJSONQuickType :: Maybe Text
    , yStructureLonelyStringJSONQuickType :: Text
    , yStructureLonelyTrueJSONQuickType :: Bool
    , yStructureStringEmptyJSONQuickType :: Text
    , yStructureTrailingNewlineJSONQuickType :: [Text]
    , yStructureTrueInArrayJSONQuickType :: [Bool]
    , yStructureWhitespaceArrayJSONQuickType :: [Value]
    } deriving (Show)

data YArrayHeterogeneousJSON
    = IntegerInYArrayHeterogeneousJSON Int
    | JSONInYArrayHeterogeneousJSON JSON
    | NullInYArrayHeterogeneousJSON
    | StringInYArrayHeterogeneousJSON Text
    deriving (Show)

data JSON = JSON
    {
    } deriving (Show)

data YObjectBasicJSON = YObjectBasicJSON
    { asdYObjectBasicJSON :: Text
    } deriving (Show)

data YObjectEmptyKeyJSON = YObjectEmptyKeyJSON
    { emptyYObjectEmptyKeyJSON :: Int
    } deriving (Show)

data YObjectEscapedNullInKeyJSON = YObjectEscapedNullInKeyJSON
    { fooBarYObjectEscapedNullInKeyJSON :: Int
    } deriving (Show)

data YObjectExtremeNumbersJSON = YObjectExtremeNumbersJSON
    { maxYObjectExtremeNumbersJSON :: Double
    , minYObjectExtremeNumbersJSON :: Double
    } deriving (Show)

data YObjectJSON = YObjectJSON
    { asdYObjectJSON :: Text
    , dfgYObjectJSON :: Text
    } deriving (Show)

data YObjectLongStringsJSON = YObjectLongStringsJSON
    { xYObjectLongStringsJSON :: [X]
    , yObjectLongStringsJSONIDYObjectLongStringsJSON :: Text
    } deriving (Show)

data X = X
    { xIDX :: Text
    } deriving (Show)

data YObjectSimpleJSON = YObjectSimpleJSON
    { aYObjectSimpleJSON :: [Value]
    } deriving (Show)

data YObjectStringUnicodeJSON = YObjectStringUnicodeJSON
    { titleYObjectStringUnicodeJSON :: Text
    } deriving (Show)

data YObjectWithNewlinesJSON = YObjectWithNewlinesJSON
    { aYObjectWithNewlinesJSON :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType quickTypeYNumber0E1JSONQuickType yArrayArraysWithSpacesJSONQuickType yArrayEmptyJSONQuickType yArrayEmptyStringJSONQuickType yArrayEndingWithNewlineJSONQuickType yArrayFalseJSONQuickType yArrayHeterogeneousJSONQuickType yArrayNullJSONQuickType yArrayWith1_AndNewlineJSONQuickType yArrayWithLeadingSpaceJSONQuickType yArrayWithSeveralNullJSONQuickType yArrayWithTrailingSpaceJSONQuickType yNumber0E1JSONQuickType yNumberAfterSpaceJSONQuickType yNumberDoubleCloseToZeroJSONQuickType yNumberIntWithExpJSONQuickType yNumberJSONQuickType yNumberMinusZeroJSONQuickType yNumberNegativeIntJSONQuickType yNumberNegativeOneJSONQuickType yNumberNegativeZeroJSONQuickType yNumberRealCapitalEJSONQuickType yNumberRealCapitalENegExpJSONQuickType yNumberRealCapitalEPosExpJSONQuickType yNumberRealExponentJSONQuickType yNumberRealFractionExponentJSONQuickType yNumberRealNegExpJSONQuickType yNumberRealPosExponentJSONQuickType yNumberSimpleIntJSONQuickType yNumberSimpleRealJSONQuickType yObjectBasicJSONQuickType yObjectEmptyJSONQuickType yObjectEmptyKeyJSONQuickType yObjectEscapedNullInKeyJSONQuickType yObjectExtremeNumbersJSONQuickType yObjectJSONQuickType yObjectLongStringsJSONQuickType yObjectSimpleJSONQuickType yObjectStringUnicodeJSONQuickType yObjectWithNewlinesJSONQuickType yString1_2_3_BytesUTF8_SequencesJSONQuickType yStringAcceptedSurrogatePairJSONQuickType yStringAcceptedSurrogatePairsJSONQuickType yStringAllowedEscapesJSONQuickType yStringBackslashAndUEscapedZeroJSONQuickType yStringBackslashDoublequotesJSONQuickType yStringCommentsJSONQuickType yStringDoubleEscapeAJSONQuickType yStringDoubleEscapeNJSONQuickType yStringEscapedControlCharacterJSONQuickType yStringEscapedNoncharacterJSONQuickType yStringInArrayJSONQuickType yStringInArrayWithLeadingSpaceJSONQuickType yStringLastSurrogates1_And2JSONQuickType yStringNbspUescapedJSONQuickType yStringNonCharacterInUTF8_U10FFFFJSONQuickType yStringNonCharacterInUTF8_U1FFFFJSONQuickType yStringNonCharacterInUTF8_UFFFFJSONQuickType yStringNullEscapeJSONQuickType yStringOneByteUTF8JSONQuickType yStringPiJSONQuickType yStringSimpleASCIIJSONQuickType yStringSpaceJSONQuickType yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSONQuickType yStringThreeByteUTF8JSONQuickType yStringTwoByteUTF8JSONQuickType yStringU2028_LineSepJSONQuickType yStringU2029_ParSepJSONQuickType yStringUEscapeJSONQuickType yStringUescapedNewlineJSONQuickType yStringUnescapedCharDeleteJSONQuickType yStringUnicode2JSONQuickType yStringUnicodeEscapedBackslashJSONQuickType yStringUnicodeEscapedDoubleQuoteJSONQuickType yStringUnicodeJSONQuickType yStringUnicodeU10FFFENoncharJSONQuickType yStringUnicodeU1FFFENoncharJSONQuickType yStringUnicodeU200BZEROWIDTHSPACEJSONQuickType yStringUnicodeU2064_InvisiblePlusJSONQuickType yStringUnicodeUFDD0NoncharJSONQuickType yStringUnicodeUFFFENoncharJSONQuickType yStringUtf8JSONQuickType yStringWithDelCharacterJSONQuickType yStructureLonelyFalseJSONQuickType yStructureLonelyIntJSONQuickType yStructureLonelyNegativeRealJSONQuickType yStructureLonelyNullJSONQuickType yStructureLonelyStringJSONQuickType yStructureLonelyTrueJSONQuickType yStructureStringEmptyJSONQuickType yStructureTrailingNewlineJSONQuickType yStructureTrueInArrayJSONQuickType yStructureWhitespaceArrayJSONQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "y_number_0e1.json" .= quickTypeYNumber0E1JSONQuickType
        , Just $ "y_array_arraysWithSpaces.json" .= yArrayArraysWithSpacesJSONQuickType
        , Just $ "y_array_empty.json" .= yArrayEmptyJSONQuickType
        , Just $ "y_array_empty-string.json" .= yArrayEmptyStringJSONQuickType
        , Just $ "y_array_ending_with_newline.json" .= yArrayEndingWithNewlineJSONQuickType
        , Just $ "y_array_false.json" .= yArrayFalseJSONQuickType
        , Just $ "y_array_heterogeneous.json" .= yArrayHeterogeneousJSONQuickType
        , Just $ "y_array_null.json" .= yArrayNullJSONQuickType
        , Just $ "y_array_with_1_and_newline.json" .= yArrayWith1_AndNewlineJSONQuickType
        , Just $ "y_array_with_leading_space.json" .= yArrayWithLeadingSpaceJSONQuickType
        , Just $ "y_array_with_several_null.json" .= yArrayWithSeveralNullJSONQuickType
        , Just $ "y_array_with_trailing_space.json" .= yArrayWithTrailingSpaceJSONQuickType
        , Just $ "y_number_0e+1.json" .= yNumber0E1JSONQuickType
        , Just $ "y_number_after_space.json" .= yNumberAfterSpaceJSONQuickType
        , Just $ "y_number_double_close_to_zero.json" .= yNumberDoubleCloseToZeroJSONQuickType
        , Just $ "y_number_int_with_exp.json" .= yNumberIntWithExpJSONQuickType
        , Just $ "y_number.json" .= yNumberJSONQuickType
        , Just $ "y_number_minus_zero.json" .= yNumberMinusZeroJSONQuickType
        , Just $ "y_number_negative_int.json" .= yNumberNegativeIntJSONQuickType
        , Just $ "y_number_negative_one.json" .= yNumberNegativeOneJSONQuickType
        , Just $ "y_number_negative_zero.json" .= yNumberNegativeZeroJSONQuickType
        , Just $ "y_number_real_capital_e.json" .= yNumberRealCapitalEJSONQuickType
        , Just $ "y_number_real_capital_e_neg_exp.json" .= yNumberRealCapitalENegExpJSONQuickType
        , Just $ "y_number_real_capital_e_pos_exp.json" .= yNumberRealCapitalEPosExpJSONQuickType
        , Just $ "y_number_real_exponent.json" .= yNumberRealExponentJSONQuickType
        , Just $ "y_number_real_fraction_exponent.json" .= yNumberRealFractionExponentJSONQuickType
        , Just $ "y_number_real_neg_exp.json" .= yNumberRealNegExpJSONQuickType
        , Just $ "y_number_real_pos_exponent.json" .= yNumberRealPosExponentJSONQuickType
        , Just $ "y_number_simple_int.json" .= yNumberSimpleIntJSONQuickType
        , Just $ "y_number_simple_real.json" .= yNumberSimpleRealJSONQuickType
        , Just $ "y_object_basic.json" .= yObjectBasicJSONQuickType
        , Just $ "y_object_empty.json" .= yObjectEmptyJSONQuickType
        , Just $ "y_object_empty_key.json" .= yObjectEmptyKeyJSONQuickType
        , Just $ "y_object_escaped_null_in_key.json" .= yObjectEscapedNullInKeyJSONQuickType
        , Just $ "y_object_extreme_numbers.json" .= yObjectExtremeNumbersJSONQuickType
        , Just $ "y_object.json" .= yObjectJSONQuickType
        , Just $ "y_object_long_strings.json" .= yObjectLongStringsJSONQuickType
        , Just $ "y_object_simple.json" .= yObjectSimpleJSONQuickType
        , Just $ "y_object_string_unicode.json" .= yObjectStringUnicodeJSONQuickType
        , Just $ "y_object_with_newlines.json" .= yObjectWithNewlinesJSONQuickType
        , Just $ "y_string_1_2_3_bytes_UTF-8_sequences.json" .= yString1_2_3_BytesUTF8_SequencesJSONQuickType
        , Just $ "y_string_accepted_surrogate_pair.json" .= yStringAcceptedSurrogatePairJSONQuickType
        , Just $ "y_string_accepted_surrogate_pairs.json" .= yStringAcceptedSurrogatePairsJSONQuickType
        , Just $ "y_string_allowed_escapes.json" .= yStringAllowedEscapesJSONQuickType
        , Just $ "y_string_backslash_and_u_escaped_zero.json" .= yStringBackslashAndUEscapedZeroJSONQuickType
        , Just $ "y_string_backslash_doublequotes.json" .= yStringBackslashDoublequotesJSONQuickType
        , Just $ "y_string_comments.json" .= yStringCommentsJSONQuickType
        , Just $ "y_string_double_escape_a.json" .= yStringDoubleEscapeAJSONQuickType
        , Just $ "y_string_double_escape_n.json" .= yStringDoubleEscapeNJSONQuickType
        , Just $ "y_string_escaped_control_character.json" .= yStringEscapedControlCharacterJSONQuickType
        , Just $ "y_string_escaped_noncharacter.json" .= yStringEscapedNoncharacterJSONQuickType
        , Just $ "y_string_in_array.json" .= yStringInArrayJSONQuickType
        , Just $ "y_string_in_array_with_leading_space.json" .= yStringInArrayWithLeadingSpaceJSONQuickType
        , Just $ "y_string_last_surrogates_1_and_2.json" .= yStringLastSurrogates1_And2JSONQuickType
        , Just $ "y_string_nbsp_uescaped.json" .= yStringNbspUescapedJSONQuickType
        , Just $ "y_string_nonCharacterInUTF-8_U+10FFFF.json" .= yStringNonCharacterInUTF8_U10FFFFJSONQuickType
        , Just $ "y_string_nonCharacterInUTF-8_U+1FFFF.json" .= yStringNonCharacterInUTF8_U1FFFFJSONQuickType
        , Just $ "y_string_nonCharacterInUTF-8_U+FFFF.json" .= yStringNonCharacterInUTF8_UFFFFJSONQuickType
        , Just $ "y_string_null_escape.json" .= yStringNullEscapeJSONQuickType
        , Just $ "y_string_one-byte-utf-8.json" .= yStringOneByteUTF8JSONQuickType
        , Just $ "y_string_pi.json" .= yStringPiJSONQuickType
        , Just $ "y_string_simple_ascii.json" .= yStringSimpleASCIIJSONQuickType
        , Just $ "y_string_space.json" .= yStringSpaceJSONQuickType
        , Just $ "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json" .= yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSONQuickType
        , Just $ "y_string_three-byte-utf-8.json" .= yStringThreeByteUTF8JSONQuickType
        , Just $ "y_string_two-byte-utf-8.json" .= yStringTwoByteUTF8JSONQuickType
        , Just $ "y_string_u+2028_line_sep.json" .= yStringU2028_LineSepJSONQuickType
        , Just $ "y_string_u+2029_par_sep.json" .= yStringU2029_ParSepJSONQuickType
        , Just $ "y_string_uEscape.json" .= yStringUEscapeJSONQuickType
        , Just $ "y_string_uescaped_newline.json" .= yStringUescapedNewlineJSONQuickType
        , Just $ "y_string_unescaped_char_delete.json" .= yStringUnescapedCharDeleteJSONQuickType
        , Just $ "y_string_unicode_2.json" .= yStringUnicode2JSONQuickType
        , Just $ "y_string_unicodeEscapedBackslash.json" .= yStringUnicodeEscapedBackslashJSONQuickType
        , Just $ "y_string_unicode_escaped_double_quote.json" .= yStringUnicodeEscapedDoubleQuoteJSONQuickType
        , Just $ "y_string_unicode.json" .= yStringUnicodeJSONQuickType
        , Just $ "y_string_unicode_U+10FFFE_nonchar.json" .= yStringUnicodeU10FFFENoncharJSONQuickType
        , Just $ "y_string_unicode_U+1FFFE_nonchar.json" .= yStringUnicodeU1FFFENoncharJSONQuickType
        , Just $ "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json" .= yStringUnicodeU200BZEROWIDTHSPACEJSONQuickType
        , Just $ "y_string_unicode_U+2064_invisible_plus.json" .= yStringUnicodeU2064_InvisiblePlusJSONQuickType
        , Just $ "y_string_unicode_U+FDD0_nonchar.json" .= yStringUnicodeUFDD0NoncharJSONQuickType
        , Just $ "y_string_unicode_U+FFFE_nonchar.json" .= yStringUnicodeUFFFENoncharJSONQuickType
        , Just $ "y_string_utf8.json" .= yStringUtf8JSONQuickType
        , Just $ "y_string_with_del_character.json" .= yStringWithDelCharacterJSONQuickType
        , Just $ "y_structure_lonely_false.json" .= yStructureLonelyFalseJSONQuickType
        , Just $ "y_structure_lonely_int.json" .= yStructureLonelyIntJSONQuickType
        , Just $ "y_structure_lonely_negative_real.json" .= yStructureLonelyNegativeRealJSONQuickType
        , Just $ "y_structure_lonely_null.json" .= yStructureLonelyNullJSONQuickType
        , Just $ "y_structure_lonely_string.json" .= yStructureLonelyStringJSONQuickType
        , Just $ "y_structure_lonely_true.json" .= yStructureLonelyTrueJSONQuickType
        , Just $ "y_structure_string_empty.json" .= yStructureStringEmptyJSONQuickType
        , Just $ "y_structure_trailing_newline.json" .= yStructureTrailingNewlineJSONQuickType
        , Just $ "y_structure_true_in_array.json" .= yStructureTrueInArrayJSONQuickType
        , Just $ "y_structure_whitespace_array.json" .= yStructureWhitespaceArrayJSONQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "y_number_0e1.json"
        <*> v .: "y_array_arraysWithSpaces.json"
        <*> v .: "y_array_empty.json"
        <*> v .: "y_array_empty-string.json"
        <*> v .: "y_array_ending_with_newline.json"
        <*> v .: "y_array_false.json"
        <*> v .: "y_array_heterogeneous.json"
        <*> v .: "y_array_null.json"
        <*> v .: "y_array_with_1_and_newline.json"
        <*> v .: "y_array_with_leading_space.json"
        <*> v .: "y_array_with_several_null.json"
        <*> v .: "y_array_with_trailing_space.json"
        <*> v .: "y_number_0e+1.json"
        <*> v .: "y_number_after_space.json"
        <*> v .: "y_number_double_close_to_zero.json"
        <*> v .: "y_number_int_with_exp.json"
        <*> v .: "y_number.json"
        <*> v .: "y_number_minus_zero.json"
        <*> v .: "y_number_negative_int.json"
        <*> v .: "y_number_negative_one.json"
        <*> v .: "y_number_negative_zero.json"
        <*> v .: "y_number_real_capital_e.json"
        <*> v .: "y_number_real_capital_e_neg_exp.json"
        <*> v .: "y_number_real_capital_e_pos_exp.json"
        <*> v .: "y_number_real_exponent.json"
        <*> v .: "y_number_real_fraction_exponent.json"
        <*> v .: "y_number_real_neg_exp.json"
        <*> v .: "y_number_real_pos_exponent.json"
        <*> v .: "y_number_simple_int.json"
        <*> v .: "y_number_simple_real.json"
        <*> v .: "y_object_basic.json"
        <*> v .: "y_object_empty.json"
        <*> v .: "y_object_empty_key.json"
        <*> v .: "y_object_escaped_null_in_key.json"
        <*> v .: "y_object_extreme_numbers.json"
        <*> v .: "y_object.json"
        <*> v .: "y_object_long_strings.json"
        <*> v .: "y_object_simple.json"
        <*> v .: "y_object_string_unicode.json"
        <*> v .: "y_object_with_newlines.json"
        <*> v .: "y_string_1_2_3_bytes_UTF-8_sequences.json"
        <*> v .: "y_string_accepted_surrogate_pair.json"
        <*> v .: "y_string_accepted_surrogate_pairs.json"
        <*> v .: "y_string_allowed_escapes.json"
        <*> v .: "y_string_backslash_and_u_escaped_zero.json"
        <*> v .: "y_string_backslash_doublequotes.json"
        <*> v .: "y_string_comments.json"
        <*> v .: "y_string_double_escape_a.json"
        <*> v .: "y_string_double_escape_n.json"
        <*> v .: "y_string_escaped_control_character.json"
        <*> v .: "y_string_escaped_noncharacter.json"
        <*> v .: "y_string_in_array.json"
        <*> v .: "y_string_in_array_with_leading_space.json"
        <*> v .: "y_string_last_surrogates_1_and_2.json"
        <*> v .: "y_string_nbsp_uescaped.json"
        <*> v .: "y_string_nonCharacterInUTF-8_U+10FFFF.json"
        <*> v .: "y_string_nonCharacterInUTF-8_U+1FFFF.json"
        <*> v .: "y_string_nonCharacterInUTF-8_U+FFFF.json"
        <*> v .: "y_string_null_escape.json"
        <*> v .: "y_string_one-byte-utf-8.json"
        <*> v .: "y_string_pi.json"
        <*> v .: "y_string_simple_ascii.json"
        <*> v .: "y_string_space.json"
        <*> v .: "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json"
        <*> v .: "y_string_three-byte-utf-8.json"
        <*> v .: "y_string_two-byte-utf-8.json"
        <*> v .: "y_string_u+2028_line_sep.json"
        <*> v .: "y_string_u+2029_par_sep.json"
        <*> v .: "y_string_uEscape.json"
        <*> v .: "y_string_uescaped_newline.json"
        <*> v .: "y_string_unescaped_char_delete.json"
        <*> v .: "y_string_unicode_2.json"
        <*> v .: "y_string_unicodeEscapedBackslash.json"
        <*> v .: "y_string_unicode_escaped_double_quote.json"
        <*> v .: "y_string_unicode.json"
        <*> v .: "y_string_unicode_U+10FFFE_nonchar.json"
        <*> v .: "y_string_unicode_U+1FFFE_nonchar.json"
        <*> v .: "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"
        <*> v .: "y_string_unicode_U+2064_invisible_plus.json"
        <*> v .: "y_string_unicode_U+FDD0_nonchar.json"
        <*> v .: "y_string_unicode_U+FFFE_nonchar.json"
        <*> v .: "y_string_utf8.json"
        <*> v .: "y_string_with_del_character.json"
        <*> v .: "y_structure_lonely_false.json"
        <*> v .: "y_structure_lonely_int.json"
        <*> v .: "y_structure_lonely_negative_real.json"
        <*> v .: "y_structure_lonely_null.json"
        <*> v .: "y_structure_lonely_string.json"
        <*> v .: "y_structure_lonely_true.json"
        <*> v .: "y_structure_string_empty.json"
        <*> v .: "y_structure_trailing_newline.json"
        <*> v .: "y_structure_true_in_array.json"
        <*> v .: "y_structure_whitespace_array.json"

instance ToJSON YArrayHeterogeneousJSON where
    toJSON (IntegerInYArrayHeterogeneousJSON x) = toJSON x
    toJSON (JSONInYArrayHeterogeneousJSON x) = toJSON x
    toJSON NullInYArrayHeterogeneousJSON = Null
    toJSON (StringInYArrayHeterogeneousJSON x) = toJSON x

instance FromJSON YArrayHeterogeneousJSON where
    parseJSON xs@(Number _) = (fmap IntegerInYArrayHeterogeneousJSON . parseJSON) xs
    parseJSON xs@(Object _) = (fmap JSONInYArrayHeterogeneousJSON . parseJSON) xs
    parseJSON Null = return NullInYArrayHeterogeneousJSON
    parseJSON xs@(String _) = (fmap StringInYArrayHeterogeneousJSON . parseJSON) xs

instance ToJSON JSON where
    toJSON = \_ -> emptyObject

instance FromJSON JSON where
    parseJSON (Object _) = return JSON

instance ToJSON YObjectBasicJSON where
    toJSON (YObjectBasicJSON asdYObjectBasicJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "asd" .= asdYObjectBasicJSON
        ]

instance FromJSON YObjectBasicJSON where
    parseJSON (Object v) = YObjectBasicJSON
        <$> v .: "asd"

instance ToJSON YObjectEmptyKeyJSON where
    toJSON (YObjectEmptyKeyJSON emptyYObjectEmptyKeyJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "" .= emptyYObjectEmptyKeyJSON
        ]

instance FromJSON YObjectEmptyKeyJSON where
    parseJSON (Object v) = YObjectEmptyKeyJSON
        <$> v .: ""

instance ToJSON YObjectEscapedNullInKeyJSON where
    toJSON (YObjectEscapedNullInKeyJSON fooBarYObjectEscapedNullInKeyJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "foo\x0000\&bar" .= fooBarYObjectEscapedNullInKeyJSON
        ]

instance FromJSON YObjectEscapedNullInKeyJSON where
    parseJSON (Object v) = YObjectEscapedNullInKeyJSON
        <$> v .: "foo\x0000\&bar"

instance ToJSON YObjectExtremeNumbersJSON where
    toJSON (YObjectExtremeNumbersJSON maxYObjectExtremeNumbersJSON minYObjectExtremeNumbersJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "max" .= maxYObjectExtremeNumbersJSON
        , Just $ "min" .= minYObjectExtremeNumbersJSON
        ]

instance FromJSON YObjectExtremeNumbersJSON where
    parseJSON (Object v) = YObjectExtremeNumbersJSON
        <$> v .: "max"
        <*> v .: "min"

instance ToJSON YObjectJSON where
    toJSON (YObjectJSON asdYObjectJSON dfgYObjectJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "asd" .= asdYObjectJSON
        , Just $ "dfg" .= dfgYObjectJSON
        ]

instance FromJSON YObjectJSON where
    parseJSON (Object v) = YObjectJSON
        <$> v .: "asd"
        <*> v .: "dfg"

instance ToJSON YObjectLongStringsJSON where
    toJSON (YObjectLongStringsJSON xYObjectLongStringsJSON yObjectLongStringsJSONIDYObjectLongStringsJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "x" .= xYObjectLongStringsJSON
        , Just $ "id" .= yObjectLongStringsJSONIDYObjectLongStringsJSON
        ]

instance FromJSON YObjectLongStringsJSON where
    parseJSON (Object v) = YObjectLongStringsJSON
        <$> v .: "x"
        <*> v .: "id"

instance ToJSON X where
    toJSON (X xIDX) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= xIDX
        ]

instance FromJSON X where
    parseJSON (Object v) = X
        <$> v .: "id"

instance ToJSON YObjectSimpleJSON where
    toJSON (YObjectSimpleJSON aYObjectSimpleJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "a" .= aYObjectSimpleJSON
        ]

instance FromJSON YObjectSimpleJSON where
    parseJSON (Object v) = YObjectSimpleJSON
        <$> v .: "a"

instance ToJSON YObjectStringUnicodeJSON where
    toJSON (YObjectStringUnicodeJSON titleYObjectStringUnicodeJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "title" .= titleYObjectStringUnicodeJSON
        ]

instance FromJSON YObjectStringUnicodeJSON where
    parseJSON (Object v) = YObjectStringUnicodeJSON
        <$> v .: "title"

instance ToJSON YObjectWithNewlinesJSON where
    toJSON (YObjectWithNewlinesJSON aYObjectWithNewlinesJSON) =
        object $ foldMap (maybe [] pure)
        [ Just $ "a" .= aYObjectWithNewlinesJSON
        ]

instance FromJSON YObjectWithNewlinesJSON where
    parseJSON (Object v) = YObjectWithNewlinesJSON
        <$> v .: "a"
