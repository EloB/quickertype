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
    { free : Float
    , intersection : Float
    , max : Float
    , min : Float
    , minmax : Float
    , minMaxIntersection : Float
    , minMaxUnion : Float
    , union : Float
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
        |> Jpipe.required "free" Jdec.float
        |> Jpipe.required "intersection" (Jdec.andThen (\x -> if x >= 4 && x <= 5 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)
        |> Jpipe.required "max" (Jdec.andThen (\x -> if True && x <= 5 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)
        |> Jpipe.required "min" (Jdec.andThen (\x -> if x >= 3 && True then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)
        |> Jpipe.required "minmax" (Jdec.andThen (\x -> if x >= 3 && x <= 5 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)
        |> Jpipe.required "minMaxIntersection" (Jdec.andThen (\x -> if x >= 3 && x <= 5 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)
        |> Jpipe.required "minMaxUnion" Jdec.float
        |> Jpipe.required "union" (Jdec.andThen (\x -> if x >= 3 && x <= 6 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("free", Jenc.float x.free)
        , ("intersection", Jenc.float x.intersection)
        , ("max", Jenc.float x.max)
        , ("min", Jenc.float x.min)
        , ("minmax", Jenc.float x.minmax)
        , ("minMaxIntersection", Jenc.float x.minMaxIntersection)
        , ("minMaxUnion", Jenc.float x.minMaxUnion)
        , ("union", Jenc.float x.union)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
