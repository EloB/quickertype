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
        bool boolean;
        int64_t integer;
        std::vector<int64_t> integers;
        double number;
        std::string string;

        public:
        const bool & get_boolean() const { return boolean; }
        bool & get_mutable_boolean() { return boolean; }
        void set_boolean(const bool & value) { this->boolean = value; }

        const int64_t & get_integer() const { return integer; }
        int64_t & get_mutable_integer() { return integer; }
        void set_integer(const int64_t & value) { this->integer = value; }

        const std::vector<int64_t> & get_integers() const { return integers; }
        std::vector<int64_t> & get_mutable_integers() { return integers; }
        void set_integers(const std::vector<int64_t> & value) { this->integers = value; }

        const double & get_number() const { return number; }
        double & get_mutable_number() { return number; }
        void set_number(const double & value) { this->number = value; }

        const std::string & get_string() const { return string; }
        std::string & get_mutable_string() { return string; }
        void set_string(const std::string & value) { this->string = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_boolean(j.at("boolean").get<bool>());
        if (j.find("integer") != j.end() && !j.at("integer").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_integer(j.at("integer").get<int64_t>());
        x.set_integers(j.at("integers").get<std::vector<int64_t>>());
        x.set_number(j.at("number").get<double>());
        x.set_string(j.at("string").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["boolean"] = x.get_boolean();
        j["integer"] = x.get_integer();
        j["integers"] = x.get_integers();
        j["number"] = x.get_number();
        j["string"] = x.get_string();
    }
}
