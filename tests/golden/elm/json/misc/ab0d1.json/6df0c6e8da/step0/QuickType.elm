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
    , QuickTypeElement
    , Country(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { age : Int
    , country : Country
    , females : Int
    , males : Int
    , total : Int
    , year : Int
    }

type Country
    = UnitedStates

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeElement 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeElement r)

quickTypeElement : Jdec.Decoder QuickTypeElement
quickTypeElement =
    Jdec.succeed QuickTypeElement
        |> Jpipe.required "age" Jdec.int
        |> Jpipe.required "country" country
        |> Jpipe.required "females" Jdec.int
        |> Jpipe.required "males" Jdec.int
        |> Jpipe.required "total" Jdec.int
        |> Jpipe.required "year" Jdec.int

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("age", Jenc.int x.age)
        , ("country", encodeCountry x.country)
        , ("females", Jenc.int x.females)
        , ("males", Jenc.int x.males)
        , ("total", Jenc.int x.total)
        , ("year", Jenc.int x.year)
        ]

country : Jdec.Decoder Country
country =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "United States" -> Jdec.succeed UnitedStates
                somethingElse -> Jdec.fail <| "Invalid Country: " ++ somethingElse
        )

encodeCountry : Country -> Jenc.Value
encodeCountry x = case x of
    UnitedStates -> Jenc.string "United States"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
