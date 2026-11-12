{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , QuickTypeElement (..)
    , Grant (..)
    , QuickTypeMetadata (..)
    , CustomFields (..)
    , Test (..)
    , JSONQuery (..)
    , Group (..)
    , Where (..)
    , Child (..)
    , ChildMetadata (..)
    , TableColumnID (..)
    , Order (..)
    , Select (..)
    , MetadataRenderTypeConfig (..)
    , PurpleVisible (..)
    , RichRendererConfigs (..)
    , FatRow (..)
    , Column (..)
    , Row (..)
    , Field (..)
    , Styles (..)
    , V1ArchivedProperties (..)
    , AccessPoints (..)
    , V1ArchivedPropertiesRenderTypeConfig (..)
    , FluffyVisible (..)
    , Owner (..)
    , Ratings (..)
    , TableAuthor (..)
    , DisplayType (..)
    , QuickTypeFlag (..)
    , GrantFlag (..)
    , GrantType (..)
    , ChildColumnFieldName (..)
    , MetadataOperator (..)
    , ChildOperator (..)
    , WhereOperator (..)
    , OrderColumnFieldName (..)
    , FieldType (..)
    , Width (..)
    , ModifyingViewUid (..)
    , RoleName (..)
    , Provenance (..)
    , PublicationStage (..)
    , RightElement (..)
    , RowsUpdatedBy (..)
    , ViewType (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type QuickType = [QuickTypeElement]

data QuickTypeElement = QuickTypeElement
    { averageRatingQuickTypeElement :: Int
    , categoryQuickTypeElement :: Maybe Text
    , createdAtQuickTypeElement :: Int
    , descriptionQuickTypeElement :: Maybe Text
    , displayTypeQuickTypeElement :: Maybe DisplayType
    , downloadCountQuickTypeElement :: Int
    , flagsQuickTypeElement :: Maybe ([QuickTypeFlag])
    , grantsQuickTypeElement :: [Grant]
    , hideFromCatalogQuickTypeElement :: Bool
    , hideFromDataJSONQuickTypeElement :: Bool
    , indexUpdatedAtQuickTypeElement :: Maybe Int
    , localeQuickTypeElement :: Text
    , metadataQuickTypeElement :: QuickTypeMetadata
    , moderationStatusQuickTypeElement :: Maybe Bool
    , modifyingViewUidQuickTypeElement :: Maybe ModifyingViewUid
    , nameQuickTypeElement :: Text
    , newBackendQuickTypeElement :: Bool
    , numberOfCommentsQuickTypeElement :: Int
    , oidQuickTypeElement :: Int
    , ownerQuickTypeElement :: Owner
    , provenanceQuickTypeElement :: Provenance
    , publicationAppendEnabledQuickTypeElement :: Bool
    , publicationDateQuickTypeElement :: Maybe Int
    , publicationGroupQuickTypeElement :: Int
    , publicationStageQuickTypeElement :: PublicationStage
    , quickTypeIDQuickTypeElement :: Text
    , ratingsQuickTypeElement :: Maybe Ratings
    , resourceNameQuickTypeElement :: Maybe Text
    , rightsQuickTypeElement :: [RightElement]
    , rowClassQuickTypeElement :: Maybe Text
    , rowIdentifierColumnIDQuickTypeElement :: Maybe Int
    , rowsUpdatedAtQuickTypeElement :: Maybe Int
    , rowsUpdatedByQuickTypeElement :: Maybe RowsUpdatedBy
    , tableAuthorQuickTypeElement :: TableAuthor
    , tableIDQuickTypeElement :: Int
    , tagsQuickTypeElement :: Maybe ([Text])
    , totalTimesRatedQuickTypeElement :: Int
    , viewCountQuickTypeElement :: Int
    , viewLastModifiedQuickTypeElement :: Int
    , viewTypeQuickTypeElement :: ViewType
    } deriving (Show)

data DisplayType
    = TableDisplayType
    | DataLensDisplayType
    | FatrowDisplayType
    | PageDisplayType
    deriving (Show)

data QuickTypeFlag
    = DefaultQuickTypeFlag
    | RestorableQuickTypeFlag
    | RestorePossibleForTypeQuickTypeFlag
    deriving (Show)

data Grant = Grant
    { flagsGrant :: [GrantFlag]
    , grantTypeGrant :: GrantType
    , inheritedGrant :: Bool
    } deriving (Show)

data GrantFlag
    = PublicGrantFlag
    deriving (Show)

data GrantType
    = ViewerGrantType
    deriving (Show)

data QuickTypeMetadata = QuickTypeMetadata
    { availableDisplayTypesQuickTypeMetadata :: Maybe ([DisplayType])
    , customFieldsQuickTypeMetadata :: Maybe CustomFields
    , jsonQueryQuickTypeMetadata :: Maybe JSONQuery
    , rdfClassQuickTypeMetadata :: Maybe Text
    , rdfSubjectQuickTypeMetadata :: Maybe Text
    , renderTypeConfigQuickTypeMetadata :: Maybe MetadataRenderTypeConfig
    , richRendererConfigsQuickTypeMetadata :: Maybe RichRendererConfigs
    , rowIdentifierQuickTypeMetadata :: Maybe Text
    , rowLabelQuickTypeMetadata :: Maybe Text
    , v1ArchivedPropertiesQuickTypeMetadata :: Maybe V1ArchivedProperties
    } deriving (Show)

data CustomFields = CustomFields
    { testCustomFields :: Test
    } deriving (Show)

data Test = Test
    { cfpb1Test :: Text
    } deriving (Show)

data JSONQuery = JSONQuery
    { groupJSONQuery :: Maybe ([Group])
    , jsonQueryWhereJSONQuery :: Maybe Where
    , orderJSONQuery :: Maybe ([Order])
    , selectJSONQuery :: Maybe ([Select])
    } deriving (Show)

data Group = Group
    { columnFieldNameGroup :: Text
    } deriving (Show)

data Where = Where
    { childrenWhere :: Maybe ([Child])
    , columnFieldNameWhere :: Maybe ChildColumnFieldName
    , metadataWhere :: Maybe ChildMetadata
    , operatorWhere :: WhereOperator
    , valueWhere :: Maybe Text
    } deriving (Show)

data Child = Child
    { columnFieldNameChild :: ChildColumnFieldName
    , metadataChild :: Maybe ChildMetadata
    , operatorChild :: ChildOperator
    , valueChild :: Maybe Text
    } deriving (Show)

data ChildColumnFieldName
    = ProductChildColumnFieldName
    | ComplaintWhatHappenedChildColumnFieldName
    | SubProductChildColumnFieldName
    | IssueChildColumnFieldName
    deriving (Show)

data ChildMetadata = ChildMetadata
    { customValuesChildMetadata :: Maybe ([Text])
    , freeformChildMetadata :: Maybe Bool
    , includeAutoChildMetadata :: Maybe Int
    , operatorChildMetadata :: Maybe MetadataOperator
    , tableColumnIDChildMetadata :: Maybe TableColumnID
    , unifiedVersionChildMetadata :: Maybe Int
    } deriving (Show)

data MetadataOperator
    = EQUALSMetadataOperator
    | BlankMetadataOperator
    deriving (Show)

data TableColumnID = TableColumnID
    { the2819740TableColumnID :: Int
    } deriving (Show)

data ChildOperator
    = EQUALSChildOperator
    | ISNOTBLANKChildOperator
    deriving (Show)

data WhereOperator
    = EQUALSWhereOperator
    | ANDWhereOperator
    deriving (Show)

data Order = Order
    { ascendingOrder :: Bool
    , columnFieldNameOrder :: OrderColumnFieldName
    } deriving (Show)

data OrderColumnFieldName
    = DateReceivedOrderColumnFieldName
    | AgreementDateOrderColumnFieldName
    | InEffectAsOf1_1_2012_OrderColumnFieldName
    deriving (Show)

data Select = Select
    { aggregateSelect :: Maybe Text
    , columnFieldNameSelect :: Text
    } deriving (Show)

data MetadataRenderTypeConfig = MetadataRenderTypeConfig
    { visibleMetadataRenderTypeConfig :: PurpleVisible
    } deriving (Show)

data PurpleVisible = PurpleVisible
    { fatrowPurpleVisible :: Maybe Bool
    , tablePurpleVisible :: Maybe Bool
    } deriving (Show)

data RichRendererConfigs = RichRendererConfigs
    { fatRowRichRendererConfigs :: FatRow
    } deriving (Show)

data FatRow = FatRow
    { columnsFatRow :: [Column]
    } deriving (Show)

data Column = Column
    { rowsColumn :: [Row]
    , stylesColumn :: Styles
    } deriving (Show)

data Row = Row
    { fieldsRow :: [Field]
    } deriving (Show)

data Field = Field
    { fieldTypeField :: FieldType
    , tableColumnIDField :: Int
    } deriving (Show)

data FieldType
    = ColumnLabelFieldType
    | ColumnDataFieldType
    deriving (Show)

data Styles = Styles
    { widthStyles :: Width
    } deriving (Show)

data Width
    = The27_Width
    | The40_Width
    | The30_Width
    | The33_Width
    deriving (Show)

data V1ArchivedProperties = V1ArchivedProperties
    { accessPointsV1ArchivedProperties :: AccessPoints
    , blistIDV1ArchivedProperties :: Text
    , renderTypeConfigV1ArchivedProperties :: V1ArchivedPropertiesRenderTypeConfig
    } deriving (Show)

data AccessPoints = AccessPoints
    { newViewAccessPoints :: Text
    } deriving (Show)

data V1ArchivedPropertiesRenderTypeConfig = V1ArchivedPropertiesRenderTypeConfig
    { visibleV1ArchivedPropertiesRenderTypeConfig :: FluffyVisible
    } deriving (Show)

data FluffyVisible = FluffyVisible
    { hrefFluffyVisible :: Bool
    } deriving (Show)

data ModifyingViewUid
    = S6EwH6MpModifyingViewUid
    deriving (Show)

data Owner = Owner
    { displayNameOwner :: Text
    , flagsOwner :: Maybe ([Text])
    , lastNotificationSeenAtOwner :: Maybe Int
    , ownerIDOwner :: Text
    , profileImageURLLargeOwner :: Maybe Text
    , profileImageURLMediumOwner :: Maybe Text
    , profileImageURLSmallOwner :: Maybe Text
    , rightsOwner :: Maybe ([Text])
    , roleNameOwner :: Maybe RoleName
    , screenNameOwner :: Text
    } deriving (Show)

data RoleName
    = AdministratorRoleName
    | PublisherRoleName
    deriving (Show)

data Provenance
    = OfficialProvenance
    deriving (Show)

data PublicationStage
    = PublishedPublicationStage
    deriving (Show)

data Ratings = Ratings
    { ratingRatings :: Int
    } deriving (Show)

data RightElement
    = ReadRightElement
    deriving (Show)

data RowsUpdatedBy
    = PjxgVe4MRowsUpdatedBy
    | The54A3QyunRowsUpdatedBy
    | The9E3M2843_RowsUpdatedBy
    | VvcaFr6GRowsUpdatedBy
    deriving (Show)

data TableAuthor = TableAuthor
    { displayNameTableAuthor :: Text
    , rightsTableAuthor :: Maybe ([Text])
    , roleNameTableAuthor :: Maybe RoleName
    , screenNameTableAuthor :: Text
    , tableAuthorIDTableAuthor :: Text
    } deriving (Show)

data ViewType
    = TabularViewType
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickTypeElement where
    toJSON (QuickTypeElement averageRatingQuickTypeElement categoryQuickTypeElement createdAtQuickTypeElement descriptionQuickTypeElement displayTypeQuickTypeElement downloadCountQuickTypeElement flagsQuickTypeElement grantsQuickTypeElement hideFromCatalogQuickTypeElement hideFromDataJSONQuickTypeElement indexUpdatedAtQuickTypeElement localeQuickTypeElement metadataQuickTypeElement moderationStatusQuickTypeElement modifyingViewUidQuickTypeElement nameQuickTypeElement newBackendQuickTypeElement numberOfCommentsQuickTypeElement oidQuickTypeElement ownerQuickTypeElement provenanceQuickTypeElement publicationAppendEnabledQuickTypeElement publicationDateQuickTypeElement publicationGroupQuickTypeElement publicationStageQuickTypeElement quickTypeIDQuickTypeElement ratingsQuickTypeElement resourceNameQuickTypeElement rightsQuickTypeElement rowClassQuickTypeElement rowIdentifierColumnIDQuickTypeElement rowsUpdatedAtQuickTypeElement rowsUpdatedByQuickTypeElement tableAuthorQuickTypeElement tableIDQuickTypeElement tagsQuickTypeElement totalTimesRatedQuickTypeElement viewCountQuickTypeElement viewLastModifiedQuickTypeElement viewTypeQuickTypeElement) =
        object $ foldMap (maybe [] pure)
        [ Just $ "averageRating" .= averageRatingQuickTypeElement
        , ("category" .=) <$> categoryQuickTypeElement
        , Just $ "createdAt" .= createdAtQuickTypeElement
        , ("description" .=) <$> descriptionQuickTypeElement
        , ("displayType" .=) <$> displayTypeQuickTypeElement
        , Just $ "downloadCount" .= downloadCountQuickTypeElement
        , ("flags" .=) <$> flagsQuickTypeElement
        , Just $ "grants" .= grantsQuickTypeElement
        , Just $ "hideFromCatalog" .= hideFromCatalogQuickTypeElement
        , Just $ "hideFromDataJson" .= hideFromDataJSONQuickTypeElement
        , ("indexUpdatedAt" .=) <$> indexUpdatedAtQuickTypeElement
        , Just $ "locale" .= localeQuickTypeElement
        , Just $ "metadata" .= metadataQuickTypeElement
        , ("moderationStatus" .=) <$> moderationStatusQuickTypeElement
        , ("modifyingViewUid" .=) <$> modifyingViewUidQuickTypeElement
        , Just $ "name" .= nameQuickTypeElement
        , Just $ "newBackend" .= newBackendQuickTypeElement
        , Just $ "numberOfComments" .= numberOfCommentsQuickTypeElement
        , Just $ "oid" .= oidQuickTypeElement
        , Just $ "owner" .= ownerQuickTypeElement
        , Just $ "provenance" .= provenanceQuickTypeElement
        , Just $ "publicationAppendEnabled" .= publicationAppendEnabledQuickTypeElement
        , ("publicationDate" .=) <$> publicationDateQuickTypeElement
        , Just $ "publicationGroup" .= publicationGroupQuickTypeElement
        , Just $ "publicationStage" .= publicationStageQuickTypeElement
        , Just $ "id" .= quickTypeIDQuickTypeElement
        , ("ratings" .=) <$> ratingsQuickTypeElement
        , ("resourceName" .=) <$> resourceNameQuickTypeElement
        , Just $ "rights" .= rightsQuickTypeElement
        , ("rowClass" .=) <$> rowClassQuickTypeElement
        , ("rowIdentifierColumnId" .=) <$> rowIdentifierColumnIDQuickTypeElement
        , ("rowsUpdatedAt" .=) <$> rowsUpdatedAtQuickTypeElement
        , ("rowsUpdatedBy" .=) <$> rowsUpdatedByQuickTypeElement
        , Just $ "tableAuthor" .= tableAuthorQuickTypeElement
        , Just $ "tableId" .= tableIDQuickTypeElement
        , ("tags" .=) <$> tagsQuickTypeElement
        , Just $ "totalTimesRated" .= totalTimesRatedQuickTypeElement
        , Just $ "viewCount" .= viewCountQuickTypeElement
        , Just $ "viewLastModified" .= viewLastModifiedQuickTypeElement
        , Just $ "viewType" .= viewTypeQuickTypeElement
        ]

instance FromJSON QuickTypeElement where
    parseJSON (Object v) = QuickTypeElement
        <$> v .: "averageRating"
        <*> v .:! "category"
        <*> v .: "createdAt"
        <*> v .:! "description"
        <*> v .:! "displayType"
        <*> v .: "downloadCount"
        <*> v .:! "flags"
        <*> v .: "grants"
        <*> v .: "hideFromCatalog"
        <*> v .: "hideFromDataJson"
        <*> v .:! "indexUpdatedAt"
        <*> v .: "locale"
        <*> v .: "metadata"
        <*> v .:! "moderationStatus"
        <*> v .:! "modifyingViewUid"
        <*> v .: "name"
        <*> v .: "newBackend"
        <*> v .: "numberOfComments"
        <*> v .: "oid"
        <*> v .: "owner"
        <*> v .: "provenance"
        <*> v .: "publicationAppendEnabled"
        <*> v .:! "publicationDate"
        <*> v .: "publicationGroup"
        <*> v .: "publicationStage"
        <*> v .: "id"
        <*> v .:! "ratings"
        <*> v .:! "resourceName"
        <*> v .: "rights"
        <*> v .:! "rowClass"
        <*> v .:! "rowIdentifierColumnId"
        <*> v .:! "rowsUpdatedAt"
        <*> v .:! "rowsUpdatedBy"
        <*> v .: "tableAuthor"
        <*> v .: "tableId"
        <*> v .:! "tags"
        <*> v .: "totalTimesRated"
        <*> v .: "viewCount"
        <*> v .: "viewLastModified"
        <*> v .: "viewType"

instance ToJSON DisplayType where
    toJSON TableDisplayType = "table"
    toJSON DataLensDisplayType = "data_lens"
    toJSON FatrowDisplayType = "fatrow"
    toJSON PageDisplayType = "page"

instance FromJSON DisplayType where
    parseJSON = withText "DisplayType" parseText
        where
            parseText "table" = return TableDisplayType
            parseText "data_lens" = return DataLensDisplayType
            parseText "fatrow" = return FatrowDisplayType
            parseText "page" = return PageDisplayType

instance ToJSON QuickTypeFlag where
    toJSON DefaultQuickTypeFlag = "default"
    toJSON RestorableQuickTypeFlag = "restorable"
    toJSON RestorePossibleForTypeQuickTypeFlag = "restorePossibleForType"

instance FromJSON QuickTypeFlag where
    parseJSON = withText "QuickTypeFlag" parseText
        where
            parseText "default" = return DefaultQuickTypeFlag
            parseText "restorable" = return RestorableQuickTypeFlag
            parseText "restorePossibleForType" = return RestorePossibleForTypeQuickTypeFlag

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

instance ToJSON GrantFlag where
    toJSON PublicGrantFlag = "public"

instance FromJSON GrantFlag where
    parseJSON = withText "GrantFlag" parseText
        where
            parseText "public" = return PublicGrantFlag

instance ToJSON GrantType where
    toJSON ViewerGrantType = "viewer"

instance FromJSON GrantType where
    parseJSON = withText "GrantType" parseText
        where
            parseText "viewer" = return ViewerGrantType

instance ToJSON QuickTypeMetadata where
    toJSON (QuickTypeMetadata availableDisplayTypesQuickTypeMetadata customFieldsQuickTypeMetadata jsonQueryQuickTypeMetadata rdfClassQuickTypeMetadata rdfSubjectQuickTypeMetadata renderTypeConfigQuickTypeMetadata richRendererConfigsQuickTypeMetadata rowIdentifierQuickTypeMetadata rowLabelQuickTypeMetadata v1ArchivedPropertiesQuickTypeMetadata) =
        object $ foldMap (maybe [] pure)
        [ ("availableDisplayTypes" .=) <$> availableDisplayTypesQuickTypeMetadata
        , ("custom_fields" .=) <$> customFieldsQuickTypeMetadata
        , ("jsonQuery" .=) <$> jsonQueryQuickTypeMetadata
        , ("rdfClass" .=) <$> rdfClassQuickTypeMetadata
        , ("rdfSubject" .=) <$> rdfSubjectQuickTypeMetadata
        , ("renderTypeConfig" .=) <$> renderTypeConfigQuickTypeMetadata
        , ("richRendererConfigs" .=) <$> richRendererConfigsQuickTypeMetadata
        , ("rowIdentifier" .=) <$> rowIdentifierQuickTypeMetadata
        , ("rowLabel" .=) <$> rowLabelQuickTypeMetadata
        , ("v1_archived_properties" .=) <$> v1ArchivedPropertiesQuickTypeMetadata
        ]

instance FromJSON QuickTypeMetadata where
    parseJSON (Object v) = QuickTypeMetadata
        <$> v .:! "availableDisplayTypes"
        <*> v .:! "custom_fields"
        <*> v .:! "jsonQuery"
        <*> v .:! "rdfClass"
        <*> v .:! "rdfSubject"
        <*> v .:! "renderTypeConfig"
        <*> v .:! "richRendererConfigs"
        <*> v .:! "rowIdentifier"
        <*> v .:! "rowLabel"
        <*> v .:! "v1_archived_properties"

instance ToJSON CustomFields where
    toJSON (CustomFields testCustomFields) =
        object $ foldMap (maybe [] pure)
        [ Just $ "TEST" .= testCustomFields
        ]

instance FromJSON CustomFields where
    parseJSON (Object v) = CustomFields
        <$> v .: "TEST"

instance ToJSON Test where
    toJSON (Test cfpb1Test) =
        object $ foldMap (maybe [] pure)
        [ Just $ "CFPB1" .= cfpb1Test
        ]

instance FromJSON Test where
    parseJSON (Object v) = Test
        <$> v .: "CFPB1"

instance ToJSON JSONQuery where
    toJSON (JSONQuery groupJSONQuery jsonQueryWhereJSONQuery orderJSONQuery selectJSONQuery) =
        object $ foldMap (maybe [] pure)
        [ ("group" .=) <$> groupJSONQuery
        , ("where" .=) <$> jsonQueryWhereJSONQuery
        , ("order" .=) <$> orderJSONQuery
        , ("select" .=) <$> selectJSONQuery
        ]

instance FromJSON JSONQuery where
    parseJSON (Object v) = JSONQuery
        <$> v .:! "group"
        <*> v .:! "where"
        <*> v .:! "order"
        <*> v .:! "select"

instance ToJSON Group where
    toJSON (Group columnFieldNameGroup) =
        object $ foldMap (maybe [] pure)
        [ Just $ "columnFieldName" .= columnFieldNameGroup
        ]

instance FromJSON Group where
    parseJSON (Object v) = Group
        <$> v .: "columnFieldName"

instance ToJSON Where where
    toJSON (Where childrenWhere columnFieldNameWhere metadataWhere operatorWhere valueWhere) =
        object $ foldMap (maybe [] pure)
        [ ("children" .=) <$> childrenWhere
        , ("columnFieldName" .=) <$> columnFieldNameWhere
        , ("metadata" .=) <$> metadataWhere
        , Just $ "operator" .= operatorWhere
        , ("value" .=) <$> valueWhere
        ]

instance FromJSON Where where
    parseJSON (Object v) = Where
        <$> v .:! "children"
        <*> v .:! "columnFieldName"
        <*> v .:! "metadata"
        <*> v .: "operator"
        <*> v .:! "value"

instance ToJSON Child where
    toJSON (Child columnFieldNameChild metadataChild operatorChild valueChild) =
        object $ foldMap (maybe [] pure)
        [ Just $ "columnFieldName" .= columnFieldNameChild
        , ("metadata" .=) <$> metadataChild
        , Just $ "operator" .= operatorChild
        , ("value" .=) <$> valueChild
        ]

instance FromJSON Child where
    parseJSON (Object v) = Child
        <$> v .: "columnFieldName"
        <*> v .:! "metadata"
        <*> v .: "operator"
        <*> v .:! "value"

instance ToJSON ChildColumnFieldName where
    toJSON ProductChildColumnFieldName = "product"
    toJSON ComplaintWhatHappenedChildColumnFieldName = "complaint_what_happened"
    toJSON SubProductChildColumnFieldName = "sub_product"
    toJSON IssueChildColumnFieldName = "issue"

instance FromJSON ChildColumnFieldName where
    parseJSON = withText "ChildColumnFieldName" parseText
        where
            parseText "product" = return ProductChildColumnFieldName
            parseText "complaint_what_happened" = return ComplaintWhatHappenedChildColumnFieldName
            parseText "sub_product" = return SubProductChildColumnFieldName
            parseText "issue" = return IssueChildColumnFieldName

instance ToJSON ChildMetadata where
    toJSON (ChildMetadata customValuesChildMetadata freeformChildMetadata includeAutoChildMetadata operatorChildMetadata tableColumnIDChildMetadata unifiedVersionChildMetadata) =
        object $ foldMap (maybe [] pure)
        [ ("customValues" .=) <$> customValuesChildMetadata
        , ("freeform" .=) <$> freeformChildMetadata
        , ("includeAuto" .=) <$> includeAutoChildMetadata
        , ("operator" .=) <$> operatorChildMetadata
        , ("tableColumnId" .=) <$> tableColumnIDChildMetadata
        , ("unifiedVersion" .=) <$> unifiedVersionChildMetadata
        ]

instance FromJSON ChildMetadata where
    parseJSON (Object v) = ChildMetadata
        <$> v .:! "customValues"
        <*> v .:! "freeform"
        <*> v .:! "includeAuto"
        <*> v .:! "operator"
        <*> v .:! "tableColumnId"
        <*> v .:! "unifiedVersion"

instance ToJSON MetadataOperator where
    toJSON EQUALSMetadataOperator = "EQUALS"
    toJSON BlankMetadataOperator = "blank?"

instance FromJSON MetadataOperator where
    parseJSON = withText "MetadataOperator" parseText
        where
            parseText "EQUALS" = return EQUALSMetadataOperator
            parseText "blank?" = return BlankMetadataOperator

instance ToJSON TableColumnID where
    toJSON (TableColumnID the2819740TableColumnID) =
        object $ foldMap (maybe [] pure)
        [ Just $ "2819740" .= the2819740TableColumnID
        ]

instance FromJSON TableColumnID where
    parseJSON (Object v) = TableColumnID
        <$> v .: "2819740"

instance ToJSON ChildOperator where
    toJSON EQUALSChildOperator = "EQUALS"
    toJSON ISNOTBLANKChildOperator = "IS_NOT_BLANK"

instance FromJSON ChildOperator where
    parseJSON = withText "ChildOperator" parseText
        where
            parseText "EQUALS" = return EQUALSChildOperator
            parseText "IS_NOT_BLANK" = return ISNOTBLANKChildOperator

instance ToJSON WhereOperator where
    toJSON EQUALSWhereOperator = "EQUALS"
    toJSON ANDWhereOperator = "AND"

instance FromJSON WhereOperator where
    parseJSON = withText "WhereOperator" parseText
        where
            parseText "EQUALS" = return EQUALSWhereOperator
            parseText "AND" = return ANDWhereOperator

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

instance ToJSON OrderColumnFieldName where
    toJSON DateReceivedOrderColumnFieldName = "date_received"
    toJSON AgreementDateOrderColumnFieldName = "agreement_date"
    toJSON InEffectAsOf1_1_2012_OrderColumnFieldName = "in_effect_as_of_1_1_2012"

instance FromJSON OrderColumnFieldName where
    parseJSON = withText "OrderColumnFieldName" parseText
        where
            parseText "date_received" = return DateReceivedOrderColumnFieldName
            parseText "agreement_date" = return AgreementDateOrderColumnFieldName
            parseText "in_effect_as_of_1_1_2012" = return InEffectAsOf1_1_2012_OrderColumnFieldName

instance ToJSON Select where
    toJSON (Select aggregateSelect columnFieldNameSelect) =
        object $ foldMap (maybe [] pure)
        [ ("aggregate" .=) <$> aggregateSelect
        , Just $ "columnFieldName" .= columnFieldNameSelect
        ]

instance FromJSON Select where
    parseJSON (Object v) = Select
        <$> v .:! "aggregate"
        <*> v .: "columnFieldName"

instance ToJSON MetadataRenderTypeConfig where
    toJSON (MetadataRenderTypeConfig visibleMetadataRenderTypeConfig) =
        object $ foldMap (maybe [] pure)
        [ Just $ "visible" .= visibleMetadataRenderTypeConfig
        ]

instance FromJSON MetadataRenderTypeConfig where
    parseJSON (Object v) = MetadataRenderTypeConfig
        <$> v .: "visible"

instance ToJSON PurpleVisible where
    toJSON (PurpleVisible fatrowPurpleVisible tablePurpleVisible) =
        object $ foldMap (maybe [] pure)
        [ ("fatrow" .=) <$> fatrowPurpleVisible
        , ("table" .=) <$> tablePurpleVisible
        ]

instance FromJSON PurpleVisible where
    parseJSON (Object v) = PurpleVisible
        <$> v .:! "fatrow"
        <*> v .:! "table"

instance ToJSON RichRendererConfigs where
    toJSON (RichRendererConfigs fatRowRichRendererConfigs) =
        object $ foldMap (maybe [] pure)
        [ Just $ "fatRow" .= fatRowRichRendererConfigs
        ]

instance FromJSON RichRendererConfigs where
    parseJSON (Object v) = RichRendererConfigs
        <$> v .: "fatRow"

instance ToJSON FatRow where
    toJSON (FatRow columnsFatRow) =
        object $ foldMap (maybe [] pure)
        [ Just $ "columns" .= columnsFatRow
        ]

instance FromJSON FatRow where
    parseJSON (Object v) = FatRow
        <$> v .: "columns"

instance ToJSON Column where
    toJSON (Column rowsColumn stylesColumn) =
        object $ foldMap (maybe [] pure)
        [ Just $ "rows" .= rowsColumn
        , Just $ "styles" .= stylesColumn
        ]

instance FromJSON Column where
    parseJSON (Object v) = Column
        <$> v .: "rows"
        <*> v .: "styles"

instance ToJSON Row where
    toJSON (Row fieldsRow) =
        object $ foldMap (maybe [] pure)
        [ Just $ "fields" .= fieldsRow
        ]

instance FromJSON Row where
    parseJSON (Object v) = Row
        <$> v .: "fields"

instance ToJSON Field where
    toJSON (Field fieldTypeField tableColumnIDField) =
        object $ foldMap (maybe [] pure)
        [ Just $ "type" .= fieldTypeField
        , Just $ "tableColumnId" .= tableColumnIDField
        ]

instance FromJSON Field where
    parseJSON (Object v) = Field
        <$> v .: "type"
        <*> v .: "tableColumnId"

instance ToJSON FieldType where
    toJSON ColumnLabelFieldType = "columnLabel"
    toJSON ColumnDataFieldType = "columnData"

instance FromJSON FieldType where
    parseJSON = withText "FieldType" parseText
        where
            parseText "columnLabel" = return ColumnLabelFieldType
            parseText "columnData" = return ColumnDataFieldType

instance ToJSON Styles where
    toJSON (Styles widthStyles) =
        object $ foldMap (maybe [] pure)
        [ Just $ "width" .= widthStyles
        ]

instance FromJSON Styles where
    parseJSON (Object v) = Styles
        <$> v .: "width"

instance ToJSON Width where
    toJSON The27_Width = "27%"
    toJSON The40_Width = "40%"
    toJSON The30_Width = "30%"
    toJSON The33_Width = "33%"

instance FromJSON Width where
    parseJSON = withText "Width" parseText
        where
            parseText "27%" = return The27_Width
            parseText "40%" = return The40_Width
            parseText "30%" = return The30_Width
            parseText "33%" = return The33_Width

instance ToJSON V1ArchivedProperties where
    toJSON (V1ArchivedProperties accessPointsV1ArchivedProperties blistIDV1ArchivedProperties renderTypeConfigV1ArchivedProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "accessPoints" .= accessPointsV1ArchivedProperties
        , Just $ "blist_id" .= blistIDV1ArchivedProperties
        , Just $ "renderTypeConfig" .= renderTypeConfigV1ArchivedProperties
        ]

instance FromJSON V1ArchivedProperties where
    parseJSON (Object v) = V1ArchivedProperties
        <$> v .: "accessPoints"
        <*> v .: "blist_id"
        <*> v .: "renderTypeConfig"

instance ToJSON AccessPoints where
    toJSON (AccessPoints newViewAccessPoints) =
        object $ foldMap (maybe [] pure)
        [ Just $ "new_view" .= newViewAccessPoints
        ]

instance FromJSON AccessPoints where
    parseJSON (Object v) = AccessPoints
        <$> v .: "new_view"

instance ToJSON V1ArchivedPropertiesRenderTypeConfig where
    toJSON (V1ArchivedPropertiesRenderTypeConfig visibleV1ArchivedPropertiesRenderTypeConfig) =
        object $ foldMap (maybe [] pure)
        [ Just $ "visible" .= visibleV1ArchivedPropertiesRenderTypeConfig
        ]

instance FromJSON V1ArchivedPropertiesRenderTypeConfig where
    parseJSON (Object v) = V1ArchivedPropertiesRenderTypeConfig
        <$> v .: "visible"

instance ToJSON FluffyVisible where
    toJSON (FluffyVisible hrefFluffyVisible) =
        object $ foldMap (maybe [] pure)
        [ Just $ "href" .= hrefFluffyVisible
        ]

instance FromJSON FluffyVisible where
    parseJSON (Object v) = FluffyVisible
        <$> v .: "href"

instance ToJSON ModifyingViewUid where
    toJSON S6EwH6MpModifyingViewUid = "s6ew-h6mp"

instance FromJSON ModifyingViewUid where
    parseJSON = withText "ModifyingViewUid" parseText
        where
            parseText "s6ew-h6mp" = return S6EwH6MpModifyingViewUid

instance ToJSON Owner where
    toJSON (Owner displayNameOwner flagsOwner lastNotificationSeenAtOwner ownerIDOwner profileImageURLLargeOwner profileImageURLMediumOwner profileImageURLSmallOwner rightsOwner roleNameOwner screenNameOwner) =
        object $ foldMap (maybe [] pure)
        [ Just $ "displayName" .= displayNameOwner
        , ("flags" .=) <$> flagsOwner
        , ("lastNotificationSeenAt" .=) <$> lastNotificationSeenAtOwner
        , Just $ "id" .= ownerIDOwner
        , ("profileImageUrlLarge" .=) <$> profileImageURLLargeOwner
        , ("profileImageUrlMedium" .=) <$> profileImageURLMediumOwner
        , ("profileImageUrlSmall" .=) <$> profileImageURLSmallOwner
        , ("rights" .=) <$> rightsOwner
        , ("roleName" .=) <$> roleNameOwner
        , Just $ "screenName" .= screenNameOwner
        ]

instance FromJSON Owner where
    parseJSON (Object v) = Owner
        <$> v .: "displayName"
        <*> v .:! "flags"
        <*> v .:! "lastNotificationSeenAt"
        <*> v .: "id"
        <*> v .:! "profileImageUrlLarge"
        <*> v .:! "profileImageUrlMedium"
        <*> v .:! "profileImageUrlSmall"
        <*> v .:! "rights"
        <*> v .:! "roleName"
        <*> v .: "screenName"

instance ToJSON RoleName where
    toJSON AdministratorRoleName = "administrator"
    toJSON PublisherRoleName = "publisher"

instance FromJSON RoleName where
    parseJSON = withText "RoleName" parseText
        where
            parseText "administrator" = return AdministratorRoleName
            parseText "publisher" = return PublisherRoleName

instance ToJSON Provenance where
    toJSON OfficialProvenance = "official"

instance FromJSON Provenance where
    parseJSON = withText "Provenance" parseText
        where
            parseText "official" = return OfficialProvenance

instance ToJSON PublicationStage where
    toJSON PublishedPublicationStage = "published"

instance FromJSON PublicationStage where
    parseJSON = withText "PublicationStage" parseText
        where
            parseText "published" = return PublishedPublicationStage

instance ToJSON Ratings where
    toJSON (Ratings ratingRatings) =
        object $ foldMap (maybe [] pure)
        [ Just $ "rating" .= ratingRatings
        ]

instance FromJSON Ratings where
    parseJSON (Object v) = Ratings
        <$> v .: "rating"

instance ToJSON RightElement where
    toJSON ReadRightElement = "read"

instance FromJSON RightElement where
    parseJSON = withText "RightElement" parseText
        where
            parseText "read" = return ReadRightElement

instance ToJSON RowsUpdatedBy where
    toJSON PjxgVe4MRowsUpdatedBy = "pjxg-ve4m"
    toJSON The54A3QyunRowsUpdatedBy = "54a3-qyun"
    toJSON The9E3M2843_RowsUpdatedBy = "9e3m-2843"
    toJSON VvcaFr6GRowsUpdatedBy = "vvca-fr6g"

instance FromJSON RowsUpdatedBy where
    parseJSON = withText "RowsUpdatedBy" parseText
        where
            parseText "pjxg-ve4m" = return PjxgVe4MRowsUpdatedBy
            parseText "54a3-qyun" = return The54A3QyunRowsUpdatedBy
            parseText "9e3m-2843" = return The9E3M2843_RowsUpdatedBy
            parseText "vvca-fr6g" = return VvcaFr6GRowsUpdatedBy

instance ToJSON TableAuthor where
    toJSON (TableAuthor displayNameTableAuthor rightsTableAuthor roleNameTableAuthor screenNameTableAuthor tableAuthorIDTableAuthor) =
        object $ foldMap (maybe [] pure)
        [ Just $ "displayName" .= displayNameTableAuthor
        , ("rights" .=) <$> rightsTableAuthor
        , ("roleName" .=) <$> roleNameTableAuthor
        , Just $ "screenName" .= screenNameTableAuthor
        , Just $ "id" .= tableAuthorIDTableAuthor
        ]

instance FromJSON TableAuthor where
    parseJSON (Object v) = TableAuthor
        <$> v .: "displayName"
        <*> v .:! "rights"
        <*> v .:! "roleName"
        <*> v .: "screenName"
        <*> v .: "id"

instance ToJSON ViewType where
    toJSON TabularViewType = "tabular"

instance FromJSON ViewType where
    parseJSON = withText "ViewType" parseText
        where
            parseText "tabular" = return TabularViewType
