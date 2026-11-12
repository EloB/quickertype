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

    class TotalPopulation {
        public:
        TotalPopulation() = default;
        virtual ~TotalPopulation() = default;

        private:
        std::string date;
        int64_t population;

        public:
        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const int64_t & get_population() const { return population; }
        int64_t & get_mutable_population() { return population; }
        void set_population(const int64_t & value) { this->population = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<TotalPopulation> total_population;

        public:
        const std::vector<TotalPopulation> & get_total_population() const { return total_population; }
        std::vector<TotalPopulation> & get_mutable_total_population() { return total_population; }
        void set_total_population(const std::vector<TotalPopulation> & value) { this->total_population = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TotalPopulation & x);
    void to_json(json & j, const TotalPopulation & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TotalPopulation& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_date(j.at("date").get<std::string>());
        if (j.find("population") != j.end() && !j.at("population").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_population(j.at("population").get<int64_t>());
    }

    inline void to_json(json & j, const TotalPopulation & x) {
        j = json::object();
        j["date"] = x.get_date();
        j["population"] = x.get_population();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_total_population(j.at("total_population").get<std::vector<TotalPopulation>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["total_population"] = x.get_total_population();
    }
}
