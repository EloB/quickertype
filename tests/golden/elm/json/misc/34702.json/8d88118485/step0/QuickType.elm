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
    , FireBanR(..)
    , PropertiesType(..)
    , Region(..)
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
    { coordinates : List Float
    , geometryType : GeometryType
    }

type GeometryType
    = Point

type GeometryName
    = Geom

type alias FeatureProperties =
    { division : String
    , fax : Float
    , fireBanR : Maybe FireBanR
    , latitude : Float
    , localGovt : String
    , longitude : Float
    , no : Maybe String
    , phone : Float
    , postcode : Int
    , propertiesType : Maybe PropertiesType
    , psa : String
    , region : Region
    , station : String
    , street : String
    , suburb : String
    }

type FireBanR
    = NorthCentral
    | Central
    | SouthWest
    | Wimmera
    | NorthernCountry
    | EastGippsland
    | NorthEast
    | Mallee
    | WestSouthGippsland
    | Ballarat

type PropertiesType
    = Street
    | Avenue
    | Road
    | Highway
    | Boulevard
    | Court
    | Way
    | Drive
    | South
    | Hill
    | Lane
    | Close
    | Parade
    | TypeRoad
    | Place
    | RD

type Region
    = Eastern
    | NorthernMetro
    | Western
    | SouthernMetro

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
        |> Jpipe.required "division" Jdec.string
        |> Jpipe.required "fax" Jdec.float
        |> Jpipe.required "fire_ban_r" (Jdec.nullable fireBanR)
        |> Jpipe.required "latitude" Jdec.float
        |> Jpipe.required "local_govt" Jdec.string
        |> Jpipe.required "longitude" Jdec.float
        |> Jpipe.required "no" (Jdec.nullable Jdec.string)
        |> Jpipe.required "phone" Jdec.float
        |> Jpipe.required "postcode" Jdec.int
        |> Jpipe.required "type" (Jdec.nullable propertiesType)
        |> Jpipe.required "psa" Jdec.string
        |> Jpipe.required "region" region
        |> Jpipe.required "station" Jdec.string
        |> Jpipe.required "street" Jdec.string
        |> Jpipe.required "suburb" Jdec.string

encodeFeatureProperties : FeatureProperties -> Jenc.Value
encodeFeatureProperties x =
    Jenc.object
        [ ("division", Jenc.string x.division)
        , ("fax", Jenc.float x.fax)
        , ("fire_ban_r", makeNullableEncoder encodeFireBanR x.fireBanR)
        , ("latitude", Jenc.float x.latitude)
        , ("local_govt", Jenc.string x.localGovt)
        , ("longitude", Jenc.float x.longitude)
        , ("no", makeNullableEncoder Jenc.string x.no)
        , ("phone", Jenc.float x.phone)
        , ("postcode", Jenc.int x.postcode)
        , ("type", makeNullableEncoder encodePropertiesType x.propertiesType)
        , ("psa", Jenc.string x.psa)
        , ("region", encodeRegion x.region)
        , ("station", Jenc.string x.station)
        , ("street", Jenc.string x.street)
        , ("suburb", Jenc.string x.suburb)
        ]

fireBanR : Jdec.Decoder FireBanR
fireBanR =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "North Central" -> Jdec.succeed NorthCentral
                "Central" -> Jdec.succeed Central
                "South West" -> Jdec.succeed SouthWest
                "Wimmera" -> Jdec.succeed Wimmera
                "Northern Country" -> Jdec.succeed NorthernCountry
                "East Gippsland" -> Jdec.succeed EastGippsland
                "North East" -> Jdec.succeed NorthEast
                "Mallee" -> Jdec.succeed Mallee
                "West &South Gippsland" -> Jdec.succeed WestSouthGippsland
                "Ballarat" -> Jdec.succeed Ballarat
                somethingElse -> Jdec.fail <| "Invalid FireBanR: " ++ somethingElse
        )

encodeFireBanR : FireBanR -> Jenc.Value
encodeFireBanR x = case x of
    NorthCentral -> Jenc.string "North Central"
    Central -> Jenc.string "Central"
    SouthWest -> Jenc.string "South West"
    Wimmera -> Jenc.string "Wimmera"
    NorthernCountry -> Jenc.string "Northern Country"
    EastGippsland -> Jenc.string "East Gippsland"
    NorthEast -> Jenc.string "North East"
    Mallee -> Jenc.string "Mallee"
    WestSouthGippsland -> Jenc.string "West &South Gippsland"
    Ballarat -> Jenc.string "Ballarat"

propertiesType : Jdec.Decoder PropertiesType
propertiesType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "STREET" -> Jdec.succeed Street
                "AVENUE" -> Jdec.succeed Avenue
                "ROAD" -> Jdec.succeed Road
                "HIGHWAY" -> Jdec.succeed Highway
                "BOULEVARD" -> Jdec.succeed Boulevard
                "COURT" -> Jdec.succeed Court
                "WAY" -> Jdec.succeed Way
                "DRIVE" -> Jdec.succeed Drive
                "SOUTH" -> Jdec.succeed South
                "HILL" -> Jdec.succeed Hill
                "LANE" -> Jdec.succeed Lane
                "CLOSE" -> Jdec.succeed Close
                "PARADE" -> Jdec.succeed Parade
                "Road" -> Jdec.succeed TypeRoad
                "PLACE" -> Jdec.succeed Place
                "RD" -> Jdec.succeed RD
                somethingElse -> Jdec.fail <| "Invalid PropertiesType: " ++ somethingElse
        )

encodePropertiesType : PropertiesType -> Jenc.Value
encodePropertiesType x = case x of
    Street -> Jenc.string "STREET"
    Avenue -> Jenc.string "AVENUE"
    Road -> Jenc.string "ROAD"
    Highway -> Jenc.string "HIGHWAY"
    Boulevard -> Jenc.string "BOULEVARD"
    Court -> Jenc.string "COURT"
    Way -> Jenc.string "WAY"
    Drive -> Jenc.string "DRIVE"
    South -> Jenc.string "SOUTH"
    Hill -> Jenc.string "HILL"
    Lane -> Jenc.string "LANE"
    Close -> Jenc.string "CLOSE"
    Parade -> Jenc.string "PARADE"
    TypeRoad -> Jenc.string "Road"
    Place -> Jenc.string "PLACE"
    RD -> Jenc.string "RD"

region : Jdec.Decoder Region
region =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "Eastern" -> Jdec.succeed Eastern
                "Northern Metro" -> Jdec.succeed NorthernMetro
                "Western" -> Jdec.succeed Western
                "Southern Metro" -> Jdec.succeed SouthernMetro
                somethingElse -> Jdec.fail <| "Invalid Region: " ++ somethingElse
        )

encodeRegion : Region -> Jenc.Value
encodeRegion x = case x of
    Eastern -> Jenc.string "Eastern"
    NorthernMetro -> Jenc.string "Northern Metro"
    Western -> Jenc.string "Western"
    SouthernMetro -> Jenc.string "Southern Metro"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
