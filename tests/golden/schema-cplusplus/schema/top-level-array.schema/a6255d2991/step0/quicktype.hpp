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

    class TextClassificationOutputElement {
        public:
        TextClassificationOutputElement() = default;
        virtual ~TextClassificationOutputElement() = default;

        private:
        std::string label;
        double score;

        public:
        const std::string & get_label() const { return label; }
        std::string & get_mutable_label() { return label; }
        void set_label(const std::string & value) { this->label = value; }

        const double & get_score() const { return score; }
        double & get_mutable_score() { return score; }
        void set_score(const double & value) { this->score = value; }
    };

    using TopLevel = std::vector<TextClassificationOutputElement>;
}

namespace quicktype {
    void from_json(const json & j, TextClassificationOutputElement & x);
    void to_json(json & j, const TextClassificationOutputElement & x);

    inline void from_json(const json & j, TextClassificationOutputElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_label(j.at("label").get<std::string>());
        x.set_score(j.at("score").get<double>());
    }

    inline void to_json(json & j, const TextClassificationOutputElement & x) {
        j = json::object();
        j["label"] = x.get_label();
        j["score"] = x.get_score();
    }
}
