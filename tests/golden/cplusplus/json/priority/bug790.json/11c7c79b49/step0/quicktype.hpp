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
        std::vector<TopLevel> children_data;
        int64_t id;
        bool is_active;
        int64_t level;
        std::string name;
        int64_t parent_id;
        int64_t position;
        int64_t product_count;

        public:
        const std::vector<TopLevel> & get_children_data() const { return children_data; }
        std::vector<TopLevel> & get_mutable_children_data() { return children_data; }
        void set_children_data(const std::vector<TopLevel> & value) { this->children_data = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const bool & get_is_active() const { return is_active; }
        bool & get_mutable_is_active() { return is_active; }
        void set_is_active(const bool & value) { this->is_active = value; }

        const int64_t & get_level() const { return level; }
        int64_t & get_mutable_level() { return level; }
        void set_level(const int64_t & value) { this->level = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const int64_t & get_parent_id() const { return parent_id; }
        int64_t & get_mutable_parent_id() { return parent_id; }
        void set_parent_id(const int64_t & value) { this->parent_id = value; }

        const int64_t & get_position() const { return position; }
        int64_t & get_mutable_position() { return position; }
        void set_position(const int64_t & value) { this->position = value; }

        const int64_t & get_product_count() const { return product_count; }
        int64_t & get_mutable_product_count() { return product_count; }
        void set_product_count(const int64_t & value) { this->product_count = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_children_data(j.at("children_data").get<std::vector<TopLevel>>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_is_active(j.at("is_active").get<bool>());
        if (j.find("level") != j.end() && !j.at("level").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_level(j.at("level").get<int64_t>());
        x.set_name(j.at("name").get<std::string>());
        if (j.find("parent_id") != j.end() && !j.at("parent_id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_parent_id(j.at("parent_id").get<int64_t>());
        if (j.find("position") != j.end() && !j.at("position").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_position(j.at("position").get<int64_t>());
        if (j.find("product_count") != j.end() && !j.at("product_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_product_count(j.at("product_count").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["children_data"] = x.get_children_data();
        j["id"] = x.get_id();
        j["is_active"] = x.get_is_active();
        j["level"] = x.get_level();
        j["name"] = x.get_name();
        j["parent_id"] = x.get_parent_id();
        j["position"] = x.get_position();
        j["product_count"] = x.get_product_count();
    }
}
