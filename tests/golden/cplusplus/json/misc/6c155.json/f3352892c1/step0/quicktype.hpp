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

    class ResponseInfo {
        public:
        ResponseInfo() = default;
        virtual ~ResponseInfo() = default;

        private:
        std::string developer_message;
        int64_t status;

        public:
        const std::string & get_developer_message() const { return developer_message; }
        std::string & get_mutable_developer_message() { return developer_message; }
        void set_developer_message(const std::string & value) { this->developer_message = value; }

        const int64_t & get_status() const { return status; }
        int64_t & get_mutable_status() { return status; }
        void set_status(const int64_t & value) { this->status = value; }
    };

    class Resultset {
        public:
        Resultset() = default;
        virtual ~Resultset() = default;

        private:
        int64_t count;
        int64_t page;
        int64_t pagesize;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const int64_t & get_page() const { return page; }
        int64_t & get_mutable_page() { return page; }
        void set_page(const int64_t & value) { this->page = value; }

        const int64_t & get_pagesize() const { return pagesize; }
        int64_t & get_mutable_pagesize() { return pagesize; }
        void set_pagesize(const int64_t & value) { this->pagesize = value; }
    };

    class Metadata {
        public:
        Metadata() = default;
        virtual ~Metadata() = default;

        private:
        double execution_time;
        ResponseInfo response_info;
        Resultset resultset;

        public:
        const double & get_execution_time() const { return execution_time; }
        double & get_mutable_execution_time() { return execution_time; }
        void set_execution_time(const double & value) { this->execution_time = value; }

        const ResponseInfo & get_response_info() const { return response_info; }
        ResponseInfo & get_mutable_response_info() { return response_info; }
        void set_response_info(const ResponseInfo & value) { this->response_info = value; }

        const Resultset & get_resultset() const { return resultset; }
        Resultset & get_mutable_resultset() { return resultset; }
        void set_resultset(const Resultset & value) { this->resultset = value; }
    };

    class Component {
        public:
        Component() = default;
        virtual ~Component() = default;

        private:
        std::string name;
        std::string uuid;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_uuid() const { return uuid; }
        std::string & get_mutable_uuid() { return uuid; }
        void set_uuid(const std::string & value) { this->uuid = value; }
    };

    class Location {
        public:
        Location() = default;
        virtual ~Location() = default;

        private:
        std::string administrative_area;
        std::string country;
        std::string fax_number;
        std::string locality;
        std::string mobile_number;
        std::string phone_number;
        std::string phone_number_extension;
        std::string postal_code;
        nlohmann::json sub_premise;
        std::string thoroughfare;

        public:
        const std::string & get_administrative_area() const { return administrative_area; }
        std::string & get_mutable_administrative_area() { return administrative_area; }
        void set_administrative_area(const std::string & value) { this->administrative_area = value; }

        const std::string & get_country() const { return country; }
        std::string & get_mutable_country() { return country; }
        void set_country(const std::string & value) { this->country = value; }

        const std::string & get_fax_number() const { return fax_number; }
        std::string & get_mutable_fax_number() { return fax_number; }
        void set_fax_number(const std::string & value) { this->fax_number = value; }

        const std::string & get_locality() const { return locality; }
        std::string & get_mutable_locality() { return locality; }
        void set_locality(const std::string & value) { this->locality = value; }

        const std::string & get_mobile_number() const { return mobile_number; }
        std::string & get_mutable_mobile_number() { return mobile_number; }
        void set_mobile_number(const std::string & value) { this->mobile_number = value; }

        const std::string & get_phone_number() const { return phone_number; }
        std::string & get_mutable_phone_number() { return phone_number; }
        void set_phone_number(const std::string & value) { this->phone_number = value; }

        const std::string & get_phone_number_extension() const { return phone_number_extension; }
        std::string & get_mutable_phone_number_extension() { return phone_number_extension; }
        void set_phone_number_extension(const std::string & value) { this->phone_number_extension = value; }

        const std::string & get_postal_code() const { return postal_code; }
        std::string & get_mutable_postal_code() { return postal_code; }
        void set_postal_code(const std::string & value) { this->postal_code = value; }

        const nlohmann::json & get_sub_premise() const { return sub_premise; }
        nlohmann::json & get_mutable_sub_premise() { return sub_premise; }
        void set_sub_premise(const nlohmann::json & value) { this->sub_premise = value; }

        const std::string & get_thoroughfare() const { return thoroughfare; }
        std::string & get_mutable_thoroughfare() { return thoroughfare; }
        void set_thoroughfare(const std::string & value) { this->thoroughfare = value; }
    };

    class Result {
        public:
        Result() = default;
        virtual ~Result() = default;

        private:
        std::vector<nlohmann::json> attachment;
        std::string body;
        std::string changed;
        std::vector<Component> component;
        std::string created;
        std::string date;
        std::vector<nlohmann::json> image;
        Location location;
        nlohmann::json teaser;
        std::string title;
        std::vector<nlohmann::json> topic;
        std::string url;
        std::string uuid;
        std::string vuuid;

        public:
        const std::vector<nlohmann::json> & get_attachment() const { return attachment; }
        std::vector<nlohmann::json> & get_mutable_attachment() { return attachment; }
        void set_attachment(const std::vector<nlohmann::json> & value) { this->attachment = value; }

        const std::string & get_body() const { return body; }
        std::string & get_mutable_body() { return body; }
        void set_body(const std::string & value) { this->body = value; }

        const std::string & get_changed() const { return changed; }
        std::string & get_mutable_changed() { return changed; }
        void set_changed(const std::string & value) { this->changed = value; }

        const std::vector<Component> & get_component() const { return component; }
        std::vector<Component> & get_mutable_component() { return component; }
        void set_component(const std::vector<Component> & value) { this->component = value; }

        const std::string & get_created() const { return created; }
        std::string & get_mutable_created() { return created; }
        void set_created(const std::string & value) { this->created = value; }

        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const std::vector<nlohmann::json> & get_image() const { return image; }
        std::vector<nlohmann::json> & get_mutable_image() { return image; }
        void set_image(const std::vector<nlohmann::json> & value) { this->image = value; }

        const Location & get_location() const { return location; }
        Location & get_mutable_location() { return location; }
        void set_location(const Location & value) { this->location = value; }

        const nlohmann::json & get_teaser() const { return teaser; }
        nlohmann::json & get_mutable_teaser() { return teaser; }
        void set_teaser(const nlohmann::json & value) { this->teaser = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::vector<nlohmann::json> & get_topic() const { return topic; }
        std::vector<nlohmann::json> & get_mutable_topic() { return topic; }
        void set_topic(const std::vector<nlohmann::json> & value) { this->topic = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const std::string & get_uuid() const { return uuid; }
        std::string & get_mutable_uuid() { return uuid; }
        void set_uuid(const std::string & value) { this->uuid = value; }

        const std::string & get_vuuid() const { return vuuid; }
        std::string & get_mutable_vuuid() { return vuuid; }
        void set_vuuid(const std::string & value) { this->vuuid = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Metadata metadata;
        std::vector<Result> results;

        public:
        const Metadata & get_metadata() const { return metadata; }
        Metadata & get_mutable_metadata() { return metadata; }
        void set_metadata(const Metadata & value) { this->metadata = value; }

        const std::vector<Result> & get_results() const { return results; }
        std::vector<Result> & get_mutable_results() { return results; }
        void set_results(const std::vector<Result> & value) { this->results = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, ResponseInfo & x);
    void to_json(json & j, const ResponseInfo & x);

    void from_json(const json & j, Resultset & x);
    void to_json(json & j, const Resultset & x);

    void from_json(const json & j, Metadata & x);
    void to_json(json & j, const Metadata & x);

    void from_json(const json & j, Component & x);
    void to_json(json & j, const Component & x);

    void from_json(const json & j, Location & x);
    void to_json(json & j, const Location & x);

    void from_json(const json & j, Result & x);
    void to_json(json & j, const Result & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, ResponseInfo& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_developer_message(j.at("developerMessage").get<std::string>());
        if (j.find("status") != j.end() && !j.at("status").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_status(j.at("status").get<int64_t>());
    }

    inline void to_json(json & j, const ResponseInfo & x) {
        j = json::object();
        j["developerMessage"] = x.get_developer_message();
        j["status"] = x.get_status();
    }

    inline void from_json(const json & j, Resultset& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        if (j.find("page") != j.end() && !j.at("page").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_page(j.at("page").get<int64_t>());
        if (j.find("pagesize") != j.end() && !j.at("pagesize").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_pagesize(j.at("pagesize").get<int64_t>());
    }

    inline void to_json(json & j, const Resultset & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["page"] = x.get_page();
        j["pagesize"] = x.get_pagesize();
    }

    inline void from_json(const json & j, Metadata& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_execution_time(j.at("executionTime").get<double>());
        x.set_response_info(j.at("responseInfo").get<ResponseInfo>());
        x.set_resultset(j.at("resultset").get<Resultset>());
    }

    inline void to_json(json & j, const Metadata & x) {
        j = json::object();
        j["executionTime"] = x.get_execution_time();
        j["responseInfo"] = x.get_response_info();
        j["resultset"] = x.get_resultset();
    }

    inline void from_json(const json & j, Component& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
        if (j.find("uuid") != j.end() && !std::regex_match(j.at("uuid").get<std::string>(), std::regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"))) throw std::runtime_error("Expected UUID");
        x.set_uuid(j.at("uuid").get<std::string>());
    }

    inline void to_json(json & j, const Component & x) {
        j = json::object();
        j["name"] = x.get_name();
        j["uuid"] = x.get_uuid();
    }

    inline void from_json(const json & j, Location& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_administrative_area(j.at("administrative_area").get<std::string>());
        x.set_country(j.at("country").get<std::string>());
        x.set_fax_number(j.at("fax_number").get<std::string>());
        x.set_locality(j.at("locality").get<std::string>());
        x.set_mobile_number(j.at("mobile_number").get<std::string>());
        x.set_phone_number(j.at("phone_number").get<std::string>());
        x.set_phone_number_extension(j.at("phone_number_extension").get<std::string>());
        x.set_postal_code(j.at("postal_code").get<std::string>());
        x.set_sub_premise(get_untyped(j, "sub_premise"));
        x.set_thoroughfare(j.at("thoroughfare").get<std::string>());
    }

    inline void to_json(json & j, const Location & x) {
        j = json::object();
        j["administrative_area"] = x.get_administrative_area();
        j["country"] = x.get_country();
        j["fax_number"] = x.get_fax_number();
        j["locality"] = x.get_locality();
        j["mobile_number"] = x.get_mobile_number();
        j["phone_number"] = x.get_phone_number();
        j["phone_number_extension"] = x.get_phone_number_extension();
        j["postal_code"] = x.get_postal_code();
        j["sub_premise"] = x.get_sub_premise();
        j["thoroughfare"] = x.get_thoroughfare();
    }

    inline void from_json(const json & j, Result& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_attachment(j.at("attachment").get<std::vector<nlohmann::json>>());
        x.set_body(j.at("body").get<std::string>());
        x.set_changed(j.at("changed").get<std::string>());
        x.set_component(j.at("component").get<std::vector<Component>>());
        x.set_created(j.at("created").get<std::string>());
        x.set_date(j.at("date").get<std::string>());
        x.set_image(j.at("image").get<std::vector<nlohmann::json>>());
        x.set_location(j.at("location").get<Location>());
        x.set_teaser(get_untyped(j, "teaser"));
        x.set_title(j.at("title").get<std::string>());
        x.set_topic(j.at("topic").get<std::vector<nlohmann::json>>());
        x.set_url(j.at("url").get<std::string>());
        if (j.find("uuid") != j.end() && !std::regex_match(j.at("uuid").get<std::string>(), std::regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"))) throw std::runtime_error("Expected UUID");
        x.set_uuid(j.at("uuid").get<std::string>());
        if (j.find("vuuid") != j.end() && !std::regex_match(j.at("vuuid").get<std::string>(), std::regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"))) throw std::runtime_error("Expected UUID");
        x.set_vuuid(j.at("vuuid").get<std::string>());
    }

    inline void to_json(json & j, const Result & x) {
        j = json::object();
        j["attachment"] = x.get_attachment();
        j["body"] = x.get_body();
        j["changed"] = x.get_changed();
        j["component"] = x.get_component();
        j["created"] = x.get_created();
        j["date"] = x.get_date();
        j["image"] = x.get_image();
        j["location"] = x.get_location();
        j["teaser"] = x.get_teaser();
        j["title"] = x.get_title();
        j["topic"] = x.get_topic();
        j["url"] = x.get_url();
        j["uuid"] = x.get_uuid();
        j["vuuid"] = x.get_vuuid();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_metadata(j.at("metadata").get<Metadata>());
        x.set_results(j.at("results").get<std::vector<Result>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["metadata"] = x.get_metadata();
        j["results"] = x.get_results();
    }
}
