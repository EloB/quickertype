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

    class FooClass {
        public:
        FooClass() = default;
        virtual ~FooClass() = default;

        private:
        int64_t bar;

        public:
        const int64_t & get_bar() const { return bar; }
        int64_t & get_mutable_bar() { return bar; }
        void set_bar(const int64_t & value) { this->bar = value; }
    };

    using FooUnion = std::optional<std::variant<std::vector<int64_t>, bool, FooClass, double, int64_t, std::string>>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        FooUnion foo;

        public:
        FooUnion get_foo() const { return foo; }
        void set_foo(FooUnion value) { this->foo = value; }
    };
}

namespace quicktype {
void from_json(const json & j, FooClass & x);
void to_json(json & j, const FooClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::FooClass, double, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool, quicktype::FooClass, double, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool, quicktype::FooClass, double, int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, FooClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bar") != j.end() && !j.at("bar").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_bar(j.at("bar").get<int64_t>());
    }

    inline void to_json(json & j, const FooClass & x) {
        j = json::object();
        j["bar"] = x.get_bar();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("foo");
        x.set_foo(get_stack_optional<std::variant<std::vector<int64_t>, bool, FooClass, double, int64_t, std::string>>(j, "foo"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["foo"] = x.get_foo();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::FooClass, double, int64_t, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool, quicktype::FooClass, double, int64_t, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::FooClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::FooClass, double, int64_t, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool, quicktype::FooClass, double, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<quicktype::FooClass>(x);
                break;
            case 3:
                j = std::get<double>(x);
                break;
            case 4:
                j = std::get<int64_t>(x);
                break;
            case 5:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
