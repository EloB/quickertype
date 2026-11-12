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
        nlohmann::json foo;
        std::map<std::string, nlohmann::json> values;

        public:
        const nlohmann::json & get_foo() const { return foo; }
        nlohmann::json & get_mutable_foo() { return foo; }
        void set_foo(const nlohmann::json & value) { this->foo = value; }

        const std::map<std::string, nlohmann::json> & get_values() const { return values; }
        std::map<std::string, nlohmann::json> & get_mutable_values() { return values; }
        void set_values(const std::map<std::string, nlohmann::json> & value) { this->values = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_foo(get_untyped(j, "foo"));
        x.set_values(j.at("values").get<std::map<std::string, nlohmann::json>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["foo"] = x.get_foo();
        j["values"] = x.get_values();
    }
}
