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

    enum class Category : int { EMPTY, CATEGORY };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        Category category;

        public:
        const Category & get_category() const { return category; }
        Category & get_mutable_category() { return category; }
        void set_category(const Category & value) { this->category = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, Category & x);
    void to_json(json & j, const Category & x);

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_category(j.at("category").get<Category>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["category"] = x.get_category();
    }

    inline void from_json(const json & j, Category & x) {
        if (j == " ") x = Category::EMPTY;
        else if (j == "") x = Category::CATEGORY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Category\""); }
    }

    inline void to_json(json & j, const Category & x) {
        switch (x) {
            case Category::EMPTY: j = " "; break;
            case Category::CATEGORY: j = ""; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Category\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
