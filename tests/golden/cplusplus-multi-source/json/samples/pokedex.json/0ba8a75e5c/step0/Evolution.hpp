//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include "json.hpp"
#include "helper.hpp"

namespace quicktype {
    using nlohmann::json;

    class Evolution {
        public:
        Evolution() = default;
        virtual ~Evolution() = default;

        private:
        std::string name;
        std::string num;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_num() const { return num; }
        std::string & get_mutable_num() { return num; }
        void set_num(const std::string & value) { this->num = value; }
    };
}
