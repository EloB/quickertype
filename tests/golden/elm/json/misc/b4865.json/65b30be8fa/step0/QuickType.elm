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
    , Geolocation
    , Fall(..)
    , Type(..)
    , Nametype(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { computedRegionCbhkFwbd : Maybe String
    , computedRegionNnqa25F4 : Maybe String
    , fall : Fall
    , geolocation : Maybe Geolocation
    , id : String
    , mass : Maybe String
    , name : String
    , nametype : Nametype
    , recclass : String
    , reclat : Maybe String
    , reclong : Maybe String
    , year : Maybe String
    }

type Fall
    = Fell
    | Found

type alias Geolocation =
    { coordinates : List Float
    , geolocationType : Type
    }

type Type
    = Point

type Nametype
    = Valid

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
        |> Jpipe.custom (optionalField ":@computed_region_cbhk_fwbd" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField ":@computed_region_nnqa_25f4" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "fall" fall
        |> Jpipe.custom (optionalField "geolocation" (Jdec.map Just geolocation) Nothing)
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.custom (optionalField "mass" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "nametype" nametype
        |> Jpipe.required "recclass" Jdec.string
        |> Jpipe.custom (optionalField "reclat" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "reclong" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "year" (Jdec.map Just Jdec.string) Nothing)

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ (":@computed_region_cbhk_fwbd", makeNullableEncoder Jenc.string x.computedRegionCbhkFwbd)
        , (":@computed_region_nnqa_25f4", makeNullableEncoder Jenc.string x.computedRegionNnqa25F4)
        , ("fall", encodeFall x.fall)
        , ("geolocation", makeNullableEncoder encodeGeolocation x.geolocation)
        , ("id", Jenc.string x.id)
        , ("mass", makeNullableEncoder Jenc.string x.mass)
        , ("name", Jenc.string x.name)
        , ("nametype", encodeNametype x.nametype)
        , ("recclass", Jenc.string x.recclass)
        , ("reclat", makeNullableEncoder Jenc.string x.reclat)
        , ("reclong", makeNullableEncoder Jenc.string x.reclong)
        , ("year", makeNullableEncoder Jenc.string x.year)
        ]

fall : Jdec.Decoder Fall
fall =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Fell" -> Jdec.succeed Fell
                "Found" -> Jdec.succeed Found
                somethingElse -> Jdec.fail <| "Invalid Fall: " ++ somethingElse
        )

encodeFall : Fall -> Jenc.Value
encodeFall x = case x of
    Fell -> Jenc.string "Fell"
    Found -> Jenc.string "Found"

geolocation : Jdec.Decoder Geolocation
geolocation =
    Jdec.succeed Geolocation
        |> Jpipe.required "coordinates" (Jdec.list Jdec.float )
        |> Jpipe.required "type" purpleType

encodeGeolocation : Geolocation -> Jenc.Value
encodeGeolocation x =
    Jenc.object
        [ ("coordinates", Jenc.list Jenc.float x.coordinates)
        , ("type", encodeType x.geolocationType)
        ]

purpleType : Jdec.Decoder Type
purpleType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Point" -> Jdec.succeed Point
                somethingElse -> Jdec.fail <| "Invalid Type: " ++ somethingElse
        )

encodeType : Type -> Jenc.Value
encodeType x = case x of
    Point -> Jenc.string "Point"

nametype : Jdec.Decoder Nametype
nametype =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Valid" -> Jdec.succeed Valid
                somethingElse -> Jdec.fail <| "Invalid Nametype: " ++ somethingElse
        )

encodeNametype : Nametype -> Jenc.Value
encodeNametype x = case x of
    Valid -> Jenc.string "Valid"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
