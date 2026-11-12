{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { gitQuickType :: [Text]
    , githubServicesSHAQuickType :: Text
    , hooksQuickType :: [Text]
    , importerQuickType :: [Text]
    , pagesQuickType :: [Text]
    , verifiablePasswordAuthenticationQuickType :: Bool
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType gitQuickType githubServicesSHAQuickType hooksQuickType importerQuickType pagesQuickType verifiablePasswordAuthenticationQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "git" .= gitQuickType
        , Just $ "github_services_sha" .= githubServicesSHAQuickType
        , Just $ "hooks" .= hooksQuickType
        , Just $ "importer" .= importerQuickType
        , Just $ "pages" .= pagesQuickType
        , Just $ "verifiable_password_authentication" .= verifiablePasswordAuthenticationQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "git"
        <*> v .: "github_services_sha"
        <*> v .: "hooks"
        <*> v .: "importer"
        <*> v .: "pages"
        <*> v .: "verifiable_password_authentication"
