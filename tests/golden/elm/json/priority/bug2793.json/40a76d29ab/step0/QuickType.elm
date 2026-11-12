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
    , Hints
    , Labels
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { hints : Hints
    , labels : Labels
    }

type alias Hints =
    {
    }

type alias Labels =
    { accountNumber : String
    , title : String
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
        |> Jpipe.required "Hints" hints
        |> Jpipe.required "Labels" labels

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("Hints", encodeHints x.hints)
        , ("Labels", encodeLabels x.labels)
        ]

hints : Jdec.Decoder Hints
hints =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Hints)

encodeHints : Hints -> Jenc.Value
encodeHints x =
    Jenc.object
        [
        ]

labels : Jdec.Decoder Labels
labels =
    Jdec.succeed Labels
        |> Jpipe.required "AccountNumber" Jdec.string
        |> Jpipe.required "Title" Jdec.string

encodeLabels : Labels -> Jenc.Value
encodeLabels x =
    Jenc.object
        [ ("AccountNumber", Jenc.string x.accountNumber)
        , ("Title", Jenc.string x.title)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
