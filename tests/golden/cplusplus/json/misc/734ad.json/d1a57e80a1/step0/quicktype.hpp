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

    class Facets {
        public:
        Facets() = default;
        virtual ~Facets() = default;

        private:

        public:
    };

    enum class Status : int { ACTIVE, INACTIVE };

    class Result {
        public:
        Result() = default;
        virtual ~Result() = default;

        private:
        std::optional<std::string> acronym;
        std::string activity_consult_committees;
        std::string activity_eu_legislative;
        std::string activity_expert_groups;
        std::string activity_high_level_groups;
        std::string activity_industry_forums;
        std::string activity_inter_groups;
        std::optional<std::string> activity_other;
        std::string activity_relevant_comm;
        std::optional<std::string> be_office_country;
        std::optional<double> be_office_lat;
        std::optional<double> be_office_lon;
        std::optional<std::string> be_office_phone;
        std::optional<std::string> be_office_post_code;
        std::optional<std::string> be_office_postbox;
        std::optional<std::string> be_office_street;
        std::optional<std::string> be_office_town;
        std::string code_of_conduct;
        int64_t contact_country;
        std::string created_at;
        std::string entity;
        std::string goals;
        std::string head;
        std::string head_office_country;
        std::optional<double> head_office_lat;
        std::optional<double> head_office_lon;
        std::string head_office_phone;
        std::optional<std::string> head_office_post_code;
        std::optional<std::string> head_office_postbox;
        std::string head_office_street;
        std::string head_office_town;
        std::string id;
        std::string identification_code;
        std::string info_members;
        std::string last_update_date;
        std::string legal;
        std::string legal_status;
        int64_t main_category;
        std::string main_category_title;
        int64_t members;
        std::optional<int64_t> members_100;
        std::optional<int64_t> members_25;
        std::optional<int64_t> members_50;
        std::optional<int64_t> members_75;
        double members_fte;
        std::string name;
        nlohmann::json native_name;
        std::optional<std::string> networking;
        std::optional<int64_t> number_of_natural_persons;
        std::optional<std::string> other_code_of_conduct;
        std::string registration_date;
        Status status;
        std::string structure_members;
        int64_t sub_category;
        std::string sub_category_title;
        std::string updated_at;
        std::string uri;
        std::optional<std::string> web_site_url;

        public:
        std::optional<std::string> get_acronym() const { return acronym; }
        void set_acronym(std::optional<std::string> value) { this->acronym = value; }

        const std::string & get_activity_consult_committees() const { return activity_consult_committees; }
        std::string & get_mutable_activity_consult_committees() { return activity_consult_committees; }
        void set_activity_consult_committees(const std::string & value) { this->activity_consult_committees = value; }

        const std::string & get_activity_eu_legislative() const { return activity_eu_legislative; }
        std::string & get_mutable_activity_eu_legislative() { return activity_eu_legislative; }
        void set_activity_eu_legislative(const std::string & value) { this->activity_eu_legislative = value; }

        const std::string & get_activity_expert_groups() const { return activity_expert_groups; }
        std::string & get_mutable_activity_expert_groups() { return activity_expert_groups; }
        void set_activity_expert_groups(const std::string & value) { this->activity_expert_groups = value; }

        const std::string & get_activity_high_level_groups() const { return activity_high_level_groups; }
        std::string & get_mutable_activity_high_level_groups() { return activity_high_level_groups; }
        void set_activity_high_level_groups(const std::string & value) { this->activity_high_level_groups = value; }

        const std::string & get_activity_industry_forums() const { return activity_industry_forums; }
        std::string & get_mutable_activity_industry_forums() { return activity_industry_forums; }
        void set_activity_industry_forums(const std::string & value) { this->activity_industry_forums = value; }

        const std::string & get_activity_inter_groups() const { return activity_inter_groups; }
        std::string & get_mutable_activity_inter_groups() { return activity_inter_groups; }
        void set_activity_inter_groups(const std::string & value) { this->activity_inter_groups = value; }

        std::optional<std::string> get_activity_other() const { return activity_other; }
        void set_activity_other(std::optional<std::string> value) { this->activity_other = value; }

        const std::string & get_activity_relevant_comm() const { return activity_relevant_comm; }
        std::string & get_mutable_activity_relevant_comm() { return activity_relevant_comm; }
        void set_activity_relevant_comm(const std::string & value) { this->activity_relevant_comm = value; }

        const std::optional<std::string> & get_be_office_country() const { return be_office_country; }
        std::optional<std::string> & get_mutable_be_office_country() { return be_office_country; }
        void set_be_office_country(const std::optional<std::string> & value) { this->be_office_country = value; }

        std::optional<double> get_be_office_lat() const { return be_office_lat; }
        void set_be_office_lat(std::optional<double> value) { this->be_office_lat = value; }

        std::optional<double> get_be_office_lon() const { return be_office_lon; }
        void set_be_office_lon(std::optional<double> value) { this->be_office_lon = value; }

        const std::optional<std::string> & get_be_office_phone() const { return be_office_phone; }
        std::optional<std::string> & get_mutable_be_office_phone() { return be_office_phone; }
        void set_be_office_phone(const std::optional<std::string> & value) { this->be_office_phone = value; }

        std::optional<std::string> get_be_office_post_code() const { return be_office_post_code; }
        void set_be_office_post_code(std::optional<std::string> value) { this->be_office_post_code = value; }

        std::optional<std::string> get_be_office_postbox() const { return be_office_postbox; }
        void set_be_office_postbox(std::optional<std::string> value) { this->be_office_postbox = value; }

        const std::optional<std::string> & get_be_office_street() const { return be_office_street; }
        std::optional<std::string> & get_mutable_be_office_street() { return be_office_street; }
        void set_be_office_street(const std::optional<std::string> & value) { this->be_office_street = value; }

        const std::optional<std::string> & get_be_office_town() const { return be_office_town; }
        std::optional<std::string> & get_mutable_be_office_town() { return be_office_town; }
        void set_be_office_town(const std::optional<std::string> & value) { this->be_office_town = value; }

        const std::string & get_code_of_conduct() const { return code_of_conduct; }
        std::string & get_mutable_code_of_conduct() { return code_of_conduct; }
        void set_code_of_conduct(const std::string & value) { this->code_of_conduct = value; }

        const int64_t & get_contact_country() const { return contact_country; }
        int64_t & get_mutable_contact_country() { return contact_country; }
        void set_contact_country(const int64_t & value) { this->contact_country = value; }

        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        const std::string & get_entity() const { return entity; }
        std::string & get_mutable_entity() { return entity; }
        void set_entity(const std::string & value) { this->entity = value; }

        const std::string & get_goals() const { return goals; }
        std::string & get_mutable_goals() { return goals; }
        void set_goals(const std::string & value) { this->goals = value; }

        const std::string & get_head() const { return head; }
        std::string & get_mutable_head() { return head; }
        void set_head(const std::string & value) { this->head = value; }

        const std::string & get_head_office_country() const { return head_office_country; }
        std::string & get_mutable_head_office_country() { return head_office_country; }
        void set_head_office_country(const std::string & value) { this->head_office_country = value; }

        std::optional<double> get_head_office_lat() const { return head_office_lat; }
        void set_head_office_lat(std::optional<double> value) { this->head_office_lat = value; }

        std::optional<double> get_head_office_lon() const { return head_office_lon; }
        void set_head_office_lon(std::optional<double> value) { this->head_office_lon = value; }

        const std::string & get_head_office_phone() const { return head_office_phone; }
        std::string & get_mutable_head_office_phone() { return head_office_phone; }
        void set_head_office_phone(const std::string & value) { this->head_office_phone = value; }

        std::optional<std::string> get_head_office_post_code() const { return head_office_post_code; }
        void set_head_office_post_code(std::optional<std::string> value) { this->head_office_post_code = value; }

        std::optional<std::string> get_head_office_postbox() const { return head_office_postbox; }
        void set_head_office_postbox(std::optional<std::string> value) { this->head_office_postbox = value; }

        const std::string & get_head_office_street() const { return head_office_street; }
        std::string & get_mutable_head_office_street() { return head_office_street; }
        void set_head_office_street(const std::string & value) { this->head_office_street = value; }

        const std::string & get_head_office_town() const { return head_office_town; }
        std::string & get_mutable_head_office_town() { return head_office_town; }
        void set_head_office_town(const std::string & value) { this->head_office_town = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::string & get_identification_code() const { return identification_code; }
        std::string & get_mutable_identification_code() { return identification_code; }
        void set_identification_code(const std::string & value) { this->identification_code = value; }

        const std::string & get_info_members() const { return info_members; }
        std::string & get_mutable_info_members() { return info_members; }
        void set_info_members(const std::string & value) { this->info_members = value; }

        const std::string & get_last_update_date() const { return last_update_date; }
        std::string & get_mutable_last_update_date() { return last_update_date; }
        void set_last_update_date(const std::string & value) { this->last_update_date = value; }

        const std::string & get_legal() const { return legal; }
        std::string & get_mutable_legal() { return legal; }
        void set_legal(const std::string & value) { this->legal = value; }

        const std::string & get_legal_status() const { return legal_status; }
        std::string & get_mutable_legal_status() { return legal_status; }
        void set_legal_status(const std::string & value) { this->legal_status = value; }

        const int64_t & get_main_category() const { return main_category; }
        int64_t & get_mutable_main_category() { return main_category; }
        void set_main_category(const int64_t & value) { this->main_category = value; }

        const std::string & get_main_category_title() const { return main_category_title; }
        std::string & get_mutable_main_category_title() { return main_category_title; }
        void set_main_category_title(const std::string & value) { this->main_category_title = value; }

        const int64_t & get_members() const { return members; }
        int64_t & get_mutable_members() { return members; }
        void set_members(const int64_t & value) { this->members = value; }

        std::optional<int64_t> get_members_100() const { return members_100; }
        void set_members_100(std::optional<int64_t> value) { this->members_100 = value; }

        std::optional<int64_t> get_members_25() const { return members_25; }
        void set_members_25(std::optional<int64_t> value) { this->members_25 = value; }

        std::optional<int64_t> get_members_50() const { return members_50; }
        void set_members_50(std::optional<int64_t> value) { this->members_50 = value; }

        std::optional<int64_t> get_members_75() const { return members_75; }
        void set_members_75(std::optional<int64_t> value) { this->members_75 = value; }

        const double & get_members_fte() const { return members_fte; }
        double & get_mutable_members_fte() { return members_fte; }
        void set_members_fte(const double & value) { this->members_fte = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const nlohmann::json & get_native_name() const { return native_name; }
        nlohmann::json & get_mutable_native_name() { return native_name; }
        void set_native_name(const nlohmann::json & value) { this->native_name = value; }

        std::optional<std::string> get_networking() const { return networking; }
        void set_networking(std::optional<std::string> value) { this->networking = value; }

        std::optional<int64_t> get_number_of_natural_persons() const { return number_of_natural_persons; }
        void set_number_of_natural_persons(std::optional<int64_t> value) { this->number_of_natural_persons = value; }

        std::optional<std::string> get_other_code_of_conduct() const { return other_code_of_conduct; }
        void set_other_code_of_conduct(std::optional<std::string> value) { this->other_code_of_conduct = value; }

        const std::string & get_registration_date() const { return registration_date; }
        std::string & get_mutable_registration_date() { return registration_date; }
        void set_registration_date(const std::string & value) { this->registration_date = value; }

        const Status & get_status() const { return status; }
        Status & get_mutable_status() { return status; }
        void set_status(const Status & value) { this->status = value; }

        const std::string & get_structure_members() const { return structure_members; }
        std::string & get_mutable_structure_members() { return structure_members; }
        void set_structure_members(const std::string & value) { this->structure_members = value; }

        const int64_t & get_sub_category() const { return sub_category; }
        int64_t & get_mutable_sub_category() { return sub_category; }
        void set_sub_category(const int64_t & value) { this->sub_category = value; }

        const std::string & get_sub_category_title() const { return sub_category_title; }
        std::string & get_mutable_sub_category_title() { return sub_category_title; }
        void set_sub_category_title(const std::string & value) { this->sub_category_title = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }

        const std::string & get_uri() const { return uri; }
        std::string & get_mutable_uri() { return uri; }
        void set_uri(const std::string & value) { this->uri = value; }

        std::optional<std::string> get_web_site_url() const { return web_site_url; }
        void set_web_site_url(std::optional<std::string> value) { this->web_site_url = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        int64_t count;
        Facets facets;
        int64_t limit;
        std::string next;
        int64_t offset;
        bool previous;
        std::vector<Result> results;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const Facets & get_facets() const { return facets; }
        Facets & get_mutable_facets() { return facets; }
        void set_facets(const Facets & value) { this->facets = value; }

        const int64_t & get_limit() const { return limit; }
        int64_t & get_mutable_limit() { return limit; }
        void set_limit(const int64_t & value) { this->limit = value; }

        const std::string & get_next() const { return next; }
        std::string & get_mutable_next() { return next; }
        void set_next(const std::string & value) { this->next = value; }

        const int64_t & get_offset() const { return offset; }
        int64_t & get_mutable_offset() { return offset; }
        void set_offset(const int64_t & value) { this->offset = value; }

        const bool & get_previous() const { return previous; }
        bool & get_mutable_previous() { return previous; }
        void set_previous(const bool & value) { this->previous = value; }

        const std::vector<Result> & get_results() const { return results; }
        std::vector<Result> & get_mutable_results() { return results; }
        void set_results(const std::vector<Result> & value) { this->results = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Facets & x);
    void to_json(json & j, const Facets & x);

    void from_json(const json & j, Result & x);
    void to_json(json & j, const Result & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Status & x);
    void to_json(json & j, const Status & x);

    inline void from_json(const json & j, Facets& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Facets & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Result& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("acronym");
        x.set_acronym(get_stack_optional<std::string>(j, "acronym"));
        x.set_activity_consult_committees(j.at("activity_consult_committees").get<std::string>());
        x.set_activity_eu_legislative(j.at("activity_eu_legislative").get<std::string>());
        x.set_activity_expert_groups(j.at("activity_expert_groups").get<std::string>());
        x.set_activity_high_level_groups(j.at("activity_high_level_groups").get<std::string>());
        x.set_activity_industry_forums(j.at("activity_industry_forums").get<std::string>());
        x.set_activity_inter_groups(j.at("activity_inter_groups").get<std::string>());
        j.at("activity_other");
        x.set_activity_other(get_stack_optional<std::string>(j, "activity_other"));
        x.set_activity_relevant_comm(j.at("activity_relevant_comm").get<std::string>());
        if (j.find("be_office_country") != j.end() && j.at("be_office_country").is_null()) throw std::runtime_error("Unexpected null");
        x.set_be_office_country(get_stack_optional<std::string>(j, "be_office_country"));
        x.set_be_office_lat(get_stack_optional<double>(j, "be_office_lat"));
        x.set_be_office_lon(get_stack_optional<double>(j, "be_office_lon"));
        if (j.find("be_office_phone") != j.end() && j.at("be_office_phone").is_null()) throw std::runtime_error("Unexpected null");
        x.set_be_office_phone(get_stack_optional<std::string>(j, "be_office_phone"));
        x.set_be_office_post_code(get_stack_optional<std::string>(j, "be_office_post_code"));
        x.set_be_office_postbox(get_stack_optional<std::string>(j, "be_office_postbox"));
        if (j.find("be_office_street") != j.end() && j.at("be_office_street").is_null()) throw std::runtime_error("Unexpected null");
        x.set_be_office_street(get_stack_optional<std::string>(j, "be_office_street"));
        if (j.find("be_office_town") != j.end() && j.at("be_office_town").is_null()) throw std::runtime_error("Unexpected null");
        x.set_be_office_town(get_stack_optional<std::string>(j, "be_office_town"));
        x.set_code_of_conduct(j.at("code_of_conduct").get<std::string>());
        if (j.find("contact_country") != j.end() && !j.at("contact_country").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_contact_country(j.at("contact_country").get<int64_t>());
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        x.set_entity(j.at("entity").get<std::string>());
        x.set_goals(j.at("goals").get<std::string>());
        x.set_head(j.at("head").get<std::string>());
        x.set_head_office_country(j.at("head_office_country").get<std::string>());
        j.at("head_office_lat");
        x.set_head_office_lat(get_stack_optional<double>(j, "head_office_lat"));
        j.at("head_office_lon");
        x.set_head_office_lon(get_stack_optional<double>(j, "head_office_lon"));
        x.set_head_office_phone(j.at("head_office_phone").get<std::string>());
        j.at("head_office_post_code");
        x.set_head_office_post_code(get_stack_optional<std::string>(j, "head_office_post_code"));
        j.at("head_office_postbox");
        x.set_head_office_postbox(get_stack_optional<std::string>(j, "head_office_postbox"));
        x.set_head_office_street(j.at("head_office_street").get<std::string>());
        x.set_head_office_town(j.at("head_office_town").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_identification_code(j.at("identification_code").get<std::string>());
        x.set_info_members(j.at("info_members").get<std::string>());
        if (j.find("last_update_date") != j.end() && !std::regex_match(j.at("last_update_date").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_last_update_date(j.at("last_update_date").get<std::string>());
        x.set_legal(j.at("legal").get<std::string>());
        x.set_legal_status(j.at("legal_status").get<std::string>());
        if (j.find("main_category") != j.end() && !j.at("main_category").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_main_category(j.at("main_category").get<int64_t>());
        x.set_main_category_title(j.at("main_category_title").get<std::string>());
        if (j.find("members") != j.end() && !j.at("members").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_members(j.at("members").get<int64_t>());
        j.at("members_100");
        x.set_members_100(get_stack_optional<int64_t>(j, "members_100"));
        j.at("members_25");
        x.set_members_25(get_stack_optional<int64_t>(j, "members_25"));
        j.at("members_50");
        x.set_members_50(get_stack_optional<int64_t>(j, "members_50"));
        j.at("members_75");
        x.set_members_75(get_stack_optional<int64_t>(j, "members_75"));
        x.set_members_fte(j.at("members_fte").get<double>());
        x.set_name(j.at("name").get<std::string>());
        x.set_native_name(get_untyped(j, "native_name"));
        j.at("networking");
        x.set_networking(get_stack_optional<std::string>(j, "networking"));
        j.at("number_of_natural_persons");
        x.set_number_of_natural_persons(get_stack_optional<int64_t>(j, "number_of_natural_persons"));
        j.at("other_code_of_conduct");
        x.set_other_code_of_conduct(get_stack_optional<std::string>(j, "other_code_of_conduct"));
        if (j.find("registration_date") != j.end() && !std::regex_match(j.at("registration_date").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_registration_date(j.at("registration_date").get<std::string>());
        x.set_status(j.at("status").get<Status>());
        x.set_structure_members(j.at("structure_members").get<std::string>());
        if (j.find("sub_category") != j.end() && !j.at("sub_category").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sub_category(j.at("sub_category").get<int64_t>());
        x.set_sub_category_title(j.at("sub_category_title").get<std::string>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
        x.set_uri(j.at("uri").get<std::string>());
        j.at("web_site_url");
        x.set_web_site_url(get_stack_optional<std::string>(j, "web_site_url"));
    }

    inline void to_json(json & j, const Result & x) {
        j = json::object();
        j["acronym"] = x.get_acronym();
        j["activity_consult_committees"] = x.get_activity_consult_committees();
        j["activity_eu_legislative"] = x.get_activity_eu_legislative();
        j["activity_expert_groups"] = x.get_activity_expert_groups();
        j["activity_high_level_groups"] = x.get_activity_high_level_groups();
        j["activity_industry_forums"] = x.get_activity_industry_forums();
        j["activity_inter_groups"] = x.get_activity_inter_groups();
        j["activity_other"] = x.get_activity_other();
        j["activity_relevant_comm"] = x.get_activity_relevant_comm();
        j["be_office_country"] = x.get_be_office_country();
        j["be_office_lat"] = x.get_be_office_lat();
        j["be_office_lon"] = x.get_be_office_lon();
        j["be_office_phone"] = x.get_be_office_phone();
        j["be_office_post_code"] = x.get_be_office_post_code();
        j["be_office_postbox"] = x.get_be_office_postbox();
        j["be_office_street"] = x.get_be_office_street();
        j["be_office_town"] = x.get_be_office_town();
        j["code_of_conduct"] = x.get_code_of_conduct();
        j["contact_country"] = x.get_contact_country();
        j["created_at"] = x.get_created_at();
        j["entity"] = x.get_entity();
        j["goals"] = x.get_goals();
        j["head"] = x.get_head();
        j["head_office_country"] = x.get_head_office_country();
        j["head_office_lat"] = x.get_head_office_lat();
        j["head_office_lon"] = x.get_head_office_lon();
        j["head_office_phone"] = x.get_head_office_phone();
        j["head_office_post_code"] = x.get_head_office_post_code();
        j["head_office_postbox"] = x.get_head_office_postbox();
        j["head_office_street"] = x.get_head_office_street();
        j["head_office_town"] = x.get_head_office_town();
        j["id"] = x.get_id();
        j["identification_code"] = x.get_identification_code();
        j["info_members"] = x.get_info_members();
        j["last_update_date"] = x.get_last_update_date();
        j["legal"] = x.get_legal();
        j["legal_status"] = x.get_legal_status();
        j["main_category"] = x.get_main_category();
        j["main_category_title"] = x.get_main_category_title();
        j["members"] = x.get_members();
        j["members_100"] = x.get_members_100();
        j["members_25"] = x.get_members_25();
        j["members_50"] = x.get_members_50();
        j["members_75"] = x.get_members_75();
        j["members_fte"] = x.get_members_fte();
        j["name"] = x.get_name();
        j["native_name"] = x.get_native_name();
        j["networking"] = x.get_networking();
        j["number_of_natural_persons"] = x.get_number_of_natural_persons();
        j["other_code_of_conduct"] = x.get_other_code_of_conduct();
        j["registration_date"] = x.get_registration_date();
        j["status"] = x.get_status();
        j["structure_members"] = x.get_structure_members();
        j["sub_category"] = x.get_sub_category();
        j["sub_category_title"] = x.get_sub_category_title();
        j["updated_at"] = x.get_updated_at();
        j["uri"] = x.get_uri();
        j["web_site_url"] = x.get_web_site_url();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        x.set_facets(j.at("facets").get<Facets>());
        if (j.find("limit") != j.end() && !j.at("limit").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_limit(j.at("limit").get<int64_t>());
        x.set_next(j.at("next").get<std::string>());
        if (j.find("offset") != j.end() && !j.at("offset").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_offset(j.at("offset").get<int64_t>());
        x.set_previous(j.at("previous").get<bool>());
        x.set_results(j.at("results").get<std::vector<Result>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["facets"] = x.get_facets();
        j["limit"] = x.get_limit();
        j["next"] = x.get_next();
        j["offset"] = x.get_offset();
        j["previous"] = x.get_previous();
        j["results"] = x.get_results();
    }

    inline void from_json(const json & j, Status & x) {
        if (j == "active") x = Status::ACTIVE;
        else if (j == "inactive") x = Status::INACTIVE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Status\""); }
    }

    inline void to_json(json & j, const Status & x) {
        switch (x) {
            case Status::ACTIVE: j = "active"; break;
            case Status::INACTIVE: j = "inactive"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Status\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
