{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Facets (..)
    , ResultElement (..)
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
    , nextQuickType :: Bool
    , offsetQuickType :: Int
    , previousQuickType :: Bool
    , resultsQuickType :: [ResultElement]
    } deriving (Show)

data Facets = Facets
    {
    } deriving (Show)

data ResultElement = ResultElement
    { createdAtResultElement :: Text
    , itemsResultElement :: Int
    , nameResultElement :: Text
    , parentResultElement :: Maybe Int
    , resultIDResultElement :: Int
    , updatedAtResultElement :: Text
    , uriResultElement :: Text
    } deriving (Show)

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
    toJSON (ResultElement createdAtResultElement itemsResultElement nameResultElement parentResultElement resultIDResultElement updatedAtResultElement uriResultElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "created_at" .= createdAtResultElement
        , Just $ "items" .= itemsResultElement
        , Just $ "name" .= nameResultElement
        , Just $ "parent" .= parentResultElement
        , Just $ "id" .= resultIDResultElement
        , Just $ "updated_at" .= updatedAtResultElement
        , Just $ "uri" .= uriResultElement
        ]

instance FromJSON ResultElement where
    parseJSON (Object v) = ResultElement
        <$> v .: "created_at"
        <*> v .: "items"
        <*> v .: "name"
        <*> v .: "parent"
        <*> v .: "id"
        <*> v .: "updated_at"
        <*> v .: "uri"
