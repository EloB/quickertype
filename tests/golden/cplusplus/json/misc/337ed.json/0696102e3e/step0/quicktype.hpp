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

    class Facets {
        public:
        Facets() = default;
        virtual ~Facets() = default;

        private:

        public:
    };

    enum class Status : int { ACTIVE, INACTIVE };

    enum class CustomIncomeType : int { PUBLIC, OTHER };

    class CustomIncome {
        public:
        CustomIncome() = default;
        virtual ~CustomIncome() = default;

        private:
        int64_t amount;
        std::string created_at;
        std::string id;
        std::string name;
        Status status;
        CustomIncomeType type;
        std::string updated_at;
        std::string uri;

        public:
        const int64_t & get_amount() const { return amount; }
        int64_t & get_mutable_amount() { return amount; }
        void set_amount(const int64_t & value) { this->amount = value; }

        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const Status & get_status() const { return status; }
        Status & get_mutable_status() { return status; }
        void set_status(const Status & value) { this->status = value; }

        const CustomIncomeType & get_type() const { return type; }
        CustomIncomeType & get_mutable_type() { return type; }
        void set_type(const CustomIncomeType & value) { this->type = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }

        const std::string & get_uri() const { return uri; }
        std::string & get_mutable_uri() { return uri; }
        void set_uri(const std::string & value) { this->uri = value; }
    };

    enum class ResultType : int { FINANCIAL_DATA_NGO, FINANCIAL_DATA_LAWYER, FINANCIAL_DATA_TRADE_ASSOCIATION };

    class Result {
        public:
        Result() = default;
        virtual ~Result() = default;

        private:
        std::optional<int64_t> cost_absolute;
        std::optional<int64_t> cost_max;
        std::optional<int64_t> cost_min;
        std::string created_at;
        std::vector<CustomIncome> custom_incomes;
        nlohmann::json direct_rep_costs_max;
        nlohmann::json direct_rep_costs_min;
        std::string end_date;
        int64_t eur_sources_grants;
        std::optional<std::string> eur_sources_grants_src;
        int64_t eur_sources_procurement;
        std::optional<std::string> eur_sources_procurement_src;
        std::string id;
        nlohmann::json new_organisation;
        std::optional<std::string> no_clients;
        std::optional<std::string> other_financial_information;
        std::optional<int64_t> other_sources_contributions;
        std::optional<int64_t> other_sources_donation;
        std::optional<int64_t> other_sources_total;
        std::optional<int64_t> public_financing_infranational;
        std::optional<int64_t> public_financing_national;
        std::optional<int64_t> public_financing_total;
        std::string representative;
        std::string start_date;
        Status status;
        std::optional<int64_t> total_budget;
        std::optional<int64_t> turnover_absolute;
        std::optional<int64_t> turnover_max;
        std::optional<int64_t> turnover_min;
        ResultType type;
        std::string updated_at;
        std::string uri;

        public:
        std::optional<int64_t> get_cost_absolute() const { return cost_absolute; }
        void set_cost_absolute(std::optional<int64_t> value) { this->cost_absolute = value; }

        std::optional<int64_t> get_cost_max() const { return cost_max; }
        void set_cost_max(std::optional<int64_t> value) { this->cost_max = value; }

        std::optional<int64_t> get_cost_min() const { return cost_min; }
        void set_cost_min(std::optional<int64_t> value) { this->cost_min = value; }

        const std::string & get_created_at() const { return created_at; }
        std::string & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::string & value) { this->created_at = value; }

        const std::vector<CustomIncome> & get_custom_incomes() const { return custom_incomes; }
        std::vector<CustomIncome> & get_mutable_custom_incomes() { return custom_incomes; }
        void set_custom_incomes(const std::vector<CustomIncome> & value) { this->custom_incomes = value; }

        const nlohmann::json & get_direct_rep_costs_max() const { return direct_rep_costs_max; }
        nlohmann::json & get_mutable_direct_rep_costs_max() { return direct_rep_costs_max; }
        void set_direct_rep_costs_max(const nlohmann::json & value) { this->direct_rep_costs_max = value; }

        const nlohmann::json & get_direct_rep_costs_min() const { return direct_rep_costs_min; }
        nlohmann::json & get_mutable_direct_rep_costs_min() { return direct_rep_costs_min; }
        void set_direct_rep_costs_min(const nlohmann::json & value) { this->direct_rep_costs_min = value; }

        const std::string & get_end_date() const { return end_date; }
        std::string & get_mutable_end_date() { return end_date; }
        void set_end_date(const std::string & value) { this->end_date = value; }

        const int64_t & get_eur_sources_grants() const { return eur_sources_grants; }
        int64_t & get_mutable_eur_sources_grants() { return eur_sources_grants; }
        void set_eur_sources_grants(const int64_t & value) { this->eur_sources_grants = value; }

        std::optional<std::string> get_eur_sources_grants_src() const { return eur_sources_grants_src; }
        void set_eur_sources_grants_src(std::optional<std::string> value) { this->eur_sources_grants_src = value; }

        const int64_t & get_eur_sources_procurement() const { return eur_sources_procurement; }
        int64_t & get_mutable_eur_sources_procurement() { return eur_sources_procurement; }
        void set_eur_sources_procurement(const int64_t & value) { this->eur_sources_procurement = value; }

        std::optional<std::string> get_eur_sources_procurement_src() const { return eur_sources_procurement_src; }
        void set_eur_sources_procurement_src(std::optional<std::string> value) { this->eur_sources_procurement_src = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const nlohmann::json & get_new_organisation() const { return new_organisation; }
        nlohmann::json & get_mutable_new_organisation() { return new_organisation; }
        void set_new_organisation(const nlohmann::json & value) { this->new_organisation = value; }

        std::optional<std::string> get_no_clients() const { return no_clients; }
        void set_no_clients(std::optional<std::string> value) { this->no_clients = value; }

        std::optional<std::string> get_other_financial_information() const { return other_financial_information; }
        void set_other_financial_information(std::optional<std::string> value) { this->other_financial_information = value; }

        std::optional<int64_t> get_other_sources_contributions() const { return other_sources_contributions; }
        void set_other_sources_contributions(std::optional<int64_t> value) { this->other_sources_contributions = value; }

        std::optional<int64_t> get_other_sources_donation() const { return other_sources_donation; }
        void set_other_sources_donation(std::optional<int64_t> value) { this->other_sources_donation = value; }

        std::optional<int64_t> get_other_sources_total() const { return other_sources_total; }
        void set_other_sources_total(std::optional<int64_t> value) { this->other_sources_total = value; }

        std::optional<int64_t> get_public_financing_infranational() const { return public_financing_infranational; }
        void set_public_financing_infranational(std::optional<int64_t> value) { this->public_financing_infranational = value; }

        std::optional<int64_t> get_public_financing_national() const { return public_financing_national; }
        void set_public_financing_national(std::optional<int64_t> value) { this->public_financing_national = value; }

        std::optional<int64_t> get_public_financing_total() const { return public_financing_total; }
        void set_public_financing_total(std::optional<int64_t> value) { this->public_financing_total = value; }

        const std::string & get_representative() const { return representative; }
        std::string & get_mutable_representative() { return representative; }
        void set_representative(const std::string & value) { this->representative = value; }

        const std::string & get_start_date() const { return start_date; }
        std::string & get_mutable_start_date() { return start_date; }
        void set_start_date(const std::string & value) { this->start_date = value; }

        const Status & get_status() const { return status; }
        Status & get_mutable_status() { return status; }
        void set_status(const Status & value) { this->status = value; }

        std::optional<int64_t> get_total_budget() const { return total_budget; }
        void set_total_budget(std::optional<int64_t> value) { this->total_budget = value; }

        std::optional<int64_t> get_turnover_absolute() const { return turnover_absolute; }
        void set_turnover_absolute(std::optional<int64_t> value) { this->turnover_absolute = value; }

        std::optional<int64_t> get_turnover_max() const { return turnover_max; }
        void set_turnover_max(std::optional<int64_t> value) { this->turnover_max = value; }

        std::optional<int64_t> get_turnover_min() const { return turnover_min; }
        void set_turnover_min(std::optional<int64_t> value) { this->turnover_min = value; }

        const ResultType & get_type() const { return type; }
        ResultType & get_mutable_type() { return type; }
        void set_type(const ResultType & value) { this->type = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }

        const std::string & get_uri() const { return uri; }
        std::string & get_mutable_uri() { return uri; }
        void set_uri(const std::string & value) { this->uri = value; }
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

    void from_json(const json & j, CustomIncome & x);
    void to_json(json & j, const CustomIncome & x);

    void from_json(const json & j, Result & x);
    void to_json(json & j, const Result & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Status & x);
    void to_json(json & j, const Status & x);

    void from_json(const json & j, CustomIncomeType & x);
    void to_json(json & j, const CustomIncomeType & x);

    void from_json(const json & j, ResultType & x);
    void to_json(json & j, const ResultType & x);

    inline void from_json(const json & j, Facets& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Facets & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, CustomIncome& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("amount") != j.end() && !j.at("amount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_amount(j.at("amount").get<int64_t>());
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_status(j.at("status").get<Status>());
        x.set_type(j.at("type").get<CustomIncomeType>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
        x.set_uri(j.at("uri").get<std::string>());
    }

    inline void to_json(json & j, const CustomIncome & x) {
        j = json::object();
        j["amount"] = x.get_amount();
        j["created_at"] = x.get_created_at();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["status"] = x.get_status();
        j["type"] = x.get_type();
        j["updated_at"] = x.get_updated_at();
        j["uri"] = x.get_uri();
    }

    inline void from_json(const json & j, Result& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("cost_absolute");
        x.set_cost_absolute(get_stack_optional<int64_t>(j, "cost_absolute"));
        j.at("cost_max");
        x.set_cost_max(get_stack_optional<int64_t>(j, "cost_max"));
        j.at("cost_min");
        x.set_cost_min(get_stack_optional<int64_t>(j, "cost_min"));
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created_at(j.at("created_at").get<std::string>());
        x.set_custom_incomes(j.at("customIncomes").get<std::vector<CustomIncome>>());
        x.set_direct_rep_costs_max(get_untyped(j, "direct_rep_costs_max"));
        x.set_direct_rep_costs_min(get_untyped(j, "direct_rep_costs_min"));
        if (j.find("end_date") != j.end() && !std::regex_match(j.at("end_date").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_end_date(j.at("end_date").get<std::string>());
        if (j.find("eur_sources_grants") != j.end() && !j.at("eur_sources_grants").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_eur_sources_grants(j.at("eur_sources_grants").get<int64_t>());
        j.at("eur_sources_grants_src");
        x.set_eur_sources_grants_src(get_stack_optional<std::string>(j, "eur_sources_grants_src"));
        if (j.find("eur_sources_procurement") != j.end() && !j.at("eur_sources_procurement").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_eur_sources_procurement(j.at("eur_sources_procurement").get<int64_t>());
        j.at("eur_sources_procurement_src");
        x.set_eur_sources_procurement_src(get_stack_optional<std::string>(j, "eur_sources_procurement_src"));
        x.set_id(j.at("id").get<std::string>());
        x.set_new_organisation(get_untyped(j, "new_organisation"));
        j.at("no_clients");
        x.set_no_clients(get_stack_optional<std::string>(j, "no_clients"));
        j.at("other_financial_information");
        x.set_other_financial_information(get_stack_optional<std::string>(j, "other_financial_information"));
        j.at("other_sources_contributions");
        x.set_other_sources_contributions(get_stack_optional<int64_t>(j, "other_sources_contributions"));
        j.at("other_sources_donation");
        x.set_other_sources_donation(get_stack_optional<int64_t>(j, "other_sources_donation"));
        j.at("other_sources_total");
        x.set_other_sources_total(get_stack_optional<int64_t>(j, "other_sources_total"));
        j.at("public_financing_infranational");
        x.set_public_financing_infranational(get_stack_optional<int64_t>(j, "public_financing_infranational"));
        j.at("public_financing_national");
        x.set_public_financing_national(get_stack_optional<int64_t>(j, "public_financing_national"));
        j.at("public_financing_total");
        x.set_public_financing_total(get_stack_optional<int64_t>(j, "public_financing_total"));
        x.set_representative(j.at("representative").get<std::string>());
        if (j.find("start_date") != j.end() && !std::regex_match(j.at("start_date").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_start_date(j.at("start_date").get<std::string>());
        x.set_status(j.at("status").get<Status>());
        j.at("total_budget");
        x.set_total_budget(get_stack_optional<int64_t>(j, "total_budget"));
        j.at("turnover_absolute");
        x.set_turnover_absolute(get_stack_optional<int64_t>(j, "turnover_absolute"));
        j.at("turnover_max");
        x.set_turnover_max(get_stack_optional<int64_t>(j, "turnover_max"));
        j.at("turnover_min");
        x.set_turnover_min(get_stack_optional<int64_t>(j, "turnover_min"));
        x.set_type(j.at("type").get<ResultType>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
        x.set_uri(j.at("uri").get<std::string>());
    }

    inline void to_json(json & j, const Result & x) {
        j = json::object();
        j["cost_absolute"] = x.get_cost_absolute();
        j["cost_max"] = x.get_cost_max();
        j["cost_min"] = x.get_cost_min();
        j["created_at"] = x.get_created_at();
        j["customIncomes"] = x.get_custom_incomes();
        j["direct_rep_costs_max"] = x.get_direct_rep_costs_max();
        j["direct_rep_costs_min"] = x.get_direct_rep_costs_min();
        j["end_date"] = x.get_end_date();
        j["eur_sources_grants"] = x.get_eur_sources_grants();
        j["eur_sources_grants_src"] = x.get_eur_sources_grants_src();
        j["eur_sources_procurement"] = x.get_eur_sources_procurement();
        j["eur_sources_procurement_src"] = x.get_eur_sources_procurement_src();
        j["id"] = x.get_id();
        j["new_organisation"] = x.get_new_organisation();
        j["no_clients"] = x.get_no_clients();
        j["other_financial_information"] = x.get_other_financial_information();
        j["other_sources_contributions"] = x.get_other_sources_contributions();
        j["other_sources_donation"] = x.get_other_sources_donation();
        j["other_sources_total"] = x.get_other_sources_total();
        j["public_financing_infranational"] = x.get_public_financing_infranational();
        j["public_financing_national"] = x.get_public_financing_national();
        j["public_financing_total"] = x.get_public_financing_total();
        j["representative"] = x.get_representative();
        j["start_date"] = x.get_start_date();
        j["status"] = x.get_status();
        j["total_budget"] = x.get_total_budget();
        j["turnover_absolute"] = x.get_turnover_absolute();
        j["turnover_max"] = x.get_turnover_max();
        j["turnover_min"] = x.get_turnover_min();
        j["type"] = x.get_type();
        j["updated_at"] = x.get_updated_at();
        j["uri"] = x.get_uri();
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

    inline void from_json(const json & j, CustomIncomeType & x) {
        if (j == "public") x = CustomIncomeType::PUBLIC;
        else if (j == "other") x = CustomIncomeType::OTHER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"CustomIncomeType\""); }
    }

    inline void to_json(json & j, const CustomIncomeType & x) {
        switch (x) {
            case CustomIncomeType::PUBLIC: j = "public"; break;
            case CustomIncomeType::OTHER: j = "other"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"CustomIncomeType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ResultType & x) {
        if (j == "FinancialDataNGO") x = ResultType::FINANCIAL_DATA_NGO;
        else if (j == "FinancialDataLawyer") x = ResultType::FINANCIAL_DATA_LAWYER;
        else if (j == "FinancialDataTradeAssociation") x = ResultType::FINANCIAL_DATA_TRADE_ASSOCIATION;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ResultType\""); }
    }

    inline void to_json(json & j, const ResultType & x) {
        switch (x) {
            case ResultType::FINANCIAL_DATA_NGO: j = "FinancialDataNGO"; break;
            case ResultType::FINANCIAL_DATA_LAWYER: j = "FinancialDataLawyer"; break;
            case ResultType::FINANCIAL_DATA_TRADE_ASSOCIATION: j = "FinancialDataTradeAssociation"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ResultType\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
