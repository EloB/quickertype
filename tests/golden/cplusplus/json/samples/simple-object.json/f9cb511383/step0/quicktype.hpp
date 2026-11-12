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
        int64_t date;
        std::string title;
        bool validity;

        public:
        const int64_t & get_date() const { return date; }
        int64_t & get_mutable_date() { return date; }
        void set_date(const int64_t & value) { this->date = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const bool & get_validity() const { return validity; }
        bool & get_mutable_validity() { return validity; }
        void set_validity(const bool & value) { this->validity = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("date") != j.end() && !j.at("date").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_date(j.at("date").get<int64_t>());
        x.set_title(j.at("title").get<std::string>());
        x.set_validity(j.at("validity").get<bool>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["date"] = x.get_date();
        j["title"] = x.get_title();
        j["validity"] = x.get_validity();
    }
}
