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
    , OtherArr(..)
    , Gve(..)
    , Lvc(..)
    , Arr(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { arr : Maybe (List Arr)
    , for : Maybe String
    , gve : Gve
    , lvc : Maybe Lvc
    , otherArr : Maybe (List OtherArr)
    }

type Arr
    = EnumInArr OtherArr
    | IntegerInArr Int

type OtherArr
    = Foo
    | Bar
    | If

type Gve
    = Good
    | GveNeutral
    | Evil

type Lvc
    = Lawful
    | LvcNeutral
    | Chaotic

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
        |> Jpipe.custom (optionalField "arr" (Jdec.map Just (Jdec.list arr )) Nothing)
        |> Jpipe.custom (optionalField "for" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "gve" gve
        |> Jpipe.custom (optionalField "lvc" (Jdec.map Just lvc) Nothing)
        |> Jpipe.custom (optionalField "otherArr" (Jdec.map Just (Jdec.list otherArr )) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("arr", makeNullableEncoder (Jenc.list encodeArr) x.arr)
        , ("for", makeNullableEncoder Jenc.string x.for)
        , ("gve", encodeGve x.gve)
        , ("lvc", makeNullableEncoder encodeLvc x.lvc)
        , ("otherArr", makeNullableEncoder (Jenc.list encodeOtherArr) x.otherArr)
        ]

arr : Jdec.Decoder Arr
arr =
    Jdec.oneOf
        [ Jdec.map IntegerInArr Jdec.int
        , Jdec.map EnumInArr otherArr
        ]

encodeArr : Arr -> Jenc.Value
encodeArr x = case x of
    IntegerInArr y -> Jenc.int y
    EnumInArr y -> encodeOtherArr y

otherArr : Jdec.Decoder OtherArr
otherArr =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "foo" -> Jdec.succeed Foo
                "bar" -> Jdec.succeed Bar
                "if" -> Jdec.succeed If
                somethingElse -> Jdec.fail <| "Invalid OtherArr: " ++ somethingElse
        )

encodeOtherArr : OtherArr -> Jenc.Value
encodeOtherArr x = case x of
    Foo -> Jenc.string "foo"
    Bar -> Jenc.string "bar"
    If -> Jenc.string "if"

gve : Jdec.Decoder Gve
gve =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "good" -> Jdec.succeed Good
                "neutral" -> Jdec.succeed GveNeutral
                "evil" -> Jdec.succeed Evil
                somethingElse -> Jdec.fail <| "Invalid Gve: " ++ somethingElse
        )

encodeGve : Gve -> Jenc.Value
encodeGve x = case x of
    Good -> Jenc.string "good"
    GveNeutral -> Jenc.string "neutral"
    Evil -> Jenc.string "evil"

lvc : Jdec.Decoder Lvc
lvc =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "lawful" -> Jdec.succeed Lawful
                "neutral" -> Jdec.succeed LvcNeutral
                "chaotic" -> Jdec.succeed Chaotic
                somethingElse -> Jdec.fail <| "Invalid Lvc: " ++ somethingElse
        )

encodeLvc : Lvc -> Jenc.Value
encodeLvc x = case x of
    Lawful -> Jenc.string "lawful"
    LvcNeutral -> Jenc.string "neutral"
    Chaotic -> Jenc.string "chaotic"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
