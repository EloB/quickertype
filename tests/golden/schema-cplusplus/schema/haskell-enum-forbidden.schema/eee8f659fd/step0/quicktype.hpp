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

    enum class Health : int { OK, ERROR };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Health health;

        public:
        const Health & get_health() const { return health; }
        Health & get_mutable_health() { return health; }
        void set_health(const Health & value) { this->health = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Health & x);
    void to_json(json & j, const Health & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_health(j.at("health").get<Health>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["health"] = x.get_health();
    }

    inline void from_json(const json & j, Health & x) {
        if (j == "ok") x = Health::OK;
        else if (j == "error") x = Health::ERROR;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Health\""); }
    }

    inline void to_json(json & j, const Health & x) {
        switch (x) {
            case Health::OK: j = "ok"; break;
            case Health::ERROR: j = "error"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Health\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
