-- To decode the JSON data, add this file to your project, run
--
--     elm install NoRedInk/elm-json-decode-pipeline
--
-- add these imports
--
--     import Json.Decode exposing (decodeString)
--     import QuickType exposing (quickType)
--
-- and you're off to the races with
--
--     decodeString quickType myJsonString

module QuickType exposing
    ( QuickType
    , quickTypeToString
    , quickType
    , QuickTypeElement
    , Grant
    , QuickTypeMetadata
    , CustomFields
    , Test
    , JSONQuery
    , Group
    , Where
    , Child
    , ChildMetadata
    , TableColumnID
    , Order
    , Select
    , MetadataRenderTypeConfig
    , PurpleVisible
    , RichRendererConfigs
    , FatRow
    , Column
    , Row
    , Field
    , Styles
    , V1ArchivedProperties
    , AccessPoints
    , V1ArchivedPropertiesRenderTypeConfig
    , FluffyVisible
    , Owner
    , Ratings
    , TableAuthor
    , DisplayType(..)
    , QuickTypeFlag(..)
    , GrantFlag(..)
    , GrantType(..)
    , ChildColumnFieldName(..)
    , MetadataOperator(..)
    , ChildOperator(..)
    , WhereOperator(..)
    , OrderColumnFieldName(..)
    , FieldType(..)
    , Width(..)
    , ModifyingViewUid(..)
    , RoleName(..)
    , Provenance(..)
    , PublicationStage(..)
    , Right(..)
    , RowsUpdatedBy(..)
    , ViewType(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType = List QuickTypeElement

type alias QuickTypeElement =
    { averageRating : Int
    , category : Maybe String
    , createdAt : Int
    , description : Maybe String
    , displayType : Maybe DisplayType
    , downloadCount : Int
    , flags : Maybe (List QuickTypeFlag)
    , grants : List Grant
    , hideFromCatalog : Bool
    , hideFromDataJSON : Bool
    , id : String
    , indexUpdatedAt : Maybe Int
    , locale : String
    , metadata : QuickTypeMetadata
    , moderationStatus : Maybe Bool
    , modifyingViewUid : Maybe ModifyingViewUid
    , name : String
    , newBackend : Bool
    , numberOfComments : Int
    , oid : Int
    , owner : Owner
    , provenance : Provenance
    , publicationAppendEnabled : Bool
    , publicationDate : Maybe Int
    , publicationGroup : Int
    , publicationStage : PublicationStage
    , ratings : Maybe Ratings
    , resourceName : Maybe String
    , rights : List Right
    , rowClass : Maybe String
    , rowIdentifierColumnID : Maybe Int
    , rowsUpdatedAt : Maybe Int
    , rowsUpdatedBy : Maybe RowsUpdatedBy
    , tableAuthor : TableAuthor
    , tableID : Int
    , tags : Maybe (List String)
    , totalTimesRated : Int
    , viewCount : Int
    , viewLastModified : Int
    , viewType : ViewType
    }

type DisplayType
    = Table
    | DataLens
    | Fatrow
    | Page

type QuickTypeFlag
    = Default
    | Restorable
    | RestorePossibleForType

type alias Grant =
    { flags : List GrantFlag
    , grantType : GrantType
    , inherited : Bool
    }

type GrantFlag
    = Public

type GrantType
    = Viewer

type alias QuickTypeMetadata =
    { availableDisplayTypes : Maybe (List DisplayType)
    , customFields : Maybe CustomFields
    , jsonQuery : Maybe JSONQuery
    , rdfClass : Maybe String
    , rdfSubject : Maybe String
    , renderTypeConfig : Maybe MetadataRenderTypeConfig
    , richRendererConfigs : Maybe RichRendererConfigs
    , rowIdentifier : Maybe String
    , rowLabel : Maybe String
    , v1ArchivedProperties : Maybe V1ArchivedProperties
    }

type alias CustomFields =
    { test : Test
    }

type alias Test =
    { cfpb1 : String
    }

type alias JSONQuery =
    { group : Maybe (List Group)
    , jsonQueryWhere : Maybe Where
    , order : Maybe (List Order)
    , select : Maybe (List Select)
    }

type alias Group =
    { columnFieldName : String
    }

type alias Where =
    { children : Maybe (List Child)
    , columnFieldName : Maybe ChildColumnFieldName
    , metadata : Maybe ChildMetadata
    , operator : WhereOperator
    , value : Maybe String
    }

type alias Child =
    { columnFieldName : ChildColumnFieldName
    , metadata : Maybe ChildMetadata
    , operator : ChildOperator
    , value : Maybe String
    }

type ChildColumnFieldName
    = Product
    | ComplaintWhatHappened
    | SubProduct
    | Issue

type alias ChildMetadata =
    { customValues : Maybe (List String)
    , freeform : Maybe Bool
    , includeAuto : Maybe Int
    , operator : Maybe MetadataOperator
    , tableColumnID : Maybe TableColumnID
    , unifiedVersion : Maybe Int
    }

type MetadataOperator
    = PurpleEQUALS
    | Blank

type alias TableColumnID =
    { the2819740 : Int
    }

type ChildOperator
    = FluffyEQUALS
    | IsNotBlank

type WhereOperator
    = TentacledEQUALS
    | And

type alias Order =
    { ascending : Bool
    , columnFieldName : OrderColumnFieldName
    }

type OrderColumnFieldName
    = DateReceived
    | AgreementDate
    | InEffectAsOf1_1_2012

type alias Select =
    { aggregate : Maybe String
    , columnFieldName : String
    }

type alias MetadataRenderTypeConfig =
    { visible : PurpleVisible
    }

type alias PurpleVisible =
    { fatrow : Maybe Bool
    , table : Maybe Bool
    }

type alias RichRendererConfigs =
    { fatRow : FatRow
    }

type alias FatRow =
    { columns : List Column
    }

type alias Column =
    { rows : List Row
    , styles : Styles
    }

type alias Row =
    { fields : List Field
    }

type alias Field =
    { fieldType : FieldType
    , tableColumnID : Int
    }

type FieldType
    = ColumnLabel
    | ColumnData

type alias Styles =
    { width : Width
    }

type Width
    = The27
    | The40
    | The30
    | The33

type alias V1ArchivedProperties =
    { accessPoints : AccessPoints
    , blistID : String
    , renderTypeConfig : V1ArchivedPropertiesRenderTypeConfig
    }

type alias AccessPoints =
    { newView : String
    }

type alias V1ArchivedPropertiesRenderTypeConfig =
    { visible : FluffyVisible
    }

type alias FluffyVisible =
    { href : Bool
    }

type ModifyingViewUid
    = S6EwH6Mp

type alias Owner =
    { displayName : String
    , flags : Maybe (List String)
    , id : String
    , lastNotificationSeenAt : Maybe Int
    , profileImageURLLarge : Maybe String
    , profileImageURLMedium : Maybe String
    , profileImageURLSmall : Maybe String
    , rights : Maybe (List String)
    , roleName : Maybe RoleName
    , screenName : String
    }

type RoleName
    = Administrator
    | Publisher

type Provenance
    = Official

type PublicationStage
    = Published

type alias Ratings =
    { rating : Int
    }

type Right
    = Read

type RowsUpdatedBy
    = PjxgVe4M
    | The54A3Qyun
    | The9E3M2843
    | VvcaFr6G

type alias TableAuthor =
    { displayName : String
    , id : String
    , rights : Maybe (List String)
    , roleName : Maybe RoleName
    , screenName : String
    }

type ViewType
    = Tabular

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickType : Jdec.Decoder QuickType
quickType = Jdec.list quickTypeElement 

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (Jenc.list encodeQuickTypeElement r)

quickTypeElement : Jdec.Decoder QuickTypeElement
quickTypeElement =
    Jdec.succeed QuickTypeElement
        |> Jpipe.required "averageRating" Jdec.int
        |> Jpipe.custom (optionalField "category" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "createdAt" Jdec.int
        |> Jpipe.custom (optionalField "description" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "displayType" (Jdec.map Just displayType) Nothing)
        |> Jpipe.required "downloadCount" Jdec.int
        |> Jpipe.custom (optionalField "flags" (Jdec.map Just (Jdec.list quickTypeFlag )) Nothing)
        |> Jpipe.required "grants" (Jdec.list grant )
        |> Jpipe.required "hideFromCatalog" Jdec.bool
        |> Jpipe.required "hideFromDataJson" Jdec.bool
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.custom (optionalField "indexUpdatedAt" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.required "locale" Jdec.string
        |> Jpipe.required "metadata" quickTypeMetadata
        |> Jpipe.custom (optionalField "moderationStatus" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "modifyingViewUid" (Jdec.map Just modifyingViewUid) Nothing)
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "newBackend" Jdec.bool
        |> Jpipe.required "numberOfComments" Jdec.int
        |> Jpipe.required "oid" Jdec.int
        |> Jpipe.required "owner" owner
        |> Jpipe.required "provenance" provenance
        |> Jpipe.required "publicationAppendEnabled" Jdec.bool
        |> Jpipe.custom (optionalField "publicationDate" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.required "publicationGroup" Jdec.int
        |> Jpipe.required "publicationStage" publicationStage
        |> Jpipe.custom (optionalField "ratings" (Jdec.map Just ratings) Nothing)
        |> Jpipe.custom (optionalField "resourceName" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "rights" (Jdec.list right )
        |> Jpipe.custom (optionalField "rowClass" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "rowIdentifierColumnId" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "rowsUpdatedAt" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "rowsUpdatedBy" (Jdec.map Just rowsUpdatedBy) Nothing)
        |> Jpipe.required "tableAuthor" tableAuthor
        |> Jpipe.required "tableId" Jdec.int
        |> Jpipe.custom (optionalField "tags" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.required "totalTimesRated" Jdec.int
        |> Jpipe.required "viewCount" Jdec.int
        |> Jpipe.required "viewLastModified" Jdec.int
        |> Jpipe.required "viewType" viewType

encodeQuickTypeElement : QuickTypeElement -> Jenc.Value
encodeQuickTypeElement x =
    Jenc.object
        [ ("averageRating", Jenc.int x.averageRating)
        , ("category", makeNullableEncoder Jenc.string x.category)
        , ("createdAt", Jenc.int x.createdAt)
        , ("description", makeNullableEncoder Jenc.string x.description)
        , ("displayType", makeNullableEncoder encodeDisplayType x.displayType)
        , ("downloadCount", Jenc.int x.downloadCount)
        , ("flags", makeNullableEncoder (Jenc.list encodeQuickTypeFlag) x.flags)
        , ("grants", Jenc.list encodeGrant x.grants)
        , ("hideFromCatalog", Jenc.bool x.hideFromCatalog)
        , ("hideFromDataJson", Jenc.bool x.hideFromDataJSON)
        , ("id", Jenc.string x.id)
        , ("indexUpdatedAt", makeNullableEncoder Jenc.int x.indexUpdatedAt)
        , ("locale", Jenc.string x.locale)
        , ("metadata", encodeQuickTypeMetadata x.metadata)
        , ("moderationStatus", makeNullableEncoder Jenc.bool x.moderationStatus)
        , ("modifyingViewUid", makeNullableEncoder encodeModifyingViewUid x.modifyingViewUid)
        , ("name", Jenc.string x.name)
        , ("newBackend", Jenc.bool x.newBackend)
        , ("numberOfComments", Jenc.int x.numberOfComments)
        , ("oid", Jenc.int x.oid)
        , ("owner", encodeOwner x.owner)
        , ("provenance", encodeProvenance x.provenance)
        , ("publicationAppendEnabled", Jenc.bool x.publicationAppendEnabled)
        , ("publicationDate", makeNullableEncoder Jenc.int x.publicationDate)
        , ("publicationGroup", Jenc.int x.publicationGroup)
        , ("publicationStage", encodePublicationStage x.publicationStage)
        , ("ratings", makeNullableEncoder encodeRatings x.ratings)
        , ("resourceName", makeNullableEncoder Jenc.string x.resourceName)
        , ("rights", Jenc.list encodeRight x.rights)
        , ("rowClass", makeNullableEncoder Jenc.string x.rowClass)
        , ("rowIdentifierColumnId", makeNullableEncoder Jenc.int x.rowIdentifierColumnID)
        , ("rowsUpdatedAt", makeNullableEncoder Jenc.int x.rowsUpdatedAt)
        , ("rowsUpdatedBy", makeNullableEncoder encodeRowsUpdatedBy x.rowsUpdatedBy)
        , ("tableAuthor", encodeTableAuthor x.tableAuthor)
        , ("tableId", Jenc.int x.tableID)
        , ("tags", makeNullableEncoder (Jenc.list Jenc.string) x.tags)
        , ("totalTimesRated", Jenc.int x.totalTimesRated)
        , ("viewCount", Jenc.int x.viewCount)
        , ("viewLastModified", Jenc.int x.viewLastModified)
        , ("viewType", encodeViewType x.viewType)
        ]

displayType : Jdec.Decoder DisplayType
displayType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "table" -> Jdec.succeed Table
                "data_lens" -> Jdec.succeed DataLens
                "fatrow" -> Jdec.succeed Fatrow
                "page" -> Jdec.succeed Page
                somethingElse -> Jdec.fail <| "Invalid DisplayType: " ++ somethingElse
        )

encodeDisplayType : DisplayType -> Jenc.Value
encodeDisplayType x = case x of
    Table -> Jenc.string "table"
    DataLens -> Jenc.string "data_lens"
    Fatrow -> Jenc.string "fatrow"
    Page -> Jenc.string "page"

quickTypeFlag : Jdec.Decoder QuickTypeFlag
quickTypeFlag =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "default" -> Jdec.succeed Default
                "restorable" -> Jdec.succeed Restorable
                "restorePossibleForType" -> Jdec.succeed RestorePossibleForType
                somethingElse -> Jdec.fail <| "Invalid QuickTypeFlag: " ++ somethingElse
        )

encodeQuickTypeFlag : QuickTypeFlag -> Jenc.Value
encodeQuickTypeFlag x = case x of
    Default -> Jenc.string "default"
    Restorable -> Jenc.string "restorable"
    RestorePossibleForType -> Jenc.string "restorePossibleForType"

grant : Jdec.Decoder Grant
grant =
    Jdec.succeed Grant
        |> Jpipe.required "flags" (Jdec.list grantFlag )
        |> Jpipe.required "type" grantType
        |> Jpipe.required "inherited" Jdec.bool

encodeGrant : Grant -> Jenc.Value
encodeGrant x =
    Jenc.object
        [ ("flags", Jenc.list encodeGrantFlag x.flags)
        , ("type", encodeGrantType x.grantType)
        , ("inherited", Jenc.bool x.inherited)
        ]

grantFlag : Jdec.Decoder GrantFlag
grantFlag =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "public" -> Jdec.succeed Public
                somethingElse -> Jdec.fail <| "Invalid GrantFlag: " ++ somethingElse
        )

encodeGrantFlag : GrantFlag -> Jenc.Value
encodeGrantFlag x = case x of
    Public -> Jenc.string "public"

grantType : Jdec.Decoder GrantType
grantType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "viewer" -> Jdec.succeed Viewer
                somethingElse -> Jdec.fail <| "Invalid GrantType: " ++ somethingElse
        )

encodeGrantType : GrantType -> Jenc.Value
encodeGrantType x = case x of
    Viewer -> Jenc.string "viewer"

quickTypeMetadata : Jdec.Decoder QuickTypeMetadata
quickTypeMetadata =
    Jdec.succeed QuickTypeMetadata
        |> Jpipe.custom (optionalField "availableDisplayTypes" (Jdec.map Just (Jdec.list displayType )) Nothing)
        |> Jpipe.custom (optionalField "custom_fields" (Jdec.map Just customFields) Nothing)
        |> Jpipe.custom (optionalField "jsonQuery" (Jdec.map Just jsonQuery) Nothing)
        |> Jpipe.custom (optionalField "rdfClass" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "rdfSubject" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "renderTypeConfig" (Jdec.map Just metadataRenderTypeConfig) Nothing)
        |> Jpipe.custom (optionalField "richRendererConfigs" (Jdec.map Just richRendererConfigs) Nothing)
        |> Jpipe.custom (optionalField "rowIdentifier" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "rowLabel" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "v1_archived_properties" (Jdec.map Just v1ArchivedProperties) Nothing)

encodeQuickTypeMetadata : QuickTypeMetadata -> Jenc.Value
encodeQuickTypeMetadata x =
    Jenc.object
        [ ("availableDisplayTypes", makeNullableEncoder (Jenc.list encodeDisplayType) x.availableDisplayTypes)
        , ("custom_fields", makeNullableEncoder encodeCustomFields x.customFields)
        , ("jsonQuery", makeNullableEncoder encodeJSONQuery x.jsonQuery)
        , ("rdfClass", makeNullableEncoder Jenc.string x.rdfClass)
        , ("rdfSubject", makeNullableEncoder Jenc.string x.rdfSubject)
        , ("renderTypeConfig", makeNullableEncoder encodeMetadataRenderTypeConfig x.renderTypeConfig)
        , ("richRendererConfigs", makeNullableEncoder encodeRichRendererConfigs x.richRendererConfigs)
        , ("rowIdentifier", makeNullableEncoder Jenc.string x.rowIdentifier)
        , ("rowLabel", makeNullableEncoder Jenc.string x.rowLabel)
        , ("v1_archived_properties", makeNullableEncoder encodeV1ArchivedProperties x.v1ArchivedProperties)
        ]

customFields : Jdec.Decoder CustomFields
customFields =
    Jdec.succeed CustomFields
        |> Jpipe.required "TEST" test

encodeCustomFields : CustomFields -> Jenc.Value
encodeCustomFields x =
    Jenc.object
        [ ("TEST", encodeTest x.test)
        ]

test : Jdec.Decoder Test
test =
    Jdec.succeed Test
        |> Jpipe.required "CFPB1" Jdec.string

encodeTest : Test -> Jenc.Value
encodeTest x =
    Jenc.object
        [ ("CFPB1", Jenc.string x.cfpb1)
        ]

jsonQuery : Jdec.Decoder JSONQuery
jsonQuery =
    Jdec.succeed JSONQuery
        |> Jpipe.custom (optionalField "group" (Jdec.map Just (Jdec.list group )) Nothing)
        |> Jpipe.custom (optionalField "where" (Jdec.map Just purpleWhere) Nothing)
        |> Jpipe.custom (optionalField "order" (Jdec.map Just (Jdec.list order )) Nothing)
        |> Jpipe.custom (optionalField "select" (Jdec.map Just (Jdec.list select )) Nothing)

encodeJSONQuery : JSONQuery -> Jenc.Value
encodeJSONQuery x =
    Jenc.object
        [ ("group", makeNullableEncoder (Jenc.list encodeGroup) x.group)
        , ("where", makeNullableEncoder encodeWhere x.jsonQueryWhere)
        , ("order", makeNullableEncoder (Jenc.list encodeOrder) x.order)
        , ("select", makeNullableEncoder (Jenc.list encodeSelect) x.select)
        ]

group : Jdec.Decoder Group
group =
    Jdec.succeed Group
        |> Jpipe.required "columnFieldName" Jdec.string

encodeGroup : Group -> Jenc.Value
encodeGroup x =
    Jenc.object
        [ ("columnFieldName", Jenc.string x.columnFieldName)
        ]

purpleWhere : Jdec.Decoder Where
purpleWhere =
    Jdec.succeed Where
        |> Jpipe.custom (optionalField "children" (Jdec.map Just (Jdec.list child )) Nothing)
        |> Jpipe.custom (optionalField "columnFieldName" (Jdec.map Just childColumnFieldName) Nothing)
        |> Jpipe.custom (optionalField "metadata" (Jdec.map Just childMetadata) Nothing)
        |> Jpipe.required "operator" whereOperator
        |> Jpipe.custom (optionalField "value" (Jdec.map Just Jdec.string) Nothing)

encodeWhere : Where -> Jenc.Value
encodeWhere x =
    Jenc.object
        [ ("children", makeNullableEncoder (Jenc.list encodeChild) x.children)
        , ("columnFieldName", makeNullableEncoder encodeChildColumnFieldName x.columnFieldName)
        , ("metadata", makeNullableEncoder encodeChildMetadata x.metadata)
        , ("operator", encodeWhereOperator x.operator)
        , ("value", makeNullableEncoder Jenc.string x.value)
        ]

child : Jdec.Decoder Child
child =
    Jdec.succeed Child
        |> Jpipe.required "columnFieldName" childColumnFieldName
        |> Jpipe.custom (optionalField "metadata" (Jdec.map Just childMetadata) Nothing)
        |> Jpipe.required "operator" childOperator
        |> Jpipe.custom (optionalField "value" (Jdec.map Just Jdec.string) Nothing)

encodeChild : Child -> Jenc.Value
encodeChild x =
    Jenc.object
        [ ("columnFieldName", encodeChildColumnFieldName x.columnFieldName)
        , ("metadata", makeNullableEncoder encodeChildMetadata x.metadata)
        , ("operator", encodeChildOperator x.operator)
        , ("value", makeNullableEncoder Jenc.string x.value)
        ]

childColumnFieldName : Jdec.Decoder ChildColumnFieldName
childColumnFieldName =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "product" -> Jdec.succeed Product
                "complaint_what_happened" -> Jdec.succeed ComplaintWhatHappened
                "sub_product" -> Jdec.succeed SubProduct
                "issue" -> Jdec.succeed Issue
                somethingElse -> Jdec.fail <| "Invalid ChildColumnFieldName: " ++ somethingElse
        )

encodeChildColumnFieldName : ChildColumnFieldName -> Jenc.Value
encodeChildColumnFieldName x = case x of
    Product -> Jenc.string "product"
    ComplaintWhatHappened -> Jenc.string "complaint_what_happened"
    SubProduct -> Jenc.string "sub_product"
    Issue -> Jenc.string "issue"

childMetadata : Jdec.Decoder ChildMetadata
childMetadata =
    Jdec.succeed ChildMetadata
        |> Jpipe.custom (optionalField "customValues" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.custom (optionalField "freeform" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "includeAuto" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "operator" (Jdec.map Just metadataOperator) Nothing)
        |> Jpipe.custom (optionalField "tableColumnId" (Jdec.map Just tableColumnID) Nothing)
        |> Jpipe.custom (optionalField "unifiedVersion" (Jdec.map Just Jdec.int) Nothing)

encodeChildMetadata : ChildMetadata -> Jenc.Value
encodeChildMetadata x =
    Jenc.object
        [ ("customValues", makeNullableEncoder (Jenc.list Jenc.string) x.customValues)
        , ("freeform", makeNullableEncoder Jenc.bool x.freeform)
        , ("includeAuto", makeNullableEncoder Jenc.int x.includeAuto)
        , ("operator", makeNullableEncoder encodeMetadataOperator x.operator)
        , ("tableColumnId", makeNullableEncoder encodeTableColumnID x.tableColumnID)
        , ("unifiedVersion", makeNullableEncoder Jenc.int x.unifiedVersion)
        ]

metadataOperator : Jdec.Decoder MetadataOperator
metadataOperator =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "EQUALS" -> Jdec.succeed PurpleEQUALS
                "blank?" -> Jdec.succeed Blank
                somethingElse -> Jdec.fail <| "Invalid MetadataOperator: " ++ somethingElse
        )

encodeMetadataOperator : MetadataOperator -> Jenc.Value
encodeMetadataOperator x = case x of
    PurpleEQUALS -> Jenc.string "EQUALS"
    Blank -> Jenc.string "blank?"

tableColumnID : Jdec.Decoder TableColumnID
tableColumnID =
    Jdec.succeed TableColumnID
        |> Jpipe.required "2819740" Jdec.int

encodeTableColumnID : TableColumnID -> Jenc.Value
encodeTableColumnID x =
    Jenc.object
        [ ("2819740", Jenc.int x.the2819740)
        ]

childOperator : Jdec.Decoder ChildOperator
childOperator =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "EQUALS" -> Jdec.succeed FluffyEQUALS
                "IS_NOT_BLANK" -> Jdec.succeed IsNotBlank
                somethingElse -> Jdec.fail <| "Invalid ChildOperator: " ++ somethingElse
        )

encodeChildOperator : ChildOperator -> Jenc.Value
encodeChildOperator x = case x of
    FluffyEQUALS -> Jenc.string "EQUALS"
    IsNotBlank -> Jenc.string "IS_NOT_BLANK"

whereOperator : Jdec.Decoder WhereOperator
whereOperator =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "EQUALS" -> Jdec.succeed TentacledEQUALS
                "AND" -> Jdec.succeed And
                somethingElse -> Jdec.fail <| "Invalid WhereOperator: " ++ somethingElse
        )

encodeWhereOperator : WhereOperator -> Jenc.Value
encodeWhereOperator x = case x of
    TentacledEQUALS -> Jenc.string "EQUALS"
    And -> Jenc.string "AND"

order : Jdec.Decoder Order
order =
    Jdec.succeed Order
        |> Jpipe.required "ascending" Jdec.bool
        |> Jpipe.required "columnFieldName" orderColumnFieldName

encodeOrder : Order -> Jenc.Value
encodeOrder x =
    Jenc.object
        [ ("ascending", Jenc.bool x.ascending)
        , ("columnFieldName", encodeOrderColumnFieldName x.columnFieldName)
        ]

orderColumnFieldName : Jdec.Decoder OrderColumnFieldName
orderColumnFieldName =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "date_received" -> Jdec.succeed DateReceived
                "agreement_date" -> Jdec.succeed AgreementDate
                "in_effect_as_of_1_1_2012" -> Jdec.succeed InEffectAsOf1_1_2012
                somethingElse -> Jdec.fail <| "Invalid OrderColumnFieldName: " ++ somethingElse
        )

encodeOrderColumnFieldName : OrderColumnFieldName -> Jenc.Value
encodeOrderColumnFieldName x = case x of
    DateReceived -> Jenc.string "date_received"
    AgreementDate -> Jenc.string "agreement_date"
    InEffectAsOf1_1_2012 -> Jenc.string "in_effect_as_of_1_1_2012"

select : Jdec.Decoder Select
select =
    Jdec.succeed Select
        |> Jpipe.custom (optionalField "aggregate" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "columnFieldName" Jdec.string

encodeSelect : Select -> Jenc.Value
encodeSelect x =
    Jenc.object
        [ ("aggregate", makeNullableEncoder Jenc.string x.aggregate)
        , ("columnFieldName", Jenc.string x.columnFieldName)
        ]

metadataRenderTypeConfig : Jdec.Decoder MetadataRenderTypeConfig
metadataRenderTypeConfig =
    Jdec.succeed MetadataRenderTypeConfig
        |> Jpipe.required "visible" purpleVisible

encodeMetadataRenderTypeConfig : MetadataRenderTypeConfig -> Jenc.Value
encodeMetadataRenderTypeConfig x =
    Jenc.object
        [ ("visible", encodePurpleVisible x.visible)
        ]

purpleVisible : Jdec.Decoder PurpleVisible
purpleVisible =
    Jdec.succeed PurpleVisible
        |> Jpipe.custom (optionalField "fatrow" (Jdec.map Just Jdec.bool) Nothing)
        |> Jpipe.custom (optionalField "table" (Jdec.map Just Jdec.bool) Nothing)

encodePurpleVisible : PurpleVisible -> Jenc.Value
encodePurpleVisible x =
    Jenc.object
        [ ("fatrow", makeNullableEncoder Jenc.bool x.fatrow)
        , ("table", makeNullableEncoder Jenc.bool x.table)
        ]

richRendererConfigs : Jdec.Decoder RichRendererConfigs
richRendererConfigs =
    Jdec.succeed RichRendererConfigs
        |> Jpipe.required "fatRow" fatRow

encodeRichRendererConfigs : RichRendererConfigs -> Jenc.Value
encodeRichRendererConfigs x =
    Jenc.object
        [ ("fatRow", encodeFatRow x.fatRow)
        ]

fatRow : Jdec.Decoder FatRow
fatRow =
    Jdec.succeed FatRow
        |> Jpipe.required "columns" (Jdec.list column )

encodeFatRow : FatRow -> Jenc.Value
encodeFatRow x =
    Jenc.object
        [ ("columns", Jenc.list encodeColumn x.columns)
        ]

column : Jdec.Decoder Column
column =
    Jdec.succeed Column
        |> Jpipe.required "rows" (Jdec.list row )
        |> Jpipe.required "styles" styles

encodeColumn : Column -> Jenc.Value
encodeColumn x =
    Jenc.object
        [ ("rows", Jenc.list encodeRow x.rows)
        , ("styles", encodeStyles x.styles)
        ]

row : Jdec.Decoder Row
row =
    Jdec.succeed Row
        |> Jpipe.required "fields" (Jdec.list field )

encodeRow : Row -> Jenc.Value
encodeRow x =
    Jenc.object
        [ ("fields", Jenc.list encodeField x.fields)
        ]

field : Jdec.Decoder Field
field =
    Jdec.succeed Field
        |> Jpipe.required "type" fieldType
        |> Jpipe.required "tableColumnId" Jdec.int

encodeField : Field -> Jenc.Value
encodeField x =
    Jenc.object
        [ ("type", encodeFieldType x.fieldType)
        , ("tableColumnId", Jenc.int x.tableColumnID)
        ]

fieldType : Jdec.Decoder FieldType
fieldType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "columnLabel" -> Jdec.succeed ColumnLabel
                "columnData" -> Jdec.succeed ColumnData
                somethingElse -> Jdec.fail <| "Invalid FieldType: " ++ somethingElse
        )

encodeFieldType : FieldType -> Jenc.Value
encodeFieldType x = case x of
    ColumnLabel -> Jenc.string "columnLabel"
    ColumnData -> Jenc.string "columnData"

styles : Jdec.Decoder Styles
styles =
    Jdec.succeed Styles
        |> Jpipe.required "width" width

encodeStyles : Styles -> Jenc.Value
encodeStyles x =
    Jenc.object
        [ ("width", encodeWidth x.width)
        ]

width : Jdec.Decoder Width
width =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "27%" -> Jdec.succeed The27
                "40%" -> Jdec.succeed The40
                "30%" -> Jdec.succeed The30
                "33%" -> Jdec.succeed The33
                somethingElse -> Jdec.fail <| "Invalid Width: " ++ somethingElse
        )

encodeWidth : Width -> Jenc.Value
encodeWidth x = case x of
    The27 -> Jenc.string "27%"
    The40 -> Jenc.string "40%"
    The30 -> Jenc.string "30%"
    The33 -> Jenc.string "33%"

v1ArchivedProperties : Jdec.Decoder V1ArchivedProperties
v1ArchivedProperties =
    Jdec.succeed V1ArchivedProperties
        |> Jpipe.required "accessPoints" accessPoints
        |> Jpipe.required "blist_id" Jdec.string
        |> Jpipe.required "renderTypeConfig" v1ArchivedPropertiesRenderTypeConfig

encodeV1ArchivedProperties : V1ArchivedProperties -> Jenc.Value
encodeV1ArchivedProperties x =
    Jenc.object
        [ ("accessPoints", encodeAccessPoints x.accessPoints)
        , ("blist_id", Jenc.string x.blistID)
        , ("renderTypeConfig", encodeV1ArchivedPropertiesRenderTypeConfig x.renderTypeConfig)
        ]

accessPoints : Jdec.Decoder AccessPoints
accessPoints =
    Jdec.succeed AccessPoints
        |> Jpipe.required "new_view" Jdec.string

encodeAccessPoints : AccessPoints -> Jenc.Value
encodeAccessPoints x =
    Jenc.object
        [ ("new_view", Jenc.string x.newView)
        ]

v1ArchivedPropertiesRenderTypeConfig : Jdec.Decoder V1ArchivedPropertiesRenderTypeConfig
v1ArchivedPropertiesRenderTypeConfig =
    Jdec.succeed V1ArchivedPropertiesRenderTypeConfig
        |> Jpipe.required "visible" fluffyVisible

encodeV1ArchivedPropertiesRenderTypeConfig : V1ArchivedPropertiesRenderTypeConfig -> Jenc.Value
encodeV1ArchivedPropertiesRenderTypeConfig x =
    Jenc.object
        [ ("visible", encodeFluffyVisible x.visible)
        ]

fluffyVisible : Jdec.Decoder FluffyVisible
fluffyVisible =
    Jdec.succeed FluffyVisible
        |> Jpipe.required "href" Jdec.bool

encodeFluffyVisible : FluffyVisible -> Jenc.Value
encodeFluffyVisible x =
    Jenc.object
        [ ("href", Jenc.bool x.href)
        ]

modifyingViewUid : Jdec.Decoder ModifyingViewUid
modifyingViewUid =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "s6ew-h6mp" -> Jdec.succeed S6EwH6Mp
                somethingElse -> Jdec.fail <| "Invalid ModifyingViewUid: " ++ somethingElse
        )

encodeModifyingViewUid : ModifyingViewUid -> Jenc.Value
encodeModifyingViewUid x = case x of
    S6EwH6Mp -> Jenc.string "s6ew-h6mp"

owner : Jdec.Decoder Owner
owner =
    Jdec.succeed Owner
        |> Jpipe.required "displayName" Jdec.string
        |> Jpipe.custom (optionalField "flags" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.custom (optionalField "lastNotificationSeenAt" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "profileImageUrlLarge" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "profileImageUrlMedium" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "profileImageUrlSmall" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "rights" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.custom (optionalField "roleName" (Jdec.map Just roleName) Nothing)
        |> Jpipe.required "screenName" Jdec.string

encodeOwner : Owner -> Jenc.Value
encodeOwner x =
    Jenc.object
        [ ("displayName", Jenc.string x.displayName)
        , ("flags", makeNullableEncoder (Jenc.list Jenc.string) x.flags)
        , ("id", Jenc.string x.id)
        , ("lastNotificationSeenAt", makeNullableEncoder Jenc.int x.lastNotificationSeenAt)
        , ("profileImageUrlLarge", makeNullableEncoder Jenc.string x.profileImageURLLarge)
        , ("profileImageUrlMedium", makeNullableEncoder Jenc.string x.profileImageURLMedium)
        , ("profileImageUrlSmall", makeNullableEncoder Jenc.string x.profileImageURLSmall)
        , ("rights", makeNullableEncoder (Jenc.list Jenc.string) x.rights)
        , ("roleName", makeNullableEncoder encodeRoleName x.roleName)
        , ("screenName", Jenc.string x.screenName)
        ]

roleName : Jdec.Decoder RoleName
roleName =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "administrator" -> Jdec.succeed Administrator
                "publisher" -> Jdec.succeed Publisher
                somethingElse -> Jdec.fail <| "Invalid RoleName: " ++ somethingElse
        )

encodeRoleName : RoleName -> Jenc.Value
encodeRoleName x = case x of
    Administrator -> Jenc.string "administrator"
    Publisher -> Jenc.string "publisher"

provenance : Jdec.Decoder Provenance
provenance =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "official" -> Jdec.succeed Official
                somethingElse -> Jdec.fail <| "Invalid Provenance: " ++ somethingElse
        )

encodeProvenance : Provenance -> Jenc.Value
encodeProvenance x = case x of
    Official -> Jenc.string "official"

publicationStage : Jdec.Decoder PublicationStage
publicationStage =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "published" -> Jdec.succeed Published
                somethingElse -> Jdec.fail <| "Invalid PublicationStage: " ++ somethingElse
        )

encodePublicationStage : PublicationStage -> Jenc.Value
encodePublicationStage x = case x of
    Published -> Jenc.string "published"

ratings : Jdec.Decoder Ratings
ratings =
    Jdec.succeed Ratings
        |> Jpipe.required "rating" Jdec.int

encodeRatings : Ratings -> Jenc.Value
encodeRatings x =
    Jenc.object
        [ ("rating", Jenc.int x.rating)
        ]

right : Jdec.Decoder Right
right =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "read" -> Jdec.succeed Read
                somethingElse -> Jdec.fail <| "Invalid Right: " ++ somethingElse
        )

encodeRight : Right -> Jenc.Value
encodeRight x = case x of
    Read -> Jenc.string "read"

rowsUpdatedBy : Jdec.Decoder RowsUpdatedBy
rowsUpdatedBy =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "pjxg-ve4m" -> Jdec.succeed PjxgVe4M
                "54a3-qyun" -> Jdec.succeed The54A3Qyun
                "9e3m-2843" -> Jdec.succeed The9E3M2843
                "vvca-fr6g" -> Jdec.succeed VvcaFr6G
                somethingElse -> Jdec.fail <| "Invalid RowsUpdatedBy: " ++ somethingElse
        )

encodeRowsUpdatedBy : RowsUpdatedBy -> Jenc.Value
encodeRowsUpdatedBy x = case x of
    PjxgVe4M -> Jenc.string "pjxg-ve4m"
    The54A3Qyun -> Jenc.string "54a3-qyun"
    The9E3M2843 -> Jenc.string "9e3m-2843"
    VvcaFr6G -> Jenc.string "vvca-fr6g"

tableAuthor : Jdec.Decoder TableAuthor
tableAuthor =
    Jdec.succeed TableAuthor
        |> Jpipe.required "displayName" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.custom (optionalField "rights" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.custom (optionalField "roleName" (Jdec.map Just roleName) Nothing)
        |> Jpipe.required "screenName" Jdec.string

encodeTableAuthor : TableAuthor -> Jenc.Value
encodeTableAuthor x =
    Jenc.object
        [ ("displayName", Jenc.string x.displayName)
        , ("id", Jenc.string x.id)
        , ("rights", makeNullableEncoder (Jenc.list Jenc.string) x.rights)
        , ("roleName", makeNullableEncoder encodeRoleName x.roleName)
        , ("screenName", Jenc.string x.screenName)
        ]

viewType : Jdec.Decoder ViewType
viewType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "tabular" -> Jdec.succeed Tabular
                somethingElse -> Jdec.fail <| "Invalid ViewType: " ++ somethingElse
        )

encodeViewType : ViewType -> Jenc.Value
encodeViewType x = case x of
    Tabular -> Jenc.string "tabular"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
