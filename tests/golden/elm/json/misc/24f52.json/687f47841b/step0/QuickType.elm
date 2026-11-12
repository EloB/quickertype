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
    , Status
    , Weather
    , Meta
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { city : String
    , delay : String
    , iata : String
    , icao : String
    , name : String
    , state : String
    , status : Status
    , weather : Weather
    }

type alias Status =
    { avgDelay : String
    , closureBegin : String
    , closureEnd : String
    , endTime : String
    , maxDelay : String
    , minDelay : String
    , reason : String
    , statusType : String
    , trend : String
    }

type alias Weather =
    { meta : Meta
    , temp : String
    , visibility : Float
    , weather : String
    , wind : String
    }

type alias Meta =
    { credit : String
    , updated : String
    , url : String
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
        |> Jpipe.required "city" Jdec.string
        |> Jpipe.required "delay" Jdec.string
        |> Jpipe.required "IATA" Jdec.string
        |> Jpipe.required "ICAO" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "state" Jdec.string
        |> Jpipe.required "status" status
        |> Jpipe.required "weather" weather

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("city", Jenc.string x.city)
        , ("delay", Jenc.string x.delay)
        , ("IATA", Jenc.string x.iata)
        , ("ICAO", Jenc.string x.icao)
        , ("name", Jenc.string x.name)
        , ("state", Jenc.string x.state)
        , ("status", encodeStatus x.status)
        , ("weather", encodeWeather x.weather)
        ]

status : Jdec.Decoder Status
status =
    Jdec.succeed Status
        |> Jpipe.required "avgDelay" Jdec.string
        |> Jpipe.required "closureBegin" Jdec.string
        |> Jpipe.required "closureEnd" Jdec.string
        |> Jpipe.required "endTime" Jdec.string
        |> Jpipe.required "maxDelay" Jdec.string
        |> Jpipe.required "minDelay" Jdec.string
        |> Jpipe.required "reason" Jdec.string
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "trend" Jdec.string

encodeStatus : Status -> Jenc.Value
encodeStatus x =
    Jenc.object
        [ ("avgDelay", Jenc.string x.avgDelay)
        , ("closureBegin", Jenc.string x.closureBegin)
        , ("closureEnd", Jenc.string x.closureEnd)
        , ("endTime", Jenc.string x.endTime)
        , ("maxDelay", Jenc.string x.maxDelay)
        , ("minDelay", Jenc.string x.minDelay)
        , ("reason", Jenc.string x.reason)
        , ("type", Jenc.string x.statusType)
        , ("trend", Jenc.string x.trend)
        ]

weather : Jdec.Decoder Weather
weather =
    Jdec.succeed Weather
        |> Jpipe.required "meta" meta
        |> Jpipe.required "temp" Jdec.string
        |> Jpipe.required "visibility" Jdec.float
        |> Jpipe.required "weather" Jdec.string
        |> Jpipe.required "wind" Jdec.string

encodeWeather : Weather -> Jenc.Value
encodeWeather x =
    Jenc.object
        [ ("meta", encodeMeta x.meta)
        , ("temp", Jenc.string x.temp)
        , ("visibility", Jenc.float x.visibility)
        , ("weather", Jenc.string x.weather)
        , ("wind", Jenc.string x.wind)
        ]

meta : Jdec.Decoder Meta
meta =
    Jdec.succeed Meta
        |> Jpipe.required "credit" Jdec.string
        |> Jpipe.required "updated" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeMeta : Meta -> Jenc.Value
encodeMeta x =
    Jenc.object
        [ ("credit", Jenc.string x.credit)
        , ("updated", Jenc.string x.updated)
        , ("url", Jenc.string x.url)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
