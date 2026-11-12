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
    , Headers
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { headers : Headers
    }

type alias Headers =
    { acceptEncoding : String
    , connection : String
    , host : String
    , userAgent : String
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
        |> Jpipe.required "headers" headers

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("headers", encodeHeaders x.headers)
        ]

headers : Jdec.Decoder Headers
headers =
    Jdec.succeed Headers
        |> Jpipe.required "Accept-Encoding" Jdec.string
        |> Jpipe.required "Connection" Jdec.string
        |> Jpipe.required "Host" Jdec.string
        |> Jpipe.required "User-Agent" Jdec.string

encodeHeaders : Headers -> Jenc.Value
encodeHeaders x =
    Jenc.object
        [ ("Accept-Encoding", Jenc.string x.acceptEncoding)
        , ("Connection", Jenc.string x.connection)
        , ("Host", Jenc.string x.host)
        , ("User-Agent", Jenc.string x.userAgent)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
