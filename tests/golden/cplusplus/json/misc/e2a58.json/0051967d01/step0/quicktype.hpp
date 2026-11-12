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

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        std::string date;
        std::vector<std::string> stop_and_search;

        public:
        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const std::vector<std::string> & get_stop_and_search() const { return stop_and_search; }
        std::vector<std::string> & get_mutable_stop_and_search() { return stop_and_search; }
        void set_stop_and_search(const std::vector<std::string> & value) { this->stop_and_search = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_date(j.at("date").get<std::string>());
        x.set_stop_and_search(j.at("stop-and-search").get<std::vector<std::string>>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["date"] = x.get_date();
        j["stop-and-search"] = x.get_stop_and_search();
    }
}
