{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , File (..)
    , Type (..)
    , Language (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { commentsQuickTypeElement :: Int
    , commentsURLQuickTypeElement :: Text
    , commitsURLQuickTypeElement :: Text
    , createdAtQuickTypeElement :: Text
    , descriptionQuickTypeElement :: Maybe Text
    , filesQuickTypeElement :: HashMap Text File
    , forksURLQuickTypeElement :: Text
    , gitPullURLQuickTypeElement :: Text
    , gitPushURLQuickTypeElement :: Text
    , htmlURLQuickTypeElement :: Text
    , publicQuickTypeElement :: Bool
    , quickTypeIDQuickTypeElement :: Text
    , truncatedQuickTypeElement :: Bool
    , updatedAtQuickTypeElement :: Text
    , urlQuickTypeElement :: Text
    , userQuickTypeElement :: Maybe Text
    } deriving (Show)

data File = File
    { fileTypeFile :: Type
    , filenameFile :: Text
    , languageFile :: Maybe Language
    , rawURLFile :: Text
    , sizeFile :: Int
    } deriving (Show)

data Type
    = TextPlainType
    deriving (Show)

data Language
    = MarkdownLanguage
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement commentsQuickTypeElement commentsURLQuickTypeElement commitsURLQuickTypeElement createdAtQuickTypeElement descriptionQuickTypeElement filesQuickTypeElement forksURLQuickTypeElement gitPullURLQuickTypeElement gitPushURLQuickTypeElement htmlURLQuickTypeElement publicQuickTypeElement quickTypeIDQuickTypeElement truncatedQuickTypeElement updatedAtQuickTypeElement urlQuickTypeElement userQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "comments" .= commentsQuickTypeElement
        , Just $ "comments_url" .= commentsURLQuickTypeElement
        , Just $ "commits_url" .= commitsURLQuickTypeElement
        , Just $ "created_at" .= createdAtQuickTypeElement
        , Just $ "description" .= descriptionQuickTypeElement
        , Just $ "files" .= filesQuickTypeElement
        , Just $ "forks_url" .= forksURLQuickTypeElement
        , Just $ "git_pull_url" .= gitPullURLQuickTypeElement
        , Just $ "git_push_url" .= gitPushURLQuickTypeElement
        , Just $ "html_url" .= htmlURLQuickTypeElement
        , Just $ "public" .= publicQuickTypeElement
        , Just $ "id" .= quickTypeIDQuickTypeElement
        , Just $ "truncated" .= truncatedQuickTypeElement
        , Just $ "updated_at" .= updatedAtQuickTypeElement
        , Just $ "url" .= urlQuickTypeElement
        , Just $ "user" .= userQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "comments"
        <*> v .: "comments_url"
        <*> v .: "commits_url"
        <*> v .: "created_at"
        <*> v .: "description"
        <*> v .: "files"
        <*> v .: "forks_url"
        <*> v .: "git_pull_url"
        <*> v .: "git_push_url"
        <*> v .: "html_url"
        <*> v .: "public"
        <*> v .: "id"
        <*> v .: "truncated"
        <*> v .: "updated_at"
        <*> v .: "url"
        <*> v .: "user"

instance ToJSON File where
    toJSON (File fileTypeFile filenameFile languageFile rawURLFile sizeFile) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= fileTypeFile
        , Just $ "filename" .= filenameFile
        , Just $ "language" .= languageFile
        , Just $ "raw_url" .= rawURLFile
        , Just $ "size" .= sizeFile
        ]

instance FromJSON File where
    parseJSON (Object v) = File
        <$> v .: "type"
        <*> v .: "filename"
        <*> v .: "language"
        <*> v .: "raw_url"
        <*> v .: "size"

instance ToJSON Type where
    toJSON TextPlainType = "text/plain"

instance FromJSON Type where
    parseJSON = withText "Type" parseText
        where
            parseText "text/plain" = return TextPlainType

instance ToJSON Language where
    toJSON MarkdownLanguage = "Markdown"

instance FromJSON Language where
    parseJSON = withText "Language" parseText
        where
            parseText "Markdown" = return MarkdownLanguage
