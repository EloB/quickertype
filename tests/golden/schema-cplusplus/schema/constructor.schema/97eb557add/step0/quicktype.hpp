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

    class Constructor {
        public:
        Constructor() = default;
        virtual ~Constructor() = default;

        private:

        public:
    };

    using UnionConstructor = std::variant<Constructor, double>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<UnionConstructor> constructor;

        public:
        const std::optional<UnionConstructor> & get_constructor() const { return constructor; }
        std::optional<UnionConstructor> & get_mutable_constructor() { return constructor; }
        void set_constructor(const std::optional<UnionConstructor> & value) { this->constructor = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Constructor & x);
void to_json(json & j, const Constructor & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::Constructor, double>> {
    static void from_json(const json & j, std::variant<quicktype::Constructor, double> & x);
    static void to_json(json & j, const std::variant<quicktype::Constructor, double> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Constructor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Constructor & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("constructor") != j.end() && j.at("constructor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_constructor(get_stack_optional<std::variant<Constructor, double>>(j, "constructor"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["constructor"] = x.get_constructor();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::Constructor, double>>::from_json(const json & j, std::variant<quicktype::Constructor, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Constructor>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Constructor, double>>::to_json(json & j, const std::variant<quicktype::Constructor, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Constructor>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
