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

    class Response {
        public:
        Response() = default;
        virtual ~Response() = default;

        private:
        int64_t player_count;
        int64_t result;

        public:
        const int64_t & get_player_count() const { return player_count; }
        int64_t & get_mutable_player_count() { return player_count; }
        void set_player_count(const int64_t & value) { this->player_count = value; }

        const int64_t & get_result() const { return result; }
        int64_t & get_mutable_result() { return result; }
        void set_result(const int64_t & value) { this->result = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Response response;

        public:
        const Response & get_response() const { return response; }
        Response & get_mutable_response() { return response; }
        void set_response(const Response & value) { this->response = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Response & x);
    void to_json(json & j, const Response & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Response& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("player_count") != j.end() && !j.at("player_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_player_count(j.at("player_count").get<int64_t>());
        if (j.find("result") != j.end() && !j.at("result").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_result(j.at("result").get<int64_t>());
    }

    inline void to_json(json & j, const Response & x) {
        j = json::object();
        j["player_count"] = x.get_player_count();
        j["result"] = x.get_result();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_response(j.at("response").get<Response>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["response"] = x.get_response();
    }
}
