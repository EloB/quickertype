{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Definitions (..)
    , Rate (..)
    , Property (..)
    , Info (..)
    , Paths (..)
    , TariffRatesSearch (..)
    , Get (..)
    , Parameter (..)
    , Responses (..)
    , The200 (..)
    , Schema (..)
    , Items (..)
    , Type (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { basePathQuickType :: Text
    , definitionsQuickType :: Definitions
    , hostQuickType :: Text
    , infoQuickType :: Info
    , pathsQuickType :: Paths
    , producesQuickType :: [Text]
    , schemesQuickType :: [Text]
    , swaggerQuickType :: Text
    } deriving (Show)

data Definitions = Definitions
    { rateDefinitions :: Rate
    } deriving (Show)

data Rate = Rate
    { propertiesRate :: HashMap Text Property
    } deriving (Show)

data Property = Property
    { descriptionProperty :: Text
    , propertyTypeProperty :: Type
    } deriving (Show)

data Type
    = StringType
    deriving (Show)

data Info = Info
    { descriptionInfo :: Text
    , titleInfo :: Text
    , versionInfo :: Text
    } deriving (Show)

data Paths = Paths
    { tariffRatesSearchPaths :: TariffRatesSearch
    } deriving (Show)

data TariffRatesSearch = TariffRatesSearch
    { getTariffRatesSearch :: Get
    } deriving (Show)

data Get = Get
    { descriptionGet :: Text
    , parametersGet :: [Parameter]
    , responsesGet :: Responses
    , summaryGet :: Text
    , tagsGet :: [Text]
    } deriving (Show)

data Parameter = Parameter
    { descriptionParameter :: Text
    , formatParameter :: Type
    , nameParameter :: Text
    , parameterInParameter :: Text
    , parameterTypeParameter :: Type
    , requiredParameter :: Bool
    } deriving (Show)

data Responses = Responses
    { the200Responses :: The200
    } deriving (Show)

data The200 = The200
    { descriptionThe200 :: Text
    , schemaThe200 :: Schema
    } deriving (Show)

data Schema = Schema
    { itemsSchema :: Items
    , schemaTypeSchema :: Text
    } deriving (Show)

data Items = Items
    { refItems :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType basePathQuickType definitionsQuickType hostQuickType infoQuickType pathsQuickType producesQuickType schemesQuickType swaggerQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "basePath" .= basePathQuickType
        , Just $ "definitions" .= definitionsQuickType
        , Just $ "host" .= hostQuickType
        , Just $ "info" .= infoQuickType
        , Just $ "paths" .= pathsQuickType
        , Just $ "produces" .= producesQuickType
        , Just $ "schemes" .= schemesQuickType
        , Just $ "swagger" .= swaggerQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "basePath"
        <*> v .: "definitions"
        <*> v .: "host"
        <*> v .: "info"
        <*> v .: "paths"
        <*> v .: "produces"
        <*> v .: "schemes"
        <*> v .: "swagger"

instance ToJSON Definitions where
    toJSON (Definitions rateDefinitions) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Rate" .= rateDefinitions
        ]

instance FromJSON Definitions where
    parseJSON (Object v) = Definitions
        <$> v .: "Rate"

instance ToJSON Rate where
    toJSON (Rate propertiesRate) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesRate
        ]

instance FromJSON Rate where
    parseJSON (Object v) = Rate
        <$> v .: "properties"

instance ToJSON Property where
    toJSON (Property descriptionProperty propertyTypeProperty) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionProperty
        , Just $ "type" .= propertyTypeProperty
        ]

instance FromJSON Property where
    parseJSON (Object v) = Property
        <$> v .: "description"
        <*> v .: "type"

instance ToJSON Type where
    toJSON StringType = "string"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "string" = return StringType

instance ToJSON Info where
    toJSON (Info descriptionInfo titleInfo versionInfo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionInfo
        , Just $ "title" .= titleInfo
        , Just $ "version" .= versionInfo
        ]

instance FromJSON Info where
    parseJSON (Object v) = Info
        <$> v .: "description"
        <*> v .: "title"
        <*> v .: "version"

instance ToJSON Paths where
    toJSON (Paths tariffRatesSearchPaths) =
        object $ foldMap (maybe [] pure)
        [ Just $ "/tariff_rates/search" .= tariffRatesSearchPaths
        ]

instance FromJSON Paths where
    parseJSON (Object v) = Paths
        <$> v .: "/tariff_rates/search"

instance ToJSON TariffRatesSearch where
    toJSON (TariffRatesSearch getTariffRatesSearch) =
        object $ foldMap (maybe [] pure)
        [ Just $ "get" .= getTariffRatesSearch
        ]

instance FromJSON TariffRatesSearch where
    parseJSON (Object v) = TariffRatesSearch
        <$> v .: "get"

instance ToJSON Get where
    toJSON (Get descriptionGet parametersGet responsesGet summaryGet tagsGet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionGet
        , Just $ "parameters" .= parametersGet
        , Just $ "responses" .= responsesGet
        , Just $ "summary" .= summaryGet
        , Just $ "tags" .= tagsGet
        ]

instance FromJSON Get where
    parseJSON (Object v) = Get
        <$> v .: "description"
        <*> v .: "parameters"
        <*> v .: "responses"
        <*> v .: "summary"
        <*> v .: "tags"

instance ToJSON Parameter where
    toJSON (Parameter descriptionParameter formatParameter nameParameter parameterInParameter parameterTypeParameter requiredParameter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionParameter
        , Just $ "format" .= formatParameter
        , Just $ "name" .= nameParameter
        , Just $ "in" .= parameterInParameter
        , Just $ "type" .= parameterTypeParameter
        , Just $ "required" .= requiredParameter
        ]

instance FromJSON Parameter where
    parseJSON (Object v) = Parameter
        <$> v .: "description"
        <*> v .: "format"
        <*> v .: "name"
        <*> v .: "in"
        <*> v .: "type"
        <*> v .: "required"

instance ToJSON Responses where
    toJSON (Responses the200Responses) =
        object $ foldMap (maybe [] pure)
        [ Just $ "200" .= the200Responses
        ]

instance FromJSON Responses where
    parseJSON (Object v) = Responses
        <$> v .: "200"

instance ToJSON The200 where
    toJSON (The200 descriptionThe200 schemaThe200) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionThe200
        , Just $ "schema" .= schemaThe200
        ]

instance FromJSON The200 where
    parseJSON (Object v) = The200
        <$> v .: "description"
        <*> v .: "schema"

instance ToJSON Schema where
    toJSON (Schema itemsSchema schemaTypeSchema) =
        object $ foldMap (maybe [] pure)
        [ Just $ "items" .= itemsSchema
        , Just $ "type" .= schemaTypeSchema
        ]

instance FromJSON Schema where
    parseJSON (Object v) = Schema
        <$> v .: "items"
        <*> v .: "type"

instance ToJSON Items where
    toJSON (Items refItems) =
        object $ foldMap (maybe [] pure)
        [ Just $ "$ref" .= refItems
        ]

instance FromJSON Items where
    parseJSON (Object v) = Items
        <$> v .: "$ref"
