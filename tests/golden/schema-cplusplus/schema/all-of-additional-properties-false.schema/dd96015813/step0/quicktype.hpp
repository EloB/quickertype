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

#include <optional>
#include <stdexcept>
#include <regex>

#ifndef NLOHMANN_OPT_HELPER
#define NLOHMANN_OPT_HELPER
namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::shared_ptr<T>> {
        static void to_json(json & j, const std::shared_ptr<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(const json & j) {
            if (j.is_null()) return std::shared_ptr<T>(); else return std::make_shared<T>(j.get<T>());
        }
    };
    template <typename T>
    struct adl_serializer<std::optional<T>> {
        static void to_json(json & j, const std::optional<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::optional<T> from_json(const json & j) {
            if (j.is_null()) return std::optional<T>(); else return std::make_optional<T>(j.get<T>());
        }
    };
}
#endif

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

    #ifndef NLOHMANN_OPTIONAL_quicktype_HELPER
    #define NLOHMANN_OPTIONAL_quicktype_HELPER
    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, std::string property) {
        return get_heap_optional<T>(j, property.data());
    }
    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::optional<T>>();
        }
        return std::optional<T>();
    }

    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    enum class Frequency : int { WEEKLY, MONTHLY, ANNUALLY };

    enum class Type : int { GROSS_SALARY_AMOUNT, OVERTIME };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        double amount;
        Frequency frequency;
        std::optional<std::string> description;
        Type type;

        public:
        const double & get_amount() const { return amount; }
        double & get_mutable_amount() { return amount; }
        void set_amount(const double & value) { this->amount = value; }

        const Frequency & get_frequency() const { return frequency; }
        Frequency & get_mutable_frequency() { return frequency; }
        void set_frequency(const Frequency & value) { this->frequency = value; }

        const std::optional<std::string> & get_description() const { return description; }
        std::optional<std::string> & get_mutable_description() { return description; }
        void set_description(const std::optional<std::string> & value) { this->description = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Frequency & x);
    void to_json(json & j, const Frequency & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_amount(j.at("amount").get<double>());
        x.set_frequency(j.at("frequency").get<Frequency>());
        if (j.find("description") != j.end() && j.at("description").is_null()) throw std::runtime_error("Unexpected null");
        x.set_description(get_stack_optional<std::string>(j, "description"));
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["amount"] = x.get_amount();
        j["frequency"] = x.get_frequency();
        j["description"] = x.get_description();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Frequency & x) {
        if (j == "Weekly") x = Frequency::WEEKLY;
        else if (j == "Monthly") x = Frequency::MONTHLY;
        else if (j == "Annually") x = Frequency::ANNUALLY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Frequency\""); }
    }

    inline void to_json(json & j, const Frequency & x) {
        switch (x) {
            case Frequency::WEEKLY: j = "Weekly"; break;
            case Frequency::MONTHLY: j = "Monthly"; break;
            case Frequency::ANNUALLY: j = "Annually"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Frequency\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "GrossSalaryAmount") x = Type::GROSS_SALARY_AMOUNT;
        else if (j == "Overtime") x = Type::OVERTIME;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::GROSS_SALARY_AMOUNT: j = "GrossSalaryAmount"; break;
            case Type::OVERTIME: j = "Overtime"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
