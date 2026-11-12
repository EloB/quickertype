{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Facets (..)
    , ResultElement (..)
    , Status (..)
    , Title (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { countQuickType :: Int
    , facetsQuickType :: Facets
    , limitQuickType :: Int
    , nextQuickType :: Text
    , offsetQuickType :: Int
    , previousQuickType :: Bool
    , resultsQuickType :: [ResultElement]
    } deriving (Show)

data Facets = Facets
    {
    } deriving (Show)

data ResultElement = ResultElement
    { createdAtResultElement :: Text
    , entityResultElement :: Text
    , firstNameResultElement :: Text
    , lastNameResultElement :: Text
    , nameResultElement :: Text
    , positionResultElement :: Maybe Text
    , resultIDResultElement :: Text
    , statusResultElement :: Status
    , titleResultElement :: Maybe Title
    , updatedAtResultElement :: Text
    , uriResultElement :: Text
    } deriving (Show)

data Status
    = InactiveStatus
    | ActiveStatus
    deriving (Show)

data Title
    = MrTitle
    | MSTitle
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType countQuickType facetsQuickType limitQuickType nextQuickType offsetQuickType previousQuickType resultsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countQuickType
        , Just $ "facets" .= facetsQuickType
        , Just $ "limit" .= limitQuickType
        , Just $ "next" .= nextQuickType
        , Just $ "offset" .= offsetQuickType
        , Just $ "previous" .= previousQuickType
        , Just $ "results" .= resultsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "count"
        <*> v .: "facets"
        <*> v .: "limit"
        <*> v .: "next"
        <*> v .: "offset"
        <*> v .: "previous"
        <*> v .: "results"

instance ToJSON Facets where
    toJSON = \_ -> emptyObject

instance FromJSON Facets where
    parseJSON (Object _) = return Facets

instance ToJSON ResultElement where
    toJSON (ResultElement createdAtResultElement entityResultElement firstNameResultElement lastNameResultElement nameResultElement positionResultElement resultIDResultElement statusResultElement titleResultElement updatedAtResultElement uriResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "created_at" .= createdAtResultElement
        , Just $ "entity" .= entityResultElement
        , Just $ "first_name" .= firstNameResultElement
        , Just $ "last_name" .= lastNameResultElement
        , Just $ "name" .= nameResultElement
        , Just $ "position" .= positionResultElement
        , Just $ "id" .= resultIDResultElement
        , Just $ "status" .= statusResultElement
        , Just $ "title" .= titleResultElement
        , Just $ "updated_at" .= updatedAtResultElement
        , Just $ "uri" .= uriResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "created_at"
        <*> v .: "entity"
        <*> v .: "first_name"
        <*> v .: "last_name"
        <*> v .: "name"
        <*> v .: "position"
        <*> v .: "id"
        <*> v .: "status"
        <*> v .: "title"
        <*> v .: "updated_at"
        <*> v .: "uri"

instance ToJSON Status where
    toJSON InactiveStatus = "inactive"
    toJSON ActiveStatus = "active"

instance FromJSON Status where
    parseJSON = withText "Status" parseText
        where
            parseText "inactive" = return InactiveStatus
            parseText "active" = return ActiveStatus

instance ToJSON Title where
    toJSON MrTitle = "Mr"
    toJSON MSTitle = "Ms"

instance FromJSON Title where
    parseJSON = withText "Title" parseText
        where
            parseText "Mr" = return MrTitle
            parseText "Ms" = return MSTitle
