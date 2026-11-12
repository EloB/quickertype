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
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { aboveI32Max : Int
    , belowI32Min : Int
    , i32Range : Int
    , largeBounds : Int
    , onlyMaximum : Int
    , onlyMinimum : Int
    , smallNegative : Int
    , smallPositive : Int
    , unbounded : Int
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
        |> Jpipe.required "above_i32_max" (Jdec.andThen (\x -> if x >= 0 && x <= 2147483648 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "below_i32_min" (Jdec.andThen (\x -> if x >= -2147483649 && x <= 0 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "i32_range" (Jdec.andThen (\x -> if x >= -2147483648 && x <= 2147483647 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "large_bounds" (Jdec.andThen (\x -> if x >= -9007199254740991 && x <= 9007199254740991 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "only_maximum" (Jdec.andThen (\x -> if True && x <= 0 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "only_minimum" (Jdec.andThen (\x -> if x >= 0 && True then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "small_negative" (Jdec.andThen (\x -> if x >= -100 && x <= 0 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "small_positive" (Jdec.andThen (\x -> if x >= 0 && x <= 100 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "unbounded" Jdec.int

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("above_i32_max", Jenc.int x.aboveI32Max)
        , ("below_i32_min", Jenc.int x.belowI32Min)
        , ("i32_range", Jenc.int x.i32Range)
        , ("large_bounds", Jenc.int x.largeBounds)
        , ("only_maximum", Jenc.int x.onlyMaximum)
        , ("only_minimum", Jenc.int x.onlyMinimum)
        , ("small_negative", Jenc.int x.smallNegative)
        , ("small_positive", Jenc.int x.smallPositive)
        , ("unbounded", Jenc.int x.unbounded)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
