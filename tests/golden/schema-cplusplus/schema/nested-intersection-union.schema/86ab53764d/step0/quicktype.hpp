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

    class Item {
        public:
        Item() = default;
        virtual ~Item() = default;

        private:
        std::optional<std::string> content;
        std::optional<std::string> id;
        std::optional<std::string> output;
        std::optional<std::string> summary;

        public:
        const std::optional<std::string> & get_content() const { return content; }
        std::optional<std::string> & get_mutable_content() { return content; }
        void set_content(const std::optional<std::string> & value) { this->content = value; }

        const std::optional<std::string> & get_id() const { return id; }
        std::optional<std::string> & get_mutable_id() { return id; }
        void set_id(const std::optional<std::string> & value) { this->id = value; }

        const std::optional<std::string> & get_output() const { return output; }
        std::optional<std::string> & get_mutable_output() { return output; }
        void set_output(const std::optional<std::string> & value) { this->output = value; }

        const std::optional<std::string> & get_summary() const { return summary; }
        std::optional<std::string> & get_mutable_summary() { return summary; }
        void set_summary(const std::optional<std::string> & value) { this->summary = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Item> input;

        public:
        const std::vector<Item> & get_input() const { return input; }
        std::vector<Item> & get_mutable_input() { return input; }
        void set_input(const std::vector<Item> & value) { this->input = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Item & x);
    void to_json(json & j, const Item & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Item& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("content") != j.end() && j.at("content").is_null()) throw std::runtime_error("Unexpected null");
        x.set_content(get_stack_optional<std::string>(j, "content"));
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<std::string>(j, "id"));
        if (j.find("output") != j.end() && j.at("output").is_null()) throw std::runtime_error("Unexpected null");
        x.set_output(get_stack_optional<std::string>(j, "output"));
        if (j.find("summary") != j.end() && j.at("summary").is_null()) throw std::runtime_error("Unexpected null");
        x.set_summary(get_stack_optional<std::string>(j, "summary"));
    }

    inline void to_json(json & j, const Item & x) {
        j = json::object();
        j["content"] = x.get_content();
        j["id"] = x.get_id();
        j["output"] = x.get_output();
        j["summary"] = x.get_summary();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_input(j.at("input").get<std::vector<Item>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["input"] = x.get_input();
    }
}
