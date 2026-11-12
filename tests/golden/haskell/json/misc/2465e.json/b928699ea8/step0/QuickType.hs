{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Definitions (..)
    , Taxonomy (..)
    , Properties (..)
    , Annotations (..)
    , Info (..)
    , Paths (..)
    , ItaTaxonomiesSearch (..)
    , Get (..)
    , Parameter (..)
    , Responses (..)
    , The200 (..)
    , Schema (..)
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
    { taxonomyDefinitions :: Taxonomy
    } deriving (Show)

data Taxonomy = Taxonomy
    { propertiesTaxonomy :: Properties
    } deriving (Show)

data Properties = Properties
    { annotationsProperties :: Annotations
    , datatypePropertiesProperties :: Annotations
    , labelProperties :: Annotations
    , propertiesIDProperties :: Annotations
    , propertiesTypeProperties :: Annotations
    , subClassOfProperties :: Annotations
    } deriving (Show)

data Annotations = Annotations
    { annotationsTypeAnnotations :: Text
    , descriptionAnnotations :: Text
    } deriving (Show)

data Info = Info
    { descriptionInfo :: Text
    , titleInfo :: Text
    , versionInfo :: Text
    } deriving (Show)

data Paths = Paths
    { itaTaxonomiesSearchPaths :: ItaTaxonomiesSearch
    } deriving (Show)

data ItaTaxonomiesSearch = ItaTaxonomiesSearch
    { getItaTaxonomiesSearch :: Get
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
    , formatParameter :: Text
    , nameParameter :: Text
    , parameterInParameter :: Text
    , parameterTypeParameter :: Text
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
    toJSON (Definitions taxonomyDefinitions) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Taxonomy" .= taxonomyDefinitions
        ]

instance FromJSON Definitions where
    parseJSON (Object v) = Definitions
        <$> v .: "Taxonomy"

instance ToJSON Taxonomy where
    toJSON (Taxonomy propertiesTaxonomy) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesTaxonomy
        ]

instance FromJSON Taxonomy where
    parseJSON (Object v) = Taxonomy
        <$> v .: "properties"

instance ToJSON Properties where
    toJSON (Properties annotationsProperties datatypePropertiesProperties labelProperties propertiesIDProperties propertiesTypeProperties subClassOfProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "annotations" .= annotationsProperties
        , Just $ "datatype_properties" .= datatypePropertiesProperties
        , Just $ "label" .= labelProperties
        , Just $ "id" .= propertiesIDProperties
        , Just $ "type" .= propertiesTypeProperties
        , Just $ "sub_class_of" .= subClassOfProperties
        ]

instance FromJSON Properties where
    parseJSON (Object v) = Properties
        <$> v .: "annotations"
        <*> v .: "datatype_properties"
        <*> v .: "label"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "sub_class_of"

instance ToJSON Annotations where
    toJSON (Annotations annotationsTypeAnnotations descriptionAnnotations) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= annotationsTypeAnnotations
        , Just $ "description" .= descriptionAnnotations
        ]

instance FromJSON Annotations where
    parseJSON (Object v) = Annotations
        <$> v .: "type"
        <*> v .: "description"

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
    toJSON (Paths itaTaxonomiesSearchPaths) =
        object $ foldMap (maybe [] pure)
        [ Just $ "/ita_taxonomies/search" .= itaTaxonomiesSearchPaths
        ]

instance FromJSON Paths where
    parseJSON (Object v) = Paths
        <$> v .: "/ita_taxonomies/search"

instance ToJSON ItaTaxonomiesSearch where
    toJSON (ItaTaxonomiesSearch getItaTaxonomiesSearch) =
        object $ foldMap (maybe [] pure)
        [ Just $ "get" .= getItaTaxonomiesSearch
        ]

instance FromJSON ItaTaxonomiesSearch where
    parseJSON (Object v) = ItaTaxonomiesSearch
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
