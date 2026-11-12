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

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string empty;
        std::string null;
        std::string purple_x;
        std::string top_level;
        std::string top_level_continue;
        std::string top_level_x;
        std::string undefined;
        std::string x;
        std::string x_y;

        public:
        const std::string & get_empty() const { return empty; }
        std::string & get_mutable_empty() { return empty; }
        void set_empty(const std::string & value) { this->empty = value; }

        const std::string & get_null() const { return null; }
        std::string & get_mutable_null() { return null; }
        void set_null(const std::string & value) { this->null = value; }

        const std::string & get_purple_x() const { return purple_x; }
        std::string & get_mutable_purple_x() { return purple_x; }
        void set_purple_x(const std::string & value) { this->purple_x = value; }

        const std::string & get_top_level() const { return top_level; }
        std::string & get_mutable_top_level() { return top_level; }
        void set_top_level(const std::string & value) { this->top_level = value; }

        const std::string & get_top_level_continue() const { return top_level_continue; }
        std::string & get_mutable_top_level_continue() { return top_level_continue; }
        void set_top_level_continue(const std::string & value) { this->top_level_continue = value; }

        const std::string & get_top_level_x() const { return top_level_x; }
        std::string & get_mutable_top_level_x() { return top_level_x; }
        void set_top_level_x(const std::string & value) { this->top_level_x = value; }

        const std::string & get_undefined() const { return undefined; }
        std::string & get_mutable_undefined() { return undefined; }
        void set_undefined(const std::string & value) { this->undefined = value; }

        const std::string & get_x() const { return x; }
        std::string & get_mutable_x() { return x; }
        void set_x(const std::string & value) { this->x = value; }

        const std::string & get_x_y() const { return x_y; }
        std::string & get_mutable_x_y() { return x_y; }
        void set_x_y(const std::string & value) { this->x_y = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_empty(j.at("").get<std::string>());
        x.set_null(j.at("null").get<std::string>());
        x.set_purple_x(j.at("x'").get<std::string>());
        x.set_top_level(j.at("{}").get<std::string>());
        x.set_top_level_continue(j.at("continue").get<std::string>());
        x.set_top_level_x(j.at("x\"").get<std::string>());
        x.set_undefined(j.at("undefined").get<std::string>());
        x.set_x(j.at("x").get<std::string>());
        x.set_x_y(j.at("x y").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j[""] = x.get_empty();
        j["null"] = x.get_null();
        j["x'"] = x.get_purple_x();
        j["{}"] = x.get_top_level();
        j["continue"] = x.get_top_level_continue();
        j["x\""] = x.get_top_level_x();
        j["undefined"] = x.get_undefined();
        j["x"] = x.get_x();
        j["x y"] = x.get_x_y();
    }
}
