//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <variant>
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

    enum class Enum : int { FIRE, GRASS, BLUE };

    using Union = std::variant<bool, double>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string barre;
        Enum enumerification;
        std::string foo;
        Union unionization;

        public:
        const std::string & get_barre() const { return barre; }
        std::string & get_mutable_barre() { return barre; }
        void set_barre(const std::string & value) { this->barre = value; }

        const Enum & get_enumerification() const { return enumerification; }
        Enum & get_mutable_enumerification() { return enumerification; }
        void set_enumerification(const Enum & value) { this->enumerification = value; }

        const std::string & get_foo() const { return foo; }
        std::string & get_mutable_foo() { return foo; }
        void set_foo(const std::string & value) { this->foo = value; }

        const Union & get_unionization() const { return unionization; }
        Union & get_mutable_unionization() { return unionization; }
        void set_unionization(const Union & value) { this->unionization = value; }
    };
}

namespace quicktype {
void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, Enum & x);
void to_json(json & j, const Enum & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(const json & j, std::variant<bool, double> & x);
    static void to_json(json & j, const std::variant<bool, double> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_barre(j.at("bar").get<std::string>());
        x.set_enumerification(j.at("enum").get<Enum>());
        x.set_foo(j.at("foo").get<std::string>());
        x.set_unionization(j.at("union").get<Union>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bar"] = x.get_barre();
        j["enum"] = x.get_enumerification();
        j["foo"] = x.get_foo();
        j["union"] = x.get_unionization();
    }

    inline void from_json(const json & j, Enum & x) {
        if (j == "red") x = Enum::FIRE;
        else if (j == "green") x = Enum::GRASS;
        else if (j == "blue") x = Enum::BLUE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Enum\""); }
    }

    inline void to_json(json & j, const Enum & x) {
        switch (x) {
            case Enum::FIRE: j = "red"; break;
            case Enum::GRASS: j = "green"; break;
            case Enum::BLUE: j = "blue"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Enum\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, double>>::from_json(const json & j, std::variant<bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double>>::to_json(json & j, const std::variant<bool, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
