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

    class Facets {
        public:
        Facets() = default;
        virtual ~Facets() = default;

        private:

        public:
    };

    enum class Status : int { INACTIVE, ACTIVE };

    class Result {
        public:
        Result() = default;
        virtual ~Result() = default;

        private:
        std::string created_at;
        std::string id;
        std::string person_id;
        std::string representative_id;
        Status status;
        std::string updated_at;

        public:
        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::string & get_person_id() const { return person_id; }
        std::string & get_mutable_person_id() { return person_id; }
        void set_person_id(const std::string & value) { this->person_id = value; }

        const std::string & get_representative_id() const { return representative_id; }
        std::string & get_mutable_representative_id() { return representative_id; }
        void set_representative_id(const std::string & value) { this->representative_id = value; }

        const Status & get_status() const { return status; }
        Status & get_mutable_status() { return status; }
        void set_status(const Status & value) { this->status = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        int64_t count;
        Facets facets;
        int64_t limit;
        std::string next;
        int64_t offset;
        bool previous;
        std::vector<Result> results;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const Facets & get_facets() const { return facets; }
        Facets & get_mutable_facets() { return facets; }
        void set_facets(const Facets & value) { this->facets = value; }

        const int64_t & get_limit() const { return limit; }
        int64_t & get_mutable_limit() { return limit; }
        void set_limit(const int64_t & value) { this->limit = value; }

        const std::string & get_next() const { return next; }
        std::string & get_mutable_next() { return next; }
        void set_next(const std::string & value) { this->next = value; }

        const int64_t & get_offset() const { return offset; }
        int64_t & get_mutable_offset() { return offset; }
        void set_offset(const int64_t & value) { this->offset = value; }

        const bool & get_previous() const { return previous; }
        bool & get_mutable_previous() { return previous; }
        void set_previous(const bool & value) { this->previous = value; }

        const std::vector<Result> & get_results() const { return results; }
        std::vector<Result> & get_mutable_results() { return results; }
        void set_results(const std::vector<Result> & value) { this->results = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Facets & x);
    void to_json(json & j, const Facets & x);

    void from_json(const json & j, Result & x);
    void to_json(json & j, const Result & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Status & x);
    void to_json(json & j, const Status & x);

    inline void from_json(const json & j, Facets& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Facets & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Result& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_person_id(j.at("person_id").get<std::string>());
        x.set_representative_id(j.at("representative_id").get<std::string>());
        x.set_status(j.at("status").get<Status>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
    }

    inline void to_json(json & j, const Result & x) {
        j = json::object();
        j["created_at"] = x.get_created_at();
        j["id"] = x.get_id();
        j["person_id"] = x.get_person_id();
        j["representative_id"] = x.get_representative_id();
        j["status"] = x.get_status();
        j["updated_at"] = x.get_updated_at();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        x.set_facets(j.at("facets").get<Facets>());
        if (j.find("limit") != j.end() && !j.at("limit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_limit(j.at("limit").get<int64_t>());
        x.set_next(j.at("next").get<std::string>());
        if (j.find("offset") != j.end() && !j.at("offset").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_offset(j.at("offset").get<int64_t>());
        x.set_previous(j.at("previous").get<bool>());
        x.set_results(j.at("results").get<std::vector<Result>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["facets"] = x.get_facets();
        j["limit"] = x.get_limit();
        j["next"] = x.get_next();
        j["offset"] = x.get_offset();
        j["previous"] = x.get_previous();
        j["results"] = x.get_results();
    }

    inline void from_json(const json & j, Status & x) {
        if (j == "inactive") x = Status::INACTIVE;
        else if (j == "active") x = Status::ACTIVE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Status\""); }
    }

    inline void to_json(json & j, const Status & x) {
        switch (x) {
            case Status::INACTIVE: j = "inactive"; break;
            case Status::ACTIVE: j = "active"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Status\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
