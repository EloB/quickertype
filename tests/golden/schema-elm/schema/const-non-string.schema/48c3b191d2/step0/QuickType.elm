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
    , Kind(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { amount : Int
    , enabled : Bool
    , kind : Kind
    , ratio : Float
    , version : Float
    }

type Kind
    = Widget

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
        |> Jpipe.required "amount" Jdec.int
        |> Jpipe.required "enabled" Jdec.bool
        |> Jpipe.required "kind" kind
        |> Jpipe.required "ratio" Jdec.float
        |> Jpipe.required "version" Jdec.float

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("amount", Jenc.int x.amount)
        , ("enabled", Jenc.bool x.enabled)
        , ("kind", encodeKind x.kind)
        , ("ratio", Jenc.float x.ratio)
        , ("version", Jenc.float x.version)
        ]

kind : Jdec.Decoder Kind
kind =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "widget" -> Jdec.succeed Widget
                somethingElse -> Jdec.fail <| "Invalid Kind: " ++ somethingElse
        )

encodeKind : Kind -> Jenc.Value
encodeKind x = case x of
    Widget -> Jenc.string "widget"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
