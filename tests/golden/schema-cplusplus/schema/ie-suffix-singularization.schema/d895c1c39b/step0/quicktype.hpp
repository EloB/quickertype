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

    class Cookie {
        public:
        Cookie() = default;
        virtual ~Cookie() = default;

        private:
        std::string name;
        std::string value;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_value() const { return value; }
        std::string & get_mutable_value() { return value; }
        void set_value(const std::string & value) { this->value = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Cookie> cookies;

        public:
        const std::vector<Cookie> & get_cookies() const { return cookies; }
        std::vector<Cookie> & get_mutable_cookies() { return cookies; }
        void set_cookies(const std::vector<Cookie> & value) { this->cookies = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Cookie & x);
    void to_json(json & j, const Cookie & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Cookie& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
        x.set_value(j.at("value").get<std::string>());
    }

    inline void to_json(json & j, const Cookie & x) {
        j = json::object();
        j["name"] = x.get_name();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_cookies(j.at("cookies").get<std::vector<Cookie>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["cookies"] = x.get_cookies();
    }
}
