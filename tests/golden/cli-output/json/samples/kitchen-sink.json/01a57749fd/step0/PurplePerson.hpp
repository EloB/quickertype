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

namespace quicktype {
    using nlohmann::json;

    class PurplePerson {
        public:
        PurplePerson() = default;
        virtual ~PurplePerson() = default;

        private:
        std::string name;
        int64_t int_or_string;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const int64_t & get_int_or_string() const { return int_or_string; }
        int64_t & get_mutable_int_or_string() { return int_or_string; }
        void set_int_or_string(const int64_t & value) { this->int_or_string = value; }
    };
}
