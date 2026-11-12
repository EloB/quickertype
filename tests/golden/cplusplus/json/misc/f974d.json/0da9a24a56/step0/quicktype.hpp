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
        int64_t block_index;
        std::string hash;
        int64_t height;
        int64_t time;
        std::vector<int64_t> tx_indexes;

        public:
        const int64_t & get_block_index() const { return block_index; }
        int64_t & get_mutable_block_index() { return block_index; }
        void set_block_index(const int64_t & value) { this->block_index = value; }

        const std::string & get_hash() const { return hash; }
        std::string & get_mutable_hash() { return hash; }
        void set_hash(const std::string & value) { this->hash = value; }

        const int64_t & get_height() const { return height; }
        int64_t & get_mutable_height() { return height; }
        void set_height(const int64_t & value) { this->height = value; }

        const int64_t & get_time() const { return time; }
        int64_t & get_mutable_time() { return time; }
        void set_time(const int64_t & value) { this->time = value; }

        const std::vector<int64_t> & get_tx_indexes() const { return tx_indexes; }
        std::vector<int64_t> & get_mutable_tx_indexes() { return tx_indexes; }
        void set_tx_indexes(const std::vector<int64_t> & value) { this->tx_indexes = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("block_index") != j.end() && !j.at("block_index").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_block_index(j.at("block_index").get<int64_t>());
        x.set_hash(j.at("hash").get<std::string>());
        if (j.find("height") != j.end() && !j.at("height").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_height(j.at("height").get<int64_t>());
        if (j.find("time") != j.end() && !j.at("time").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_time(j.at("time").get<int64_t>());
        x.set_tx_indexes(j.at("txIndexes").get<std::vector<int64_t>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["block_index"] = x.get_block_index();
        j["hash"] = x.get_hash();
        j["height"] = x.get_height();
        j["time"] = x.get_time();
        j["txIndexes"] = x.get_tx_indexes();
    }
}
