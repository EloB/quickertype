//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

namespace quicktype {
    using nlohmann::json;

    #ifndef NLOHMANN_UNTYPED_quicktype_HELPER
    #define NLOHMANN_UNTYPED_quicktype_HELPER
    inline json get_untyped(const json & j, const char * property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }

    inline json get_untyped(const json & j, std::string property) {
        return get_untyped(j, property.data());
    }
    #endif

    enum class FormatEnum : int { STRING };

    class Property {
        public:
        Property() = default;
        virtual ~Property() = default;

        private:
        std::string description;
        FormatEnum type;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const FormatEnum & get_type() const { return type; }
        FormatEnum & get_mutable_type() { return type; }
        void set_type(const FormatEnum & value) { this->type = value; }
    };

    class Article {
        public:
        Article() = default;
        virtual ~Article() = default;

        private:
        std::map<std::string, Property> properties;

        public:
        const std::map<std::string, Property> & get_properties() const { return properties; }
        std::map<std::string, Property> & get_mutable_properties() { return properties; }
        void set_properties(const std::map<std::string, Property> & value) { this->properties = value; }
    };

    class DeMinimisProperties {
        public:
        DeMinimisProperties() = default;
        virtual ~DeMinimisProperties() = default;

        private:
        Property countries;
        Property country;
        Property de_minimis_currency;
        Property de_minimis_value;
        Property notes;
        Property vat_amount;
        Property vat_currency;

        public:
        const Property & get_countries() const { return countries; }
        Property & get_mutable_countries() { return countries; }
        void set_countries(const Property & value) { this->countries = value; }

        const Property & get_country() const { return country; }
        Property & get_mutable_country() { return country; }
        void set_country(const Property & value) { this->country = value; }

        const Property & get_de_minimis_currency() const { return de_minimis_currency; }
        Property & get_mutable_de_minimis_currency() { return de_minimis_currency; }
        void set_de_minimis_currency(const Property & value) { this->de_minimis_currency = value; }

        const Property & get_de_minimis_value() const { return de_minimis_value; }
        Property & get_mutable_de_minimis_value() { return de_minimis_value; }
        void set_de_minimis_value(const Property & value) { this->de_minimis_value = value; }

        const Property & get_notes() const { return notes; }
        Property & get_mutable_notes() { return notes; }
        void set_notes(const Property & value) { this->notes = value; }

        const Property & get_vat_amount() const { return vat_amount; }
        Property & get_mutable_vat_amount() { return vat_amount; }
        void set_vat_amount(const Property & value) { this->vat_amount = value; }

        const Property & get_vat_currency() const { return vat_currency; }
        Property & get_mutable_vat_currency() { return vat_currency; }
        void set_vat_currency(const Property & value) { this->vat_currency = value; }
    };

    class DeMinimis {
        public:
        DeMinimis() = default;
        virtual ~DeMinimis() = default;

        private:
        DeMinimisProperties properties;

        public:
        const DeMinimisProperties & get_properties() const { return properties; }
        DeMinimisProperties & get_mutable_properties() { return properties; }
        void set_properties(const DeMinimisProperties & value) { this->properties = value; }
    };

    class FaqProperties {
        public:
        FaqProperties() = default;
        virtual ~FaqProperties() = default;

        private:
        Property answer;
        Property countries;
        Property first_published_date;
        Property id;
        Property industries;
        Property last_published_date;
        Property question;
        Property topics;
        Property trade_regions;
        Property url;
        Property world_regions;

        public:
        const Property & get_answer() const { return answer; }
        Property & get_mutable_answer() { return answer; }
        void set_answer(const Property & value) { this->answer = value; }

        const Property & get_countries() const { return countries; }
        Property & get_mutable_countries() { return countries; }
        void set_countries(const Property & value) { this->countries = value; }

        const Property & get_first_published_date() const { return first_published_date; }
        Property & get_mutable_first_published_date() { return first_published_date; }
        void set_first_published_date(const Property & value) { this->first_published_date = value; }

        const Property & get_id() const { return id; }
        Property & get_mutable_id() { return id; }
        void set_id(const Property & value) { this->id = value; }

        const Property & get_industries() const { return industries; }
        Property & get_mutable_industries() { return industries; }
        void set_industries(const Property & value) { this->industries = value; }

        const Property & get_last_published_date() const { return last_published_date; }
        Property & get_mutable_last_published_date() { return last_published_date; }
        void set_last_published_date(const Property & value) { this->last_published_date = value; }

        const Property & get_question() const { return question; }
        Property & get_mutable_question() { return question; }
        void set_question(const Property & value) { this->question = value; }

        const Property & get_topics() const { return topics; }
        Property & get_mutable_topics() { return topics; }
        void set_topics(const Property & value) { this->topics = value; }

        const Property & get_trade_regions() const { return trade_regions; }
        Property & get_mutable_trade_regions() { return trade_regions; }
        void set_trade_regions(const Property & value) { this->trade_regions = value; }

        const Property & get_url() const { return url; }
        Property & get_mutable_url() { return url; }
        void set_url(const Property & value) { this->url = value; }

        const Property & get_world_regions() const { return world_regions; }
        Property & get_mutable_world_regions() { return world_regions; }
        void set_world_regions(const Property & value) { this->world_regions = value; }
    };

    class Faq {
        public:
        Faq() = default;
        virtual ~Faq() = default;

        private:
        FaqProperties properties;

        public:
        const FaqProperties & get_properties() const { return properties; }
        FaqProperties & get_mutable_properties() { return properties; }
        void set_properties(const FaqProperties & value) { this->properties = value; }
    };

    class ReportProperties {
        public:
        ReportProperties() = default;
        virtual ~ReportProperties() = default;

        private:
        Property countries;
        Property description;
        Property expiration_date;
        Property id;
        Property industries;
        Property ita_industries;
        Property report_type;
        Property title;
        Property url;

        public:
        const Property & get_countries() const { return countries; }
        Property & get_mutable_countries() { return countries; }
        void set_countries(const Property & value) { this->countries = value; }

        const Property & get_description() const { return description; }
        Property & get_mutable_description() { return description; }
        void set_description(const Property & value) { this->description = value; }

        const Property & get_expiration_date() const { return expiration_date; }
        Property & get_mutable_expiration_date() { return expiration_date; }
        void set_expiration_date(const Property & value) { this->expiration_date = value; }

        const Property & get_id() const { return id; }
        Property & get_mutable_id() { return id; }
        void set_id(const Property & value) { this->id = value; }

        const Property & get_industries() const { return industries; }
        Property & get_mutable_industries() { return industries; }
        void set_industries(const Property & value) { this->industries = value; }

        const Property & get_ita_industries() const { return ita_industries; }
        Property & get_mutable_ita_industries() { return ita_industries; }
        void set_ita_industries(const Property & value) { this->ita_industries = value; }

        const Property & get_report_type() const { return report_type; }
        Property & get_mutable_report_type() { return report_type; }
        void set_report_type(const Property & value) { this->report_type = value; }

        const Property & get_title() const { return title; }
        Property & get_mutable_title() { return title; }
        void set_title(const Property & value) { this->title = value; }

        const Property & get_url() const { return url; }
        Property & get_mutable_url() { return url; }
        void set_url(const Property & value) { this->url = value; }
    };

    class Report {
        public:
        Report() = default;
        virtual ~Report() = default;

        private:
        ReportProperties properties;

        public:
        const ReportProperties & get_properties() const { return properties; }
        ReportProperties & get_mutable_properties() { return properties; }
        void set_properties(const ReportProperties & value) { this->properties = value; }
    };

    class TaxonomyProperties {
        public:
        TaxonomyProperties() = default;
        virtual ~TaxonomyProperties() = default;

        private:
        Property annotations;
        Property datatype_properties;
        Property id;
        Property label;
        Property sub_class_of;
        Property type;

        public:
        const Property & get_annotations() const { return annotations; }
        Property & get_mutable_annotations() { return annotations; }
        void set_annotations(const Property & value) { this->annotations = value; }

        const Property & get_datatype_properties() const { return datatype_properties; }
        Property & get_mutable_datatype_properties() { return datatype_properties; }
        void set_datatype_properties(const Property & value) { this->datatype_properties = value; }

        const Property & get_id() const { return id; }
        Property & get_mutable_id() { return id; }
        void set_id(const Property & value) { this->id = value; }

        const Property & get_label() const { return label; }
        Property & get_mutable_label() { return label; }
        void set_label(const Property & value) { this->label = value; }

        const Property & get_sub_class_of() const { return sub_class_of; }
        Property & get_mutable_sub_class_of() { return sub_class_of; }
        void set_sub_class_of(const Property & value) { this->sub_class_of = value; }

        const Property & get_type() const { return type; }
        Property & get_mutable_type() { return type; }
        void set_type(const Property & value) { this->type = value; }
    };

    class Taxonomy {
        public:
        Taxonomy() = default;
        virtual ~Taxonomy() = default;

        private:
        TaxonomyProperties properties;

        public:
        const TaxonomyProperties & get_properties() const { return properties; }
        TaxonomyProperties & get_mutable_properties() { return properties; }
        void set_properties(const TaxonomyProperties & value) { this->properties = value; }
    };

    class Definitions {
        public:
        Definitions() = default;
        virtual ~Definitions() = default;

        private:
        Article article;
        Article center;
        DeMinimis de_minimis;
        Article event;
        Faq faq;
        Article lead;
        Article list;
        Article market_intelligence;
        Article office;
        Article provider;
        Article rate;
        Report report;
        Taxonomy taxonomy;

        public:
        const Article & get_article() const { return article; }
        Article & get_mutable_article() { return article; }
        void set_article(const Article & value) { this->article = value; }

        const Article & get_center() const { return center; }
        Article & get_mutable_center() { return center; }
        void set_center(const Article & value) { this->center = value; }

        const DeMinimis & get_de_minimis() const { return de_minimis; }
        DeMinimis & get_mutable_de_minimis() { return de_minimis; }
        void set_de_minimis(const DeMinimis & value) { this->de_minimis = value; }

        const Article & get_event() const { return event; }
        Article & get_mutable_event() { return event; }
        void set_event(const Article & value) { this->event = value; }

        const Faq & get_faq() const { return faq; }
        Faq & get_mutable_faq() { return faq; }
        void set_faq(const Faq & value) { this->faq = value; }

        const Article & get_lead() const { return lead; }
        Article & get_mutable_lead() { return lead; }
        void set_lead(const Article & value) { this->lead = value; }

        const Article & get_list() const { return list; }
        Article & get_mutable_list() { return list; }
        void set_list(const Article & value) { this->list = value; }

        const Article & get_market_intelligence() const { return market_intelligence; }
        Article & get_mutable_market_intelligence() { return market_intelligence; }
        void set_market_intelligence(const Article & value) { this->market_intelligence = value; }

        const Article & get_office() const { return office; }
        Article & get_mutable_office() { return office; }
        void set_office(const Article & value) { this->office = value; }

        const Article & get_provider() const { return provider; }
        Article & get_mutable_provider() { return provider; }
        void set_provider(const Article & value) { this->provider = value; }

        const Article & get_rate() const { return rate; }
        Article & get_mutable_rate() { return rate; }
        void set_rate(const Article & value) { this->rate = value; }

        const Report & get_report() const { return report; }
        Report & get_mutable_report() { return report; }
        void set_report(const Report & value) { this->report = value; }

        const Taxonomy & get_taxonomy() const { return taxonomy; }
        Taxonomy & get_mutable_taxonomy() { return taxonomy; }
        void set_taxonomy(const Taxonomy & value) { this->taxonomy = value; }
    };

    class Info {
        public:
        Info() = default;
        virtual ~Info() = default;

        private:
        std::string description;
        std::string title;
        std::string version;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::string & get_version() const { return version; }
        std::string & get_mutable_version() { return version; }
        void set_version(const std::string & value) { this->version = value; }
    };

    enum class In : int { QUERY };

    class Parameter {
        public:
        Parameter() = default;
        virtual ~Parameter() = default;

        private:
        std::string description;
        FormatEnum format;
        In in;
        std::string name;
        bool required;
        FormatEnum type;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const FormatEnum & get_format() const { return format; }
        FormatEnum & get_mutable_format() { return format; }
        void set_format(const FormatEnum & value) { this->format = value; }

        const In & get_in() const { return in; }
        In & get_mutable_in() { return in; }
        void set_in(const In & value) { this->in = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const bool & get_required() const { return required; }
        bool & get_mutable_required() { return required; }
        void set_required(const bool & value) { this->required = value; }

        const FormatEnum & get_type() const { return type; }
        FormatEnum & get_mutable_type() { return type; }
        void set_type(const FormatEnum & value) { this->type = value; }
    };

    class ItemsClass {
        public:
        ItemsClass() = default;
        virtual ~ItemsClass() = default;

        private:
        std::string ref;

        public:
        const std::string & get_ref() const { return ref; }
        std::string & get_mutable_ref() { return ref; }
        void set_ref(const std::string & value) { this->ref = value; }
    };

    class Purple200 {
        public:
        Purple200() = default;
        virtual ~Purple200() = default;

        private:
        std::string description;
        ItemsClass schema;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const ItemsClass & get_schema() const { return schema; }
        ItemsClass & get_mutable_schema() { return schema; }
        void set_schema(const ItemsClass & value) { this->schema = value; }
    };

    class PurpleResponses {
        public:
        PurpleResponses() = default;
        virtual ~PurpleResponses() = default;

        private:
        Purple200 the_200;

        public:
        const Purple200 & get_the_200() const { return the_200; }
        Purple200 & get_mutable_the_200() { return the_200; }
        void set_the_200(const Purple200 & value) { this->the_200 = value; }
    };

    class BusinessServiceProvidersSearchGet {
        public:
        BusinessServiceProvidersSearchGet() = default;
        virtual ~BusinessServiceProvidersSearchGet() = default;

        private:
        std::string description;
        std::vector<Parameter> parameters;
        PurpleResponses responses;
        std::string summary;
        std::vector<std::string> tags;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const std::vector<Parameter> & get_parameters() const { return parameters; }
        std::vector<Parameter> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::vector<Parameter> & value) { this->parameters = value; }

        const PurpleResponses & get_responses() const { return responses; }
        PurpleResponses & get_mutable_responses() { return responses; }
        void set_responses(const PurpleResponses & value) { this->responses = value; }

        const std::string & get_summary() const { return summary; }
        std::string & get_mutable_summary() { return summary; }
        void set_summary(const std::string & value) { this->summary = value; }

        const std::vector<std::string> & get_tags() const { return tags; }
        std::vector<std::string> & get_mutable_tags() { return tags; }
        void set_tags(const std::vector<std::string> & value) { this->tags = value; }
    };

    class BusinessServiceProvidersSearchClass {
        public:
        BusinessServiceProvidersSearchClass() = default;
        virtual ~BusinessServiceProvidersSearchClass() = default;

        private:
        BusinessServiceProvidersSearchGet get;

        public:
        const BusinessServiceProvidersSearchGet & get_get() const { return get; }
        BusinessServiceProvidersSearchGet & get_mutable_get() { return get; }
        void set_get(const BusinessServiceProvidersSearchGet & value) { this->get = value; }
    };

    enum class SchemaType : int { ARRAY };

    class PurpleSchema {
        public:
        PurpleSchema() = default;
        virtual ~PurpleSchema() = default;

        private:
        ItemsClass items;
        SchemaType type;

        public:
        const ItemsClass & get_items() const { return items; }
        ItemsClass & get_mutable_items() { return items; }
        void set_items(const ItemsClass & value) { this->items = value; }

        const SchemaType & get_type() const { return type; }
        SchemaType & get_mutable_type() { return type; }
        void set_type(const SchemaType & value) { this->type = value; }
    };

    class Fluffy200 {
        public:
        Fluffy200() = default;
        virtual ~Fluffy200() = default;

        private:
        std::string description;
        PurpleSchema schema;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const PurpleSchema & get_schema() const { return schema; }
        PurpleSchema & get_mutable_schema() { return schema; }
        void set_schema(const PurpleSchema & value) { this->schema = value; }
    };

    class FluffyResponses {
        public:
        FluffyResponses() = default;
        virtual ~FluffyResponses() = default;

        private:
        Fluffy200 the_200;

        public:
        const Fluffy200 & get_the_200() const { return the_200; }
        Fluffy200 & get_mutable_the_200() { return the_200; }
        void set_the_200(const Fluffy200 & value) { this->the_200 = value; }
    };

    class ConsolidatedScreeningListSearchGet {
        public:
        ConsolidatedScreeningListSearchGet() = default;
        virtual ~ConsolidatedScreeningListSearchGet() = default;

        private:
        std::string description;
        std::vector<Parameter> parameters;
        FluffyResponses responses;
        std::string summary;
        std::vector<std::string> tags;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const std::vector<Parameter> & get_parameters() const { return parameters; }
        std::vector<Parameter> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::vector<Parameter> & value) { this->parameters = value; }

        const FluffyResponses & get_responses() const { return responses; }
        FluffyResponses & get_mutable_responses() { return responses; }
        void set_responses(const FluffyResponses & value) { this->responses = value; }

        const std::string & get_summary() const { return summary; }
        std::string & get_mutable_summary() { return summary; }
        void set_summary(const std::string & value) { this->summary = value; }

        const std::vector<std::string> & get_tags() const { return tags; }
        std::vector<std::string> & get_mutable_tags() { return tags; }
        void set_tags(const std::vector<std::string> & value) { this->tags = value; }
    };

    class ConsolidatedScreeningListSearchClass {
        public:
        ConsolidatedScreeningListSearchClass() = default;
        virtual ~ConsolidatedScreeningListSearchClass() = default;

        private:
        ConsolidatedScreeningListSearchGet get;

        public:
        const ConsolidatedScreeningListSearchGet & get_get() const { return get; }
        ConsolidatedScreeningListSearchGet & get_mutable_get() { return get; }
        void set_get(const ConsolidatedScreeningListSearchGet & value) { this->get = value; }
    };

    class Paths {
        public:
        Paths() = default;
        virtual ~Paths() = default;

        private:
        BusinessServiceProvidersSearchClass business_service_providers_search;
        ConsolidatedScreeningListSearchClass consolidated_screening_list_search;
        ConsolidatedScreeningListSearchClass de_minimis_search;
        ConsolidatedScreeningListSearchClass ita_faqs_search;
        ConsolidatedScreeningListSearchClass ita_office_locations_search;
        BusinessServiceProvidersSearchClass ita_taxonomies_search;
        BusinessServiceProvidersSearchClass ita_zipcode_to_post_search;
        ConsolidatedScreeningListSearchClass market_intelligence_search;
        ConsolidatedScreeningListSearchClass market_research_library_search;
        ConsolidatedScreeningListSearchClass tariff_rates_search;
        ConsolidatedScreeningListSearchClass trade_articles_search;
        ConsolidatedScreeningListSearchClass trade_events_search;
        ConsolidatedScreeningListSearchClass trade_leads_search;

        public:
        const BusinessServiceProvidersSearchClass & get_business_service_providers_search() const { return business_service_providers_search; }
        BusinessServiceProvidersSearchClass & get_mutable_business_service_providers_search() { return business_service_providers_search; }
        void set_business_service_providers_search(const BusinessServiceProvidersSearchClass & value) { this->business_service_providers_search = value; }

        const ConsolidatedScreeningListSearchClass & get_consolidated_screening_list_search() const { return consolidated_screening_list_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_consolidated_screening_list_search() { return consolidated_screening_list_search; }
        void set_consolidated_screening_list_search(const ConsolidatedScreeningListSearchClass & value) { this->consolidated_screening_list_search = value; }

        const ConsolidatedScreeningListSearchClass & get_de_minimis_search() const { return de_minimis_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_de_minimis_search() { return de_minimis_search; }
        void set_de_minimis_search(const ConsolidatedScreeningListSearchClass & value) { this->de_minimis_search = value; }

        const ConsolidatedScreeningListSearchClass & get_ita_faqs_search() const { return ita_faqs_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_ita_faqs_search() { return ita_faqs_search; }
        void set_ita_faqs_search(const ConsolidatedScreeningListSearchClass & value) { this->ita_faqs_search = value; }

        const ConsolidatedScreeningListSearchClass & get_ita_office_locations_search() const { return ita_office_locations_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_ita_office_locations_search() { return ita_office_locations_search; }
        void set_ita_office_locations_search(const ConsolidatedScreeningListSearchClass & value) { this->ita_office_locations_search = value; }

        const BusinessServiceProvidersSearchClass & get_ita_taxonomies_search() const { return ita_taxonomies_search; }
        BusinessServiceProvidersSearchClass & get_mutable_ita_taxonomies_search() { return ita_taxonomies_search; }
        void set_ita_taxonomies_search(const BusinessServiceProvidersSearchClass & value) { this->ita_taxonomies_search = value; }

        const BusinessServiceProvidersSearchClass & get_ita_zipcode_to_post_search() const { return ita_zipcode_to_post_search; }
        BusinessServiceProvidersSearchClass & get_mutable_ita_zipcode_to_post_search() { return ita_zipcode_to_post_search; }
        void set_ita_zipcode_to_post_search(const BusinessServiceProvidersSearchClass & value) { this->ita_zipcode_to_post_search = value; }

        const ConsolidatedScreeningListSearchClass & get_market_intelligence_search() const { return market_intelligence_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_market_intelligence_search() { return market_intelligence_search; }
        void set_market_intelligence_search(const ConsolidatedScreeningListSearchClass & value) { this->market_intelligence_search = value; }

        const ConsolidatedScreeningListSearchClass & get_market_research_library_search() const { return market_research_library_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_market_research_library_search() { return market_research_library_search; }
        void set_market_research_library_search(const ConsolidatedScreeningListSearchClass & value) { this->market_research_library_search = value; }

        const ConsolidatedScreeningListSearchClass & get_tariff_rates_search() const { return tariff_rates_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_tariff_rates_search() { return tariff_rates_search; }
        void set_tariff_rates_search(const ConsolidatedScreeningListSearchClass & value) { this->tariff_rates_search = value; }

        const ConsolidatedScreeningListSearchClass & get_trade_articles_search() const { return trade_articles_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_trade_articles_search() { return trade_articles_search; }
        void set_trade_articles_search(const ConsolidatedScreeningListSearchClass & value) { this->trade_articles_search = value; }

        const ConsolidatedScreeningListSearchClass & get_trade_events_search() const { return trade_events_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_trade_events_search() { return trade_events_search; }
        void set_trade_events_search(const ConsolidatedScreeningListSearchClass & value) { this->trade_events_search = value; }

        const ConsolidatedScreeningListSearchClass & get_trade_leads_search() const { return trade_leads_search; }
        ConsolidatedScreeningListSearchClass & get_mutable_trade_leads_search() { return trade_leads_search; }
        void set_trade_leads_search(const ConsolidatedScreeningListSearchClass & value) { this->trade_leads_search = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string base_path;
        Definitions definitions;
        std::string host;
        Info info;
        Paths paths;
        std::vector<std::string> produces;
        std::vector<std::string> schemes;
        std::string swagger;

        public:
        const std::string & get_base_path() const { return base_path; }
        std::string & get_mutable_base_path() { return base_path; }
        void set_base_path(const std::string & value) { this->base_path = value; }

        const Definitions & get_definitions() const { return definitions; }
        Definitions & get_mutable_definitions() { return definitions; }
        void set_definitions(const Definitions & value) { this->definitions = value; }

        const std::string & get_host() const { return host; }
        std::string & get_mutable_host() { return host; }
        void set_host(const std::string & value) { this->host = value; }

        const Info & get_info() const { return info; }
        Info & get_mutable_info() { return info; }
        void set_info(const Info & value) { this->info = value; }

        const Paths & get_paths() const { return paths; }
        Paths & get_mutable_paths() { return paths; }
        void set_paths(const Paths & value) { this->paths = value; }

        const std::vector<std::string> & get_produces() const { return produces; }
        std::vector<std::string> & get_mutable_produces() { return produces; }
        void set_produces(const std::vector<std::string> & value) { this->produces = value; }

        const std::vector<std::string> & get_schemes() const { return schemes; }
        std::vector<std::string> & get_mutable_schemes() { return schemes; }
        void set_schemes(const std::vector<std::string> & value) { this->schemes = value; }

        const std::string & get_swagger() const { return swagger; }
        std::string & get_mutable_swagger() { return swagger; }
        void set_swagger(const std::string & value) { this->swagger = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Property & x);
    void to_json(json & j, const Property & x);

    void from_json(const json & j, Article & x);
    void to_json(json & j, const Article & x);

    void from_json(const json & j, DeMinimisProperties & x);
    void to_json(json & j, const DeMinimisProperties & x);

    void from_json(const json & j, DeMinimis & x);
    void to_json(json & j, const DeMinimis & x);

    void from_json(const json & j, FaqProperties & x);
    void to_json(json & j, const FaqProperties & x);

    void from_json(const json & j, Faq & x);
    void to_json(json & j, const Faq & x);

    void from_json(const json & j, ReportProperties & x);
    void to_json(json & j, const ReportProperties & x);

    void from_json(const json & j, Report & x);
    void to_json(json & j, const Report & x);

    void from_json(const json & j, TaxonomyProperties & x);
    void to_json(json & j, const TaxonomyProperties & x);

    void from_json(const json & j, Taxonomy & x);
    void to_json(json & j, const Taxonomy & x);

    void from_json(const json & j, Definitions & x);
    void to_json(json & j, const Definitions & x);

    void from_json(const json & j, Info & x);
    void to_json(json & j, const Info & x);

    void from_json(const json & j, Parameter & x);
    void to_json(json & j, const Parameter & x);

    void from_json(const json & j, ItemsClass & x);
    void to_json(json & j, const ItemsClass & x);

    void from_json(const json & j, Purple200 & x);
    void to_json(json & j, const Purple200 & x);

    void from_json(const json & j, PurpleResponses & x);
    void to_json(json & j, const PurpleResponses & x);

    void from_json(const json & j, BusinessServiceProvidersSearchGet & x);
    void to_json(json & j, const BusinessServiceProvidersSearchGet & x);

    void from_json(const json & j, BusinessServiceProvidersSearchClass & x);
    void to_json(json & j, const BusinessServiceProvidersSearchClass & x);

    void from_json(const json & j, PurpleSchema & x);
    void to_json(json & j, const PurpleSchema & x);

    void from_json(const json & j, Fluffy200 & x);
    void to_json(json & j, const Fluffy200 & x);

    void from_json(const json & j, FluffyResponses & x);
    void to_json(json & j, const FluffyResponses & x);

    void from_json(const json & j, ConsolidatedScreeningListSearchGet & x);
    void to_json(json & j, const ConsolidatedScreeningListSearchGet & x);

    void from_json(const json & j, ConsolidatedScreeningListSearchClass & x);
    void to_json(json & j, const ConsolidatedScreeningListSearchClass & x);

    void from_json(const json & j, Paths & x);
    void to_json(json & j, const Paths & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, FormatEnum & x);
    void to_json(json & j, const FormatEnum & x);

    void from_json(const json & j, In & x);
    void to_json(json & j, const In & x);

    void from_json(const json & j, SchemaType & x);
    void to_json(json & j, const SchemaType & x);

    inline void from_json(const json & j, Property& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_type(j.at("type").get<FormatEnum>());
    }

    inline void to_json(json & j, const Property & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Article& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_properties(j.at("properties").get<std::map<std::string, Property>>());
    }

    inline void to_json(json & j, const Article & x) {
        j = json::object();
        j["properties"] = x.get_properties();
    }

    inline void from_json(const json & j, DeMinimisProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_countries(j.at("countries").get<Property>());
        x.set_country(j.at("country").get<Property>());
        x.set_de_minimis_currency(j.at("de_minimis_currency").get<Property>());
        x.set_de_minimis_value(j.at("de_minimis_value").get<Property>());
        x.set_notes(j.at("notes").get<Property>());
        x.set_vat_amount(j.at("vat_amount").get<Property>());
        x.set_vat_currency(j.at("vat_currency").get<Property>());
    }

    inline void to_json(json & j, const DeMinimisProperties & x) {
        j = json::object();
        j["countries"] = x.get_countries();
        j["country"] = x.get_country();
        j["de_minimis_currency"] = x.get_de_minimis_currency();
        j["de_minimis_value"] = x.get_de_minimis_value();
        j["notes"] = x.get_notes();
        j["vat_amount"] = x.get_vat_amount();
        j["vat_currency"] = x.get_vat_currency();
    }

    inline void from_json(const json & j, DeMinimis& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_properties(j.at("properties").get<DeMinimisProperties>());
    }

    inline void to_json(json & j, const DeMinimis & x) {
        j = json::object();
        j["properties"] = x.get_properties();
    }

    inline void from_json(const json & j, FaqProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_answer(j.at("answer").get<Property>());
        x.set_countries(j.at("countries").get<Property>());
        x.set_first_published_date(j.at("first_published_date").get<Property>());
        x.set_id(j.at("id").get<Property>());
        x.set_industries(j.at("industries").get<Property>());
        x.set_last_published_date(j.at("last_published_date").get<Property>());
        x.set_question(j.at("question").get<Property>());
        x.set_topics(j.at("topics").get<Property>());
        x.set_trade_regions(j.at("trade_regions").get<Property>());
        x.set_url(j.at("url").get<Property>());
        x.set_world_regions(j.at("world_regions").get<Property>());
    }

    inline void to_json(json & j, const FaqProperties & x) {
        j = json::object();
        j["answer"] = x.get_answer();
        j["countries"] = x.get_countries();
        j["first_published_date"] = x.get_first_published_date();
        j["id"] = x.get_id();
        j["industries"] = x.get_industries();
        j["last_published_date"] = x.get_last_published_date();
        j["question"] = x.get_question();
        j["topics"] = x.get_topics();
        j["trade_regions"] = x.get_trade_regions();
        j["url"] = x.get_url();
        j["world_regions"] = x.get_world_regions();
    }

    inline void from_json(const json & j, Faq& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_properties(j.at("properties").get<FaqProperties>());
    }

    inline void to_json(json & j, const Faq & x) {
        j = json::object();
        j["properties"] = x.get_properties();
    }

    inline void from_json(const json & j, ReportProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_countries(j.at("countries").get<Property>());
        x.set_description(j.at("description").get<Property>());
        x.set_expiration_date(j.at("expiration_date").get<Property>());
        x.set_id(j.at("id").get<Property>());
        x.set_industries(j.at("industries").get<Property>());
        x.set_ita_industries(j.at("ita_industries").get<Property>());
        x.set_report_type(j.at("report_type").get<Property>());
        x.set_title(j.at("title").get<Property>());
        x.set_url(j.at("url").get<Property>());
    }

    inline void to_json(json & j, const ReportProperties & x) {
        j = json::object();
        j["countries"] = x.get_countries();
        j["description"] = x.get_description();
        j["expiration_date"] = x.get_expiration_date();
        j["id"] = x.get_id();
        j["industries"] = x.get_industries();
        j["ita_industries"] = x.get_ita_industries();
        j["report_type"] = x.get_report_type();
        j["title"] = x.get_title();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Report& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_properties(j.at("properties").get<ReportProperties>());
    }

    inline void to_json(json & j, const Report & x) {
        j = json::object();
        j["properties"] = x.get_properties();
    }

    inline void from_json(const json & j, TaxonomyProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_annotations(j.at("annotations").get<Property>());
        x.set_datatype_properties(j.at("datatype_properties").get<Property>());
        x.set_id(j.at("id").get<Property>());
        x.set_label(j.at("label").get<Property>());
        x.set_sub_class_of(j.at("sub_class_of").get<Property>());
        x.set_type(j.at("type").get<Property>());
    }

    inline void to_json(json & j, const TaxonomyProperties & x) {
        j = json::object();
        j["annotations"] = x.get_annotations();
        j["datatype_properties"] = x.get_datatype_properties();
        j["id"] = x.get_id();
        j["label"] = x.get_label();
        j["sub_class_of"] = x.get_sub_class_of();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Taxonomy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_properties(j.at("properties").get<TaxonomyProperties>());
    }

    inline void to_json(json & j, const Taxonomy & x) {
        j = json::object();
        j["properties"] = x.get_properties();
    }

    inline void from_json(const json & j, Definitions& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_article(j.at("Article").get<Article>());
        x.set_center(j.at("Center").get<Article>());
        x.set_de_minimis(j.at("DeMinimis").get<DeMinimis>());
        x.set_event(j.at("Event").get<Article>());
        x.set_faq(j.at("FAQ").get<Faq>());
        x.set_lead(j.at("Lead").get<Article>());
        x.set_list(j.at("List").get<Article>());
        x.set_market_intelligence(j.at("MarketIntelligence").get<Article>());
        x.set_office(j.at("Office").get<Article>());
        x.set_provider(j.at("Provider").get<Article>());
        x.set_rate(j.at("Rate").get<Article>());
        x.set_report(j.at("Report").get<Report>());
        x.set_taxonomy(j.at("Taxonomy").get<Taxonomy>());
    }

    inline void to_json(json & j, const Definitions & x) {
        j = json::object();
        j["Article"] = x.get_article();
        j["Center"] = x.get_center();
        j["DeMinimis"] = x.get_de_minimis();
        j["Event"] = x.get_event();
        j["FAQ"] = x.get_faq();
        j["Lead"] = x.get_lead();
        j["List"] = x.get_list();
        j["MarketIntelligence"] = x.get_market_intelligence();
        j["Office"] = x.get_office();
        j["Provider"] = x.get_provider();
        j["Rate"] = x.get_rate();
        j["Report"] = x.get_report();
        j["Taxonomy"] = x.get_taxonomy();
    }

    inline void from_json(const json & j, Info& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_title(j.at("title").get<std::string>());
        x.set_version(j.at("version").get<std::string>());
    }

    inline void to_json(json & j, const Info & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["title"] = x.get_title();
        j["version"] = x.get_version();
    }

    inline void from_json(const json & j, Parameter& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_format(j.at("format").get<FormatEnum>());
        x.set_in(j.at("in").get<In>());
        x.set_name(j.at("name").get<std::string>());
        x.set_required(j.at("required").get<bool>());
        x.set_type(j.at("type").get<FormatEnum>());
    }

    inline void to_json(json & j, const Parameter & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["format"] = x.get_format();
        j["in"] = x.get_in();
        j["name"] = x.get_name();
        j["required"] = x.get_required();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, ItemsClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_ref(j.at("$ref").get<std::string>());
    }

    inline void to_json(json & j, const ItemsClass & x) {
        j = json::object();
        j["$ref"] = x.get_ref();
    }

    inline void from_json(const json & j, Purple200& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_schema(j.at("schema").get<ItemsClass>());
    }

    inline void to_json(json & j, const Purple200 & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["schema"] = x.get_schema();
    }

    inline void from_json(const json & j, PurpleResponses& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_the_200(j.at("200").get<Purple200>());
    }

    inline void to_json(json & j, const PurpleResponses & x) {
        j = json::object();
        j["200"] = x.get_the_200();
    }

    inline void from_json(const json & j, BusinessServiceProvidersSearchGet& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_parameters(j.at("parameters").get<std::vector<Parameter>>());
        x.set_responses(j.at("responses").get<PurpleResponses>());
        x.set_summary(j.at("summary").get<std::string>());
        x.set_tags(j.at("tags").get<std::vector<std::string>>());
    }

    inline void to_json(json & j, const BusinessServiceProvidersSearchGet & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["parameters"] = x.get_parameters();
        j["responses"] = x.get_responses();
        j["summary"] = x.get_summary();
        j["tags"] = x.get_tags();
    }

    inline void from_json(const json & j, BusinessServiceProvidersSearchClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_get(j.at("get").get<BusinessServiceProvidersSearchGet>());
    }

    inline void to_json(json & j, const BusinessServiceProvidersSearchClass & x) {
        j = json::object();
        j["get"] = x.get_get();
    }

    inline void from_json(const json & j, PurpleSchema& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_items(j.at("items").get<ItemsClass>());
        x.set_type(j.at("type").get<SchemaType>());
    }

    inline void to_json(json & j, const PurpleSchema & x) {
        j = json::object();
        j["items"] = x.get_items();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Fluffy200& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_schema(j.at("schema").get<PurpleSchema>());
    }

    inline void to_json(json & j, const Fluffy200 & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["schema"] = x.get_schema();
    }

    inline void from_json(const json & j, FluffyResponses& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_the_200(j.at("200").get<Fluffy200>());
    }

    inline void to_json(json & j, const FluffyResponses & x) {
        j = json::object();
        j["200"] = x.get_the_200();
    }

    inline void from_json(const json & j, ConsolidatedScreeningListSearchGet& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_parameters(j.at("parameters").get<std::vector<Parameter>>());
        x.set_responses(j.at("responses").get<FluffyResponses>());
        x.set_summary(j.at("summary").get<std::string>());
        x.set_tags(j.at("tags").get<std::vector<std::string>>());
    }

    inline void to_json(json & j, const ConsolidatedScreeningListSearchGet & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["parameters"] = x.get_parameters();
        j["responses"] = x.get_responses();
        j["summary"] = x.get_summary();
        j["tags"] = x.get_tags();
    }

    inline void from_json(const json & j, ConsolidatedScreeningListSearchClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_get(j.at("get").get<ConsolidatedScreeningListSearchGet>());
    }

    inline void to_json(json & j, const ConsolidatedScreeningListSearchClass & x) {
        j = json::object();
        j["get"] = x.get_get();
    }

    inline void from_json(const json & j, Paths& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_business_service_providers_search(j.at("/business_service_providers/search").get<BusinessServiceProvidersSearchClass>());
        x.set_consolidated_screening_list_search(j.at("/consolidated_screening_list/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_de_minimis_search(j.at("/de_minimis/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_ita_faqs_search(j.at("/ita_faqs/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_ita_office_locations_search(j.at("/ita_office_locations/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_ita_taxonomies_search(j.at("/ita_taxonomies/search").get<BusinessServiceProvidersSearchClass>());
        x.set_ita_zipcode_to_post_search(j.at("/ita_zipcode_to_post/search").get<BusinessServiceProvidersSearchClass>());
        x.set_market_intelligence_search(j.at("/market_intelligence/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_market_research_library_search(j.at("/market_research_library/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_tariff_rates_search(j.at("/tariff_rates/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_trade_articles_search(j.at("/trade_articles/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_trade_events_search(j.at("/trade_events/search").get<ConsolidatedScreeningListSearchClass>());
        x.set_trade_leads_search(j.at("/trade_leads/search").get<ConsolidatedScreeningListSearchClass>());
    }

    inline void to_json(json & j, const Paths & x) {
        j = json::object();
        j["/business_service_providers/search"] = x.get_business_service_providers_search();
        j["/consolidated_screening_list/search"] = x.get_consolidated_screening_list_search();
        j["/de_minimis/search"] = x.get_de_minimis_search();
        j["/ita_faqs/search"] = x.get_ita_faqs_search();
        j["/ita_office_locations/search"] = x.get_ita_office_locations_search();
        j["/ita_taxonomies/search"] = x.get_ita_taxonomies_search();
        j["/ita_zipcode_to_post/search"] = x.get_ita_zipcode_to_post_search();
        j["/market_intelligence/search"] = x.get_market_intelligence_search();
        j["/market_research_library/search"] = x.get_market_research_library_search();
        j["/tariff_rates/search"] = x.get_tariff_rates_search();
        j["/trade_articles/search"] = x.get_trade_articles_search();
        j["/trade_events/search"] = x.get_trade_events_search();
        j["/trade_leads/search"] = x.get_trade_leads_search();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_base_path(j.at("basePath").get<std::string>());
        x.set_definitions(j.at("definitions").get<Definitions>());
        x.set_host(j.at("host").get<std::string>());
        x.set_info(j.at("info").get<Info>());
        x.set_paths(j.at("paths").get<Paths>());
        x.set_produces(j.at("produces").get<std::vector<std::string>>());
        x.set_schemes(j.at("schemes").get<std::vector<std::string>>());
        x.set_swagger(j.at("swagger").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["basePath"] = x.get_base_path();
        j["definitions"] = x.get_definitions();
        j["host"] = x.get_host();
        j["info"] = x.get_info();
        j["paths"] = x.get_paths();
        j["produces"] = x.get_produces();
        j["schemes"] = x.get_schemes();
        j["swagger"] = x.get_swagger();
    }

    inline void from_json(const json & j, FormatEnum & x) {
        if (j == "string") x = FormatEnum::STRING;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FormatEnum\""); }
    }

    inline void to_json(json & j, const FormatEnum & x) {
        switch (x) {
            case FormatEnum::STRING: j = "string"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FormatEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, In & x) {
        if (j == "query") x = In::QUERY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"In\""); }
    }

    inline void to_json(json & j, const In & x) {
        switch (x) {
            case In::QUERY: j = "query"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"In\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SchemaType & x) {
        if (j == "array") x = SchemaType::ARRAY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SchemaType\""); }
    }

    inline void to_json(json & j, const SchemaType & x) {
        switch (x) {
            case SchemaType::ARRAY: j = "array"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SchemaType\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
