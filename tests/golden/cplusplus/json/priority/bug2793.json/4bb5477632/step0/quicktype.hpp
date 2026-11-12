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

    class Hints {
        public:
        Hints() = default;
        virtual ~Hints() = default;

        private:

        public:
    };

    class Labels {
        public:
        Labels() = default;
        virtual ~Labels() = default;

        private:
        std::string account_number;
        std::string title;

        public:
        const std::string & get_account_number() const { return account_number; }
        std::string & get_mutable_account_number() { return account_number; }
        void set_account_number(const std::string & value) { this->account_number = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Hints hints;
        Labels labels;

        public:
        const Hints & get_hints() const { return hints; }
        Hints & get_mutable_hints() { return hints; }
        void set_hints(const Hints & value) { this->hints = value; }

        const Labels & get_labels() const { return labels; }
        Labels & get_mutable_labels() { return labels; }
        void set_labels(const Labels & value) { this->labels = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Hints & x);
    void to_json(json & j, const Hints & x);

    void from_json(const json & j, Labels & x);
    void to_json(json & j, const Labels & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Hints& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Hints & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Labels& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_account_number(j.at("AccountNumber").get<std::string>());
        x.set_title(j.at("Title").get<std::string>());
    }

    inline void to_json(json & j, const Labels & x) {
        j = json::object();
        j["AccountNumber"] = x.get_account_number();
        j["Title"] = x.get_title();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_hints(j.at("Hints").get<Hints>());
        x.set_labels(j.at("Labels").get<Labels>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["Hints"] = x.get_hints();
        j["Labels"] = x.get_labels();
    }
}
