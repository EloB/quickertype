//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

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

    class Invoice {
        public:
        Invoice() = default;
        virtual ~Invoice() = default;

        private:
        std::optional<std::string> created_at;
        std::optional<std::string> due_date;
        std::string name;

        public:
        std::optional<std::string> get_created_at() const { return created_at; }
        void set_created_at(std::optional<std::string> value) { this->created_at = value; }

        std::optional<std::string> get_due_date() const { return due_date; }
        void set_due_date(std::optional<std::string> value) { this->due_date = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Invoice> invoices;

        public:
        const std::vector<Invoice> & get_invoices() const { return invoices; }
        std::vector<Invoice> & get_mutable_invoices() { return invoices; }
        void set_invoices(const std::vector<Invoice> & value) { this->invoices = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Invoice & x);
    void to_json(json & j, const Invoice & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Invoice& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("createdAt");
        x.set_created_at(get_stack_optional<std::string>(j, "createdAt"));
        j.at("dueDate");
        x.set_due_date(get_stack_optional<std::string>(j, "dueDate"));
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const Invoice & x) {
        j = json::object();
        j["createdAt"] = x.get_created_at();
        j["dueDate"] = x.get_due_date();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_invoices(j.at("invoices").get<std::vector<Invoice>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["invoices"] = x.get_invoices();
    }
}
