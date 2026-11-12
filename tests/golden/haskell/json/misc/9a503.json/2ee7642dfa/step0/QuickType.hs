{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Identifier (..)
    , Link (..)
    , TextElement (..)
    , Keyword (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { identifiersQuickTypeElement :: [Identifier]
    , keywordsQuickTypeElement :: [Keyword]
    , linksQuickTypeElement :: [Link]
    , nameQuickTypeElement :: Text
    , otherNamesQuickTypeElement :: [Value]
    , quickTypeIDQuickTypeElement :: Text
    , quickTypeTextQuickTypeElement :: [TextElement]
    , supersededByQuickTypeElement :: Maybe Text
    } deriving (Show)

data Identifier = Identifier
    { identifierIdentifier :: Text
    , schemeIdentifier :: Text
    } deriving (Show)

data Keyword
    = DiscouragedKeyword
    | RetiredKeyword
    | OSIApprovedKeyword
    deriving (Show)

data Link = Link
    { noteLink :: Text
    , urlLink :: Text
    } deriving (Show)

data TextElement = TextElement
    { mediaTypeTextElement :: Text
    , titleTextElement :: Text
    , urlTextElement :: Text
    } deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement identifiersQuickTypeElement keywordsQuickTypeElement linksQuickTypeElement nameQuickTypeElement otherNamesQuickTypeElement quickTypeIDQuickTypeElement quickTypeTextQuickTypeElement supersededByQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "identifiers" .= identifiersQuickTypeElement
        , Just $ "keywords" .= keywordsQuickTypeElement
        , Just $ "links" .= linksQuickTypeElement
        , Just $ "name" .= nameQuickTypeElement
        , Just $ "other_names" .= otherNamesQuickTypeElement
        , Just $ "id" .= quickTypeIDQuickTypeElement
        , Just $ "text" .= quickTypeTextQuickTypeElement
        , Just $ "superseded_by" .= supersededByQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "identifiers"
        <*> v .: "keywords"
        <*> v .: "links"
        <*> v .: "name"
        <*> v .: "other_names"
        <*> v .: "id"
        <*> v .: "text"
        <*> v .: "superseded_by"

instance ToJSON Identifier where
    toJSON (Identifier identifierIdentifier schemeIdentifier) =
        object $ foldMap (maybe [] pure)
        [ Just $ "identifier" .= identifierIdentifier
        , Just $ "scheme" .= schemeIdentifier
        ]

instance FromJSON Identifier where
    parseJSON (Object v) = Identifier
        <$> v .: "identifier"
        <*> v .: "scheme"

instance ToJSON Keyword where
    toJSON DiscouragedKeyword = "discouraged"
    toJSON RetiredKeyword = "retired"
    toJSON OSIApprovedKeyword = "osi-approved"

instance FromJSON Keyword where
    parseJSON = withText "Keyword" parseText
        where
            parseText "discouraged" = return DiscouragedKeyword
            parseText "retired" = return RetiredKeyword
            parseText "osi-approved" = return OSIApprovedKeyword

instance ToJSON Link where
    toJSON (Link noteLink urlLink) =
        object $ foldMap (maybe [] pure)
        [ Just $ "note" .= noteLink
        , Just $ "url" .= urlLink
        ]

instance FromJSON Link where
    parseJSON (Object v) = Link
        <$> v .: "note"
        <*> v .: "url"

instance ToJSON TextElement where
    toJSON (TextElement mediaTypeTextElement titleTextElement urlTextElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "media_type" .= mediaTypeTextElement
        , Just $ "title" .= titleTextElement
        , Just $ "url" .= urlTextElement
        ]

instance FromJSON TextElement where
    parseJSON (Object v) = TextElement
        <$> v .: "media_type"
        <*> v .: "title"
        <*> v .: "url"
