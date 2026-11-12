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
        bool boolean_value;
        double double_value;
        int64_t int_value;
        std::string string_value;
        std::string uuid_value;
        std::vector<std::string> uuid_values;

        public:
        const bool & get_boolean_value() const { return boolean_value; }
        bool & get_mutable_boolean_value() { return boolean_value; }
        void set_boolean_value(const bool & value) { this->boolean_value = value; }

        const double & get_double_value() const { return double_value; }
        double & get_mutable_double_value() { return double_value; }
        void set_double_value(const double & value) { this->double_value = value; }

        const int64_t & get_int_value() const { return int_value; }
        int64_t & get_mutable_int_value() { return int_value; }
        void set_int_value(const int64_t & value) { this->int_value = value; }

        const std::string & get_string_value() const { return string_value; }
        std::string & get_mutable_string_value() { return string_value; }
        void set_string_value(const std::string & value) { this->string_value = value; }

        const std::string & get_uuid_value() const { return uuid_value; }
        std::string & get_mutable_uuid_value() { return uuid_value; }
        void set_uuid_value(const std::string & value) { this->uuid_value = value; }

        const std::vector<std::string> & get_uuid_values() const { return uuid_values; }
        std::vector<std::string> & get_mutable_uuid_values() { return uuid_values; }
        void set_uuid_values(const std::vector<std::string> & value) { this->uuid_values = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_boolean_value(j.at("booleanValue").get<bool>());
        x.set_double_value(j.at("doubleValue").get<double>());
        if (j.find("intValue") != j.end() && !j.at("intValue").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_int_value(j.at("intValue").get<int64_t>());
        x.set_string_value(j.at("stringValue").get<std::string>());
        if (j.find("uuidValue") != j.end() && !std::regex_match(j.at("uuidValue").get<std::string>(), std::regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"))) throw std::runtime_error("Expected UUID");
        x.set_uuid_value(j.at("uuidValue").get<std::string>());
        x.set_uuid_values(j.at("uuidValues").get<std::vector<std::string>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["booleanValue"] = x.get_boolean_value();
        j["doubleValue"] = x.get_double_value();
        j["intValue"] = x.get_int_value();
        j["stringValue"] = x.get_string_value();
        j["uuidValue"] = x.get_uuid_value();
        j["uuidValues"] = x.get_uuid_values();
    }
}
