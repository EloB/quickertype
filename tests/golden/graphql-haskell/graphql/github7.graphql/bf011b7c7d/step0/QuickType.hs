{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ErrorElement (..)
    , Data (..)
    , User (..)
    , RepositoryConnection (..)
    , RepositoryEdge (..)
    , Repository (..)
    , Connection (..)
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
    , starredRepositoriesUser :: Connection
    , repositoriesUser :: RepositoryConnection
    } deriving (Show)

data RepositoryConnection = RepositoryConnection
    { edgesRepositoryConnection :: Maybe ([(Maybe RepositoryEdge)])
    } deriving (Show)

data RepositoryEdge = RepositoryEdge
    { nodeRepositoryEdge :: Maybe Repository
    } deriving (Show)

data Repository = Repository
    { nameRepository :: Text
    , stargazersRepository :: Connection
    , forksRepository :: Connection
    , watchersRepository :: Connection
    , issuesRepository :: Connection
    } deriving (Show)

data Connection = Connection
    { totalCountConnection :: Int
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
    toJSON (User loginUser starredRepositoriesUser repositoriesUser) =
        object $ foldMap (maybe [] pure)
        [ Just $ "login" .= loginUser
        , Just $ "starredRepositories" .= starredRepositoriesUser
        , Just $ "repositories" .= repositoriesUser
        ]

instance FromJSON User where
    parseJSON (Object v) = User
        <$> v .: "login"
        <*> v .: "starredRepositories"
        <*> v .: "repositories"

instance ToJSON RepositoryConnection where
    toJSON (RepositoryConnection edgesRepositoryConnection) =
        object $ foldMap (maybe [] pure)
        [ Just $ "edges" .= edgesRepositoryConnection
        ]

instance FromJSON RepositoryConnection where
    parseJSON (Object v) = RepositoryConnection
        <$> v .: "edges"

instance ToJSON RepositoryEdge where
    toJSON (RepositoryEdge nodeRepositoryEdge) =
        object $ foldMap (maybe [] pure)
        [ Just $ "node" .= nodeRepositoryEdge
        ]

instance FromJSON RepositoryEdge where
    parseJSON (Object v) = RepositoryEdge
        <$> v .: "node"

instance ToJSON Repository where
    toJSON (Repository nameRepository stargazersRepository forksRepository watchersRepository issuesRepository) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameRepository
        , Just $ "stargazers" .= stargazersRepository
        , Just $ "forks" .= forksRepository
        , Just $ "watchers" .= watchersRepository
        , Just $ "issues" .= issuesRepository
        ]

instance FromJSON Repository where
    parseJSON (Object v) = Repository
        <$> v .: "name"
        <*> v .: "stargazers"
        <*> v .: "forks"
        <*> v .: "watchers"
        <*> v .: "issues"

instance ToJSON Connection where
    toJSON (Connection totalCountConnection) =
        object $ foldMap (maybe [] pure)
        [ Just $ "totalCount" .= totalCountConnection
        ]

instance FromJSON Connection where
    parseJSON (Object v) = Connection
        <$> v .: "totalCount"
