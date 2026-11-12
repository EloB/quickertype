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

    class Intersection {
        public:
        Intersection() = default;
        virtual ~Intersection() = default;

        private:
        double foo;
        std::optional<std::string> bar;

        public:
        const double & get_foo() const { return foo; }
        double & get_mutable_foo() { return foo; }
        void set_foo(const double & value) { this->foo = value; }

        const std::optional<std::string> & get_bar() const { return bar; }
        std::optional<std::string> & get_mutable_bar() { return bar; }
        void set_bar(const std::optional<std::string> & value) { this->bar = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<Intersection> intersection;

        public:
        const std::optional<Intersection> & get_intersection() const { return intersection; }
        std::optional<Intersection> & get_mutable_intersection() { return intersection; }
        void set_intersection(const std::optional<Intersection> & value) { this->intersection = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Intersection & x);
    void to_json(json & j, const Intersection & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Intersection& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_foo(j.at("foo").get<double>());
        if (j.find("bar") != j.end() && j.at("bar").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bar(get_stack_optional<std::string>(j, "bar"));
    }

    inline void to_json(json & j, const Intersection & x) {
        j = json::object();
        j["foo"] = x.get_foo();
        j["bar"] = x.get_bar();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("intersection") != j.end() && j.at("intersection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_intersection(get_stack_optional<Intersection>(j, "intersection"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["intersection"] = x.get_intersection();
    }
}
