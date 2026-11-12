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
        std::vector<std::string> git;
        std::string github_services_sha;
        std::vector<std::string> hooks;
        std::vector<std::string> importer;
        std::vector<std::string> pages;
        bool verifiable_password_authentication;

        public:
        const std::vector<std::string> & get_git() const { return git; }
        std::vector<std::string> & get_mutable_git() { return git; }
        void set_git(const std::vector<std::string> & value) { this->git = value; }

        const std::string & get_github_services_sha() const { return github_services_sha; }
        std::string & get_mutable_github_services_sha() { return github_services_sha; }
        void set_github_services_sha(const std::string & value) { this->github_services_sha = value; }

        const std::vector<std::string> & get_hooks() const { return hooks; }
        std::vector<std::string> & get_mutable_hooks() { return hooks; }
        void set_hooks(const std::vector<std::string> & value) { this->hooks = value; }

        const std::vector<std::string> & get_importer() const { return importer; }
        std::vector<std::string> & get_mutable_importer() { return importer; }
        void set_importer(const std::vector<std::string> & value) { this->importer = value; }

        const std::vector<std::string> & get_pages() const { return pages; }
        std::vector<std::string> & get_mutable_pages() { return pages; }
        void set_pages(const std::vector<std::string> & value) { this->pages = value; }

        const bool & get_verifiable_password_authentication() const { return verifiable_password_authentication; }
        bool & get_mutable_verifiable_password_authentication() { return verifiable_password_authentication; }
        void set_verifiable_password_authentication(const bool & value) { this->verifiable_password_authentication = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_git(j.at("git").get<std::vector<std::string>>());
        x.set_github_services_sha(j.at("github_services_sha").get<std::string>());
        x.set_hooks(j.at("hooks").get<std::vector<std::string>>());
        x.set_importer(j.at("importer").get<std::vector<std::string>>());
        x.set_pages(j.at("pages").get<std::vector<std::string>>());
        x.set_verifiable_password_authentication(j.at("verifiable_password_authentication").get<bool>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["git"] = x.get_git();
        j["github_services_sha"] = x.get_github_services_sha();
        j["hooks"] = x.get_hooks();
        j["importer"] = x.get_importer();
        j["pages"] = x.get_pages();
        j["verifiable_password_authentication"] = x.get_verifiable_password_authentication();
    }
}
