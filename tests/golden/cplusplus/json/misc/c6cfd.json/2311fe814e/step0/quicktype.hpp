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

    class Country {
        public:
        Country() = default;
        virtual ~Country() = default;

        private:
        std::string code;
        std::string name;

        public:
        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Country> countries;

        public:
        const std::vector<Country> & get_countries() const { return countries; }
        std::vector<Country> & get_mutable_countries() { return countries; }
        void set_countries(const std::vector<Country> & value) { this->countries = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Country & x);
    void to_json(json & j, const Country & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Country& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const Country & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_countries(j.at("countries").get<std::vector<Country>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["countries"] = x.get_countries();
    }
}
