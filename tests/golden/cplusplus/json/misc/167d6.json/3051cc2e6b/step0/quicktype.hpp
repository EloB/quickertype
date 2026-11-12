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

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string base;
        std::string date;
        std::map<std::string, double> rates;

        public:
        const std::string & get_base() const { return base; }
        std::string & get_mutable_base() { return base; }
        void set_base(const std::string & value) { this->base = value; }

        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const std::map<std::string, double> & get_rates() const { return rates; }
        std::map<std::string, double> & get_mutable_rates() { return rates; }
        void set_rates(const std::map<std::string, double> & value) { this->rates = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_base(j.at("base").get<std::string>());
        x.set_date(j.at("date").get<std::string>());
        x.set_rates(j.at("rates").get<std::map<std::string, double>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["base"] = x.get_base();
        j["date"] = x.get_date();
        j["rates"] = x.get_rates();
    }
}
