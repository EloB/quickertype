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

    enum class PullRequestState : int { OPEN, CLOSED, MERGED };

    class PullRequest {
        public:
        PullRequest() = default;
        virtual ~PullRequest() = default;

        private:
        PullRequestState state;

        public:
        const PullRequestState & get_state() const { return state; }
        PullRequestState & get_mutable_state() { return state; }
        void set_state(const PullRequestState & value) { this->state = value; }
    };

    class PullRequestConnection {
        public:
        PullRequestConnection() = default;
        virtual ~PullRequestConnection() = default;

        private:
        std::optional<std::vector<std::optional<PullRequest>>> nodes;

        public:
        std::optional<std::vector<std::optional<PullRequest>>> get_nodes() const { return nodes; }
        void set_nodes(std::optional<std::vector<std::optional<PullRequest>>> value) { this->nodes = value; }
    };

    class Repository {
        public:
        Repository() = default;
        virtual ~Repository() = default;

        private:
        PullRequestConnection pull_requests;

        public:
        const PullRequestConnection & get_pull_requests() const { return pull_requests; }
        PullRequestConnection & get_mutable_pull_requests() { return pull_requests; }
        void set_pull_requests(const PullRequestConnection & value) { this->pull_requests = value; }
    };

    class User {
        public:
        User() = default;
        virtual ~User() = default;

        private:
        std::string login;
        std::optional<Repository> repository;

        public:
        const std::string & get_login() const { return login; }
        std::string & get_mutable_login() { return login; }
        void set_login(const std::string & value) { this->login = value; }

        std::optional<Repository> get_repository() const { return repository; }
        void set_repository(std::optional<Repository> value) { this->repository = value; }
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
    void from_json(const json & j, PullRequest & x);
    void to_json(json & j, const PullRequest & x);

    void from_json(const json & j, PullRequestConnection & x);
    void to_json(json & j, const PullRequestConnection & x);

    void from_json(const json & j, Repository & x);
    void to_json(json & j, const Repository & x);

    void from_json(const json & j, User & x);
    void to_json(json & j, const User & x);

    void from_json(const json & j, Data & x);
    void to_json(json & j, const Data & x);

    void from_json(const json & j, Error & x);
    void to_json(json & j, const Error & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, PullRequestState & x);
    void to_json(json & j, const PullRequestState & x);

    inline void from_json(const json & j, PullRequest& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_state(j.at("state").get<PullRequestState>());
    }

    inline void to_json(json & j, const PullRequest & x) {
        j = json::object();
        j["state"] = x.get_state();
    }

    inline void from_json(const json & j, PullRequestConnection& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("nodes");
        x.set_nodes(get_stack_optional<std::vector<std::optional<PullRequest>>>(j, "nodes"));
    }

    inline void to_json(json & j, const PullRequestConnection & x) {
        j = json::object();
        j["nodes"] = x.get_nodes();
    }

    inline void from_json(const json & j, Repository& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_pull_requests(j.at("pullRequests").get<PullRequestConnection>());
    }

    inline void to_json(json & j, const Repository & x) {
        j = json::object();
        j["pullRequests"] = x.get_pull_requests();
    }

    inline void from_json(const json & j, User& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_login(j.at("login").get<std::string>());
        j.at("repository");
        x.set_repository(get_stack_optional<Repository>(j, "repository"));
    }

    inline void to_json(json & j, const User & x) {
        j = json::object();
        j["login"] = x.get_login();
        j["repository"] = x.get_repository();
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

    inline void from_json(const json & j, PullRequestState & x) {
        if (j == "OPEN") x = PullRequestState::OPEN;
        else if (j == "CLOSED") x = PullRequestState::CLOSED;
        else if (j == "MERGED") x = PullRequestState::MERGED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PullRequestState\""); }
    }

    inline void to_json(json & j, const PullRequestState & x) {
        switch (x) {
            case PullRequestState::OPEN: j = "OPEN"; break;
            case PullRequestState::CLOSED: j = "CLOSED"; break;
            case PullRequestState::MERGED: j = "MERGED"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"PullRequestState\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
