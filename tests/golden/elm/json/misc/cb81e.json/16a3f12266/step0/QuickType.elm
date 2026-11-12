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
    , Description
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { data : Dict String String
    , description : Description
    }

type alias Description =
    { basePeriod : String
    , missing : String
    , title : String
    , units : String
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
        |> Jpipe.required "data" (Jdec.dict Jdec.string)
        |> Jpipe.required "description" description

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("data", Jenc.dict identity Jenc.string x.data)
        , ("description", encodeDescription x.description)
        ]

description : Jdec.Decoder Description
description =
    Jdec.succeed Description
        |> Jpipe.required "base_period" Jdec.string
        |> Jpipe.required "missing" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "units" Jdec.string

encodeDescription : Description -> Jenc.Value
encodeDescription x =
    Jenc.object
        [ ("base_period", Jenc.string x.basePeriod)
        , ("missing", Jenc.string x.missing)
        , ("title", Jenc.string x.title)
        , ("units", Jenc.string x.units)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
