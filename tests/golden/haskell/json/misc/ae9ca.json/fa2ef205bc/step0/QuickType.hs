{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Feature (..)
    , Geometry (..)
    , Properties (..)
    , FeatureType (..)
    , GeometryType (..)
    , MaintainingAuthority (..)
    , Class (..)
    , Ward (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { featuresQuickType :: [Feature]
    , nameQuickType :: Text
    , quickTypeTypeQuickType :: Text
    } deriving (Show)

data Feature = Feature
    { featureTypeFeature :: FeatureType
    , geometryFeature :: Geometry
    , propertiesFeature :: Properties
    } deriving (Show)

data FeatureType
    = FeatureFeatureType
    deriving (Show)

data Geometry = Geometry
    { coordinatesGeometry :: [Double]
    , geometryTypeGeometry :: GeometryType
    } deriving (Show)

data GeometryType
    = PointGeometryType
    deriving (Show)

data Properties = Properties
    { areaProperties :: Text
    , centralAssetIDProperties :: Text
    , featureLocationProperties :: Text
    , latProperties :: Text
    , longProperties :: Text
    , maintainingAuthorityProperties :: MaintainingAuthority
    , numberProperties :: Text
    , propertiesClassProperties :: Class
    , siteNameProperties :: Text
    , wardProperties :: Ward
    } deriving (Show)

data MaintainingAuthority
    = CityOfBallaratMaintainingAuthority
    deriving (Show)

data Class
    = NoCodeAllocatedClass
    | OSDistrictClass
    | OSNeighbourhoodClass
    | OSRegionalClass
    deriving (Show)

data Ward
    = SouthWard
    | NorthWard
    | CentralWard
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType featuresQuickType nameQuickType quickTypeTypeQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "features" .= featuresQuickType
        , Just $ "name" .= nameQuickType
        , Just $ "type" .= quickTypeTypeQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "features"
        <*> v .: "name"
        <*> v .: "type"

instance ToJSON Feature where
    toJSON (Feature featureTypeFeature geometryFeature propertiesFeature) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= featureTypeFeature
        , Just $ "geometry" .= geometryFeature
        , Just $ "properties" .= propertiesFeature
        ]

instance FromJSON Feature where
    parseJSON (Object v) = Feature
        <$> v .: "type"
        <*> v .: "geometry"
        <*> v .: "properties"

instance ToJSON FeatureType where
    toJSON FeatureFeatureType = "Feature"

instance FromJSON FeatureType where
    parseJSON = withText "FeatureType" parseText
        where
            parseText "Feature" = return FeatureFeatureType

instance ToJSON Geometry where
    toJSON (Geometry coordinatesGeometry geometryTypeGeometry) =
        object $ foldMap (maybe [] pure)
        [ Just $ "coordinates" .= coordinatesGeometry
        , Just $ "type" .= geometryTypeGeometry
        ]

instance FromJSON Geometry where
    parseJSON (Object v) = Geometry
        <$> v .: "coordinates"
        <*> v .: "type"

instance ToJSON GeometryType where
    toJSON PointGeometryType = "Point"

instance FromJSON GeometryType where
    parseJSON = withText "GeometryType" parseText
        where
            parseText "Point" = return PointGeometryType

instance ToJSON Properties where
    toJSON (Properties areaProperties centralAssetIDProperties featureLocationProperties latProperties longProperties maintainingAuthorityProperties numberProperties propertiesClassProperties siteNameProperties wardProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Area" .= areaProperties
        , Just $ "Central Asset ID" .= centralAssetIDProperties
        , Just $ "Feature Location" .= featureLocationProperties
        , Just $ "lat" .= latProperties
        , Just $ "long" .= longProperties
        , Just $ "Maintaining Authority" .= maintainingAuthorityProperties
        , Just $ "Number" .= numberProperties
        , Just $ "Class" .= propertiesClassProperties
        , Just $ "Site Name" .= siteNameProperties
        , Just $ "Ward" .= wardProperties
        ]

instance FromJSON Properties where
    parseJSON (Object v) = Properties
        <$> v .: "Area"
        <*> v .: "Central Asset ID"
        <*> v .: "Feature Location"
        <*> v .: "lat"
        <*> v .: "long"
        <*> v .: "Maintaining Authority"
        <*> v .: "Number"
        <*> v .: "Class"
        <*> v .: "Site Name"
        <*> v .: "Ward"

instance ToJSON MaintainingAuthority where
    toJSON CityOfBallaratMaintainingAuthority = "City of Ballarat"

instance FromJSON MaintainingAuthority where
    parseJSON = withText "MaintainingAuthority" parseText
        where
            parseText "City of Ballarat" = return CityOfBallaratMaintainingAuthority

instance ToJSON Class where
    toJSON NoCodeAllocatedClass = "No Code Allocated"
    toJSON OSDistrictClass = "OS-District"
    toJSON OSNeighbourhoodClass = "OS-Neighbourhood"
    toJSON OSRegionalClass = "OS-Regional"

instance FromJSON Class where
    parseJSON = withText "Class" parseText
        where
            parseText "No Code Allocated" = return NoCodeAllocatedClass
            parseText "OS-District" = return OSDistrictClass
            parseText "OS-Neighbourhood" = return OSNeighbourhoodClass
            parseText "OS-Regional" = return OSRegionalClass

instance ToJSON Ward where
    toJSON SouthWard = "South"
    toJSON NorthWard = "North"
    toJSON CentralWard = "Central"

instance FromJSON Ward where
    parseJSON = withText "Ward" parseText
        where
            parseText "South" = return SouthWard
            parseText "North" = return NorthWard
            parseText "Central" = return CentralWard
