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

    class Response {
        public:
        Response() = default;
        virtual ~Response() = default;

        private:
        std::optional<std::string> body;

        public:
        const std::optional<std::string> & get_body() const { return body; }
        std::optional<std::string> & get_mutable_body() { return body; }
        void set_body(const std::optional<std::string> & value) { this->body = value; }
    };

    /**
     * Postman collection
     */
    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<std::vector<TopLevel>> item;
        std::optional<std::string> name;
        std::optional<std::vector<Response>> response;

        public:
        const std::optional<std::vector<TopLevel>> & get_item() const { return item; }
        std::optional<std::vector<TopLevel>> & get_mutable_item() { return item; }
        void set_item(const std::optional<std::vector<TopLevel>> & value) { this->item = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        const std::optional<std::vector<Response>> & get_response() const { return response; }
        std::optional<std::vector<Response>> & get_mutable_response() { return response; }
        void set_response(const std::optional<std::vector<Response>> & value) { this->response = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Response & x);
    void to_json(json & j, const Response & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Response& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("body") != j.end() && j.at("body").is_null()) throw std::runtime_error("Unexpected null");
        x.set_body(get_stack_optional<std::string>(j, "body"));
    }

    inline void to_json(json & j, const Response & x) {
        j = json::object();
        j["body"] = x.get_body();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("item") != j.end() && j.at("item").is_null()) throw std::runtime_error("Unexpected null");
        x.set_item(get_stack_optional<std::vector<TopLevel>>(j, "item"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        if (j.find("response") != j.end() && j.at("response").is_null()) throw std::runtime_error("Unexpected null");
        x.set_response(get_stack_optional<std::vector<Response>>(j, "response"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["item"] = x.get_item();
        j["name"] = x.get_name();
        j["response"] = x.get_response();
    }
}
