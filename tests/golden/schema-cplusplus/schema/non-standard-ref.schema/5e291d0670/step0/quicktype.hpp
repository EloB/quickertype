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
        int64_t bar;
        int64_t foo;
        bool quux;

        public:
        const int64_t & get_bar() const { return bar; }
        int64_t & get_mutable_bar() { return bar; }
        void set_bar(const int64_t & value) { this->bar = value; }

        const int64_t & get_foo() const { return foo; }
        int64_t & get_mutable_foo() { return foo; }
        void set_foo(const int64_t & value) { this->foo = value; }

        const bool & get_quux() const { return quux; }
        bool & get_mutable_quux() { return quux; }
        void set_quux(const bool & value) { this->quux = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bar") != j.end() && !j.at("bar").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bar(j.at("bar").get<int64_t>());
        if (j.find("foo") != j.end() && !j.at("foo").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_foo(j.at("foo").get<int64_t>());
        x.set_quux(j.at("quux").get<bool>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bar"] = x.get_bar();
        j["foo"] = x.get_foo();
        j["quux"] = x.get_quux();
    }
}
