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

    enum class Country : int { UNITED_STATES };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        int64_t age;
        Country country;
        int64_t females;
        int64_t males;
        int64_t total;
        int64_t year;

        public:
        const int64_t & get_age() const { return age; }
        int64_t & get_mutable_age() { return age; }
        void set_age(const int64_t & value) { this->age = value; }

        const Country & get_country() const { return country; }
        Country & get_mutable_country() { return country; }
        void set_country(const Country & value) { this->country = value; }

        const int64_t & get_females() const { return females; }
        int64_t & get_mutable_females() { return females; }
        void set_females(const int64_t & value) { this->females = value; }

        const int64_t & get_males() const { return males; }
        int64_t & get_mutable_males() { return males; }
        void set_males(const int64_t & value) { this->males = value; }

        const int64_t & get_total() const { return total; }
        int64_t & get_mutable_total() { return total; }
        void set_total(const int64_t & value) { this->total = value; }

        const int64_t & get_year() const { return year; }
        int64_t & get_mutable_year() { return year; }
        void set_year(const int64_t & value) { this->year = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, Country & x);
    void to_json(json & j, const Country & x);

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("age") != j.end() && !j.at("age").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_age(j.at("age").get<int64_t>());
        x.set_country(j.at("country").get<Country>());
        if (j.find("females") != j.end() && !j.at("females").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_females(j.at("females").get<int64_t>());
        if (j.find("males") != j.end() && !j.at("males").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_males(j.at("males").get<int64_t>());
        if (j.find("total") != j.end() && !j.at("total").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total(j.at("total").get<int64_t>());
        if (j.find("year") != j.end() && !j.at("year").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_year(j.at("year").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["age"] = x.get_age();
        j["country"] = x.get_country();
        j["females"] = x.get_females();
        j["males"] = x.get_males();
        j["total"] = x.get_total();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, Country & x) {
        if (j == "United States") x = Country::UNITED_STATES;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Country\""); }
    }

    inline void to_json(json & j, const Country & x) {
        switch (x) {
            case Country::UNITED_STATES: j = "United States"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Country\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
