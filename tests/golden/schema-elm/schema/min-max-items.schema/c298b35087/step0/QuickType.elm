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
    , UnionItem(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { maxOnly : List Int
    , minAndMax : List Float
    , minOnly : List String
    , plain : List String
    , unionItems : List UnionItem
    }

type UnionItem
    = IntegerInUnionItem Int
    | StringInUnionItem String

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
        |> Jpipe.required "maxOnly" (Jdec.list Jdec.int |> Jdec.andThen (\x -> if True && List.length x <= 3 then Jdec.succeed x else Jdec.fail "Array length out of range"))
        |> Jpipe.required "minAndMax" (Jdec.list Jdec.float |> Jdec.andThen (\x -> if List.length x >= 1 && List.length x <= 4 then Jdec.succeed x else Jdec.fail "Array length out of range"))
        |> Jpipe.required "minOnly" (Jdec.list Jdec.string |> Jdec.andThen (\x -> if List.length x >= 2 && True then Jdec.succeed x else Jdec.fail "Array length out of range"))
        |> Jpipe.required "plain" (Jdec.list Jdec.string )
        |> Jpipe.required "unionItems" (Jdec.list unionItem |> Jdec.andThen (\x -> if List.length x >= 2 && True then Jdec.succeed x else Jdec.fail "Array length out of range"))

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("maxOnly", Jenc.list Jenc.int x.maxOnly)
        , ("minAndMax", Jenc.list Jenc.float x.minAndMax)
        , ("minOnly", Jenc.list Jenc.string x.minOnly)
        , ("plain", Jenc.list Jenc.string x.plain)
        , ("unionItems", Jenc.list encodeUnionItem x.unionItems)
        ]

unionItem : Jdec.Decoder UnionItem
unionItem =
    Jdec.oneOf
        [ Jdec.map IntegerInUnionItem Jdec.int
        , Jdec.map StringInUnionItem Jdec.string
        ]

encodeUnionItem : UnionItem -> Jenc.Value
encodeUnionItem x = case x of
    IntegerInUnionItem y -> Jenc.int y
    StringInUnionItem y -> Jenc.string y

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
