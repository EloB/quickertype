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

    enum class IssueState : int { OPEN, CLOSED };

    class IssueOrPullRequest {
        public:
        IssueOrPullRequest() = default;
        virtual ~IssueOrPullRequest() = default;

        private:
        std::optional<std::string> title;
        std::optional<IssueState> state;
        std::optional<bool> merged;

        public:
        const std::optional<std::string> & get_title() const { return title; }
        std::optional<std::string> & get_mutable_title() { return title; }
        void set_title(const std::optional<std::string> & value) { this->title = value; }

        const std::optional<IssueState> & get_state() const { return state; }
        std::optional<IssueState> & get_mutable_state() { return state; }
        void set_state(const std::optional<IssueState> & value) { this->state = value; }

        const std::optional<bool> & get_merged() const { return merged; }
        std::optional<bool> & get_mutable_merged() { return merged; }
        void set_merged(const std::optional<bool> & value) { this->merged = value; }
    };

    class Repository {
        public:
        Repository() = default;
        virtual ~Repository() = default;

        private:
        std::string name_with_owner;
        std::optional<IssueOrPullRequest> n303;
        std::optional<IssueOrPullRequest> n307;

        public:
        const std::string & get_name_with_owner() const { return name_with_owner; }
        std::string & get_mutable_name_with_owner() { return name_with_owner; }
        void set_name_with_owner(const std::string & value) { this->name_with_owner = value; }

        std::optional<IssueOrPullRequest> get_n303() const { return n303; }
        void set_n303(std::optional<IssueOrPullRequest> value) { this->n303 = value; }

        std::optional<IssueOrPullRequest> get_n307() const { return n307; }
        void set_n307(std::optional<IssueOrPullRequest> value) { this->n307 = value; }
    };

    class Data {
        public:
        Data() = default;
        virtual ~Data() = default;

        private:
        std::optional<Repository> repository;

        public:
        std::optional<Repository> get_repository() const { return repository; }
        void set_repository(std::optional<Repository> value) { this->repository = value; }
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
    void from_json(const json & j, IssueOrPullRequest & x);
    void to_json(json & j, const IssueOrPullRequest & x);

    void from_json(const json & j, Repository & x);
    void to_json(json & j, const Repository & x);

    void from_json(const json & j, Data & x);
    void to_json(json & j, const Data & x);

    void from_json(const json & j, Error & x);
    void to_json(json & j, const Error & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, IssueState & x);
    void to_json(json & j, const IssueState & x);

    inline void from_json(const json & j, IssueOrPullRequest& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("title") != j.end() && j.at("title").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title(get_stack_optional<std::string>(j, "title"));
        if (j.find("state") != j.end() && j.at("state").is_null()) throw std::runtime_error("Unexpected null");
        x.set_state(get_stack_optional<IssueState>(j, "state"));
        if (j.find("merged") != j.end() && j.at("merged").is_null()) throw std::runtime_error("Unexpected null");
        x.set_merged(get_stack_optional<bool>(j, "merged"));
    }

    inline void to_json(json & j, const IssueOrPullRequest & x) {
        j = json::object();
        j["title"] = x.get_title();
        j["state"] = x.get_state();
        j["merged"] = x.get_merged();
    }

    inline void from_json(const json & j, Repository& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name_with_owner(j.at("nameWithOwner").get<std::string>());
        j.at("n303");
        x.set_n303(get_stack_optional<IssueOrPullRequest>(j, "n303"));
        j.at("n307");
        x.set_n307(get_stack_optional<IssueOrPullRequest>(j, "n307"));
    }

    inline void to_json(json & j, const Repository & x) {
        j = json::object();
        j["nameWithOwner"] = x.get_name_with_owner();
        j["n303"] = x.get_n303();
        j["n307"] = x.get_n307();
    }

    inline void from_json(const json & j, Data& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("repository");
        x.set_repository(get_stack_optional<Repository>(j, "repository"));
    }

    inline void to_json(json & j, const Data & x) {
        j = json::object();
        j["repository"] = x.get_repository();
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

    inline void from_json(const json & j, IssueState & x) {
        if (j == "OPEN") x = IssueState::OPEN;
        else if (j == "CLOSED") x = IssueState::CLOSED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"IssueState\""); }
    }

    inline void to_json(json & j, const IssueState & x) {
        switch (x) {
            case IssueState::OPEN: j = "OPEN"; break;
            case IssueState::CLOSED: j = "CLOSED"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"IssueState\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
