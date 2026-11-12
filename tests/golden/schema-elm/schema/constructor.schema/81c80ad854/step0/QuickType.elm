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
    , Constructor
    , UnionConstructor(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { constructor : Maybe UnionConstructor
    }

type UnionConstructor
    = ConstructorInUnionConstructor Constructor
    | DoubleInUnionConstructor Float

type alias Constructor =
    {
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
        |> Jpipe.custom (optionalField "constructor" (Jdec.map Just unionConstructor) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("constructor", makeNullableEncoder encodeUnionConstructor x.constructor)
        ]

unionConstructor : Jdec.Decoder UnionConstructor
unionConstructor =
    Jdec.oneOf
        [ Jdec.map DoubleInUnionConstructor Jdec.float
        , Jdec.map ConstructorInUnionConstructor constructor
        ]

encodeUnionConstructor : UnionConstructor -> Jenc.Value
encodeUnionConstructor x = case x of
    DoubleInUnionConstructor y -> Jenc.float y
    ConstructorInUnionConstructor y -> encodeConstructor y

constructor : Jdec.Decoder Constructor
constructor =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Constructor)

encodeConstructor : Constructor -> Jenc.Value
encodeConstructor x =
    Jenc.object
        [
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
