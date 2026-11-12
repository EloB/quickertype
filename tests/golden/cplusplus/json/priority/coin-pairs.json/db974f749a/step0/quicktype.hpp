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

    class Pair {
        public:
        Pair() = default;
        virtual ~Pair() = default;

        private:
        int64_t decimal_places;
        double fee;
        int64_t hidden;
        int64_t max_amount;
        int64_t max_price;
        double min_amount;
        double min_price;
        double min_total;

        public:
        const int64_t & get_decimal_places() const { return decimal_places; }
        int64_t & get_mutable_decimal_places() { return decimal_places; }
        void set_decimal_places(const int64_t & value) { this->decimal_places = value; }

        const double & get_fee() const { return fee; }
        double & get_mutable_fee() { return fee; }
        void set_fee(const double & value) { this->fee = value; }

        const int64_t & get_hidden() const { return hidden; }
        int64_t & get_mutable_hidden() { return hidden; }
        void set_hidden(const int64_t & value) { this->hidden = value; }

        const int64_t & get_max_amount() const { return max_amount; }
        int64_t & get_mutable_max_amount() { return max_amount; }
        void set_max_amount(const int64_t & value) { this->max_amount = value; }

        const int64_t & get_max_price() const { return max_price; }
        int64_t & get_mutable_max_price() { return max_price; }
        void set_max_price(const int64_t & value) { this->max_price = value; }

        const double & get_min_amount() const { return min_amount; }
        double & get_mutable_min_amount() { return min_amount; }
        void set_min_amount(const double & value) { this->min_amount = value; }

        const double & get_min_price() const { return min_price; }
        double & get_mutable_min_price() { return min_price; }
        void set_min_price(const double & value) { this->min_price = value; }

        const double & get_min_total() const { return min_total; }
        double & get_mutable_min_total() { return min_total; }
        void set_min_total(const double & value) { this->min_total = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::map<std::string, Pair> pairs;
        int64_t server_time;

        public:
        const std::map<std::string, Pair> & get_pairs() const { return pairs; }
        std::map<std::string, Pair> & get_mutable_pairs() { return pairs; }
        void set_pairs(const std::map<std::string, Pair> & value) { this->pairs = value; }

        const int64_t & get_server_time() const { return server_time; }
        int64_t & get_mutable_server_time() { return server_time; }
        void set_server_time(const int64_t & value) { this->server_time = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Pair & x);
    void to_json(json & j, const Pair & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Pair& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("decimal_places") != j.end() && !j.at("decimal_places").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_decimal_places(j.at("decimal_places").get<int64_t>());
        x.set_fee(j.at("fee").get<double>());
        if (j.find("hidden") != j.end() && !j.at("hidden").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_hidden(j.at("hidden").get<int64_t>());
        if (j.find("max_amount") != j.end() && !j.at("max_amount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_max_amount(j.at("max_amount").get<int64_t>());
        if (j.find("max_price") != j.end() && !j.at("max_price").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_max_price(j.at("max_price").get<int64_t>());
        x.set_min_amount(j.at("min_amount").get<double>());
        x.set_min_price(j.at("min_price").get<double>());
        x.set_min_total(j.at("min_total").get<double>());
    }

    inline void to_json(json & j, const Pair & x) {
        j = json::object();
        j["decimal_places"] = x.get_decimal_places();
        j["fee"] = x.get_fee();
        j["hidden"] = x.get_hidden();
        j["max_amount"] = x.get_max_amount();
        j["max_price"] = x.get_max_price();
        j["min_amount"] = x.get_min_amount();
        j["min_price"] = x.get_min_price();
        j["min_total"] = x.get_min_total();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_pairs(j.at("pairs").get<std::map<std::string, Pair>>());
        if (j.find("server_time") != j.end() && !j.at("server_time").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_server_time(j.at("server_time").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["pairs"] = x.get_pairs();
        j["server_time"] = x.get_server_time();
    }
}
