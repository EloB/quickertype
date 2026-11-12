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
    , FireBanR (..)
    , PropertiesType (..)
    , Region (..)
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
    { coordinatesGeometry :: [Double]
    , geometryTypeGeometry :: GeometryType
    } deriving (Show)

data GeometryType
    = PointGeometryType
    deriving (Show)

data GeometryName
    = GeomGeometryName
    deriving (Show)

data FeatureProperties = FeatureProperties
    { divisionFeatureProperties :: Text
    , faxFeatureProperties :: Double
    , fireBanRFeatureProperties :: Maybe FireBanR
    , latitudeFeatureProperties :: Double
    , localGovtFeatureProperties :: Text
    , longitudeFeatureProperties :: Double
    , noFeatureProperties :: Maybe Text
    , phoneFeatureProperties :: Double
    , postcodeFeatureProperties :: Int
    , propertiesTypeFeatureProperties :: Maybe PropertiesType
    , psaFeatureProperties :: Text
    , regionFeatureProperties :: Region
    , stationFeatureProperties :: Text
    , streetFeatureProperties :: Text
    , suburbFeatureProperties :: Text
    } deriving (Show)

data FireBanR
    = NorthCentralFireBanR
    | CentralFireBanR
    | SouthWestFireBanR
    | WimmeraFireBanR
    | NorthernCountryFireBanR
    | EastGippslandFireBanR
    | NorthEastFireBanR
    | MalleeFireBanR
    | WestSouthGippslandFireBanR
    | BallaratFireBanR
    deriving (Show)

data PropertiesType
    = STREETPropertiesType
    | AVENUEPropertiesType
    | ROADPropertiesType
    | HIGHWAYPropertiesType
    | BOULEVARDPropertiesType
    | COURTPropertiesType
    | WAYPropertiesType
    | DRIVEPropertiesType
    | SOUTHPropertiesType
    | HILLPropertiesType
    | LANEPropertiesType
    | CLOSEPropertiesType
    | PARADEPropertiesType
    | RoadPropertiesType
    | PLACEPropertiesType
    | RDPropertiesType
    deriving (Show)

data Region
    = EasternRegion
    | NorthernMetroRegion
    | WesternRegion
    | SouthernMetroRegion
    deriving (Show)

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
    toJSON PointGeometryType = "Point"

instance FromJSON GeometryType where
    parseJSON = withText "GeometryType" parseText
        where
            parseText "Point" = return PointGeometryType

instance ToJSON GeometryName where
    toJSON GeomGeometryName = "geom"

instance FromJSON GeometryName where
    parseJSON = withText "GeometryName" parseText
        where
            parseText "geom" = return GeomGeometryName

instance ToJSON FeatureProperties where
    toJSON (FeatureProperties divisionFeatureProperties faxFeatureProperties fireBanRFeatureProperties latitudeFeatureProperties localGovtFeatureProperties longitudeFeatureProperties noFeatureProperties phoneFeatureProperties postcodeFeatureProperties propertiesTypeFeatureProperties psaFeatureProperties regionFeatureProperties stationFeatureProperties streetFeatureProperties suburbFeatureProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "division" .= divisionFeatureProperties
        , Just $ "fax" .= faxFeatureProperties
        , Just $ "fire_ban_r" .= fireBanRFeatureProperties
        , Just $ "latitude" .= latitudeFeatureProperties
        , Just $ "local_govt" .= localGovtFeatureProperties
        , Just $ "longitude" .= longitudeFeatureProperties
        , Just $ "no" .= noFeatureProperties
        , Just $ "phone" .= phoneFeatureProperties
        , Just $ "postcode" .= postcodeFeatureProperties
        , Just $ "type" .= propertiesTypeFeatureProperties
        , Just $ "psa" .= psaFeatureProperties
        , Just $ "region" .= regionFeatureProperties
        , Just $ "station" .= stationFeatureProperties
        , Just $ "street" .= streetFeatureProperties
        , Just $ "suburb" .= suburbFeatureProperties
        ]

instance FromJSON FeatureProperties where
    parseJSON (Object v) = FeatureProperties
        <$> v .: "division"
        <*> v .: "fax"
        <*> v .: "fire_ban_r"
        <*> v .: "latitude"
        <*> v .: "local_govt"
        <*> v .: "longitude"
        <*> v .: "no"
        <*> v .: "phone"
        <*> v .: "postcode"
        <*> v .: "type"
        <*> v .: "psa"
        <*> v .: "region"
        <*> v .: "station"
        <*> v .: "street"
        <*> v .: "suburb"

instance ToJSON FireBanR where
    toJSON NorthCentralFireBanR = "North Central"
    toJSON CentralFireBanR = "Central"
    toJSON SouthWestFireBanR = "South West"
    toJSON WimmeraFireBanR = "Wimmera"
    toJSON NorthernCountryFireBanR = "Northern Country"
    toJSON EastGippslandFireBanR = "East Gippsland"
    toJSON NorthEastFireBanR = "North East"
    toJSON MalleeFireBanR = "Mallee"
    toJSON WestSouthGippslandFireBanR = "West &South Gippsland"
    toJSON BallaratFireBanR = "Ballarat"

instance FromJSON FireBanR where
    parseJSON = withText "FireBanR" parseText
        where
            parseText "North Central" = return NorthCentralFireBanR
            parseText "Central" = return CentralFireBanR
            parseText "South West" = return SouthWestFireBanR
            parseText "Wimmera" = return WimmeraFireBanR
            parseText "Northern Country" = return NorthernCountryFireBanR
            parseText "East Gippsland" = return EastGippslandFireBanR
            parseText "North East" = return NorthEastFireBanR
            parseText "Mallee" = return MalleeFireBanR
            parseText "West &South Gippsland" = return WestSouthGippslandFireBanR
            parseText "Ballarat" = return BallaratFireBanR

instance ToJSON PropertiesType where
    toJSON STREETPropertiesType = "STREET"
    toJSON AVENUEPropertiesType = "AVENUE"
    toJSON ROADPropertiesType = "ROAD"
    toJSON HIGHWAYPropertiesType = "HIGHWAY"
    toJSON BOULEVARDPropertiesType = "BOULEVARD"
    toJSON COURTPropertiesType = "COURT"
    toJSON WAYPropertiesType = "WAY"
    toJSON DRIVEPropertiesType = "DRIVE"
    toJSON SOUTHPropertiesType = "SOUTH"
    toJSON HILLPropertiesType = "HILL"
    toJSON LANEPropertiesType = "LANE"
    toJSON CLOSEPropertiesType = "CLOSE"
    toJSON PARADEPropertiesType = "PARADE"
    toJSON RoadPropertiesType = "Road"
    toJSON PLACEPropertiesType = "PLACE"
    toJSON RDPropertiesType = "RD"

instance FromJSON PropertiesType where
    parseJSON = withText "PropertiesType" parseText
        where
            parseText "STREET" = return STREETPropertiesType
            parseText "AVENUE" = return AVENUEPropertiesType
            parseText "ROAD" = return ROADPropertiesType
            parseText "HIGHWAY" = return HIGHWAYPropertiesType
            parseText "BOULEVARD" = return BOULEVARDPropertiesType
            parseText "COURT" = return COURTPropertiesType
            parseText "WAY" = return WAYPropertiesType
            parseText "DRIVE" = return DRIVEPropertiesType
            parseText "SOUTH" = return SOUTHPropertiesType
            parseText "HILL" = return HILLPropertiesType
            parseText "LANE" = return LANEPropertiesType
            parseText "CLOSE" = return CLOSEPropertiesType
            parseText "PARADE" = return PARADEPropertiesType
            parseText "Road" = return RoadPropertiesType
            parseText "PLACE" = return PLACEPropertiesType
            parseText "RD" = return RDPropertiesType

instance ToJSON Region where
    toJSON EasternRegion = "Eastern"
    toJSON NorthernMetroRegion = "Northern Metro"
    toJSON WesternRegion = "Western"
    toJSON SouthernMetroRegion = "Southern Metro"

instance FromJSON Region where
    parseJSON = withText "Region" parseText
        where
            parseText "Eastern" = return EasternRegion
            parseText "Northern Metro" = return NorthernMetroRegion
            parseText "Western" = return WesternRegion
            parseText "Southern Metro" = return SouthernMetroRegion
