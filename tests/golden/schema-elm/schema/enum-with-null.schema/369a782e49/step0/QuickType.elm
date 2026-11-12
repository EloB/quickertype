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
    , Enum(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { enum : Maybe Enum
    }

type Enum
    = Foo
    | Bar

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
        |> Jpipe.required "enum" (Jdec.nullable enum)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("enum", makeNullableEncoder encodeEnum x.enum)
        ]

enum : Jdec.Decoder Enum
enum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "foo" -> Jdec.succeed Foo
                "bar" -> Jdec.succeed Bar
                somethingElse -> Jdec.fail <| "Invalid Enum: " ++ somethingElse
        )

encodeEnum : Enum -> Jenc.Value
encodeEnum x = case x of
    Foo -> Jenc.string "foo"
    Bar -> Jenc.string "bar"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
