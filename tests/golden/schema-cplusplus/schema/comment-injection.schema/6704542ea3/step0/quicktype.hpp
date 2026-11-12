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

    /**
     * Comment delimiters:
     * * /
     * / *
     * {-
     * -}
     * """
     * </summary> & <br>
     * }
     * }
     * }
     * }
     * }
     */
    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<std::string> trailing_backslash;
        std::optional<std::string> trailing_quote;
        std::optional<std::string> trailing_triple_quote;
        std::string value;

        public:
        /**
         * Ends with a backslash \.
         */
        const std::optional<std::string> & get_trailing_backslash() const { return trailing_backslash; }
        std::optional<std::string> & get_mutable_trailing_backslash() { return trailing_backslash; }
        void set_trailing_backslash(const std::optional<std::string> & value) { this->trailing_backslash = value; }

        /**
         * Ends with a quote "
         */
        const std::optional<std::string> & get_trailing_quote() const { return trailing_quote; }
        std::optional<std::string> & get_mutable_trailing_quote() { return trailing_quote; }
        void set_trailing_quote(const std::optional<std::string> & value) { this->trailing_quote = value; }

        /**
         * Ends with a triple quote """
         */
        const std::optional<std::string> & get_trailing_triple_quote() const { return trailing_triple_quote; }
        std::optional<std::string> & get_mutable_trailing_triple_quote() { return trailing_triple_quote; }
        void set_trailing_triple_quote(const std::optional<std::string> & value) { this->trailing_triple_quote = value; }

        /**
         * Property delimiters:
         * * /
         * / *
         * {-
         * -}
         * """
         * </summary> & <br>
         * }
         * }
         * }
         * }
         * }
         */
        const std::string & get_value() const { return value; }
        std::string & get_mutable_value() { return value; }
        void set_value(const std::string & value) { this->value = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("trailingBackslash") != j.end() && j.at("trailingBackslash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_trailing_backslash(get_stack_optional<std::string>(j, "trailingBackslash"));
        if (j.find("trailingQuote") != j.end() && j.at("trailingQuote").is_null()) throw std::runtime_error("Unexpected null");
        x.set_trailing_quote(get_stack_optional<std::string>(j, "trailingQuote"));
        if (j.find("trailingTripleQuote") != j.end() && j.at("trailingTripleQuote").is_null()) throw std::runtime_error("Unexpected null");
        x.set_trailing_triple_quote(get_stack_optional<std::string>(j, "trailingTripleQuote"));
        x.set_value(j.at("value").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["trailingBackslash"] = x.get_trailing_backslash();
        j["trailingQuote"] = x.get_trailing_quote();
        j["trailingTripleQuote"] = x.get_trailing_triple_quote();
        j["value"] = x.get_value();
    }
}
