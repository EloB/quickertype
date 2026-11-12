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
    , AddImprov (..)
    , FundingBa (..)
    , LevelAccu (..)
    , Material (..)
    , MiSymbolo (..)
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
    { coordinatesGeometry :: [([([([Double])])])]
    , geometryTypeGeometry :: GeometryType
    } deriving (Show)

data GeometryType
    = MultiPolygonGeometryType
    deriving (Show)

data GeometryName
    = GeomGeometryName
    deriving (Show)

data FeatureProperties = FeatureProperties
    { addImprovFeatureProperties :: Maybe AddImprov
    , areaFeatureProperties :: Double
    , assetNumbFeatureProperties :: Text
    , commentsFeatureProperties :: Maybe Text
    , conditionFeatureProperties :: Int
    , constructiFeatureProperties :: Maybe Text
    , createdateFeatureProperties :: Maybe Text
    , createuserFeatureProperties :: Maybe Text
    , disposalDFeatureProperties :: Maybe Text
    , documentsFeatureProperties :: Text
    , drawingNuFeatureProperties :: Maybe Text
    , fileNumbeFeatureProperties :: Maybe Text
    , folderNumFeatureProperties :: Maybe Text
    , fundingBaFeatureProperties :: Maybe FundingBa
    , historicCFeatureProperties :: Int
    , inspectionFeatureProperties :: Text
    , inspectorsFeatureProperties :: Maybe Text
    , lastUpdatFeatureProperties :: Maybe Text
    , levelAccuFeatureProperties :: Maybe LevelAccu
    , materialFeatureProperties :: Material
    , miPrinxFeatureProperties :: Int
    , miSymboloFeatureProperties :: MiSymbolo
    , numberLANFeatureProperties :: Int
    , ownerFeatureProperties :: Maybe Text
    , positionalFeatureProperties :: Maybe LevelAccu
    , projectNuFeatureProperties :: Maybe Text
    , propertiesTypeFeatureProperties :: Maybe PropertiesType
    , recIDFeatureProperties :: Int
    , recordCreFeatureProperties :: Maybe Text
    , shapeAreaFeatureProperties :: Double
    , shapeLengFeatureProperties :: Double
    , statusFeatureProperties :: Status
    , surveyNumFeatureProperties :: Maybe Text
    , toeRlFeatureProperties :: Double
    , topRlFeatureProperties :: Double
    , updateDATFeatureProperties :: Text
    , updatedateFeatureProperties :: Maybe Text
    , updateuserFeatureProperties :: Maybe Text
    } deriving (Show)

data AddImprov
    = FAddImprov
    | PurpleFAddImprov
    | TAddImprov
    deriving (Show)

data FundingBa
    = NonGCCCFundingBa
    | CapexFundingBa
    | InitialFundingBa
    | ContributeFundingBa
    deriving (Show)

data LevelAccu
    = GPSCorrected10MLevelAccu
    | APPROXLevelAccu
    | GPSCOrrected10MLevelAccu
    deriving (Show)

data Material
    = GravelMaterial
    | ConcreteMaterial
    | BitumenMaterial
    | InterlockConcBlockMaterial
    | OtherMaterial
    | EarthMaterial
    deriving (Show)

data MiSymbolo
    = Pen2265535Brush1016777215_MiSymbolo
    deriving (Show)

data PropertiesType
    = BoatRampPropertiesType
    deriving (Show)

data Status
    = CURRENTStatus
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
    toJSON MultiPolygonGeometryType = "MultiPolygon"

instance FromJSON GeometryType where
    parseJSON = withText "GeometryType" parseText
        where
            parseText "MultiPolygon" = return MultiPolygonGeometryType

instance ToJSON GeometryName where
    toJSON GeomGeometryName = "geom"

instance FromJSON GeometryName where
    parseJSON = withText "GeometryName" parseText
        where
            parseText "geom" = return GeomGeometryName

instance ToJSON FeatureProperties where
    toJSON (FeatureProperties addImprovFeatureProperties areaFeatureProperties assetNumbFeatureProperties commentsFeatureProperties conditionFeatureProperties constructiFeatureProperties createdateFeatureProperties createuserFeatureProperties disposalDFeatureProperties documentsFeatureProperties drawingNuFeatureProperties fileNumbeFeatureProperties folderNumFeatureProperties fundingBaFeatureProperties historicCFeatureProperties inspectionFeatureProperties inspectorsFeatureProperties lastUpdatFeatureProperties levelAccuFeatureProperties materialFeatureProperties miPrinxFeatureProperties miSymboloFeatureProperties numberLANFeatureProperties ownerFeatureProperties positionalFeatureProperties projectNuFeatureProperties propertiesTypeFeatureProperties recIDFeatureProperties recordCreFeatureProperties shapeAreaFeatureProperties shapeLengFeatureProperties statusFeatureProperties surveyNumFeatureProperties toeRlFeatureProperties topRlFeatureProperties updateDATFeatureProperties updatedateFeatureProperties updateuserFeatureProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "add_improv" .= addImprovFeatureProperties
        , Just $ "area_" .= areaFeatureProperties
        , Just $ "asset_numb" .= assetNumbFeatureProperties
        , Just $ "comments" .= commentsFeatureProperties
        , Just $ "condition" .= conditionFeatureProperties
        , Just $ "constructi" .= constructiFeatureProperties
        , Just $ "createdate" .= createdateFeatureProperties
        , Just $ "createuser" .= createuserFeatureProperties
        , Just $ "disposal_d" .= disposalDFeatureProperties
        , Just $ "documents" .= documentsFeatureProperties
        , Just $ "drawing_nu" .= drawingNuFeatureProperties
        , Just $ "file_numbe" .= fileNumbeFeatureProperties
        , Just $ "folder_num" .= folderNumFeatureProperties
        , Just $ "funding_ba" .= fundingBaFeatureProperties
        , Just $ "historic_c" .= historicCFeatureProperties
        , Just $ "inspection" .= inspectionFeatureProperties
        , Just $ "inspectors" .= inspectorsFeatureProperties
        , Just $ "last_updat" .= lastUpdatFeatureProperties
        , Just $ "level_accu" .= levelAccuFeatureProperties
        , Just $ "material" .= materialFeatureProperties
        , Just $ "mi_prinx" .= miPrinxFeatureProperties
        , Just $ "mi_symbolo" .= miSymboloFeatureProperties
        , Just $ "number_lan" .= numberLANFeatureProperties
        , Just $ "owner" .= ownerFeatureProperties
        , Just $ "positional" .= positionalFeatureProperties
        , Just $ "project_nu" .= projectNuFeatureProperties
        , Just $ "type" .= propertiesTypeFeatureProperties
        , Just $ "rec_id" .= recIDFeatureProperties
        , Just $ "record_cre" .= recordCreFeatureProperties
        , Just $ "shape_area" .= shapeAreaFeatureProperties
        , Just $ "shape_leng" .= shapeLengFeatureProperties
        , Just $ "status" .= statusFeatureProperties
        , Just $ "survey_num" .= surveyNumFeatureProperties
        , Just $ "toe_rl" .= toeRlFeatureProperties
        , Just $ "top_rl" .= topRlFeatureProperties
        , Just $ "update_dat" .= updateDATFeatureProperties
        , Just $ "updatedate" .= updatedateFeatureProperties
        , Just $ "updateuser" .= updateuserFeatureProperties
        ]

instance FromJSON FeatureProperties where
    parseJSON (Object v) = FeatureProperties
        <$> v .: "add_improv"
        <*> v .: "area_"
        <*> v .: "asset_numb"
        <*> v .: "comments"
        <*> v .: "condition"
        <*> v .: "constructi"
        <*> v .: "createdate"
        <*> v .: "createuser"
        <*> v .: "disposal_d"
        <*> v .: "documents"
        <*> v .: "drawing_nu"
        <*> v .: "file_numbe"
        <*> v .: "folder_num"
        <*> v .: "funding_ba"
        <*> v .: "historic_c"
        <*> v .: "inspection"
        <*> v .: "inspectors"
        <*> v .: "last_updat"
        <*> v .: "level_accu"
        <*> v .: "material"
        <*> v .: "mi_prinx"
        <*> v .: "mi_symbolo"
        <*> v .: "number_lan"
        <*> v .: "owner"
        <*> v .: "positional"
        <*> v .: "project_nu"
        <*> v .: "type"
        <*> v .: "rec_id"
        <*> v .: "record_cre"
        <*> v .: "shape_area"
        <*> v .: "shape_leng"
        <*> v .: "status"
        <*> v .: "survey_num"
        <*> v .: "toe_rl"
        <*> v .: "top_rl"
        <*> v .: "update_dat"
        <*> v .: "updatedate"
        <*> v .: "updateuser"

instance ToJSON AddImprov where
    toJSON FAddImprov = "f"
    toJSON PurpleFAddImprov = "F"
    toJSON TAddImprov = "t"

instance FromJSON AddImprov where
    parseJSON = withText "AddImprov" parseText
        where
            parseText "f" = return FAddImprov
            parseText "F" = return PurpleFAddImprov
            parseText "t" = return TAddImprov

instance ToJSON FundingBa where
    toJSON NonGCCCFundingBa = "Non GCCC"
    toJSON CapexFundingBa = "Capex"
    toJSON InitialFundingBa = "Initial"
    toJSON ContributeFundingBa = "Contribute"

instance FromJSON FundingBa where
    parseJSON = withText "FundingBa" parseText
        where
            parseText "Non GCCC" = return NonGCCCFundingBa
            parseText "Capex" = return CapexFundingBa
            parseText "Initial" = return InitialFundingBa
            parseText "Contribute" = return ContributeFundingBa

instance ToJSON LevelAccu where
    toJSON GPSCorrected10MLevelAccu = "GPS Corrected 1.0M"
    toJSON APPROXLevelAccu = "APPROX"
    toJSON GPSCOrrected10MLevelAccu = "GPS COrrected 1.0M"

instance FromJSON LevelAccu where
    parseJSON = withText "LevelAccu" parseText
        where
            parseText "GPS Corrected 1.0M" = return GPSCorrected10MLevelAccu
            parseText "APPROX" = return APPROXLevelAccu
            parseText "GPS COrrected 1.0M" = return GPSCOrrected10MLevelAccu

instance ToJSON Material where
    toJSON GravelMaterial = "Gravel"
    toJSON ConcreteMaterial = "Concrete"
    toJSON BitumenMaterial = "Bitumen"
    toJSON InterlockConcBlockMaterial = "Interlock Conc Block"
    toJSON OtherMaterial = "Other"
    toJSON EarthMaterial = "Earth"

instance FromJSON Material where
    parseJSON = withText "Material" parseText
        where
            parseText "Gravel" = return GravelMaterial
            parseText "Concrete" = return ConcreteMaterial
            parseText "Bitumen" = return BitumenMaterial
            parseText "Interlock Conc Block" = return InterlockConcBlockMaterial
            parseText "Other" = return OtherMaterial
            parseText "Earth" = return EarthMaterial

instance ToJSON MiSymbolo where
    toJSON Pen2265535Brush1016777215_MiSymbolo = "Pen (2, 2, 65535) Brush (1, 0, 16777215)"

instance FromJSON MiSymbolo where
    parseJSON = withText "MiSymbolo" parseText
        where
            parseText "Pen (2, 2, 65535) Brush (1, 0, 16777215)" = return Pen2265535Brush1016777215_MiSymbolo

instance ToJSON PropertiesType where
    toJSON BoatRampPropertiesType = "Boat Ramp"

instance FromJSON PropertiesType where
    parseJSON = withText "PropertiesType" parseText
        where
            parseText "Boat Ramp" = return BoatRampPropertiesType

instance ToJSON Status where
    toJSON CURRENTStatus = "CURRENT"

instance FromJSON Status where
    parseJSON = withText "Status" parseText
        where
            parseText "CURRENT" = return CURRENTStatus
