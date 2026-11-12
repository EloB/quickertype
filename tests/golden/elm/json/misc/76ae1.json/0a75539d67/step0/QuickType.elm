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
    , Definitions
    , Article
    , Property
    , DeMinimis
    , DeMinimisProperties
    , FAQ
    , FAQProperties
    , Report
    , ReportProperties
    , Taxonomy
    , TaxonomyProperties
    , Info
    , Paths
    , BusinessServiceProvidersSearchClass
    , BusinessServiceProvidersSearchGet
    , Parameter
    , PurpleResponses
    , Purple200
    , ItemsClass
    , ConsolidatedScreeningListSearchClass
    , ConsolidatedScreeningListSearchGet
    , FluffyResponses
    , Fluffy200
    , PurpleSchema
    , FormatEnum(..)
    , In(..)
    , SchemaType(..)
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict)

type alias QuickType =
    { basePath : String
    , definitions : Definitions
    , host : String
    , info : Info
    , paths : Paths
    , produces : List String
    , schemes : List String
    , swagger : String
    }

type alias Definitions =
    { article : Article
    , center : Article
    , deMinimis : DeMinimis
    , event : Article
    , faq : FAQ
    , lead : Article
    , list : Article
    , marketIntelligence : Article
    , office : Article
    , provider : Article
    , rate : Article
    , report : Report
    , taxonomy : Taxonomy
    }

type alias Article =
    { properties : Dict String Property
    }

type alias Property =
    { description : String
    , propertyType : FormatEnum
    }

type FormatEnum
    = TypeString

type alias DeMinimis =
    { properties : DeMinimisProperties
    }

type alias DeMinimisProperties =
    { countries : Property
    , country : Property
    , deMinimisCurrency : Property
    , deMinimisValue : Property
    , notes : Property
    , vatAmount : Property
    , vatCurrency : Property
    }

type alias FAQ =
    { properties : FAQProperties
    }

type alias FAQProperties =
    { answer : Property
    , countries : Property
    , firstPublishedDate : Property
    , id : Property
    , industries : Property
    , lastPublishedDate : Property
    , question : Property
    , topics : Property
    , tradeRegions : Property
    , url : Property
    , worldRegions : Property
    }

type alias Report =
    { properties : ReportProperties
    }

type alias ReportProperties =
    { countries : Property
    , description : Property
    , expirationDate : Property
    , id : Property
    , industries : Property
    , itaIndustries : Property
    , reportType : Property
    , title : Property
    , url : Property
    }

type alias Taxonomy =
    { properties : TaxonomyProperties
    }

type alias TaxonomyProperties =
    { annotations : Property
    , datatypeProperties : Property
    , id : Property
    , label : Property
    , propertiesType : Property
    , subClassOf : Property
    }

type alias Info =
    { description : String
    , title : String
    , version : String
    }

type alias Paths =
    { businessServiceProvidersSearch : BusinessServiceProvidersSearchClass
    , consolidatedScreeningListSearch : ConsolidatedScreeningListSearchClass
    , deMinimisSearch : ConsolidatedScreeningListSearchClass
    , itaFaqsSearch : ConsolidatedScreeningListSearchClass
    , itaOfficeLocationsSearch : ConsolidatedScreeningListSearchClass
    , itaTaxonomiesSearch : BusinessServiceProvidersSearchClass
    , itaZipcodeToPostSearch : BusinessServiceProvidersSearchClass
    , marketIntelligenceSearch : ConsolidatedScreeningListSearchClass
    , marketResearchLibrarySearch : ConsolidatedScreeningListSearchClass
    , tariffRatesSearch : ConsolidatedScreeningListSearchClass
    , tradeArticlesSearch : ConsolidatedScreeningListSearchClass
    , tradeEventsSearch : ConsolidatedScreeningListSearchClass
    , tradeLeadsSearch : ConsolidatedScreeningListSearchClass
    }

type alias BusinessServiceProvidersSearchClass =
    { get : BusinessServiceProvidersSearchGet
    }

type alias BusinessServiceProvidersSearchGet =
    { description : String
    , parameters : List Parameter
    , responses : PurpleResponses
    , summary : String
    , tags : List String
    }

type alias Parameter =
    { description : String
    , format : FormatEnum
    , name : String
    , parameterIn : In
    , parameterType : FormatEnum
    , required : Bool
    }

type In
    = Query

type alias PurpleResponses =
    { the200 : Purple200
    }

type alias Purple200 =
    { description : String
    , schema : ItemsClass
    }

type alias ItemsClass =
    { ref : String
    }

type alias ConsolidatedScreeningListSearchClass =
    { get : ConsolidatedScreeningListSearchGet
    }

type alias ConsolidatedScreeningListSearchGet =
    { description : String
    , parameters : List Parameter
    , responses : FluffyResponses
    , summary : String
    , tags : List String
    }

type alias FluffyResponses =
    { the200 : Fluffy200
    }

type alias Fluffy200 =
    { description : String
    , schema : PurpleSchema
    }

type alias PurpleSchema =
    { items : ItemsClass
    , schemaType : SchemaType
    }

type SchemaType
    = TypeArray

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
        |> Jpipe.required "basePath" Jdec.string
        |> Jpipe.required "definitions" definitions
        |> Jpipe.required "host" Jdec.string
        |> Jpipe.required "info" info
        |> Jpipe.required "paths" paths
        |> Jpipe.required "produces" (Jdec.list Jdec.string )
        |> Jpipe.required "schemes" (Jdec.list Jdec.string )
        |> Jpipe.required "swagger" Jdec.string

encodeQuickType : QuickType -> Jenc.Value
encodeQuickType x =
    Jenc.object
        [ ("basePath", Jenc.string x.basePath)
        , ("definitions", encodeDefinitions x.definitions)
        , ("host", Jenc.string x.host)
        , ("info", encodeInfo x.info)
        , ("paths", encodePaths x.paths)
        , ("produces", Jenc.list Jenc.string x.produces)
        , ("schemes", Jenc.list Jenc.string x.schemes)
        , ("swagger", Jenc.string x.swagger)
        ]

definitions : Jdec.Decoder Definitions
definitions =
    Jdec.succeed Definitions
        |> Jpipe.required "Article" article
        |> Jpipe.required "Center" article
        |> Jpipe.required "DeMinimis" deMinimis
        |> Jpipe.required "Event" article
        |> Jpipe.required "FAQ" faq
        |> Jpipe.required "Lead" article
        |> Jpipe.required "List" article
        |> Jpipe.required "MarketIntelligence" article
        |> Jpipe.required "Office" article
        |> Jpipe.required "Provider" article
        |> Jpipe.required "Rate" article
        |> Jpipe.required "Report" report
        |> Jpipe.required "Taxonomy" taxonomy

encodeDefinitions : Definitions -> Jenc.Value
encodeDefinitions x =
    Jenc.object
        [ ("Article", encodeArticle x.article)
        , ("Center", encodeArticle x.center)
        , ("DeMinimis", encodeDeMinimis x.deMinimis)
        , ("Event", encodeArticle x.event)
        , ("FAQ", encodeFAQ x.faq)
        , ("Lead", encodeArticle x.lead)
        , ("List", encodeArticle x.list)
        , ("MarketIntelligence", encodeArticle x.marketIntelligence)
        , ("Office", encodeArticle x.office)
        , ("Provider", encodeArticle x.provider)
        , ("Rate", encodeArticle x.rate)
        , ("Report", encodeReport x.report)
        , ("Taxonomy", encodeTaxonomy x.taxonomy)
        ]

article : Jdec.Decoder Article
article =
    Jdec.succeed Article
        |> Jpipe.required "properties" (Jdec.dict property)

encodeArticle : Article -> Jenc.Value
encodeArticle x =
    Jenc.object
        [ ("properties", Jenc.dict identity encodeProperty x.properties)
        ]

property : Jdec.Decoder Property
property =
    Jdec.succeed Property
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "type" formatEnum

encodeProperty : Property -> Jenc.Value
encodeProperty x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("type", encodeFormatEnum x.propertyType)
        ]

formatEnum : Jdec.Decoder FormatEnum
formatEnum =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "string" -> Jdec.succeed TypeString
                somethingElse -> Jdec.fail <| "Invalid FormatEnum: " ++ somethingElse
        )

encodeFormatEnum : FormatEnum -> Jenc.Value
encodeFormatEnum x = case x of
    TypeString -> Jenc.string "string"

deMinimis : Jdec.Decoder DeMinimis
deMinimis =
    Jdec.succeed DeMinimis
        |> Jpipe.required "properties" deMinimisProperties

encodeDeMinimis : DeMinimis -> Jenc.Value
encodeDeMinimis x =
    Jenc.object
        [ ("properties", encodeDeMinimisProperties x.properties)
        ]

deMinimisProperties : Jdec.Decoder DeMinimisProperties
deMinimisProperties =
    Jdec.succeed DeMinimisProperties
        |> Jpipe.required "countries" property
        |> Jpipe.required "country" property
        |> Jpipe.required "de_minimis_currency" property
        |> Jpipe.required "de_minimis_value" property
        |> Jpipe.required "notes" property
        |> Jpipe.required "vat_amount" property
        |> Jpipe.required "vat_currency" property

encodeDeMinimisProperties : DeMinimisProperties -> Jenc.Value
encodeDeMinimisProperties x =
    Jenc.object
        [ ("countries", encodeProperty x.countries)
        , ("country", encodeProperty x.country)
        , ("de_minimis_currency", encodeProperty x.deMinimisCurrency)
        , ("de_minimis_value", encodeProperty x.deMinimisValue)
        , ("notes", encodeProperty x.notes)
        , ("vat_amount", encodeProperty x.vatAmount)
        , ("vat_currency", encodeProperty x.vatCurrency)
        ]

faq : Jdec.Decoder FAQ
faq =
    Jdec.succeed FAQ
        |> Jpipe.required "properties" faqProperties

encodeFAQ : FAQ -> Jenc.Value
encodeFAQ x =
    Jenc.object
        [ ("properties", encodeFAQProperties x.properties)
        ]

faqProperties : Jdec.Decoder FAQProperties
faqProperties =
    Jdec.succeed FAQProperties
        |> Jpipe.required "answer" property
        |> Jpipe.required "countries" property
        |> Jpipe.required "first_published_date" property
        |> Jpipe.required "id" property
        |> Jpipe.required "industries" property
        |> Jpipe.required "last_published_date" property
        |> Jpipe.required "question" property
        |> Jpipe.required "topics" property
        |> Jpipe.required "trade_regions" property
        |> Jpipe.required "url" property
        |> Jpipe.required "world_regions" property

encodeFAQProperties : FAQProperties -> Jenc.Value
encodeFAQProperties x =
    Jenc.object
        [ ("answer", encodeProperty x.answer)
        , ("countries", encodeProperty x.countries)
        , ("first_published_date", encodeProperty x.firstPublishedDate)
        , ("id", encodeProperty x.id)
        , ("industries", encodeProperty x.industries)
        , ("last_published_date", encodeProperty x.lastPublishedDate)
        , ("question", encodeProperty x.question)
        , ("topics", encodeProperty x.topics)
        , ("trade_regions", encodeProperty x.tradeRegions)
        , ("url", encodeProperty x.url)
        , ("world_regions", encodeProperty x.worldRegions)
        ]

report : Jdec.Decoder Report
report =
    Jdec.succeed Report
        |> Jpipe.required "properties" reportProperties

encodeReport : Report -> Jenc.Value
encodeReport x =
    Jenc.object
        [ ("properties", encodeReportProperties x.properties)
        ]

reportProperties : Jdec.Decoder ReportProperties
reportProperties =
    Jdec.succeed ReportProperties
        |> Jpipe.required "countries" property
        |> Jpipe.required "description" property
        |> Jpipe.required "expiration_date" property
        |> Jpipe.required "id" property
        |> Jpipe.required "industries" property
        |> Jpipe.required "ita_industries" property
        |> Jpipe.required "report_type" property
        |> Jpipe.required "title" property
        |> Jpipe.required "url" property

encodeReportProperties : ReportProperties -> Jenc.Value
encodeReportProperties x =
    Jenc.object
        [ ("countries", encodeProperty x.countries)
        , ("description", encodeProperty x.description)
        , ("expiration_date", encodeProperty x.expirationDate)
        , ("id", encodeProperty x.id)
        , ("industries", encodeProperty x.industries)
        , ("ita_industries", encodeProperty x.itaIndustries)
        , ("report_type", encodeProperty x.reportType)
        , ("title", encodeProperty x.title)
        , ("url", encodeProperty x.url)
        ]

taxonomy : Jdec.Decoder Taxonomy
taxonomy =
    Jdec.succeed Taxonomy
        |> Jpipe.required "properties" taxonomyProperties

encodeTaxonomy : Taxonomy -> Jenc.Value
encodeTaxonomy x =
    Jenc.object
        [ ("properties", encodeTaxonomyProperties x.properties)
        ]

taxonomyProperties : Jdec.Decoder TaxonomyProperties
taxonomyProperties =
    Jdec.succeed TaxonomyProperties
        |> Jpipe.required "annotations" property
        |> Jpipe.required "datatype_properties" property
        |> Jpipe.required "id" property
        |> Jpipe.required "label" property
        |> Jpipe.required "type" property
        |> Jpipe.required "sub_class_of" property

encodeTaxonomyProperties : TaxonomyProperties -> Jenc.Value
encodeTaxonomyProperties x =
    Jenc.object
        [ ("annotations", encodeProperty x.annotations)
        , ("datatype_properties", encodeProperty x.datatypeProperties)
        , ("id", encodeProperty x.id)
        , ("label", encodeProperty x.label)
        , ("type", encodeProperty x.propertiesType)
        , ("sub_class_of", encodeProperty x.subClassOf)
        ]

info : Jdec.Decoder Info
info =
    Jdec.succeed Info
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "title" Jdec.string
        |> Jpipe.required "version" Jdec.string

encodeInfo : Info -> Jenc.Value
encodeInfo x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("title", Jenc.string x.title)
        , ("version", Jenc.string x.version)
        ]

paths : Jdec.Decoder Paths
paths =
    Jdec.succeed Paths
        |> Jpipe.required "/business_service_providers/search" businessServiceProvidersSearchClass
        |> Jpipe.required "/consolidated_screening_list/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/de_minimis/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/ita_faqs/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/ita_office_locations/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/ita_taxonomies/search" businessServiceProvidersSearchClass
        |> Jpipe.required "/ita_zipcode_to_post/search" businessServiceProvidersSearchClass
        |> Jpipe.required "/market_intelligence/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/market_research_library/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/tariff_rates/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/trade_articles/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/trade_events/search" consolidatedScreeningListSearchClass
        |> Jpipe.required "/trade_leads/search" consolidatedScreeningListSearchClass

encodePaths : Paths -> Jenc.Value
encodePaths x =
    Jenc.object
        [ ("/business_service_providers/search", encodeBusinessServiceProvidersSearchClass x.businessServiceProvidersSearch)
        , ("/consolidated_screening_list/search", encodeConsolidatedScreeningListSearchClass x.consolidatedScreeningListSearch)
        , ("/de_minimis/search", encodeConsolidatedScreeningListSearchClass x.deMinimisSearch)
        , ("/ita_faqs/search", encodeConsolidatedScreeningListSearchClass x.itaFaqsSearch)
        , ("/ita_office_locations/search", encodeConsolidatedScreeningListSearchClass x.itaOfficeLocationsSearch)
        , ("/ita_taxonomies/search", encodeBusinessServiceProvidersSearchClass x.itaTaxonomiesSearch)
        , ("/ita_zipcode_to_post/search", encodeBusinessServiceProvidersSearchClass x.itaZipcodeToPostSearch)
        , ("/market_intelligence/search", encodeConsolidatedScreeningListSearchClass x.marketIntelligenceSearch)
        , ("/market_research_library/search", encodeConsolidatedScreeningListSearchClass x.marketResearchLibrarySearch)
        , ("/tariff_rates/search", encodeConsolidatedScreeningListSearchClass x.tariffRatesSearch)
        , ("/trade_articles/search", encodeConsolidatedScreeningListSearchClass x.tradeArticlesSearch)
        , ("/trade_events/search", encodeConsolidatedScreeningListSearchClass x.tradeEventsSearch)
        , ("/trade_leads/search", encodeConsolidatedScreeningListSearchClass x.tradeLeadsSearch)
        ]

businessServiceProvidersSearchClass : Jdec.Decoder BusinessServiceProvidersSearchClass
businessServiceProvidersSearchClass =
    Jdec.succeed BusinessServiceProvidersSearchClass
        |> Jpipe.required "get" businessServiceProvidersSearchGet

encodeBusinessServiceProvidersSearchClass : BusinessServiceProvidersSearchClass -> Jenc.Value
encodeBusinessServiceProvidersSearchClass x =
    Jenc.object
        [ ("get", encodeBusinessServiceProvidersSearchGet x.get)
        ]

businessServiceProvidersSearchGet : Jdec.Decoder BusinessServiceProvidersSearchGet
businessServiceProvidersSearchGet =
    Jdec.succeed BusinessServiceProvidersSearchGet
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "parameters" (Jdec.list parameter )
        |> Jpipe.required "responses" purpleResponses
        |> Jpipe.required "summary" Jdec.string
        |> Jpipe.required "tags" (Jdec.list Jdec.string )

encodeBusinessServiceProvidersSearchGet : BusinessServiceProvidersSearchGet -> Jenc.Value
encodeBusinessServiceProvidersSearchGet x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("parameters", Jenc.list encodeParameter x.parameters)
        , ("responses", encodePurpleResponses x.responses)
        , ("summary", Jenc.string x.summary)
        , ("tags", Jenc.list Jenc.string x.tags)
        ]

parameter : Jdec.Decoder Parameter
parameter =
    Jdec.succeed Parameter
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "format" formatEnum
        |> Jpipe.required "name" Jdec.string
        |> Jpipe.required "in" purpleIn
        |> Jpipe.required "type" formatEnum
        |> Jpipe.required "required" Jdec.bool

encodeParameter : Parameter -> Jenc.Value
encodeParameter x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("format", encodeFormatEnum x.format)
        , ("name", Jenc.string x.name)
        , ("in", encodeIn x.parameterIn)
        , ("type", encodeFormatEnum x.parameterType)
        , ("required", Jenc.bool x.required)
        ]

purpleIn : Jdec.Decoder In
purpleIn =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "query" -> Jdec.succeed Query
                somethingElse -> Jdec.fail <| "Invalid In: " ++ somethingElse
        )

encodeIn : In -> Jenc.Value
encodeIn x = case x of
    Query -> Jenc.string "query"

purpleResponses : Jdec.Decoder PurpleResponses
purpleResponses =
    Jdec.succeed PurpleResponses
        |> Jpipe.required "200" purple200

encodePurpleResponses : PurpleResponses -> Jenc.Value
encodePurpleResponses x =
    Jenc.object
        [ ("200", encodePurple200 x.the200)
        ]

purple200 : Jdec.Decoder Purple200
purple200 =
    Jdec.succeed Purple200
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "schema" itemsClass

encodePurple200 : Purple200 -> Jenc.Value
encodePurple200 x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("schema", encodeItemsClass x.schema)
        ]

itemsClass : Jdec.Decoder ItemsClass
itemsClass =
    Jdec.succeed ItemsClass
        |> Jpipe.required "$ref" Jdec.string

encodeItemsClass : ItemsClass -> Jenc.Value
encodeItemsClass x =
    Jenc.object
        [ ("$ref", Jenc.string x.ref)
        ]

consolidatedScreeningListSearchClass : Jdec.Decoder ConsolidatedScreeningListSearchClass
consolidatedScreeningListSearchClass =
    Jdec.succeed ConsolidatedScreeningListSearchClass
        |> Jpipe.required "get" consolidatedScreeningListSearchGet

encodeConsolidatedScreeningListSearchClass : ConsolidatedScreeningListSearchClass -> Jenc.Value
encodeConsolidatedScreeningListSearchClass x =
    Jenc.object
        [ ("get", encodeConsolidatedScreeningListSearchGet x.get)
        ]

consolidatedScreeningListSearchGet : Jdec.Decoder ConsolidatedScreeningListSearchGet
consolidatedScreeningListSearchGet =
    Jdec.succeed ConsolidatedScreeningListSearchGet
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "parameters" (Jdec.list parameter )
        |> Jpipe.required "responses" fluffyResponses
        |> Jpipe.required "summary" Jdec.string
        |> Jpipe.required "tags" (Jdec.list Jdec.string )

encodeConsolidatedScreeningListSearchGet : ConsolidatedScreeningListSearchGet -> Jenc.Value
encodeConsolidatedScreeningListSearchGet x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("parameters", Jenc.list encodeParameter x.parameters)
        , ("responses", encodeFluffyResponses x.responses)
        , ("summary", Jenc.string x.summary)
        , ("tags", Jenc.list Jenc.string x.tags)
        ]

fluffyResponses : Jdec.Decoder FluffyResponses
fluffyResponses =
    Jdec.succeed FluffyResponses
        |> Jpipe.required "200" fluffy200

encodeFluffyResponses : FluffyResponses -> Jenc.Value
encodeFluffyResponses x =
    Jenc.object
        [ ("200", encodeFluffy200 x.the200)
        ]

fluffy200 : Jdec.Decoder Fluffy200
fluffy200 =
    Jdec.succeed Fluffy200
        |> Jpipe.required "description" Jdec.string
        |> Jpipe.required "schema" purpleSchema

encodeFluffy200 : Fluffy200 -> Jenc.Value
encodeFluffy200 x =
    Jenc.object
        [ ("description", Jenc.string x.description)
        , ("schema", encodePurpleSchema x.schema)
        ]

purpleSchema : Jdec.Decoder PurpleSchema
purpleSchema =
    Jdec.succeed PurpleSchema
        |> Jpipe.required "items" itemsClass
        |> Jpipe.required "type" schemaType

encodePurpleSchema : PurpleSchema -> Jenc.Value
encodePurpleSchema x =
    Jenc.object
        [ ("items", encodeItemsClass x.items)
        , ("type", encodeSchemaType x.schemaType)
        ]

schemaType : Jdec.Decoder SchemaType
schemaType =
    Jdec.string
        |> Jdec.andThen (\str ->
            case str of
                "array" -> Jdec.succeed TypeArray
                somethingElse -> Jdec.fail <| "Invalid SchemaType: " ++ somethingElse
        )

encodeSchemaType : SchemaType -> Jenc.Value
encodeSchemaType x = case x of
    TypeArray -> Jenc.string "array"

--- encoder helpers

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
