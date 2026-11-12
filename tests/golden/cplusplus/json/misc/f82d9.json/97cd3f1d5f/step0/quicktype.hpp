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

    enum class Type : int { STRING };

    class ClickUrl {
        public:
        ClickUrl() = default;
        virtual ~ClickUrl() = default;

        private:
        std::string description;
        Type type;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    class Properties {
        public:
        Properties() = default;
        virtual ~Properties() = default;

        private:
        ClickUrl click_url;
        ClickUrl country;
        ClickUrl description;
        ClickUrl expiration_date;
        ClickUrl id;
        ClickUrl industry;
        ClickUrl report_type;
        ClickUrl source_industry;
        ClickUrl title;
        ClickUrl url;

        public:
        const ClickUrl & get_click_url() const { return click_url; }
        ClickUrl & get_mutable_click_url() { return click_url; }
        void set_click_url(const ClickUrl & value) { this->click_url = value; }

        const ClickUrl & get_country() const { return country; }
        ClickUrl & get_mutable_country() { return country; }
        void set_country(const ClickUrl & value) { this->country = value; }

        const ClickUrl & get_description() const { return description; }
        ClickUrl & get_mutable_description() { return description; }
        void set_description(const ClickUrl & value) { this->description = value; }

        const ClickUrl & get_expiration_date() const { return expiration_date; }
        ClickUrl & get_mutable_expiration_date() { return expiration_date; }
        void set_expiration_date(const ClickUrl & value) { this->expiration_date = value; }

        const ClickUrl & get_id() const { return id; }
        ClickUrl & get_mutable_id() { return id; }
        void set_id(const ClickUrl & value) { this->id = value; }

        const ClickUrl & get_industry() const { return industry; }
        ClickUrl & get_mutable_industry() { return industry; }
        void set_industry(const ClickUrl & value) { this->industry = value; }

        const ClickUrl & get_report_type() const { return report_type; }
        ClickUrl & get_mutable_report_type() { return report_type; }
        void set_report_type(const ClickUrl & value) { this->report_type = value; }

        const ClickUrl & get_source_industry() const { return source_industry; }
        ClickUrl & get_mutable_source_industry() { return source_industry; }
        void set_source_industry(const ClickUrl & value) { this->source_industry = value; }

        const ClickUrl & get_title() const { return title; }
        ClickUrl & get_mutable_title() { return title; }
        void set_title(const ClickUrl & value) { this->title = value; }

        const ClickUrl & get_url() const { return url; }
        ClickUrl & get_mutable_url() { return url; }
        void set_url(const ClickUrl & value) { this->url = value; }
    };

    class Report {
        public:
        Report() = default;
        virtual ~Report() = default;

        private:
        Properties properties;

        public:
        const Properties & get_properties() const { return properties; }
        Properties & get_mutable_properties() { return properties; }
        void set_properties(const Properties & value) { this->properties = value; }
    };

    class Definitions {
        public:
        Definitions() = default;
        virtual ~Definitions() = default;

        private:
        Report report;

        public:
        const Report & get_report() const { return report; }
        Report & get_mutable_report() { return report; }
        void set_report(const Report & value) { this->report = value; }
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

    class Parameter {
        public:
        Parameter() = default;
        virtual ~Parameter() = default;

        private:
        std::string description;
        Type format;
        std::string in;
        std::string name;
        bool required;
        Type type;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const Type & get_format() const { return format; }
        Type & get_mutable_format() { return format; }
        void set_format(const Type & value) { this->format = value; }

        const std::string & get_in() const { return in; }
        std::string & get_mutable_in() { return in; }
        void set_in(const std::string & value) { this->in = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const bool & get_required() const { return required; }
        bool & get_mutable_required() { return required; }
        void set_required(const bool & value) { this->required = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    class Items {
        public:
        Items() = default;
        virtual ~Items() = default;

        private:
        std::string ref;

        public:
        const std::string & get_ref() const { return ref; }
        std::string & get_mutable_ref() { return ref; }
        void set_ref(const std::string & value) { this->ref = value; }
    };

    class Schema {
        public:
        Schema() = default;
        virtual ~Schema() = default;

        private:
        Items items;
        std::string type;

        public:
        const Items & get_items() const { return items; }
        Items & get_mutable_items() { return items; }
        void set_items(const Items & value) { this->items = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };

    class The200 {
        public:
        The200() = default;
        virtual ~The200() = default;

        private:
        std::string description;
        Schema schema;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const Schema & get_schema() const { return schema; }
        Schema & get_mutable_schema() { return schema; }
        void set_schema(const Schema & value) { this->schema = value; }
    };

    class Responses {
        public:
        Responses() = default;
        virtual ~Responses() = default;

        private:
        The200 the_200;

        public:
        const The200 & get_the_200() const { return the_200; }
        The200 & get_mutable_the_200() { return the_200; }
        void set_the_200(const The200 & value) { this->the_200 = value; }
    };

    class Get {
        public:
        Get() = default;
        virtual ~Get() = default;

        private:
        std::string description;
        std::vector<Parameter> parameters;
        Responses responses;
        std::string summary;
        std::vector<std::string> tags;

        public:
        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const std::vector<Parameter> & get_parameters() const { return parameters; }
        std::vector<Parameter> & get_mutable_parameters() { return parameters; }
        void set_parameters(const std::vector<Parameter> & value) { this->parameters = value; }

        const Responses & get_responses() const { return responses; }
        Responses & get_mutable_responses() { return responses; }
        void set_responses(const Responses & value) { this->responses = value; }

        const std::string & get_summary() const { return summary; }
        std::string & get_mutable_summary() { return summary; }
        void set_summary(const std::string & value) { this->summary = value; }

        const std::vector<std::string> & get_tags() const { return tags; }
        std::vector<std::string> & get_mutable_tags() { return tags; }
        void set_tags(const std::vector<std::string> & value) { this->tags = value; }
    };

    class MarketResearchLibrarySearch {
        public:
        MarketResearchLibrarySearch() = default;
        virtual ~MarketResearchLibrarySearch() = default;

        private:
        Get get;

        public:
        const Get & get_get() const { return get; }
        Get & get_mutable_get() { return get; }
        void set_get(const Get & value) { this->get = value; }
    };

    class Paths {
        public:
        Paths() = default;
        virtual ~Paths() = default;

        private:
        MarketResearchLibrarySearch market_research_library_search;

        public:
        const MarketResearchLibrarySearch & get_market_research_library_search() const { return market_research_library_search; }
        MarketResearchLibrarySearch & get_mutable_market_research_library_search() { return market_research_library_search; }
        void set_market_research_library_search(const MarketResearchLibrarySearch & value) { this->market_research_library_search = value; }
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
    void from_json(const json & j, ClickUrl & x);
    void to_json(json & j, const ClickUrl & x);

    void from_json(const json & j, Properties & x);
    void to_json(json & j, const Properties & x);

    void from_json(const json & j, Report & x);
    void to_json(json & j, const Report & x);

    void from_json(const json & j, Definitions & x);
    void to_json(json & j, const Definitions & x);

    void from_json(const json & j, Info & x);
    void to_json(json & j, const Info & x);

    void from_json(const json & j, Parameter & x);
    void to_json(json & j, const Parameter & x);

    void from_json(const json & j, Items & x);
    void to_json(json & j, const Items & x);

    void from_json(const json & j, Schema & x);
    void to_json(json & j, const Schema & x);

    void from_json(const json & j, The200 & x);
    void to_json(json & j, const The200 & x);

    void from_json(const json & j, Responses & x);
    void to_json(json & j, const Responses & x);

    void from_json(const json & j, Get & x);
    void to_json(json & j, const Get & x);

    void from_json(const json & j, MarketResearchLibrarySearch & x);
    void to_json(json & j, const MarketResearchLibrarySearch & x);

    void from_json(const json & j, Paths & x);
    void to_json(json & j, const Paths & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    inline void from_json(const json & j, ClickUrl& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const ClickUrl & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Properties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_click_url(j.at("click_url").get<ClickUrl>());
        x.set_country(j.at("country").get<ClickUrl>());
        x.set_description(j.at("description").get<ClickUrl>());
        x.set_expiration_date(j.at("expiration_date").get<ClickUrl>());
        x.set_id(j.at("id").get<ClickUrl>());
        x.set_industry(j.at("industry").get<ClickUrl>());
        x.set_report_type(j.at("report_type").get<ClickUrl>());
        x.set_source_industry(j.at("source_industry").get<ClickUrl>());
        x.set_title(j.at("title").get<ClickUrl>());
        x.set_url(j.at("url").get<ClickUrl>());
    }

    inline void to_json(json & j, const Properties & x) {
        j = json::object();
        j["click_url"] = x.get_click_url();
        j["country"] = x.get_country();
        j["description"] = x.get_description();
        j["expiration_date"] = x.get_expiration_date();
        j["id"] = x.get_id();
        j["industry"] = x.get_industry();
        j["report_type"] = x.get_report_type();
        j["source_industry"] = x.get_source_industry();
        j["title"] = x.get_title();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Report& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_properties(j.at("properties").get<Properties>());
    }

    inline void to_json(json & j, const Report & x) {
        j = json::object();
        j["properties"] = x.get_properties();
    }

    inline void from_json(const json & j, Definitions& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_report(j.at("Report").get<Report>());
    }

    inline void to_json(json & j, const Definitions & x) {
        j = json::object();
        j["Report"] = x.get_report();
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
        x.set_format(j.at("format").get<Type>());
        x.set_in(j.at("in").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_required(j.at("required").get<bool>());
        x.set_type(j.at("type").get<Type>());
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

    inline void from_json(const json & j, Items& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_ref(j.at("$ref").get<std::string>());
    }

    inline void to_json(json & j, const Items & x) {
        j = json::object();
        j["$ref"] = x.get_ref();
    }

    inline void from_json(const json & j, Schema& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_items(j.at("items").get<Items>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const Schema & x) {
        j = json::object();
        j["items"] = x.get_items();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, The200& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_schema(j.at("schema").get<Schema>());
    }

    inline void to_json(json & j, const The200 & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["schema"] = x.get_schema();
    }

    inline void from_json(const json & j, Responses& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_the_200(j.at("200").get<The200>());
    }

    inline void to_json(json & j, const Responses & x) {
        j = json::object();
        j["200"] = x.get_the_200();
    }

    inline void from_json(const json & j, Get& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_description(j.at("description").get<std::string>());
        x.set_parameters(j.at("parameters").get<std::vector<Parameter>>());
        x.set_responses(j.at("responses").get<Responses>());
        x.set_summary(j.at("summary").get<std::string>());
        x.set_tags(j.at("tags").get<std::vector<std::string>>());
    }

    inline void to_json(json & j, const Get & x) {
        j = json::object();
        j["description"] = x.get_description();
        j["parameters"] = x.get_parameters();
        j["responses"] = x.get_responses();
        j["summary"] = x.get_summary();
        j["tags"] = x.get_tags();
    }

    inline void from_json(const json & j, MarketResearchLibrarySearch& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_get(j.at("get").get<Get>());
    }

    inline void to_json(json & j, const MarketResearchLibrarySearch & x) {
        j = json::object();
        j["get"] = x.get_get();
    }

    inline void from_json(const json & j, Paths& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_market_research_library_search(j.at("/market_research_library/search").get<MarketResearchLibrarySearch>());
    }

    inline void to_json(json & j, const Paths & x) {
        j = json::object();
        j["/market_research_library/search"] = x.get_market_research_library_search();
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

    inline void from_json(const json & j, Type & x) {
        if (j == "string") x = Type::STRING;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::STRING: j = "string"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
