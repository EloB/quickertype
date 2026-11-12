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
        int64_t an_easy_one;
        bool is_mnist_letter;
        std::string json_string;
        bool pretty_easy_too;
        std::string should_know_that_id_is_an_initialism;
        bool spaces_are_separators_too;
        bool zsr_hh_demo3_delmatnr;

        public:
        const int64_t & get_an_easy_one() const { return an_easy_one; }
        int64_t & get_mutable_an_easy_one() { return an_easy_one; }
        void set_an_easy_one(const int64_t & value) { this->an_easy_one = value; }

        const bool & get_is_mnist_letter() const { return is_mnist_letter; }
        bool & get_mutable_is_mnist_letter() { return is_mnist_letter; }
        void set_is_mnist_letter(const bool & value) { this->is_mnist_letter = value; }

        const std::string & get_json_string() const { return json_string; }
        std::string & get_mutable_json_string() { return json_string; }
        void set_json_string(const std::string & value) { this->json_string = value; }

        const bool & get_pretty_easy_too() const { return pretty_easy_too; }
        bool & get_mutable_pretty_easy_too() { return pretty_easy_too; }
        void set_pretty_easy_too(const bool & value) { this->pretty_easy_too = value; }

        const std::string & get_should_know_that_id_is_an_initialism() const { return should_know_that_id_is_an_initialism; }
        std::string & get_mutable_should_know_that_id_is_an_initialism() { return should_know_that_id_is_an_initialism; }
        void set_should_know_that_id_is_an_initialism(const std::string & value) { this->should_know_that_id_is_an_initialism = value; }

        const bool & get_spaces_are_separators_too() const { return spaces_are_separators_too; }
        bool & get_mutable_spaces_are_separators_too() { return spaces_are_separators_too; }
        void set_spaces_are_separators_too(const bool & value) { this->spaces_are_separators_too = value; }

        const bool & get_zsr_hh_demo3_delmatnr() const { return zsr_hh_demo3_delmatnr; }
        bool & get_mutable_zsr_hh_demo3_delmatnr() { return zsr_hh_demo3_delmatnr; }
        void set_zsr_hh_demo3_delmatnr(const bool & value) { this->zsr_hh_demo3_delmatnr = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("anEasyOne") != j.end() && !j.at("anEasyOne").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_an_easy_one(j.at("anEasyOne").get<int64_t>());
        x.set_is_mnist_letter(j.at("isMNISTLetter").get<bool>());
        x.set_json_string(j.at("JSONString").get<std::string>());
        x.set_pretty_easy_too(j.at("PrettyEasyToo").get<bool>());
        x.set_should_know_that_id_is_an_initialism(j.at("should_know_that_id_is_an_initialism").get<std::string>());
        x.set_spaces_are_separators_too(j.at("   spaces are separators  too  ").get<bool>());
        x.set_zsr_hh_demo3_delmatnr(j.at("ZSR_HH_DEMO3_DELMATNR").get<bool>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["anEasyOne"] = x.get_an_easy_one();
        j["isMNISTLetter"] = x.get_is_mnist_letter();
        j["JSONString"] = x.get_json_string();
        j["PrettyEasyToo"] = x.get_pretty_easy_too();
        j["should_know_that_id_is_an_initialism"] = x.get_should_know_that_id_is_an_initialism();
        j["   spaces are separators  too  "] = x.get_spaces_are_separators_too();
        j["ZSR_HH_DEMO3_DELMATNR"] = x.get_zsr_hh_demo3_delmatnr();
    }
}
