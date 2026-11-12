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

    enum class FooEnum : int { A, B, C };

    using FooUnion = std::variant<bool, double, FooEnum, int64_t>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        FooUnion foo;

        public:
        const FooUnion & get_foo() const { return foo; }
        FooUnion & get_mutable_foo() { return foo; }
        void set_foo(const FooUnion & value) { this->foo = value; }
    };
}

namespace quicktype {
void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, FooEnum & x);
void to_json(json & j, const FooEnum & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, double, quicktype::FooEnum, int64_t>> {
    static void from_json(const json & j, std::variant<bool, double, quicktype::FooEnum, int64_t> & x);
    static void to_json(json & j, const std::variant<bool, double, quicktype::FooEnum, int64_t> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_foo(j.at("foo").get<FooUnion>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["foo"] = x.get_foo();
    }

    inline void from_json(const json & j, FooEnum & x) {
        if (j == "a") x = FooEnum::A;
        else if (j == "b") x = FooEnum::B;
        else if (j == "c") x = FooEnum::C;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FooEnum\""); }
    }

    inline void to_json(json & j, const FooEnum & x) {
        switch (x) {
            case FooEnum::A: j = "a"; break;
            case FooEnum::B: j = "b"; break;
            case FooEnum::C: j = "c"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FooEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, double, quicktype::FooEnum, int64_t>>::from_json(const json & j, std::variant<bool, double, quicktype::FooEnum, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<quicktype::FooEnum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double, quicktype::FooEnum, int64_t>>::to_json(json & j, const std::variant<bool, double, quicktype::FooEnum, int64_t> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<quicktype::FooEnum>(x);
                break;
            case 3:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
