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
    , Query
    , Grant
    , License
    , Metadata
    , RenderTypeConfig
    , Visible
    , Owner
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
    , license : License
    , licenseID : String
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
    , rowClass : String
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
    , format : Query
    , id : Int
    , name : String
    , position : Int
    , renderTypeName : String
    , tableColumnID : Maybe Int
    , width : Maybe Int
    }

type alias CachedContents =
    { average : Maybe String
    , largest : Maybe String
    , nonNull : Int
    , null : Int
    , smallest : Maybe String
    , sum : Maybe String
    , top : Maybe (List Top)
    }

type alias Top =
    { count : Int
    , item : String
    }

type alias Query =
    {
    }

type alias Grant =
    { flags : List String
    , grantType : String
    , inherited : Bool
    }

type alias License =
    { name : String
    }

type alias Metadata =
    { availableDisplayTypes : List String
    , rdfClass : String
    , rdfSubject : String
    , renderTypeConfig : RenderTypeConfig
    , rowIdentifier : String
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
    , screenName : String
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
        |> Jpipe.required "license" license
        |> Jpipe.required "licenseId" Jdec.string
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
        |> Jpipe.required "rowClass" Jdec.string
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
        , ("license", encodeLicense x.license)
        , ("licenseId", Jenc.string x.licenseID)
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
        , ("rowClass", Jenc.string x.rowClass)
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
        |> Jpipe.required "format" query
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
        , ("format", encodeQuery x.format)
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
        |> Jpipe.custom (optionalField "largest" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.required "non_null" Jdec.int
        |> Jpipe.required "null" Jdec.int
        |> Jpipe.custom (optionalField "smallest" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "sum" (Jdec.map Just Jdec.string) Nothing)
        |> Jpipe.custom (optionalField "top" (Jdec.map Just (Jdec.list top )) Nothing)

encodeCachedContents : CachedContents -> Jenc.Value
encodeCachedContents x =
    Jenc.object
        [ ("average", makeNullableEncoder Jenc.string x.average)
        , ("largest", makeNullableEncoder Jenc.string x.largest)
        , ("non_null", Jenc.int x.nonNull)
        , ("null", Jenc.int x.null)
        , ("smallest", makeNullableEncoder Jenc.string x.smallest)
        , ("sum", makeNullableEncoder Jenc.string x.sum)
        , ("top", makeNullableEncoder (Jenc.list encodeTop) x.top)
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

query : Jdec.Decoder Query
query =
    Jdec.dict Jdec.value |> Jdec.map (\_ -> Query)

encodeQuery : Query -> Jenc.Value
encodeQuery x =
    Jenc.object
        [
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

license : Jdec.Decoder License
license =
    Jdec.succeed License
        |> Jpipe.required "name" Jdec.string

encodeLicense : License -> Jenc.Value
encodeLicense x =
    Jenc.object
        [ ("name", Jenc.string x.name)
        ]

metadata : Jdec.Decoder Metadata
metadata =
    Jdec.succeed Metadata
        |> Jpipe.required "availableDisplayTypes" (Jdec.list Jdec.string )
        |> Jpipe.required "rdfClass" Jdec.string
        |> Jpipe.required "rdfSubject" Jdec.string
        |> Jpipe.required "renderTypeConfig" renderTypeConfig
        |> Jpipe.required "rowIdentifier" Jdec.string

encodeMetadata : Metadata -> Jenc.Value
encodeMetadata x =
    Jenc.object
        [ ("availableDisplayTypes", Jenc.list Jenc.string x.availableDisplayTypes)
        , ("rdfClass", Jenc.string x.rdfClass)
        , ("rdfSubject", Jenc.string x.rdfSubject)
        , ("renderTypeConfig", encodeRenderTypeConfig x.renderTypeConfig)
        , ("rowIdentifier", Jenc.string x.rowIdentifier)
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
        |> Jpipe.required "screenName" Jdec.string

encodeOwner : Owner -> Jenc.Value
encodeOwner x =
    Jenc.object
        [ ("displayName", Jenc.string x.displayName)
        , ("id", Jenc.string x.id)
        , ("screenName", Jenc.string x.screenName)
        ]

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
