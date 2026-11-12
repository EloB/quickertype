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
    , Value(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { value : Value
    }

type Value
    = DoubleInValue Float
    | IntegerInValue Int
    | StringInValue String

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
        |> Jpipe.required "value" value

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("value", encodeValue x.value)
        ]

value : Jdec.Decoder Value
value =
    Jdec.oneOf
        [ Jdec.map IntegerInValue Jdec.int
        , Jdec.map StringInValue Jdec.string
        , Jdec.map DoubleInValue Jdec.float
        ]

encodeValue : Value -> Jenc.Value
encodeValue x = case x of
    IntegerInValue y -> Jenc.int y
    StringInValue y -> Jenc.string y
    DoubleInValue y -> Jenc.float y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
