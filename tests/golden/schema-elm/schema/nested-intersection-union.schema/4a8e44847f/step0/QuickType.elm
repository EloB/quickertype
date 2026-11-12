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
    , Item
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { input : List Item
    }

type alias Item =
    { content : Maybe String
    , id : Maybe String
    , output : Maybe String
    , summary : Maybe String
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
        |> Jpipe.required "input" (Jdec.list item )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("input", Jenc.list encodeItem x.input)
        ]

item : Jdec.Decoder Item
item =
    Jdec.succeed Item
        |> Jpipe.custom (optionalField "content" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "id" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "output" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "summary" (Jdec.map Just Jdec.string) Nothing)

encodeItem : Item -> Jenc.Value
encodeItem x =
    Jenc.object
        [ ("content", makeNullableEncoder Jenc.string x.content)
        , ("id", makeNullableEncoder Jenc.string x.id)
        , ("output", makeNullableEncoder Jenc.string x.output)
        , ("summary", makeNullableEncoder Jenc.string x.summary)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
