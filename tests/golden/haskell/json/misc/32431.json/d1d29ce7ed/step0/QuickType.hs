{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Feature (..)
    , Geometry (..)
    , Properties (..)
    , Metadata (..)
    , FeatureType (..)
    , GeometryType (..)
    , MagType (..)
    , PropertiesType (..)
    , Status (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { bboxQuickType :: [Double]
    , featuresQuickType :: [Feature]
    , metadataQuickType :: Metadata
    , quickTypeTypeQuickType :: Text
    } deriving (Show)

data Feature = Feature
    { featureIDFeature :: Text
    , featureTypeFeature :: FeatureType
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
    { alertProperties :: Maybe Text
    , cdiProperties :: Maybe Text
    , codeProperties :: Text
    , detailProperties :: Text
    , dminProperties :: Maybe Double
    , feltProperties :: Maybe Text
    , gapProperties :: Maybe Int
    , idsProperties :: Text
    , magProperties :: Double
    , magTypeProperties :: MagType
    , mmiProperties :: Maybe Text
    , netProperties :: Text
    , nstProperties :: Maybe Int
    , placeProperties :: Text
    , propertiesTypeProperties :: PropertiesType
    , rmsProperties :: Double
    , sigProperties :: Int
    , sourcesProperties :: Text
    , statusProperties :: Status
    , timeProperties :: Int
    , titleProperties :: Text
    , tsunamiProperties :: Int
    , typesProperties :: Text
    , tzProperties :: Int
    , updatedProperties :: Int
    , urlProperties :: Text
    } deriving (Show)

data MagType
    = MdMagType
    | MlMagType
    | MBMagType
    deriving (Show)

data PropertiesType
    = EarthquakePropertiesType
    deriving (Show)

data Status
    = AutomaticStatus
    | ReviewedStatus
    deriving (Show)

data Metadata = Metadata
    { apiMetadata :: Text
    , countMetadata :: Int
    , generatedMetadata :: Int
    , statusMetadata :: Int
    , titleMetadata :: Text
    , urlMetadata :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType bboxQuickType featuresQuickType metadataQuickType quickTypeTypeQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "bbox" .= bboxQuickType
        , Just $ "features" .= featuresQuickType
        , Just $ "metadata" .= metadataQuickType
        , Just $ "type" .= quickTypeTypeQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "bbox"
        <*> v .: "features"
        <*> v .: "metadata"
        <*> v .: "type"

instance ToJSON Feature where
    toJSON (Feature featureIDFeature featureTypeFeature geometryFeature propertiesFeature) =
        object $ foldMap (maybe [] pure)
        [ Just $ "id" .= featureIDFeature
        , Just $ "type" .= featureTypeFeature
        , Just $ "geometry" .= geometryFeature
        , Just $ "properties" .= propertiesFeature
        ]

instance FromJSON Feature where
    parseJSON (Object v) = Feature
        <$> v .: "id"
        <*> v .: "type"
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
    toJSON (Properties alertProperties cdiProperties codeProperties detailProperties dminProperties feltProperties gapProperties idsProperties magProperties magTypeProperties mmiProperties netProperties nstProperties placeProperties propertiesTypeProperties rmsProperties sigProperties sourcesProperties statusProperties timeProperties titleProperties tsunamiProperties typesProperties tzProperties updatedProperties urlProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "alert" .= alertProperties
        , Just $ "cdi" .= cdiProperties
        , Just $ "code" .= codeProperties
        , Just $ "detail" .= detailProperties
        , Just $ "dmin" .= dminProperties
        , Just $ "felt" .= feltProperties
        , Just $ "gap" .= gapProperties
        , Just $ "ids" .= idsProperties
        , Just $ "mag" .= magProperties
        , Just $ "magType" .= magTypeProperties
        , Just $ "mmi" .= mmiProperties
        , Just $ "net" .= netProperties
        , Just $ "nst" .= nstProperties
        , Just $ "place" .= placeProperties
        , Just $ "type" .= propertiesTypeProperties
        , Just $ "rms" .= rmsProperties
        , Just $ "sig" .= sigProperties
        , Just $ "sources" .= sourcesProperties
        , Just $ "status" .= statusProperties
        , Just $ "time" .= timeProperties
        , Just $ "title" .= titleProperties
        , Just $ "tsunami" .= tsunamiProperties
        , Just $ "types" .= typesProperties
        , Just $ "tz" .= tzProperties
        , Just $ "updated" .= updatedProperties
        , Just $ "url" .= urlProperties
        ]

instance FromJSON Properties where
    parseJSON (Object v) = Properties
        <$> v .: "alert"
        <*> v .: "cdi"
        <*> v .: "code"
        <*> v .: "detail"
        <*> v .: "dmin"
        <*> v .: "felt"
        <*> v .: "gap"
        <*> v .: "ids"
        <*> v .: "mag"
        <*> v .: "magType"
        <*> v .: "mmi"
        <*> v .: "net"
        <*> v .: "nst"
        <*> v .: "place"
        <*> v .: "type"
        <*> v .: "rms"
        <*> v .: "sig"
        <*> v .: "sources"
        <*> v .: "status"
        <*> v .: "time"
        <*> v .: "title"
        <*> v .: "tsunami"
        <*> v .: "types"
        <*> v .: "tz"
        <*> v .: "updated"
        <*> v .: "url"

instance ToJSON MagType where
    toJSON MdMagType = "md"
    toJSON MlMagType = "ml"
    toJSON MBMagType = "mb"

instance FromJSON MagType where
    parseJSON = withText "MagType" parseText
        where
            parseText "md" = return MdMagType
            parseText "ml" = return MlMagType
            parseText "mb" = return MBMagType

instance ToJSON PropertiesType where
    toJSON EarthquakePropertiesType = "earthquake"

instance FromJSON PropertiesType where
    parseJSON = withText "PropertiesType" parseText
        where
            parseText "earthquake" = return EarthquakePropertiesType

instance ToJSON Status where
    toJSON AutomaticStatus = "automatic"
    toJSON ReviewedStatus = "reviewed"

instance FromJSON Status where
    parseJSON = withText "Status" parseText
        where
            parseText "automatic" = return AutomaticStatus
            parseText "reviewed" = return ReviewedStatus

instance ToJSON Metadata where
    toJSON (Metadata apiMetadata countMetadata generatedMetadata statusMetadata titleMetadata urlMetadata) =
        object $ foldMap (maybe [] pure)
        [ Just $ "api" .= apiMetadata
        , Just $ "count" .= countMetadata
        , Just $ "generated" .= generatedMetadata
        , Just $ "status" .= statusMetadata
        , Just $ "title" .= titleMetadata
        , Just $ "url" .= urlMetadata
        ]

instance FromJSON Metadata where
    parseJSON (Object v) = Metadata
        <$> v .: "api"
        <*> v .: "count"
        <*> v .: "generated"
        <*> v .: "status"
        <*> v .: "title"
        <*> v .: "url"
