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
        std::string birthday;
        std::string last_seen;
        std::string name;

        public:
        const std::string & get_birthday() const { return birthday; }
        std::string & get_mutable_birthday() { return birthday; }
        void set_birthday(const std::string & value) { this->birthday = value; }

        const std::string & get_last_seen() const { return last_seen; }
        std::string & get_mutable_last_seen() { return last_seen; }
        void set_last_seen(const std::string & value) { this->last_seen = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_birthday(j.at("birthday").get<std::string>());
        if (j.find("lastSeen") != j.end() && !std::regex_match(j.at("lastSeen").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_last_seen(j.at("lastSeen").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["birthday"] = x.get_birthday();
        j["lastSeen"] = x.get_last_seen();
        j["name"] = x.get_name();
    }
}
