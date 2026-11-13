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

#include "TopLevel.hpp"
#include "PurplePerson.hpp"
#include "PersonElement.hpp"
#include "IntOrString.hpp"
#include "DifferentThingElement.hpp"
#include "DifferentThingClass.hpp"

namespace quicktype {
void from_json(const json & j, DifferentThingClass & x);
void to_json(json & j, const DifferentThingClass & x);

void from_json(const json & j, PersonElement & x);
void to_json(json & j, const PersonElement & x);

void from_json(const json & j, PurplePerson & x);
void to_json(json & j, const PurplePerson & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::DifferentThingClass, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::DifferentThingClass, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::DifferentThingClass, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(const json & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, DifferentThingClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const DifferentThingClass & x) {
        j = json::object();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, PersonElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
        x.set_int_or_string(j.at("intOrString").get<IntOrString>());
        if (j.find("optionalValue") != j.end() && j.at("optionalValue").is_null()) throw std::runtime_error("Unexpected null");
        x.set_optional_value(get_stack_optional<bool>(j, "optionalValue"));
    }

    inline void to_json(json & j, const PersonElement & x) {
        j = json::object();
        j["name"] = x.get_name();
        j["intOrString"] = x.get_int_or_string();
        j["optionalValue"] = x.get_optional_value();
    }

    inline void from_json(const json & j, PurplePerson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
        if (j.find("intOrString") != j.end() && !j.at("intOrString").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_int_or_string(j.at("intOrString").get<int64_t>());
    }

    inline void to_json(json & j, const PurplePerson & x) {
        j = json::object();
        j["name"] = x.get_name();
        j["intOrString"] = x.get_int_or_string();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_string_value(j.at("stringValue").get<std::string>());
        x.set_date_value(j.at("dateValue").get<std::string>());
        x.set_uuid_value(j.at("uuidValue").get<std::string>());
        x.set_name_with_spaces(get_untyped(j, "name with spaces"));
        x.set_double_value(j.at("doubleValue").get<double>());
        if (j.find("intValue") != j.end() && !j.at("intValue").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_int_value(j.at("intValue").get<int64_t>());
        x.set_boolean_value(j.at("booleanValue").get<bool>());
        x.set_null_value(get_untyped(j, "nullValue"));
        x.set_tuples(j.at("tuples").get<std::vector<std::vector<IntOrString>>>());
        x.set_person(j.at("person").get<PurplePerson>());
        x.set_people(j.at("people").get<std::vector<PersonElement>>());
        x.set_different_things(j.at("differentThings").get<std::vector<DifferentThingElement>>());
        x.set_map_value(j.at("mapValue").get<std::map<std::string, std::optional<int64_t>>>());
        x.set_nullable_map_value(j.at("nullableMapValue").get<std::map<std::string, std::optional<int64_t>>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["stringValue"] = x.get_string_value();
        j["dateValue"] = x.get_date_value();
        j["uuidValue"] = x.get_uuid_value();
        j["name with spaces"] = x.get_name_with_spaces();
        j["doubleValue"] = x.get_double_value();
        j["intValue"] = x.get_int_value();
        j["booleanValue"] = x.get_boolean_value();
        j["nullValue"] = x.get_null_value();
        j["tuples"] = x.get_tuples();
        j["person"] = x.get_person();
        j["people"] = x.get_people();
        j["differentThings"] = x.get_different_things();
        j["mapValue"] = x.get_map_value();
        j["nullableMapValue"] = x.get_nullable_map_value();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::DifferentThingClass, int64_t, std::string>>::from_json(const json & j, std::variant<quicktype::DifferentThingClass, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::DifferentThingClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DifferentThingClass, int64_t, std::string>>::to_json(json & j, const std::variant<quicktype::DifferentThingClass, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DifferentThingClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<int64_t, std::string>>::from_json(const json & j, std::variant<int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::string>>::to_json(json & j, const std::variant<int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<int64_t>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
