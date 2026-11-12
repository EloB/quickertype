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
        std::map<std::string, int64_t> a;
        std::map<std::string, int64_t> b;

        public:
        const std::map<std::string, int64_t> & get_a() const { return a; }
        std::map<std::string, int64_t> & get_mutable_a() { return a; }
        void set_a(const std::map<std::string, int64_t> & value) { this->a = value; }

        const std::map<std::string, int64_t> & get_b() const { return b; }
        std::map<std::string, int64_t> & get_mutable_b() { return b; }
        void set_b(const std::map<std::string, int64_t> & value) { this->b = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_a(j.at("a").get<std::map<std::string, int64_t>>());
        x.set_b(j.at("b").get<std::map<std::string, int64_t>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["a"] = x.get_a();
        j["b"] = x.get_b();
    }
}
