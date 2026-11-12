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
    , ArrayNode
    , BooleanNode
    , DoubleNode
    , IntNode
    , LongNode
    , NullNode
    , ObjectNode
    , Thing
    , TextNode
    , Anything(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { arrayNode : Maybe ArrayNode
    , booleanNode : Maybe BooleanNode
    , doubleNode : Maybe DoubleNode
    , intNode : Maybe IntNode
    , longNode : Maybe LongNode
    , nullNode : Maybe NullNode
    , objectNode : Maybe ObjectNode
    , stuff : Dict String Thing
    , textNode : Maybe TextNode
    }

type alias ArrayNode =
    {
    }

type alias BooleanNode =
    {
    }

type alias DoubleNode =
    {
    }

type alias IntNode =
    {
    }

type alias LongNode =
    {
    }

type alias NullNode =
    {
    }

type alias ObjectNode =
    {
    }

type alias Thing =
    { optional : Maybe Anything
    , required : Anything
    }

type Anything
    = AnythingArrayInAnything (List Jdec.Value)
    | AnythingMapInAnything (Dict String Jdec.Value)
    | BoolInAnything Bool
    | DoubleInAnything Float
    | IntegerInAnything Int
    | NullInAnything
    | StringInAnything String

type alias TextNode =
    {
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
        |> Jpipe.custom (optionalField "arrayNode" (Jdec.map Just arrayNode) Nothing)
        |> Jpipe.custom (optionalField "booleanNode" (Jdec.map Just booleanNode) Nothing)
        |> Jpipe.custom (optionalField "doubleNode" (Jdec.map Just doubleNode) Nothing)
        |> Jpipe.custom (optionalField "intNode" (Jdec.map Just intNode) Nothing)
        |> Jpipe.custom (optionalField "longNode" (Jdec.map Just longNode) Nothing)
        |> Jpipe.custom (optionalField "nullNode" (Jdec.map Just nullNode) Nothing)
        |> Jpipe.custom (optionalField "objectNode" (Jdec.map Just objectNode) Nothing)
        |> Jpipe.required "stuff" (Jdec.dict thing)
        |> Jpipe.custom (optionalField "textNode" (Jdec.map Just textNode) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("arrayNode", makeNullableEncoder encodeArrayNode x.arrayNode)
        , ("booleanNode", makeNullableEncoder encodeBooleanNode x.booleanNode)
        , ("doubleNode", makeNullableEncoder encodeDoubleNode x.doubleNode)
        , ("intNode", makeNullableEncoder encodeIntNode x.intNode)
        , ("longNode", makeNullableEncoder encodeLongNode x.longNode)
        , ("nullNode", makeNullableEncoder encodeNullNode x.nullNode)
        , ("objectNode", makeNullableEncoder encodeObjectNode x.objectNode)
        , ("stuff", Jenc.dict identity encodeThing x.stuff)
        , ("textNode", makeNullableEncoder encodeTextNode x.textNode)
        ]

arrayNode : Jdec.Decoder ArrayNode
arrayNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ArrayNode)

encodeArrayNode : ArrayNode -> Jenc.Value
encodeArrayNode x =
    Jenc.object
        [
        ]

booleanNode : Jdec.Decoder BooleanNode
booleanNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> BooleanNode)

encodeBooleanNode : BooleanNode -> Jenc.Value
encodeBooleanNode x =
    Jenc.object
        [
        ]

doubleNode : Jdec.Decoder DoubleNode
doubleNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> DoubleNode)

encodeDoubleNode : DoubleNode -> Jenc.Value
encodeDoubleNode x =
    Jenc.object
        [
        ]

intNode : Jdec.Decoder IntNode
intNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> IntNode)

encodeIntNode : IntNode -> Jenc.Value
encodeIntNode x =
    Jenc.object
        [
        ]

longNode : Jdec.Decoder LongNode
longNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> LongNode)

encodeLongNode : LongNode -> Jenc.Value
encodeLongNode x =
    Jenc.object
        [
        ]

nullNode : Jdec.Decoder NullNode
nullNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> NullNode)

encodeNullNode : NullNode -> Jenc.Value
encodeNullNode x =
    Jenc.object
        [
        ]

objectNode : Jdec.Decoder ObjectNode
objectNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ObjectNode)

encodeObjectNode : ObjectNode -> Jenc.Value
encodeObjectNode x =
    Jenc.object
        [
        ]

thing : Jdec.Decoder Thing
thing =
    Jdec.succeed Thing
        |> Jpipe.custom (optionalField "optional" (Jdec.nullable anything) Nothing)
        |> Jpipe.required "required" anything

encodeThing : Thing -> Jenc.Value
encodeThing x =
    Jenc.object
        [ ("optional", makeNullableEncoder encodeAnything x.optional)
        , ("required", encodeAnything x.required)
        ]

anything : Jdec.Decoder Anything
anything =
    Jdec.oneOf
        [ Jdec.map AnythingArrayInAnything (Jdec.list Jdec.value )
        , Jdec.map BoolInAnything Jdec.bool
        , Jdec.map IntegerInAnything Jdec.int
        , Jdec.null NullInAnything
        , Jdec.map StringInAnything Jdec.string
        , Jdec.map DoubleInAnything Jdec.float
        , Jdec.map AnythingMapInAnything (Jdec.dict Jdec.value)
        ]

encodeAnything : Anything -> Jenc.Value
encodeAnything x = case x of
    AnythingArrayInAnything y -> Jenc.list identity y
    BoolInAnything y -> Jenc.bool y
    IntegerInAnything y -> Jenc.int y
    NullInAnything -> Jenc.null
    StringInAnything y -> Jenc.string y
    DoubleInAnything y -> Jenc.float y
    AnythingMapInAnything y -> Jenc.dict identity identity y

textNode : Jdec.Decoder TextNode
textNode =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> TextNode)

encodeTextNode : TextNode -> Jenc.Value
encodeTextNode x =
    Jenc.object
        [
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
