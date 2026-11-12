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

    class Description {
        public:
        Description() = default;
        virtual ~Description() = default;

        private:
        std::string base_period;
        std::string missing;
        std::string title;
        std::string units;

        public:
        const std::string & get_base_period() const { return base_period; }
        std::string & get_mutable_base_period() { return base_period; }
        void set_base_period(const std::string & value) { this->base_period = value; }

        const std::string & get_missing() const { return missing; }
        std::string & get_mutable_missing() { return missing; }
        void set_missing(const std::string & value) { this->missing = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::string & get_units() const { return units; }
        std::string & get_mutable_units() { return units; }
        void set_units(const std::string & value) { this->units = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::map<std::string, std::string> data;
        Description description;

        public:
        const std::map<std::string, std::string> & get_data() const { return data; }
        std::map<std::string, std::string> & get_mutable_data() { return data; }
        void set_data(const std::map<std::string, std::string> & value) { this->data = value; }

        const Description & get_description() const { return description; }
        Description & get_mutable_description() { return description; }
        void set_description(const Description & value) { this->description = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Description & x);
    void to_json(json & j, const Description & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Description& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_base_period(j.at("base_period").get<std::string>());
        x.set_missing(j.at("missing").get<std::string>());
        x.set_title(j.at("title").get<std::string>());
        x.set_units(j.at("units").get<std::string>());
    }

    inline void to_json(json & j, const Description & x) {
        j = json::object();
        j["base_period"] = x.get_base_period();
        j["missing"] = x.get_missing();
        j["title"] = x.get_title();
        j["units"] = x.get_units();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_data(j.at("data").get<std::map<std::string, std::string>>());
        x.set_description(j.at("description").get<Description>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["description"] = x.get_description();
    }
}
