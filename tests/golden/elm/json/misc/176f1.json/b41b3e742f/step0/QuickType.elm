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
    , Results
    , Series
    , Datum
    , Footnote
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { message : List Jdec.Value
    , responseTime : Int
    , results : Results
    , status : String
    }

type alias Results =
    { series : List Series
    }

type alias Series =
    { data : List Datum
    , seriesID : String
    }

type alias Datum =
    { footnotes : List Footnote
    , period : String
    , periodName : String
    , value : String
    , year : String
    }

type alias Footnote =
    { code : Maybe String
    , text : Maybe String
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
        |> Jpipe.required "message" (Jdec.list Jdec.value )
        |> Jpipe.required "responseTime" Jdec.int
        |> Jpipe.required "Results" results
        |> Jpipe.required "status" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("message", Jenc.list identity x.message)
        , ("responseTime", Jenc.int x.responseTime)
        , ("Results", encodeResults x.results)
        , ("status", Jenc.string x.status)
        ]

results : Jdec.Decoder Results
results =
    Jdec.succeed Results
        |> Jpipe.required "series" (Jdec.list series )

encodeResults : Results -> Jenc.Value
encodeResults x =
    Jenc.object
        [ ("series", Jenc.list encodeSeries x.series)
        ]

series : Jdec.Decoder Series
series =
    Jdec.succeed Series
        |> Jpipe.required "data" (Jdec.list datum )
        |> Jpipe.required "seriesID" Jdec.string

encodeSeries : Series -> Jenc.Value
encodeSeries x =
    Jenc.object
        [ ("data", Jenc.list encodeDatum x.data)
        , ("seriesID", Jenc.string x.seriesID)
        ]

datum : Jdec.Decoder Datum
datum =
    Jdec.succeed Datum
        |> Jpipe.required "footnotes" (Jdec.list footnote )
        |> Jpipe.required "period" Jdec.string
        |> Jpipe.required "periodName" Jdec.string
        |> Jpipe.required "value" Jdec.string
        |> Jpipe.required "year" Jdec.string

encodeDatum : Datum -> Jenc.Value
encodeDatum x =
    Jenc.object
        [ ("footnotes", Jenc.list encodeFootnote x.footnotes)
        , ("period", Jenc.string x.period)
        , ("periodName", Jenc.string x.periodName)
        , ("value", Jenc.string x.value)
        , ("year", Jenc.string x.year)
        ]

footnote : Jdec.Decoder Footnote
footnote =
    Jdec.succeed Footnote
        |> Jpipe.custom (optionalField "code" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "text" (Jdec.map Just Jdec.string) Nothing)

encodeFootnote : Footnote -> Jenc.Value
encodeFootnote x =
    Jenc.object
        [ ("code", makeNullableEncoder Jenc.string x.code)
        , ("text", makeNullableEncoder Jenc.string x.text)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
