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
    , FeatureElement
    , Geometry
    , Properties
    , FeatureType(..)
    , GeometryType(..)
    , Class(..)
    , MaintainingAuthority(..)
    , Ward(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { features : List FeatureElement
    , name : String
    , quickTypeType : String
    }

type alias FeatureElement =
    { featureType : FeatureType
    , geometry : Geometry
    , properties : Properties
    }

type FeatureType
    = Feature

type alias Geometry =
    { coordinates : List Float
    , geometryType : GeometryType
    }

type GeometryType
    = Point

type alias Properties =
    { area : String
    , centralAssetID : String
    , class : Class
    , featureLocation : String
    , lat : String
    , long : String
    , maintainingAuthority : MaintainingAuthority
    , number : String
    , siteName : String
    , ward : Ward
    }

type Class
    = NoCodeAllocated
    | OSDistrict
    | OSNeighbourhood
    | OSRegional

type MaintainingAuthority
    = CityOfBallarat

type Ward
    = South
    | North
    | Central

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
        |> Jpipe.required "features" (Jdec.list featureElement )
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "type" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("features", Jenc.list encodeFeatureElement x.features)
        , ("name", Jenc.string x.name)
        , ("type", Jenc.string x.quickTypeType)
        ]

featureElement : Jdec.Decoder FeatureElement
featureElement =
    Jdec.succeed FeatureElement
        |> Jpipe.required "type" featureType
        |> Jpipe.required "geometry" geometry
        |> Jpipe.required "properties" properties

encodeFeatureElement : FeatureElement -> Jenc.Value
encodeFeatureElement x =
    Jenc.object
        [ ("type", encodeFeatureType x.featureType)
        , ("geometry", encodeGeometry x.geometry)
        , ("properties", encodeProperties x.properties)
        ]

featureType : Jdec.Decoder FeatureType
featureType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Feature" -> Jdec.succeed Feature
                somethingElse -> Jdec.fail <| "Invalid FeatureType: " ++ somethingElse
        )

encodeFeatureType : FeatureType -> Jenc.Value
encodeFeatureType x = case x of
    Feature -> Jenc.string "Feature"

geometry : Jdec.Decoder Geometry
geometry =
    Jdec.succeed Geometry
        |> Jpipe.required "coordinates" (Jdec.list Jdec.float )
        |> Jpipe.required "type" geometryType

encodeGeometry : Geometry -> Jenc.Value
encodeGeometry x =
    Jenc.object
        [ ("coordinates", Jenc.list Jenc.float x.coordinates)
        , ("type", encodeGeometryType x.geometryType)
        ]

geometryType : Jdec.Decoder GeometryType
geometryType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Point" -> Jdec.succeed Point
                somethingElse -> Jdec.fail <| "Invalid GeometryType: " ++ somethingElse
        )

encodeGeometryType : GeometryType -> Jenc.Value
encodeGeometryType x = case x of
    Point -> Jenc.string "Point"

properties : Jdec.Decoder Properties
properties =
    Jdec.succeed Properties
        |> Jpipe.required "Area" Jdec.string
        |> Jpipe.required "Central Asset ID" Jdec.string
        |> Jpipe.required "Class" class
        |> Jpipe.required "Feature Location" Jdec.string
        |> Jpipe.required "lat" Jdec.string
        |> Jpipe.required "long" Jdec.string
        |> Jpipe.required "Maintaining Authority" maintainingAuthority
        |> Jpipe.required "Number" Jdec.string
        |> Jpipe.required "Site Name" Jdec.string
        |> Jpipe.required "Ward" ward

encodeProperties : Properties -> Jenc.Value
encodeProperties x =
    Jenc.object
        [ ("Area", Jenc.string x.area)
        , ("Central Asset ID", Jenc.string x.centralAssetID)
        , ("Class", encodeClass x.class)
        , ("Feature Location", Jenc.string x.featureLocation)
        , ("lat", Jenc.string x.lat)
        , ("long", Jenc.string x.long)
        , ("Maintaining Authority", encodeMaintainingAuthority x.maintainingAuthority)
        , ("Number", Jenc.string x.number)
        , ("Site Name", Jenc.string x.siteName)
        , ("Ward", encodeWard x.ward)
        ]

class : Jdec.Decoder Class
class =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "No Code Allocated" -> Jdec.succeed NoCodeAllocated
                "OS-District" -> Jdec.succeed OSDistrict
                "OS-Neighbourhood" -> Jdec.succeed OSNeighbourhood
                "OS-Regional" -> Jdec.succeed OSRegional
                somethingElse -> Jdec.fail <| "Invalid Class: " ++ somethingElse
        )

encodeClass : Class -> Jenc.Value
encodeClass x = case x of
    NoCodeAllocated -> Jenc.string "No Code Allocated"
    OSDistrict -> Jenc.string "OS-District"
    OSNeighbourhood -> Jenc.string "OS-Neighbourhood"
    OSRegional -> Jenc.string "OS-Regional"

maintainingAuthority : Jdec.Decoder MaintainingAuthority
maintainingAuthority =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "City of Ballarat" -> Jdec.succeed CityOfBallarat
                somethingElse -> Jdec.fail <| "Invalid MaintainingAuthority: " ++ somethingElse
        )

encodeMaintainingAuthority : MaintainingAuthority -> Jenc.Value
encodeMaintainingAuthority x = case x of
    CityOfBallarat -> Jenc.string "City of Ballarat"

ward : Jdec.Decoder Ward
ward =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "South" -> Jdec.succeed South
                "North" -> Jdec.succeed North
                "Central" -> Jdec.succeed Central
                somethingElse -> Jdec.fail <| "Invalid Ward: " ++ somethingElse
        )

encodeWard : Ward -> Jenc.Value
encodeWard x = case x of
    South -> Jenc.string "South"
    North -> Jenc.string "North"
    Central -> Jenc.string "Central"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
