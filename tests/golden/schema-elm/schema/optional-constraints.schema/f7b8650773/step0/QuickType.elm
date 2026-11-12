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
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { optDouble : Maybe Float
    , optInt : Maybe Int
    , optPattern : Maybe String
    , optString : Maybe String
    , reqZeroMin : Int
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
        |> Jpipe.custom (optionalField "optDouble" (Jdec.map Just (Jdec.andThen (\x -> if x >= 0.5 && x <= 99.5 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)) Nothing)
        |> Jpipe.custom (optionalField "optInt" (Jdec.map Just (Jdec.andThen (\x -> if x >= 0 && x <= 100 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)) Nothing)
        |> Jpipe.custom (optionalField "optPattern" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "optString" (Jdec.map Just (Jdec.andThen (\x -> if List.length (String.toList x) >= 3 && List.length (String.toList x) <= 10 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)) Nothing)
        |> Jpipe.required "reqZeroMin" (Jdec.andThen (\x -> if x >= 0 && x <= 100 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("optDouble", makeNullableEncoder Jenc.float x.optDouble)
        , ("optInt", makeNullableEncoder Jenc.int x.optInt)
        , ("optPattern", makeNullableEncoder Jenc.string x.optPattern)
        , ("optString", makeNullableEncoder Jenc.string x.optString)
        , ("reqZeroMin", Jenc.int x.reqZeroMin)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
