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

    enum class X : int { THREE, ONE, TWO };

    class Bar {
        public:
        Bar() = default;
        virtual ~Bar() = default;

        private:
        X x;

        public:
        const X & get_x() const { return x; }
        X & get_mutable_x() { return x; }
        void set_x(const X & value) { this->x = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Bar> bar;
        std::vector<Bar> foo;

        public:
        const std::vector<Bar> & get_bar() const { return bar; }
        std::vector<Bar> & get_mutable_bar() { return bar; }
        void set_bar(const std::vector<Bar> & value) { this->bar = value; }

        const std::vector<Bar> & get_foo() const { return foo; }
        std::vector<Bar> & get_mutable_foo() { return foo; }
        void set_foo(const std::vector<Bar> & value) { this->foo = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Bar & x);
    void to_json(json & j, const Bar & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, X & x);
    void to_json(json & j, const X & x);

    inline void from_json(const json & j, Bar& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_x(j.at("x").get<X>());
    }

    inline void to_json(json & j, const Bar & x) {
        j = json::object();
        j["x"] = x.get_x();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bar(j.at("bar").get<std::vector<Bar>>());
        x.set_foo(j.at("foo").get<std::vector<Bar>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bar"] = x.get_bar();
        j["foo"] = x.get_foo();
    }

    inline void from_json(const json & j, X & x) {
        if (j == "three") x = X::THREE;
        else if (j == "one") x = X::ONE;
        else if (j == "two") x = X::TWO;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"X\""); }
    }

    inline void to_json(json & j, const X & x) {
        switch (x) {
            case X::THREE: j = "three"; break;
            case X::ONE: j = "one"; break;
            case X::TWO: j = "two"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"X\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
