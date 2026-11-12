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

    class Street {
        public:
        Street() = default;
        virtual ~Street() = default;

        private:
        int64_t id;
        std::string name;

        public:
        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class Location {
        public:
        Location() = default;
        virtual ~Location() = default;

        private:
        std::string latitude;
        std::string longitude;
        Street street;

        public:
        const std::string & get_latitude() const { return latitude; }
        std::string & get_mutable_latitude() { return latitude; }
        void set_latitude(const std::string & value) { this->latitude = value; }

        const std::string & get_longitude() const { return longitude; }
        std::string & get_mutable_longitude() { return longitude; }
        void set_longitude(const std::string & value) { this->longitude = value; }

        const Street & get_street() const { return street; }
        Street & get_mutable_street() { return street; }
        void set_street(const Street & value) { this->street = value; }
    };

    class OutcomeStatus {
        public:
        OutcomeStatus() = default;
        virtual ~OutcomeStatus() = default;

        private:
        std::string category;
        std::string date;

        public:
        const std::string & get_category() const { return category; }
        std::string & get_mutable_category() { return category; }
        void set_category(const std::string & value) { this->category = value; }

        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }
    };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        std::string category;
        std::string context;
        int64_t id;
        Location location;
        std::string location_subtype;
        std::string location_type;
        std::string month;
        OutcomeStatus outcome_status;
        std::string persistent_id;

        public:
        const std::string & get_category() const { return category; }
        std::string & get_mutable_category() { return category; }
        void set_category(const std::string & value) { this->category = value; }

        const std::string & get_context() const { return context; }
        std::string & get_mutable_context() { return context; }
        void set_context(const std::string & value) { this->context = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const Location & get_location() const { return location; }
        Location & get_mutable_location() { return location; }
        void set_location(const Location & value) { this->location = value; }

        const std::string & get_location_subtype() const { return location_subtype; }
        std::string & get_mutable_location_subtype() { return location_subtype; }
        void set_location_subtype(const std::string & value) { this->location_subtype = value; }

        const std::string & get_location_type() const { return location_type; }
        std::string & get_mutable_location_type() { return location_type; }
        void set_location_type(const std::string & value) { this->location_type = value; }

        const std::string & get_month() const { return month; }
        std::string & get_mutable_month() { return month; }
        void set_month(const std::string & value) { this->month = value; }

        const OutcomeStatus & get_outcome_status() const { return outcome_status; }
        OutcomeStatus & get_mutable_outcome_status() { return outcome_status; }
        void set_outcome_status(const OutcomeStatus & value) { this->outcome_status = value; }

        const std::string & get_persistent_id() const { return persistent_id; }
        std::string & get_mutable_persistent_id() { return persistent_id; }
        void set_persistent_id(const std::string & value) { this->persistent_id = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, Street & x);
    void to_json(json & j, const Street & x);

    void from_json(const json & j, Location & x);
    void to_json(json & j, const Location & x);

    void from_json(const json & j, OutcomeStatus & x);
    void to_json(json & j, const OutcomeStatus & x);

    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    inline void from_json(const json & j, Street& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const Street & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, Location& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_latitude(j.at("latitude").get<std::string>());
        x.set_longitude(j.at("longitude").get<std::string>());
        x.set_street(j.at("street").get<Street>());
    }

    inline void to_json(json & j, const Location & x) {
        j = json::object();
        j["latitude"] = x.get_latitude();
        j["longitude"] = x.get_longitude();
        j["street"] = x.get_street();
    }

    inline void from_json(const json & j, OutcomeStatus& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_category(j.at("category").get<std::string>());
        x.set_date(j.at("date").get<std::string>());
    }

    inline void to_json(json & j, const OutcomeStatus & x) {
        j = json::object();
        j["category"] = x.get_category();
        j["date"] = x.get_date();
    }

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_category(j.at("category").get<std::string>());
        x.set_context(j.at("context").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_location(j.at("location").get<Location>());
        x.set_location_subtype(j.at("location_subtype").get<std::string>());
        x.set_location_type(j.at("location_type").get<std::string>());
        x.set_month(j.at("month").get<std::string>());
        x.set_outcome_status(j.at("outcome_status").get<OutcomeStatus>());
        x.set_persistent_id(j.at("persistent_id").get<std::string>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["category"] = x.get_category();
        j["context"] = x.get_context();
        j["id"] = x.get_id();
        j["location"] = x.get_location();
        j["location_subtype"] = x.get_location_subtype();
        j["location_type"] = x.get_location_type();
        j["month"] = x.get_month();
        j["outcome_status"] = x.get_outcome_status();
        j["persistent_id"] = x.get_persistent_id();
    }
}
