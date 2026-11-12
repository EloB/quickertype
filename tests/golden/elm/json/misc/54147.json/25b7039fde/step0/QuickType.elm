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
    , Args
    , Headers
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { args : Args
    , data : String
    , files : Args
    , form : Args
    , headers : Headers
    , origin : String
    , url : String
    }

type alias Args =
    {
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
        |> Jpipe.required "args" args
        |> Jpipe.required "data" Jdec.string
        |> Jpipe.required "files" args
        |> Jpipe.required "form" args
        |> Jpipe.required "headers" headers
        |> Jpipe.required "origin" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("args", encodeArgs x.args)
        , ("data", Jenc.string x.data)
        , ("files", encodeArgs x.files)
        , ("form", encodeArgs x.form)
        , ("headers", encodeHeaders x.headers)
        , ("origin", Jenc.string x.origin)
        , ("url", Jenc.string x.url)
        ]

args : Jdec.Decoder Args
args =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Args)

encodeArgs : Args -> Jenc.Value
encodeArgs x =
    Jenc.object
        [
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
