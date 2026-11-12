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
    , PC
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { pc : PC
    , ps3 : PC
    , ps4 : PC
    , xbox : PC
    , xone : PC
    }

type alias PC =
    { count : Int
    , label : String
    , peak24 : Int
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
        |> Jpipe.required "pc" pc
        |> Jpipe.required "ps3" pc
        |> Jpipe.required "ps4" pc
        |> Jpipe.required "xbox" pc
        |> Jpipe.required "xone" pc

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("pc", encodePC x.pc)
        , ("ps3", encodePC x.ps3)
        , ("ps4", encodePC x.ps4)
        , ("xbox", encodePC x.xbox)
        , ("xone", encodePC x.xone)
        ]

pc : Jdec.Decoder PC
pc =
    Jdec.succeed PC
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "label" Jdec.string
        |> Jpipe.required "peak24" Jdec.int

encodePC : PC -> Jenc.Value
encodePC x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("label", Jenc.string x.label)
        , ("peak24", Jenc.int x.peak24)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
