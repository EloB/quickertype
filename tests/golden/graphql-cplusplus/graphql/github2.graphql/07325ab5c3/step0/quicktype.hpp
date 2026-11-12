//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

#ifndef NLOHMANN_OPT_HELPER
#define NLOHMANN_OPT_HELPER
namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::shared_ptr<T>> {
        static void to_json(json & j, const std::shared_ptr<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(const json & j) {
            if (j.is_null()) return std::shared_ptr<T>(); else return std::make_shared<T>(j.get<T>());
        }
    };
    template <typename T>
    struct adl_serializer<std::optional<T>> {
        static void to_json(json & j, const std::optional<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::optional<T> from_json(const json & j) {
            if (j.is_null()) return std::optional<T>(); else return std::make_optional<T>(j.get<T>());
        }
    };
}
#endif

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

    #ifndef NLOHMANN_OPTIONAL_quicktype_HELPER
    #define NLOHMANN_OPTIONAL_quicktype_HELPER
    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, std::string property) {
        return get_heap_optional<T>(j, property.data());
    }
    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::optional<T>>();
        }
        return std::optional<T>();
    }

    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    class Repository {
        public:
        Repository() = default;
        virtual ~Repository() = default;

        private:
        std::string name;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class RepositoryConnection {
        public:
        RepositoryConnection() = default;
        virtual ~RepositoryConnection() = default;

        private:
        int64_t total_count;
        std::optional<std::vector<std::optional<Repository>>> nodes;

        public:
        const int64_t & get_total_count() const { return total_count; }
        int64_t & get_mutable_total_count() { return total_count; }
        void set_total_count(const int64_t & value) { this->total_count = value; }

        std::optional<std::vector<std::optional<Repository>>> get_nodes() const { return nodes; }
        void set_nodes(std::optional<std::vector<std::optional<Repository>>> value) { this->nodes = value; }
    };

    class User {
        public:
        User() = default;
        virtual ~User() = default;

        private:
        std::string login;
        RepositoryConnection repositories;

        public:
        const std::string & get_login() const { return login; }
        std::string & get_mutable_login() { return login; }
        void set_login(const std::string & value) { this->login = value; }

        const RepositoryConnection & get_repositories() const { return repositories; }
        RepositoryConnection & get_mutable_repositories() { return repositories; }
        void set_repositories(const RepositoryConnection & value) { this->repositories = value; }
    };

    class Data {
        public:
        Data() = default;
        virtual ~Data() = default;

        private:
        User viewer;

        public:
        const User & get_viewer() const { return viewer; }
        User & get_mutable_viewer() { return viewer; }
        void set_viewer(const User & value) { this->viewer = value; }
    };

    class Error {
        public:
        Error() = default;
        virtual ~Error() = default;

        private:
        std::string message;

        public:
        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string & value) { this->message = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<Data> data;
        std::optional<std::vector<Error>> errors;

        public:
        std::optional<Data> get_data() const { return data; }
        void set_data(std::optional<Data> value) { this->data = value; }

        const std::optional<std::vector<Error>> & get_errors() const { return errors; }
        std::optional<std::vector<Error>> & get_mutable_errors() { return errors; }
        void set_errors(const std::optional<std::vector<Error>> & value) { this->errors = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Repository & x);
    void to_json(json & j, const Repository & x);

    void from_json(const json & j, RepositoryConnection & x);
    void to_json(json & j, const RepositoryConnection & x);

    void from_json(const json & j, User & x);
    void to_json(json & j, const User & x);

    void from_json(const json & j, Data & x);
    void to_json(json & j, const Data & x);

    void from_json(const json & j, Error & x);
    void to_json(json & j, const Error & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Repository& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const Repository & x) {
        j = json::object();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, RepositoryConnection& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("totalCount") != j.end() && !j.at("totalCount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total_count(j.at("totalCount").get<int64_t>());
        j.at("nodes");
        x.set_nodes(get_stack_optional<std::vector<std::optional<Repository>>>(j, "nodes"));
    }

    inline void to_json(json & j, const RepositoryConnection & x) {
        j = json::object();
        j["totalCount"] = x.get_total_count();
        j["nodes"] = x.get_nodes();
    }

    inline void from_json(const json & j, User& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_login(j.at("login").get<std::string>());
        x.set_repositories(j.at("repositories").get<RepositoryConnection>());
    }

    inline void to_json(json & j, const User & x) {
        j = json::object();
        j["login"] = x.get_login();
        j["repositories"] = x.get_repositories();
    }

    inline void from_json(const json & j, Data& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_viewer(j.at("viewer").get<User>());
    }

    inline void to_json(json & j, const Data & x) {
        j = json::object();
        j["viewer"] = x.get_viewer();
    }

    inline void from_json(const json & j, Error& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_message(j.at("message").get<std::string>());
    }

    inline void to_json(json & j, const Error & x) {
        j = json::object();
        j["message"] = x.get_message();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("data");
        x.set_data(get_stack_optional<Data>(j, "data"));
        if (j.find("errors") != j.end() && j.at("errors").is_null()) throw std::runtime_error("Unexpected null");
        x.set_errors(get_stack_optional<std::vector<Error>>(j, "errors"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["errors"] = x.get_errors();
    }
}
