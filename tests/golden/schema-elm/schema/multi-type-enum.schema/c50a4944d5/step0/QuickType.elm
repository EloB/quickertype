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
    , FooEnum(..)
    , FooUnion(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { foo : FooUnion
    }

type FooUnion
    = BoolInFooUnion Bool
    | DoubleInFooUnion Float
    | EnumInFooUnion FooEnum
    | IntegerInFooUnion Int

type FooEnum
    = A
    | B
    | C

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
        |> Jpipe.required "foo" fooUnion

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("foo", encodeFooUnion x.foo)
        ]

fooUnion : Jdec.Decoder FooUnion
fooUnion =
    Jdec.oneOf
        [ Jdec.map BoolInFooUnion Jdec.bool
        , Jdec.map IntegerInFooUnion Jdec.int
        , Jdec.map DoubleInFooUnion Jdec.float
        , Jdec.map EnumInFooUnion fooEnum
        ]

encodeFooUnion : FooUnion -> Jenc.Value
encodeFooUnion x = case x of
    BoolInFooUnion y -> Jenc.bool y
    IntegerInFooUnion y -> Jenc.int y
    DoubleInFooUnion y -> Jenc.float y
    EnumInFooUnion y -> encodeFooEnum y

fooEnum : Jdec.Decoder FooEnum
fooEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "a" -> Jdec.succeed A
                "b" -> Jdec.succeed B
                "c" -> Jdec.succeed C
                somethingElse -> Jdec.fail <| "Invalid FooEnum: " ++ somethingElse
        )

encodeFooEnum : FooEnum -> Jenc.Value
encodeFooEnum x = case x of
    A -> Jenc.string "a"
    B -> Jenc.string "b"
    C -> Jenc.string "c"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
