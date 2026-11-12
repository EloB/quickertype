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
    , Shortcut(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { name : String
    , shortcut : Maybe Shortcut
    }

type Shortcut
    = Hidden
    | Visible

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
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.custom (optionalField "shortcut" (Jdec.map Just shortcut) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        , ("shortcut", makeNullableEncoder encodeShortcut x.shortcut)
        ]

shortcut : Jdec.Decoder Shortcut
shortcut =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "hidden" -> Jdec.succeed Hidden
                "visible" -> Jdec.succeed Visible
                somethingElse -> Jdec.fail <| "Invalid Shortcut: " ++ somethingElse
        )

encodeShortcut : Shortcut -> Jenc.Value
encodeShortcut x = case x of
    Hidden -> Jenc.string "hidden"
    Visible -> Jenc.string "visible"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
