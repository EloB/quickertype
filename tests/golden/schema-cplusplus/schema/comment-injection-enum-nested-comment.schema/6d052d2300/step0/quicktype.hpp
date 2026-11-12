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

    /**
     * Nested enum block comment openers:
     * {-
     * / *
     * This text must remain inside the generated enum documentation comment.
     */
    enum class Kind : int { OK };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Kind kind;

        public:
        /**
         * Nested enum block comment openers:
         * {-
         * / *
         * This text must remain inside the generated enum documentation comment.
         */
        const Kind & get_kind() const { return kind; }
        Kind & get_mutable_kind() { return kind; }
        void set_kind(const Kind & value) { this->kind = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Kind & x);
    void to_json(json & j, const Kind & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_kind(j.at("kind").get<Kind>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["kind"] = x.get_kind();
    }

    inline void from_json(const json & j, Kind & x) {
        if (j == "ok") x = Kind::OK;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Kind\""); }
    }

    inline void to_json(json & j, const Kind & x) {
        switch (x) {
            case Kind::OK: j = "ok"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Kind\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
