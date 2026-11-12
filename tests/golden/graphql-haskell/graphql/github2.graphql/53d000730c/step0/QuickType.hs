{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ErrorElement (..)
    , Data (..)
    , User (..)
    , RepositoryConnection (..)
    , Repository (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { quickTypeDataQuickType :: Maybe Data
    , errorsQuickType :: Maybe ([ErrorElement])
    } deriving (Show)

data ErrorElement = ErrorElement
    { messageErrorElement :: Text
    } deriving (Show)

data Data = Data
    { viewerData :: User
    } deriving (Show)

data User = User
    { loginUser :: Text
    , repositoriesUser :: RepositoryConnection
    } deriving (Show)

data RepositoryConnection = RepositoryConnection
    { totalCountRepositoryConnection :: Int
    , nodesRepositoryConnection :: Maybe ([(Maybe Repository)])
    } deriving (Show)

data Repository = Repository
    { nameRepository :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType quickTypeDataQuickType errorsQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "data" .= quickTypeDataQuickType
        , ("errors" .=) <$> errorsQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "data"
        <*> v .:! "errors"

instance ToJSON ErrorElement where
    toJSON (ErrorElement messageErrorElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "message" .= messageErrorElement
        ]

instance FromJSON ErrorElement where
    parseJSON (Object v) = ErrorElement
        <$> v .: "message"

instance ToJSON Data where
    toJSON (Data viewerData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "viewer" .= viewerData
        ]

instance FromJSON Data where
    parseJSON (Object v) = Data
        <$> v .: "viewer"

instance ToJSON User where
    toJSON (User loginUser repositoriesUser) =
        object $ foldMap (maybe [] pure)
        [ Just $ "login" .= loginUser
        , Just $ "repositories" .= repositoriesUser
        ]

instance FromJSON User where
    parseJSON (Object v) = User
        <$> v .: "login"
        <*> v .: "repositories"

instance ToJSON RepositoryConnection where
    toJSON (RepositoryConnection totalCountRepositoryConnection nodesRepositoryConnection) =
        object $ foldMap (maybe [] pure)
        [ Just $ "totalCount" .= totalCountRepositoryConnection
        , Just $ "nodes" .= nodesRepositoryConnection
        ]

instance FromJSON RepositoryConnection where
    parseJSON (Object v) = RepositoryConnection
        <$> v .: "totalCount"
        <*> v .: "nodes"

instance ToJSON Repository where
    toJSON (Repository nameRepository) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameRepository
        ]

instance FromJSON Repository where
    parseJSON (Object v) = Repository
        <$> v .: "name"
