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
    , TextClassificationOutputElement
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List TextClassificationOutputElement

type alias TextClassificationOutputElement =
    { label : String
    , score : Float
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list textClassificationOutputElement 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeTextClassificationOutputElement r)

textClassificationOutputElement : Jdec.Decoder TextClassificationOutputElement
textClassificationOutputElement =
    Jdec.succeed TextClassificationOutputElement
        |> Jpipe.required "label" Jdec.string
        |> Jpipe.required "score" Jdec.float

encodeTextClassificationOutputElement : TextClassificationOutputElement -> Jenc.Value
encodeTextClassificationOutputElement x =
    Jenc.object
        [ ("label", Jenc.string x.label)
        , ("score", Jenc.float x.score)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
