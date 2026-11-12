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
    , CRS
    , CRSProperties
    , FeatureElement
    , Geometry
    , FeatureProperties
    , FeatureType(..)
    , GeometryType(..)
    , GeometryName(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { crs : CRS
    , features : List FeatureElement
    , quickTypeType : String
    , totalFeatures : Int
    }

type alias CRS =
    { crsType : String
    , properties : CRSProperties
    }

type alias CRSProperties =
    { name : String
    }

type alias FeatureElement =
    { featureType : FeatureType
    , geometry : Geometry
    , geometryName : GeometryName
    , id : String
    , properties : FeatureProperties
    }

type FeatureType
    = Feature

type alias Geometry =
    { coordinates : List (List Float)
    , geometryType : GeometryType
    }

type GeometryType
    = MultiPoint

type GeometryName
    = Geom

type alias FeatureProperties =
    { facebookaccount : String
    , frequencyfinderurl : String
    , name : String
    , siteurl : String
    , streetaddress : String
    , twitteraccount : String
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
        |> Jpipe.required "crs" crs
        |> Jpipe.required "features" (Jdec.list featureElement )
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "totalFeatures" Jdec.int

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("crs", encodeCRS x.crs)
        , ("features", Jenc.list encodeFeatureElement x.features)
        , ("type", Jenc.string x.quickTypeType)
        , ("totalFeatures", Jenc.int x.totalFeatures)
        ]

crs : Jdec.Decoder CRS
crs =
    Jdec.succeed CRS
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "properties" crsProperties

encodeCRS : CRS -> Jenc.Value
encodeCRS x =
    Jenc.object
        [ ("type", Jenc.string x.crsType)
        , ("properties", encodeCRSProperties x.properties)
        ]

crsProperties : Jdec.Decoder CRSProperties
crsProperties =
    Jdec.succeed CRSProperties
        |> Jpipe.required "name" Jdec.string

encodeCRSProperties : CRSProperties -> Jenc.Value
encodeCRSProperties x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        ]

featureElement : Jdec.Decoder FeatureElement
featureElement =
    Jdec.succeed FeatureElement
        |> Jpipe.required "type" featureType
        |> Jpipe.required "geometry" geometry
        |> Jpipe.required "geometry_name" geometryName
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "properties" featureProperties

encodeFeatureElement : FeatureElement -> Jenc.Value
encodeFeatureElement x =
    Jenc.object
        [ ("type", encodeFeatureType x.featureType)
        , ("geometry", encodeGeometry x.geometry)
        , ("geometry_name", encodeGeometryName x.geometryName)
        , ("id", Jenc.string x.id)
        , ("properties", encodeFeatureProperties x.properties)
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
        |> Jpipe.required "coordinates" (Jdec.list (Jdec.list Jdec.float ) )
        |> Jpipe.required "type" geometryType

encodeGeometry : Geometry -> Jenc.Value
encodeGeometry x =
    Jenc.object
        [ ("coordinates", Jenc.list (Jenc.list Jenc.float) x.coordinates)
        , ("type", encodeGeometryType x.geometryType)
        ]

geometryType : Jdec.Decoder GeometryType
geometryType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "MultiPoint" -> Jdec.succeed MultiPoint
                somethingElse -> Jdec.fail <| "Invalid GeometryType: " ++ somethingElse
        )

encodeGeometryType : GeometryType -> Jenc.Value
encodeGeometryType x = case x of
    MultiPoint -> Jenc.string "MultiPoint"

geometryName : Jdec.Decoder GeometryName
geometryName =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "geom" -> Jdec.succeed Geom
                somethingElse -> Jdec.fail <| "Invalid GeometryName: " ++ somethingElse
        )

encodeGeometryName : GeometryName -> Jenc.Value
encodeGeometryName x = case x of
    Geom -> Jenc.string "geom"

featureProperties : Jdec.Decoder FeatureProperties
featureProperties =
    Jdec.succeed FeatureProperties
        |> Jpipe.required "facebookaccount" Jdec.string
        |> Jpipe.required "frequencyfinderurl" Jdec.string
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "siteurl" Jdec.string
        |> Jpipe.required "streetaddress" Jdec.string
        |> Jpipe.required "twitteraccount" Jdec.string

encodeFeatureProperties : FeatureProperties -> Jenc.Value
encodeFeatureProperties x =
    Jenc.object
        [ ("facebookaccount", Jenc.string x.facebookaccount)
        , ("frequencyfinderurl", Jenc.string x.frequencyfinderurl)
        , ("name", Jenc.string x.name)
        , ("siteurl", Jenc.string x.siteurl)
        , ("streetaddress", Jenc.string x.streetaddress)
        , ("twitteraccount", Jenc.string x.twitteraccount)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
