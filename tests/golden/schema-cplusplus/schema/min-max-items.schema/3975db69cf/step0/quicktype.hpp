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

    using UnionItem = std::variant<int64_t, std::string>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<int64_t> max_only;
        std::vector<double> min_and_max;
        std::vector<std::string> min_only;
        std::vector<std::string> plain;
        std::vector<UnionItem> union_items;

        public:
        const std::vector<int64_t> & get_max_only() const { return max_only; }
        std::vector<int64_t> & get_mutable_max_only() { return max_only; }
        void set_max_only(const std::vector<int64_t> & value) { this->max_only = value; }

        const std::vector<double> & get_min_and_max() const { return min_and_max; }
        std::vector<double> & get_mutable_min_and_max() { return min_and_max; }
        void set_min_and_max(const std::vector<double> & value) { this->min_and_max = value; }

        const std::vector<std::string> & get_min_only() const { return min_only; }
        std::vector<std::string> & get_mutable_min_only() { return min_only; }
        void set_min_only(const std::vector<std::string> & value) { this->min_only = value; }

        const std::vector<std::string> & get_plain() const { return plain; }
        std::vector<std::string> & get_mutable_plain() { return plain; }
        void set_plain(const std::vector<std::string> & value) { this->plain = value; }

        const std::vector<UnionItem> & get_union_items() const { return union_items; }
        std::vector<UnionItem> & get_mutable_union_items() { return union_items; }
        void set_union_items(const std::vector<UnionItem> & value) { this->union_items = value; }
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
        if (j.at("maxOnly").size() > 3) throw std::runtime_error("Too many items");
        x.set_max_only(j.at("maxOnly").get<std::vector<int64_t>>());
        if (j.at("minAndMax").size() < 1) throw std::runtime_error("Too few items");
        if (j.at("minAndMax").size() > 4) throw std::runtime_error("Too many items");
        x.set_min_and_max(j.at("minAndMax").get<std::vector<double>>());
        if (j.at("minOnly").size() < 2) throw std::runtime_error("Too few items");
        x.set_min_only(j.at("minOnly").get<std::vector<std::string>>());
        x.set_plain(j.at("plain").get<std::vector<std::string>>());
        if (j.at("unionItems").size() < 2) throw std::runtime_error("Too few items");
        x.set_union_items(j.at("unionItems").get<std::vector<UnionItem>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["maxOnly"] = x.get_max_only();
        j["minAndMax"] = x.get_min_and_max();
        j["minOnly"] = x.get_min_only();
        j["plain"] = x.get_plain();
        j["unionItems"] = x.get_union_items();
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
