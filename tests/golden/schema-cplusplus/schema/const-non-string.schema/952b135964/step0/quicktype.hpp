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

    enum class Kind : int { WIDGET };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        int64_t amount;
        bool enabled;
        Kind kind;
        double ratio;
        double version;

        public:
        const int64_t & get_amount() const { return amount; }
        int64_t & get_mutable_amount() { return amount; }
        void set_amount(const int64_t & value) { this->amount = value; }

        const bool & get_enabled() const { return enabled; }
        bool & get_mutable_enabled() { return enabled; }
        void set_enabled(const bool & value) { this->enabled = value; }

        const Kind & get_kind() const { return kind; }
        Kind & get_mutable_kind() { return kind; }
        void set_kind(const Kind & value) { this->kind = value; }

        const double & get_ratio() const { return ratio; }
        double & get_mutable_ratio() { return ratio; }
        void set_ratio(const double & value) { this->ratio = value; }

        const double & get_version() const { return version; }
        double & get_mutable_version() { return version; }
        void set_version(const double & value) { this->version = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Kind & x);
    void to_json(json & j, const Kind & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("amount") != j.end() && !j.at("amount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_amount(j.at("amount").get<int64_t>());
        x.set_enabled(j.at("enabled").get<bool>());
        x.set_kind(j.at("kind").get<Kind>());
        x.set_ratio(j.at("ratio").get<double>());
        x.set_version(j.at("version").get<double>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["amount"] = x.get_amount();
        j["enabled"] = x.get_enabled();
        j["kind"] = x.get_kind();
        j["ratio"] = x.get_ratio();
        j["version"] = x.get_version();
    }

    inline void from_json(const json & j, Kind & x) {
        if (j == "widget") x = Kind::WIDGET;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Kind\""); }
    }

    inline void to_json(json & j, const Kind & x) {
        switch (x) {
            case Kind::WIDGET: j = "widget"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Kind\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
