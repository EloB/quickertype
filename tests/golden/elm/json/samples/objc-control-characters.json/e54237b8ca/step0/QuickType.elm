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
    , Value(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { literal : String
    , the11 : Int
    , values : List Value
    }

type Value
    = C0
    | C1

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
        |> Jpipe.required "literal" Jdec.string
        |> Jpipe.required "#{1+1}" Jdec.int
        |> Jpipe.required "values" (Jdec.list value )

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("literal", Jenc.string x.literal)
        , ("#{1+1}", Jenc.int x.the11)
        , ("values", Jenc.list encodeValue x.values)
        ]

value : Jdec.Decoder Value
value =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "c0\u{0001}\u{001B}\u{001F}" -> Jdec.succeed C0
                "c1\u{007F}\u{0080}\u{0085}\u{009F}" -> Jdec.succeed C1
                somethingElse -> Jdec.fail <| "Invalid Value: " ++ somethingElse
        )

encodeValue : Value -> Jenc.Value
encodeValue x = case x of
    C0 -> Jenc.string "c0\u{0001}\u{001B}\u{001F}"
    C1 -> Jenc.string "c1\u{007F}\u{0080}\u{0085}\u{009F}"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
