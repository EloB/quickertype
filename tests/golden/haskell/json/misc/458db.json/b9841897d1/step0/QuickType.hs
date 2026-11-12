{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Metadata (..)
    , ResponseInfo (..)
    , Resultset (..)
    , ResultElement (..)
    , Component (..)
    , Name (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { metadataQuickType :: Metadata
    , resultsQuickType :: [ResultElement]
    } deriving (Show)

data Metadata = Metadata
    { executionTimeMetadata :: Double
    , responseInfoMetadata :: ResponseInfo
    , resultsetMetadata :: Resultset
    } deriving (Show)

data ResponseInfo = ResponseInfo
    { developerMessageResponseInfo :: Text
    , statusResponseInfo :: Int
    } deriving (Show)

data Resultset = Resultset
    { countResultset :: Int
    , pageResultset :: Int
    , pagesizeResultset :: Int
    } deriving (Show)

data ResultElement = ResultElement
    { attachmentsResultElement :: [Value]
    , bodyResultElement :: Text
    , changedResultElement :: Text
    , componentResultElement :: [Component]
    , createdResultElement :: Text
    , dateResultElement :: Text
    , imageResultElement :: [Value]
    , teaserResultElement :: [Value]
    , titleResultElement :: Text
    , topicResultElement :: [Value]
    , urlResultElement :: Text
    , uuidResultElement :: Text
    , vuuidResultElement :: Text
    } deriving (Show)

data Component = Component
    { nameComponent :: Name
    , uuidComponent :: Text
    } deriving (Show)

data Name
    = OfficeOnViolenceAgainstWomenName
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType metadataQuickType resultsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "metadata" .= metadataQuickType
        , Just $ "results" .= resultsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "metadata"
        <*> v .: "results"

instance ToJSON Metadata where
    toJSON (Metadata executionTimeMetadata responseInfoMetadata resultsetMetadata) =
        object $ foldMap (maybe [] pure)
        [ Just $ "executionTime" .= executionTimeMetadata
        , Just $ "responseInfo" .= responseInfoMetadata
        , Just $ "resultset" .= resultsetMetadata
        ]

instance FromJSON Metadata where
    parseJSON (Object v) = Metadata
        <$> v .: "executionTime"
        <*> v .: "responseInfo"
        <*> v .: "resultset"

instance ToJSON ResponseInfo where
    toJSON (ResponseInfo developerMessageResponseInfo statusResponseInfo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "developerMessage" .= developerMessageResponseInfo
        , Just $ "status" .= statusResponseInfo
        ]

instance FromJSON ResponseInfo where
    parseJSON (Object v) = ResponseInfo
        <$> v .: "developerMessage"
        <*> v .: "status"

instance ToJSON Resultset where
    toJSON (Resultset countResultset pageResultset pagesizeResultset) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countResultset
        , Just $ "page" .= pageResultset
        , Just $ "pagesize" .= pagesizeResultset
        ]

instance FromJSON Resultset where
    parseJSON (Object v) = Resultset
        <$> v .: "count"
        <*> v .: "page"
        <*> v .: "pagesize"

instance ToJSON ResultElement where
    toJSON (ResultElement attachmentsResultElement bodyResultElement changedResultElement componentResultElement createdResultElement dateResultElement imageResultElement teaserResultElement titleResultElement topicResultElement urlResultElement uuidResultElement vuuidResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "attachments" .= attachmentsResultElement
        , Just $ "body" .= bodyResultElement
        , Just $ "changed" .= changedResultElement
        , Just $ "component" .= componentResultElement
        , Just $ "created" .= createdResultElement
        , Just $ "date" .= dateResultElement
        , Just $ "image" .= imageResultElement
        , Just $ "teaser" .= teaserResultElement
        , Just $ "title" .= titleResultElement
        , Just $ "topic" .= topicResultElement
        , Just $ "url" .= urlResultElement
        , Just $ "uuid" .= uuidResultElement
        , Just $ "vuuid" .= vuuidResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "attachments"
        <*> v .: "body"
        <*> v .: "changed"
        <*> v .: "component"
        <*> v .: "created"
        <*> v .: "date"
        <*> v .: "image"
        <*> v .: "teaser"
        <*> v .: "title"
        <*> v .: "topic"
        <*> v .: "url"
        <*> v .: "uuid"
        <*> v .: "vuuid"

instance ToJSON Component where
    toJSON (Component nameComponent uuidComponent) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameComponent
        , Just $ "uuid" .= uuidComponent
        ]

instance FromJSON Component where
    parseJSON (Object v) = Component
        <$> v .: "name"
        <*> v .: "uuid"

instance ToJSON Name where
    toJSON OfficeOnViolenceAgainstWomenName = "Office on Violence Against Women"

instance FromJSON Name where
    parseJSON = withText "Name" parseText
        where
            parseText "Office on Violence Against Women" = return OfficeOnViolenceAgainstWomenName
