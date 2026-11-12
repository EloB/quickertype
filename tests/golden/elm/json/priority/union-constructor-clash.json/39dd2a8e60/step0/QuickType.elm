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
    , BoolInUnion
    , Union(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { boolInUnion : BoolInUnion
    , union : List Union
    }

type alias BoolInUnion =
    { a : Bool
    }

type Union
    = IntegerInUnion Int
    | PurpleBoolInUnion Bool

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
        |> Jpipe.required "BoolInUnion" boolInUnion
        |> Jpipe.required "union" (Jdec.list union )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("BoolInUnion", encodeBoolInUnion x.boolInUnion)
        , ("union", Jenc.list encodeUnion x.union)
        ]

boolInUnion : Jdec.Decoder BoolInUnion
boolInUnion =
    Jdec.succeed BoolInUnion
        |> Jpipe.required "a" Jdec.bool

encodeBoolInUnion : BoolInUnion -> Jenc.Value
encodeBoolInUnion x =
    Jenc.object
        [ ("a", Jenc.bool x.a)
        ]

union : Jdec.Decoder Union
union =
    Jdec.oneOf
        [ Jdec.map PurpleBoolInUnion Jdec.bool
        , Jdec.map IntegerInUnion Jdec.int
        ]

encodeUnion : Union -> Jenc.Value
encodeUnion x = case x of
    PurpleBoolInUnion y -> Jenc.bool y
    IntegerInUnion y -> Jenc.int y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
