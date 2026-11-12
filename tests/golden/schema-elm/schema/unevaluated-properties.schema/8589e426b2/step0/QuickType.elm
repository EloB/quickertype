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
    , Config
    , ClosedClass
    , Item
    , Closed(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { config : Maybe Config
    }

type alias Config =
    { closed : Maybe Closed
    , name : Maybe String
    , settings : Maybe (Dict String (List Item))
    }

type Closed
    = AnythingArrayInClosed (List Jdec.Value)
    | BoolInClosed Bool
    | ClosedClassInClosed ClosedClass
    | DoubleInClosed Float
    | IntegerInClosed Int
    | NullInClosed
    | StringInClosed String

type alias ClosedClass =
    {
    }

type alias Item =
    { key : String
    , value : String
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
        |> Jpipe.custom (optionalField "config" (Jdec.map Just config) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("config", makeNullableEncoder encodeConfig x.config)
        ]

config : Jdec.Decoder Config
config =
    Jdec.succeed Config
        |> Jpipe.custom (optionalField "closed" (Jdec.nullable closed) Nothing)
        |> Jpipe.custom (optionalField "name" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "settings" (Jdec.map Just (Jdec.dict (Jdec.list item ))) Nothing)

encodeConfig : Config -> Jenc.Value
encodeConfig x =
    Jenc.object
        [ ("closed", makeNullableEncoder encodeClosed x.closed)
        , ("name", makeNullableEncoder Jenc.string x.name)
        , ("settings", makeNullableEncoder (Jenc.dict identity (Jenc.list encodeItem)) x.settings)
        ]

closed : Jdec.Decoder Closed
closed =
    Jdec.oneOf
        [ Jdec.map AnythingArrayInClosed (Jdec.list Jdec.value )
        , Jdec.map BoolInClosed Jdec.bool
        , Jdec.map IntegerInClosed Jdec.int
        , Jdec.null NullInClosed
        , Jdec.map StringInClosed Jdec.string
        , Jdec.map DoubleInClosed Jdec.float
        , Jdec.map ClosedClassInClosed closedClass
        ]

encodeClosed : Closed -> Jenc.Value
encodeClosed x = case x of
    AnythingArrayInClosed y -> Jenc.list identity y
    BoolInClosed y -> Jenc.bool y
    IntegerInClosed y -> Jenc.int y
    NullInClosed -> Jenc.null
    StringInClosed y -> Jenc.string y
    DoubleInClosed y -> Jenc.float y
    ClosedClassInClosed y -> encodeClosedClass y

closedClass : Jdec.Decoder ClosedClass
closedClass =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> ClosedClass)

encodeClosedClass : ClosedClass -> Jenc.Value
encodeClosedClass x =
    Jenc.object
        [
        ]

item : Jdec.Decoder Item
item =
    Jdec.succeed Item
        |> Jpipe.required "key" Jdec.string
        |> Jpipe.required "value" Jdec.string

encodeItem : Item -> Jenc.Value
encodeItem x =
    Jenc.object
        [ ("key", Jenc.string x.key)
        , ("value", Jenc.string x.value)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
