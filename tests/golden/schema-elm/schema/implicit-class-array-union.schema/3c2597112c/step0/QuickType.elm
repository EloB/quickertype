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
    , FooClass
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
    | FooClassInFooUnion FooClass
    | IntegerArrayInFooUnion (List Int)
    | IntegerInFooUnion Int
    | NullInFooUnion
    | StringInFooUnion String

type alias FooClass =
    { bar : Int
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
        |> Jpipe.required "foo" fooUnion

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("foo", encodeFooUnion x.foo)
        ]

fooUnion : Jdec.Decoder FooUnion
fooUnion =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInFooUnion (Jdec.list Jdec.int )
        , Jdec.map BoolInFooUnion Jdec.bool
        , Jdec.map IntegerInFooUnion Jdec.int
        , Jdec.null NullInFooUnion
        , Jdec.map StringInFooUnion Jdec.string
        , Jdec.map DoubleInFooUnion Jdec.float
        , Jdec.map FooClassInFooUnion fooClass
        ]

encodeFooUnion : FooUnion -> Jenc.Value
encodeFooUnion x = case x of
    IntegerArrayInFooUnion y -> Jenc.list Jenc.int y
    BoolInFooUnion y -> Jenc.bool y
    IntegerInFooUnion y -> Jenc.int y
    NullInFooUnion -> Jenc.null
    StringInFooUnion y -> Jenc.string y
    DoubleInFooUnion y -> Jenc.float y
    FooClassInFooUnion y -> encodeFooClass y

fooClass : Jdec.Decoder FooClass
fooClass =
    Jdec.succeed FooClass
        |> Jpipe.required "bar" Jdec.int

encodeFooClass : FooClass -> Jenc.Value
encodeFooClass x =
    Jenc.object
        [ ("bar", Jenc.int x.bar)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
