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

    struct Next;

    class Node;

    struct Next : std::shared_ptr<std::variant<std::shared_ptr<Node>, std::string>> {
        using base = std::shared_ptr<std::variant<std::shared_ptr<Node>, std::string>>;
        using base::base;
        using base::operator=;
    };

    class Node {
        public:
        Node() = default;
        virtual ~Node() = default;

        private:
        Next next;
        std::string value;

        public:
        Next get_next() const { return next; }
        void set_next(Next value) { this->next = value; }

        const std::string & get_value() const { return value; }
        std::string & get_mutable_value() { return value; }
        void set_value(const std::string & value) { this->value = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Next next;
        std::string value;

        public:
        Next get_next() const { return next; }
        void set_next(Next value) { this->next = value; }

        const std::string & get_value() const { return value; }
        std::string & get_mutable_value() { return value; }
        void set_value(const std::string & value) { this->value = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Node & x);
void to_json(json & j, const Node & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, Next & x);
void to_json(json & j, const Next & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::shared_ptr<quicktype::Node>, std::string>> {
    static void from_json(const json & j, std::variant<std::shared_ptr<quicktype::Node>, std::string> & x);
    static void to_json(json & j, const std::variant<std::shared_ptr<quicktype::Node>, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Node& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_next(j.find("next") != j.end() ? j.at("next").get<Next>() : Next());
        x.set_value(j.at("value").get<std::string>());
    }

    inline void to_json(json & j, const Node & x) {
        j = json::object();
        j["next"] = x.get_next();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_next(j.find("next") != j.end() ? j.at("next").get<Next>() : Next());
        x.set_value(j.at("value").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["next"] = x.get_next();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, Next & x) {
        x = j.get<Next::base>();
    }

    inline void to_json(json & j, const Next & x) {
        j = static_cast<const Next::base &>(x);
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::Node>, std::string>>::from_json(const json & j, std::variant<std::shared_ptr<quicktype::Node>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::shared_ptr<quicktype::Node>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::Node>, std::string>>::to_json(json & j, const std::variant<std::shared_ptr<quicktype::Node>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::shared_ptr<quicktype::Node>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
