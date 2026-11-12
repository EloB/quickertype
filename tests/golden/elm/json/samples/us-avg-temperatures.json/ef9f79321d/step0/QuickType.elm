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
    , Datum
    , Description
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { data : Dict String Datum
    , description : Description
    }

type alias Datum =
    { anomaly : String
    , value : String
    }

type alias Description =
    { basePeriod : String
    , missing : Int
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
        |> Jpipe.required "data" (Jdec.dict datum)
        |> Jpipe.required "description" description

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("data", Jenc.dict identity encodeDatum x.data)
        , ("description", encodeDescription x.description)
        ]

datum : Jdec.Decoder Datum
datum =
    Jdec.succeed Datum
        |> Jpipe.required "anomaly" Jdec.string
        |> Jpipe.required "value" Jdec.string

encodeDatum : Datum -> Jenc.Value
encodeDatum x =
    Jenc.object
        [ ("anomaly", Jenc.string x.anomaly)
        , ("value", Jenc.string x.value)
        ]

description : Jdec.Decoder Description
description =
    Jdec.succeed Description
        |> Jpipe.required "base_period" Jdec.string
        |> Jpipe.required "missing" Jdec.int
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "units" Jdec.string

encodeDescription : Description -> Jenc.Value
encodeDescription x =
    Jenc.object
        [ ("base_period", Jenc.string x.basePeriod)
        , ("missing", Jenc.int x.missing)
        , ("title", Jenc.string x.title)
        , ("units", Jenc.string x.units)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
