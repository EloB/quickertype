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

    enum class Language : int { MARKDOWN };

    enum class Type : int { TEXT_PLAIN };

    class File {
        public:
        File() = default;
        virtual ~File() = default;

        private:
        std::string filename;
        std::optional<Language> language;
        std::string raw_url;
        int64_t size;
        Type type;

        public:
        const std::string & get_filename() const { return filename; }
        std::string & get_mutable_filename() { return filename; }
        void set_filename(const std::string & value) { this->filename = value; }

        std::optional<Language> get_language() const { return language; }
        void set_language(std::optional<Language> value) { this->language = value; }

        const std::string & get_raw_url() const { return raw_url; }
        std::string & get_mutable_raw_url() { return raw_url; }
        void set_raw_url(const std::string & value) { this->raw_url = value; }

        const int64_t & get_size() const { return size; }
        int64_t & get_mutable_size() { return size; }
        void set_size(const int64_t & value) { this->size = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        int64_t comments;
        std::string comments_url;
        std::string commits_url;
        std::string created_at;
        std::optional<std::string> description;
        std::map<std::string, File> files;
        std::string forks_url;
        std::string git_pull_url;
        std::string git_push_url;
        std::string html_url;
        std::string id;
        bool top_level_public;
        bool truncated;
        std::string updated_at;
        std::string url;
        nlohmann::json user;

        public:
        const int64_t & get_comments() const { return comments; }
        int64_t & get_mutable_comments() { return comments; }
        void set_comments(const int64_t & value) { this->comments = value; }

        const std::string & get_comments_url() const { return comments_url; }
        std::string & get_mutable_comments_url() { return comments_url; }
        void set_comments_url(const std::string & value) { this->comments_url = value; }

        const std::string & get_commits_url() const { return commits_url; }
        std::string & get_mutable_commits_url() { return commits_url; }
        void set_commits_url(const std::string & value) { this->commits_url = value; }

        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        std::optional<std::string> get_description() const { return description; }
        void set_description(std::optional<std::string> value) { this->description = value; }

        const std::map<std::string, File> & get_files() const { return files; }
        std::map<std::string, File> & get_mutable_files() { return files; }
        void set_files(const std::map<std::string, File> & value) { this->files = value; }

        const std::string & get_forks_url() const { return forks_url; }
        std::string & get_mutable_forks_url() { return forks_url; }
        void set_forks_url(const std::string & value) { this->forks_url = value; }

        const std::string & get_git_pull_url() const { return git_pull_url; }
        std::string & get_mutable_git_pull_url() { return git_pull_url; }
        void set_git_pull_url(const std::string & value) { this->git_pull_url = value; }

        const std::string & get_git_push_url() const { return git_push_url; }
        std::string & get_mutable_git_push_url() { return git_push_url; }
        void set_git_push_url(const std::string & value) { this->git_push_url = value; }

        const std::string & get_html_url() const { return html_url; }
        std::string & get_mutable_html_url() { return html_url; }
        void set_html_url(const std::string & value) { this->html_url = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const bool & get_top_level_public() const { return top_level_public; }
        bool & get_mutable_top_level_public() { return top_level_public; }
        void set_top_level_public(const bool & value) { this->top_level_public = value; }

        const bool & get_truncated() const { return truncated; }
        bool & get_mutable_truncated() { return truncated; }
        void set_truncated(const bool & value) { this->truncated = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const nlohmann::json & get_user() const { return user; }
        nlohmann::json & get_mutable_user() { return user; }
        void set_user(const nlohmann::json & value) { this->user = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, File & x);
    void to_json(json & j, const File & x);

    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, Language & x);
    void to_json(json & j, const Language & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    inline void from_json(const json & j, File& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_filename(j.at("filename").get<std::string>());
        j.at("language");
        x.set_language(get_stack_optional<Language>(j, "language"));
        x.set_raw_url(j.at("raw_url").get<std::string>());
        if (j.find("size") != j.end() && !j.at("size").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_size(j.at("size").get<int64_t>());
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const File & x) {
        j = json::object();
        j["filename"] = x.get_filename();
        j["language"] = x.get_language();
        j["raw_url"] = x.get_raw_url();
        j["size"] = x.get_size();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("comments") != j.end() && !j.at("comments").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_comments(j.at("comments").get<int64_t>());
        x.set_comments_url(j.at("comments_url").get<std::string>());
        x.set_commits_url(j.at("commits_url").get<std::string>());
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        j.at("description");
        x.set_description(get_stack_optional<std::string>(j, "description"));
        x.set_files(j.at("files").get<std::map<std::string, File>>());
        x.set_forks_url(j.at("forks_url").get<std::string>());
        x.set_git_pull_url(j.at("git_pull_url").get<std::string>());
        x.set_git_push_url(j.at("git_push_url").get<std::string>());
        x.set_html_url(j.at("html_url").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_top_level_public(j.at("public").get<bool>());
        x.set_truncated(j.at("truncated").get<bool>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
        x.set_user(get_untyped(j, "user"));
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["comments"] = x.get_comments();
        j["comments_url"] = x.get_comments_url();
        j["commits_url"] = x.get_commits_url();
        j["created_at"] = x.get_created_at();
        j["description"] = x.get_description();
        j["files"] = x.get_files();
        j["forks_url"] = x.get_forks_url();
        j["git_pull_url"] = x.get_git_pull_url();
        j["git_push_url"] = x.get_git_push_url();
        j["html_url"] = x.get_html_url();
        j["id"] = x.get_id();
        j["public"] = x.get_top_level_public();
        j["truncated"] = x.get_truncated();
        j["updated_at"] = x.get_updated_at();
        j["url"] = x.get_url();
        j["user"] = x.get_user();
    }

    inline void from_json(const json & j, Language & x) {
        if (j == "Markdown") x = Language::MARKDOWN;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Language\""); }
    }

    inline void to_json(json & j, const Language & x) {
        switch (x) {
            case Language::MARKDOWN: j = "Markdown"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Language\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "text/plain") x = Type::TEXT_PLAIN;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::TEXT_PLAIN: j = "text/plain"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
