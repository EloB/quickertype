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
    , Metadata
    , FeatureType(..)
    , GeometryType(..)
    , MagType(..)
    , PropertiesType(..)
    , Status(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { bbox : List Float
    , features : List FeatureElement
    , metadata : Metadata
    , quickTypeType : String
    }

type alias FeatureElement =
    { featureType : FeatureType
    , geometry : Geometry
    , id : String
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
    { alert : ()
    , cdi : ()
    , code : String
    , detail : String
    , dmin : Maybe Float
    , felt : ()
    , gap : Maybe Int
    , ids : String
    , mag : Float
    , magType : MagType
    , mmi : ()
    , net : String
    , nst : Maybe Int
    , place : String
    , propertiesType : PropertiesType
    , rms : Float
    , sig : Int
    , sources : String
    , status : Status
    , time : Int
    , title : String
    , tsunami : Int
    , types : String
    , tz : Int
    , updated : Int
    , url : String
    }

type MagType
    = Md
    | Ml
    | MB

type PropertiesType
    = Earthquake

type Status
    = Automatic
    | Reviewed

type alias Metadata =
    { api : String
    , count : Int
    , generated : Int
    , status : Int
    , title : String
    , url : String
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
        |> Jpipe.required "bbox" (Jdec.list Jdec.float )
        |> Jpipe.required "features" (Jdec.list featureElement )
        |> Jpipe.required "metadata" metadata
        |> Jpipe.required "type" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("bbox", Jenc.list Jenc.float x.bbox)
        , ("features", Jenc.list encodeFeatureElement x.features)
        , ("metadata", encodeMetadata x.metadata)
        , ("type", Jenc.string x.quickTypeType)
        ]

featureElement : Jdec.Decoder FeatureElement
featureElement =
    Jdec.succeed FeatureElement
        |> Jpipe.required "type" featureType
        |> Jpipe.required "geometry" geometry
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "properties" properties

encodeFeatureElement : FeatureElement -> Jenc.Value
encodeFeatureElement x =
    Jenc.object
        [ ("type", encodeFeatureType x.featureType)
        , ("geometry", encodeGeometry x.geometry)
        , ("id", Jenc.string x.id)
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
        |> Jpipe.required "alert" (Jdec.null ())
        |> Jpipe.required "cdi" (Jdec.null ())
        |> Jpipe.required "code" Jdec.string
        |> Jpipe.required "detail" Jdec.string
        |> Jpipe.required "dmin" (Jdec.nullable Jdec.float)
        |> Jpipe.required "felt" (Jdec.null ())
        |> Jpipe.required "gap" (Jdec.nullable Jdec.int)
        |> Jpipe.required "ids" Jdec.string
        |> Jpipe.required "mag" Jdec.float
        |> Jpipe.required "magType" magType
        |> Jpipe.required "mmi" (Jdec.null ())
        |> Jpipe.required "net" Jdec.string
        |> Jpipe.required "nst" (Jdec.nullable Jdec.int)
        |> Jpipe.required "place" Jdec.string
        |> Jpipe.required "type" propertiesType
        |> Jpipe.required "rms" Jdec.float
        |> Jpipe.required "sig" Jdec.int
        |> Jpipe.required "sources" Jdec.string
        |> Jpipe.required "status" status
        |> Jpipe.required "time" Jdec.int
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "tsunami" Jdec.int
        |> Jpipe.required "types" Jdec.string
        |> Jpipe.required "tz" Jdec.int
        |> Jpipe.required "updated" Jdec.int
        |> Jpipe.required "url" Jdec.string

encodeProperties : Properties -> Jenc.Value
encodeProperties x =
    Jenc.object
        [ ("alert", always Jenc.null x.alert)
        , ("cdi", always Jenc.null x.cdi)
        , ("code", Jenc.string x.code)
        , ("detail", Jenc.string x.detail)
        , ("dmin", makeNullableEncoder Jenc.float x.dmin)
        , ("felt", always Jenc.null x.felt)
        , ("gap", makeNullableEncoder Jenc.int x.gap)
        , ("ids", Jenc.string x.ids)
        , ("mag", Jenc.float x.mag)
        , ("magType", encodeMagType x.magType)
        , ("mmi", always Jenc.null x.mmi)
        , ("net", Jenc.string x.net)
        , ("nst", makeNullableEncoder Jenc.int x.nst)
        , ("place", Jenc.string x.place)
        , ("type", encodePropertiesType x.propertiesType)
        , ("rms", Jenc.float x.rms)
        , ("sig", Jenc.int x.sig)
        , ("sources", Jenc.string x.sources)
        , ("status", encodeStatus x.status)
        , ("time", Jenc.int x.time)
        , ("title", Jenc.string x.title)
        , ("tsunami", Jenc.int x.tsunami)
        , ("types", Jenc.string x.types)
        , ("tz", Jenc.int x.tz)
        , ("updated", Jenc.int x.updated)
        , ("url", Jenc.string x.url)
        ]

magType : Jdec.Decoder MagType
magType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "md" -> Jdec.succeed Md
                "ml" -> Jdec.succeed Ml
                "mb" -> Jdec.succeed MB
                somethingElse -> Jdec.fail <| "Invalid MagType: " ++ somethingElse
        )

encodeMagType : MagType -> Jenc.Value
encodeMagType x = case x of
    Md -> Jenc.string "md"
    Ml -> Jenc.string "ml"
    MB -> Jenc.string "mb"

propertiesType : Jdec.Decoder PropertiesType
propertiesType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "earthquake" -> Jdec.succeed Earthquake
                somethingElse -> Jdec.fail <| "Invalid PropertiesType: " ++ somethingElse
        )

encodePropertiesType : PropertiesType -> Jenc.Value
encodePropertiesType x = case x of
    Earthquake -> Jenc.string "earthquake"

status : Jdec.Decoder Status
status =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "automatic" -> Jdec.succeed Automatic
                "reviewed" -> Jdec.succeed Reviewed
                somethingElse -> Jdec.fail <| "Invalid Status: " ++ somethingElse
        )

encodeStatus : Status -> Jenc.Value
encodeStatus x = case x of
    Automatic -> Jenc.string "automatic"
    Reviewed -> Jenc.string "reviewed"

metadata : Jdec.Decoder Metadata
metadata =
    Jdec.succeed Metadata
        |> Jpipe.required "api" Jdec.string
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "generated" Jdec.int
        |> Jpipe.required "status" Jdec.int
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "url" Jdec.string

encodeMetadata : Metadata -> Jenc.Value
encodeMetadata x =
    Jenc.object
        [ ("api", Jenc.string x.api)
        , ("count", Jenc.int x.count)
        , ("generated", Jenc.int x.generated)
        , ("status", Jenc.int x.status)
        , ("title", Jenc.string x.title)
        , ("url", Jenc.string x.url)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
