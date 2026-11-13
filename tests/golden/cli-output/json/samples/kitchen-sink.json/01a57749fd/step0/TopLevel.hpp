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
#include "PurplePerson.hpp"
#include "PersonElement.hpp"
#include "DifferentThingElement.hpp"
#include "DifferentThingClass.hpp"

namespace quicktype {
    using nlohmann::json;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string string_value;
        std::string date_value;
        std::string uuid_value;
        nlohmann::json name_with_spaces;
        double double_value;
        int64_t int_value;
        bool boolean_value;
        nlohmann::json null_value;
        std::vector<std::vector<IntOrString>> tuples;
        PurplePerson person;
        std::vector<PersonElement> people;
        std::vector<DifferentThingElement> different_things;
        std::map<std::string, std::optional<int64_t>> map_value;
        std::map<std::string, std::optional<int64_t>> nullable_map_value;

        public:
        const std::string & get_string_value() const { return string_value; }
        std::string & get_mutable_string_value() { return string_value; }
        void set_string_value(const std::string & value) { this->string_value = value; }

        const std::string & get_date_value() const { return date_value; }
        std::string & get_mutable_date_value() { return date_value; }
        void set_date_value(const std::string & value) { this->date_value = value; }

        const std::string & get_uuid_value() const { return uuid_value; }
        std::string & get_mutable_uuid_value() { return uuid_value; }
        void set_uuid_value(const std::string & value) { this->uuid_value = value; }

        const nlohmann::json & get_name_with_spaces() const { return name_with_spaces; }
        nlohmann::json & get_mutable_name_with_spaces() { return name_with_spaces; }
        void set_name_with_spaces(const nlohmann::json & value) { this->name_with_spaces = value; }

        const double & get_double_value() const { return double_value; }
        double & get_mutable_double_value() { return double_value; }
        void set_double_value(const double & value) { this->double_value = value; }

        const int64_t & get_int_value() const { return int_value; }
        int64_t & get_mutable_int_value() { return int_value; }
        void set_int_value(const int64_t & value) { this->int_value = value; }

        const bool & get_boolean_value() const { return boolean_value; }
        bool & get_mutable_boolean_value() { return boolean_value; }
        void set_boolean_value(const bool & value) { this->boolean_value = value; }

        const nlohmann::json & get_null_value() const { return null_value; }
        nlohmann::json & get_mutable_null_value() { return null_value; }
        void set_null_value(const nlohmann::json & value) { this->null_value = value; }

        const std::vector<std::vector<IntOrString>> & get_tuples() const { return tuples; }
        std::vector<std::vector<IntOrString>> & get_mutable_tuples() { return tuples; }
        void set_tuples(const std::vector<std::vector<IntOrString>> & value) { this->tuples = value; }

        const PurplePerson & get_person() const { return person; }
        PurplePerson & get_mutable_person() { return person; }
        void set_person(const PurplePerson & value) { this->person = value; }

        const std::vector<PersonElement> & get_people() const { return people; }
        std::vector<PersonElement> & get_mutable_people() { return people; }
        void set_people(const std::vector<PersonElement> & value) { this->people = value; }

        const std::vector<DifferentThingElement> & get_different_things() const { return different_things; }
        std::vector<DifferentThingElement> & get_mutable_different_things() { return different_things; }
        void set_different_things(const std::vector<DifferentThingElement> & value) { this->different_things = value; }

        const std::map<std::string, std::optional<int64_t>> & get_map_value() const { return map_value; }
        std::map<std::string, std::optional<int64_t>> & get_mutable_map_value() { return map_value; }
        void set_map_value(const std::map<std::string, std::optional<int64_t>> & value) { this->map_value = value; }

        const std::map<std::string, std::optional<int64_t>> & get_nullable_map_value() const { return nullable_map_value; }
        std::map<std::string, std::optional<int64_t>> & get_mutable_nullable_map_value() { return nullable_map_value; }
        void set_nullable_map_value(const std::map<std::string, std::optional<int64_t>> & value) { this->nullable_map_value = value; }
    };
}
