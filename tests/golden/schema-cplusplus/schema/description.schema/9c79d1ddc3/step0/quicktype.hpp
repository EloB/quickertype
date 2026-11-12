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

    class ObjectOrStringClass {
        public:
        ObjectOrStringClass() = default;
        virtual ~ObjectOrStringClass() = default;

        private:
        double prop;

        public:
        /**
         * This must not get lost
         */
        const double & get_prop() const { return prop; }
        double & get_mutable_prop() { return prop; }
        void set_prop(const double & value) { this->prop = value; }
    };

    using ObjectOrStringUnion = std::variant<ObjectOrStringClass, std::string>;

    /**
     * An enumeration
     */
    enum class Enum : int { FOO, BAR };

    using Union = std::variant<double, std::string>;

    /**
     * The top-level class.
     * Its description has two lines.
     */
    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<bool> bar;
        Enum top_level_enum;
        std::optional<double> foo;
        ObjectOrStringUnion object_or_string;
        Union top_level_union;

        public:
        /**
         * A pretty boolean
         */
        const std::optional<bool> & get_bar() const { return bar; }
        std::optional<bool> & get_mutable_bar() { return bar; }
        void set_bar(const std::optional<bool> & value) { this->bar = value; }

        /**
         * An enumeration
         */
        const Enum & get_top_level_enum() const { return top_level_enum; }
        Enum & get_mutable_top_level_enum() { return top_level_enum; }
        void set_top_level_enum(const Enum & value) { this->top_level_enum = value; }

        const std::optional<double> & get_foo() const { return foo; }
        std::optional<double> & get_mutable_foo() { return foo; }
        void set_foo(const std::optional<double> & value) { this->foo = value; }

        const ObjectOrStringUnion & get_object_or_string() const { return object_or_string; }
        ObjectOrStringUnion & get_mutable_object_or_string() { return object_or_string; }
        void set_object_or_string(const ObjectOrStringUnion & value) { this->object_or_string = value; }

        /**
         * Either a number or a string
         */
        const Union & get_top_level_union() const { return top_level_union; }
        Union & get_mutable_top_level_union() { return top_level_union; }
        void set_top_level_union(const Union & value) { this->top_level_union = value; }
    };
}

namespace quicktype {
void from_json(const json & j, ObjectOrStringClass & x);
void to_json(json & j, const ObjectOrStringClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, Enum & x);
void to_json(json & j, const Enum & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::ObjectOrStringClass, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::ObjectOrStringClass, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::ObjectOrStringClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(const json & j, std::variant<double, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, ObjectOrStringClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_prop(j.at("prop").get<double>());
    }

    inline void to_json(json & j, const ObjectOrStringClass & x) {
        j = json::object();
        j["prop"] = x.get_prop();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bar") != j.end() && j.at("bar").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bar(get_stack_optional<bool>(j, "bar"));
        x.set_top_level_enum(j.at("enum").get<Enum>());
        if (j.find("foo") != j.end() && j.at("foo").is_null()) throw std::runtime_error("Unexpected null");
        x.set_foo(get_stack_optional<double>(j, "foo"));
        x.set_object_or_string(j.at("object-or-string").get<ObjectOrStringUnion>());
        x.set_top_level_union(j.at("union").get<Union>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bar"] = x.get_bar();
        j["enum"] = x.get_top_level_enum();
        j["foo"] = x.get_foo();
        j["object-or-string"] = x.get_object_or_string();
        j["union"] = x.get_top_level_union();
    }

    inline void from_json(const json & j, Enum & x) {
        if (j == "foo") x = Enum::FOO;
        else if (j == "bar") x = Enum::BAR;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Enum\""); }
    }

    inline void to_json(json & j, const Enum & x) {
        switch (x) {
            case Enum::FOO: j = "foo"; break;
            case Enum::BAR: j = "bar"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Enum\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::ObjectOrStringClass, std::string>>::from_json(const json & j, std::variant<quicktype::ObjectOrStringClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::ObjectOrStringClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ObjectOrStringClass, std::string>>::to_json(json & j, const std::variant<quicktype::ObjectOrStringClass, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ObjectOrStringClass>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, std::string>>::from_json(const json & j, std::variant<double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::string>>::to_json(json & j, const std::variant<double, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<double>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
