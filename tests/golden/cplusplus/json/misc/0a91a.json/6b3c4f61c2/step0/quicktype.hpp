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

    class Actor {
        public:
        Actor() = default;
        virtual ~Actor() = default;

        private:
        std::string avatar_url;
        std::optional<std::string> display_login;
        std::string gravatar_id;
        int64_t id;
        std::string login;
        std::string url;

        public:
        const std::string & get_avatar_url() const { return avatar_url; }
        std::string & get_mutable_avatar_url() { return avatar_url; }
        void set_avatar_url(const std::string & value) { this->avatar_url = value; }

        const std::optional<std::string> & get_display_login() const { return display_login; }
        std::optional<std::string> & get_mutable_display_login() { return display_login; }
        void set_display_login(const std::optional<std::string> & value) { this->display_login = value; }

        const std::string & get_gravatar_id() const { return gravatar_id; }
        std::string & get_mutable_gravatar_id() { return gravatar_id; }
        void set_gravatar_id(const std::string & value) { this->gravatar_id = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_login() const { return login; }
        std::string & get_mutable_login() { return login; }
        void set_login(const std::string & value) { this->login = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class Author {
        public:
        Author() = default;
        virtual ~Author() = default;

        private:
        std::string email;
        std::string name;

        public:
        const std::string & get_email() const { return email; }
        std::string & get_mutable_email() { return email; }
        void set_email(const std::string & value) { this->email = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class Commit {
        public:
        Commit() = default;
        virtual ~Commit() = default;

        private:
        Author author;
        bool distinct;
        std::string message;
        std::string sha;
        std::string url;

        public:
        const Author & get_author() const { return author; }
        Author & get_mutable_author() { return author; }
        void set_author(const Author & value) { this->author = value; }

        const bool & get_distinct() const { return distinct; }
        bool & get_mutable_distinct() { return distinct; }
        void set_distinct(const bool & value) { this->distinct = value; }

        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string & value) { this->message = value; }

        const std::string & get_sha() const { return sha; }
        std::string & get_mutable_sha() { return sha; }
        void set_sha(const std::string & value) { this->sha = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class MergedBy {
        public:
        MergedBy() = default;
        virtual ~MergedBy() = default;

        private:
        std::string avatar_url;
        std::string events_url;
        std::string followers_url;
        std::string following_url;
        std::string gists_url;
        std::string gravatar_id;
        std::string html_url;
        int64_t id;
        std::string login;
        std::string organizations_url;
        std::string received_events_url;
        std::string repos_url;
        bool site_admin;
        std::string starred_url;
        std::string subscriptions_url;
        std::string type;
        std::string url;

        public:
        const std::string & get_avatar_url() const { return avatar_url; }
        std::string & get_mutable_avatar_url() { return avatar_url; }
        void set_avatar_url(const std::string & value) { this->avatar_url = value; }

        const std::string & get_events_url() const { return events_url; }
        std::string & get_mutable_events_url() { return events_url; }
        void set_events_url(const std::string & value) { this->events_url = value; }

        const std::string & get_followers_url() const { return followers_url; }
        std::string & get_mutable_followers_url() { return followers_url; }
        void set_followers_url(const std::string & value) { this->followers_url = value; }

        const std::string & get_following_url() const { return following_url; }
        std::string & get_mutable_following_url() { return following_url; }
        void set_following_url(const std::string & value) { this->following_url = value; }

        const std::string & get_gists_url() const { return gists_url; }
        std::string & get_mutable_gists_url() { return gists_url; }
        void set_gists_url(const std::string & value) { this->gists_url = value; }

        const std::string & get_gravatar_id() const { return gravatar_id; }
        std::string & get_mutable_gravatar_id() { return gravatar_id; }
        void set_gravatar_id(const std::string & value) { this->gravatar_id = value; }

        const std::string & get_html_url() const { return html_url; }
        std::string & get_mutable_html_url() { return html_url; }
        void set_html_url(const std::string & value) { this->html_url = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_login() const { return login; }
        std::string & get_mutable_login() { return login; }
        void set_login(const std::string & value) { this->login = value; }

        const std::string & get_organizations_url() const { return organizations_url; }
        std::string & get_mutable_organizations_url() { return organizations_url; }
        void set_organizations_url(const std::string & value) { this->organizations_url = value; }

        const std::string & get_received_events_url() const { return received_events_url; }
        std::string & get_mutable_received_events_url() { return received_events_url; }
        void set_received_events_url(const std::string & value) { this->received_events_url = value; }

        const std::string & get_repos_url() const { return repos_url; }
        std::string & get_mutable_repos_url() { return repos_url; }
        void set_repos_url(const std::string & value) { this->repos_url = value; }

        const bool & get_site_admin() const { return site_admin; }
        bool & get_mutable_site_admin() { return site_admin; }
        void set_site_admin(const bool & value) { this->site_admin = value; }

        const std::string & get_starred_url() const { return starred_url; }
        std::string & get_mutable_starred_url() { return starred_url; }
        void set_starred_url(const std::string & value) { this->starred_url = value; }

        const std::string & get_subscriptions_url() const { return subscriptions_url; }
        std::string & get_mutable_subscriptions_url() { return subscriptions_url; }
        void set_subscriptions_url(const std::string & value) { this->subscriptions_url = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class BaseRepo {
        public:
        BaseRepo() = default;
        virtual ~BaseRepo() = default;

        private:
        std::string archive_url;
        std::string assignees_url;
        std::string blobs_url;
        std::string branches_url;
        std::string clone_url;
        std::string collaborators_url;
        std::string comments_url;
        std::string commits_url;
        std::string compare_url;
        std::string contents_url;
        std::string contributors_url;
        std::string created_at;
        std::string default_branch;
        std::string deployments_url;
        nlohmann::json description;
        std::string downloads_url;
        std::string events_url;
        bool fork;
        int64_t forks;
        int64_t forks_count;
        std::string forks_url;
        std::string full_name;
        std::string git_commits_url;
        std::string git_refs_url;
        std::string git_tags_url;
        std::string git_url;
        bool has_downloads;
        bool has_issues;
        bool has_pages;
        bool has_projects;
        bool has_wiki;
        nlohmann::json homepage;
        std::string hooks_url;
        std::string html_url;
        int64_t id;
        std::string issue_comment_url;
        std::string issue_events_url;
        std::string issues_url;
        std::string keys_url;
        std::string labels_url;
        std::string language;
        std::string languages_url;
        std::string merges_url;
        std::string milestones_url;
        nlohmann::json mirror_url;
        std::string name;
        std::string notifications_url;
        int64_t open_issues;
        int64_t open_issues_count;
        MergedBy owner;
        std::string pulls_url;
        std::string pushed_at;
        std::string releases_url;
        bool repo_private;
        int64_t size;
        std::string ssh_url;
        int64_t stargazers_count;
        std::string stargazers_url;
        std::string statuses_url;
        std::string subscribers_url;
        std::string subscription_url;
        std::string svn_url;
        std::string tags_url;
        std::string teams_url;
        std::string trees_url;
        std::string updated_at;
        std::string url;
        int64_t watchers;
        int64_t watchers_count;

        public:
        const std::string & get_archive_url() const { return archive_url; }
        std::string & get_mutable_archive_url() { return archive_url; }
        void set_archive_url(const std::string & value) { this->archive_url = value; }

        const std::string & get_assignees_url() const { return assignees_url; }
        std::string & get_mutable_assignees_url() { return assignees_url; }
        void set_assignees_url(const std::string & value) { this->assignees_url = value; }

        const std::string & get_blobs_url() const { return blobs_url; }
        std::string & get_mutable_blobs_url() { return blobs_url; }
        void set_blobs_url(const std::string & value) { this->blobs_url = value; }

        const std::string & get_branches_url() const { return branches_url; }
        std::string & get_mutable_branches_url() { return branches_url; }
        void set_branches_url(const std::string & value) { this->branches_url = value; }

        const std::string & get_clone_url() const { return clone_url; }
        std::string & get_mutable_clone_url() { return clone_url; }
        void set_clone_url(const std::string & value) { this->clone_url = value; }

        const std::string & get_collaborators_url() const { return collaborators_url; }
        std::string & get_mutable_collaborators_url() { return collaborators_url; }
        void set_collaborators_url(const std::string & value) { this->collaborators_url = value; }

        const std::string & get_comments_url() const { return comments_url; }
        std::string & get_mutable_comments_url() { return comments_url; }
        void set_comments_url(const std::string & value) { this->comments_url = value; }

        const std::string & get_commits_url() const { return commits_url; }
        std::string & get_mutable_commits_url() { return commits_url; }
        void set_commits_url(const std::string & value) { this->commits_url = value; }

        const std::string & get_compare_url() const { return compare_url; }
        std::string & get_mutable_compare_url() { return compare_url; }
        void set_compare_url(const std::string & value) { this->compare_url = value; }

        const std::string & get_contents_url() const { return contents_url; }
        std::string & get_mutable_contents_url() { return contents_url; }
        void set_contents_url(const std::string & value) { this->contents_url = value; }

        const std::string & get_contributors_url() const { return contributors_url; }
        std::string & get_mutable_contributors_url() { return contributors_url; }
        void set_contributors_url(const std::string & value) { this->contributors_url = value; }

        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        const std::string & get_default_branch() const { return default_branch; }
        std::string & get_mutable_default_branch() { return default_branch; }
        void set_default_branch(const std::string & value) { this->default_branch = value; }

        const std::string & get_deployments_url() const { return deployments_url; }
        std::string & get_mutable_deployments_url() { return deployments_url; }
        void set_deployments_url(const std::string & value) { this->deployments_url = value; }

        const nlohmann::json & get_description() const { return description; }
        nlohmann::json & get_mutable_description() { return description; }
        void set_description(const nlohmann::json & value) { this->description = value; }

        const std::string & get_downloads_url() const { return downloads_url; }
        std::string & get_mutable_downloads_url() { return downloads_url; }
        void set_downloads_url(const std::string & value) { this->downloads_url = value; }

        const std::string & get_events_url() const { return events_url; }
        std::string & get_mutable_events_url() { return events_url; }
        void set_events_url(const std::string & value) { this->events_url = value; }

        const bool & get_fork() const { return fork; }
        bool & get_mutable_fork() { return fork; }
        void set_fork(const bool & value) { this->fork = value; }

        const int64_t & get_forks() const { return forks; }
        int64_t & get_mutable_forks() { return forks; }
        void set_forks(const int64_t & value) { this->forks = value; }

        const int64_t & get_forks_count() const { return forks_count; }
        int64_t & get_mutable_forks_count() { return forks_count; }
        void set_forks_count(const int64_t & value) { this->forks_count = value; }

        const std::string & get_forks_url() const { return forks_url; }
        std::string & get_mutable_forks_url() { return forks_url; }
        void set_forks_url(const std::string & value) { this->forks_url = value; }

        const std::string & get_full_name() const { return full_name; }
        std::string & get_mutable_full_name() { return full_name; }
        void set_full_name(const std::string & value) { this->full_name = value; }

        const std::string & get_git_commits_url() const { return git_commits_url; }
        std::string & get_mutable_git_commits_url() { return git_commits_url; }
        void set_git_commits_url(const std::string & value) { this->git_commits_url = value; }

        const std::string & get_git_refs_url() const { return git_refs_url; }
        std::string & get_mutable_git_refs_url() { return git_refs_url; }
        void set_git_refs_url(const std::string & value) { this->git_refs_url = value; }

        const std::string & get_git_tags_url() const { return git_tags_url; }
        std::string & get_mutable_git_tags_url() { return git_tags_url; }
        void set_git_tags_url(const std::string & value) { this->git_tags_url = value; }

        const std::string & get_git_url() const { return git_url; }
        std::string & get_mutable_git_url() { return git_url; }
        void set_git_url(const std::string & value) { this->git_url = value; }

        const bool & get_has_downloads() const { return has_downloads; }
        bool & get_mutable_has_downloads() { return has_downloads; }
        void set_has_downloads(const bool & value) { this->has_downloads = value; }

        const bool & get_has_issues() const { return has_issues; }
        bool & get_mutable_has_issues() { return has_issues; }
        void set_has_issues(const bool & value) { this->has_issues = value; }

        const bool & get_has_pages() const { return has_pages; }
        bool & get_mutable_has_pages() { return has_pages; }
        void set_has_pages(const bool & value) { this->has_pages = value; }

        const bool & get_has_projects() const { return has_projects; }
        bool & get_mutable_has_projects() { return has_projects; }
        void set_has_projects(const bool & value) { this->has_projects = value; }

        const bool & get_has_wiki() const { return has_wiki; }
        bool & get_mutable_has_wiki() { return has_wiki; }
        void set_has_wiki(const bool & value) { this->has_wiki = value; }

        const nlohmann::json & get_homepage() const { return homepage; }
        nlohmann::json & get_mutable_homepage() { return homepage; }
        void set_homepage(const nlohmann::json & value) { this->homepage = value; }

        const std::string & get_hooks_url() const { return hooks_url; }
        std::string & get_mutable_hooks_url() { return hooks_url; }
        void set_hooks_url(const std::string & value) { this->hooks_url = value; }

        const std::string & get_html_url() const { return html_url; }
        std::string & get_mutable_html_url() { return html_url; }
        void set_html_url(const std::string & value) { this->html_url = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_issue_comment_url() const { return issue_comment_url; }
        std::string & get_mutable_issue_comment_url() { return issue_comment_url; }
        void set_issue_comment_url(const std::string & value) { this->issue_comment_url = value; }

        const std::string & get_issue_events_url() const { return issue_events_url; }
        std::string & get_mutable_issue_events_url() { return issue_events_url; }
        void set_issue_events_url(const std::string & value) { this->issue_events_url = value; }

        const std::string & get_issues_url() const { return issues_url; }
        std::string & get_mutable_issues_url() { return issues_url; }
        void set_issues_url(const std::string & value) { this->issues_url = value; }

        const std::string & get_keys_url() const { return keys_url; }
        std::string & get_mutable_keys_url() { return keys_url; }
        void set_keys_url(const std::string & value) { this->keys_url = value; }

        const std::string & get_labels_url() const { return labels_url; }
        std::string & get_mutable_labels_url() { return labels_url; }
        void set_labels_url(const std::string & value) { this->labels_url = value; }

        const std::string & get_language() const { return language; }
        std::string & get_mutable_language() { return language; }
        void set_language(const std::string & value) { this->language = value; }

        const std::string & get_languages_url() const { return languages_url; }
        std::string & get_mutable_languages_url() { return languages_url; }
        void set_languages_url(const std::string & value) { this->languages_url = value; }

        const std::string & get_merges_url() const { return merges_url; }
        std::string & get_mutable_merges_url() { return merges_url; }
        void set_merges_url(const std::string & value) { this->merges_url = value; }

        const std::string & get_milestones_url() const { return milestones_url; }
        std::string & get_mutable_milestones_url() { return milestones_url; }
        void set_milestones_url(const std::string & value) { this->milestones_url = value; }

        const nlohmann::json & get_mirror_url() const { return mirror_url; }
        nlohmann::json & get_mutable_mirror_url() { return mirror_url; }
        void set_mirror_url(const nlohmann::json & value) { this->mirror_url = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_notifications_url() const { return notifications_url; }
        std::string & get_mutable_notifications_url() { return notifications_url; }
        void set_notifications_url(const std::string & value) { this->notifications_url = value; }

        const int64_t & get_open_issues() const { return open_issues; }
        int64_t & get_mutable_open_issues() { return open_issues; }
        void set_open_issues(const int64_t & value) { this->open_issues = value; }

        const int64_t & get_open_issues_count() const { return open_issues_count; }
        int64_t & get_mutable_open_issues_count() { return open_issues_count; }
        void set_open_issues_count(const int64_t & value) { this->open_issues_count = value; }

        const MergedBy & get_owner() const { return owner; }
        MergedBy & get_mutable_owner() { return owner; }
        void set_owner(const MergedBy & value) { this->owner = value; }

        const std::string & get_pulls_url() const { return pulls_url; }
        std::string & get_mutable_pulls_url() { return pulls_url; }
        void set_pulls_url(const std::string & value) { this->pulls_url = value; }

        const std::string & get_pushed_at() const { return pushed_at; }
        std::string & get_mutable_pushed_at() { return pushed_at; }
        void set_pushed_at(const std::string & value) { this->pushed_at = value; }

        const std::string & get_releases_url() const { return releases_url; }
        std::string & get_mutable_releases_url() { return releases_url; }
        void set_releases_url(const std::string & value) { this->releases_url = value; }

        const bool & get_repo_private() const { return repo_private; }
        bool & get_mutable_repo_private() { return repo_private; }
        void set_repo_private(const bool & value) { this->repo_private = value; }

        const int64_t & get_size() const { return size; }
        int64_t & get_mutable_size() { return size; }
        void set_size(const int64_t & value) { this->size = value; }

        const std::string & get_ssh_url() const { return ssh_url; }
        std::string & get_mutable_ssh_url() { return ssh_url; }
        void set_ssh_url(const std::string & value) { this->ssh_url = value; }

        const int64_t & get_stargazers_count() const { return stargazers_count; }
        int64_t & get_mutable_stargazers_count() { return stargazers_count; }
        void set_stargazers_count(const int64_t & value) { this->stargazers_count = value; }

        const std::string & get_stargazers_url() const { return stargazers_url; }
        std::string & get_mutable_stargazers_url() { return stargazers_url; }
        void set_stargazers_url(const std::string & value) { this->stargazers_url = value; }

        const std::string & get_statuses_url() const { return statuses_url; }
        std::string & get_mutable_statuses_url() { return statuses_url; }
        void set_statuses_url(const std::string & value) { this->statuses_url = value; }

        const std::string & get_subscribers_url() const { return subscribers_url; }
        std::string & get_mutable_subscribers_url() { return subscribers_url; }
        void set_subscribers_url(const std::string & value) { this->subscribers_url = value; }

        const std::string & get_subscription_url() const { return subscription_url; }
        std::string & get_mutable_subscription_url() { return subscription_url; }
        void set_subscription_url(const std::string & value) { this->subscription_url = value; }

        const std::string & get_svn_url() const { return svn_url; }
        std::string & get_mutable_svn_url() { return svn_url; }
        void set_svn_url(const std::string & value) { this->svn_url = value; }

        const std::string & get_tags_url() const { return tags_url; }
        std::string & get_mutable_tags_url() { return tags_url; }
        void set_tags_url(const std::string & value) { this->tags_url = value; }

        const std::string & get_teams_url() const { return teams_url; }
        std::string & get_mutable_teams_url() { return teams_url; }
        void set_teams_url(const std::string & value) { this->teams_url = value; }

        const std::string & get_trees_url() const { return trees_url; }
        std::string & get_mutable_trees_url() { return trees_url; }
        void set_trees_url(const std::string & value) { this->trees_url = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const int64_t & get_watchers() const { return watchers; }
        int64_t & get_mutable_watchers() { return watchers; }
        void set_watchers(const int64_t & value) { this->watchers = value; }

        const int64_t & get_watchers_count() const { return watchers_count; }
        int64_t & get_mutable_watchers_count() { return watchers_count; }
        void set_watchers_count(const int64_t & value) { this->watchers_count = value; }
    };

    class Base {
        public:
        Base() = default;
        virtual ~Base() = default;

        private:
        std::string label;
        std::string ref;
        BaseRepo repo;
        std::string sha;
        MergedBy user;

        public:
        const std::string & get_label() const { return label; }
        std::string & get_mutable_label() { return label; }
        void set_label(const std::string & value) { this->label = value; }

        const std::string & get_ref() const { return ref; }
        std::string & get_mutable_ref() { return ref; }
        void set_ref(const std::string & value) { this->ref = value; }

        const BaseRepo & get_repo() const { return repo; }
        BaseRepo & get_mutable_repo() { return repo; }
        void set_repo(const BaseRepo & value) { this->repo = value; }

        const std::string & get_sha() const { return sha; }
        std::string & get_mutable_sha() { return sha; }
        void set_sha(const std::string & value) { this->sha = value; }

        const MergedBy & get_user() const { return user; }
        MergedBy & get_mutable_user() { return user; }
        void set_user(const MergedBy & value) { this->user = value; }
    };

    class Comments {
        public:
        Comments() = default;
        virtual ~Comments() = default;

        private:
        std::string href;

        public:
        const std::string & get_href() const { return href; }
        std::string & get_mutable_href() { return href; }
        void set_href(const std::string & value) { this->href = value; }
    };

    class Links {
        public:
        Links() = default;
        virtual ~Links() = default;

        private:
        Comments comments;
        Comments commits;
        Comments html;
        Comments issue;
        Comments review_comment;
        Comments review_comments;
        Comments self;
        Comments statuses;

        public:
        const Comments & get_comments() const { return comments; }
        Comments & get_mutable_comments() { return comments; }
        void set_comments(const Comments & value) { this->comments = value; }

        const Comments & get_commits() const { return commits; }
        Comments & get_mutable_commits() { return commits; }
        void set_commits(const Comments & value) { this->commits = value; }

        const Comments & get_html() const { return html; }
        Comments & get_mutable_html() { return html; }
        void set_html(const Comments & value) { this->html = value; }

        const Comments & get_issue() const { return issue; }
        Comments & get_mutable_issue() { return issue; }
        void set_issue(const Comments & value) { this->issue = value; }

        const Comments & get_review_comment() const { return review_comment; }
        Comments & get_mutable_review_comment() { return review_comment; }
        void set_review_comment(const Comments & value) { this->review_comment = value; }

        const Comments & get_review_comments() const { return review_comments; }
        Comments & get_mutable_review_comments() { return review_comments; }
        void set_review_comments(const Comments & value) { this->review_comments = value; }

        const Comments & get_self() const { return self; }
        Comments & get_mutable_self() { return self; }
        void set_self(const Comments & value) { this->self = value; }

        const Comments & get_statuses() const { return statuses; }
        Comments & get_mutable_statuses() { return statuses; }
        void set_statuses(const Comments & value) { this->statuses = value; }
    };

    class PullRequest {
        public:
        PullRequest() = default;
        virtual ~PullRequest() = default;

        private:
        int64_t additions;
        nlohmann::json assignee;
        std::vector<nlohmann::json> assignees;
        Base base;
        std::string body;
        int64_t changed_files;
        std::string closed_at;
        int64_t comments;
        std::string comments_url;
        int64_t commits;
        std::string commits_url;
        std::string created_at;
        int64_t deletions;
        std::string diff_url;
        Base head;
        std::string html_url;
        int64_t id;
        std::string issue_url;
        Links links;
        bool locked;
        bool maintainer_can_modify;
        std::string merge_commit_sha;
        nlohmann::json mergeable;
        std::string mergeable_state;
        bool merged;
        std::string merged_at;
        MergedBy merged_by;
        nlohmann::json milestone;
        int64_t number;
        std::string patch_url;
        nlohmann::json rebaseable;
        std::vector<nlohmann::json> requested_reviewers;
        std::string review_comment_url;
        int64_t review_comments;
        std::string review_comments_url;
        std::string state;
        std::string statuses_url;
        std::string title;
        std::string updated_at;
        std::string url;
        MergedBy user;

        public:
        const int64_t & get_additions() const { return additions; }
        int64_t & get_mutable_additions() { return additions; }
        void set_additions(const int64_t & value) { this->additions = value; }

        const nlohmann::json & get_assignee() const { return assignee; }
        nlohmann::json & get_mutable_assignee() { return assignee; }
        void set_assignee(const nlohmann::json & value) { this->assignee = value; }

        const std::vector<nlohmann::json> & get_assignees() const { return assignees; }
        std::vector<nlohmann::json> & get_mutable_assignees() { return assignees; }
        void set_assignees(const std::vector<nlohmann::json> & value) { this->assignees = value; }

        const Base & get_base() const { return base; }
        Base & get_mutable_base() { return base; }
        void set_base(const Base & value) { this->base = value; }

        const std::string & get_body() const { return body; }
        std::string & get_mutable_body() { return body; }
        void set_body(const std::string & value) { this->body = value; }

        const int64_t & get_changed_files() const { return changed_files; }
        int64_t & get_mutable_changed_files() { return changed_files; }
        void set_changed_files(const int64_t & value) { this->changed_files = value; }

        const std::string & get_closed_at() const { return closed_at; }
        std::string & get_mutable_closed_at() { return closed_at; }
        void set_closed_at(const std::string & value) { this->closed_at = value; }

        const int64_t & get_comments() const { return comments; }
        int64_t & get_mutable_comments() { return comments; }
        void set_comments(const int64_t & value) { this->comments = value; }

        const std::string & get_comments_url() const { return comments_url; }
        std::string & get_mutable_comments_url() { return comments_url; }
        void set_comments_url(const std::string & value) { this->comments_url = value; }

        const int64_t & get_commits() const { return commits; }
        int64_t & get_mutable_commits() { return commits; }
        void set_commits(const int64_t & value) { this->commits = value; }

        const std::string & get_commits_url() const { return commits_url; }
        std::string & get_mutable_commits_url() { return commits_url; }
        void set_commits_url(const std::string & value) { this->commits_url = value; }

        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        const int64_t & get_deletions() const { return deletions; }
        int64_t & get_mutable_deletions() { return deletions; }
        void set_deletions(const int64_t & value) { this->deletions = value; }

        const std::string & get_diff_url() const { return diff_url; }
        std::string & get_mutable_diff_url() { return diff_url; }
        void set_diff_url(const std::string & value) { this->diff_url = value; }

        const Base & get_head() const { return head; }
        Base & get_mutable_head() { return head; }
        void set_head(const Base & value) { this->head = value; }

        const std::string & get_html_url() const { return html_url; }
        std::string & get_mutable_html_url() { return html_url; }
        void set_html_url(const std::string & value) { this->html_url = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_issue_url() const { return issue_url; }
        std::string & get_mutable_issue_url() { return issue_url; }
        void set_issue_url(const std::string & value) { this->issue_url = value; }

        const Links & get_links() const { return links; }
        Links & get_mutable_links() { return links; }
        void set_links(const Links & value) { this->links = value; }

        const bool & get_locked() const { return locked; }
        bool & get_mutable_locked() { return locked; }
        void set_locked(const bool & value) { this->locked = value; }

        const bool & get_maintainer_can_modify() const { return maintainer_can_modify; }
        bool & get_mutable_maintainer_can_modify() { return maintainer_can_modify; }
        void set_maintainer_can_modify(const bool & value) { this->maintainer_can_modify = value; }

        const std::string & get_merge_commit_sha() const { return merge_commit_sha; }
        std::string & get_mutable_merge_commit_sha() { return merge_commit_sha; }
        void set_merge_commit_sha(const std::string & value) { this->merge_commit_sha = value; }

        const nlohmann::json & get_mergeable() const { return mergeable; }
        nlohmann::json & get_mutable_mergeable() { return mergeable; }
        void set_mergeable(const nlohmann::json & value) { this->mergeable = value; }

        const std::string & get_mergeable_state() const { return mergeable_state; }
        std::string & get_mutable_mergeable_state() { return mergeable_state; }
        void set_mergeable_state(const std::string & value) { this->mergeable_state = value; }

        const bool & get_merged() const { return merged; }
        bool & get_mutable_merged() { return merged; }
        void set_merged(const bool & value) { this->merged = value; }

        const std::string & get_merged_at() const { return merged_at; }
        std::string & get_mutable_merged_at() { return merged_at; }
        void set_merged_at(const std::string & value) { this->merged_at = value; }

        const MergedBy & get_merged_by() const { return merged_by; }
        MergedBy & get_mutable_merged_by() { return merged_by; }
        void set_merged_by(const MergedBy & value) { this->merged_by = value; }

        const nlohmann::json & get_milestone() const { return milestone; }
        nlohmann::json & get_mutable_milestone() { return milestone; }
        void set_milestone(const nlohmann::json & value) { this->milestone = value; }

        const int64_t & get_number() const { return number; }
        int64_t & get_mutable_number() { return number; }
        void set_number(const int64_t & value) { this->number = value; }

        const std::string & get_patch_url() const { return patch_url; }
        std::string & get_mutable_patch_url() { return patch_url; }
        void set_patch_url(const std::string & value) { this->patch_url = value; }

        const nlohmann::json & get_rebaseable() const { return rebaseable; }
        nlohmann::json & get_mutable_rebaseable() { return rebaseable; }
        void set_rebaseable(const nlohmann::json & value) { this->rebaseable = value; }

        const std::vector<nlohmann::json> & get_requested_reviewers() const { return requested_reviewers; }
        std::vector<nlohmann::json> & get_mutable_requested_reviewers() { return requested_reviewers; }
        void set_requested_reviewers(const std::vector<nlohmann::json> & value) { this->requested_reviewers = value; }

        const std::string & get_review_comment_url() const { return review_comment_url; }
        std::string & get_mutable_review_comment_url() { return review_comment_url; }
        void set_review_comment_url(const std::string & value) { this->review_comment_url = value; }

        const int64_t & get_review_comments() const { return review_comments; }
        int64_t & get_mutable_review_comments() { return review_comments; }
        void set_review_comments(const int64_t & value) { this->review_comments = value; }

        const std::string & get_review_comments_url() const { return review_comments_url; }
        std::string & get_mutable_review_comments_url() { return review_comments_url; }
        void set_review_comments_url(const std::string & value) { this->review_comments_url = value; }

        const std::string & get_state() const { return state; }
        std::string & get_mutable_state() { return state; }
        void set_state(const std::string & value) { this->state = value; }

        const std::string & get_statuses_url() const { return statuses_url; }
        std::string & get_mutable_statuses_url() { return statuses_url; }
        void set_statuses_url(const std::string & value) { this->statuses_url = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const MergedBy & get_user() const { return user; }
        MergedBy & get_mutable_user() { return user; }
        void set_user(const MergedBy & value) { this->user = value; }
    };

    class Payload {
        public:
        Payload() = default;
        virtual ~Payload() = default;

        private:
        std::optional<std::string> action;
        std::optional<std::string> before;
        std::optional<std::vector<Commit>> commits;
        std::optional<std::string> description;
        std::optional<int64_t> distinct_size;
        std::optional<std::string> head;
        std::optional<std::string> master_branch;
        std::optional<int64_t> number;
        std::optional<PullRequest> pull_request;
        std::optional<int64_t> push_id;
        std::optional<std::string> pusher_type;
        std::optional<std::string> ref;
        std::optional<std::string> ref_type;
        std::optional<int64_t> size;

        public:
        const std::optional<std::string> & get_action() const { return action; }
        std::optional<std::string> & get_mutable_action() { return action; }
        void set_action(const std::optional<std::string> & value) { this->action = value; }

        const std::optional<std::string> & get_before() const { return before; }
        std::optional<std::string> & get_mutable_before() { return before; }
        void set_before(const std::optional<std::string> & value) { this->before = value; }

        const std::optional<std::vector<Commit>> & get_commits() const { return commits; }
        std::optional<std::vector<Commit>> & get_mutable_commits() { return commits; }
        void set_commits(const std::optional<std::vector<Commit>> & value) { this->commits = value; }

        std::optional<std::string> get_description() const { return description; }
        void set_description(std::optional<std::string> value) { this->description = value; }

        const std::optional<int64_t> & get_distinct_size() const { return distinct_size; }
        std::optional<int64_t> & get_mutable_distinct_size() { return distinct_size; }
        void set_distinct_size(const std::optional<int64_t> & value) { this->distinct_size = value; }

        const std::optional<std::string> & get_head() const { return head; }
        std::optional<std::string> & get_mutable_head() { return head; }
        void set_head(const std::optional<std::string> & value) { this->head = value; }

        const std::optional<std::string> & get_master_branch() const { return master_branch; }
        std::optional<std::string> & get_mutable_master_branch() { return master_branch; }
        void set_master_branch(const std::optional<std::string> & value) { this->master_branch = value; }

        const std::optional<int64_t> & get_number() const { return number; }
        std::optional<int64_t> & get_mutable_number() { return number; }
        void set_number(const std::optional<int64_t> & value) { this->number = value; }

        const std::optional<PullRequest> & get_pull_request() const { return pull_request; }
        std::optional<PullRequest> & get_mutable_pull_request() { return pull_request; }
        void set_pull_request(const std::optional<PullRequest> & value) { this->pull_request = value; }

        const std::optional<int64_t> & get_push_id() const { return push_id; }
        std::optional<int64_t> & get_mutable_push_id() { return push_id; }
        void set_push_id(const std::optional<int64_t> & value) { this->push_id = value; }

        const std::optional<std::string> & get_pusher_type() const { return pusher_type; }
        std::optional<std::string> & get_mutable_pusher_type() { return pusher_type; }
        void set_pusher_type(const std::optional<std::string> & value) { this->pusher_type = value; }

        const std::optional<std::string> & get_ref() const { return ref; }
        std::optional<std::string> & get_mutable_ref() { return ref; }
        void set_ref(const std::optional<std::string> & value) { this->ref = value; }

        const std::optional<std::string> & get_ref_type() const { return ref_type; }
        std::optional<std::string> & get_mutable_ref_type() { return ref_type; }
        void set_ref_type(const std::optional<std::string> & value) { this->ref_type = value; }

        const std::optional<int64_t> & get_size() const { return size; }
        std::optional<int64_t> & get_mutable_size() { return size; }
        void set_size(const std::optional<int64_t> & value) { this->size = value; }
    };

    class TopLevelRepo {
        public:
        TopLevelRepo() = default;
        virtual ~TopLevelRepo() = default;

        private:
        int64_t id;
        std::string name;
        std::string url;

        public:
        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    enum class Type : int { PUSH_EVENT, CREATE_EVENT, WATCH_EVENT, PULL_REQUEST_EVENT, DELETE_EVENT };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        Actor actor;
        std::string created_at;
        std::string id;
        std::optional<Actor> org;
        Payload payload;
        TopLevelRepo repo;
        bool top_level_public;
        Type type;

        public:
        const Actor & get_actor() const { return actor; }
        Actor & get_mutable_actor() { return actor; }
        void set_actor(const Actor & value) { this->actor = value; }

        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::optional<Actor> & get_org() const { return org; }
        std::optional<Actor> & get_mutable_org() { return org; }
        void set_org(const std::optional<Actor> & value) { this->org = value; }

        const Payload & get_payload() const { return payload; }
        Payload & get_mutable_payload() { return payload; }
        void set_payload(const Payload & value) { this->payload = value; }

        const TopLevelRepo & get_repo() const { return repo; }
        TopLevelRepo & get_mutable_repo() { return repo; }
        void set_repo(const TopLevelRepo & value) { this->repo = value; }

        const bool & get_top_level_public() const { return top_level_public; }
        bool & get_mutable_top_level_public() { return top_level_public; }
        void set_top_level_public(const bool & value) { this->top_level_public = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, Actor & x);
    void to_json(json & j, const Actor & x);

    void from_json(const json & j, Author & x);
    void to_json(json & j, const Author & x);

    void from_json(const json & j, Commit & x);
    void to_json(json & j, const Commit & x);

    void from_json(const json & j, MergedBy & x);
    void to_json(json & j, const MergedBy & x);

    void from_json(const json & j, BaseRepo & x);
    void to_json(json & j, const BaseRepo & x);

    void from_json(const json & j, Base & x);
    void to_json(json & j, const Base & x);

    void from_json(const json & j, Comments & x);
    void to_json(json & j, const Comments & x);

    void from_json(const json & j, Links & x);
    void to_json(json & j, const Links & x);

    void from_json(const json & j, PullRequest & x);
    void to_json(json & j, const PullRequest & x);

    void from_json(const json & j, Payload & x);
    void to_json(json & j, const Payload & x);

    void from_json(const json & j, TopLevelRepo & x);
    void to_json(json & j, const TopLevelRepo & x);

    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    inline void from_json(const json & j, Actor& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_avatar_url(j.at("avatar_url").get<std::string>());
        if (j.find("display_login") != j.end() && j.at("display_login").is_null()) throw std::runtime_error("Unexpected null");
        x.set_display_login(get_stack_optional<std::string>(j, "display_login"));
        x.set_gravatar_id(j.at("gravatar_id").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_login(j.at("login").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Actor & x) {
        j = json::object();
        j["avatar_url"] = x.get_avatar_url();
        j["display_login"] = x.get_display_login();
        j["gravatar_id"] = x.get_gravatar_id();
        j["id"] = x.get_id();
        j["login"] = x.get_login();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Author& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_email(j.at("email").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const Author & x) {
        j = json::object();
        j["email"] = x.get_email();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, Commit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_author(j.at("author").get<Author>());
        x.set_distinct(j.at("distinct").get<bool>());
        x.set_message(j.at("message").get<std::string>());
        x.set_sha(j.at("sha").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Commit & x) {
        j = json::object();
        j["author"] = x.get_author();
        j["distinct"] = x.get_distinct();
        j["message"] = x.get_message();
        j["sha"] = x.get_sha();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, MergedBy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_avatar_url(j.at("avatar_url").get<std::string>());
        x.set_events_url(j.at("events_url").get<std::string>());
        x.set_followers_url(j.at("followers_url").get<std::string>());
        x.set_following_url(j.at("following_url").get<std::string>());
        x.set_gists_url(j.at("gists_url").get<std::string>());
        x.set_gravatar_id(j.at("gravatar_id").get<std::string>());
        x.set_html_url(j.at("html_url").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_login(j.at("login").get<std::string>());
        x.set_organizations_url(j.at("organizations_url").get<std::string>());
        x.set_received_events_url(j.at("received_events_url").get<std::string>());
        x.set_repos_url(j.at("repos_url").get<std::string>());
        x.set_site_admin(j.at("site_admin").get<bool>());
        x.set_starred_url(j.at("starred_url").get<std::string>());
        x.set_subscriptions_url(j.at("subscriptions_url").get<std::string>());
        x.set_type(j.at("type").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const MergedBy & x) {
        j = json::object();
        j["avatar_url"] = x.get_avatar_url();
        j["events_url"] = x.get_events_url();
        j["followers_url"] = x.get_followers_url();
        j["following_url"] = x.get_following_url();
        j["gists_url"] = x.get_gists_url();
        j["gravatar_id"] = x.get_gravatar_id();
        j["html_url"] = x.get_html_url();
        j["id"] = x.get_id();
        j["login"] = x.get_login();
        j["organizations_url"] = x.get_organizations_url();
        j["received_events_url"] = x.get_received_events_url();
        j["repos_url"] = x.get_repos_url();
        j["site_admin"] = x.get_site_admin();
        j["starred_url"] = x.get_starred_url();
        j["subscriptions_url"] = x.get_subscriptions_url();
        j["type"] = x.get_type();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, BaseRepo& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_archive_url(j.at("archive_url").get<std::string>());
        x.set_assignees_url(j.at("assignees_url").get<std::string>());
        x.set_blobs_url(j.at("blobs_url").get<std::string>());
        x.set_branches_url(j.at("branches_url").get<std::string>());
        x.set_clone_url(j.at("clone_url").get<std::string>());
        x.set_collaborators_url(j.at("collaborators_url").get<std::string>());
        x.set_comments_url(j.at("comments_url").get<std::string>());
        x.set_commits_url(j.at("commits_url").get<std::string>());
        x.set_compare_url(j.at("compare_url").get<std::string>());
        x.set_contents_url(j.at("contents_url").get<std::string>());
        x.set_contributors_url(j.at("contributors_url").get<std::string>());
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        x.set_default_branch(j.at("default_branch").get<std::string>());
        x.set_deployments_url(j.at("deployments_url").get<std::string>());
        x.set_description(get_untyped(j, "description"));
        x.set_downloads_url(j.at("downloads_url").get<std::string>());
        x.set_events_url(j.at("events_url").get<std::string>());
        x.set_fork(j.at("fork").get<bool>());
        if (j.find("forks") != j.end() && !j.at("forks").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_forks(j.at("forks").get<int64_t>());
        if (j.find("forks_count") != j.end() && !j.at("forks_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_forks_count(j.at("forks_count").get<int64_t>());
        x.set_forks_url(j.at("forks_url").get<std::string>());
        x.set_full_name(j.at("full_name").get<std::string>());
        x.set_git_commits_url(j.at("git_commits_url").get<std::string>());
        x.set_git_refs_url(j.at("git_refs_url").get<std::string>());
        x.set_git_tags_url(j.at("git_tags_url").get<std::string>());
        x.set_git_url(j.at("git_url").get<std::string>());
        x.set_has_downloads(j.at("has_downloads").get<bool>());
        x.set_has_issues(j.at("has_issues").get<bool>());
        x.set_has_pages(j.at("has_pages").get<bool>());
        x.set_has_projects(j.at("has_projects").get<bool>());
        x.set_has_wiki(j.at("has_wiki").get<bool>());
        x.set_homepage(get_untyped(j, "homepage"));
        x.set_hooks_url(j.at("hooks_url").get<std::string>());
        x.set_html_url(j.at("html_url").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_issue_comment_url(j.at("issue_comment_url").get<std::string>());
        x.set_issue_events_url(j.at("issue_events_url").get<std::string>());
        x.set_issues_url(j.at("issues_url").get<std::string>());
        x.set_keys_url(j.at("keys_url").get<std::string>());
        x.set_labels_url(j.at("labels_url").get<std::string>());
        x.set_language(j.at("language").get<std::string>());
        x.set_languages_url(j.at("languages_url").get<std::string>());
        x.set_merges_url(j.at("merges_url").get<std::string>());
        x.set_milestones_url(j.at("milestones_url").get<std::string>());
        x.set_mirror_url(get_untyped(j, "mirror_url"));
        x.set_name(j.at("name").get<std::string>());
        x.set_notifications_url(j.at("notifications_url").get<std::string>());
        if (j.find("open_issues") != j.end() && !j.at("open_issues").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_open_issues(j.at("open_issues").get<int64_t>());
        if (j.find("open_issues_count") != j.end() && !j.at("open_issues_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_open_issues_count(j.at("open_issues_count").get<int64_t>());
        x.set_owner(j.at("owner").get<MergedBy>());
        x.set_pulls_url(j.at("pulls_url").get<std::string>());
        if (j.find("pushed_at") != j.end() && !std::regex_match(j.at("pushed_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_pushed_at(j.at("pushed_at").get<std::string>());
        x.set_releases_url(j.at("releases_url").get<std::string>());
        x.set_repo_private(j.at("private").get<bool>());
        if (j.find("size") != j.end() && !j.at("size").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_size(j.at("size").get<int64_t>());
        x.set_ssh_url(j.at("ssh_url").get<std::string>());
        if (j.find("stargazers_count") != j.end() && !j.at("stargazers_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_stargazers_count(j.at("stargazers_count").get<int64_t>());
        x.set_stargazers_url(j.at("stargazers_url").get<std::string>());
        x.set_statuses_url(j.at("statuses_url").get<std::string>());
        x.set_subscribers_url(j.at("subscribers_url").get<std::string>());
        x.set_subscription_url(j.at("subscription_url").get<std::string>());
        x.set_svn_url(j.at("svn_url").get<std::string>());
        x.set_tags_url(j.at("tags_url").get<std::string>());
        x.set_teams_url(j.at("teams_url").get<std::string>());
        x.set_trees_url(j.at("trees_url").get<std::string>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
        if (j.find("watchers") != j.end() && !j.at("watchers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_watchers(j.at("watchers").get<int64_t>());
        if (j.find("watchers_count") != j.end() && !j.at("watchers_count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_watchers_count(j.at("watchers_count").get<int64_t>());
    }

    inline void to_json(json & j, const BaseRepo & x) {
        j = json::object();
        j["archive_url"] = x.get_archive_url();
        j["assignees_url"] = x.get_assignees_url();
        j["blobs_url"] = x.get_blobs_url();
        j["branches_url"] = x.get_branches_url();
        j["clone_url"] = x.get_clone_url();
        j["collaborators_url"] = x.get_collaborators_url();
        j["comments_url"] = x.get_comments_url();
        j["commits_url"] = x.get_commits_url();
        j["compare_url"] = x.get_compare_url();
        j["contents_url"] = x.get_contents_url();
        j["contributors_url"] = x.get_contributors_url();
        j["created_at"] = x.get_created_at();
        j["default_branch"] = x.get_default_branch();
        j["deployments_url"] = x.get_deployments_url();
        j["description"] = x.get_description();
        j["downloads_url"] = x.get_downloads_url();
        j["events_url"] = x.get_events_url();
        j["fork"] = x.get_fork();
        j["forks"] = x.get_forks();
        j["forks_count"] = x.get_forks_count();
        j["forks_url"] = x.get_forks_url();
        j["full_name"] = x.get_full_name();
        j["git_commits_url"] = x.get_git_commits_url();
        j["git_refs_url"] = x.get_git_refs_url();
        j["git_tags_url"] = x.get_git_tags_url();
        j["git_url"] = x.get_git_url();
        j["has_downloads"] = x.get_has_downloads();
        j["has_issues"] = x.get_has_issues();
        j["has_pages"] = x.get_has_pages();
        j["has_projects"] = x.get_has_projects();
        j["has_wiki"] = x.get_has_wiki();
        j["homepage"] = x.get_homepage();
        j["hooks_url"] = x.get_hooks_url();
        j["html_url"] = x.get_html_url();
        j["id"] = x.get_id();
        j["issue_comment_url"] = x.get_issue_comment_url();
        j["issue_events_url"] = x.get_issue_events_url();
        j["issues_url"] = x.get_issues_url();
        j["keys_url"] = x.get_keys_url();
        j["labels_url"] = x.get_labels_url();
        j["language"] = x.get_language();
        j["languages_url"] = x.get_languages_url();
        j["merges_url"] = x.get_merges_url();
        j["milestones_url"] = x.get_milestones_url();
        j["mirror_url"] = x.get_mirror_url();
        j["name"] = x.get_name();
        j["notifications_url"] = x.get_notifications_url();
        j["open_issues"] = x.get_open_issues();
        j["open_issues_count"] = x.get_open_issues_count();
        j["owner"] = x.get_owner();
        j["pulls_url"] = x.get_pulls_url();
        j["pushed_at"] = x.get_pushed_at();
        j["releases_url"] = x.get_releases_url();
        j["private"] = x.get_repo_private();
        j["size"] = x.get_size();
        j["ssh_url"] = x.get_ssh_url();
        j["stargazers_count"] = x.get_stargazers_count();
        j["stargazers_url"] = x.get_stargazers_url();
        j["statuses_url"] = x.get_statuses_url();
        j["subscribers_url"] = x.get_subscribers_url();
        j["subscription_url"] = x.get_subscription_url();
        j["svn_url"] = x.get_svn_url();
        j["tags_url"] = x.get_tags_url();
        j["teams_url"] = x.get_teams_url();
        j["trees_url"] = x.get_trees_url();
        j["updated_at"] = x.get_updated_at();
        j["url"] = x.get_url();
        j["watchers"] = x.get_watchers();
        j["watchers_count"] = x.get_watchers_count();
    }

    inline void from_json(const json & j, Base& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_label(j.at("label").get<std::string>());
        x.set_ref(j.at("ref").get<std::string>());
        x.set_repo(j.at("repo").get<BaseRepo>());
        x.set_sha(j.at("sha").get<std::string>());
        x.set_user(j.at("user").get<MergedBy>());
    }

    inline void to_json(json & j, const Base & x) {
        j = json::object();
        j["label"] = x.get_label();
        j["ref"] = x.get_ref();
        j["repo"] = x.get_repo();
        j["sha"] = x.get_sha();
        j["user"] = x.get_user();
    }

    inline void from_json(const json & j, Comments& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_href(j.at("href").get<std::string>());
    }

    inline void to_json(json & j, const Comments & x) {
        j = json::object();
        j["href"] = x.get_href();
    }

    inline void from_json(const json & j, Links& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_comments(j.at("comments").get<Comments>());
        x.set_commits(j.at("commits").get<Comments>());
        x.set_html(j.at("html").get<Comments>());
        x.set_issue(j.at("issue").get<Comments>());
        x.set_review_comment(j.at("review_comment").get<Comments>());
        x.set_review_comments(j.at("review_comments").get<Comments>());
        x.set_self(j.at("self").get<Comments>());
        x.set_statuses(j.at("statuses").get<Comments>());
    }

    inline void to_json(json & j, const Links & x) {
        j = json::object();
        j["comments"] = x.get_comments();
        j["commits"] = x.get_commits();
        j["html"] = x.get_html();
        j["issue"] = x.get_issue();
        j["review_comment"] = x.get_review_comment();
        j["review_comments"] = x.get_review_comments();
        j["self"] = x.get_self();
        j["statuses"] = x.get_statuses();
    }

    inline void from_json(const json & j, PullRequest& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("additions") != j.end() && !j.at("additions").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_additions(j.at("additions").get<int64_t>());
        x.set_assignee(get_untyped(j, "assignee"));
        x.set_assignees(j.at("assignees").get<std::vector<nlohmann::json>>());
        x.set_base(j.at("base").get<Base>());
        x.set_body(j.at("body").get<std::string>());
        if (j.find("changed_files") != j.end() && !j.at("changed_files").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_changed_files(j.at("changed_files").get<int64_t>());
        if (j.find("closed_at") != j.end() && !std::regex_match(j.at("closed_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_closed_at(j.at("closed_at").get<std::string>());
        if (j.find("comments") != j.end() && !j.at("comments").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_comments(j.at("comments").get<int64_t>());
        x.set_comments_url(j.at("comments_url").get<std::string>());
        if (j.find("commits") != j.end() && !j.at("commits").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_commits(j.at("commits").get<int64_t>());
        x.set_commits_url(j.at("commits_url").get<std::string>());
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        if (j.find("deletions") != j.end() && !j.at("deletions").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_deletions(j.at("deletions").get<int64_t>());
        x.set_diff_url(j.at("diff_url").get<std::string>());
        x.set_head(j.at("head").get<Base>());
        x.set_html_url(j.at("html_url").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_issue_url(j.at("issue_url").get<std::string>());
        x.set_links(j.at("_links").get<Links>());
        x.set_locked(j.at("locked").get<bool>());
        x.set_maintainer_can_modify(j.at("maintainer_can_modify").get<bool>());
        x.set_merge_commit_sha(j.at("merge_commit_sha").get<std::string>());
        x.set_mergeable(get_untyped(j, "mergeable"));
        x.set_mergeable_state(j.at("mergeable_state").get<std::string>());
        x.set_merged(j.at("merged").get<bool>());
        if (j.find("merged_at") != j.end() && !std::regex_match(j.at("merged_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_merged_at(j.at("merged_at").get<std::string>());
        x.set_merged_by(j.at("merged_by").get<MergedBy>());
        x.set_milestone(get_untyped(j, "milestone"));
        if (j.find("number") != j.end() && !j.at("number").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_number(j.at("number").get<int64_t>());
        x.set_patch_url(j.at("patch_url").get<std::string>());
        x.set_rebaseable(get_untyped(j, "rebaseable"));
        x.set_requested_reviewers(j.at("requested_reviewers").get<std::vector<nlohmann::json>>());
        x.set_review_comment_url(j.at("review_comment_url").get<std::string>());
        if (j.find("review_comments") != j.end() && !j.at("review_comments").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_review_comments(j.at("review_comments").get<int64_t>());
        x.set_review_comments_url(j.at("review_comments_url").get<std::string>());
        x.set_state(j.at("state").get<std::string>());
        x.set_statuses_url(j.at("statuses_url").get<std::string>());
        x.set_title(j.at("title").get<std::string>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
        x.set_user(j.at("user").get<MergedBy>());
    }

    inline void to_json(json & j, const PullRequest & x) {
        j = json::object();
        j["additions"] = x.get_additions();
        j["assignee"] = x.get_assignee();
        j["assignees"] = x.get_assignees();
        j["base"] = x.get_base();
        j["body"] = x.get_body();
        j["changed_files"] = x.get_changed_files();
        j["closed_at"] = x.get_closed_at();
        j["comments"] = x.get_comments();
        j["comments_url"] = x.get_comments_url();
        j["commits"] = x.get_commits();
        j["commits_url"] = x.get_commits_url();
        j["created_at"] = x.get_created_at();
        j["deletions"] = x.get_deletions();
        j["diff_url"] = x.get_diff_url();
        j["head"] = x.get_head();
        j["html_url"] = x.get_html_url();
        j["id"] = x.get_id();
        j["issue_url"] = x.get_issue_url();
        j["_links"] = x.get_links();
        j["locked"] = x.get_locked();
        j["maintainer_can_modify"] = x.get_maintainer_can_modify();
        j["merge_commit_sha"] = x.get_merge_commit_sha();
        j["mergeable"] = x.get_mergeable();
        j["mergeable_state"] = x.get_mergeable_state();
        j["merged"] = x.get_merged();
        j["merged_at"] = x.get_merged_at();
        j["merged_by"] = x.get_merged_by();
        j["milestone"] = x.get_milestone();
        j["number"] = x.get_number();
        j["patch_url"] = x.get_patch_url();
        j["rebaseable"] = x.get_rebaseable();
        j["requested_reviewers"] = x.get_requested_reviewers();
        j["review_comment_url"] = x.get_review_comment_url();
        j["review_comments"] = x.get_review_comments();
        j["review_comments_url"] = x.get_review_comments_url();
        j["state"] = x.get_state();
        j["statuses_url"] = x.get_statuses_url();
        j["title"] = x.get_title();
        j["updated_at"] = x.get_updated_at();
        j["url"] = x.get_url();
        j["user"] = x.get_user();
    }

    inline void from_json(const json & j, Payload& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("action") != j.end() && j.at("action").is_null()) throw std::runtime_error("Unexpected null");
        x.set_action(get_stack_optional<std::string>(j, "action"));
        if (j.find("before") != j.end() && j.at("before").is_null()) throw std::runtime_error("Unexpected null");
        x.set_before(get_stack_optional<std::string>(j, "before"));
        if (j.find("commits") != j.end() && j.at("commits").is_null()) throw std::runtime_error("Unexpected null");
        x.set_commits(get_stack_optional<std::vector<Commit>>(j, "commits"));
        x.set_description(get_stack_optional<std::string>(j, "description"));
        if (j.find("distinct_size") != j.end() && !j.at("distinct_size").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("distinct_size") != j.end() && j.at("distinct_size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_distinct_size(get_stack_optional<int64_t>(j, "distinct_size"));
        if (j.find("head") != j.end() && j.at("head").is_null()) throw std::runtime_error("Unexpected null");
        x.set_head(get_stack_optional<std::string>(j, "head"));
        if (j.find("master_branch") != j.end() && j.at("master_branch").is_null()) throw std::runtime_error("Unexpected null");
        x.set_master_branch(get_stack_optional<std::string>(j, "master_branch"));
        if (j.find("number") != j.end() && !j.at("number").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("number") != j.end() && j.at("number").is_null()) throw std::runtime_error("Unexpected null");
        x.set_number(get_stack_optional<int64_t>(j, "number"));
        if (j.find("pull_request") != j.end() && j.at("pull_request").is_null()) throw std::runtime_error("Unexpected null");
        x.set_pull_request(get_stack_optional<PullRequest>(j, "pull_request"));
        if (j.find("push_id") != j.end() && !j.at("push_id").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("push_id") != j.end() && j.at("push_id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_push_id(get_stack_optional<int64_t>(j, "push_id"));
        if (j.find("pusher_type") != j.end() && j.at("pusher_type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_pusher_type(get_stack_optional<std::string>(j, "pusher_type"));
        if (j.find("ref") != j.end() && j.at("ref").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ref(get_stack_optional<std::string>(j, "ref"));
        if (j.find("ref_type") != j.end() && j.at("ref_type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ref_type(get_stack_optional<std::string>(j, "ref_type"));
        if (j.find("size") != j.end() && !j.at("size").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<int64_t>(j, "size"));
    }

    inline void to_json(json & j, const Payload & x) {
        j = json::object();
        j["action"] = x.get_action();
        j["before"] = x.get_before();
        j["commits"] = x.get_commits();
        j["description"] = x.get_description();
        j["distinct_size"] = x.get_distinct_size();
        j["head"] = x.get_head();
        j["master_branch"] = x.get_master_branch();
        j["number"] = x.get_number();
        j["pull_request"] = x.get_pull_request();
        j["push_id"] = x.get_push_id();
        j["pusher_type"] = x.get_pusher_type();
        j["ref"] = x.get_ref();
        j["ref_type"] = x.get_ref_type();
        j["size"] = x.get_size();
    }

    inline void from_json(const json & j, TopLevelRepo& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_name(j.at("name").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const TopLevelRepo & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_actor(j.at("actor").get<Actor>());
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        if (j.find("org") != j.end() && j.at("org").is_null()) throw std::runtime_error("Unexpected null");
        x.set_org(get_stack_optional<Actor>(j, "org"));
        x.set_payload(j.at("payload").get<Payload>());
        x.set_repo(j.at("repo").get<TopLevelRepo>());
        x.set_top_level_public(j.at("public").get<bool>());
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["actor"] = x.get_actor();
        j["created_at"] = x.get_created_at();
        j["id"] = x.get_id();
        j["org"] = x.get_org();
        j["payload"] = x.get_payload();
        j["repo"] = x.get_repo();
        j["public"] = x.get_top_level_public();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "PushEvent") x = Type::PUSH_EVENT;
        else if (j == "CreateEvent") x = Type::CREATE_EVENT;
        else if (j == "WatchEvent") x = Type::WATCH_EVENT;
        else if (j == "PullRequestEvent") x = Type::PULL_REQUEST_EVENT;
        else if (j == "DeleteEvent") x = Type::DELETE_EVENT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::PUSH_EVENT: j = "PushEvent"; break;
            case Type::CREATE_EVENT: j = "CreateEvent"; break;
            case Type::WATCH_EVENT: j = "WatchEvent"; break;
            case Type::PULL_REQUEST_EVENT: j = "PullRequestEvent"; break;
            case Type::DELETE_EVENT: j = "DeleteEvent"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
