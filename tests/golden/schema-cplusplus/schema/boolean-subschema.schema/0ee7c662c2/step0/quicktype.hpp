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

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        nlohmann::json disallowed;
        std::vector<nlohmann::json> empty;
        std::string foo;
        nlohmann::json impossible;

        public:
        const nlohmann::json & get_disallowed() const { return disallowed; }
        nlohmann::json & get_mutable_disallowed() { return disallowed; }
        void set_disallowed(const nlohmann::json & value) { this->disallowed = value; }

        const std::vector<nlohmann::json> & get_empty() const { return empty; }
        std::vector<nlohmann::json> & get_mutable_empty() { return empty; }
        void set_empty(const std::vector<nlohmann::json> & value) { this->empty = value; }

        const std::string & get_foo() const { return foo; }
        std::string & get_mutable_foo() { return foo; }
        void set_foo(const std::string & value) { this->foo = value; }

        const nlohmann::json & get_impossible() const { return impossible; }
        nlohmann::json & get_mutable_impossible() { return impossible; }
        void set_impossible(const nlohmann::json & value) { this->impossible = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_disallowed(get_untyped(j, "disallowed"));
        x.set_empty(j.at("empty").get<std::vector<nlohmann::json>>());
        x.set_foo(j.at("foo").get<std::string>());
        x.set_impossible(get_untyped(j, "impossible"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["disallowed"] = x.get_disallowed();
        j["empty"] = x.get_empty();
        j["foo"] = x.get_foo();
        j["impossible"] = x.get_impossible();
    }
}
