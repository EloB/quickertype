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
    , MixedClass
    , MixedElement(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { mixed : List MixedElement
    }

type MixedElement
    = BoolInMixedElement Bool
    | IntegerInMixedElement Int
    | MixedClassInMixedElement MixedClass
    | NullInMixedElement
    | StringInMixedElement String

type alias MixedClass =
    { nested : String
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
        |> Jpipe.required "mixed" (Jdec.list mixedElement )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("mixed", Jenc.list encodeMixedElement x.mixed)
        ]

mixedElement : Jdec.Decoder MixedElement
mixedElement =
    Jdec.oneOf
        [ Jdec.map BoolInMixedElement Jdec.bool
        , Jdec.map IntegerInMixedElement Jdec.int
        , Jdec.null NullInMixedElement
        , Jdec.map StringInMixedElement Jdec.string
        , Jdec.map MixedClassInMixedElement mixedClass
        ]

encodeMixedElement : MixedElement -> Jenc.Value
encodeMixedElement x = case x of
    BoolInMixedElement y -> Jenc.bool y
    IntegerInMixedElement y -> Jenc.int y
    NullInMixedElement -> Jenc.null
    StringInMixedElement y -> Jenc.string y
    MixedClassInMixedElement y -> encodeMixedClass y

mixedClass : Jdec.Decoder MixedClass
mixedClass =
    Jdec.succeed MixedClass
        |> Jpipe.required "nested" Jdec.string

encodeMixedClass : MixedClass -> Jenc.Value
encodeMixedClass x =
    Jenc.object
        [ ("nested", Jenc.string x.nested)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
