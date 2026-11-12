{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , ErrorElement (..)
    , Data (..)
    , Repository (..)
    , IssueOrPullRequest (..)
    , IssueState (..)
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
    { repositoryData :: Maybe Repository
    } deriving (Show)

data Repository = Repository
    { nameWithOwnerRepository :: Text
    , n303Repository :: Maybe IssueOrPullRequest
    , n307Repository :: Maybe IssueOrPullRequest
    } deriving (Show)

data IssueOrPullRequest = IssueOrPullRequest
    { titleIssueOrPullRequest :: Maybe Text
    , stateIssueOrPullRequest :: Maybe IssueState
    , mergedIssueOrPullRequest :: Maybe Bool
    } deriving (Show)

data IssueState
    = OPENIssueState
    | CLOSEDIssueState
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
    toJSON (Data repositoryData) =
        object $ foldMap (maybe [] pure)
        [ Just $ "repository" .= repositoryData
        ]

instance FromJSON Data where
    parseJSON (Object v) = Data
        <$> v .: "repository"

instance ToJSON Repository where
    toJSON (Repository nameWithOwnerRepository n303Repository n307Repository) =
        object $ foldMap (maybe [] pure)
        [ Just $ "nameWithOwner" .= nameWithOwnerRepository
        , Just $ "n303" .= n303Repository
        , Just $ "n307" .= n307Repository
        ]

instance FromJSON Repository where
    parseJSON (Object v) = Repository
        <$> v .: "nameWithOwner"
        <*> v .: "n303"
        <*> v .: "n307"

instance ToJSON IssueOrPullRequest where
    toJSON (IssueOrPullRequest titleIssueOrPullRequest stateIssueOrPullRequest mergedIssueOrPullRequest) =
        object $ foldMap (maybe [] pure)
        [ ("title" .=) <$> titleIssueOrPullRequest
        , ("state" .=) <$> stateIssueOrPullRequest
        , ("merged" .=) <$> mergedIssueOrPullRequest
        ]

instance FromJSON IssueOrPullRequest where
    parseJSON (Object v) = IssueOrPullRequest
        <$> v .:! "title"
        <*> v .:! "state"
        <*> v .:! "merged"

instance ToJSON IssueState where
    toJSON OPENIssueState = "OPEN"
    toJSON CLOSEDIssueState = "CLOSED"

instance FromJSON IssueState where
    parseJSON = withText "IssueState" parseText
        where
            parseText "OPEN" = return OPENIssueState
            parseText "CLOSED" = return CLOSEDIssueState
