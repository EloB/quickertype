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

    class MixedClass {
        public:
        MixedClass() = default;
        virtual ~MixedClass() = default;

        private:
        std::string nested;

        public:
        const std::string & get_nested() const { return nested; }
        std::string & get_mutable_nested() { return nested; }
        void set_nested(const std::string & value) { this->nested = value; }
    };

    using MixedElement = std::optional<std::variant<bool, MixedClass, int64_t, std::string>>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<MixedElement> mixed;

        public:
        const std::vector<MixedElement> & get_mixed() const { return mixed; }
        std::vector<MixedElement> & get_mutable_mixed() { return mixed; }
        void set_mixed(const std::vector<MixedElement> & value) { this->mixed = value; }
    };
}

namespace quicktype {
void from_json(const json & j, MixedClass & x);
void to_json(json & j, const MixedClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, quicktype::MixedClass, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<bool, quicktype::MixedClass, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::MixedClass, int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, MixedClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_nested(j.at("nested").get<std::string>());
    }

    inline void to_json(json & j, const MixedClass & x) {
        j = json::object();
        j["nested"] = x.get_nested();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_mixed(j.at("mixed").get<std::vector<MixedElement>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["mixed"] = x.get_mixed();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, quicktype::MixedClass, int64_t, std::string>>::from_json(const json & j, std::variant<bool, quicktype::MixedClass, int64_t, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::MixedClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::MixedClass, int64_t, std::string>>::to_json(json & j, const std::variant<bool, quicktype::MixedClass, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::MixedClass>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            case 3:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
