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
    , Note (..)
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
    = SPDXScheme
    | TroveScheme
    | DEP5Scheme
    deriving (Show)

data Keyword
    = DiscouragedKeyword
    | NonReusableKeyword
    | OSIApprovedKeyword
    deriving (Show)

data Link = Link
    { noteLink :: Note
    , urlLink :: Text
    } deriving (Show)

data Note
    = OSIPageNote
    deriving (Show)

data TextElement = TextElement
    { mediaTypeTextElement :: MediaType
    , titleTextElement :: Title
    , urlTextElement :: Text
    } deriving (Show)

data MediaType
    = TextHTMLMediaType
    deriving (Show)

data Title
    = HTMLTitle
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
    toJSON SPDXScheme = "SPDX"
    toJSON TroveScheme = "Trove"
    toJSON DEP5Scheme = "DEP5"

instance FromJSON Scheme where
    parseJSON = withText "Scheme" parseText
        where
            parseText "SPDX" = return SPDXScheme
            parseText "Trove" = return TroveScheme
            parseText "DEP5" = return DEP5Scheme

instance ToJSON Keyword where
    toJSON DiscouragedKeyword = "discouraged"
    toJSON NonReusableKeyword = "non-reusable"
    toJSON OSIApprovedKeyword = "osi-approved"

instance FromJSON Keyword where
    parseJSON = withText "Keyword" parseText
        where
            parseText "discouraged" = return DiscouragedKeyword
            parseText "non-reusable" = return NonReusableKeyword
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

instance ToJSON Note where
    toJSON OSIPageNote = "OSI Page"

instance FromJSON Note where
    parseJSON = withText "Note" parseText
        where
            parseText "OSI Page" = return OSIPageNote

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
    toJSON TextHTMLMediaType = "text/html"

instance FromJSON MediaType where
    parseJSON = withText "MediaType" parseText
        where
            parseText "text/html" = return TextHTMLMediaType

instance ToJSON Title where
    toJSON HTMLTitle = "HTML"

instance FromJSON Title where
    parseJSON = withText "Title" parseText
        where
            parseText "HTML" = return HTMLTitle
