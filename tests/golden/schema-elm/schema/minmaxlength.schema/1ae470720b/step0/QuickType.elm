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
    , InUnion(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { intersection : String
    , inUnion : InUnion
    , maxlength : String
    , minlength : String
    , minMaxIntersection : String
    , minmaxlength : String
    , minMaxUnion : String
    , union : String
    }

type InUnion
    = DoubleInInUnion Float
    | StringInInUnion String

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
        |> Jpipe.required "intersection" (Jdec.andThen (\x -> if List.length (String.toList x) >= 4 && List.length (String.toList x) <= 5 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.required "inUnion" inUnion
        |> Jpipe.required "maxlength" (Jdec.andThen (\x -> if True && List.length (String.toList x) <= 5 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.required "minlength" (Jdec.andThen (\x -> if List.length (String.toList x) >= 3 && True then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.required "minMaxIntersection" (Jdec.andThen (\x -> if List.length (String.toList x) >= 3 && List.length (String.toList x) <= 5 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.required "minmaxlength" (Jdec.andThen (\x -> if List.length (String.toList x) >= 3 && List.length (String.toList x) <= 5 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.required "minMaxUnion" Jdec.string
        |> Jpipe.required "union" (Jdec.andThen (\x -> if List.length (String.toList x) >= 3 && List.length (String.toList x) <= 6 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("intersection", Jenc.string x.intersection)
        , ("inUnion", encodeInUnion x.inUnion)
        , ("maxlength", Jenc.string x.maxlength)
        , ("minlength", Jenc.string x.minlength)
        , ("minMaxIntersection", Jenc.string x.minMaxIntersection)
        , ("minmaxlength", Jenc.string x.minmaxlength)
        , ("minMaxUnion", Jenc.string x.minMaxUnion)
        , ("union", Jenc.string x.union)
        ]

inUnion : Jdec.Decoder InUnion
inUnion =
    Jdec.oneOf
        [ Jdec.map StringInInUnion (Jdec.andThen (\x -> if List.length (String.toList x) >= 3 && List.length (String.toList x) <= 5 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        , Jdec.map DoubleInInUnion Jdec.float
        ]

encodeInUnion : InUnion -> Jenc.Value
encodeInUnion x = case x of
    StringInInUnion y -> Jenc.string y
    DoubleInInUnion y -> Jenc.float y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
