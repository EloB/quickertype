{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Meta (..)
    , View (..)
    , Column (..)
    , CachedContents (..)
    , Top (..)
    , Query (..)
    , Grant (..)
    , License (..)
    , Metadata (..)
    , RenderTypeConfig (..)
    , Visible (..)
    , Owner (..)
    , TypeName (..)
    , Datum (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { metaQuickType :: Meta
    , quickTypeDataQuickType :: [([Datum])]
    } deriving (Show)

data Meta = Meta
    { viewMeta :: View
    } deriving (Show)

data View = View
    { averageRatingView :: Int
    , categoryView :: Text
    , columnsView :: [Column]
    , createdAtView :: Int
    , displayTypeView :: Text
    , downloadCountView :: Int
    , flagsView :: [Text]
    , grantsView :: [Grant]
    , hideFromCatalogView :: Bool
    , hideFromDataJSONView :: Bool
    , indexUpdatedAtView :: Int
    , licenseView :: License
    , licenseIDView :: Text
    , localeView :: Text
    , metadataView :: Metadata
    , nameView :: Text
    , newBackendView :: Bool
    , numberOfCommentsView :: Int
    , oidView :: Int
    , ownerView :: Owner
    , provenanceView :: Text
    , publicationAppendEnabledView :: Bool
    , publicationDateView :: Int
    , publicationGroupView :: Int
    , publicationStageView :: Text
    , queryView :: Query
    , rightsView :: [Text]
    , rowClassView :: Text
    , rowsUpdatedAtView :: Int
    , rowsUpdatedByView :: Text
    , tableAuthorView :: Owner
    , tableIDView :: Int
    , totalTimesRatedView :: Int
    , viewCountView :: Int
    , viewIDView :: Text
    , viewLastModifiedView :: Int
    , viewTypeView :: Text
    } deriving (Show)

data Column = Column
    { cachedContentsColumn :: Maybe CachedContents
    , columnIDColumn :: Int
    , dataTypeNameColumn :: TypeName
    , fieldNameColumn :: Text
    , flagsColumn :: Maybe ([Text])
    , formatColumn :: Query
    , nameColumn :: Text
    , positionColumn :: Int
    , renderTypeNameColumn :: TypeName
    , tableColumnIDColumn :: Maybe Int
    , widthColumn :: Maybe Int
    } deriving (Show)

data CachedContents = CachedContents
    { averageCachedContents :: Maybe Text
    , largestCachedContents :: Text
    , nonNullCachedContents :: Int
    , nullCachedContents :: Int
    , smallestCachedContents :: Text
    , sumCachedContents :: Maybe Text
    , topCachedContents :: [Top]
    } deriving (Show)

data Top = Top
    { countTop :: Int
    , itemTop :: Text
    } deriving (Show)

data TypeName
    = MetaDataTypeName
    | NumberTypeName
    | TextTypeName
    deriving (Show)

data Query = Query
    {
    } deriving (Show)

data Grant = Grant
    { flagsGrant :: [Text]
    , grantTypeGrant :: Text
    , inheritedGrant :: Bool
    } deriving (Show)

data License = License
    { nameLicense :: Text
    } deriving (Show)

data Metadata = Metadata
    { availableDisplayTypesMetadata :: [Text]
    , rdfClassMetadata :: Text
    , rdfSubjectMetadata :: Text
    , renderTypeConfigMetadata :: RenderTypeConfig
    , rowIdentifierMetadata :: Text
    } deriving (Show)

data RenderTypeConfig = RenderTypeConfig
    { visibleRenderTypeConfig :: Visible
    } deriving (Show)

data Visible = Visible
    { tableVisible :: Bool
    } deriving (Show)

data Owner = Owner
    { displayNameOwner :: Text
    , ownerIDOwner :: Text
    , screenNameOwner :: Text
    } deriving (Show)

data Datum
    = IntegerInDatum Int
    | NullInDatum
    | StringInDatum Text
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType metaQuickType quickTypeDataQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "meta" .= metaQuickType
        , Just $ "data" .= quickTypeDataQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "meta"
        <*> v .: "data"

instance ToJSON Meta where
    toJSON (Meta viewMeta) =
        object $ foldMap (maybe [] pure)
        [ Just $ "view" .= viewMeta
        ]

instance FromJSON Meta where
    parseJSON (Object v) = Meta
        <$> v .: "view"

instance ToJSON View where
    toJSON (View averageRatingView categoryView columnsView createdAtView displayTypeView downloadCountView flagsView grantsView hideFromCatalogView hideFromDataJSONView indexUpdatedAtView licenseView licenseIDView localeView metadataView nameView newBackendView numberOfCommentsView oidView ownerView provenanceView publicationAppendEnabledView publicationDateView publicationGroupView publicationStageView queryView rightsView rowClassView rowsUpdatedAtView rowsUpdatedByView tableAuthorView tableIDView totalTimesRatedView viewCountView viewIDView viewLastModifiedView viewTypeView) =
        object $ foldMap (maybe [] pure)
        [ Just $ "averageRating" .= averageRatingView
        , Just $ "category" .= categoryView
        , Just $ "columns" .= columnsView
        , Just $ "createdAt" .= createdAtView
        , Just $ "displayType" .= displayTypeView
        , Just $ "downloadCount" .= downloadCountView
        , Just $ "flags" .= flagsView
        , Just $ "grants" .= grantsView
        , Just $ "hideFromCatalog" .= hideFromCatalogView
        , Just $ "hideFromDataJson" .= hideFromDataJSONView
        , Just $ "indexUpdatedAt" .= indexUpdatedAtView
        , Just $ "license" .= licenseView
        , Just $ "licenseId" .= licenseIDView
        , Just $ "locale" .= localeView
        , Just $ "metadata" .= metadataView
        , Just $ "name" .= nameView
        , Just $ "newBackend" .= newBackendView
        , Just $ "numberOfComments" .= numberOfCommentsView
        , Just $ "oid" .= oidView
        , Just $ "owner" .= ownerView
        , Just $ "provenance" .= provenanceView
        , Just $ "publicationAppendEnabled" .= publicationAppendEnabledView
        , Just $ "publicationDate" .= publicationDateView
        , Just $ "publicationGroup" .= publicationGroupView
        , Just $ "publicationStage" .= publicationStageView
        , Just $ "query" .= queryView
        , Just $ "rights" .= rightsView
        , Just $ "rowClass" .= rowClassView
        , Just $ "rowsUpdatedAt" .= rowsUpdatedAtView
        , Just $ "rowsUpdatedBy" .= rowsUpdatedByView
        , Just $ "tableAuthor" .= tableAuthorView
        , Just $ "tableId" .= tableIDView
        , Just $ "totalTimesRated" .= totalTimesRatedView
        , Just $ "viewCount" .= viewCountView
        , Just $ "id" .= viewIDView
        , Just $ "viewLastModified" .= viewLastModifiedView
        , Just $ "viewType" .= viewTypeView
        ]

instance FromJSON View where
    parseJSON (Object v) = View
        <$> v .: "averageRating"
        <*> v .: "category"
        <*> v .: "columns"
        <*> v .: "createdAt"
        <*> v .: "displayType"
        <*> v .: "downloadCount"
        <*> v .: "flags"
        <*> v .: "grants"
        <*> v .: "hideFromCatalog"
        <*> v .: "hideFromDataJson"
        <*> v .: "indexUpdatedAt"
        <*> v .: "license"
        <*> v .: "licenseId"
        <*> v .: "locale"
        <*> v .: "metadata"
        <*> v .: "name"
        <*> v .: "newBackend"
        <*> v .: "numberOfComments"
        <*> v .: "oid"
        <*> v .: "owner"
        <*> v .: "provenance"
        <*> v .: "publicationAppendEnabled"
        <*> v .: "publicationDate"
        <*> v .: "publicationGroup"
        <*> v .: "publicationStage"
        <*> v .: "query"
        <*> v .: "rights"
        <*> v .: "rowClass"
        <*> v .: "rowsUpdatedAt"
        <*> v .: "rowsUpdatedBy"
        <*> v .: "tableAuthor"
        <*> v .: "tableId"
        <*> v .: "totalTimesRated"
        <*> v .: "viewCount"
        <*> v .: "id"
        <*> v .: "viewLastModified"
        <*> v .: "viewType"

instance ToJSON Column where
    toJSON (Column cachedContentsColumn columnIDColumn dataTypeNameColumn fieldNameColumn flagsColumn formatColumn nameColumn positionColumn renderTypeNameColumn tableColumnIDColumn widthColumn) =
        object $ foldMap (maybe [] pure)
        [ ("cachedContents" .=) <$> cachedContentsColumn
        , Just $ "id" .= columnIDColumn
        , Just $ "dataTypeName" .= dataTypeNameColumn
        , Just $ "fieldName" .= fieldNameColumn
        , ("flags" .=) <$> flagsColumn
        , Just $ "format" .= formatColumn
        , Just $ "name" .= nameColumn
        , Just $ "position" .= positionColumn
        , Just $ "renderTypeName" .= renderTypeNameColumn
        , ("tableColumnId" .=) <$> tableColumnIDColumn
        , ("width" .=) <$> widthColumn
        ]

instance FromJSON Column where
    parseJSON (Object v) = Column
        <$> v .:! "cachedContents"
        <*> v .: "id"
        <*> v .: "dataTypeName"
        <*> v .: "fieldName"
        <*> v .:! "flags"
        <*> v .: "format"
        <*> v .: "name"
        <*> v .: "position"
        <*> v .: "renderTypeName"
        <*> v .:! "tableColumnId"
        <*> v .:! "width"

instance ToJSON CachedContents where
    toJSON (CachedContents averageCachedContents largestCachedContents nonNullCachedContents nullCachedContents smallestCachedContents sumCachedContents topCachedContents) =
        object $ foldMap (maybe [] pure)
        [ ("average" .=) <$> averageCachedContents
        , Just $ "largest" .= largestCachedContents
        , Just $ "non_null" .= nonNullCachedContents
        , Just $ "null" .= nullCachedContents
        , Just $ "smallest" .= smallestCachedContents
        , ("sum" .=) <$> sumCachedContents
        , Just $ "top" .= topCachedContents
        ]

instance FromJSON CachedContents where
    parseJSON (Object v) = CachedContents
        <$> v .:! "average"
        <*> v .: "largest"
        <*> v .: "non_null"
        <*> v .: "null"
        <*> v .: "smallest"
        <*> v .:! "sum"
        <*> v .: "top"

instance ToJSON Top where
    toJSON (Top countTop itemTop) =
        object $ foldMap (maybe [] pure)
        [ Just $ "count" .= countTop
        , Just $ "item" .= itemTop
        ]

instance FromJSON Top where
    parseJSON (Object v) = Top
        <$> v .: "count"
        <*> v .: "item"

instance ToJSON TypeName where
    toJSON MetaDataTypeName = "meta_data"
    toJSON NumberTypeName = "number"
    toJSON TextTypeName = "text"

instance FromJSON TypeName where
    parseJSON = withText "TypeName" parseText
        where
            parseText "meta_data" = return MetaDataTypeName
            parseText "number" = return NumberTypeName
            parseText "text" = return TextTypeName

instance ToJSON Query where
    toJSON = \_ -> emptyObject

instance FromJSON Query where
    parseJSON (Object _) = return Query

instance ToJSON Grant where
    toJSON (Grant flagsGrant grantTypeGrant inheritedGrant) =
        object $ foldMap (maybe [] pure)
        [ Just $ "flags" .= flagsGrant
        , Just $ "type" .= grantTypeGrant
        , Just $ "inherited" .= inheritedGrant
        ]

instance FromJSON Grant where
    parseJSON (Object v) = Grant
        <$> v .: "flags"
        <*> v .: "type"
        <*> v .: "inherited"

instance ToJSON License where
    toJSON (License nameLicense) =
        object $ foldMap (maybe [] pure)
        [ Just $ "name" .= nameLicense
        ]

instance FromJSON License where
    parseJSON (Object v) = License
        <$> v .: "name"

instance ToJSON Metadata where
    toJSON (Metadata availableDisplayTypesMetadata rdfClassMetadata rdfSubjectMetadata renderTypeConfigMetadata rowIdentifierMetadata) =
        object $ foldMap (maybe [] pure)
        [ Just $ "availableDisplayTypes" .= availableDisplayTypesMetadata
        , Just $ "rdfClass" .= rdfClassMetadata
        , Just $ "rdfSubject" .= rdfSubjectMetadata
        , Just $ "renderTypeConfig" .= renderTypeConfigMetadata
        , Just $ "rowIdentifier" .= rowIdentifierMetadata
        ]

instance FromJSON Metadata where
    parseJSON (Object v) = Metadata
        <$> v .: "availableDisplayTypes"
        <*> v .: "rdfClass"
        <*> v .: "rdfSubject"
        <*> v .: "renderTypeConfig"
        <*> v .: "rowIdentifier"

instance ToJSON RenderTypeConfig where
    toJSON (RenderTypeConfig visibleRenderTypeConfig) =
        object $ foldMap (maybe [] pure)
        [ Just $ "visible" .= visibleRenderTypeConfig
        ]

instance FromJSON RenderTypeConfig where
    parseJSON (Object v) = RenderTypeConfig
        <$> v .: "visible"

instance ToJSON Visible where
    toJSON (Visible tableVisible) =
        object $ foldMap (maybe [] pure)
        [ Just $ "table" .= tableVisible
        ]

instance FromJSON Visible where
    parseJSON (Object v) = Visible
        <$> v .: "table"

instance ToJSON Owner where
    toJSON (Owner displayNameOwner ownerIDOwner screenNameOwner) =
        object $ foldMap (maybe [] pure)
        [ Just $ "displayName" .= displayNameOwner
        , Just $ "id" .= ownerIDOwner
        , Just $ "screenName" .= screenNameOwner
        ]

instance FromJSON Owner where
    parseJSON (Object v) = Owner
        <$> v .: "displayName"
        <*> v .: "id"
        <*> v .: "screenName"

instance ToJSON Datum where
    toJSON (IntegerInDatum x) = toJSON x
    toJSON NullInDatum = Null
    toJSON (StringInDatum x) = toJSON x

instance FromJSON Datum where
    parseJSON xs@(Number _) = (fmap IntegerInDatum . parseJSON) xs
    parseJSON Null = return NullInDatum
    parseJSON xs@(String _) = (fmap StringInDatum . parseJSON) xs
