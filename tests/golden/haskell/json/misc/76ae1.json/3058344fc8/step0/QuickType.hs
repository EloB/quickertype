{-# LANGUAGE StrictData #-}
{-# LANGUAGE OverloadedStrings #-}

module QuickType
    ( QuickType (..)
    , Definitions (..)
    , Article (..)
    , Property (..)
    , DeMinimis (..)
    , DeMinimisProperties (..)
    , FAQ (..)
    , FAQProperties (..)
    , Report (..)
    , ReportProperties (..)
    , Taxonomy (..)
    , TaxonomyProperties (..)
    , Info (..)
    , Paths (..)
    , BusinessServiceProvidersSearchClass (..)
    , BusinessServiceProvidersSearchGet (..)
    , Parameter (..)
    , PurpleResponses (..)
    , Purple200 (..)
    , ItemsClass (..)
    , ConsolidatedScreeningListSearchClass (..)
    , ConsolidatedScreeningListSearchGet (..)
    , FluffyResponses (..)
    , Fluffy200 (..)
    , PurpleSchema (..)
    , FormatEnum (..)
    , In (..)
    , SchemaType (..)
    , decodeTopLevel
    ) where

import Data.Aeson
import Data.Aeson.Types (emptyObject)
import Data.ByteString.Lazy (ByteString)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

data QuickType = QuickType
    { basePathQuickType :: Text
    , definitionsQuickType :: Definitions
    , hostQuickType :: Text
    , infoQuickType :: Info
    , pathsQuickType :: Paths
    , producesQuickType :: [Text]
    , schemesQuickType :: [Text]
    , swaggerQuickType :: Text
    } deriving (Show)

data Definitions = Definitions
    { articleDefinitions :: Article
    , centerDefinitions :: Article
    , deMinimisDefinitions :: DeMinimis
    , eventDefinitions :: Article
    , faqDefinitions :: FAQ
    , leadDefinitions :: Article
    , listDefinitions :: Article
    , marketIntelligenceDefinitions :: Article
    , officeDefinitions :: Article
    , providerDefinitions :: Article
    , rateDefinitions :: Article
    , reportDefinitions :: Report
    , taxonomyDefinitions :: Taxonomy
    } deriving (Show)

data Article = Article
    { propertiesArticle :: HashMap Text Property
    } deriving (Show)

data Property = Property
    { descriptionProperty :: Text
    , propertyTypeProperty :: FormatEnum
    } deriving (Show)

data FormatEnum
    = StringFormatEnum
    deriving (Show)

data DeMinimis = DeMinimis
    { propertiesDeMinimis :: DeMinimisProperties
    } deriving (Show)

data DeMinimisProperties = DeMinimisProperties
    { countriesDeMinimisProperties :: Property
    , countryDeMinimisProperties :: Property
    , deMinimisCurrencyDeMinimisProperties :: Property
    , deMinimisValueDeMinimisProperties :: Property
    , notesDeMinimisProperties :: Property
    , vatAmountDeMinimisProperties :: Property
    , vatCurrencyDeMinimisProperties :: Property
    } deriving (Show)

data FAQ = FAQ
    { propertiesFAQ :: FAQProperties
    } deriving (Show)

data FAQProperties = FAQProperties
    { answerFAQProperties :: Property
    , countriesFAQProperties :: Property
    , firstPublishedDateFAQProperties :: Property
    , industriesFAQProperties :: Property
    , lastPublishedDateFAQProperties :: Property
    , propertiesIDFAQProperties :: Property
    , questionFAQProperties :: Property
    , topicsFAQProperties :: Property
    , tradeRegionsFAQProperties :: Property
    , urlFAQProperties :: Property
    , worldRegionsFAQProperties :: Property
    } deriving (Show)

data Report = Report
    { propertiesReport :: ReportProperties
    } deriving (Show)

data ReportProperties = ReportProperties
    { countriesReportProperties :: Property
    , descriptionReportProperties :: Property
    , expirationDateReportProperties :: Property
    , industriesReportProperties :: Property
    , itaIndustriesReportProperties :: Property
    , propertiesIDReportProperties :: Property
    , reportTypeReportProperties :: Property
    , titleReportProperties :: Property
    , urlReportProperties :: Property
    } deriving (Show)

data Taxonomy = Taxonomy
    { propertiesTaxonomy :: TaxonomyProperties
    } deriving (Show)

data TaxonomyProperties = TaxonomyProperties
    { annotationsTaxonomyProperties :: Property
    , datatypePropertiesTaxonomyProperties :: Property
    , labelTaxonomyProperties :: Property
    , propertiesIDTaxonomyProperties :: Property
    , propertiesTypeTaxonomyProperties :: Property
    , subClassOfTaxonomyProperties :: Property
    } deriving (Show)

data Info = Info
    { descriptionInfo :: Text
    , titleInfo :: Text
    , versionInfo :: Text
    } deriving (Show)

data Paths = Paths
    { businessServiceProvidersSearchPaths :: BusinessServiceProvidersSearchClass
    , consolidatedScreeningListSearchPaths :: ConsolidatedScreeningListSearchClass
    , deMinimisSearchPaths :: ConsolidatedScreeningListSearchClass
    , itaFaqsSearchPaths :: ConsolidatedScreeningListSearchClass
    , itaOfficeLocationsSearchPaths :: ConsolidatedScreeningListSearchClass
    , itaTaxonomiesSearchPaths :: BusinessServiceProvidersSearchClass
    , itaZipcodeToPostSearchPaths :: BusinessServiceProvidersSearchClass
    , marketIntelligenceSearchPaths :: ConsolidatedScreeningListSearchClass
    , marketResearchLibrarySearchPaths :: ConsolidatedScreeningListSearchClass
    , tariffRatesSearchPaths :: ConsolidatedScreeningListSearchClass
    , tradeArticlesSearchPaths :: ConsolidatedScreeningListSearchClass
    , tradeEventsSearchPaths :: ConsolidatedScreeningListSearchClass
    , tradeLeadsSearchPaths :: ConsolidatedScreeningListSearchClass
    } deriving (Show)

data BusinessServiceProvidersSearchClass = BusinessServiceProvidersSearchClass
    { getBusinessServiceProvidersSearchClass :: BusinessServiceProvidersSearchGet
    } deriving (Show)

data BusinessServiceProvidersSearchGet = BusinessServiceProvidersSearchGet
    { descriptionBusinessServiceProvidersSearchGet :: Text
    , parametersBusinessServiceProvidersSearchGet :: [Parameter]
    , responsesBusinessServiceProvidersSearchGet :: PurpleResponses
    , summaryBusinessServiceProvidersSearchGet :: Text
    , tagsBusinessServiceProvidersSearchGet :: [Text]
    } deriving (Show)

data Parameter = Parameter
    { descriptionParameter :: Text
    , formatParameter :: FormatEnum
    , nameParameter :: Text
    , parameterInParameter :: In
    , parameterTypeParameter :: FormatEnum
    , requiredParameter :: Bool
    } deriving (Show)

data In
    = QueryIn
    deriving (Show)

data PurpleResponses = PurpleResponses
    { the200PurpleResponses :: Purple200
    } deriving (Show)

data Purple200 = Purple200
    { descriptionPurple200 :: Text
    , schemaPurple200 :: ItemsClass
    } deriving (Show)

data ItemsClass = ItemsClass
    { refItemsClass :: Text
    } deriving (Show)

data ConsolidatedScreeningListSearchClass = ConsolidatedScreeningListSearchClass
    { getConsolidatedScreeningListSearchClass :: ConsolidatedScreeningListSearchGet
    } deriving (Show)

data ConsolidatedScreeningListSearchGet = ConsolidatedScreeningListSearchGet
    { descriptionConsolidatedScreeningListSearchGet :: Text
    , parametersConsolidatedScreeningListSearchGet :: [Parameter]
    , responsesConsolidatedScreeningListSearchGet :: FluffyResponses
    , summaryConsolidatedScreeningListSearchGet :: Text
    , tagsConsolidatedScreeningListSearchGet :: [Text]
    } deriving (Show)

data FluffyResponses = FluffyResponses
    { the200FluffyResponses :: Fluffy200
    } deriving (Show)

data Fluffy200 = Fluffy200
    { descriptionFluffy200 :: Text
    , schemaFluffy200 :: PurpleSchema
    } deriving (Show)

data PurpleSchema = PurpleSchema
    { itemsPurpleSchema :: ItemsClass
    , schemaTypePurpleSchema :: SchemaType
    } deriving (Show)

data SchemaType
    = ArraySchemaType
    deriving (Show)

decodeTopLevel :: ByteString -> Maybe QuickType
decodeTopLevel = decode

instance ToJSON QuickType where
    toJSON (QuickType basePathQuickType definitionsQuickType hostQuickType infoQuickType pathsQuickType producesQuickType schemesQuickType swaggerQuickType) =
        object $ foldMap (maybe [] pure)
        [ Just $ "basePath" .= basePathQuickType
        , Just $ "definitions" .= definitionsQuickType
        , Just $ "host" .= hostQuickType
        , Just $ "info" .= infoQuickType
        , Just $ "paths" .= pathsQuickType
        , Just $ "produces" .= producesQuickType
        , Just $ "schemes" .= schemesQuickType
        , Just $ "swagger" .= swaggerQuickType
        ]

instance FromJSON QuickType where
    parseJSON (Object v) = QuickType
        <$> v .: "basePath"
        <*> v .: "definitions"
        <*> v .: "host"
        <*> v .: "info"
        <*> v .: "paths"
        <*> v .: "produces"
        <*> v .: "schemes"
        <*> v .: "swagger"

instance ToJSON Definitions where
    toJSON (Definitions articleDefinitions centerDefinitions deMinimisDefinitions eventDefinitions faqDefinitions leadDefinitions listDefinitions marketIntelligenceDefinitions officeDefinitions providerDefinitions rateDefinitions reportDefinitions taxonomyDefinitions) =
        object $ foldMap (maybe [] pure)
        [ Just $ "Article" .= articleDefinitions
        , Just $ "Center" .= centerDefinitions
        , Just $ "DeMinimis" .= deMinimisDefinitions
        , Just $ "Event" .= eventDefinitions
        , Just $ "FAQ" .= faqDefinitions
        , Just $ "Lead" .= leadDefinitions
        , Just $ "List" .= listDefinitions
        , Just $ "MarketIntelligence" .= marketIntelligenceDefinitions
        , Just $ "Office" .= officeDefinitions
        , Just $ "Provider" .= providerDefinitions
        , Just $ "Rate" .= rateDefinitions
        , Just $ "Report" .= reportDefinitions
        , Just $ "Taxonomy" .= taxonomyDefinitions
        ]

instance FromJSON Definitions where
    parseJSON (Object v) = Definitions
        <$> v .: "Article"
        <*> v .: "Center"
        <*> v .: "DeMinimis"
        <*> v .: "Event"
        <*> v .: "FAQ"
        <*> v .: "Lead"
        <*> v .: "List"
        <*> v .: "MarketIntelligence"
        <*> v .: "Office"
        <*> v .: "Provider"
        <*> v .: "Rate"
        <*> v .: "Report"
        <*> v .: "Taxonomy"

instance ToJSON Article where
    toJSON (Article propertiesArticle) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesArticle
        ]

instance FromJSON Article where
    parseJSON (Object v) = Article
        <$> v .: "properties"

instance ToJSON Property where
    toJSON (Property descriptionProperty propertyTypeProperty) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionProperty
        , Just $ "type" .= propertyTypeProperty
        ]

instance FromJSON Property where
    parseJSON (Object v) = Property
        <$> v .: "description"
        <*> v .: "type"

instance ToJSON FormatEnum where
    toJSON StringFormatEnum = "string"

instance FromJSON FormatEnum where
    parseJSON = withText "FormatEnum" parseText
        where
            parseText "string" = return StringFormatEnum

instance ToJSON DeMinimis where
    toJSON (DeMinimis propertiesDeMinimis) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesDeMinimis
        ]

instance FromJSON DeMinimis where
    parseJSON (Object v) = DeMinimis
        <$> v .: "properties"

instance ToJSON DeMinimisProperties where
    toJSON (DeMinimisProperties countriesDeMinimisProperties countryDeMinimisProperties deMinimisCurrencyDeMinimisProperties deMinimisValueDeMinimisProperties notesDeMinimisProperties vatAmountDeMinimisProperties vatCurrencyDeMinimisProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "countries" .= countriesDeMinimisProperties
        , Just $ "country" .= countryDeMinimisProperties
        , Just $ "de_minimis_currency" .= deMinimisCurrencyDeMinimisProperties
        , Just $ "de_minimis_value" .= deMinimisValueDeMinimisProperties
        , Just $ "notes" .= notesDeMinimisProperties
        , Just $ "vat_amount" .= vatAmountDeMinimisProperties
        , Just $ "vat_currency" .= vatCurrencyDeMinimisProperties
        ]

instance FromJSON DeMinimisProperties where
    parseJSON (Object v) = DeMinimisProperties
        <$> v .: "countries"
        <*> v .: "country"
        <*> v .: "de_minimis_currency"
        <*> v .: "de_minimis_value"
        <*> v .: "notes"
        <*> v .: "vat_amount"
        <*> v .: "vat_currency"

instance ToJSON FAQ where
    toJSON (FAQ propertiesFAQ) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesFAQ
        ]

instance FromJSON FAQ where
    parseJSON (Object v) = FAQ
        <$> v .: "properties"

instance ToJSON FAQProperties where
    toJSON (FAQProperties answerFAQProperties countriesFAQProperties firstPublishedDateFAQProperties industriesFAQProperties lastPublishedDateFAQProperties propertiesIDFAQProperties questionFAQProperties topicsFAQProperties tradeRegionsFAQProperties urlFAQProperties worldRegionsFAQProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "answer" .= answerFAQProperties
        , Just $ "countries" .= countriesFAQProperties
        , Just $ "first_published_date" .= firstPublishedDateFAQProperties
        , Just $ "industries" .= industriesFAQProperties
        , Just $ "last_published_date" .= lastPublishedDateFAQProperties
        , Just $ "id" .= propertiesIDFAQProperties
        , Just $ "question" .= questionFAQProperties
        , Just $ "topics" .= topicsFAQProperties
        , Just $ "trade_regions" .= tradeRegionsFAQProperties
        , Just $ "url" .= urlFAQProperties
        , Just $ "world_regions" .= worldRegionsFAQProperties
        ]

instance FromJSON FAQProperties where
    parseJSON (Object v) = FAQProperties
        <$> v .: "answer"
        <*> v .: "countries"
        <*> v .: "first_published_date"
        <*> v .: "industries"
        <*> v .: "last_published_date"
        <*> v .: "id"
        <*> v .: "question"
        <*> v .: "topics"
        <*> v .: "trade_regions"
        <*> v .: "url"
        <*> v .: "world_regions"

instance ToJSON Report where
    toJSON (Report propertiesReport) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesReport
        ]

instance FromJSON Report where
    parseJSON (Object v) = Report
        <$> v .: "properties"

instance ToJSON ReportProperties where
    toJSON (ReportProperties countriesReportProperties descriptionReportProperties expirationDateReportProperties industriesReportProperties itaIndustriesReportProperties propertiesIDReportProperties reportTypeReportProperties titleReportProperties urlReportProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "countries" .= countriesReportProperties
        , Just $ "description" .= descriptionReportProperties
        , Just $ "expiration_date" .= expirationDateReportProperties
        , Just $ "industries" .= industriesReportProperties
        , Just $ "ita_industries" .= itaIndustriesReportProperties
        , Just $ "id" .= propertiesIDReportProperties
        , Just $ "report_type" .= reportTypeReportProperties
        , Just $ "title" .= titleReportProperties
        , Just $ "url" .= urlReportProperties
        ]

instance FromJSON ReportProperties where
    parseJSON (Object v) = ReportProperties
        <$> v .: "countries"
        <*> v .: "description"
        <*> v .: "expiration_date"
        <*> v .: "industries"
        <*> v .: "ita_industries"
        <*> v .: "id"
        <*> v .: "report_type"
        <*> v .: "title"
        <*> v .: "url"

instance ToJSON Taxonomy where
    toJSON (Taxonomy propertiesTaxonomy) =
        object $ foldMap (maybe [] pure)
        [ Just $ "properties" .= propertiesTaxonomy
        ]

instance FromJSON Taxonomy where
    parseJSON (Object v) = Taxonomy
        <$> v .: "properties"

instance ToJSON TaxonomyProperties where
    toJSON (TaxonomyProperties annotationsTaxonomyProperties datatypePropertiesTaxonomyProperties labelTaxonomyProperties propertiesIDTaxonomyProperties propertiesTypeTaxonomyProperties subClassOfTaxonomyProperties) =
        object $ foldMap (maybe [] pure)
        [ Just $ "annotations" .= annotationsTaxonomyProperties
        , Just $ "datatype_properties" .= datatypePropertiesTaxonomyProperties
        , Just $ "label" .= labelTaxonomyProperties
        , Just $ "id" .= propertiesIDTaxonomyProperties
        , Just $ "type" .= propertiesTypeTaxonomyProperties
        , Just $ "sub_class_of" .= subClassOfTaxonomyProperties
        ]

instance FromJSON TaxonomyProperties where
    parseJSON (Object v) = TaxonomyProperties
        <$> v .: "annotations"
        <*> v .: "datatype_properties"
        <*> v .: "label"
        <*> v .: "id"
        <*> v .: "type"
        <*> v .: "sub_class_of"

instance ToJSON Info where
    toJSON (Info descriptionInfo titleInfo versionInfo) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionInfo
        , Just $ "title" .= titleInfo
        , Just $ "version" .= versionInfo
        ]

instance FromJSON Info where
    parseJSON (Object v) = Info
        <$> v .: "description"
        <*> v .: "title"
        <*> v .: "version"

instance ToJSON Paths where
    toJSON (Paths businessServiceProvidersSearchPaths consolidatedScreeningListSearchPaths deMinimisSearchPaths itaFaqsSearchPaths itaOfficeLocationsSearchPaths itaTaxonomiesSearchPaths itaZipcodeToPostSearchPaths marketIntelligenceSearchPaths marketResearchLibrarySearchPaths tariffRatesSearchPaths tradeArticlesSearchPaths tradeEventsSearchPaths tradeLeadsSearchPaths) =
        object $ foldMap (maybe [] pure)
        [ Just $ "/business_service_providers/search" .= businessServiceProvidersSearchPaths
        , Just $ "/consolidated_screening_list/search" .= consolidatedScreeningListSearchPaths
        , Just $ "/de_minimis/search" .= deMinimisSearchPaths
        , Just $ "/ita_faqs/search" .= itaFaqsSearchPaths
        , Just $ "/ita_office_locations/search" .= itaOfficeLocationsSearchPaths
        , Just $ "/ita_taxonomies/search" .= itaTaxonomiesSearchPaths
        , Just $ "/ita_zipcode_to_post/search" .= itaZipcodeToPostSearchPaths
        , Just $ "/market_intelligence/search" .= marketIntelligenceSearchPaths
        , Just $ "/market_research_library/search" .= marketResearchLibrarySearchPaths
        , Just $ "/tariff_rates/search" .= tariffRatesSearchPaths
        , Just $ "/trade_articles/search" .= tradeArticlesSearchPaths
        , Just $ "/trade_events/search" .= tradeEventsSearchPaths
        , Just $ "/trade_leads/search" .= tradeLeadsSearchPaths
        ]

instance FromJSON Paths where
    parseJSON (Object v) = Paths
        <$> v .: "/business_service_providers/search"
        <*> v .: "/consolidated_screening_list/search"
        <*> v .: "/de_minimis/search"
        <*> v .: "/ita_faqs/search"
        <*> v .: "/ita_office_locations/search"
        <*> v .: "/ita_taxonomies/search"
        <*> v .: "/ita_zipcode_to_post/search"
        <*> v .: "/market_intelligence/search"
        <*> v .: "/market_research_library/search"
        <*> v .: "/tariff_rates/search"
        <*> v .: "/trade_articles/search"
        <*> v .: "/trade_events/search"
        <*> v .: "/trade_leads/search"

instance ToJSON BusinessServiceProvidersSearchClass where
    toJSON (BusinessServiceProvidersSearchClass getBusinessServiceProvidersSearchClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "get" .= getBusinessServiceProvidersSearchClass
        ]

instance FromJSON BusinessServiceProvidersSearchClass where
    parseJSON (Object v) = BusinessServiceProvidersSearchClass
        <$> v .: "get"

instance ToJSON BusinessServiceProvidersSearchGet where
    toJSON (BusinessServiceProvidersSearchGet descriptionBusinessServiceProvidersSearchGet parametersBusinessServiceProvidersSearchGet responsesBusinessServiceProvidersSearchGet summaryBusinessServiceProvidersSearchGet tagsBusinessServiceProvidersSearchGet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionBusinessServiceProvidersSearchGet
        , Just $ "parameters" .= parametersBusinessServiceProvidersSearchGet
        , Just $ "responses" .= responsesBusinessServiceProvidersSearchGet
        , Just $ "summary" .= summaryBusinessServiceProvidersSearchGet
        , Just $ "tags" .= tagsBusinessServiceProvidersSearchGet
        ]

instance FromJSON BusinessServiceProvidersSearchGet where
    parseJSON (Object v) = BusinessServiceProvidersSearchGet
        <$> v .: "description"
        <*> v .: "parameters"
        <*> v .: "responses"
        <*> v .: "summary"
        <*> v .: "tags"

instance ToJSON Parameter where
    toJSON (Parameter descriptionParameter formatParameter nameParameter parameterInParameter parameterTypeParameter requiredParameter) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionParameter
        , Just $ "format" .= formatParameter
        , Just $ "name" .= nameParameter
        , Just $ "in" .= parameterInParameter
        , Just $ "type" .= parameterTypeParameter
        , Just $ "required" .= requiredParameter
        ]

instance FromJSON Parameter where
    parseJSON (Object v) = Parameter
        <$> v .: "description"
        <*> v .: "format"
        <*> v .: "name"
        <*> v .: "in"
        <*> v .: "type"
        <*> v .: "required"

instance ToJSON In where
    toJSON QueryIn = "query"

instance FromJSON In where
    parseJSON = withText "In" parseText
        where
            parseText "query" = return QueryIn

instance ToJSON PurpleResponses where
    toJSON (PurpleResponses the200PurpleResponses) =
        object $ foldMap (maybe [] pure)
        [ Just $ "200" .= the200PurpleResponses
        ]

instance FromJSON PurpleResponses where
    parseJSON (Object v) = PurpleResponses
        <$> v .: "200"

instance ToJSON Purple200 where
    toJSON (Purple200 descriptionPurple200 schemaPurple200) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionPurple200
        , Just $ "schema" .= schemaPurple200
        ]

instance FromJSON Purple200 where
    parseJSON (Object v) = Purple200
        <$> v .: "description"
        <*> v .: "schema"

instance ToJSON ItemsClass where
    toJSON (ItemsClass refItemsClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "$ref" .= refItemsClass
        ]

instance FromJSON ItemsClass where
    parseJSON (Object v) = ItemsClass
        <$> v .: "$ref"

instance ToJSON ConsolidatedScreeningListSearchClass where
    toJSON (ConsolidatedScreeningListSearchClass getConsolidatedScreeningListSearchClass) =
        object $ foldMap (maybe [] pure)
        [ Just $ "get" .= getConsolidatedScreeningListSearchClass
        ]

instance FromJSON ConsolidatedScreeningListSearchClass where
    parseJSON (Object v) = ConsolidatedScreeningListSearchClass
        <$> v .: "get"

instance ToJSON ConsolidatedScreeningListSearchGet where
    toJSON (ConsolidatedScreeningListSearchGet descriptionConsolidatedScreeningListSearchGet parametersConsolidatedScreeningListSearchGet responsesConsolidatedScreeningListSearchGet summaryConsolidatedScreeningListSearchGet tagsConsolidatedScreeningListSearchGet) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionConsolidatedScreeningListSearchGet
        , Just $ "parameters" .= parametersConsolidatedScreeningListSearchGet
        , Just $ "responses" .= responsesConsolidatedScreeningListSearchGet
        , Just $ "summary" .= summaryConsolidatedScreeningListSearchGet
        , Just $ "tags" .= tagsConsolidatedScreeningListSearchGet
        ]

instance FromJSON ConsolidatedScreeningListSearchGet where
    parseJSON (Object v) = ConsolidatedScreeningListSearchGet
        <$> v .: "description"
        <*> v .: "parameters"
        <*> v .: "responses"
        <*> v .: "summary"
        <*> v .: "tags"

instance ToJSON FluffyResponses where
    toJSON (FluffyResponses the200FluffyResponses) =
        object $ foldMap (maybe [] pure)
        [ Just $ "200" .= the200FluffyResponses
        ]

instance FromJSON FluffyResponses where
    parseJSON (Object v) = FluffyResponses
        <$> v .: "200"

instance ToJSON Fluffy200 where
    toJSON (Fluffy200 descriptionFluffy200 schemaFluffy200) =
        object $ foldMap (maybe [] pure)
        [ Just $ "description" .= descriptionFluffy200
        , Just $ "schema" .= schemaFluffy200
        ]

instance FromJSON Fluffy200 where
    parseJSON (Object v) = Fluffy200
        <$> v .: "description"
        <*> v .: "schema"

instance ToJSON PurpleSchema where
    toJSON (PurpleSchema itemsPurpleSchema schemaTypePurpleSchema) =
        object $ foldMap (maybe [] pure)
        [ Just $ "items" .= itemsPurpleSchema
        , Just $ "type" .= schemaTypePurpleSchema
        ]

instance FromJSON PurpleSchema where
    parseJSON (Object v) = PurpleSchema
        <$> v .: "items"
        <*> v .: "type"

instance ToJSON SchemaType where
    toJSON ArraySchemaType = "array"

instance FromJSON SchemaType where
    parseJSON = withText "SchemaType" parseText
        where
            parseText "array" = return ArraySchemaType
