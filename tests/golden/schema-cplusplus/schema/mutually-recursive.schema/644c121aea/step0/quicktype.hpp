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

    struct Foo;

    class Bar;

    class TopLevel;

    struct Foo : std::variant<std::vector<TopLevel>, std::shared_ptr<TopLevel>> {
        using base = std::variant<std::vector<TopLevel>, std::shared_ptr<TopLevel>>;
        using base::base;
        using base::operator=;
    };

    class Bar {
        public:
        Bar() = default;
        virtual ~Bar() = default;

        private:
        Foo foo;

        public:
        const Foo & get_foo() const { return foo; }
        Foo & get_mutable_foo() { return foo; }
        void set_foo(const Foo & value) { this->foo = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::shared_ptr<Bar> bar;

        public:
        const std::shared_ptr<Bar> & get_bar() const { return bar; }
        std::shared_ptr<Bar> & get_mutable_bar() { return bar; }
        void set_bar(const std::shared_ptr<Bar> & value) { this->bar = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Bar & x);
void to_json(json & j, const Bar & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, Foo & x);
void to_json(json & j, const Foo & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<quicktype::TopLevel>, std::shared_ptr<quicktype::TopLevel>>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::TopLevel>, std::shared_ptr<quicktype::TopLevel>> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::TopLevel>, std::shared_ptr<quicktype::TopLevel>> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Bar& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_foo(j.at("foo").get<Foo>());
    }

    inline void to_json(json & j, const Bar & x) {
        j = json::object();
        j["foo"] = x.get_foo();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bar") != j.end() && j.at("bar").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bar(get_heap_optional<Bar>(j, "bar"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bar"] = x.get_bar();
    }

    inline void from_json(const json & j, Foo & x) {
        x = j.get<Foo::base>();
    }

    inline void to_json(json & j, const Foo & x) {
        j = static_cast<const Foo::base &>(x);
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<quicktype::TopLevel>, std::shared_ptr<quicktype::TopLevel>>>::from_json(const json & j, std::variant<std::vector<quicktype::TopLevel>, std::shared_ptr<quicktype::TopLevel>> & x) {
        if (j.is_object())
            x = j.get<std::shared_ptr<quicktype::TopLevel>>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::TopLevel>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::TopLevel>, std::shared_ptr<quicktype::TopLevel>>>::to_json(json & j, const std::variant<std::vector<quicktype::TopLevel>, std::shared_ptr<quicktype::TopLevel>> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::TopLevel>>(x);
                break;
            case 1:
                j = std::get<std::shared_ptr<quicktype::TopLevel>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
