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

    enum class BarEnum : int { QUUX };

    using BarUnion = std::variant<std::string, BarEnum>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        BarUnion bar;
        std::string foo;

        public:
        const BarUnion & get_bar() const { return bar; }
        BarUnion & get_mutable_bar() { return bar; }
        void set_bar(const BarUnion & value) { this->bar = value; }

        const std::string & get_foo() const { return foo; }
        std::string & get_mutable_foo() { return foo; }
        void set_foo(const std::string & value) { this->foo = value; }
    };
}

namespace quicktype {
void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, BarEnum & x);
void to_json(json & j, const BarEnum & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::string, quicktype::BarEnum>> {
    static void from_json(const json & j, std::variant<std::string, quicktype::BarEnum> & x);
    static void to_json(json & j, const std::variant<std::string, quicktype::BarEnum> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bar(j.at("bar").get<BarUnion>());
        x.set_foo(j.at("foo").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bar"] = x.get_bar();
        j["foo"] = x.get_foo();
    }

    inline void from_json(const json & j, BarEnum & x) {
        if (j == "quux") x = BarEnum::QUUX;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"BarEnum\""); }
    }

    inline void to_json(json & j, const BarEnum & x) {
        switch (x) {
            case BarEnum::QUUX: j = "quux"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"BarEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::string, quicktype::BarEnum>>::from_json(const json & j, std::variant<std::string, quicktype::BarEnum> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_string())
            x = j.get<quicktype::BarEnum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::string, quicktype::BarEnum>>::to_json(json & j, const std::variant<std::string, quicktype::BarEnum> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::string>(x);
                break;
            case 1:
                j = std::get<quicktype::BarEnum>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
