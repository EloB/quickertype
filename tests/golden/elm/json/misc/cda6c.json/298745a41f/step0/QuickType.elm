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
    , PurpleQuickType
    , Country
    , FluffyQuickType
    , ID(..)
    , Value(..)
    , QuickTypeUnion(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeUnion

type QuickTypeUnion
    = FluffyQuickTypeInQuickTypeUnion FluffyQuickType
    | PurpleQuickTypeArrayInQuickTypeUnion (List PurpleQuickType)

type alias PurpleQuickType =
    { country : Country
    , date : String
    , decimal : String
    , indicator : Country
    , value : String
    }

type alias Country =
    { id : ID
    , value : Value
    }

type ID
    = CN
    | SPPopTotl

type Value
    = China
    | PopulationTotal

type alias FluffyQuickType =
    { page : Int
    , pages : Int
    , perPage : String
    , total : Int
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeUnion 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeUnion r)

quickTypeUnion : Jdec.Decoder QuickTypeUnion
quickTypeUnion =
    Jdec.oneOf
        [ Jdec.map PurpleQuickTypeArrayInQuickTypeUnion (Jdec.list purpleQuickType )
        , Jdec.map FluffyQuickTypeInQuickTypeUnion fluffyQuickType
        ]

encodeQuickTypeUnion : QuickTypeUnion -> Jenc.Value
encodeQuickTypeUnion x = case x of
    PurpleQuickTypeArrayInQuickTypeUnion y -> Jenc.list encodePurpleQuickType y
    FluffyQuickTypeInQuickTypeUnion y -> encodeFluffyQuickType y

purpleQuickType : Jdec.Decoder PurpleQuickType
purpleQuickType =
    Jdec.succeed PurpleQuickType
        |> Jpipe.required "country" country
        |> Jpipe.required "date" Jdec.string
        |> Jpipe.required "decimal" Jdec.string
        |> Jpipe.required "indicator" country
        |> Jpipe.required "value" Jdec.string

encodePurpleQuickType : PurpleQuickType -> Jenc.Value
encodePurpleQuickType x =
    Jenc.object
        [ ("country", encodeCountry x.country)
        , ("date", Jenc.string x.date)
        , ("decimal", Jenc.string x.decimal)
        , ("indicator", encodeCountry x.indicator)
        , ("value", Jenc.string x.value)
        ]

country : Jdec.Decoder Country
country =
    Jdec.succeed Country
        |> Jpipe.required "id" id
        |> Jpipe.required "value" value

encodeCountry : Country -> Jenc.Value
encodeCountry x =
    Jenc.object
        [ ("id", encodeID x.id)
        , ("value", encodeValue x.value)
        ]

id : Jdec.Decoder ID
id =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "CN" -> Jdec.succeed CN
                "SP.POP.TOTL" -> Jdec.succeed SPPopTotl
                somethingElse -> Jdec.fail <| "Invalid ID: " ++ somethingElse
        )

encodeID : ID -> Jenc.Value
encodeID x = case x of
    CN -> Jenc.string "CN"
    SPPopTotl -> Jenc.string "SP.POP.TOTL"

value : Jdec.Decoder Value
value =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "China" -> Jdec.succeed China
                "Population, total" -> Jdec.succeed PopulationTotal
                somethingElse -> Jdec.fail <| "Invalid Value: " ++ somethingElse
        )

encodeValue : Value -> Jenc.Value
encodeValue x = case x of
    China -> Jenc.string "China"
    PopulationTotal -> Jenc.string "Population, total"

fluffyQuickType : Jdec.Decoder FluffyQuickType
fluffyQuickType =
    Jdec.succeed FluffyQuickType
        |> Jpipe.required "page" Jdec.int
        |> Jpipe.required "pages" Jdec.int
        |> Jpipe.required "per_page" Jdec.string
        |> Jpipe.required "total" Jdec.int

encodeFluffyQuickType : FluffyQuickType -> Jenc.Value
encodeFluffyQuickType x =
    Jenc.object
        [ ("page", Jenc.int x.page)
        , ("pages", Jenc.int x.pages)
        , ("per_page", Jenc.string x.perPage)
        , ("total", Jenc.int x.total)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
