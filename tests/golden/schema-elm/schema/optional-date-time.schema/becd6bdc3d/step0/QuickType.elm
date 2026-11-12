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
    { optionalDate : Maybe String
    , optionalDateTime : Maybe String
    , optionalTime : Maybe String
    , requiredDate : String
    , requiredDateTime : String
    , requiredTime : String
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
        |> Jpipe.custom (optionalField "optional-date" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "optional-date-time" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "optional-time" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "required-date" Jdec.string
        |> Jpipe.required "required-date-time" Jdec.string
        |> Jpipe.required "required-time" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("optional-date", makeNullableEncoder Jenc.string x.optionalDate)
        , ("optional-date-time", makeNullableEncoder Jenc.string x.optionalDateTime)
        , ("optional-time", makeNullableEncoder Jenc.string x.optionalTime)
        , ("required-date", Jenc.string x.requiredDate)
        , ("required-date-time", Jenc.string x.requiredDateTime)
        , ("required-time", Jenc.string x.requiredTime)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
