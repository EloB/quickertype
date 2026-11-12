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
    , IssPosition
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { issPosition : IssPosition
    , message : String
    , timestamp : Int
    }

type alias IssPosition =
    { latitude : String
    , longitude : String
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
        |> Jpipe.required "iss_position" issPosition
        |> Jpipe.required "message" Jdec.string
        |> Jpipe.required "timestamp" Jdec.int

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("iss_position", encodeIssPosition x.issPosition)
        , ("message", Jenc.string x.message)
        , ("timestamp", Jenc.int x.timestamp)
        ]

issPosition : Jdec.Decoder IssPosition
issPosition =
    Jdec.succeed IssPosition
        |> Jpipe.required "latitude" Jdec.string
        |> Jpipe.required "longitude" Jdec.string

encodeIssPosition : IssPosition -> Jenc.Value
encodeIssPosition x =
    Jenc.object
        [ ("latitude", Jenc.string x.latitude)
        , ("longitude", Jenc.string x.longitude)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
