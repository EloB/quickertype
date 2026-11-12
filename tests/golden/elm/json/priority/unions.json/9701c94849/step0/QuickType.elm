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
    , ZClass
    , X(..)
    , ZElement(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { quickTypeX : List X
    , quickTypeY : List (Maybe Int)
    , z : List ZElement
    }

type X
    = IntegerInX Int
    | NullInX
    | StringInX String

type ZElement
    = IntegerArrayInZElement (List Int)
    | IntegerInZElement Int
    | ZClassInZElement ZClass

type alias ZClass =
    { a : Bool
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
        |> Jpipe.required "x" (Jdec.list purpleX )
        |> Jpipe.required "y" (Jdec.list (Jdec.nullable Jdec.int) )
        |> Jpipe.required "z" (Jdec.list zElement )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("x", Jenc.list encodeX x.quickTypeX)
        , ("y", Jenc.list (makeNullableEncoder Jenc.int) x.quickTypeY)
        , ("z", Jenc.list encodeZElement x.z)
        ]

purpleX : Jdec.Decoder X
purpleX =
    Jdec.oneOf
        [ Jdec.map IntegerInX Jdec.int
        , Jdec.null NullInX
        , Jdec.map StringInX Jdec.string
        ]

encodeX : X -> Jenc.Value
encodeX x = case x of
    IntegerInX y -> Jenc.int y
    NullInX -> Jenc.null
    StringInX y -> Jenc.string y

zElement : Jdec.Decoder ZElement
zElement =
    Jdec.oneOf
        [ Jdec.map IntegerArrayInZElement (Jdec.list Jdec.int )
        , Jdec.map IntegerInZElement Jdec.int
        , Jdec.map ZClassInZElement zClass
        ]

encodeZElement : ZElement -> Jenc.Value
encodeZElement x = case x of
    IntegerArrayInZElement y -> Jenc.list Jenc.int y
    IntegerInZElement y -> Jenc.int y
    ZClassInZElement y -> encodeZClass y

zClass : Jdec.Decoder ZClass
zClass =
    Jdec.succeed ZClass
        |> Jpipe.required "a" Jdec.bool

encodeZClass : ZClass -> Jenc.Value
encodeZClass x =
    Jenc.object
        [ ("a", Jenc.bool x.a)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
