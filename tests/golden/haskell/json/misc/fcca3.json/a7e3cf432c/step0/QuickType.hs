{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Meta (..)
    , View (..)
    , Column (..)
    , CachedContents (..)
    , Top (..)
    , Format (..)
    , Grant (..)
    , ViewMetadata (..)
    , Attachment (..)
    , CustomFields (..)
    , CommonCore (..)
    , DatasetInformation (..)
    , DatasetSummary (..)
    , Disclaimers (..)
    , FilterCondition (..)
    , Child (..)
    , ChildMetadata (..)
    , TableColumnID (..)
    , FilterConditionMetadata (..)
    , JSONQuery (..)
    , Order (..)
    , RenderTypeConfig (..)
    , Visible (..)
    , Owner (..)
    , Query (..)
    , OrderBy (..)
    , Expression (..)
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
    { attributionView :: Text
    , averageRatingView :: Int
    , categoryView :: Text
    , columnsView :: [Column]
    , createdAtView :: Int
    , descriptionView :: Text
    , displayTypeView :: Text
    , downloadCountView :: Int
    , flagsView :: [Text]
    , grantsView :: [Grant]
    , hideFromCatalogView :: Bool
    , hideFromDataJSONView :: Bool
    , indexUpdatedAtView :: Int
    , localeView :: Text
    , metadataView :: ViewMetadata
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
    , rowsUpdatedAtView :: Int
    , rowsUpdatedByView :: Text
    , tableAuthorView :: Owner
    , tableIDView :: Int
    , tagsView :: [Text]
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
    , descriptionColumn :: Maybe Text
    , fieldNameColumn :: Text
    , flagsColumn :: Maybe ([Text])
    , formatColumn :: Format
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

data Format = Format
    { alignFormat :: Maybe Text
    , noCommasFormat :: Maybe Text
    , precisionStyleFormat :: Maybe Text
    } deriving (Show)

data Grant = Grant
    { flagsGrant :: [Text]
    , grantTypeGrant :: Text
    , inheritedGrant :: Bool
    } deriving (Show)

data ViewMetadata = ViewMetadata
    { attachmentsViewMetadata :: [Attachment]
    , availableDisplayTypesViewMetadata :: [Text]
    , customFieldsViewMetadata :: CustomFields
    , filterConditionViewMetadata :: FilterCondition
    , jsonQueryViewMetadata :: JSONQuery
    , rdfSubjectViewMetadata :: Text
    , renderTypeConfigViewMetadata :: RenderTypeConfig
    , rowLabelViewMetadata :: Text
    } deriving (Show)

data Attachment = Attachment
    { assetIDAttachment :: Text
    , blobIDAttachment :: Text
    , filenameAttachment :: Text
    , nameAttachment :: Text
    } deriving (Show)

data CustomFields = CustomFields
    { commonCoreCustomFields :: CommonCore
    , datasetInformationCustomFields :: DatasetInformation
    , datasetSummaryCustomFields :: DatasetSummary
    , disclaimersCustomFields :: Disclaimers
    } deriving (Show)

data CommonCore = CommonCore
    { contactEmailCommonCore :: Text
    , contactNameCommonCore :: Text
    , publisherCommonCore :: Text
    } deriving (Show)

data DatasetInformation = DatasetInformation
    { agencyDatasetInformation :: Text
    } deriving (Show)

data DatasetSummary = DatasetSummary
    { contactInformationDatasetSummary :: Text
    , coverageDatasetSummary :: Text
    , granularityDatasetSummary :: Text
    , organizationDatasetSummary :: Text
    , postingFrequencyDatasetSummary :: Text
    , timePeriodDatasetSummary :: Text
    } deriving (Show)

data Disclaimers = Disclaimers
    { disclaimerDisclaimers :: Text
    , limitationsDisclaimers :: Text
    } deriving (Show)

data FilterCondition = FilterCondition
    { childrenFilterCondition :: [Child]
    , filterConditionTypeFilterCondition :: Text
    , metadataFilterCondition :: FilterConditionMetadata
    , valueFilterCondition :: Text
    } deriving (Show)

data Child = Child
    { childTypeChild :: Text
    , metadataChild :: ChildMetadata
    , valueChild :: Text
    } deriving (Show)

data ChildMetadata = ChildMetadata
    { customValuesChildMetadata :: [([Text])]
    , operatorChildMetadata :: Text
    , tableColumnIDChildMetadata :: TableColumnID
    } deriving (Show)

data TableColumnID = TableColumnID
    { the703610TableColumnID :: Int
    } deriving (Show)

data FilterConditionMetadata = FilterConditionMetadata
    { advancedFilterConditionMetadata :: Bool
    , unifiedVersionFilterConditionMetadata :: Int
    } deriving (Show)

data JSONQuery = JSONQuery
    { orderJSONQuery :: [Order]
    } deriving (Show)

data Order = Order
    { ascendingOrder :: Bool
    , columnFieldNameOrder :: Text
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
    , profileImageURLLargeOwner :: Text
    , profileImageURLMediumOwner :: Text
    , profileImageURLSmallOwner :: Text
    , rightsOwner :: [Text]
    , roleNameOwner :: Text
    , screenNameOwner :: Text
    } deriving (Show)

data Query = Query
    { orderBysQuery :: [OrderBy]
    } deriving (Show)

data OrderBy = OrderBy
    { ascendingOrderBy :: Bool
    , expressionOrderBy :: Expression
    } deriving (Show)

data Expression = Expression
    { columnIDExpression :: Int
    , expressionTypeExpression :: Text
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
    toJSON (View attributionView averageRatingView categoryView columnsView createdAtView descriptionView displayTypeView downloadCountView flagsView grantsView hideFromCatalogView hideFromDataJSONView indexUpdatedAtView localeView metadataView nameView newBackendView numberOfCommentsView oidView ownerView provenanceView publicationAppendEnabledView publicationDateView publicationGroupView publicationStageView queryView rightsView rowsUpdatedAtView rowsUpdatedByView tableAuthorView tableIDView tagsView totalTimesRatedView viewCountView viewIDView viewLastModifiedView viewTypeView) =
        object $ foldMap (maybe [] pure)
        [ Just $ "attribution" .= attributionView
        , Just $ "averageRating" .= averageRatingView
        , Just $ "category" .= categoryView
        , Just $ "columns" .= columnsView
        , Just $ "createdAt" .= createdAtView
        , Just $ "description" .= descriptionView
        , Just $ "displayType" .= displayTypeView
        , Just $ "downloadCount" .= downloadCountView
        , Just $ "flags" .= flagsView
        , Just $ "grants" .= grantsView
        , Just $ "hideFromCatalog" .= hideFromCatalogView
        , Just $ "hideFromDataJson" .= hideFromDataJSONView
        , Just $ "indexUpdatedAt" .= indexUpdatedAtView
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
        , Just $ "rowsUpdatedAt" .= rowsUpdatedAtView
        , Just $ "rowsUpdatedBy" .= rowsUpdatedByView
        , Just $ "tableAuthor" .= tableAuthorView
        , Just $ "tableId" .= tableIDView
        , Just $ "tags" .= tagsView
        , Just $ "totalTimesRated" .= totalTimesRatedView
        , Just $ "viewCount" .= viewCountView
        , Just $ "id" .= viewIDView
        , Just $ "viewLastModified" .= viewLastModifiedView
        , Just $ "viewType" .= viewTypeView
        ]

instance FromJSON View where
    parseJSON (Object v) = View
        <$> v .: "attribution"
        <*> v .: "averageRating"
        <*> v .: "category"
        <*> v .: "columns"
        <*> v .: "createdAt"
        <*> v .: "description"
        <*> v .: "displayType"
        <*> v .: "downloadCount"
        <*> v .: "flags"
        <*> v .: "grants"
        <*> v .: "hideFromCatalog"
        <*> v .: "hideFromDataJson"
        <*> v .: "indexUpdatedAt"
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
        <*> v .: "rowsUpdatedAt"
        <*> v .: "rowsUpdatedBy"
        <*> v .: "tableAuthor"
        <*> v .: "tableId"
        <*> v .: "tags"
        <*> v .: "totalTimesRated"
        <*> v .: "viewCount"
        <*> v .: "id"
        <*> v .: "viewLastModified"
        <*> v .: "viewType"

instance ToJSON Column where
    toJSON (Column cachedContentsColumn columnIDColumn dataTypeNameColumn descriptionColumn fieldNameColumn flagsColumn formatColumn nameColumn positionColumn renderTypeNameColumn tableColumnIDColumn widthColumn) =
        object $ foldMap (maybe [] pure)
        [ ("cachedContents" .=) <$> cachedContentsColumn
        , Just $ "id" .= columnIDColumn
        , Just $ "dataTypeName" .= dataTypeNameColumn
        , ("description" .=) <$> descriptionColumn
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
        <*> v .:! "description"
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

instance ToJSON Format where
    toJSON (Format alignFormat noCommasFormat precisionStyleFormat) =
        object $ foldMap (maybe [] pure)
        [ ("align" .=) <$> alignFormat
        , ("noCommas" .=) <$> noCommasFormat
        , ("precisionStyle" .=) <$> precisionStyleFormat
        ]

instance FromJSON Format where
    parseJSON (Object v) = Format
        <$> v .:! "align"
        <*> v .:! "noCommas"
        <*> v .:! "precisionStyle"

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

instance ToJSON ViewMetadata where
    toJSON (ViewMetadata attachmentsViewMetadata availableDisplayTypesViewMetadata customFieldsViewMetadata filterConditionViewMetadata jsonQueryViewMetadata rdfSubjectViewMetadata renderTypeConfigViewMetadata rowLabelViewMetadata) =
        object $ foldMap (maybe [] pure)
        [ Just $ "attachments" .= attachmentsViewMetadata
        , Just $ "availableDisplayTypes" .= availableDisplayTypesViewMetadata
        , Just $ "custom_fields" .= customFieldsViewMetadata
        , Just $ "filterCondition" .= filterConditionViewMetadata
        , Just $ "jsonQuery" .= jsonQueryViewMetadata
        , Just $ "rdfSubject" .= rdfSubjectViewMetadata
        , Just $ "renderTypeConfig" .= renderTypeConfigViewMetadata
        , Just $ "rowLabel" .= rowLabelViewMetadata
        ]

instance FromJSON ViewMetadata where
    parseJSON (Object v) = ViewMetadata
        <$> v .: "attachments"
        <*> v .: "availableDisplayTypes"
        <*> v .: "custom_fields"
        <*> v .: "filterCondition"
        <*> v .: "jsonQuery"
        <*> v .: "rdfSubject"
        <*> v .: "renderTypeConfig"
        <*> v .: "rowLabel"

instance ToJSON Attachment where
    toJSON (Attachment assetIDAttachment blobIDAttachment filenameAttachment nameAttachment) =
        object $ foldMap (maybe [] pure)
        [ Just $ "assetId" .= assetIDAttachment
        , Just $ "blobId" .= blobIDAttachment
        , Just $ "filename" .= filenameAttachment
        , Just $ "name" .= nameAttachment
        ]

instance FromJSON Attachment where
    parseJSON (Object v) = Attachment
        <$> v .: "assetId"
        <*> v .: "blobId"
        <*> v .: "filename"
        <*> v .: "name"

instance ToJSON CustomFields where
    toJSON (CustomFields commonCoreCustomFields datasetInformationCustomFields datasetSummaryCustomFields disclaimersCustomFields) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Common Core" .= commonCoreCustomFields
        , Just $ "Dataset Information" .= datasetInformationCustomFields
        , Just $ "Dataset Summary" .= datasetSummaryCustomFields
        , Just $ "Disclaimers" .= disclaimersCustomFields
        ]

instance FromJSON CustomFields where
    parseJSON (Object v) = CustomFields
        <$> v .: "Common Core"
        <*> v .: "Dataset Information"
        <*> v .: "Dataset Summary"
        <*> v .: "Disclaimers"

instance ToJSON CommonCore where
    toJSON (CommonCore contactEmailCommonCore contactNameCommonCore publisherCommonCore) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Contact Email" .= contactEmailCommonCore
        , Just $ "Contact Name" .= contactNameCommonCore
        , Just $ "Publisher" .= publisherCommonCore
        ]

instance FromJSON CommonCore where
    parseJSON (Object v) = CommonCore
        <$> v .: "Contact Email"
        <*> v .: "Contact Name"
        <*> v .: "Publisher"

instance ToJSON DatasetInformation where
    toJSON (DatasetInformation agencyDatasetInformation) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Agency" .= agencyDatasetInformation
        ]

instance FromJSON DatasetInformation where
    parseJSON (Object v) = DatasetInformation
        <$> v .: "Agency"

instance ToJSON DatasetSummary where
    toJSON (DatasetSummary contactInformationDatasetSummary coverageDatasetSummary granularityDatasetSummary organizationDatasetSummary postingFrequencyDatasetSummary timePeriodDatasetSummary) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Contact Information" .= contactInformationDatasetSummary
        , Just $ "Coverage" .= coverageDatasetSummary
        , Just $ "Granularity" .= granularityDatasetSummary
        , Just $ "Organization" .= organizationDatasetSummary
        , Just $ "Posting Frequency" .= postingFrequencyDatasetSummary
        , Just $ "Time Period" .= timePeriodDatasetSummary
        ]

instance FromJSON DatasetSummary where
    parseJSON (Object v) = DatasetSummary
        <$> v .: "Contact Information"
        <*> v .: "Coverage"
        <*> v .: "Granularity"
        <*> v .: "Organization"
        <*> v .: "Posting Frequency"
        <*> v .: "Time Period"

instance ToJSON Disclaimers where
    toJSON (Disclaimers disclaimerDisclaimers limitationsDisclaimers) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Disclaimer" .= disclaimerDisclaimers
        , Just $ "Limitations" .= limitationsDisclaimers
        ]

instance FromJSON Disclaimers where
    parseJSON (Object v) = Disclaimers
        <$> v .: "Disclaimer"
        <*> v .: "Limitations"

instance ToJSON FilterCondition where
    toJSON (FilterCondition childrenFilterCondition filterConditionTypeFilterCondition metadataFilterCondition valueFilterCondition) =
        object $ foldMap (maybe [] pure)
        [ Just $ "children" .= childrenFilterCondition
        , Just $ "type" .= filterConditionTypeFilterCondition
        , Just $ "metadata" .= metadataFilterCondition
        , Just $ "value" .= valueFilterCondition
        ]

instance FromJSON FilterCondition where
    parseJSON (Object v) = FilterCondition
        <$> v .: "children"
        <*> v .: "type"
        <*> v .: "metadata"
        <*> v .: "value"

instance ToJSON Child where
    toJSON (Child childTypeChild metadataChild valueChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= childTypeChild
        , Just $ "metadata" .= metadataChild
        , Just $ "value" .= valueChild
        ]

instance FromJSON Child where
    parseJSON (Object v) = Child
        <$> v .: "type"
        <*> v .: "metadata"
        <*> v .: "value"

instance ToJSON ChildMetadata where
    toJSON (ChildMetadata customValuesChildMetadata operatorChildMetadata tableColumnIDChildMetadata) =
        object $ foldMap (maybe [] pure)
        [ Just $ "customValues" .= customValuesChildMetadata
        , Just $ "operator" .= operatorChildMetadata
        , Just $ "tableColumnId" .= tableColumnIDChildMetadata
        ]

instance FromJSON ChildMetadata where
    parseJSON (Object v) = ChildMetadata
        <$> v .: "customValues"
        <*> v .: "operator"
        <*> v .: "tableColumnId"

instance ToJSON TableColumnID where
    toJSON (TableColumnID the703610TableColumnID) =
        object $ foldMap (maybe [] pure)
        [ Just $ "703610" .= the703610TableColumnID
        ]

instance FromJSON TableColumnID where
    parseJSON (Object v) = TableColumnID
        <$> v .: "703610"

instance ToJSON FilterConditionMetadata where
    toJSON (FilterConditionMetadata advancedFilterConditionMetadata unifiedVersionFilterConditionMetadata) =
        object $ foldMap (maybe [] pure)
        [ Just $ "advanced" .= advancedFilterConditionMetadata
        , Just $ "unifiedVersion" .= unifiedVersionFilterConditionMetadata
        ]

instance FromJSON FilterConditionMetadata where
    parseJSON (Object v) = FilterConditionMetadata
        <$> v .: "advanced"
        <*> v .: "unifiedVersion"

instance ToJSON JSONQuery where
    toJSON (JSONQuery orderJSONQuery) =
        object $ foldMap (maybe [] pure)
        [ Just $ "order" .= orderJSONQuery
        ]

instance FromJSON JSONQuery where
    parseJSON (Object v) = JSONQuery
        <$> v .: "order"

instance ToJSON Order where
    toJSON (Order ascendingOrder columnFieldNameOrder) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ascending" .= ascendingOrder
        , Just $ "columnFieldName" .= columnFieldNameOrder
        ]

instance FromJSON Order where
    parseJSON (Object v) = Order
        <$> v .: "ascending"
        <*> v .: "columnFieldName"

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
    toJSON (Owner displayNameOwner ownerIDOwner profileImageURLLargeOwner profileImageURLMediumOwner profileImageURLSmallOwner rightsOwner roleNameOwner screenNameOwner) =
        object $ foldMap (maybe [] pure)
        [ Just $ "displayName" .= displayNameOwner
        , Just $ "id" .= ownerIDOwner
        , Just $ "profileImageUrlLarge" .= profileImageURLLargeOwner
        , Just $ "profileImageUrlMedium" .= profileImageURLMediumOwner
        , Just $ "profileImageUrlSmall" .= profileImageURLSmallOwner
        , Just $ "rights" .= rightsOwner
        , Just $ "roleName" .= roleNameOwner
        , Just $ "screenName" .= screenNameOwner
        ]

instance FromJSON Owner where
    parseJSON (Object v) = Owner
        <$> v .: "displayName"
        <*> v .: "id"
        <*> v .: "profileImageUrlLarge"
        <*> v .: "profileImageUrlMedium"
        <*> v .: "profileImageUrlSmall"
        <*> v .: "rights"
        <*> v .: "roleName"
        <*> v .: "screenName"

instance ToJSON Query where
    toJSON (Query orderBysQuery) =
        object $ foldMap (maybe [] pure)
        [ Just $ "orderBys" .= orderBysQuery
        ]

instance FromJSON Query where
    parseJSON (Object v) = Query
        <$> v .: "orderBys"

instance ToJSON OrderBy where
    toJSON (OrderBy ascendingOrderBy expressionOrderBy) =
        object $ foldMap (maybe [] pure)
        [ Just $ "ascending" .= ascendingOrderBy
        , Just $ "expression" .= expressionOrderBy
        ]

instance FromJSON OrderBy where
    parseJSON (Object v) = OrderBy
        <$> v .: "ascending"
        <*> v .: "expression"

instance ToJSON Expression where
    toJSON (Expression columnIDExpression expressionTypeExpression) =
        object $ foldMap (maybe [] pure)
        [ Just $ "columnId" .= columnIDExpression
        , Just $ "type" .= expressionTypeExpression
        ]

instance FromJSON Expression where
    parseJSON (Object v) = Expression
        <$> v .: "columnId"
        <*> v .: "type"

instance ToJSON Datum where
    toJSON (IntegerInDatum x) = toJSON x
    toJSON NullInDatum = Null
    toJSON (StringInDatum x) = toJSON x

instance FromJSON Datum where
    parseJSON xs@(Number _) = (fmap IntegerInDatum . parseJSON) xs
    parseJSON Null = return NullInDatum
    parseJSON xs@(String _) = (fmap StringInDatum . parseJSON) xs
