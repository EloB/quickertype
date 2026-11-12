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
        int64_t id;
        std::string sponsor;
        std::string title;

        public:
        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_sponsor() const { return sponsor; }
        std::string & get_mutable_sponsor() { return sponsor; }
        void set_sponsor(const std::string & value) { this->sponsor = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Date") != j.end() && !std::regex_match(j.at("Date").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_date(j.at("Date").get<std::string>());
        if (j.find("ID") != j.end() && !j.at("ID").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("ID").get<int64_t>());
        x.set_sponsor(j.at("Sponsor").get<std::string>());
        x.set_title(j.at("Title").get<std::string>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["Date"] = x.get_date();
        j["ID"] = x.get_id();
        j["Sponsor"] = x.get_sponsor();
        j["Title"] = x.get_title();
    }
}
