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
    , Coordinate
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { coordinates : Maybe (List Coordinate)
    , count : Maybe Int
    , label : Maybe String
    , requiredCoordinates : List Coordinate
    , requiredCount : Int
    , requiredLabel : String
    , weight : Maybe Float
    }

type alias Coordinate =
    { latitude : Float
    , longitude : Float
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
        |> Jpipe.custom (optionalField "coordinates" (Jdec.map Just (Jdec.list coordinate )) Nothing)
        |> Jpipe.custom (optionalField "count" (Jdec.map Just (Jdec.andThen (\x -> if x >= 1 && x <= 100 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)) Nothing)
        |> Jpipe.custom (optionalField "label" (Jdec.map Just (Jdec.andThen (\x -> if List.length (String.toList x) >= 2 && List.length (String.toList x) <= 16 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)) Nothing)
        |> Jpipe.required "requiredCoordinates" (Jdec.list coordinate )
        |> Jpipe.required "requiredCount" (Jdec.andThen (\x -> if x >= 1 && x <= 100 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.int)
        |> Jpipe.required "requiredLabel" (Jdec.andThen (\x -> if List.length (String.toList x) >= 2 && List.length (String.toList x) <= 16 then Jdec.succeed x else Jdec.fail "String length out of range") Jdec.string)
        |> Jpipe.custom (optionalField "weight" (Jdec.map Just (Jdec.andThen (\x -> if x >= 0.5 && x <= 99.5 then Jdec.succeed x else Jdec.fail "Number out of range") Jdec.float)) Nothing)

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("coordinates", makeNullableEncoder (Jenc.list encodeCoordinate) x.coordinates)
        , ("count", makeNullableEncoder Jenc.int x.count)
        , ("label", makeNullableEncoder Jenc.string x.label)
        , ("requiredCoordinates", Jenc.list encodeCoordinate x.requiredCoordinates)
        , ("requiredCount", Jenc.int x.requiredCount)
        , ("requiredLabel", Jenc.string x.requiredLabel)
        , ("weight", makeNullableEncoder Jenc.float x.weight)
        ]

coordinate : Jdec.Decoder Coordinate
coordinate =
    Jdec.succeed Coordinate
        |> Jpipe.required "latitude" Jdec.float
        |> Jpipe.required "longitude" Jdec.float

encodeCoordinate : Coordinate -> Jenc.Value
encodeCoordinate x =
    Jenc.object
        [ ("latitude", Jenc.float x.latitude)
        , ("longitude", Jenc.float x.longitude)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
