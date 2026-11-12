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
    , Meta
    , View
    , Column
    , CachedContents
    , Top
    , Format
    , Grant
    , Metadata
    , Attachment
    , CustomFields
    , AdditionalResources
    , CommonCore
    , DatasetInformation
    , DatasetSummary
    , Notes
    , JSONQuery
    , Order
    , RenderTypeConfig
    , Visible
    , Owner
    , Query
    , OrderBy
    , Expression
    , Datum(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { data : List (List Datum)
    , meta : Meta
    }

type Datum
    = IntegerInDatum Int
    | NullInDatum
    | StringInDatum String

type alias Meta =
    { view : View
    }

type alias View =
    { attribution : String
    , attributionLink : String
    , averageRating : Int
    , category : String
    , columns : List Column
    , createdAt : Int
    , description : String
    , displayType : String
    , downloadCount : Int
    , flags : List String
    , grants : List Grant
    , hideFromCatalog : Bool
    , hideFromDataJSON : Bool
    , id : String
    , indexUpdatedAt : Int
    , locale : String
    , metadata : Metadata
    , name : String
    , newBackend : Bool
    , numberOfComments : Int
    , oid : Int
    , owner : Owner
    , provenance : String
    , publicationAppendEnabled : Bool
    , publicationDate : Int
    , publicationGroup : Int
    , publicationStage : String
    , query : Query
    , rights : List String
    , rowsUpdatedAt : Int
    , rowsUpdatedBy : String
    , tableAuthor : Owner
    , tableID : Int
    , tags : List String
    , totalTimesRated : Int
    , viewCount : Int
    , viewLastModified : Int
    , viewType : String
    }

type alias Column =
    { cachedContents : Maybe CachedContents
    , dataTypeName : String
    , fieldName : String
    , flags : Maybe (List String)
    , format : Format
    , id : Int
    , name : String
    , position : Int
    , renderTypeName : String
    , tableColumnID : Maybe Int
    , width : Maybe Int
    }

type alias CachedContents =
    { average : Maybe String
    , largest : String
    , nonNull : Int
    , null : Int
    , smallest : String
    , sum : Maybe String
    , top : List Top
    }

type alias Top =
    { count : Int
    , item : String
    }

type alias Format =
    { align : Maybe String
    , noCommas : Maybe String
    , precisionStyle : Maybe String
    , view : Maybe String
    }

type alias Grant =
    { flags : List String
    , grantType : String
    , inherited : Bool
    }

type alias Metadata =
    { attachments : List Attachment
    , availableDisplayTypes : List String
    , customFields : CustomFields
    , jsonQuery : JSONQuery
    , rdfSubject : String
    , renderTypeConfig : RenderTypeConfig
    }

type alias Attachment =
    { assetID : String
    , blobID : String
    , filename : String
    , name : String
    }

type alias CustomFields =
    { additionalResources : AdditionalResources
    , commonCore : CommonCore
    , datasetInformation : DatasetInformation
    , datasetSummary : DatasetSummary
    , notes : Notes
    }

type alias AdditionalResources =
    { additionalResourcesSeeAlso : String
    , seeAlso : String
    }

type alias CommonCore =
    { contactEmail : String
    , contactName : String
    , publisher : String
    }

type alias DatasetInformation =
    { agency : String
    }

type alias DatasetSummary =
    { contactInformation : String
    , coverage : String
    , dataFrequency : String
    , datasetOwner : String
    , granularity : String
    , organization : String
    , postingFrequency : String
    , timePeriod : String
    , units : String
    }

type alias Notes =
    { notes : String
    }

type alias JSONQuery =
    { order : List Order
    }

type alias Order =
    { ascending : Bool
    , columnFieldName : String
    }

type alias RenderTypeConfig =
    { visible : Visible
    }

type alias Visible =
    { table : Bool
    }

type alias Owner =
    { displayName : String
    , id : String
    , profileImageURLLarge : String
    , profileImageURLMedium : String
    , profileImageURLSmall : String
    , rights : List String
    , roleName : String
    , screenName : String
    }

type alias Query =
    { orderBys : List OrderBy
    }

type alias OrderBy =
    { ascending : Bool
    , expression : Expression
    }

type alias Expression =
    { columnID : Int
    , expressionType : String
    }

-- decoders and encoders
optionalField key decoder fallback =
    Jdec.dict Jdec.value
        |> Jdec.andThen (\m ->
            case Dict.get key m of
                Nothing -> Jdec.succeed fallback
                Just x -> Jdec.decodeValue decoder x |> Result.map Jdec.succeed |> Result.withDefault (Jdec.fail ("Invalid " ++ key)))

quickTypeToString : QuickType -> String
quickTypeToString r = Jenc.encode 0 (encodeQuickType r)

quickType : Jdec.Decoder QuickType
quickType =
    Jdec.succeed QuickType
        |> Jpipe.required "data" (Jdec.list (Jdec.list datum ) )
        |> Jpipe.required "meta" meta

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("data", Jenc.list (Jenc.list encodeDatum) x.data)
        , ("meta", encodeMeta x.meta)
        ]

datum : Jdec.Decoder Datum
datum =
    Jdec.oneOf
        [ Jdec.map IntegerInDatum Jdec.int
        , Jdec.null NullInDatum
        , Jdec.map StringInDatum Jdec.string
        ]

encodeDatum : Datum -> Jenc.Value
encodeDatum x = case x of
    IntegerInDatum y -> Jenc.int y
    NullInDatum -> Jenc.null
    StringInDatum y -> Jenc.string y

meta : Jdec.Decoder Meta
meta =
    Jdec.succeed Meta
        |> Jpipe.required "view" view

encodeMeta : Meta -> Jenc.Value
encodeMeta x =
    Jenc.object
        [ ("view", encodeView x.view)
        ]

view : Jdec.Decoder View
view =
    Jdec.succeed View
        |> Jpipe.required "attribution" Jdec.string
        |> Jpipe.required "attributionLink" Jdec.string
        |> Jpipe.required "averageRating" Jdec.int
        |> Jpipe.required "category" Jdec.string
        |> Jpipe.required "columns" (Jdec.list column )
        |> Jpipe.required "createdAt" Jdec.int
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "displayType" Jdec.string
        |> Jpipe.required "downloadCount" Jdec.int
        |> Jpipe.required "flags" (Jdec.list Jdec.string )
        |> Jpipe.required "grants" (Jdec.list grant )
        |> Jpipe.required "hideFromCatalog" Jdec.bool
        |> Jpipe.required "hideFromDataJson" Jdec.bool
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "indexUpdatedAt" Jdec.int
        |> Jpipe.required "locale" Jdec.string
        |> Jpipe.required "metadata" metadata
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "newBackend" Jdec.bool
        |> Jpipe.required "numberOfComments" Jdec.int
        |> Jpipe.required "oid" Jdec.int
        |> Jpipe.required "owner" owner
        |> Jpipe.required "provenance" Jdec.string
        |> Jpipe.required "publicationAppendEnabled" Jdec.bool
        |> Jpipe.required "publicationDate" Jdec.int
        |> Jpipe.required "publicationGroup" Jdec.int
        |> Jpipe.required "publicationStage" Jdec.string
        |> Jpipe.required "query" query
        |> Jpipe.required "rights" (Jdec.list Jdec.string )
        |> Jpipe.required "rowsUpdatedAt" Jdec.int
        |> Jpipe.required "rowsUpdatedBy" Jdec.string
        |> Jpipe.required "tableAuthor" owner
        |> Jpipe.required "tableId" Jdec.int
        |> Jpipe.required "tags" (Jdec.list Jdec.string )
        |> Jpipe.required "totalTimesRated" Jdec.int
        |> Jpipe.required "viewCount" Jdec.int
        |> Jpipe.required "viewLastModified" Jdec.int
        |> Jpipe.required "viewType" Jdec.string

encodeView : View -> Jenc.Value
encodeView x =
    Jenc.object
        [ ("attribution", Jenc.string x.attribution)
        , ("attributionLink", Jenc.string x.attributionLink)
        , ("averageRating", Jenc.int x.averageRating)
        , ("category", Jenc.string x.category)
        , ("columns", Jenc.list encodeColumn x.columns)
        , ("createdAt", Jenc.int x.createdAt)
        , ("description", Jenc.string x.description)
        , ("displayType", Jenc.string x.displayType)
        , ("downloadCount", Jenc.int x.downloadCount)
        , ("flags", Jenc.list Jenc.string x.flags)
        , ("grants", Jenc.list encodeGrant x.grants)
        , ("hideFromCatalog", Jenc.bool x.hideFromCatalog)
        , ("hideFromDataJson", Jenc.bool x.hideFromDataJSON)
        , ("id", Jenc.string x.id)
        , ("indexUpdatedAt", Jenc.int x.indexUpdatedAt)
        , ("locale", Jenc.string x.locale)
        , ("metadata", encodeMetadata x.metadata)
        , ("name", Jenc.string x.name)
        , ("newBackend", Jenc.bool x.newBackend)
        , ("numberOfComments", Jenc.int x.numberOfComments)
        , ("oid", Jenc.int x.oid)
        , ("owner", encodeOwner x.owner)
        , ("provenance", Jenc.string x.provenance)
        , ("publicationAppendEnabled", Jenc.bool x.publicationAppendEnabled)
        , ("publicationDate", Jenc.int x.publicationDate)
        , ("publicationGroup", Jenc.int x.publicationGroup)
        , ("publicationStage", Jenc.string x.publicationStage)
        , ("query", encodeQuery x.query)
        , ("rights", Jenc.list Jenc.string x.rights)
        , ("rowsUpdatedAt", Jenc.int x.rowsUpdatedAt)
        , ("rowsUpdatedBy", Jenc.string x.rowsUpdatedBy)
        , ("tableAuthor", encodeOwner x.tableAuthor)
        , ("tableId", Jenc.int x.tableID)
        , ("tags", Jenc.list Jenc.string x.tags)
        , ("totalTimesRated", Jenc.int x.totalTimesRated)
        , ("viewCount", Jenc.int x.viewCount)
        , ("viewLastModified", Jenc.int x.viewLastModified)
        , ("viewType", Jenc.string x.viewType)
        ]

column : Jdec.Decoder Column
column =
    Jdec.succeed Column
        |> Jpipe.custom (optionalField "cachedContents" (Jdec.map Just cachedContents) Nothing)
        |> Jpipe.required "dataTypeName" Jdec.string
        |> Jpipe.required "fieldName" Jdec.string
        |> Jpipe.custom (optionalField "flags" (Jdec.map Just (Jdec.list Jdec.string )) Nothing)
        |> Jpipe.required "format" format
        |> Jpipe.required "id" Jdec.int
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "position" Jdec.int
        |> Jpipe.required "renderTypeName" Jdec.string
        |> Jpipe.custom (optionalField "tableColumnId" (Jdec.map Just Jdec.int) Nothing)
        |> Jpipe.custom (optionalField "width" (Jdec.map Just Jdec.int) Nothing)

encodeColumn : Column -> Jenc.Value
encodeColumn x =
    Jenc.object
        [ ("cachedContents", makeNullableEncoder encodeCachedContents x.cachedContents)
        , ("dataTypeName", Jenc.string x.dataTypeName)
        , ("fieldName", Jenc.string x.fieldName)
        , ("flags", makeNullableEncoder (Jenc.list Jenc.string) x.flags)
        , ("format", encodeFormat x.format)
        , ("id", Jenc.int x.id)
        , ("name", Jenc.string x.name)
        , ("position", Jenc.int x.position)
        , ("renderTypeName", Jenc.string x.renderTypeName)
        , ("tableColumnId", makeNullableEncoder Jenc.int x.tableColumnID)
        , ("width", makeNullableEncoder Jenc.int x.width)
        ]

cachedContents : Jdec.Decoder CachedContents
cachedContents =
    Jdec.succeed CachedContents
        |> Jpipe.custom (optionalField "average" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "largest" Jdec.string
        |> Jpipe.required "non_null" Jdec.int
        |> Jpipe.required "null" Jdec.int
        |> Jpipe.required "smallest" Jdec.string
        |> Jpipe.custom (optionalField "sum" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "top" (Jdec.list top )

encodeCachedContents : CachedContents -> Jenc.Value
encodeCachedContents x =
    Jenc.object
        [ ("average", makeNullableEncoder Jenc.string x.average)
        , ("largest", Jenc.string x.largest)
        , ("non_null", Jenc.int x.nonNull)
        , ("null", Jenc.int x.null)
        , ("smallest", Jenc.string x.smallest)
        , ("sum", makeNullableEncoder Jenc.string x.sum)
        , ("top", Jenc.list encodeTop x.top)
        ]

top : Jdec.Decoder Top
top =
    Jdec.succeed Top
        |> Jpipe.required "count" Jdec.int
        |> Jpipe.required "item" Jdec.string

encodeTop : Top -> Jenc.Value
encodeTop x =
    Jenc.object
        [ ("count", Jenc.int x.count)
        , ("item", Jenc.string x.item)
        ]

format : Jdec.Decoder Format
format =
    Jdec.succeed Format
        |> Jpipe.custom (optionalField "align" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "noCommas" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "precisionStyle" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "view" (Jdec.map Just Jdec.string) Nothing)

encodeFormat : Format -> Jenc.Value
encodeFormat x =
    Jenc.object
        [ ("align", makeNullableEncoder Jenc.string x.align)
        , ("noCommas", makeNullableEncoder Jenc.string x.noCommas)
        , ("precisionStyle", makeNullableEncoder Jenc.string x.precisionStyle)
        , ("view", makeNullableEncoder Jenc.string x.view)
        ]

grant : Jdec.Decoder Grant
grant =
    Jdec.succeed Grant
        |> Jpipe.required "flags" (Jdec.list Jdec.string )
        |> Jpipe.required "type" Jdec.string
        |> Jpipe.required "inherited" Jdec.bool

encodeGrant : Grant -> Jenc.Value
encodeGrant x =
    Jenc.object
        [ ("flags", Jenc.list Jenc.string x.flags)
        , ("type", Jenc.string x.grantType)
        , ("inherited", Jenc.bool x.inherited)
        ]

metadata : Jdec.Decoder Metadata
metadata =
    Jdec.succeed Metadata
        |> Jpipe.required "attachments" (Jdec.list attachment )
        |> Jpipe.required "availableDisplayTypes" (Jdec.list Jdec.string )
        |> Jpipe.required "custom_fields" customFields
        |> Jpipe.required "jsonQuery" jsonQuery
        |> Jpipe.required "rdfSubject" Jdec.string
        |> Jpipe.required "renderTypeConfig" renderTypeConfig

encodeMetadata : Metadata -> Jenc.Value
encodeMetadata x =
    Jenc.object
        [ ("attachments", Jenc.list encodeAttachment x.attachments)
        , ("availableDisplayTypes", Jenc.list Jenc.string x.availableDisplayTypes)
        , ("custom_fields", encodeCustomFields x.customFields)
        , ("jsonQuery", encodeJSONQuery x.jsonQuery)
        , ("rdfSubject", Jenc.string x.rdfSubject)
        , ("renderTypeConfig", encodeRenderTypeConfig x.renderTypeConfig)
        ]

attachment : Jdec.Decoder Attachment
attachment =
    Jdec.succeed Attachment
        |> Jpipe.required "assetId" Jdec.string
        |> Jpipe.required "blobId" Jdec.string
        |> Jpipe.required "filename" Jdec.string
        |> Jpipe.required "name" Jdec.string

encodeAttachment : Attachment -> Jenc.Value
encodeAttachment x =
    Jenc.object
        [ ("assetId", Jenc.string x.assetID)
        , ("blobId", Jenc.string x.blobID)
        , ("filename", Jenc.string x.filename)
        , ("name", Jenc.string x.name)
        ]

customFields : Jdec.Decoder CustomFields
customFields =
    Jdec.succeed CustomFields
        |> Jpipe.required "Additional Resources" additionalResources
        |> Jpipe.required "Common Core" commonCore
        |> Jpipe.required "Dataset Information" datasetInformation
        |> Jpipe.required "Dataset Summary" datasetSummary
        |> Jpipe.required "Notes" notes

encodeCustomFields : CustomFields -> Jenc.Value
encodeCustomFields x =
    Jenc.object
        [ ("Additional Resources", encodeAdditionalResources x.additionalResources)
        , ("Common Core", encodeCommonCore x.commonCore)
        , ("Dataset Information", encodeDatasetInformation x.datasetInformation)
        , ("Dataset Summary", encodeDatasetSummary x.datasetSummary)
        , ("Notes", encodeNotes x.notes)
        ]

additionalResources : Jdec.Decoder AdditionalResources
additionalResources =
    Jdec.succeed AdditionalResources
        |> Jpipe.required "See Also " Jdec.string
        |> Jpipe.required "See Also" Jdec.string

encodeAdditionalResources : AdditionalResources -> Jenc.Value
encodeAdditionalResources x =
    Jenc.object
        [ ("See Also ", Jenc.string x.additionalResourcesSeeAlso)
        , ("See Also", Jenc.string x.seeAlso)
        ]

commonCore : Jdec.Decoder CommonCore
commonCore =
    Jdec.succeed CommonCore
        |> Jpipe.required "Contact Email" Jdec.string
        |> Jpipe.required "Contact Name" Jdec.string
        |> Jpipe.required "Publisher" Jdec.string

encodeCommonCore : CommonCore -> Jenc.Value
encodeCommonCore x =
    Jenc.object
        [ ("Contact Email", Jenc.string x.contactEmail)
        , ("Contact Name", Jenc.string x.contactName)
        , ("Publisher", Jenc.string x.publisher)
        ]

datasetInformation : Jdec.Decoder DatasetInformation
datasetInformation =
    Jdec.succeed DatasetInformation
        |> Jpipe.required "Agency" Jdec.string

encodeDatasetInformation : DatasetInformation -> Jenc.Value
encodeDatasetInformation x =
    Jenc.object
        [ ("Agency", Jenc.string x.agency)
        ]

datasetSummary : Jdec.Decoder DatasetSummary
datasetSummary =
    Jdec.succeed DatasetSummary
        |> Jpipe.required "Contact Information" Jdec.string
        |> Jpipe.required "Coverage" Jdec.string
        |> Jpipe.required "Data Frequency" Jdec.string
        |> Jpipe.required "Dataset Owner" Jdec.string
        |> Jpipe.required "Granularity" Jdec.string
        |> Jpipe.required "Organization" Jdec.string
        |> Jpipe.required "Posting Frequency" Jdec.string
        |> Jpipe.required "Time Period" Jdec.string
        |> Jpipe.required "Units" Jdec.string

encodeDatasetSummary : DatasetSummary -> Jenc.Value
encodeDatasetSummary x =
    Jenc.object
        [ ("Contact Information", Jenc.string x.contactInformation)
        , ("Coverage", Jenc.string x.coverage)
        , ("Data Frequency", Jenc.string x.dataFrequency)
        , ("Dataset Owner", Jenc.string x.datasetOwner)
        , ("Granularity", Jenc.string x.granularity)
        , ("Organization", Jenc.string x.organization)
        , ("Posting Frequency", Jenc.string x.postingFrequency)
        , ("Time Period", Jenc.string x.timePeriod)
        , ("Units", Jenc.string x.units)
        ]

notes : Jdec.Decoder Notes
notes =
    Jdec.succeed Notes
        |> Jpipe.required "Notes" Jdec.string

encodeNotes : Notes -> Jenc.Value
encodeNotes x =
    Jenc.object
        [ ("Notes", Jenc.string x.notes)
        ]

jsonQuery : Jdec.Decoder JSONQuery
jsonQuery =
    Jdec.succeed JSONQuery
        |> Jpipe.required "order" (Jdec.list order )

encodeJSONQuery : JSONQuery -> Jenc.Value
encodeJSONQuery x =
    Jenc.object
        [ ("order", Jenc.list encodeOrder x.order)
        ]

order : Jdec.Decoder Order
order =
    Jdec.succeed Order
        |> Jpipe.required "ascending" Jdec.bool
        |> Jpipe.required "columnFieldName" Jdec.string

encodeOrder : Order -> Jenc.Value
encodeOrder x =
    Jenc.object
        [ ("ascending", Jenc.bool x.ascending)
        , ("columnFieldName", Jenc.string x.columnFieldName)
        ]

renderTypeConfig : Jdec.Decoder RenderTypeConfig
renderTypeConfig =
    Jdec.succeed RenderTypeConfig
        |> Jpipe.required "visible" visible

encodeRenderTypeConfig : RenderTypeConfig -> Jenc.Value
encodeRenderTypeConfig x =
    Jenc.object
        [ ("visible", encodeVisible x.visible)
        ]

visible : Jdec.Decoder Visible
visible =
    Jdec.succeed Visible
        |> Jpipe.required "table" Jdec.bool

encodeVisible : Visible -> Jenc.Value
encodeVisible x =
    Jenc.object
        [ ("table", Jenc.bool x.table)
        ]

owner : Jdec.Decoder Owner
owner =
    Jdec.succeed Owner
        |> Jpipe.required "displayName" Jdec.string
        |> Jpipe.required "id" Jdec.string
        |> Jpipe.required "profileImageUrlLarge" Jdec.string
        |> Jpipe.required "profileImageUrlMedium" Jdec.string
        |> Jpipe.required "profileImageUrlSmall" Jdec.string
        |> Jpipe.required "rights" (Jdec.list Jdec.string )
        |> Jpipe.required "roleName" Jdec.string
        |> Jpipe.required "screenName" Jdec.string

encodeOwner : Owner -> Jenc.Value
encodeOwner x =
    Jenc.object
        [ ("displayName", Jenc.string x.displayName)
        , ("id", Jenc.string x.id)
        , ("profileImageUrlLarge", Jenc.string x.profileImageURLLarge)
        , ("profileImageUrlMedium", Jenc.string x.profileImageURLMedium)
        , ("profileImageUrlSmall", Jenc.string x.profileImageURLSmall)
        , ("rights", Jenc.list Jenc.string x.rights)
        , ("roleName", Jenc.string x.roleName)
        , ("screenName", Jenc.string x.screenName)
        ]

query : Jdec.Decoder Query
query =
    Jdec.succeed Query
        |> Jpipe.required "orderBys" (Jdec.list orderBy )

encodeQuery : Query -> Jenc.Value
encodeQuery x =
    Jenc.object
        [ ("orderBys", Jenc.list encodeOrderBy x.orderBys)
        ]

orderBy : Jdec.Decoder OrderBy
orderBy =
    Jdec.succeed OrderBy
        |> Jpipe.required "ascending" Jdec.bool
        |> Jpipe.required "expression" expression

encodeOrderBy : OrderBy -> Jenc.Value
encodeOrderBy x =
    Jenc.object
        [ ("ascending", Jenc.bool x.ascending)
        , ("expression", encodeExpression x.expression)
        ]

expression : Jdec.Decoder Expression
expression =
    Jdec.succeed Expression
        |> Jpipe.required "columnId" Jdec.int
        |> Jpipe.required "type" Jdec.string

encodeExpression : Expression -> Jenc.Value
encodeExpression x =
    Jenc.object
        [ ("columnId", Jenc.int x.columnID)
        , ("type", Jenc.string x.expressionType)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
