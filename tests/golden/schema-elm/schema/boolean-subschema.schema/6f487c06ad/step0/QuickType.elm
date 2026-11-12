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
    { disallowed : Maybe Jdec.Value
    , empty : List Jdec.Value
    , foo : String
    , impossible : Maybe Jdec.Value
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
        |> Jpipe.custom (optionalField "disallowed" (Jdec.nullable Jdec.value) Nothing)
        |> Jpipe.required "empty" (Jdec.list Jdec.value )
        |> Jpipe.required "foo" Jdec.string
        |> Jpipe.custom (optionalField "impossible" (Jdec.nullable Jdec.value) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("disallowed", makeNullableEncoder identity x.disallowed)
        , ("empty", Jenc.list identity x.empty)
        , ("foo", Jenc.string x.foo)
        , ("impossible", makeNullableEncoder identity x.impossible)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
