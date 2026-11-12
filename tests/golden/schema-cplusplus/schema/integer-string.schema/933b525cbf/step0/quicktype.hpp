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

    using UnionWithInt = std::variant<int64_t, std::string>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<std::vector<std::optional<std::string>>> arr_nullable;
        std::optional<std::vector<std::string>> arr_one;
        std::optional<std::string> nullable;
        std::string one;
        std::optional<std::string> optional;
        UnionWithInt union_with_int;
        UnionWithInt union_with_int_and_enum;

        public:
        const std::optional<std::vector<std::optional<std::string>>> & get_arr_nullable() const { return arr_nullable; }
        std::optional<std::vector<std::optional<std::string>>> & get_mutable_arr_nullable() { return arr_nullable; }
        void set_arr_nullable(const std::optional<std::vector<std::optional<std::string>>> & value) { this->arr_nullable = value; }

        const std::optional<std::vector<std::string>> & get_arr_one() const { return arr_one; }
        std::optional<std::vector<std::string>> & get_mutable_arr_one() { return arr_one; }
        void set_arr_one(const std::optional<std::vector<std::string>> & value) { this->arr_one = value; }

        std::optional<std::string> get_nullable() const { return nullable; }
        void set_nullable(std::optional<std::string> value) { this->nullable = value; }

        const std::string & get_one() const { return one; }
        std::string & get_mutable_one() { return one; }
        void set_one(const std::string & value) { this->one = value; }

        const std::optional<std::string> & get_optional() const { return optional; }
        std::optional<std::string> & get_mutable_optional() { return optional; }
        void set_optional(const std::optional<std::string> & value) { this->optional = value; }

        const UnionWithInt & get_union_with_int() const { return union_with_int; }
        UnionWithInt & get_mutable_union_with_int() { return union_with_int; }
        void set_union_with_int(const UnionWithInt & value) { this->union_with_int = value; }

        const UnionWithInt & get_union_with_int_and_enum() const { return union_with_int_and_enum; }
        UnionWithInt & get_mutable_union_with_int_and_enum() { return union_with_int_and_enum; }
        void set_union_with_int_and_enum(const UnionWithInt & value) { this->union_with_int_and_enum = value; }
    };
}

namespace quicktype {
void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(const json & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("arrNullable") != j.end() && j.at("arrNullable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_arr_nullable(get_stack_optional<std::vector<std::optional<std::string>>>(j, "arrNullable"));
        if (j.find("arrOne") != j.end() && j.at("arrOne").is_null()) throw std::runtime_error("Unexpected null");
        x.set_arr_one(get_stack_optional<std::vector<std::string>>(j, "arrOne"));
        j.at("nullable");
        x.set_nullable(get_stack_optional<std::string>(j, "nullable"));
        x.set_one(j.at("one").get<std::string>());
        if (j.find("optional") != j.end() && j.at("optional").is_null()) throw std::runtime_error("Unexpected null");
        x.set_optional(get_stack_optional<std::string>(j, "optional"));
        x.set_union_with_int(j.at("unionWithInt").get<UnionWithInt>());
        x.set_union_with_int_and_enum(j.at("unionWithIntAndEnum").get<UnionWithInt>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["arrNullable"] = x.get_arr_nullable();
        j["arrOne"] = x.get_arr_one();
        j["nullable"] = x.get_nullable();
        j["one"] = x.get_one();
        j["optional"] = x.get_optional();
        j["unionWithInt"] = x.get_union_with_int();
        j["unionWithIntAndEnum"] = x.get_union_with_int_and_enum();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<int64_t, std::string>>::from_json(const json & j, std::variant<int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::string>>::to_json(json & j, const std::variant<int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<int64_t>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
