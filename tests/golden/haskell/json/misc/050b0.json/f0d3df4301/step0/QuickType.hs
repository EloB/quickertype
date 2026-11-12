{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Identifier (..)
    , Link (..)
    , OtherName (..)
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
    , otherNamesQuickTypeElement :: [OtherName]
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
    | PermissiveKeyword
    | CopyleftKeyword
    deriving (Show)

data Link = Link
    { noteLink :: Note
    , urlLink :: Text
    } deriving (Show)

data Note
    = TlDRLegalNote
    | WikipediaPageNote
    | OSIPageNote
    | PurpleWikipediaPageNote
    | MozillaPageNote
    deriving (Show)

data OtherName = OtherName
    { nameOtherName :: Text
    , noteOtherName :: Maybe Text
    } deriving (Show)

data TextElement = TextElement
    { mediaTypeTextElement :: MediaType
    , titleTextElement :: Title
    , urlTextElement :: Text
    } deriving (Show)

data MediaType
    = TextHTMLMediaType
    | TextPlainMediaType
    deriving (Show)

data Title
    = HTMLTitle
    | PlainTextTitle
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
    toJSON PermissiveKeyword = "permissive"
    toJSON CopyleftKeyword = "copyleft"

instance FromJSON Keyword where
    parseJSON = withText "Keyword" parseText
        where
            parseText "osi-approved" = return OSIApprovedKeyword
            parseText "popular" = return PopularKeyword
            parseText "permissive" = return PermissiveKeyword
            parseText "copyleft" = return CopyleftKeyword

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
    toJSON TlDRLegalNote = "tl;dr legal"
    toJSON WikipediaPageNote = "Wikipedia page"
    toJSON OSIPageNote = "OSI Page"
    toJSON PurpleWikipediaPageNote = "Wikipedia Page"
    toJSON MozillaPageNote = "Mozilla Page"

instance FromJSON Note where
    parseJSON = withText "Note" parseText
        where
            parseText "tl;dr legal" = return TlDRLegalNote
            parseText "Wikipedia page" = return WikipediaPageNote
            parseText "OSI Page" = return OSIPageNote
            parseText "Wikipedia Page" = return PurpleWikipediaPageNote
            parseText "Mozilla Page" = return MozillaPageNote

instance ToJSON OtherName where
    toJSON (OtherName nameOtherName noteOtherName) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameOtherName
        , Just $ "note" .= noteOtherName
        ]

instance FromJSON OtherName where
    parseJSON (Object v) = OtherName
        <$> v .: "name"
        <*> v .: "note"

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
    toJSON TextPlainMediaType = "text/plain"

instance FromJSON MediaType where
    parseJSON = withText "MediaType" parseText
        where
            parseText "text/html" = return TextHTMLMediaType
            parseText "text/plain" = return TextPlainMediaType

instance ToJSON Title where
    toJSON HTMLTitle = "HTML"
    toJSON PlainTextTitle = "Plain Text"

instance FromJSON Title where
    parseJSON = withText "Title" parseText
        where
            parseText "HTML" = return HTMLTitle
            parseText "Plain Text" = return PlainTextTitle
