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
    , Union(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { barre : String
    , enumerification : Enum
    , foo : String
    , unionization : Union
    }

type Enum
    = Fire
    | Grass
    | Blue

type Union
    = Amount Float
    | Presence Bool

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
        |> Jpipe.required "bar" Jdec.string
        |> Jpipe.required "enum" enum
        |> Jpipe.required "foo" Jdec.string
        |> Jpipe.required "union" union

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("bar", Jenc.string x.barre)
        , ("enum", encodeEnum x.enumerification)
        , ("foo", Jenc.string x.foo)
        , ("union", encodeUnion x.unionization)
        ]

enum : Jdec.Decoder Enum
enum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "red" -> Jdec.succeed Fire
                "green" -> Jdec.succeed Grass
                "blue" -> Jdec.succeed Blue
                somethingElse -> Jdec.fail <| "Invalid Enum: " ++ somethingElse
        )

encodeEnum : Enum -> Jenc.Value
encodeEnum x = case x of
    Fire -> Jenc.string "red"
    Grass -> Jenc.string "green"
    Blue -> Jenc.string "blue"

union : Jdec.Decoder Union
union =
    Jdec.oneOf
        [ Jdec.map Presence Jdec.bool
        , Jdec.map Amount Jdec.float
        ]

encodeUnion : Union -> Jenc.Value
encodeUnion x = case x of
    Presence y -> Jenc.bool y
    Amount y -> Jenc.float y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
