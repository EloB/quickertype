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
    , UnionClass
    , UnionValue(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { union : Maybe (Dict String UnionValue)
    }

type UnionValue
    = BoolInUnionValue Bool
    | DoubleInUnionValue Float
    | StringInUnionValue String
    | UnionClassInUnionValue UnionClass

type alias UnionClass =
    { quux : Maybe Int
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
        |> Jpipe.custom (optionalField "union" (Jdec.map Just (Jdec.dict unionValue)) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("union", makeNullableEncoder (Jenc.dict identity encodeUnionValue) x.union)
        ]

unionValue : Jdec.Decoder UnionValue
unionValue =
    Jdec.oneOf
        [ Jdec.map BoolInUnionValue Jdec.bool
        , Jdec.map StringInUnionValue Jdec.string
        , Jdec.map DoubleInUnionValue Jdec.float
        , Jdec.map UnionClassInUnionValue unionClass
        ]

encodeUnionValue : UnionValue -> Jenc.Value
encodeUnionValue x = case x of
    BoolInUnionValue y -> Jenc.bool y
    StringInUnionValue y -> Jenc.string y
    DoubleInUnionValue y -> Jenc.float y
    UnionClassInUnionValue y -> encodeUnionClass y

unionClass : Jdec.Decoder UnionClass
unionClass =
    Jdec.succeed UnionClass
        |> Jpipe.custom (optionalField "quux" (Jdec.map Just Jdec.int) Nothing)

encodeUnionClass : UnionClass -> Jenc.Value
encodeUnionClass x =
    Jenc.object
        [ ("quux", makeNullableEncoder Jenc.int x.quux)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
