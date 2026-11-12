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

    class Person {
        public:
        Person() = default;
        virtual ~Person() = default;

        private:
        std::string craft;
        std::string name;

        public:
        const std::string & get_craft() const { return craft; }
        std::string & get_mutable_craft() { return craft; }
        void set_craft(const std::string & value) { this->craft = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string message;
        int64_t number;
        std::vector<Person> people;

        public:
        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string & value) { this->message = value; }

        const int64_t & get_number() const { return number; }
        int64_t & get_mutable_number() { return number; }
        void set_number(const int64_t & value) { this->number = value; }

        const std::vector<Person> & get_people() const { return people; }
        std::vector<Person> & get_mutable_people() { return people; }
        void set_people(const std::vector<Person> & value) { this->people = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Person & x);
    void to_json(json & j, const Person & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Person& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_craft(j.at("craft").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const Person & x) {
        j = json::object();
        j["craft"] = x.get_craft();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_message(j.at("message").get<std::string>());
        if (j.find("number") != j.end() && !j.at("number").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_number(j.at("number").get<int64_t>());
        x.set_people(j.at("people").get<std::vector<Person>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["message"] = x.get_message();
        j["number"] = x.get_number();
        j["people"] = x.get_people();
    }
}
