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

    class BoolInUnion {
        public:
        BoolInUnion() = default;
        virtual ~BoolInUnion() = default;

        private:
        bool a;

        public:
        const bool & get_a() const { return a; }
        bool & get_mutable_a() { return a; }
        void set_a(const bool & value) { this->a = value; }
    };

    using Union = std::variant<bool, int64_t>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        BoolInUnion bool_in_union;
        std::vector<Union> top_level_union;

        public:
        const BoolInUnion & get_bool_in_union() const { return bool_in_union; }
        BoolInUnion & get_mutable_bool_in_union() { return bool_in_union; }
        void set_bool_in_union(const BoolInUnion & value) { this->bool_in_union = value; }

        const std::vector<Union> & get_top_level_union() const { return top_level_union; }
        std::vector<Union> & get_mutable_top_level_union() { return top_level_union; }
        void set_top_level_union(const std::vector<Union> & value) { this->top_level_union = value; }
    };
}

namespace quicktype {
void from_json(const json & j, BoolInUnion & x);
void to_json(json & j, const BoolInUnion & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, int64_t>> {
    static void from_json(const json & j, std::variant<bool, int64_t> & x);
    static void to_json(json & j, const std::variant<bool, int64_t> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, BoolInUnion& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_a(j.at("a").get<bool>());
    }

    inline void to_json(json & j, const BoolInUnion & x) {
        j = json::object();
        j["a"] = x.get_a();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bool_in_union(j.at("BoolInUnion").get<BoolInUnion>());
        x.set_top_level_union(j.at("union").get<std::vector<Union>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["BoolInUnion"] = x.get_bool_in_union();
        j["union"] = x.get_top_level_union();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, int64_t>>::from_json(const json & j, std::variant<bool, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, int64_t>>::to_json(json & j, const std::variant<bool, int64_t> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
