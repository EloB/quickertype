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
    { anEasyOne : Int
    , isMNISTLetter : Bool
    , jsonString : String
    , prettyEasyToo : Bool
    , shouldKnowThatIDIsAnInitialism : String
    , spacesAreSeparatorsToo : Bool
    , zsrHhDemo3Delmatnr : Bool
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
        |> Jpipe.required "anEasyOne" Jdec.int
        |> Jpipe.required "isMNISTLetter" Jdec.bool
        |> Jpipe.required "JSONString" Jdec.string
        |> Jpipe.required "PrettyEasyToo" Jdec.bool
        |> Jpipe.required "should_know_that_id_is_an_initialism" Jdec.string
        |> Jpipe.required "   spaces are separators  too  " Jdec.bool
        |> Jpipe.required "ZSR_HH_DEMO3_DELMATNR" Jdec.bool

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("anEasyOne", Jenc.int x.anEasyOne)
        , ("isMNISTLetter", Jenc.bool x.isMNISTLetter)
        , ("JSONString", Jenc.string x.jsonString)
        , ("PrettyEasyToo", Jenc.bool x.prettyEasyToo)
        , ("should_know_that_id_is_an_initialism", Jenc.string x.shouldKnowThatIDIsAnInitialism)
        , ("   spaces are separators  too  ", Jenc.bool x.spacesAreSeparatorsToo)
        , ("ZSR_HH_DEMO3_DELMATNR", Jenc.bool x.zsrHhDemo3Delmatnr)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
