//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include <variant>
#include "json.hpp"
#include "helper.hpp"

#include "IntOrString.hpp"

namespace quicktype {
    using nlohmann::json;

    class PersonElement {
        public:
        PersonElement() = default;
        virtual ~PersonElement() = default;

        private:
        std::string name;
        IntOrString int_or_string;
        std::optional<bool> optional_value;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const IntOrString & get_int_or_string() const { return int_or_string; }
        IntOrString & get_mutable_int_or_string() { return int_or_string; }
        void set_int_or_string(const IntOrString & value) { this->int_or_string = value; }

        const std::optional<bool> & get_optional_value() const { return optional_value; }
        std::optional<bool> & get_mutable_optional_value() { return optional_value; }
        void set_optional_value(const std::optional<bool> & value) { this->optional_value = value; }
    };
}
