{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Identifier (..)
    , Link (..)
    , TextElement (..)
    , Scheme (..)
    , Keyword (..)
    , MediaType (..)
    , Title (..)
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
    , schemeIdentifier :: Scheme
    } deriving (Show)

data Scheme
    = DEP5Scheme
    | SPDXScheme
    | TroveScheme
    deriving (Show)

data Keyword
    = OSIApprovedKeyword
    | PopularKeyword
    | CopyleftKeyword
    | InternationalKeyword
    deriving (Show)

data Link = Link
    { noteLink :: Text
    , urlLink :: Text
    } deriving (Show)

data TextElement = TextElement
    { mediaTypeTextElement :: MediaType
    , titleTextElement :: Title
    , urlTextElement :: Text
    } deriving (Show)

data MediaType
    = TextPlainMediaType
    | TextHTMLMediaType
    deriving (Show)

data Title
    = PlainTextTitle
    | HTMLTitle
    deriving (Show)

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

instance ToJSON Scheme where
    toJSON DEP5Scheme = "DEP5"
    toJSON SPDXScheme = "SPDX"
    toJSON TroveScheme = "Trove"

instance FromJSON Scheme where
    parseJSON = withText "Scheme" parseText
        where
            parseText "DEP5" = return DEP5Scheme
            parseText "SPDX" = return SPDXScheme
            parseText "Trove" = return TroveScheme

instance ToJSON Keyword where
    toJSON OSIApprovedKeyword = "osi-approved"
    toJSON PopularKeyword = "popular"
    toJSON CopyleftKeyword = "copyleft"
    toJSON InternationalKeyword = "international"

instance FromJSON Keyword where
    parseJSON = withText "Keyword" parseText
        where
            parseText "osi-approved" = return OSIApprovedKeyword
            parseText "popular" = return PopularKeyword
            parseText "copyleft" = return CopyleftKeyword
            parseText "international" = return InternationalKeyword

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

instance ToJSON MediaType where
    toJSON TextPlainMediaType = "text/plain"
    toJSON TextHTMLMediaType = "text/html"

instance FromJSON MediaType where
    parseJSON = withText "MediaType" parseText
        where
            parseText "text/plain" = return TextPlainMediaType
            parseText "text/html" = return TextHTMLMediaType

instance ToJSON Title where
    toJSON PlainTextTitle = "Plain Text"
    toJSON HTMLTitle = "HTML"

instance FromJSON Title where
    parseJSON = withText "Title" parseText
        where
            parseText "Plain Text" = return PlainTextTitle
            parseText "HTML" = return HTMLTitle
