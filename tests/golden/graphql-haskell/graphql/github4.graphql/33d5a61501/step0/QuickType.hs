{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ErrorElement (..)
    , Data (..)
    , User (..)
    , Repository (..)
    , PullRequestConnection (..)
    , PullRequest (..)
    , PullRequestState (..)
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
    , nameUser :: Maybe Text
    , repositoryUser :: Maybe Repository
    } deriving (Show)

data Repository = Repository
    { pullRequestsRepository :: PullRequestConnection
    } deriving (Show)

data PullRequestConnection = PullRequestConnection
    { nodesPullRequestConnection :: Maybe ([(Maybe PullRequest)])
    } deriving (Show)

data PullRequest = PullRequest
    { statePullRequest :: PullRequestState
    } deriving (Show)

data PullRequestState
    = OPENPullRequestState
    | CLOSEDPullRequestState
    | MERGEDPullRequestState
    deriving (Show)

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
    toJSON (User loginUser nameUser repositoryUser) =
        object $ foldMap (maybe [] pure)
        [ Just $ "login" .= loginUser
        , Just $ "name" .= nameUser
        , Just $ "repository" .= repositoryUser
        ]

instance FromJSON User where
    parseJSON (Object v) = User
        <$> v .: "login"
        <*> v .: "name"
        <*> v .: "repository"

instance ToJSON Repository where
    toJSON (Repository pullRequestsRepository) =
        object $ foldMap (maybe [] pure)
        [ Just $ "pullRequests" .= pullRequestsRepository
        ]

instance FromJSON Repository where
    parseJSON (Object v) = Repository
        <$> v .: "pullRequests"

instance ToJSON PullRequestConnection where
    toJSON (PullRequestConnection nodesPullRequestConnection) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nodes" .= nodesPullRequestConnection
        ]

instance FromJSON PullRequestConnection where
    parseJSON (Object v) = PullRequestConnection
        <$> v .: "nodes"

instance ToJSON PullRequest where
    toJSON (PullRequest statePullRequest) =
        object $ foldMap (maybe [] pure)
        [ Just $ "state" .= statePullRequest
        ]

instance FromJSON PullRequest where
    parseJSON (Object v) = PullRequest
        <$> v .: "state"

instance ToJSON PullRequestState where
    toJSON OPENPullRequestState = "OPEN"
    toJSON CLOSEDPullRequestState = "CLOSED"
    toJSON MERGEDPullRequestState = "MERGED"

instance FromJSON PullRequestState where
    parseJSON = withText "PullRequestState" parseText
        where
            parseText "OPEN" = return OPENPullRequestState
            parseText "CLOSED" = return CLOSEDPullRequestState
            parseText "MERGED" = return MERGEDPullRequestState
