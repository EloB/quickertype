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
    { arrNullable : Maybe (List (Maybe String))
    , arrOne : Maybe (List String)
    , nullable : Maybe String
    , one : String
    , optional : Maybe String
    , unionWithEnum : String
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
        |> Jpipe.custom (optionalField "arrNullable" (Jdec.map Just (Jdec.list (Jdec.nullable Jdec.string) )) Nothing)
        |> Jpipe.custom (optionalField "arrOne" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.required "nullable" (Jdec.nullable Jdec.string)
        |> Jpipe.required "one" Jdec.string
        |> Jpipe.custom (optionalField "optional" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "unionWithEnum" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("arrNullable", makeNullableEncoder (Jenc.list (makeNullableEncoder Jenc.string)) x.arrNullable)
        , ("arrOne", makeNullableEncoder (Jenc.list Jenc.string) x.arrOne)
        , ("nullable", makeNullableEncoder Jenc.string x.nullable)
        , ("one", Jenc.string x.one)
        , ("optional", makeNullableEncoder Jenc.string x.optional)
        , ("unionWithEnum", Jenc.string x.unionWithEnum)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
