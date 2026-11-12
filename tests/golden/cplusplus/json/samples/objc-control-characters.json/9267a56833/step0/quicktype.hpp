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

    enum class Value : int { C0, C1 };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string literal;
        int64_t the_11;
        std::vector<Value> values;

        public:
        const std::string & get_literal() const { return literal; }
        std::string & get_mutable_literal() { return literal; }
        void set_literal(const std::string & value) { this->literal = value; }

        const int64_t & get_the_11() const { return the_11; }
        int64_t & get_mutable_the_11() { return the_11; }
        void set_the_11(const int64_t & value) { this->the_11 = value; }

        const std::vector<Value> & get_values() const { return values; }
        std::vector<Value> & get_mutable_values() { return values; }
        void set_values(const std::vector<Value> & value) { this->values = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Value & x);
    void to_json(json & j, const Value & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_literal(j.at("literal").get<std::string>());
        if (j.find("#{1+1}") != j.end() && !j.at("#{1+1}").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_the_11(j.at("#{1+1}").get<int64_t>());
        x.set_values(j.at("values").get<std::vector<Value>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["literal"] = x.get_literal();
        j["#{1+1}"] = x.get_the_11();
        j["values"] = x.get_values();
    }

    inline void from_json(const json & j, Value & x) {
        if (j == "c0\u0001\u001b\u001f") x = Value::C0;
        else if (j == "c1\u007f\u0080\u0085\u009f") x = Value::C1;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Value\""); }
    }

    inline void to_json(json & j, const Value & x) {
        switch (x) {
            case Value::C0: j = "c0\u0001\u001b\u001f"; break;
            case Value::C1: j = "c1\u007f\u0080\u0085\u009f"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Value\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
