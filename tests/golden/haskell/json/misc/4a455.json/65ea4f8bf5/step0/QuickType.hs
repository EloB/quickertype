{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , CRS (..)
    , CRSProperties (..)
    , Feature (..)
    , Geometry (..)
    , FeatureProperties (..)
    , FeatureType (..)
    , GeometryType (..)
    , GeometryName (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { crsQuickType :: CRS
    , featuresQuickType :: [Feature]
    , quickTypeTypeQuickType :: Text
    , totalFeaturesQuickType :: Int
    } deriving (Show)

data CRS = CRS
    { crsTypeCRS :: Text
    , propertiesCRS :: CRSProperties
    } deriving (Show)

data CRSProperties = CRSProperties
    { nameCRSProperties :: Text
    } deriving (Show)

data Feature = Feature
    { featureIDFeature :: Text
    , featureTypeFeature :: FeatureType
    , geometryFeature :: Geometry
    , geometryNameFeature :: GeometryName
    , propertiesFeature :: FeatureProperties
    } deriving (Show)

data FeatureType
    = FeatureFeatureType
    deriving (Show)

data Geometry = Geometry
    { coordinatesGeometry :: [([Double])]
    , geometryTypeGeometry :: GeometryType
    } deriving (Show)

data GeometryType
    = MultiPointGeometryType
    deriving (Show)

data GeometryName
    = GeomGeometryName
    deriving (Show)

data FeatureProperties = FeatureProperties
    { facebookaccountFeatureProperties :: Text
    , frequencyfinderurlFeatureProperties :: Text
    , nameFeatureProperties :: Text
    , siteurlFeatureProperties :: Text
    , streetaddressFeatureProperties :: Text
    , twitteraccountFeatureProperties :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType crsQuickType featuresQuickType quickTypeTypeQuickType totalFeaturesQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "crs" .= crsQuickType
        , Just $ "features" .= featuresQuickType
        , Just $ "type" .= quickTypeTypeQuickType
        , Just $ "totalFeatures" .= totalFeaturesQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "crs"
        <*> v .: "features"
        <*> v .: "type"
        <*> v .: "totalFeatures"

instance ToJSON CRS where
    toJSON (CRS crsTypeCRS propertiesCRS) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= crsTypeCRS
        , Just $ "properties" .= propertiesCRS
        ]

instance FromJSON CRS where
    parseJSON (Object v) = CRS
        <$> v .: "type"
        <*> v .: "properties"

instance ToJSON CRSProperties where
    toJSON (CRSProperties nameCRSProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameCRSProperties
        ]

instance FromJSON CRSProperties where
    parseJSON (Object v) = CRSProperties
        <$> v .: "name"

instance ToJSON Feature where
    toJSON (Feature featureIDFeature featureTypeFeature geometryFeature geometryNameFeature propertiesFeature) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= featureIDFeature
        , Just $ "type" .= featureTypeFeature
        , Just $ "geometry" .= geometryFeature
        , Just $ "geometry_name" .= geometryNameFeature
        , Just $ "properties" .= propertiesFeature
        ]

instance FromJSON Feature where
    parseJSON (Object v) = Feature
        <$> v .: "id"
        <*> v .: "type"
        <*> v .: "geometry"
        <*> v .: "geometry_name"
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
    toJSON MultiPointGeometryType = "MultiPoint"

instance FromJSON GeometryType where
    parseJSON = withText "GeometryType" parseText
        where
            parseText "MultiPoint" = return MultiPointGeometryType

instance ToJSON GeometryName where
    toJSON GeomGeometryName = "geom"

instance FromJSON GeometryName where
    parseJSON = withText "GeometryName" parseText
        where
            parseText "geom" = return GeomGeometryName

instance ToJSON FeatureProperties where
    toJSON (FeatureProperties facebookaccountFeatureProperties frequencyfinderurlFeatureProperties nameFeatureProperties siteurlFeatureProperties streetaddressFeatureProperties twitteraccountFeatureProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "facebookaccount" .= facebookaccountFeatureProperties
        , Just $ "frequencyfinderurl" .= frequencyfinderurlFeatureProperties
        , Just $ "name" .= nameFeatureProperties
        , Just $ "siteurl" .= siteurlFeatureProperties
        , Just $ "streetaddress" .= streetaddressFeatureProperties
        , Just $ "twitteraccount" .= twitteraccountFeatureProperties
        ]

instance FromJSON FeatureProperties where
    parseJSON (Object v) = FeatureProperties
        <$> v .: "facebookaccount"
        <*> v .: "frequencyfinderurl"
        <*> v .: "name"
        <*> v .: "siteurl"
        <*> v .: "streetaddress"
        <*> v .: "twitteraccount"
