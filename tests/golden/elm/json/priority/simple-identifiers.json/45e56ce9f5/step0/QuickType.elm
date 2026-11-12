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
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { continue : String
    , empty : String
    , fluffyX : String
    , null : String
    , purpleX : String
    , quickType : String
    , quickTypeX : String
    , undefined : String
    , xY : String
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
        |> Jpipe.required "continue" Jdec.string
        |> Jpipe.required "" Jdec.string
        |> Jpipe.required "x'" Jdec.string
        |> Jpipe.required "null" Jdec.string
        |> Jpipe.required "x\"" Jdec.string
        |> Jpipe.required "{}" Jdec.string
        |> Jpipe.required "x" Jdec.string
        |> Jpipe.required "undefined" Jdec.string
        |> Jpipe.required "x y" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("continue", Jenc.string x.continue)
        , ("", Jenc.string x.empty)
        , ("x'", Jenc.string x.fluffyX)
        , ("null", Jenc.string x.null)
        , ("x\"", Jenc.string x.purpleX)
        , ("{}", Jenc.string x.quickType)
        , ("x", Jenc.string x.quickTypeX)
        , ("undefined", Jenc.string x.undefined)
        , ("x y", Jenc.string x.xY)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
