{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Definitions (..)
    , Provider (..)
    , Property (..)
    , Info (..)
    , Paths (..)
    , BusinessServiceProvidersSearch (..)
    , Get (..)
    , Parameter (..)
    , Responses (..)
    , The200 (..)
    , Schema (..)
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
    { providerDefinitions :: Provider
    } deriving (Show)

data Provider = Provider
    { propertiesProvider :: HashMap Text Property
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
    { businessServiceProvidersSearchPaths :: BusinessServiceProvidersSearch
    } deriving (Show)

data BusinessServiceProvidersSearch = BusinessServiceProvidersSearch
    { getBusinessServiceProvidersSearch :: Get
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
    { refSchema :: Text
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
    toJSON (Definitions providerDefinitions) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Provider" .= providerDefinitions
        ]

instance FromJSON Definitions where
    parseJSON (Object v) = Definitions
        <$> v .: "Provider"

instance ToJSON Provider where
    toJSON (Provider propertiesProvider) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesProvider
        ]

instance FromJSON Provider where
    parseJSON (Object v) = Provider
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
    toJSON (Paths businessServiceProvidersSearchPaths) =
        object $ foldMap (maybe [] pure)
        [ Just $ "/business_service_providers/search" .= businessServiceProvidersSearchPaths
        ]

instance FromJSON Paths where
    parseJSON (Object v) = Paths
        <$> v .: "/business_service_providers/search"

instance ToJSON BusinessServiceProvidersSearch where
    toJSON (BusinessServiceProvidersSearch getBusinessServiceProvidersSearch) =
        object $ foldMap (maybe [] pure)
        [ Just $ "get" .= getBusinessServiceProvidersSearch
        ]

instance FromJSON BusinessServiceProvidersSearch where
    parseJSON (Object v) = BusinessServiceProvidersSearch
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
    toJSON (Schema refSchema) =
        object $ foldMap (maybe [] pure)
        [ Just $ "$ref" .= refSchema
        ]

instance FromJSON Schema where
    parseJSON (Object v) = Schema
        <$> v .: "$ref"
