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
        std::optional<std::string> optional_date;
        std::optional<std::string> optional_date_time;
        std::optional<std::string> optional_time;
        std::string required_date;
        std::string required_date_time;
        std::string required_time;

        public:
        const std::optional<std::string> & get_optional_date() const { return optional_date; }
        std::optional<std::string> & get_mutable_optional_date() { return optional_date; }
        void set_optional_date(const std::optional<std::string> & value) { this->optional_date = value; }

        const std::optional<std::string> & get_optional_date_time() const { return optional_date_time; }
        std::optional<std::string> & get_mutable_optional_date_time() { return optional_date_time; }
        void set_optional_date_time(const std::optional<std::string> & value) { this->optional_date_time = value; }

        const std::optional<std::string> & get_optional_time() const { return optional_time; }
        std::optional<std::string> & get_mutable_optional_time() { return optional_time; }
        void set_optional_time(const std::optional<std::string> & value) { this->optional_time = value; }

        const std::string & get_required_date() const { return required_date; }
        std::string & get_mutable_required_date() { return required_date; }
        void set_required_date(const std::string & value) { this->required_date = value; }

        const std::string & get_required_date_time() const { return required_date_time; }
        std::string & get_mutable_required_date_time() { return required_date_time; }
        void set_required_date_time(const std::string & value) { this->required_date_time = value; }

        const std::string & get_required_time() const { return required_time; }
        std::string & get_mutable_required_time() { return required_time; }
        void set_required_time(const std::string & value) { this->required_time = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("optional-date") != j.end() && j.at("optional-date").is_null()) throw std::runtime_error("Unexpected null");
        x.set_optional_date(get_stack_optional<std::string>(j, "optional-date"));
        if (j.find("optional-date-time") != j.end() && !std::regex_match(j.at("optional-date-time").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        if (j.find("optional-date-time") != j.end() && j.at("optional-date-time").is_null()) throw std::runtime_error("Unexpected null");
        x.set_optional_date_time(get_stack_optional<std::string>(j, "optional-date-time"));
        if (j.find("optional-time") != j.end() && j.at("optional-time").is_null()) throw std::runtime_error("Unexpected null");
        x.set_optional_time(get_stack_optional<std::string>(j, "optional-time"));
        x.set_required_date(j.at("required-date").get<std::string>());
        if (j.find("required-date-time") != j.end() && !std::regex_match(j.at("required-date-time").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_required_date_time(j.at("required-date-time").get<std::string>());
        x.set_required_time(j.at("required-time").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["optional-date"] = x.get_optional_date();
        j["optional-date-time"] = x.get_optional_date_time();
        j["optional-time"] = x.get_optional_time();
        j["required-date"] = x.get_required_date();
        j["required-date-time"] = x.get_required_date_time();
        j["required-time"] = x.get_required_time();
    }
}
