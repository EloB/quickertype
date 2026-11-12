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

    class Cookies {
        public:
        Cookies() = default;
        virtual ~Cookies() = default;

        private:

        public:
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Cookies cookies;

        public:
        const Cookies & get_cookies() const { return cookies; }
        Cookies & get_mutable_cookies() { return cookies; }
        void set_cookies(const Cookies & value) { this->cookies = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Cookies & x);
    void to_json(json & j, const Cookies & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Cookies& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Cookies & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_cookies(j.at("cookies").get<Cookies>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["cookies"] = x.get_cookies();
    }
}
