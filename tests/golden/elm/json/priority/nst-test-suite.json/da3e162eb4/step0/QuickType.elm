-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , JSON
    , YObjectBasicJSON
    , YObjectEmptyKeyJSON
    , YObjectEscapedNullInKeyJSON
    , YObjectExtremeNumbersJSON
    , YObjectJSON
    , YObjectLongStringsJSON
    , X
    , YObjectSimpleJSON
    , YObjectStringUnicodeJSON
    , YObjectWithNewlinesJSON
    , YArrayHeterogeneousJSON(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { quickTypeYNumber0E1JSON : List Float
    , yArrayArraysWithSpacesJSON : List (List Jdec.Value)
    , yArrayEmptyJSON : List Jdec.Value
    , yArrayEmptyStringJSON : List String
    , yArrayEndingWithNewlineJSON : List String
    , yArrayFalseJSON : List Bool
    , yArrayHeterogeneousJSON : List YArrayHeterogeneousJSON
    , yArrayNullJSON : List ()
    , yArrayWith1_AndNewlineJSON : List Int
    , yArrayWithLeadingSpaceJSON : List Int
    , yArrayWithSeveralNullJSON : List (Maybe Int)
    , yArrayWithTrailingSpaceJSON : List Int
    , yNumber0E1JSON : List Float
    , yNumberAfterSpaceJSON : List Int
    , yNumberDoubleCloseToZeroJSON : List Float
    , yNumberIntWithExpJSON : List Float
    , yNumberJSON : List Float
    , yNumberMinusZeroJSON : List Int
    , yNumberNegativeIntJSON : List Int
    , yNumberNegativeOneJSON : List Int
    , yNumberNegativeZeroJSON : List Int
    , yNumberRealCapitalEJSON : List Float
    , yNumberRealCapitalENegExpJSON : List Float
    , yNumberRealCapitalEPosExpJSON : List Float
    , yNumberRealExponentJSON : List Float
    , yNumberRealFractionExponentJSON : List Float
    , yNumberRealNegExpJSON : List Float
    , yNumberRealPosExponentJSON : List Float
    , yNumberSimpleIntJSON : List Int
    , yNumberSimpleRealJSON : List Float
    , yObjectBasicJSON : YObjectBasicJSON
    , yObjectEmptyJSON : JSON
    , yObjectEmptyKeyJSON : YObjectEmptyKeyJSON
    , yObjectEscapedNullInKeyJSON : YObjectEscapedNullInKeyJSON
    , yObjectExtremeNumbersJSON : YObjectExtremeNumbersJSON
    , yObjectJSON : YObjectJSON
    , yObjectLongStringsJSON : YObjectLongStringsJSON
    , yObjectSimpleJSON : YObjectSimpleJSON
    , yObjectStringUnicodeJSON : YObjectStringUnicodeJSON
    , yObjectWithNewlinesJSON : YObjectWithNewlinesJSON
    , yString1_2_3_BytesUTF8_SequencesJSON : List String
    , yStringAcceptedSurrogatePairJSON : List String
    , yStringAcceptedSurrogatePairsJSON : List String
    , yStringAllowedEscapesJSON : List String
    , yStringBackslashAndUEscapedZeroJSON : List String
    , yStringBackslashDoublequotesJSON : List String
    , yStringCommentsJSON : List String
    , yStringDoubleEscapeAJSON : List String
    , yStringDoubleEscapeNJSON : List String
    , yStringEscapedControlCharacterJSON : List String
    , yStringEscapedNoncharacterJSON : List String
    , yStringInArrayJSON : List String
    , yStringInArrayWithLeadingSpaceJSON : List String
    , yStringLastSurrogates1_And2JSON : List String
    , yStringNbspUescapedJSON : List String
    , yStringNonCharacterInUTF8_U10FFFFJSON : List String
    , yStringNonCharacterInUTF8_U1FFFFJSON : List String
    , yStringNonCharacterInUTF8_UFFFFJSON : List String
    , yStringNullEscapeJSON : List String
    , yStringOneByteUTF8JSON : List String
    , yStringPiJSON : List String
    , yStringSimpleASCIIJSON : List String
    , yStringSpaceJSON : String
    , yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON : List String
    , yStringThreeByteUTF8JSON : List String
    , yStringTwoByteUTF8JSON : List String
    , yStringU2028_LineSepJSON : List String
    , yStringU2029_ParSepJSON : List String
    , yStringUEscapeJSON : List String
    , yStringUescapedNewlineJSON : List String
    , yStringUnescapedCharDeleteJSON : List String
    , yStringUnicode2JSON : List String
    , yStringUnicodeEscapedBackslashJSON : List String
    , yStringUnicodeEscapedDoubleQuoteJSON : List String
    , yStringUnicodeJSON : List String
    , yStringUnicodeU10FFFENoncharJSON : List String
    , yStringUnicodeU1FFFENoncharJSON : List String
    , yStringUnicodeU200BZEROWIDTHSPACEJSON : List String
    , yStringUnicodeU2064_InvisiblePlusJSON : List String
    , yStringUnicodeUFDD0NoncharJSON : List String
    , yStringUnicodeUFFFENoncharJSON : List String
    , yStringUtf8JSON : List String
    , yStringWithDelCharacterJSON : List String
    , yStructureLonelyFalseJSON : Bool
    , yStructureLonelyIntJSON : Int
    , yStructureLonelyNegativeRealJSON : Float
    , yStructureLonelyNullJSON : ()
    , yStructureLonelyStringJSON : String
    , yStructureLonelyTrueJSON : Bool
    , yStructureStringEmptyJSON : String
    , yStructureTrailingNewlineJSON : List String
    , yStructureTrueInArrayJSON : List Bool
    , yStructureWhitespaceArrayJSON : List Jdec.Value
    }

type YArrayHeterogeneousJSON
    = IntegerInYArrayHeterogeneousJSON Int
    | JSONInYArrayHeterogeneousJSON JSON
    | NullInYArrayHeterogeneousJSON
    | StringInYArrayHeterogeneousJSON String

type alias JSON =
    {
    }

type alias YObjectBasicJSON =
    { asd : String
    }

type alias YObjectEmptyKeyJSON =
    { empty : Int
    }

type alias YObjectEscapedNullInKeyJSON =
    { fooBar : Int
    }

type alias YObjectExtremeNumbersJSON =
    { max : Float
    , min : Float
    }

type alias YObjectJSON =
    { asd : String
    , dfg : String
    }

type alias YObjectLongStringsJSON =
    { id : String
    , yObjectLongStringsJSONX : List X
    }

type alias X =
    { id : String
    }

type alias YObjectSimpleJSON =
    { a : List Jdec.Value
    }

type alias YObjectStringUnicodeJSON =
    { title : String
    }

type alias YObjectWithNewlinesJSON =
    { a : String
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (encodeQuickType r)

quickType : Jdec.Decoder QuickType
quickType =
    Jdec.succeed QuickType
        |> Jpipe.required "y_number_0e1.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_array_arraysWithSpaces.json" (Jdec.list (Jdec.list Jdec.value ) )
        |> Jpipe.required "y_array_empty.json" (Jdec.list Jdec.value )
        |> Jpipe.required "y_array_empty-string.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_array_ending_with_newline.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_array_false.json" (Jdec.list Jdec.bool )
        |> Jpipe.required "y_array_heterogeneous.json" (Jdec.list yArrayHeterogeneousJSON )
        |> Jpipe.required "y_array_null.json" (Jdec.list (Jdec.null ()) )
        |> Jpipe.required "y_array_with_1_and_newline.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_array_with_leading_space.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_array_with_several_null.json" (Jdec.list (Jdec.nullable Jdec.int) )
        |> Jpipe.required "y_array_with_trailing_space.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_number_0e+1.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_after_space.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_number_double_close_to_zero.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_int_with_exp.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_minus_zero.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_number_negative_int.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_number_negative_one.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_number_negative_zero.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_number_real_capital_e.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_real_capital_e_neg_exp.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_real_capital_e_pos_exp.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_real_exponent.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_real_fraction_exponent.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_real_neg_exp.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_real_pos_exponent.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_number_simple_int.json" (Jdec.list Jdec.int )
        |> Jpipe.required "y_number_simple_real.json" (Jdec.list Jdec.float )
        |> Jpipe.required "y_object_basic.json" yObjectBasicJSON
        |> Jpipe.required "y_object_empty.json" json
        |> Jpipe.required "y_object_empty_key.json" yObjectEmptyKeyJSON
        |> Jpipe.required "y_object_escaped_null_in_key.json" yObjectEscapedNullInKeyJSON
        |> Jpipe.required "y_object_extreme_numbers.json" yObjectExtremeNumbersJSON
        |> Jpipe.required "y_object.json" yObjectJSON
        |> Jpipe.required "y_object_long_strings.json" yObjectLongStringsJSON
        |> Jpipe.required "y_object_simple.json" yObjectSimpleJSON
        |> Jpipe.required "y_object_string_unicode.json" yObjectStringUnicodeJSON
        |> Jpipe.required "y_object_with_newlines.json" yObjectWithNewlinesJSON
        |> Jpipe.required "y_string_1_2_3_bytes_UTF-8_sequences.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_accepted_surrogate_pair.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_accepted_surrogate_pairs.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_allowed_escapes.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_backslash_and_u_escaped_zero.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_backslash_doublequotes.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_comments.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_double_escape_a.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_double_escape_n.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_escaped_control_character.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_escaped_noncharacter.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_in_array.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_in_array_with_leading_space.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_last_surrogates_1_and_2.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_nbsp_uescaped.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_nonCharacterInUTF-8_U+10FFFF.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_nonCharacterInUTF-8_U+1FFFF.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_nonCharacterInUTF-8_U+FFFF.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_null_escape.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_one-byte-utf-8.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_pi.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_simple_ascii.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_space.json" Jdec.string
        |> Jpipe.required "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_three-byte-utf-8.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_two-byte-utf-8.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_u+2028_line_sep.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_u+2029_par_sep.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_uEscape.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_uescaped_newline.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unescaped_char_delete.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_2.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicodeEscapedBackslash.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_escaped_double_quote.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_U+10FFFE_nonchar.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_U+1FFFE_nonchar.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_U+2064_invisible_plus.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_U+FDD0_nonchar.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_unicode_U+FFFE_nonchar.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_utf8.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_string_with_del_character.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_structure_lonely_false.json" Jdec.bool
        |> Jpipe.required "y_structure_lonely_int.json" Jdec.int
        |> Jpipe.required "y_structure_lonely_negative_real.json" Jdec.float
        |> Jpipe.required "y_structure_lonely_null.json" (Jdec.null ())
        |> Jpipe.required "y_structure_lonely_string.json" Jdec.string
        |> Jpipe.required "y_structure_lonely_true.json" Jdec.bool
        |> Jpipe.required "y_structure_string_empty.json" Jdec.string
        |> Jpipe.required "y_structure_trailing_newline.json" (Jdec.list Jdec.string )
        |> Jpipe.required "y_structure_true_in_array.json" (Jdec.list Jdec.bool )
        |> Jpipe.required "y_structure_whitespace_array.json" (Jdec.list Jdec.value )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("y_number_0e1.json", Jenc.list Jenc.float x.quickTypeYNumber0E1JSON)
        , ("y_array_arraysWithSpaces.json", Jenc.list (Jenc.list identity) x.yArrayArraysWithSpacesJSON)
        , ("y_array_empty.json", Jenc.list identity x.yArrayEmptyJSON)
        , ("y_array_empty-string.json", Jenc.list Jenc.string x.yArrayEmptyStringJSON)
        , ("y_array_ending_with_newline.json", Jenc.list Jenc.string x.yArrayEndingWithNewlineJSON)
        , ("y_array_false.json", Jenc.list Jenc.bool x.yArrayFalseJSON)
        , ("y_array_heterogeneous.json", Jenc.list encodeYArrayHeterogeneousJSON x.yArrayHeterogeneousJSON)
        , ("y_array_null.json", Jenc.list (always Jenc.null) x.yArrayNullJSON)
        , ("y_array_with_1_and_newline.json", Jenc.list Jenc.int x.yArrayWith1_AndNewlineJSON)
        , ("y_array_with_leading_space.json", Jenc.list Jenc.int x.yArrayWithLeadingSpaceJSON)
        , ("y_array_with_several_null.json", Jenc.list (makeNullableEncoder Jenc.int) x.yArrayWithSeveralNullJSON)
        , ("y_array_with_trailing_space.json", Jenc.list Jenc.int x.yArrayWithTrailingSpaceJSON)
        , ("y_number_0e+1.json", Jenc.list Jenc.float x.yNumber0E1JSON)
        , ("y_number_after_space.json", Jenc.list Jenc.int x.yNumberAfterSpaceJSON)
        , ("y_number_double_close_to_zero.json", Jenc.list Jenc.float x.yNumberDoubleCloseToZeroJSON)
        , ("y_number_int_with_exp.json", Jenc.list Jenc.float x.yNumberIntWithExpJSON)
        , ("y_number.json", Jenc.list Jenc.float x.yNumberJSON)
        , ("y_number_minus_zero.json", Jenc.list Jenc.int x.yNumberMinusZeroJSON)
        , ("y_number_negative_int.json", Jenc.list Jenc.int x.yNumberNegativeIntJSON)
        , ("y_number_negative_one.json", Jenc.list Jenc.int x.yNumberNegativeOneJSON)
        , ("y_number_negative_zero.json", Jenc.list Jenc.int x.yNumberNegativeZeroJSON)
        , ("y_number_real_capital_e.json", Jenc.list Jenc.float x.yNumberRealCapitalEJSON)
        , ("y_number_real_capital_e_neg_exp.json", Jenc.list Jenc.float x.yNumberRealCapitalENegExpJSON)
        , ("y_number_real_capital_e_pos_exp.json", Jenc.list Jenc.float x.yNumberRealCapitalEPosExpJSON)
        , ("y_number_real_exponent.json", Jenc.list Jenc.float x.yNumberRealExponentJSON)
        , ("y_number_real_fraction_exponent.json", Jenc.list Jenc.float x.yNumberRealFractionExponentJSON)
        , ("y_number_real_neg_exp.json", Jenc.list Jenc.float x.yNumberRealNegExpJSON)
        , ("y_number_real_pos_exponent.json", Jenc.list Jenc.float x.yNumberRealPosExponentJSON)
        , ("y_number_simple_int.json", Jenc.list Jenc.int x.yNumberSimpleIntJSON)
        , ("y_number_simple_real.json", Jenc.list Jenc.float x.yNumberSimpleRealJSON)
        , ("y_object_basic.json", encodeYObjectBasicJSON x.yObjectBasicJSON)
        , ("y_object_empty.json", encodeJSON x.yObjectEmptyJSON)
        , ("y_object_empty_key.json", encodeYObjectEmptyKeyJSON x.yObjectEmptyKeyJSON)
        , ("y_object_escaped_null_in_key.json", encodeYObjectEscapedNullInKeyJSON x.yObjectEscapedNullInKeyJSON)
        , ("y_object_extreme_numbers.json", encodeYObjectExtremeNumbersJSON x.yObjectExtremeNumbersJSON)
        , ("y_object.json", encodeYObjectJSON x.yObjectJSON)
        , ("y_object_long_strings.json", encodeYObjectLongStringsJSON x.yObjectLongStringsJSON)
        , ("y_object_simple.json", encodeYObjectSimpleJSON x.yObjectSimpleJSON)
        , ("y_object_string_unicode.json", encodeYObjectStringUnicodeJSON x.yObjectStringUnicodeJSON)
        , ("y_object_with_newlines.json", encodeYObjectWithNewlinesJSON x.yObjectWithNewlinesJSON)
        , ("y_string_1_2_3_bytes_UTF-8_sequences.json", Jenc.list Jenc.string x.yString1_2_3_BytesUTF8_SequencesJSON)
        , ("y_string_accepted_surrogate_pair.json", Jenc.list Jenc.string x.yStringAcceptedSurrogatePairJSON)
        , ("y_string_accepted_surrogate_pairs.json", Jenc.list Jenc.string x.yStringAcceptedSurrogatePairsJSON)
        , ("y_string_allowed_escapes.json", Jenc.list Jenc.string x.yStringAllowedEscapesJSON)
        , ("y_string_backslash_and_u_escaped_zero.json", Jenc.list Jenc.string x.yStringBackslashAndUEscapedZeroJSON)
        , ("y_string_backslash_doublequotes.json", Jenc.list Jenc.string x.yStringBackslashDoublequotesJSON)
        , ("y_string_comments.json", Jenc.list Jenc.string x.yStringCommentsJSON)
        , ("y_string_double_escape_a.json", Jenc.list Jenc.string x.yStringDoubleEscapeAJSON)
        , ("y_string_double_escape_n.json", Jenc.list Jenc.string x.yStringDoubleEscapeNJSON)
        , ("y_string_escaped_control_character.json", Jenc.list Jenc.string x.yStringEscapedControlCharacterJSON)
        , ("y_string_escaped_noncharacter.json", Jenc.list Jenc.string x.yStringEscapedNoncharacterJSON)
        , ("y_string_in_array.json", Jenc.list Jenc.string x.yStringInArrayJSON)
        , ("y_string_in_array_with_leading_space.json", Jenc.list Jenc.string x.yStringInArrayWithLeadingSpaceJSON)
        , ("y_string_last_surrogates_1_and_2.json", Jenc.list Jenc.string x.yStringLastSurrogates1_And2JSON)
        , ("y_string_nbsp_uescaped.json", Jenc.list Jenc.string x.yStringNbspUescapedJSON)
        , ("y_string_nonCharacterInUTF-8_U+10FFFF.json", Jenc.list Jenc.string x.yStringNonCharacterInUTF8_U10FFFFJSON)
        , ("y_string_nonCharacterInUTF-8_U+1FFFF.json", Jenc.list Jenc.string x.yStringNonCharacterInUTF8_U1FFFFJSON)
        , ("y_string_nonCharacterInUTF-8_U+FFFF.json", Jenc.list Jenc.string x.yStringNonCharacterInUTF8_UFFFFJSON)
        , ("y_string_null_escape.json", Jenc.list Jenc.string x.yStringNullEscapeJSON)
        , ("y_string_one-byte-utf-8.json", Jenc.list Jenc.string x.yStringOneByteUTF8JSON)
        , ("y_string_pi.json", Jenc.list Jenc.string x.yStringPiJSON)
        , ("y_string_simple_ascii.json", Jenc.list Jenc.string x.yStringSimpleASCIIJSON)
        , ("y_string_space.json", Jenc.string x.yStringSpaceJSON)
        , ("y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json", Jenc.list Jenc.string x.yStringSurrogatesU1D11EMUSICALSYMBOLGCLEFJSON)
        , ("y_string_three-byte-utf-8.json", Jenc.list Jenc.string x.yStringThreeByteUTF8JSON)
        , ("y_string_two-byte-utf-8.json", Jenc.list Jenc.string x.yStringTwoByteUTF8JSON)
        , ("y_string_u+2028_line_sep.json", Jenc.list Jenc.string x.yStringU2028_LineSepJSON)
        , ("y_string_u+2029_par_sep.json", Jenc.list Jenc.string x.yStringU2029_ParSepJSON)
        , ("y_string_uEscape.json", Jenc.list Jenc.string x.yStringUEscapeJSON)
        , ("y_string_uescaped_newline.json", Jenc.list Jenc.string x.yStringUescapedNewlineJSON)
        , ("y_string_unescaped_char_delete.json", Jenc.list Jenc.string x.yStringUnescapedCharDeleteJSON)
        , ("y_string_unicode_2.json", Jenc.list Jenc.string x.yStringUnicode2JSON)
        , ("y_string_unicodeEscapedBackslash.json", Jenc.list Jenc.string x.yStringUnicodeEscapedBackslashJSON)
        , ("y_string_unicode_escaped_double_quote.json", Jenc.list Jenc.string x.yStringUnicodeEscapedDoubleQuoteJSON)
        , ("y_string_unicode.json", Jenc.list Jenc.string x.yStringUnicodeJSON)
        , ("y_string_unicode_U+10FFFE_nonchar.json", Jenc.list Jenc.string x.yStringUnicodeU10FFFENoncharJSON)
        , ("y_string_unicode_U+1FFFE_nonchar.json", Jenc.list Jenc.string x.yStringUnicodeU1FFFENoncharJSON)
        , ("y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json", Jenc.list Jenc.string x.yStringUnicodeU200BZEROWIDTHSPACEJSON)
        , ("y_string_unicode_U+2064_invisible_plus.json", Jenc.list Jenc.string x.yStringUnicodeU2064_InvisiblePlusJSON)
        , ("y_string_unicode_U+FDD0_nonchar.json", Jenc.list Jenc.string x.yStringUnicodeUFDD0NoncharJSON)
        , ("y_string_unicode_U+FFFE_nonchar.json", Jenc.list Jenc.string x.yStringUnicodeUFFFENoncharJSON)
        , ("y_string_utf8.json", Jenc.list Jenc.string x.yStringUtf8JSON)
        , ("y_string_with_del_character.json", Jenc.list Jenc.string x.yStringWithDelCharacterJSON)
        , ("y_structure_lonely_false.json", Jenc.bool x.yStructureLonelyFalseJSON)
        , ("y_structure_lonely_int.json", Jenc.int x.yStructureLonelyIntJSON)
        , ("y_structure_lonely_negative_real.json", Jenc.float x.yStructureLonelyNegativeRealJSON)
        , ("y_structure_lonely_null.json", always Jenc.null x.yStructureLonelyNullJSON)
        , ("y_structure_lonely_string.json", Jenc.string x.yStructureLonelyStringJSON)
        , ("y_structure_lonely_true.json", Jenc.bool x.yStructureLonelyTrueJSON)
        , ("y_structure_string_empty.json", Jenc.string x.yStructureStringEmptyJSON)
        , ("y_structure_trailing_newline.json", Jenc.list Jenc.string x.yStructureTrailingNewlineJSON)
        , ("y_structure_true_in_array.json", Jenc.list Jenc.bool x.yStructureTrueInArrayJSON)
        , ("y_structure_whitespace_array.json", Jenc.list identity x.yStructureWhitespaceArrayJSON)
        ]

yArrayHeterogeneousJSON : Jdec.Decoder YArrayHeterogeneousJSON
yArrayHeterogeneousJSON =
    Jdec.oneOf
        [ Jdec.map IntegerInYArrayHeterogeneousJSON Jdec.int
        , Jdec.null NullInYArrayHeterogeneousJSON
        , Jdec.map StringInYArrayHeterogeneousJSON Jdec.string
        , Jdec.map JSONInYArrayHeterogeneousJSON json
        ]

encodeYArrayHeterogeneousJSON : YArrayHeterogeneousJSON -> Jenc.Value
encodeYArrayHeterogeneousJSON x = case x of
    IntegerInYArrayHeterogeneousJSON y -> Jenc.int y
    NullInYArrayHeterogeneousJSON -> Jenc.null
    StringInYArrayHeterogeneousJSON y -> Jenc.string y
    JSONInYArrayHeterogeneousJSON y -> encodeJSON y

json : Jdec.Decoder JSON
json =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> JSON)

encodeJSON : JSON -> Jenc.Value
encodeJSON x =
    Jenc.object
        [
        ]

yObjectBasicJSON : Jdec.Decoder YObjectBasicJSON
yObjectBasicJSON =
    Jdec.succeed YObjectBasicJSON
        |> Jpipe.required "asd" Jdec.string

encodeYObjectBasicJSON : YObjectBasicJSON -> Jenc.Value
encodeYObjectBasicJSON x =
    Jenc.object
        [ ("asd", Jenc.string x.asd)
        ]

yObjectEmptyKeyJSON : Jdec.Decoder YObjectEmptyKeyJSON
yObjectEmptyKeyJSON =
    Jdec.succeed YObjectEmptyKeyJSON
        |> Jpipe.required "" Jdec.int

encodeYObjectEmptyKeyJSON : YObjectEmptyKeyJSON -> Jenc.Value
encodeYObjectEmptyKeyJSON x =
    Jenc.object
        [ ("", Jenc.int x.empty)
        ]

yObjectEscapedNullInKeyJSON : Jdec.Decoder YObjectEscapedNullInKeyJSON
yObjectEscapedNullInKeyJSON =
    Jdec.succeed YObjectEscapedNullInKeyJSON
        |> Jpipe.required "foo\u{0000}bar" Jdec.int

encodeYObjectEscapedNullInKeyJSON : YObjectEscapedNullInKeyJSON -> Jenc.Value
encodeYObjectEscapedNullInKeyJSON x =
    Jenc.object
        [ ("foo\u{0000}bar", Jenc.int x.fooBar)
        ]

yObjectExtremeNumbersJSON : Jdec.Decoder YObjectExtremeNumbersJSON
yObjectExtremeNumbersJSON =
    Jdec.succeed YObjectExtremeNumbersJSON
        |> Jpipe.required "max" Jdec.float
        |> Jpipe.required "min" Jdec.float

encodeYObjectExtremeNumbersJSON : YObjectExtremeNumbersJSON -> Jenc.Value
encodeYObjectExtremeNumbersJSON x =
    Jenc.object
        [ ("max", Jenc.float x.max)
        , ("min", Jenc.float x.min)
        ]

yObjectJSON : Jdec.Decoder YObjectJSON
yObjectJSON =
    Jdec.succeed YObjectJSON
        |> Jpipe.required "asd" Jdec.string
        |> Jpipe.required "dfg" Jdec.string

encodeYObjectJSON : YObjectJSON -> Jenc.Value
encodeYObjectJSON x =
    Jenc.object
        [ ("asd", Jenc.string x.asd)
        , ("dfg", Jenc.string x.dfg)
        ]

yObjectLongStringsJSON : Jdec.Decoder YObjectLongStringsJSON
yObjectLongStringsJSON =
    Jdec.succeed YObjectLongStringsJSON
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "x" (Jdec.list purpleX )

encodeYObjectLongStringsJSON : YObjectLongStringsJSON -> Jenc.Value
encodeYObjectLongStringsJSON x =
    Jenc.object
        [ ("id", Jenc.string x.id)
        , ("x", Jenc.list encodeX x.yObjectLongStringsJSONX)
        ]

purpleX : Jdec.Decoder X
purpleX =
    Jdec.succeed X
        |> Jpipe.required "id" Jdec.string

encodeX : X -> Jenc.Value
encodeX x =
    Jenc.object
        [ ("id", Jenc.string x.id)
        ]

yObjectSimpleJSON : Jdec.Decoder YObjectSimpleJSON
yObjectSimpleJSON =
    Jdec.succeed YObjectSimpleJSON
        |> Jpipe.required "a" (Jdec.list Jdec.value )

encodeYObjectSimpleJSON : YObjectSimpleJSON -> Jenc.Value
encodeYObjectSimpleJSON x =
    Jenc.object
        [ ("a", Jenc.list identity x.a)
        ]

yObjectStringUnicodeJSON : Jdec.Decoder YObjectStringUnicodeJSON
yObjectStringUnicodeJSON =
    Jdec.succeed YObjectStringUnicodeJSON
        |> Jpipe.required "title" Jdec.string

encodeYObjectStringUnicodeJSON : YObjectStringUnicodeJSON -> Jenc.Value
encodeYObjectStringUnicodeJSON x =
    Jenc.object
        [ ("title", Jenc.string x.title)
        ]

yObjectWithNewlinesJSON : Jdec.Decoder YObjectWithNewlinesJSON
yObjectWithNewlinesJSON =
    Jdec.succeed YObjectWithNewlinesJSON
        |> Jpipe.required "a" Jdec.string

encodeYObjectWithNewlinesJSON : YObjectWithNewlinesJSON -> Jenc.Value
encodeYObjectWithNewlinesJSON x =
    Jenc.object
        [ ("a", Jenc.string x.a)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
