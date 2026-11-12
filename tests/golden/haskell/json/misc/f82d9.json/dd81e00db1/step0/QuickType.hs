{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Definitions (..)
    , Report (..)
    , Properties (..)
    , ClickURL (..)
    , Info (..)
    , Paths (..)
    , MarketResearchLibrarySearch (..)
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
    { reportDefinitions :: Report
    } deriving (Show)

data Report = Report
    { propertiesReport :: Properties
    } deriving (Show)

data Properties = Properties
    { clickURLProperties :: ClickURL
    , countryProperties :: ClickURL
    , descriptionProperties :: ClickURL
    , expirationDateProperties :: ClickURL
    , industryProperties :: ClickURL
    , propertiesIDProperties :: ClickURL
    , reportTypeProperties :: ClickURL
    , sourceIndustryProperties :: ClickURL
    , titleProperties :: ClickURL
    , urlProperties :: ClickURL
    } deriving (Show)

data ClickURL = ClickURL
    { clickURLTypeClickURL :: Type
    , descriptionClickURL :: Text
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
    { marketResearchLibrarySearchPaths :: MarketResearchLibrarySearch
    } deriving (Show)

data MarketResearchLibrarySearch = MarketResearchLibrarySearch
    { getMarketResearchLibrarySearch :: Get
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
    toJSON (Definitions reportDefinitions) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Report" .= reportDefinitions
        ]

instance FromJSON Definitions where
    parseJSON (Object v) = Definitions
        <$> v .: "Report"

instance ToJSON Report where
    toJSON (Report propertiesReport) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesReport
        ]

instance FromJSON Report where
    parseJSON (Object v) = Report
        <$> v .: "properties"

instance ToJSON Properties where
    toJSON (Properties clickURLProperties countryProperties descriptionProperties expirationDateProperties industryProperties propertiesIDProperties reportTypeProperties sourceIndustryProperties titleProperties urlProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "click_url" .= clickURLProperties
        , Just $ "country" .= countryProperties
        , Just $ "description" .= descriptionProperties
        , Just $ "expiration_date" .= expirationDateProperties
        , Just $ "industry" .= industryProperties
        , Just $ "id" .= propertiesIDProperties
        , Just $ "report_type" .= reportTypeProperties
        , Just $ "source_industry" .= sourceIndustryProperties
        , Just $ "title" .= titleProperties
        , Just $ "url" .= urlProperties
        ]

instance FromJSON Properties where
    parseJSON (Object v) = Properties
        <$> v .: "click_url"
        <*> v .: "country"
        <*> v .: "description"
        <*> v .: "expiration_date"
        <*> v .: "industry"
        <*> v .: "id"
        <*> v .: "report_type"
        <*> v .: "source_industry"
        <*> v .: "title"
        <*> v .: "url"

instance ToJSON ClickURL where
    toJSON (ClickURL clickURLTypeClickURL descriptionClickURL) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= clickURLTypeClickURL
        , Just $ "description" .= descriptionClickURL
        ]

instance FromJSON ClickURL where
    parseJSON (Object v) = ClickURL
        <$> v .: "type"
        <*> v .: "description"

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
    toJSON (Paths marketResearchLibrarySearchPaths) =
        object $ foldMap (maybe [] pure)
        [ Just $ "/market_research_library/search" .= marketResearchLibrarySearchPaths
        ]

instance FromJSON Paths where
    parseJSON (Object v) = Paths
        <$> v .: "/market_research_library/search"

instance ToJSON MarketResearchLibrarySearch where
    toJSON (MarketResearchLibrarySearch getMarketResearchLibrarySearch) =
        object $ foldMap (maybe [] pure)
        [ Just $ "get" .= getMarketResearchLibrarySearch
        ]

instance FromJSON MarketResearchLibrarySearch where
    parseJSON (Object v) = MarketResearchLibrarySearch
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
