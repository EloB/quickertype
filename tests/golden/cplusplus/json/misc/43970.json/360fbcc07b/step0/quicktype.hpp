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

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        int64_t id;
        std::string name;
        std::string notes;

        public:
        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_notes() const { return notes; }
        std::string & get_mutable_notes() { return notes; }
        void set_notes(const std::string & value) { this->notes = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ID") != j.end() && !j.at("ID").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("ID").get<int64_t>());
        x.set_name(j.at("Name").get<std::string>());
        x.set_notes(j.at("Notes").get<std::string>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["ID"] = x.get_id();
        j["Name"] = x.get_name();
        j["Notes"] = x.get_notes();
    }
}
