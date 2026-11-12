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

    class LightParams {
        public:
        LightParams() = default;
        virtual ~LightParams() = default;

        private:
        std::string app_id;
        std::string outlet_id;
        std::string rgba;

        public:
        const std::string & get_app_id() const { return app_id; }
        std::string & get_mutable_app_id() { return app_id; }
        void set_app_id(const std::string & value) { this->app_id = value; }

        const std::string & get_outlet_id() const { return outlet_id; }
        std::string & get_mutable_outlet_id() { return outlet_id; }
        void set_outlet_id(const std::string & value) { this->outlet_id = value; }

        const std::string & get_rgba() const { return rgba; }
        std::string & get_mutable_rgba() { return rgba; }
        void set_rgba(const std::string & value) { this->rgba = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        LightParams light_params;

        public:
        const LightParams & get_light_params() const { return light_params; }
        LightParams & get_mutable_light_params() { return light_params; }
        void set_light_params(const LightParams & value) { this->light_params = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, LightParams & x);
    void to_json(json & j, const LightParams & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, LightParams& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_app_id(j.at("app_id").get<std::string>());
        x.set_outlet_id(j.at("outlet_id").get<std::string>());
        x.set_rgba(j.at("rgba").get<std::string>());
    }

    inline void to_json(json & j, const LightParams & x) {
        j = json::object();
        j["app_id"] = x.get_app_id();
        j["outlet_id"] = x.get_outlet_id();
        j["rgba"] = x.get_rgba();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_light_params(j.at("LightParams").get<LightParams>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["LightParams"] = x.get_light_params();
    }
}
