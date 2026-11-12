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

    class UnionClass {
        public:
        UnionClass() = default;
        virtual ~UnionClass() = default;

        private:
        std::optional<int64_t> quux;

        public:
        const std::optional<int64_t> & get_quux() const { return quux; }
        std::optional<int64_t> & get_mutable_quux() { return quux; }
        void set_quux(const std::optional<int64_t> & value) { this->quux = value; }
    };

    using UnionValue = std::variant<bool, UnionClass, double, std::string>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<std::map<std::string, UnionValue>> top_level_union;

        public:
        const std::optional<std::map<std::string, UnionValue>> & get_top_level_union() const { return top_level_union; }
        std::optional<std::map<std::string, UnionValue>> & get_mutable_top_level_union() { return top_level_union; }
        void set_top_level_union(const std::optional<std::map<std::string, UnionValue>> & value) { this->top_level_union = value; }
    };
}

namespace quicktype {
void from_json(const json & j, UnionClass & x);
void to_json(json & j, const UnionClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, quicktype::UnionClass, double, std::string>> {
    static void from_json(const json & j, std::variant<bool, quicktype::UnionClass, double, std::string> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::UnionClass, double, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, UnionClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("quux") != j.end() && !j.at("quux").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("quux") != j.end() && j.at("quux").is_null()) throw std::runtime_error("Unexpected null");
        x.set_quux(get_stack_optional<int64_t>(j, "quux"));
    }

    inline void to_json(json & j, const UnionClass & x) {
        j = json::object();
        j["quux"] = x.get_quux();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("union") != j.end() && j.at("union").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top_level_union(get_stack_optional<std::map<std::string, UnionValue>>(j, "union"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["union"] = x.get_top_level_union();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, quicktype::UnionClass, double, std::string>>::from_json(const json & j, std::variant<bool, quicktype::UnionClass, double, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::UnionClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::UnionClass, double, std::string>>::to_json(json & j, const std::variant<bool, quicktype::UnionClass, double, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::UnionClass>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            case 3:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
