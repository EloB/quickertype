{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Facets (..)
    , ResultElement (..)
    , Status (..)
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
    , personIDResultElement :: Text
    , representativeIDResultElement :: Text
    , resultIDResultElement :: Text
    , statusResultElement :: Status
    , updatedAtResultElement :: Text
    } deriving (Show)

data Status
    = InactiveStatus
    | ActiveStatus
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
    toJSON (ResultElement createdAtResultElement personIDResultElement representativeIDResultElement resultIDResultElement statusResultElement updatedAtResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "created_at" .= createdAtResultElement
        , Just $ "person_id" .= personIDResultElement
        , Just $ "representative_id" .= representativeIDResultElement
        , Just $ "id" .= resultIDResultElement
        , Just $ "status" .= statusResultElement
        , Just $ "updated_at" .= updatedAtResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "created_at"
        <*> v .: "person_id"
        <*> v .: "representative_id"
        <*> v .: "id"
        <*> v .: "status"
        <*> v .: "updated_at"

instance ToJSON Status where
    toJSON InactiveStatus = "inactive"
    toJSON ActiveStatus = "active"

instance FromJSON Status where
    parseJSON = withText "Status" parseText
        where
            parseText "inactive" = return InactiveStatus
            parseText "active" = return ActiveStatus
