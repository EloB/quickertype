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

    class Args {
        public:
        Args() = default;
        virtual ~Args() = default;

        private:

        public:
    };

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
        Args args;
        std::string data;
        Args files;
        Args form;
        Headers headers;
        std::string origin;
        std::string url;

        public:
        const Args & get_args() const { return args; }
        Args & get_mutable_args() { return args; }
        void set_args(const Args & value) { this->args = value; }

        const std::string & get_data() const { return data; }
        std::string & get_mutable_data() { return data; }
        void set_data(const std::string & value) { this->data = value; }

        const Args & get_files() const { return files; }
        Args & get_mutable_files() { return files; }
        void set_files(const Args & value) { this->files = value; }

        const Args & get_form() const { return form; }
        Args & get_mutable_form() { return form; }
        void set_form(const Args & value) { this->form = value; }

        const Headers & get_headers() const { return headers; }
        Headers & get_mutable_headers() { return headers; }
        void set_headers(const Headers & value) { this->headers = value; }

        const std::string & get_origin() const { return origin; }
        std::string & get_mutable_origin() { return origin; }
        void set_origin(const std::string & value) { this->origin = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Args & x);
    void to_json(json & j, const Args & x);

    void from_json(const json & j, Headers & x);
    void to_json(json & j, const Headers & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Args& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Args & x) {
        j = json::object();
        (void)x;
    }

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
        x.set_args(j.at("args").get<Args>());
        x.set_data(j.at("data").get<std::string>());
        x.set_files(j.at("files").get<Args>());
        x.set_form(j.at("form").get<Args>());
        x.set_headers(j.at("headers").get<Headers>());
        x.set_origin(j.at("origin").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["args"] = x.get_args();
        j["data"] = x.get_data();
        j["files"] = x.get_files();
        j["form"] = x.get_form();
        j["headers"] = x.get_headers();
        j["origin"] = x.get_origin();
        j["url"] = x.get_url();
    }
}
