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

    class Headers {
        public:
        Headers() = default;
        virtual ~Headers() = default;

        private:
        std::string accept_encoding;
        std::string connection;
        std::string host;
        std::string user_agent;

        public:
        const std::string & get_accept_encoding() const { return accept_encoding; }
        std::string & get_mutable_accept_encoding() { return accept_encoding; }
        void set_accept_encoding(const std::string & value) { this->accept_encoding = value; }

        const std::string & get_connection() const { return connection; }
        std::string & get_mutable_connection() { return connection; }
        void set_connection(const std::string & value) { this->connection = value; }

        const std::string & get_host() const { return host; }
        std::string & get_mutable_host() { return host; }
        void set_host(const std::string & value) { this->host = value; }

        const std::string & get_user_agent() const { return user_agent; }
        std::string & get_mutable_user_agent() { return user_agent; }
        void set_user_agent(const std::string & value) { this->user_agent = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Headers headers;

        public:
        const Headers & get_headers() const { return headers; }
        Headers & get_mutable_headers() { return headers; }
        void set_headers(const Headers & value) { this->headers = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Headers & x);
    void to_json(json & j, const Headers & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Headers& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_accept_encoding(j.at("Accept-Encoding").get<std::string>());
        x.set_connection(j.at("Connection").get<std::string>());
        x.set_host(j.at("Host").get<std::string>());
        x.set_user_agent(j.at("User-Agent").get<std::string>());
    }

    inline void to_json(json & j, const Headers & x) {
        j = json::object();
        j["Accept-Encoding"] = x.get_accept_encoding();
        j["Connection"] = x.get_connection();
        j["Host"] = x.get_host();
        j["User-Agent"] = x.get_user_agent();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_headers(j.at("headers").get<Headers>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["headers"] = x.get_headers();
    }
}
