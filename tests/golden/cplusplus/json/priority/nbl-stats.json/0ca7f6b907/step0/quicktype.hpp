//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include <variant>
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

    enum class LeaddatumEnum : int { EMPTY, P1, P2, P3, P4 };

    using LeaddatumElement = std::variant<LeaddatumEnum, int64_t>;

    enum class PerType : int { REGULAR };

    class Team {
        public:
        Team() = default;
        virtual ~Team() = default;

        private:
        std::string team_code;
        std::string team_code_international;
        std::string team_name;
        std::string team_name_international;

        public:
        const std::string & get_team_code() const { return team_code; }
        std::string & get_mutable_team_code() { return team_code; }
        void set_team_code(const std::string & value) { this->team_code = value; }

        const std::string & get_team_code_international() const { return team_code_international; }
        std::string & get_mutable_team_code_international() { return team_code_international; }
        void set_team_code_international(const std::string & value) { this->team_code_international = value; }

        const std::string & get_team_name() const { return team_name; }
        std::string & get_mutable_team_name() { return team_name; }
        void set_team_name(const std::string & value) { this->team_name = value; }

        const std::string & get_team_name_international() const { return team_name_international; }
        std::string & get_mutable_team_name_international() { return team_name_international; }
        void set_team_name_international(const std::string & value) { this->team_name_international = value; }
    };

    class Othermatch {
        public:
        Othermatch() = default;
        virtual ~Othermatch() = default;

        private:
        std::string clock;
        std::string competition_name;
        std::string id;
        int64_t period;
        PerType period_type;
        Team team1;
        std::string team1_name;
        int64_t team1_score;
        Team team2;
        std::string team2_name;
        int64_t team2_score;

        public:
        const std::string & get_clock() const { return clock; }
        std::string & get_mutable_clock() { return clock; }
        void set_clock(const std::string & value) { this->clock = value; }

        const std::string & get_competition_name() const { return competition_name; }
        std::string & get_mutable_competition_name() { return competition_name; }
        void set_competition_name(const std::string & value) { this->competition_name = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const int64_t & get_period() const { return period; }
        int64_t & get_mutable_period() { return period; }
        void set_period(const int64_t & value) { this->period = value; }

        const PerType & get_period_type() const { return period_type; }
        PerType & get_mutable_period_type() { return period_type; }
        void set_period_type(const PerType & value) { this->period_type = value; }

        const Team & get_team1() const { return team1; }
        Team & get_mutable_team1() { return team1; }
        void set_team1(const Team & value) { this->team1 = value; }

        const std::string & get_team1_name() const { return team1_name; }
        std::string & get_mutable_team1_name() { return team1_name; }
        void set_team1_name(const std::string & value) { this->team1_name = value; }

        const int64_t & get_team1_score() const { return team1_score; }
        int64_t & get_mutable_team1_score() { return team1_score; }
        void set_team1_score(const int64_t & value) { this->team1_score = value; }

        const Team & get_team2() const { return team2; }
        Team & get_mutable_team2() { return team2; }
        void set_team2(const Team & value) { this->team2 = value; }

        const std::string & get_team2_name() const { return team2_name; }
        std::string & get_mutable_team2_name() { return team2_name; }
        void set_team2_name(const std::string & value) { this->team2_name = value; }

        const int64_t & get_team2_score() const { return team2_score; }
        int64_t & get_mutable_team2_score() { return team2_score; }
        void set_team2_score(const int64_t & value) { this->team2_score = value; }
    };

    enum class ActionType : int { GAME, PERIOD, THE_3_PT, THE_2_PT, REBOUND, TIMEOUT, FOULON, FOUL, ASSIST, SUBSTITUTION, FREETHROW, STEAL, TURNOVER, BLOCK, JUMPBALL };

    enum class FamilyNameInitial : int { R, M, S, C, O, W, A, P, V, I, J, FAMILY_NAME_INITIAL_S, H, B };

    enum class FirstNameInitial : int { D, J, T, C, O, H, L, A, K, R, B, N };

    enum class ScoreboardName : int { EMPTY, T_S, R_IHATA, D_JONES, B_VALENTINE };

    class Pbp {
        public:
        Pbp() = default;
        virtual ~Pbp() = default;

        private:
        ActionType action_type;
        std::optional<std::string> family_name;
        std::optional<FamilyNameInitial> family_name_initial;
        std::optional<std::string> first_name;
        std::optional<FirstNameInitial> first_name_initial;
        std::string gt;
        std::optional<std::string> international_family_name;
        std::optional<FamilyNameInitial> international_family_name_initial;
        std::optional<std::string> international_first_name;
        std::optional<FirstNameInitial> international_first_name_initial;
        int64_t lead;
        int64_t period;
        PerType period_type;
        std::string player;
        int64_t pno;
        std::string qualifier;
        int64_t s1;
        int64_t s2;
        std::optional<ScoreboardName> scoreboard_name;
        int64_t scoring;
        std::string shirt_number;
        std::string sub_type;
        int64_t success;
        int64_t tno;

        public:
        const ActionType & get_action_type() const { return action_type; }
        ActionType & get_mutable_action_type() { return action_type; }
        void set_action_type(const ActionType & value) { this->action_type = value; }

        const std::optional<std::string> & get_family_name() const { return family_name; }
        std::optional<std::string> & get_mutable_family_name() { return family_name; }
        void set_family_name(const std::optional<std::string> & value) { this->family_name = value; }

        const std::optional<FamilyNameInitial> & get_family_name_initial() const { return family_name_initial; }
        std::optional<FamilyNameInitial> & get_mutable_family_name_initial() { return family_name_initial; }
        void set_family_name_initial(const std::optional<FamilyNameInitial> & value) { this->family_name_initial = value; }

        const std::optional<std::string> & get_first_name() const { return first_name; }
        std::optional<std::string> & get_mutable_first_name() { return first_name; }
        void set_first_name(const std::optional<std::string> & value) { this->first_name = value; }

        const std::optional<FirstNameInitial> & get_first_name_initial() const { return first_name_initial; }
        std::optional<FirstNameInitial> & get_mutable_first_name_initial() { return first_name_initial; }
        void set_first_name_initial(const std::optional<FirstNameInitial> & value) { this->first_name_initial = value; }

        const std::string & get_gt() const { return gt; }
        std::string & get_mutable_gt() { return gt; }
        void set_gt(const std::string & value) { this->gt = value; }

        const std::optional<std::string> & get_international_family_name() const { return international_family_name; }
        std::optional<std::string> & get_mutable_international_family_name() { return international_family_name; }
        void set_international_family_name(const std::optional<std::string> & value) { this->international_family_name = value; }

        const std::optional<FamilyNameInitial> & get_international_family_name_initial() const { return international_family_name_initial; }
        std::optional<FamilyNameInitial> & get_mutable_international_family_name_initial() { return international_family_name_initial; }
        void set_international_family_name_initial(const std::optional<FamilyNameInitial> & value) { this->international_family_name_initial = value; }

        const std::optional<std::string> & get_international_first_name() const { return international_first_name; }
        std::optional<std::string> & get_mutable_international_first_name() { return international_first_name; }
        void set_international_first_name(const std::optional<std::string> & value) { this->international_first_name = value; }

        const std::optional<FirstNameInitial> & get_international_first_name_initial() const { return international_first_name_initial; }
        std::optional<FirstNameInitial> & get_mutable_international_first_name_initial() { return international_first_name_initial; }
        void set_international_first_name_initial(const std::optional<FirstNameInitial> & value) { this->international_first_name_initial = value; }

        const int64_t & get_lead() const { return lead; }
        int64_t & get_mutable_lead() { return lead; }
        void set_lead(const int64_t & value) { this->lead = value; }

        const int64_t & get_period() const { return period; }
        int64_t & get_mutable_period() { return period; }
        void set_period(const int64_t & value) { this->period = value; }

        const PerType & get_period_type() const { return period_type; }
        PerType & get_mutable_period_type() { return period_type; }
        void set_period_type(const PerType & value) { this->period_type = value; }

        const std::string & get_player() const { return player; }
        std::string & get_mutable_player() { return player; }
        void set_player(const std::string & value) { this->player = value; }

        const int64_t & get_pno() const { return pno; }
        int64_t & get_mutable_pno() { return pno; }
        void set_pno(const int64_t & value) { this->pno = value; }

        const std::string & get_qualifier() const { return qualifier; }
        std::string & get_mutable_qualifier() { return qualifier; }
        void set_qualifier(const std::string & value) { this->qualifier = value; }

        const int64_t & get_s1() const { return s1; }
        int64_t & get_mutable_s1() { return s1; }
        void set_s1(const int64_t & value) { this->s1 = value; }

        const int64_t & get_s2() const { return s2; }
        int64_t & get_mutable_s2() { return s2; }
        void set_s2(const int64_t & value) { this->s2 = value; }

        const std::optional<ScoreboardName> & get_scoreboard_name() const { return scoreboard_name; }
        std::optional<ScoreboardName> & get_mutable_scoreboard_name() { return scoreboard_name; }
        void set_scoreboard_name(const std::optional<ScoreboardName> & value) { this->scoreboard_name = value; }

        const int64_t & get_scoring() const { return scoring; }
        int64_t & get_mutable_scoring() { return scoring; }
        void set_scoring(const int64_t & value) { this->scoring = value; }

        const std::string & get_shirt_number() const { return shirt_number; }
        std::string & get_mutable_shirt_number() { return shirt_number; }
        void set_shirt_number(const std::string & value) { this->shirt_number = value; }

        const std::string & get_sub_type() const { return sub_type; }
        std::string & get_mutable_sub_type() { return sub_type; }
        void set_sub_type(const std::string & value) { this->sub_type = value; }

        const int64_t & get_success() const { return success; }
        int64_t & get_mutable_success() { return success; }
        void set_success(const int64_t & value) { this->success = value; }

        const int64_t & get_tno() const { return tno; }
        int64_t & get_mutable_tno() { return tno; }
        void set_tno(const int64_t & value) { this->tno = value; }
    };

    class Time {
        public:
        Time() = default;
        virtual ~Time() = default;

        private:
        std::string gt;
        int64_t per;
        PerType per_type;

        public:
        const std::string & get_gt() const { return gt; }
        std::string & get_mutable_gt() { return gt; }
        void set_gt(const std::string & value) { this->gt = value; }

        const int64_t & get_per() const { return per; }
        int64_t & get_mutable_per() { return per; }
        void set_per(const int64_t & value) { this->per = value; }

        const PerType & get_per_type() const { return per_type; }
        PerType & get_mutable_per_type() { return per_type; }
        void set_per_type(const PerType & value) { this->per_type = value; }
    };

    class Scorer {
        public:
        Scorer() = default;
        virtual ~Scorer() = default;

        private:
        std::optional<std::string> family_name;
        std::optional<FamilyNameInitial> family_name_initial;
        std::optional<std::string> first_name;
        std::optional<FirstNameInitial> first_name_initial;
        std::optional<std::string> gt;
        std::optional<std::string> international_family_name;
        std::optional<FamilyNameInitial> international_family_name_initial;
        std::optional<std::string> international_first_name;
        std::optional<FirstNameInitial> international_first_name_initial;
        std::optional<std::string> name;
        std::optional<int64_t> per;
        std::optional<PerType> per_type;
        std::optional<std::string> player;
        int64_t pno;
        std::optional<ScoreboardName> scoreboard_name;
        std::string shirt_number;
        std::optional<std::string> summary;
        std::optional<std::vector<Time>> times;
        int64_t tno;
        std::optional<int64_t> tot;

        public:
        const std::optional<std::string> & get_family_name() const { return family_name; }
        std::optional<std::string> & get_mutable_family_name() { return family_name; }
        void set_family_name(const std::optional<std::string> & value) { this->family_name = value; }

        const std::optional<FamilyNameInitial> & get_family_name_initial() const { return family_name_initial; }
        std::optional<FamilyNameInitial> & get_mutable_family_name_initial() { return family_name_initial; }
        void set_family_name_initial(const std::optional<FamilyNameInitial> & value) { this->family_name_initial = value; }

        const std::optional<std::string> & get_first_name() const { return first_name; }
        std::optional<std::string> & get_mutable_first_name() { return first_name; }
        void set_first_name(const std::optional<std::string> & value) { this->first_name = value; }

        const std::optional<FirstNameInitial> & get_first_name_initial() const { return first_name_initial; }
        std::optional<FirstNameInitial> & get_mutable_first_name_initial() { return first_name_initial; }
        void set_first_name_initial(const std::optional<FirstNameInitial> & value) { this->first_name_initial = value; }

        const std::optional<std::string> & get_gt() const { return gt; }
        std::optional<std::string> & get_mutable_gt() { return gt; }
        void set_gt(const std::optional<std::string> & value) { this->gt = value; }

        const std::optional<std::string> & get_international_family_name() const { return international_family_name; }
        std::optional<std::string> & get_mutable_international_family_name() { return international_family_name; }
        void set_international_family_name(const std::optional<std::string> & value) { this->international_family_name = value; }

        const std::optional<FamilyNameInitial> & get_international_family_name_initial() const { return international_family_name_initial; }
        std::optional<FamilyNameInitial> & get_mutable_international_family_name_initial() { return international_family_name_initial; }
        void set_international_family_name_initial(const std::optional<FamilyNameInitial> & value) { this->international_family_name_initial = value; }

        const std::optional<std::string> & get_international_first_name() const { return international_first_name; }
        std::optional<std::string> & get_mutable_international_first_name() { return international_first_name; }
        void set_international_first_name(const std::optional<std::string> & value) { this->international_first_name = value; }

        const std::optional<FirstNameInitial> & get_international_first_name_initial() const { return international_first_name_initial; }
        std::optional<FirstNameInitial> & get_mutable_international_first_name_initial() { return international_first_name_initial; }
        void set_international_first_name_initial(const std::optional<FirstNameInitial> & value) { this->international_first_name_initial = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        const std::optional<int64_t> & get_per() const { return per; }
        std::optional<int64_t> & get_mutable_per() { return per; }
        void set_per(const std::optional<int64_t> & value) { this->per = value; }

        const std::optional<PerType> & get_per_type() const { return per_type; }
        std::optional<PerType> & get_mutable_per_type() { return per_type; }
        void set_per_type(const std::optional<PerType> & value) { this->per_type = value; }

        const std::optional<std::string> & get_player() const { return player; }
        std::optional<std::string> & get_mutable_player() { return player; }
        void set_player(const std::optional<std::string> & value) { this->player = value; }

        const int64_t & get_pno() const { return pno; }
        int64_t & get_mutable_pno() { return pno; }
        void set_pno(const int64_t & value) { this->pno = value; }

        const std::optional<ScoreboardName> & get_scoreboard_name() const { return scoreboard_name; }
        std::optional<ScoreboardName> & get_mutable_scoreboard_name() { return scoreboard_name; }
        void set_scoreboard_name(const std::optional<ScoreboardName> & value) { this->scoreboard_name = value; }

        const std::string & get_shirt_number() const { return shirt_number; }
        std::string & get_mutable_shirt_number() { return shirt_number; }
        void set_shirt_number(const std::string & value) { this->shirt_number = value; }

        const std::optional<std::string> & get_summary() const { return summary; }
        std::optional<std::string> & get_mutable_summary() { return summary; }
        void set_summary(const std::optional<std::string> & value) { this->summary = value; }

        const std::optional<std::vector<Time>> & get_times() const { return times; }
        std::optional<std::vector<Time>> & get_mutable_times() { return times; }
        void set_times(const std::optional<std::vector<Time>> & value) { this->times = value; }

        const int64_t & get_tno() const { return tno; }
        int64_t & get_mutable_tno() { return tno; }
        void set_tno(const int64_t & value) { this->tno = value; }

        const std::optional<int64_t> & get_tot() const { return tot; }
        std::optional<int64_t> & get_mutable_tot() { return tot; }
        void set_tot(const std::optional<int64_t> & value) { this->tot = value; }
    };

    class SBlocks {
        public:
        SBlocks() = default;
        virtual ~SBlocks() = default;

        private:
        Scorer the_1;

        public:
        const Scorer & get_the_1() const { return the_1; }
        Scorer & get_mutable_the_1() { return the_1; }
        void set_the_1(const Scorer & value) { this->the_1 = value; }
    };

    class Lds {
        public:
        Lds() = default;
        virtual ~Lds() = default;

        private:
        std::map<std::string, Scorer> s_assists;
        SBlocks s_blocks;
        std::map<std::string, Scorer> s_points;
        std::map<std::string, Scorer> s_rebounds_total;
        std::map<std::string, Scorer> s_steals;

        public:
        const std::map<std::string, Scorer> & get_s_assists() const { return s_assists; }
        std::map<std::string, Scorer> & get_mutable_s_assists() { return s_assists; }
        void set_s_assists(const std::map<std::string, Scorer> & value) { this->s_assists = value; }

        const SBlocks & get_s_blocks() const { return s_blocks; }
        SBlocks & get_mutable_s_blocks() { return s_blocks; }
        void set_s_blocks(const SBlocks & value) { this->s_blocks = value; }

        const std::map<std::string, Scorer> & get_s_points() const { return s_points; }
        std::map<std::string, Scorer> & get_mutable_s_points() { return s_points; }
        void set_s_points(const std::map<std::string, Scorer> & value) { this->s_points = value; }

        const std::map<std::string, Scorer> & get_s_rebounds_total() const { return s_rebounds_total; }
        std::map<std::string, Scorer> & get_mutable_s_rebounds_total() { return s_rebounds_total; }
        void set_s_rebounds_total(const std::map<std::string, Scorer> & value) { this->s_rebounds_total = value; }

        const std::map<std::string, Scorer> & get_s_steals() const { return s_steals; }
        std::map<std::string, Scorer> & get_mutable_s_steals() { return s_steals; }
        void set_s_steals(const std::map<std::string, Scorer> & value) { this->s_steals = value; }
    };

    class Comp {
        public:
        Comp() = default;
        virtual ~Comp() = default;

        private:
        double s_assists_average;
        std::string s_minutes_average;
        double s_points_average;
        double s_rebounds_total_average;

        public:
        const double & get_s_assists_average() const { return s_assists_average; }
        double & get_mutable_s_assists_average() { return s_assists_average; }
        void set_s_assists_average(const double & value) { this->s_assists_average = value; }

        const std::string & get_s_minutes_average() const { return s_minutes_average; }
        std::string & get_mutable_s_minutes_average() { return s_minutes_average; }
        void set_s_minutes_average(const std::string & value) { this->s_minutes_average = value; }

        const double & get_s_points_average() const { return s_points_average; }
        double & get_mutable_s_points_average() { return s_points_average; }
        void set_s_points_average(const double & value) { this->s_points_average = value; }

        const double & get_s_rebounds_total_average() const { return s_rebounds_total_average; }
        double & get_mutable_s_rebounds_total_average() { return s_rebounds_total_average; }
        void set_s_rebounds_total_average(const double & value) { this->s_rebounds_total_average = value; }
    };

    using SMinutes = std::variant<int64_t, std::string>;

    class Pl {
        public:
        Pl() = default;
        virtual ~Pl() = default;

        private:
        int64_t active;
        std::optional<int64_t> captain;
        std::optional<Comp> comp;
        int64_t eff_1;
        int64_t eff_2;
        double eff_3;
        double eff_4;
        int64_t eff_5;
        int64_t eff_6;
        int64_t eff_7;
        std::string family_name;
        FamilyNameInitial family_name_initial;
        std::string first_name;
        FirstNameInitial first_name_initial;
        std::string international_family_name;
        FamilyNameInitial international_family_name_initial;
        std::string international_first_name;
        FirstNameInitial international_first_name_initial;
        std::string name;
        std::string playing_position;
        int64_t s_assists;
        int64_t s_blocks;
        int64_t s_blocks_received;
        int64_t s_field_goals_attempted;
        int64_t s_field_goals_made;
        int64_t s_field_goals_percentage;
        int64_t s_fouls_on;
        int64_t s_fouls_personal;
        int64_t s_free_throws_attempted;
        int64_t s_free_throws_made;
        int64_t s_free_throws_percentage;
        SMinutes s_minutes;
        int64_t s_plus_minus_points;
        int64_t s_points;
        int64_t s_points_fast_break;
        int64_t s_points_in_the_paint;
        int64_t s_points_second_chance;
        int64_t s_rebounds_defensive;
        int64_t s_rebounds_offensive;
        int64_t s_rebounds_total;
        int64_t s_steals;
        int64_t s_three_pointers_attempted;
        int64_t s_three_pointers_made;
        int64_t s_three_pointers_percentage;
        int64_t s_turnovers;
        int64_t s_two_pointers_attempted;
        int64_t s_two_pointers_made;
        int64_t s_two_pointers_percentage;
        std::string shirt_number;
        int64_t starter;

        public:
        const int64_t & get_active() const { return active; }
        int64_t & get_mutable_active() { return active; }
        void set_active(const int64_t & value) { this->active = value; }

        const std::optional<int64_t> & get_captain() const { return captain; }
        std::optional<int64_t> & get_mutable_captain() { return captain; }
        void set_captain(const std::optional<int64_t> & value) { this->captain = value; }

        const std::optional<Comp> & get_comp() const { return comp; }
        std::optional<Comp> & get_mutable_comp() { return comp; }
        void set_comp(const std::optional<Comp> & value) { this->comp = value; }

        const int64_t & get_eff_1() const { return eff_1; }
        int64_t & get_mutable_eff_1() { return eff_1; }
        void set_eff_1(const int64_t & value) { this->eff_1 = value; }

        const int64_t & get_eff_2() const { return eff_2; }
        int64_t & get_mutable_eff_2() { return eff_2; }
        void set_eff_2(const int64_t & value) { this->eff_2 = value; }

        const double & get_eff_3() const { return eff_3; }
        double & get_mutable_eff_3() { return eff_3; }
        void set_eff_3(const double & value) { this->eff_3 = value; }

        const double & get_eff_4() const { return eff_4; }
        double & get_mutable_eff_4() { return eff_4; }
        void set_eff_4(const double & value) { this->eff_4 = value; }

        const int64_t & get_eff_5() const { return eff_5; }
        int64_t & get_mutable_eff_5() { return eff_5; }
        void set_eff_5(const int64_t & value) { this->eff_5 = value; }

        const int64_t & get_eff_6() const { return eff_6; }
        int64_t & get_mutable_eff_6() { return eff_6; }
        void set_eff_6(const int64_t & value) { this->eff_6 = value; }

        const int64_t & get_eff_7() const { return eff_7; }
        int64_t & get_mutable_eff_7() { return eff_7; }
        void set_eff_7(const int64_t & value) { this->eff_7 = value; }

        const std::string & get_family_name() const { return family_name; }
        std::string & get_mutable_family_name() { return family_name; }
        void set_family_name(const std::string & value) { this->family_name = value; }

        const FamilyNameInitial & get_family_name_initial() const { return family_name_initial; }
        FamilyNameInitial & get_mutable_family_name_initial() { return family_name_initial; }
        void set_family_name_initial(const FamilyNameInitial & value) { this->family_name_initial = value; }

        const std::string & get_first_name() const { return first_name; }
        std::string & get_mutable_first_name() { return first_name; }
        void set_first_name(const std::string & value) { this->first_name = value; }

        const FirstNameInitial & get_first_name_initial() const { return first_name_initial; }
        FirstNameInitial & get_mutable_first_name_initial() { return first_name_initial; }
        void set_first_name_initial(const FirstNameInitial & value) { this->first_name_initial = value; }

        const std::string & get_international_family_name() const { return international_family_name; }
        std::string & get_mutable_international_family_name() { return international_family_name; }
        void set_international_family_name(const std::string & value) { this->international_family_name = value; }

        const FamilyNameInitial & get_international_family_name_initial() const { return international_family_name_initial; }
        FamilyNameInitial & get_mutable_international_family_name_initial() { return international_family_name_initial; }
        void set_international_family_name_initial(const FamilyNameInitial & value) { this->international_family_name_initial = value; }

        const std::string & get_international_first_name() const { return international_first_name; }
        std::string & get_mutable_international_first_name() { return international_first_name; }
        void set_international_first_name(const std::string & value) { this->international_first_name = value; }

        const FirstNameInitial & get_international_first_name_initial() const { return international_first_name_initial; }
        FirstNameInitial & get_mutable_international_first_name_initial() { return international_first_name_initial; }
        void set_international_first_name_initial(const FirstNameInitial & value) { this->international_first_name_initial = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_playing_position() const { return playing_position; }
        std::string & get_mutable_playing_position() { return playing_position; }
        void set_playing_position(const std::string & value) { this->playing_position = value; }

        const int64_t & get_s_assists() const { return s_assists; }
        int64_t & get_mutable_s_assists() { return s_assists; }
        void set_s_assists(const int64_t & value) { this->s_assists = value; }

        const int64_t & get_s_blocks() const { return s_blocks; }
        int64_t & get_mutable_s_blocks() { return s_blocks; }
        void set_s_blocks(const int64_t & value) { this->s_blocks = value; }

        const int64_t & get_s_blocks_received() const { return s_blocks_received; }
        int64_t & get_mutable_s_blocks_received() { return s_blocks_received; }
        void set_s_blocks_received(const int64_t & value) { this->s_blocks_received = value; }

        const int64_t & get_s_field_goals_attempted() const { return s_field_goals_attempted; }
        int64_t & get_mutable_s_field_goals_attempted() { return s_field_goals_attempted; }
        void set_s_field_goals_attempted(const int64_t & value) { this->s_field_goals_attempted = value; }

        const int64_t & get_s_field_goals_made() const { return s_field_goals_made; }
        int64_t & get_mutable_s_field_goals_made() { return s_field_goals_made; }
        void set_s_field_goals_made(const int64_t & value) { this->s_field_goals_made = value; }

        const int64_t & get_s_field_goals_percentage() const { return s_field_goals_percentage; }
        int64_t & get_mutable_s_field_goals_percentage() { return s_field_goals_percentage; }
        void set_s_field_goals_percentage(const int64_t & value) { this->s_field_goals_percentage = value; }

        const int64_t & get_s_fouls_on() const { return s_fouls_on; }
        int64_t & get_mutable_s_fouls_on() { return s_fouls_on; }
        void set_s_fouls_on(const int64_t & value) { this->s_fouls_on = value; }

        const int64_t & get_s_fouls_personal() const { return s_fouls_personal; }
        int64_t & get_mutable_s_fouls_personal() { return s_fouls_personal; }
        void set_s_fouls_personal(const int64_t & value) { this->s_fouls_personal = value; }

        const int64_t & get_s_free_throws_attempted() const { return s_free_throws_attempted; }
        int64_t & get_mutable_s_free_throws_attempted() { return s_free_throws_attempted; }
        void set_s_free_throws_attempted(const int64_t & value) { this->s_free_throws_attempted = value; }

        const int64_t & get_s_free_throws_made() const { return s_free_throws_made; }
        int64_t & get_mutable_s_free_throws_made() { return s_free_throws_made; }
        void set_s_free_throws_made(const int64_t & value) { this->s_free_throws_made = value; }

        const int64_t & get_s_free_throws_percentage() const { return s_free_throws_percentage; }
        int64_t & get_mutable_s_free_throws_percentage() { return s_free_throws_percentage; }
        void set_s_free_throws_percentage(const int64_t & value) { this->s_free_throws_percentage = value; }

        const SMinutes & get_s_minutes() const { return s_minutes; }
        SMinutes & get_mutable_s_minutes() { return s_minutes; }
        void set_s_minutes(const SMinutes & value) { this->s_minutes = value; }

        const int64_t & get_s_plus_minus_points() const { return s_plus_minus_points; }
        int64_t & get_mutable_s_plus_minus_points() { return s_plus_minus_points; }
        void set_s_plus_minus_points(const int64_t & value) { this->s_plus_minus_points = value; }

        const int64_t & get_s_points() const { return s_points; }
        int64_t & get_mutable_s_points() { return s_points; }
        void set_s_points(const int64_t & value) { this->s_points = value; }

        const int64_t & get_s_points_fast_break() const { return s_points_fast_break; }
        int64_t & get_mutable_s_points_fast_break() { return s_points_fast_break; }
        void set_s_points_fast_break(const int64_t & value) { this->s_points_fast_break = value; }

        const int64_t & get_s_points_in_the_paint() const { return s_points_in_the_paint; }
        int64_t & get_mutable_s_points_in_the_paint() { return s_points_in_the_paint; }
        void set_s_points_in_the_paint(const int64_t & value) { this->s_points_in_the_paint = value; }

        const int64_t & get_s_points_second_chance() const { return s_points_second_chance; }
        int64_t & get_mutable_s_points_second_chance() { return s_points_second_chance; }
        void set_s_points_second_chance(const int64_t & value) { this->s_points_second_chance = value; }

        const int64_t & get_s_rebounds_defensive() const { return s_rebounds_defensive; }
        int64_t & get_mutable_s_rebounds_defensive() { return s_rebounds_defensive; }
        void set_s_rebounds_defensive(const int64_t & value) { this->s_rebounds_defensive = value; }

        const int64_t & get_s_rebounds_offensive() const { return s_rebounds_offensive; }
        int64_t & get_mutable_s_rebounds_offensive() { return s_rebounds_offensive; }
        void set_s_rebounds_offensive(const int64_t & value) { this->s_rebounds_offensive = value; }

        const int64_t & get_s_rebounds_total() const { return s_rebounds_total; }
        int64_t & get_mutable_s_rebounds_total() { return s_rebounds_total; }
        void set_s_rebounds_total(const int64_t & value) { this->s_rebounds_total = value; }

        const int64_t & get_s_steals() const { return s_steals; }
        int64_t & get_mutable_s_steals() { return s_steals; }
        void set_s_steals(const int64_t & value) { this->s_steals = value; }

        const int64_t & get_s_three_pointers_attempted() const { return s_three_pointers_attempted; }
        int64_t & get_mutable_s_three_pointers_attempted() { return s_three_pointers_attempted; }
        void set_s_three_pointers_attempted(const int64_t & value) { this->s_three_pointers_attempted = value; }

        const int64_t & get_s_three_pointers_made() const { return s_three_pointers_made; }
        int64_t & get_mutable_s_three_pointers_made() { return s_three_pointers_made; }
        void set_s_three_pointers_made(const int64_t & value) { this->s_three_pointers_made = value; }

        const int64_t & get_s_three_pointers_percentage() const { return s_three_pointers_percentage; }
        int64_t & get_mutable_s_three_pointers_percentage() { return s_three_pointers_percentage; }
        void set_s_three_pointers_percentage(const int64_t & value) { this->s_three_pointers_percentage = value; }

        const int64_t & get_s_turnovers() const { return s_turnovers; }
        int64_t & get_mutable_s_turnovers() { return s_turnovers; }
        void set_s_turnovers(const int64_t & value) { this->s_turnovers = value; }

        const int64_t & get_s_two_pointers_attempted() const { return s_two_pointers_attempted; }
        int64_t & get_mutable_s_two_pointers_attempted() { return s_two_pointers_attempted; }
        void set_s_two_pointers_attempted(const int64_t & value) { this->s_two_pointers_attempted = value; }

        const int64_t & get_s_two_pointers_made() const { return s_two_pointers_made; }
        int64_t & get_mutable_s_two_pointers_made() { return s_two_pointers_made; }
        void set_s_two_pointers_made(const int64_t & value) { this->s_two_pointers_made = value; }

        const int64_t & get_s_two_pointers_percentage() const { return s_two_pointers_percentage; }
        int64_t & get_mutable_s_two_pointers_percentage() { return s_two_pointers_percentage; }
        void set_s_two_pointers_percentage(const int64_t & value) { this->s_two_pointers_percentage = value; }

        const std::string & get_shirt_number() const { return shirt_number; }
        std::string & get_mutable_shirt_number() { return shirt_number; }
        void set_shirt_number(const std::string & value) { this->shirt_number = value; }

        const int64_t & get_starter() const { return starter; }
        int64_t & get_mutable_starter() { return starter; }
        void set_starter(const int64_t & value) { this->starter = value; }
    };

    enum class SubType : int { JUMPSHOT, LAYUP, DUNK };

    class Shot {
        public:
        Shot() = default;
        virtual ~Shot() = default;

        private:
        ActionType action_type;
        int64_t p;
        int64_t per;
        PerType per_type;
        std::string player;
        int64_t pno;
        int64_t r;
        std::string shirt_number;
        SubType sub_type;
        int64_t tno;
        int64_t x;
        int64_t y;

        public:
        const ActionType & get_action_type() const { return action_type; }
        ActionType & get_mutable_action_type() { return action_type; }
        void set_action_type(const ActionType & value) { this->action_type = value; }

        const int64_t & get_p() const { return p; }
        int64_t & get_mutable_p() { return p; }
        void set_p(const int64_t & value) { this->p = value; }

        const int64_t & get_per() const { return per; }
        int64_t & get_mutable_per() { return per; }
        void set_per(const int64_t & value) { this->per = value; }

        const PerType & get_per_type() const { return per_type; }
        PerType & get_mutable_per_type() { return per_type; }
        void set_per_type(const PerType & value) { this->per_type = value; }

        const std::string & get_player() const { return player; }
        std::string & get_mutable_player() { return player; }
        void set_player(const std::string & value) { this->player = value; }

        const int64_t & get_pno() const { return pno; }
        int64_t & get_mutable_pno() { return pno; }
        void set_pno(const int64_t & value) { this->pno = value; }

        const int64_t & get_r() const { return r; }
        int64_t & get_mutable_r() { return r; }
        void set_r(const int64_t & value) { this->r = value; }

        const std::string & get_shirt_number() const { return shirt_number; }
        std::string & get_mutable_shirt_number() { return shirt_number; }
        void set_shirt_number(const std::string & value) { this->shirt_number = value; }

        const SubType & get_sub_type() const { return sub_type; }
        SubType & get_mutable_sub_type() { return sub_type; }
        void set_sub_type(const SubType & value) { this->sub_type = value; }

        const int64_t & get_tno() const { return tno; }
        int64_t & get_mutable_tno() { return tno; }
        void set_tno(const int64_t & value) { this->tno = value; }

        const int64_t & get_x() const { return x; }
        int64_t & get_mutable_x() { return x; }
        void set_x(const int64_t & value) { this->x = value; }

        const int64_t & get_y() const { return y; }
        int64_t & get_mutable_y() { return y; }
        void set_y(const int64_t & value) { this->y = value; }
    };

    class Tm {
        public:
        Tm() = default;
        virtual ~Tm() = default;

        private:
        std::string code;
        std::string code_international;
        int64_t fouls;
        int64_t full_score;
        Lds lds;
        std::string logo;
        std::string name;
        std::string name_international;
        int64_t p1_score;
        int64_t p2_score;
        int64_t p3_score;
        int64_t p4_score;
        std::map<std::string, Pl> pl;
        int64_t score;
        std::vector<Scorer> scoring;
        std::string short_name;
        std::string short_name_international;
        std::vector<Shot> shot;
        int64_t timeouts;
        int64_t tot_eff_1;
        int64_t tot_eff_2;
        double tot_eff_3;
        int64_t tot_eff_4;
        int64_t tot_eff_5;
        int64_t tot_eff_6;
        int64_t tot_eff_7;
        int64_t tot_s_assists;
        int64_t tot_s_bench_points;
        int64_t tot_s_biggest_lead;
        int64_t tot_s_biggest_scoring_run;
        int64_t tot_s_blocks;
        int64_t tot_s_blocks_received;
        int64_t tot_s_field_goals_attempted;
        int64_t tot_s_field_goals_made;
        int64_t tot_s_field_goals_percentage;
        int64_t tot_s_fouls_on;
        int64_t tot_s_fouls_personal;
        int64_t tot_s_fouls_team;
        int64_t tot_s_free_throws_attempted;
        int64_t tot_s_free_throws_made;
        int64_t tot_s_free_throws_percentage;
        int64_t tot_s_lead_changes;
        int64_t tot_s_minutes;
        int64_t tot_s_points;
        int64_t tot_s_points_fast_break;
        int64_t tot_s_points_from_turnovers;
        int64_t tot_s_points_in_the_paint;
        int64_t tot_s_points_second_chance;
        int64_t tot_s_rebounds_defensive;
        int64_t tot_s_rebounds_offensive;
        int64_t tot_s_rebounds_team;
        int64_t tot_s_rebounds_team_defensive;
        int64_t tot_s_rebounds_team_offensive;
        int64_t tot_s_rebounds_total;
        int64_t tot_s_steals;
        int64_t tot_s_three_pointers_attempted;
        int64_t tot_s_three_pointers_made;
        int64_t tot_s_three_pointers_percentage;
        double tot_s_time_leading;
        int64_t tot_s_times_scores_level;
        int64_t tot_s_turnovers;
        int64_t tot_s_turnovers_team;
        int64_t tot_s_two_pointers_attempted;
        int64_t tot_s_two_pointers_made;
        int64_t tot_s_two_pointers_percentage;

        public:
        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_code_international() const { return code_international; }
        std::string & get_mutable_code_international() { return code_international; }
        void set_code_international(const std::string & value) { this->code_international = value; }

        const int64_t & get_fouls() const { return fouls; }
        int64_t & get_mutable_fouls() { return fouls; }
        void set_fouls(const int64_t & value) { this->fouls = value; }

        const int64_t & get_full_score() const { return full_score; }
        int64_t & get_mutable_full_score() { return full_score; }
        void set_full_score(const int64_t & value) { this->full_score = value; }

        const Lds & get_lds() const { return lds; }
        Lds & get_mutable_lds() { return lds; }
        void set_lds(const Lds & value) { this->lds = value; }

        const std::string & get_logo() const { return logo; }
        std::string & get_mutable_logo() { return logo; }
        void set_logo(const std::string & value) { this->logo = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_name_international() const { return name_international; }
        std::string & get_mutable_name_international() { return name_international; }
        void set_name_international(const std::string & value) { this->name_international = value; }

        const int64_t & get_p1_score() const { return p1_score; }
        int64_t & get_mutable_p1_score() { return p1_score; }
        void set_p1_score(const int64_t & value) { this->p1_score = value; }

        const int64_t & get_p2_score() const { return p2_score; }
        int64_t & get_mutable_p2_score() { return p2_score; }
        void set_p2_score(const int64_t & value) { this->p2_score = value; }

        const int64_t & get_p3_score() const { return p3_score; }
        int64_t & get_mutable_p3_score() { return p3_score; }
        void set_p3_score(const int64_t & value) { this->p3_score = value; }

        const int64_t & get_p4_score() const { return p4_score; }
        int64_t & get_mutable_p4_score() { return p4_score; }
        void set_p4_score(const int64_t & value) { this->p4_score = value; }

        const std::map<std::string, Pl> & get_pl() const { return pl; }
        std::map<std::string, Pl> & get_mutable_pl() { return pl; }
        void set_pl(const std::map<std::string, Pl> & value) { this->pl = value; }

        const int64_t & get_score() const { return score; }
        int64_t & get_mutable_score() { return score; }
        void set_score(const int64_t & value) { this->score = value; }

        const std::vector<Scorer> & get_scoring() const { return scoring; }
        std::vector<Scorer> & get_mutable_scoring() { return scoring; }
        void set_scoring(const std::vector<Scorer> & value) { this->scoring = value; }

        const std::string & get_short_name() const { return short_name; }
        std::string & get_mutable_short_name() { return short_name; }
        void set_short_name(const std::string & value) { this->short_name = value; }

        const std::string & get_short_name_international() const { return short_name_international; }
        std::string & get_mutable_short_name_international() { return short_name_international; }
        void set_short_name_international(const std::string & value) { this->short_name_international = value; }

        const std::vector<Shot> & get_shot() const { return shot; }
        std::vector<Shot> & get_mutable_shot() { return shot; }
        void set_shot(const std::vector<Shot> & value) { this->shot = value; }

        const int64_t & get_timeouts() const { return timeouts; }
        int64_t & get_mutable_timeouts() { return timeouts; }
        void set_timeouts(const int64_t & value) { this->timeouts = value; }

        const int64_t & get_tot_eff_1() const { return tot_eff_1; }
        int64_t & get_mutable_tot_eff_1() { return tot_eff_1; }
        void set_tot_eff_1(const int64_t & value) { this->tot_eff_1 = value; }

        const int64_t & get_tot_eff_2() const { return tot_eff_2; }
        int64_t & get_mutable_tot_eff_2() { return tot_eff_2; }
        void set_tot_eff_2(const int64_t & value) { this->tot_eff_2 = value; }

        const double & get_tot_eff_3() const { return tot_eff_3; }
        double & get_mutable_tot_eff_3() { return tot_eff_3; }
        void set_tot_eff_3(const double & value) { this->tot_eff_3 = value; }

        const int64_t & get_tot_eff_4() const { return tot_eff_4; }
        int64_t & get_mutable_tot_eff_4() { return tot_eff_4; }
        void set_tot_eff_4(const int64_t & value) { this->tot_eff_4 = value; }

        const int64_t & get_tot_eff_5() const { return tot_eff_5; }
        int64_t & get_mutable_tot_eff_5() { return tot_eff_5; }
        void set_tot_eff_5(const int64_t & value) { this->tot_eff_5 = value; }

        const int64_t & get_tot_eff_6() const { return tot_eff_6; }
        int64_t & get_mutable_tot_eff_6() { return tot_eff_6; }
        void set_tot_eff_6(const int64_t & value) { this->tot_eff_6 = value; }

        const int64_t & get_tot_eff_7() const { return tot_eff_7; }
        int64_t & get_mutable_tot_eff_7() { return tot_eff_7; }
        void set_tot_eff_7(const int64_t & value) { this->tot_eff_7 = value; }

        const int64_t & get_tot_s_assists() const { return tot_s_assists; }
        int64_t & get_mutable_tot_s_assists() { return tot_s_assists; }
        void set_tot_s_assists(const int64_t & value) { this->tot_s_assists = value; }

        const int64_t & get_tot_s_bench_points() const { return tot_s_bench_points; }
        int64_t & get_mutable_tot_s_bench_points() { return tot_s_bench_points; }
        void set_tot_s_bench_points(const int64_t & value) { this->tot_s_bench_points = value; }

        const int64_t & get_tot_s_biggest_lead() const { return tot_s_biggest_lead; }
        int64_t & get_mutable_tot_s_biggest_lead() { return tot_s_biggest_lead; }
        void set_tot_s_biggest_lead(const int64_t & value) { this->tot_s_biggest_lead = value; }

        const int64_t & get_tot_s_biggest_scoring_run() const { return tot_s_biggest_scoring_run; }
        int64_t & get_mutable_tot_s_biggest_scoring_run() { return tot_s_biggest_scoring_run; }
        void set_tot_s_biggest_scoring_run(const int64_t & value) { this->tot_s_biggest_scoring_run = value; }

        const int64_t & get_tot_s_blocks() const { return tot_s_blocks; }
        int64_t & get_mutable_tot_s_blocks() { return tot_s_blocks; }
        void set_tot_s_blocks(const int64_t & value) { this->tot_s_blocks = value; }

        const int64_t & get_tot_s_blocks_received() const { return tot_s_blocks_received; }
        int64_t & get_mutable_tot_s_blocks_received() { return tot_s_blocks_received; }
        void set_tot_s_blocks_received(const int64_t & value) { this->tot_s_blocks_received = value; }

        const int64_t & get_tot_s_field_goals_attempted() const { return tot_s_field_goals_attempted; }
        int64_t & get_mutable_tot_s_field_goals_attempted() { return tot_s_field_goals_attempted; }
        void set_tot_s_field_goals_attempted(const int64_t & value) { this->tot_s_field_goals_attempted = value; }

        const int64_t & get_tot_s_field_goals_made() const { return tot_s_field_goals_made; }
        int64_t & get_mutable_tot_s_field_goals_made() { return tot_s_field_goals_made; }
        void set_tot_s_field_goals_made(const int64_t & value) { this->tot_s_field_goals_made = value; }

        const int64_t & get_tot_s_field_goals_percentage() const { return tot_s_field_goals_percentage; }
        int64_t & get_mutable_tot_s_field_goals_percentage() { return tot_s_field_goals_percentage; }
        void set_tot_s_field_goals_percentage(const int64_t & value) { this->tot_s_field_goals_percentage = value; }

        const int64_t & get_tot_s_fouls_on() const { return tot_s_fouls_on; }
        int64_t & get_mutable_tot_s_fouls_on() { return tot_s_fouls_on; }
        void set_tot_s_fouls_on(const int64_t & value) { this->tot_s_fouls_on = value; }

        const int64_t & get_tot_s_fouls_personal() const { return tot_s_fouls_personal; }
        int64_t & get_mutable_tot_s_fouls_personal() { return tot_s_fouls_personal; }
        void set_tot_s_fouls_personal(const int64_t & value) { this->tot_s_fouls_personal = value; }

        const int64_t & get_tot_s_fouls_team() const { return tot_s_fouls_team; }
        int64_t & get_mutable_tot_s_fouls_team() { return tot_s_fouls_team; }
        void set_tot_s_fouls_team(const int64_t & value) { this->tot_s_fouls_team = value; }

        const int64_t & get_tot_s_free_throws_attempted() const { return tot_s_free_throws_attempted; }
        int64_t & get_mutable_tot_s_free_throws_attempted() { return tot_s_free_throws_attempted; }
        void set_tot_s_free_throws_attempted(const int64_t & value) { this->tot_s_free_throws_attempted = value; }

        const int64_t & get_tot_s_free_throws_made() const { return tot_s_free_throws_made; }
        int64_t & get_mutable_tot_s_free_throws_made() { return tot_s_free_throws_made; }
        void set_tot_s_free_throws_made(const int64_t & value) { this->tot_s_free_throws_made = value; }

        const int64_t & get_tot_s_free_throws_percentage() const { return tot_s_free_throws_percentage; }
        int64_t & get_mutable_tot_s_free_throws_percentage() { return tot_s_free_throws_percentage; }
        void set_tot_s_free_throws_percentage(const int64_t & value) { this->tot_s_free_throws_percentage = value; }

        const int64_t & get_tot_s_lead_changes() const { return tot_s_lead_changes; }
        int64_t & get_mutable_tot_s_lead_changes() { return tot_s_lead_changes; }
        void set_tot_s_lead_changes(const int64_t & value) { this->tot_s_lead_changes = value; }

        const int64_t & get_tot_s_minutes() const { return tot_s_minutes; }
        int64_t & get_mutable_tot_s_minutes() { return tot_s_minutes; }
        void set_tot_s_minutes(const int64_t & value) { this->tot_s_minutes = value; }

        const int64_t & get_tot_s_points() const { return tot_s_points; }
        int64_t & get_mutable_tot_s_points() { return tot_s_points; }
        void set_tot_s_points(const int64_t & value) { this->tot_s_points = value; }

        const int64_t & get_tot_s_points_fast_break() const { return tot_s_points_fast_break; }
        int64_t & get_mutable_tot_s_points_fast_break() { return tot_s_points_fast_break; }
        void set_tot_s_points_fast_break(const int64_t & value) { this->tot_s_points_fast_break = value; }

        const int64_t & get_tot_s_points_from_turnovers() const { return tot_s_points_from_turnovers; }
        int64_t & get_mutable_tot_s_points_from_turnovers() { return tot_s_points_from_turnovers; }
        void set_tot_s_points_from_turnovers(const int64_t & value) { this->tot_s_points_from_turnovers = value; }

        const int64_t & get_tot_s_points_in_the_paint() const { return tot_s_points_in_the_paint; }
        int64_t & get_mutable_tot_s_points_in_the_paint() { return tot_s_points_in_the_paint; }
        void set_tot_s_points_in_the_paint(const int64_t & value) { this->tot_s_points_in_the_paint = value; }

        const int64_t & get_tot_s_points_second_chance() const { return tot_s_points_second_chance; }
        int64_t & get_mutable_tot_s_points_second_chance() { return tot_s_points_second_chance; }
        void set_tot_s_points_second_chance(const int64_t & value) { this->tot_s_points_second_chance = value; }

        const int64_t & get_tot_s_rebounds_defensive() const { return tot_s_rebounds_defensive; }
        int64_t & get_mutable_tot_s_rebounds_defensive() { return tot_s_rebounds_defensive; }
        void set_tot_s_rebounds_defensive(const int64_t & value) { this->tot_s_rebounds_defensive = value; }

        const int64_t & get_tot_s_rebounds_offensive() const { return tot_s_rebounds_offensive; }
        int64_t & get_mutable_tot_s_rebounds_offensive() { return tot_s_rebounds_offensive; }
        void set_tot_s_rebounds_offensive(const int64_t & value) { this->tot_s_rebounds_offensive = value; }

        const int64_t & get_tot_s_rebounds_team() const { return tot_s_rebounds_team; }
        int64_t & get_mutable_tot_s_rebounds_team() { return tot_s_rebounds_team; }
        void set_tot_s_rebounds_team(const int64_t & value) { this->tot_s_rebounds_team = value; }

        const int64_t & get_tot_s_rebounds_team_defensive() const { return tot_s_rebounds_team_defensive; }
        int64_t & get_mutable_tot_s_rebounds_team_defensive() { return tot_s_rebounds_team_defensive; }
        void set_tot_s_rebounds_team_defensive(const int64_t & value) { this->tot_s_rebounds_team_defensive = value; }

        const int64_t & get_tot_s_rebounds_team_offensive() const { return tot_s_rebounds_team_offensive; }
        int64_t & get_mutable_tot_s_rebounds_team_offensive() { return tot_s_rebounds_team_offensive; }
        void set_tot_s_rebounds_team_offensive(const int64_t & value) { this->tot_s_rebounds_team_offensive = value; }

        const int64_t & get_tot_s_rebounds_total() const { return tot_s_rebounds_total; }
        int64_t & get_mutable_tot_s_rebounds_total() { return tot_s_rebounds_total; }
        void set_tot_s_rebounds_total(const int64_t & value) { this->tot_s_rebounds_total = value; }

        const int64_t & get_tot_s_steals() const { return tot_s_steals; }
        int64_t & get_mutable_tot_s_steals() { return tot_s_steals; }
        void set_tot_s_steals(const int64_t & value) { this->tot_s_steals = value; }

        const int64_t & get_tot_s_three_pointers_attempted() const { return tot_s_three_pointers_attempted; }
        int64_t & get_mutable_tot_s_three_pointers_attempted() { return tot_s_three_pointers_attempted; }
        void set_tot_s_three_pointers_attempted(const int64_t & value) { this->tot_s_three_pointers_attempted = value; }

        const int64_t & get_tot_s_three_pointers_made() const { return tot_s_three_pointers_made; }
        int64_t & get_mutable_tot_s_three_pointers_made() { return tot_s_three_pointers_made; }
        void set_tot_s_three_pointers_made(const int64_t & value) { this->tot_s_three_pointers_made = value; }

        const int64_t & get_tot_s_three_pointers_percentage() const { return tot_s_three_pointers_percentage; }
        int64_t & get_mutable_tot_s_three_pointers_percentage() { return tot_s_three_pointers_percentage; }
        void set_tot_s_three_pointers_percentage(const int64_t & value) { this->tot_s_three_pointers_percentage = value; }

        const double & get_tot_s_time_leading() const { return tot_s_time_leading; }
        double & get_mutable_tot_s_time_leading() { return tot_s_time_leading; }
        void set_tot_s_time_leading(const double & value) { this->tot_s_time_leading = value; }

        const int64_t & get_tot_s_times_scores_level() const { return tot_s_times_scores_level; }
        int64_t & get_mutable_tot_s_times_scores_level() { return tot_s_times_scores_level; }
        void set_tot_s_times_scores_level(const int64_t & value) { this->tot_s_times_scores_level = value; }

        const int64_t & get_tot_s_turnovers() const { return tot_s_turnovers; }
        int64_t & get_mutable_tot_s_turnovers() { return tot_s_turnovers; }
        void set_tot_s_turnovers(const int64_t & value) { this->tot_s_turnovers = value; }

        const int64_t & get_tot_s_turnovers_team() const { return tot_s_turnovers_team; }
        int64_t & get_mutable_tot_s_turnovers_team() { return tot_s_turnovers_team; }
        void set_tot_s_turnovers_team(const int64_t & value) { this->tot_s_turnovers_team = value; }

        const int64_t & get_tot_s_two_pointers_attempted() const { return tot_s_two_pointers_attempted; }
        int64_t & get_mutable_tot_s_two_pointers_attempted() { return tot_s_two_pointers_attempted; }
        void set_tot_s_two_pointers_attempted(const int64_t & value) { this->tot_s_two_pointers_attempted = value; }

        const int64_t & get_tot_s_two_pointers_made() const { return tot_s_two_pointers_made; }
        int64_t & get_mutable_tot_s_two_pointers_made() { return tot_s_two_pointers_made; }
        void set_tot_s_two_pointers_made(const int64_t & value) { this->tot_s_two_pointers_made = value; }

        const int64_t & get_tot_s_two_pointers_percentage() const { return tot_s_two_pointers_percentage; }
        int64_t & get_mutable_tot_s_two_pointers_percentage() { return tot_s_two_pointers_percentage; }
        void set_tot_s_two_pointers_percentage(const int64_t & value) { this->tot_s_two_pointers_percentage = value; }
    };

    class Totallds {
        public:
        Totallds() = default;
        virtual ~Totallds() = default;

        private:
        std::map<std::string, Scorer> s_assists;
        std::map<std::string, Scorer> s_blocks;
        std::map<std::string, Scorer> s_points;
        std::map<std::string, Scorer> s_rebounds_total;
        std::map<std::string, Scorer> s_steals;

        public:
        const std::map<std::string, Scorer> & get_s_assists() const { return s_assists; }
        std::map<std::string, Scorer> & get_mutable_s_assists() { return s_assists; }
        void set_s_assists(const std::map<std::string, Scorer> & value) { this->s_assists = value; }

        const std::map<std::string, Scorer> & get_s_blocks() const { return s_blocks; }
        std::map<std::string, Scorer> & get_mutable_s_blocks() { return s_blocks; }
        void set_s_blocks(const std::map<std::string, Scorer> & value) { this->s_blocks = value; }

        const std::map<std::string, Scorer> & get_s_points() const { return s_points; }
        std::map<std::string, Scorer> & get_mutable_s_points() { return s_points; }
        void set_s_points(const std::map<std::string, Scorer> & value) { this->s_points = value; }

        const std::map<std::string, Scorer> & get_s_rebounds_total() const { return s_rebounds_total; }
        std::map<std::string, Scorer> & get_mutable_s_rebounds_total() { return s_rebounds_total; }
        void set_s_rebounds_total(const std::map<std::string, Scorer> & value) { this->s_rebounds_total = value; }

        const std::map<std::string, Scorer> & get_s_steals() const { return s_steals; }
        std::map<std::string, Scorer> & get_mutable_s_steals() { return s_steals; }
        void set_s_steals(const std::map<std::string, Scorer> & value) { this->s_steals = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        int64_t attendance;
        std::string clock;
        int64_t disable_match;
        int64_t in_ot;
        std::vector<std::vector<LeaddatumElement>> leaddata;
        std::string officials_referee1;
        std::string officials_referee2;
        std::string officials_referee3;
        std::vector<Othermatch> othermatches;
        std::vector<Pbp> pbp;
        int64_t period;
        int64_t period_length_overtime;
        int64_t period_length_regular;
        PerType period_type;
        int64_t periods_max;
        std::map<std::string, std::vector<Scorer>> scorers;
        std::vector<nlohmann::json> timeline;
        std::map<std::string, Tm> tm;
        int64_t total_time_added;
        Totallds totallds;

        public:
        const int64_t & get_attendance() const { return attendance; }
        int64_t & get_mutable_attendance() { return attendance; }
        void set_attendance(const int64_t & value) { this->attendance = value; }

        const std::string & get_clock() const { return clock; }
        std::string & get_mutable_clock() { return clock; }
        void set_clock(const std::string & value) { this->clock = value; }

        const int64_t & get_disable_match() const { return disable_match; }
        int64_t & get_mutable_disable_match() { return disable_match; }
        void set_disable_match(const int64_t & value) { this->disable_match = value; }

        const int64_t & get_in_ot() const { return in_ot; }
        int64_t & get_mutable_in_ot() { return in_ot; }
        void set_in_ot(const int64_t & value) { this->in_ot = value; }

        const std::vector<std::vector<LeaddatumElement>> & get_leaddata() const { return leaddata; }
        std::vector<std::vector<LeaddatumElement>> & get_mutable_leaddata() { return leaddata; }
        void set_leaddata(const std::vector<std::vector<LeaddatumElement>> & value) { this->leaddata = value; }

        const std::string & get_officials_referee1() const { return officials_referee1; }
        std::string & get_mutable_officials_referee1() { return officials_referee1; }
        void set_officials_referee1(const std::string & value) { this->officials_referee1 = value; }

        const std::string & get_officials_referee2() const { return officials_referee2; }
        std::string & get_mutable_officials_referee2() { return officials_referee2; }
        void set_officials_referee2(const std::string & value) { this->officials_referee2 = value; }

        const std::string & get_officials_referee3() const { return officials_referee3; }
        std::string & get_mutable_officials_referee3() { return officials_referee3; }
        void set_officials_referee3(const std::string & value) { this->officials_referee3 = value; }

        const std::vector<Othermatch> & get_othermatches() const { return othermatches; }
        std::vector<Othermatch> & get_mutable_othermatches() { return othermatches; }
        void set_othermatches(const std::vector<Othermatch> & value) { this->othermatches = value; }

        const std::vector<Pbp> & get_pbp() const { return pbp; }
        std::vector<Pbp> & get_mutable_pbp() { return pbp; }
        void set_pbp(const std::vector<Pbp> & value) { this->pbp = value; }

        const int64_t & get_period() const { return period; }
        int64_t & get_mutable_period() { return period; }
        void set_period(const int64_t & value) { this->period = value; }

        const int64_t & get_period_length_overtime() const { return period_length_overtime; }
        int64_t & get_mutable_period_length_overtime() { return period_length_overtime; }
        void set_period_length_overtime(const int64_t & value) { this->period_length_overtime = value; }

        const int64_t & get_period_length_regular() const { return period_length_regular; }
        int64_t & get_mutable_period_length_regular() { return period_length_regular; }
        void set_period_length_regular(const int64_t & value) { this->period_length_regular = value; }

        const PerType & get_period_type() const { return period_type; }
        PerType & get_mutable_period_type() { return period_type; }
        void set_period_type(const PerType & value) { this->period_type = value; }

        const int64_t & get_periods_max() const { return periods_max; }
        int64_t & get_mutable_periods_max() { return periods_max; }
        void set_periods_max(const int64_t & value) { this->periods_max = value; }

        const std::map<std::string, std::vector<Scorer>> & get_scorers() const { return scorers; }
        std::map<std::string, std::vector<Scorer>> & get_mutable_scorers() { return scorers; }
        void set_scorers(const std::map<std::string, std::vector<Scorer>> & value) { this->scorers = value; }

        const std::vector<nlohmann::json> & get_timeline() const { return timeline; }
        std::vector<nlohmann::json> & get_mutable_timeline() { return timeline; }
        void set_timeline(const std::vector<nlohmann::json> & value) { this->timeline = value; }

        const std::map<std::string, Tm> & get_tm() const { return tm; }
        std::map<std::string, Tm> & get_mutable_tm() { return tm; }
        void set_tm(const std::map<std::string, Tm> & value) { this->tm = value; }

        const int64_t & get_total_time_added() const { return total_time_added; }
        int64_t & get_mutable_total_time_added() { return total_time_added; }
        void set_total_time_added(const int64_t & value) { this->total_time_added = value; }

        const Totallds & get_totallds() const { return totallds; }
        Totallds & get_mutable_totallds() { return totallds; }
        void set_totallds(const Totallds & value) { this->totallds = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Team & x);
void to_json(json & j, const Team & x);

void from_json(const json & j, Othermatch & x);
void to_json(json & j, const Othermatch & x);

void from_json(const json & j, Pbp & x);
void to_json(json & j, const Pbp & x);

void from_json(const json & j, Time & x);
void to_json(json & j, const Time & x);

void from_json(const json & j, Scorer & x);
void to_json(json & j, const Scorer & x);

void from_json(const json & j, SBlocks & x);
void to_json(json & j, const SBlocks & x);

void from_json(const json & j, Lds & x);
void to_json(json & j, const Lds & x);

void from_json(const json & j, Comp & x);
void to_json(json & j, const Comp & x);

void from_json(const json & j, Pl & x);
void to_json(json & j, const Pl & x);

void from_json(const json & j, Shot & x);
void to_json(json & j, const Shot & x);

void from_json(const json & j, Tm & x);
void to_json(json & j, const Tm & x);

void from_json(const json & j, Totallds & x);
void to_json(json & j, const Totallds & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, LeaddatumEnum & x);
void to_json(json & j, const LeaddatumEnum & x);

void from_json(const json & j, PerType & x);
void to_json(json & j, const PerType & x);

void from_json(const json & j, ActionType & x);
void to_json(json & j, const ActionType & x);

void from_json(const json & j, FamilyNameInitial & x);
void to_json(json & j, const FamilyNameInitial & x);

void from_json(const json & j, FirstNameInitial & x);
void to_json(json & j, const FirstNameInitial & x);

void from_json(const json & j, ScoreboardName & x);
void to_json(json & j, const ScoreboardName & x);

void from_json(const json & j, SubType & x);
void to_json(json & j, const SubType & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::LeaddatumEnum, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::LeaddatumEnum, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::LeaddatumEnum, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(const json & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Team& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_team_code(j.at("teamCode").get<std::string>());
        x.set_team_code_international(j.at("teamCodeInternational").get<std::string>());
        x.set_team_name(j.at("teamName").get<std::string>());
        x.set_team_name_international(j.at("teamNameInternational").get<std::string>());
    }

    inline void to_json(json & j, const Team & x) {
        j = json::object();
        j["teamCode"] = x.get_team_code();
        j["teamCodeInternational"] = x.get_team_code_international();
        j["teamName"] = x.get_team_name();
        j["teamNameInternational"] = x.get_team_name_international();
    }

    inline void from_json(const json & j, Othermatch& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_clock(j.at("clock").get<std::string>());
        x.set_competition_name(j.at("competitionName").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        if (j.find("period") != j.end() && !j.at("period").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_period(j.at("period").get<int64_t>());
        x.set_period_type(j.at("periodType").get<PerType>());
        x.set_team1(j.at("team1").get<Team>());
        x.set_team1_name(j.at("team1Name").get<std::string>());
        if (j.find("team1Score") != j.end() && !j.at("team1Score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_team1_score(j.at("team1Score").get<int64_t>());
        x.set_team2(j.at("team2").get<Team>());
        x.set_team2_name(j.at("team2Name").get<std::string>());
        if (j.find("team2Score") != j.end() && !j.at("team2Score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_team2_score(j.at("team2Score").get<int64_t>());
    }

    inline void to_json(json & j, const Othermatch & x) {
        j = json::object();
        j["clock"] = x.get_clock();
        j["competitionName"] = x.get_competition_name();
        j["id"] = x.get_id();
        j["period"] = x.get_period();
        j["periodType"] = x.get_period_type();
        j["team1"] = x.get_team1();
        j["team1Name"] = x.get_team1_name();
        j["team1Score"] = x.get_team1_score();
        j["team2"] = x.get_team2();
        j["team2Name"] = x.get_team2_name();
        j["team2Score"] = x.get_team2_score();
    }

    inline void from_json(const json & j, Pbp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_action_type(j.at("actionType").get<ActionType>());
        if (j.find("familyName") != j.end() && j.at("familyName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_family_name(get_stack_optional<std::string>(j, "familyName"));
        if (j.find("familyNameInitial") != j.end() && j.at("familyNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_family_name_initial(get_stack_optional<FamilyNameInitial>(j, "familyNameInitial"));
        if (j.find("firstName") != j.end() && j.at("firstName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_first_name(get_stack_optional<std::string>(j, "firstName"));
        if (j.find("firstNameInitial") != j.end() && j.at("firstNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_first_name_initial(get_stack_optional<FirstNameInitial>(j, "firstNameInitial"));
        x.set_gt(j.at("gt").get<std::string>());
        if (j.find("internationalFamilyName") != j.end() && j.at("internationalFamilyName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_family_name(get_stack_optional<std::string>(j, "internationalFamilyName"));
        if (j.find("internationalFamilyNameInitial") != j.end() && j.at("internationalFamilyNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_family_name_initial(get_stack_optional<FamilyNameInitial>(j, "internationalFamilyNameInitial"));
        if (j.find("internationalFirstName") != j.end() && j.at("internationalFirstName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_first_name(get_stack_optional<std::string>(j, "internationalFirstName"));
        if (j.find("internationalFirstNameInitial") != j.end() && j.at("internationalFirstNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_first_name_initial(get_stack_optional<FirstNameInitial>(j, "internationalFirstNameInitial"));
        if (j.find("lead") != j.end() && !j.at("lead").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_lead(j.at("lead").get<int64_t>());
        if (j.find("period") != j.end() && !j.at("period").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_period(j.at("period").get<int64_t>());
        x.set_period_type(j.at("periodType").get<PerType>());
        x.set_player(j.at("player").get<std::string>());
        if (j.find("pno") != j.end() && !j.at("pno").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_pno(j.at("pno").get<int64_t>());
        x.set_qualifier(j.at("qualifier").get<std::string>());
        if (j.find("s1") != j.end() && !j.at("s1").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s1(j.at("s1").get<int64_t>());
        if (j.find("s2") != j.end() && !j.at("s2").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s2(j.at("s2").get<int64_t>());
        if (j.find("scoreboardName") != j.end() && j.at("scoreboardName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scoreboard_name(get_stack_optional<ScoreboardName>(j, "scoreboardName"));
        if (j.find("scoring") != j.end() && !j.at("scoring").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_scoring(j.at("scoring").get<int64_t>());
        x.set_shirt_number(j.at("shirtNumber").get<std::string>());
        x.set_sub_type(j.at("subType").get<std::string>());
        if (j.find("success") != j.end() && !j.at("success").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_success(j.at("success").get<int64_t>());
        if (j.find("tno") != j.end() && !j.at("tno").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tno(j.at("tno").get<int64_t>());
    }

    inline void to_json(json & j, const Pbp & x) {
        j = json::object();
        j["actionType"] = x.get_action_type();
        j["familyName"] = x.get_family_name();
        j["familyNameInitial"] = x.get_family_name_initial();
        j["firstName"] = x.get_first_name();
        j["firstNameInitial"] = x.get_first_name_initial();
        j["gt"] = x.get_gt();
        j["internationalFamilyName"] = x.get_international_family_name();
        j["internationalFamilyNameInitial"] = x.get_international_family_name_initial();
        j["internationalFirstName"] = x.get_international_first_name();
        j["internationalFirstNameInitial"] = x.get_international_first_name_initial();
        j["lead"] = x.get_lead();
        j["period"] = x.get_period();
        j["periodType"] = x.get_period_type();
        j["player"] = x.get_player();
        j["pno"] = x.get_pno();
        j["qualifier"] = x.get_qualifier();
        j["s1"] = x.get_s1();
        j["s2"] = x.get_s2();
        j["scoreboardName"] = x.get_scoreboard_name();
        j["scoring"] = x.get_scoring();
        j["shirtNumber"] = x.get_shirt_number();
        j["subType"] = x.get_sub_type();
        j["success"] = x.get_success();
        j["tno"] = x.get_tno();
    }

    inline void from_json(const json & j, Time& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_gt(j.at("gt").get<std::string>());
        if (j.find("per") != j.end() && !j.at("per").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_per(j.at("per").get<int64_t>());
        x.set_per_type(j.at("perType").get<PerType>());
    }

    inline void to_json(json & j, const Time & x) {
        j = json::object();
        j["gt"] = x.get_gt();
        j["per"] = x.get_per();
        j["perType"] = x.get_per_type();
    }

    inline void from_json(const json & j, Scorer& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("familyName") != j.end() && j.at("familyName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_family_name(get_stack_optional<std::string>(j, "familyName"));
        if (j.find("familyNameInitial") != j.end() && j.at("familyNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_family_name_initial(get_stack_optional<FamilyNameInitial>(j, "familyNameInitial"));
        if (j.find("firstName") != j.end() && j.at("firstName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_first_name(get_stack_optional<std::string>(j, "firstName"));
        if (j.find("firstNameInitial") != j.end() && j.at("firstNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_first_name_initial(get_stack_optional<FirstNameInitial>(j, "firstNameInitial"));
        if (j.find("gt") != j.end() && j.at("gt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gt(get_stack_optional<std::string>(j, "gt"));
        if (j.find("internationalFamilyName") != j.end() && j.at("internationalFamilyName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_family_name(get_stack_optional<std::string>(j, "internationalFamilyName"));
        if (j.find("internationalFamilyNameInitial") != j.end() && j.at("internationalFamilyNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_family_name_initial(get_stack_optional<FamilyNameInitial>(j, "internationalFamilyNameInitial"));
        if (j.find("internationalFirstName") != j.end() && j.at("internationalFirstName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_first_name(get_stack_optional<std::string>(j, "internationalFirstName"));
        if (j.find("internationalFirstNameInitial") != j.end() && j.at("internationalFirstNameInitial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_international_first_name_initial(get_stack_optional<FirstNameInitial>(j, "internationalFirstNameInitial"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        if (j.find("per") != j.end() && !j.at("per").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("per") != j.end() && j.at("per").is_null()) throw std::runtime_error("Unexpected null");
        x.set_per(get_stack_optional<int64_t>(j, "per"));
        if (j.find("perType") != j.end() && j.at("perType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_per_type(get_stack_optional<PerType>(j, "perType"));
        if (j.find("player") != j.end() && j.at("player").is_null()) throw std::runtime_error("Unexpected null");
        x.set_player(get_stack_optional<std::string>(j, "player"));
        if (j.find("pno") != j.end() && !j.at("pno").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_pno(j.at("pno").get<int64_t>());
        if (j.find("scoreboardName") != j.end() && j.at("scoreboardName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scoreboard_name(get_stack_optional<ScoreboardName>(j, "scoreboardName"));
        x.set_shirt_number(j.at("shirtNumber").get<std::string>());
        if (j.find("summary") != j.end() && j.at("summary").is_null()) throw std::runtime_error("Unexpected null");
        x.set_summary(get_stack_optional<std::string>(j, "summary"));
        if (j.find("times") != j.end() && j.at("times").is_null()) throw std::runtime_error("Unexpected null");
        x.set_times(get_stack_optional<std::vector<Time>>(j, "times"));
        if (j.find("tno") != j.end() && !j.at("tno").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tno(j.at("tno").get<int64_t>());
        if (j.find("tot") != j.end() && !j.at("tot").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tot") != j.end() && j.at("tot").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tot(get_stack_optional<int64_t>(j, "tot"));
    }

    inline void to_json(json & j, const Scorer & x) {
        j = json::object();
        j["familyName"] = x.get_family_name();
        j["familyNameInitial"] = x.get_family_name_initial();
        j["firstName"] = x.get_first_name();
        j["firstNameInitial"] = x.get_first_name_initial();
        j["gt"] = x.get_gt();
        j["internationalFamilyName"] = x.get_international_family_name();
        j["internationalFamilyNameInitial"] = x.get_international_family_name_initial();
        j["internationalFirstName"] = x.get_international_first_name();
        j["internationalFirstNameInitial"] = x.get_international_first_name_initial();
        j["name"] = x.get_name();
        j["per"] = x.get_per();
        j["perType"] = x.get_per_type();
        j["player"] = x.get_player();
        j["pno"] = x.get_pno();
        j["scoreboardName"] = x.get_scoreboard_name();
        j["shirtNumber"] = x.get_shirt_number();
        j["summary"] = x.get_summary();
        j["times"] = x.get_times();
        j["tno"] = x.get_tno();
        j["tot"] = x.get_tot();
    }

    inline void from_json(const json & j, SBlocks& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_the_1(j.at("1").get<Scorer>());
    }

    inline void to_json(json & j, const SBlocks & x) {
        j = json::object();
        j["1"] = x.get_the_1();
    }

    inline void from_json(const json & j, Lds& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_s_assists(j.at("sAssists").get<std::map<std::string, Scorer>>());
        x.set_s_blocks(j.at("sBlocks").get<SBlocks>());
        x.set_s_points(j.at("sPoints").get<std::map<std::string, Scorer>>());
        x.set_s_rebounds_total(j.at("sReboundsTotal").get<std::map<std::string, Scorer>>());
        x.set_s_steals(j.at("sSteals").get<std::map<std::string, Scorer>>());
    }

    inline void to_json(json & j, const Lds & x) {
        j = json::object();
        j["sAssists"] = x.get_s_assists();
        j["sBlocks"] = x.get_s_blocks();
        j["sPoints"] = x.get_s_points();
        j["sReboundsTotal"] = x.get_s_rebounds_total();
        j["sSteals"] = x.get_s_steals();
    }

    inline void from_json(const json & j, Comp& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_s_assists_average(j.at("sAssistsAverage").get<double>());
        x.set_s_minutes_average(j.at("sMinutesAverage").get<std::string>());
        x.set_s_points_average(j.at("sPointsAverage").get<double>());
        x.set_s_rebounds_total_average(j.at("sReboundsTotalAverage").get<double>());
    }

    inline void to_json(json & j, const Comp & x) {
        j = json::object();
        j["sAssistsAverage"] = x.get_s_assists_average();
        j["sMinutesAverage"] = x.get_s_minutes_average();
        j["sPointsAverage"] = x.get_s_points_average();
        j["sReboundsTotalAverage"] = x.get_s_rebounds_total_average();
    }

    inline void from_json(const json & j, Pl& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("active") != j.end() && !j.at("active").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_active(j.at("active").get<int64_t>());
        if (j.find("captain") != j.end() && !j.at("captain").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("captain") != j.end() && j.at("captain").is_null()) throw std::runtime_error("Unexpected null");
        x.set_captain(get_stack_optional<int64_t>(j, "captain"));
        if (j.find("comp") != j.end() && j.at("comp").is_null()) throw std::runtime_error("Unexpected null");
        x.set_comp(get_stack_optional<Comp>(j, "comp"));
        if (j.find("eff_1") != j.end() && !j.at("eff_1").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_eff_1(j.at("eff_1").get<int64_t>());
        if (j.find("eff_2") != j.end() && !j.at("eff_2").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_eff_2(j.at("eff_2").get<int64_t>());
        x.set_eff_3(j.at("eff_3").get<double>());
        x.set_eff_4(j.at("eff_4").get<double>());
        if (j.find("eff_5") != j.end() && !j.at("eff_5").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_eff_5(j.at("eff_5").get<int64_t>());
        if (j.find("eff_6") != j.end() && !j.at("eff_6").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_eff_6(j.at("eff_6").get<int64_t>());
        if (j.find("eff_7") != j.end() && !j.at("eff_7").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_eff_7(j.at("eff_7").get<int64_t>());
        x.set_family_name(j.at("familyName").get<std::string>());
        x.set_family_name_initial(j.at("familyNameInitial").get<FamilyNameInitial>());
        x.set_first_name(j.at("firstName").get<std::string>());
        x.set_first_name_initial(j.at("firstNameInitial").get<FirstNameInitial>());
        x.set_international_family_name(j.at("internationalFamilyName").get<std::string>());
        x.set_international_family_name_initial(j.at("internationalFamilyNameInitial").get<FamilyNameInitial>());
        x.set_international_first_name(j.at("internationalFirstName").get<std::string>());
        x.set_international_first_name_initial(j.at("internationalFirstNameInitial").get<FirstNameInitial>());
        x.set_name(j.at("name").get<std::string>());
        x.set_playing_position(j.at("playingPosition").get<std::string>());
        if (j.find("sAssists") != j.end() && !j.at("sAssists").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_assists(j.at("sAssists").get<int64_t>());
        if (j.find("sBlocks") != j.end() && !j.at("sBlocks").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_blocks(j.at("sBlocks").get<int64_t>());
        if (j.find("sBlocksReceived") != j.end() && !j.at("sBlocksReceived").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_blocks_received(j.at("sBlocksReceived").get<int64_t>());
        if (j.find("sFieldGoalsAttempted") != j.end() && !j.at("sFieldGoalsAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_field_goals_attempted(j.at("sFieldGoalsAttempted").get<int64_t>());
        if (j.find("sFieldGoalsMade") != j.end() && !j.at("sFieldGoalsMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_field_goals_made(j.at("sFieldGoalsMade").get<int64_t>());
        if (j.find("sFieldGoalsPercentage") != j.end() && !j.at("sFieldGoalsPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_field_goals_percentage(j.at("sFieldGoalsPercentage").get<int64_t>());
        if (j.find("sFoulsOn") != j.end() && !j.at("sFoulsOn").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_fouls_on(j.at("sFoulsOn").get<int64_t>());
        if (j.find("sFoulsPersonal") != j.end() && !j.at("sFoulsPersonal").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_fouls_personal(j.at("sFoulsPersonal").get<int64_t>());
        if (j.find("sFreeThrowsAttempted") != j.end() && !j.at("sFreeThrowsAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_free_throws_attempted(j.at("sFreeThrowsAttempted").get<int64_t>());
        if (j.find("sFreeThrowsMade") != j.end() && !j.at("sFreeThrowsMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_free_throws_made(j.at("sFreeThrowsMade").get<int64_t>());
        if (j.find("sFreeThrowsPercentage") != j.end() && !j.at("sFreeThrowsPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_free_throws_percentage(j.at("sFreeThrowsPercentage").get<int64_t>());
        x.set_s_minutes(j.at("sMinutes").get<SMinutes>());
        if (j.find("sPlusMinusPoints") != j.end() && !j.at("sPlusMinusPoints").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_plus_minus_points(j.at("sPlusMinusPoints").get<int64_t>());
        if (j.find("sPoints") != j.end() && !j.at("sPoints").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_points(j.at("sPoints").get<int64_t>());
        if (j.find("sPointsFastBreak") != j.end() && !j.at("sPointsFastBreak").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_points_fast_break(j.at("sPointsFastBreak").get<int64_t>());
        if (j.find("sPointsInThePaint") != j.end() && !j.at("sPointsInThePaint").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_points_in_the_paint(j.at("sPointsInThePaint").get<int64_t>());
        if (j.find("sPointsSecondChance") != j.end() && !j.at("sPointsSecondChance").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_points_second_chance(j.at("sPointsSecondChance").get<int64_t>());
        if (j.find("sReboundsDefensive") != j.end() && !j.at("sReboundsDefensive").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_rebounds_defensive(j.at("sReboundsDefensive").get<int64_t>());
        if (j.find("sReboundsOffensive") != j.end() && !j.at("sReboundsOffensive").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_rebounds_offensive(j.at("sReboundsOffensive").get<int64_t>());
        if (j.find("sReboundsTotal") != j.end() && !j.at("sReboundsTotal").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_rebounds_total(j.at("sReboundsTotal").get<int64_t>());
        if (j.find("sSteals") != j.end() && !j.at("sSteals").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_steals(j.at("sSteals").get<int64_t>());
        if (j.find("sThreePointersAttempted") != j.end() && !j.at("sThreePointersAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_three_pointers_attempted(j.at("sThreePointersAttempted").get<int64_t>());
        if (j.find("sThreePointersMade") != j.end() && !j.at("sThreePointersMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_three_pointers_made(j.at("sThreePointersMade").get<int64_t>());
        if (j.find("sThreePointersPercentage") != j.end() && !j.at("sThreePointersPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_three_pointers_percentage(j.at("sThreePointersPercentage").get<int64_t>());
        if (j.find("sTurnovers") != j.end() && !j.at("sTurnovers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_turnovers(j.at("sTurnovers").get<int64_t>());
        if (j.find("sTwoPointersAttempted") != j.end() && !j.at("sTwoPointersAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_two_pointers_attempted(j.at("sTwoPointersAttempted").get<int64_t>());
        if (j.find("sTwoPointersMade") != j.end() && !j.at("sTwoPointersMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_two_pointers_made(j.at("sTwoPointersMade").get<int64_t>());
        if (j.find("sTwoPointersPercentage") != j.end() && !j.at("sTwoPointersPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_s_two_pointers_percentage(j.at("sTwoPointersPercentage").get<int64_t>());
        x.set_shirt_number(j.at("shirtNumber").get<std::string>());
        if (j.find("starter") != j.end() && !j.at("starter").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_starter(j.at("starter").get<int64_t>());
    }

    inline void to_json(json & j, const Pl & x) {
        j = json::object();
        j["active"] = x.get_active();
        j["captain"] = x.get_captain();
        j["comp"] = x.get_comp();
        j["eff_1"] = x.get_eff_1();
        j["eff_2"] = x.get_eff_2();
        j["eff_3"] = x.get_eff_3();
        j["eff_4"] = x.get_eff_4();
        j["eff_5"] = x.get_eff_5();
        j["eff_6"] = x.get_eff_6();
        j["eff_7"] = x.get_eff_7();
        j["familyName"] = x.get_family_name();
        j["familyNameInitial"] = x.get_family_name_initial();
        j["firstName"] = x.get_first_name();
        j["firstNameInitial"] = x.get_first_name_initial();
        j["internationalFamilyName"] = x.get_international_family_name();
        j["internationalFamilyNameInitial"] = x.get_international_family_name_initial();
        j["internationalFirstName"] = x.get_international_first_name();
        j["internationalFirstNameInitial"] = x.get_international_first_name_initial();
        j["name"] = x.get_name();
        j["playingPosition"] = x.get_playing_position();
        j["sAssists"] = x.get_s_assists();
        j["sBlocks"] = x.get_s_blocks();
        j["sBlocksReceived"] = x.get_s_blocks_received();
        j["sFieldGoalsAttempted"] = x.get_s_field_goals_attempted();
        j["sFieldGoalsMade"] = x.get_s_field_goals_made();
        j["sFieldGoalsPercentage"] = x.get_s_field_goals_percentage();
        j["sFoulsOn"] = x.get_s_fouls_on();
        j["sFoulsPersonal"] = x.get_s_fouls_personal();
        j["sFreeThrowsAttempted"] = x.get_s_free_throws_attempted();
        j["sFreeThrowsMade"] = x.get_s_free_throws_made();
        j["sFreeThrowsPercentage"] = x.get_s_free_throws_percentage();
        j["sMinutes"] = x.get_s_minutes();
        j["sPlusMinusPoints"] = x.get_s_plus_minus_points();
        j["sPoints"] = x.get_s_points();
        j["sPointsFastBreak"] = x.get_s_points_fast_break();
        j["sPointsInThePaint"] = x.get_s_points_in_the_paint();
        j["sPointsSecondChance"] = x.get_s_points_second_chance();
        j["sReboundsDefensive"] = x.get_s_rebounds_defensive();
        j["sReboundsOffensive"] = x.get_s_rebounds_offensive();
        j["sReboundsTotal"] = x.get_s_rebounds_total();
        j["sSteals"] = x.get_s_steals();
        j["sThreePointersAttempted"] = x.get_s_three_pointers_attempted();
        j["sThreePointersMade"] = x.get_s_three_pointers_made();
        j["sThreePointersPercentage"] = x.get_s_three_pointers_percentage();
        j["sTurnovers"] = x.get_s_turnovers();
        j["sTwoPointersAttempted"] = x.get_s_two_pointers_attempted();
        j["sTwoPointersMade"] = x.get_s_two_pointers_made();
        j["sTwoPointersPercentage"] = x.get_s_two_pointers_percentage();
        j["shirtNumber"] = x.get_shirt_number();
        j["starter"] = x.get_starter();
    }

    inline void from_json(const json & j, Shot& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_action_type(j.at("actionType").get<ActionType>());
        if (j.find("p") != j.end() && !j.at("p").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_p(j.at("p").get<int64_t>());
        if (j.find("per") != j.end() && !j.at("per").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_per(j.at("per").get<int64_t>());
        x.set_per_type(j.at("perType").get<PerType>());
        x.set_player(j.at("player").get<std::string>());
        if (j.find("pno") != j.end() && !j.at("pno").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_pno(j.at("pno").get<int64_t>());
        if (j.find("r") != j.end() && !j.at("r").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_r(j.at("r").get<int64_t>());
        x.set_shirt_number(j.at("shirtNumber").get<std::string>());
        x.set_sub_type(j.at("subType").get<SubType>());
        if (j.find("tno") != j.end() && !j.at("tno").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tno(j.at("tno").get<int64_t>());
        if (j.find("x") != j.end() && !j.at("x").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_x(j.at("x").get<int64_t>());
        if (j.find("y") != j.end() && !j.at("y").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_y(j.at("y").get<int64_t>());
    }

    inline void to_json(json & j, const Shot & x) {
        j = json::object();
        j["actionType"] = x.get_action_type();
        j["p"] = x.get_p();
        j["per"] = x.get_per();
        j["perType"] = x.get_per_type();
        j["player"] = x.get_player();
        j["pno"] = x.get_pno();
        j["r"] = x.get_r();
        j["shirtNumber"] = x.get_shirt_number();
        j["subType"] = x.get_sub_type();
        j["tno"] = x.get_tno();
        j["x"] = x.get_x();
        j["y"] = x.get_y();
    }

    inline void from_json(const json & j, Tm& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<std::string>());
        x.set_code_international(j.at("codeInternational").get<std::string>());
        if (j.find("fouls") != j.end() && !j.at("fouls").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_fouls(j.at("fouls").get<int64_t>());
        if (j.find("full_score") != j.end() && !j.at("full_score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_full_score(j.at("full_score").get<int64_t>());
        x.set_lds(j.at("lds").get<Lds>());
        x.set_logo(j.at("logo").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_name_international(j.at("nameInternational").get<std::string>());
        if (j.find("p1_score") != j.end() && !j.at("p1_score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_p1_score(j.at("p1_score").get<int64_t>());
        if (j.find("p2_score") != j.end() && !j.at("p2_score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_p2_score(j.at("p2_score").get<int64_t>());
        if (j.find("p3_score") != j.end() && !j.at("p3_score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_p3_score(j.at("p3_score").get<int64_t>());
        if (j.find("p4_score") != j.end() && !j.at("p4_score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_p4_score(j.at("p4_score").get<int64_t>());
        x.set_pl(j.at("pl").get<std::map<std::string, Pl>>());
        if (j.find("score") != j.end() && !j.at("score").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_score(j.at("score").get<int64_t>());
        x.set_scoring(j.at("scoring").get<std::vector<Scorer>>());
        x.set_short_name(j.at("shortName").get<std::string>());
        x.set_short_name_international(j.at("shortNameInternational").get<std::string>());
        x.set_shot(j.at("shot").get<std::vector<Shot>>());
        if (j.find("timeouts") != j.end() && !j.at("timeouts").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_timeouts(j.at("timeouts").get<int64_t>());
        if (j.find("tot_eff_1") != j.end() && !j.at("tot_eff_1").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_eff_1(j.at("tot_eff_1").get<int64_t>());
        if (j.find("tot_eff_2") != j.end() && !j.at("tot_eff_2").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_eff_2(j.at("tot_eff_2").get<int64_t>());
        x.set_tot_eff_3(j.at("tot_eff_3").get<double>());
        if (j.find("tot_eff_4") != j.end() && !j.at("tot_eff_4").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_eff_4(j.at("tot_eff_4").get<int64_t>());
        if (j.find("tot_eff_5") != j.end() && !j.at("tot_eff_5").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_eff_5(j.at("tot_eff_5").get<int64_t>());
        if (j.find("tot_eff_6") != j.end() && !j.at("tot_eff_6").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_eff_6(j.at("tot_eff_6").get<int64_t>());
        if (j.find("tot_eff_7") != j.end() && !j.at("tot_eff_7").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_eff_7(j.at("tot_eff_7").get<int64_t>());
        if (j.find("tot_sAssists") != j.end() && !j.at("tot_sAssists").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_assists(j.at("tot_sAssists").get<int64_t>());
        if (j.find("tot_sBenchPoints") != j.end() && !j.at("tot_sBenchPoints").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_bench_points(j.at("tot_sBenchPoints").get<int64_t>());
        if (j.find("tot_sBiggestLead") != j.end() && !j.at("tot_sBiggestLead").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_biggest_lead(j.at("tot_sBiggestLead").get<int64_t>());
        if (j.find("tot_sBiggestScoringRun") != j.end() && !j.at("tot_sBiggestScoringRun").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_biggest_scoring_run(j.at("tot_sBiggestScoringRun").get<int64_t>());
        if (j.find("tot_sBlocks") != j.end() && !j.at("tot_sBlocks").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_blocks(j.at("tot_sBlocks").get<int64_t>());
        if (j.find("tot_sBlocksReceived") != j.end() && !j.at("tot_sBlocksReceived").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_blocks_received(j.at("tot_sBlocksReceived").get<int64_t>());
        if (j.find("tot_sFieldGoalsAttempted") != j.end() && !j.at("tot_sFieldGoalsAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_field_goals_attempted(j.at("tot_sFieldGoalsAttempted").get<int64_t>());
        if (j.find("tot_sFieldGoalsMade") != j.end() && !j.at("tot_sFieldGoalsMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_field_goals_made(j.at("tot_sFieldGoalsMade").get<int64_t>());
        if (j.find("tot_sFieldGoalsPercentage") != j.end() && !j.at("tot_sFieldGoalsPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_field_goals_percentage(j.at("tot_sFieldGoalsPercentage").get<int64_t>());
        if (j.find("tot_sFoulsOn") != j.end() && !j.at("tot_sFoulsOn").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_fouls_on(j.at("tot_sFoulsOn").get<int64_t>());
        if (j.find("tot_sFoulsPersonal") != j.end() && !j.at("tot_sFoulsPersonal").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_fouls_personal(j.at("tot_sFoulsPersonal").get<int64_t>());
        if (j.find("tot_sFoulsTeam") != j.end() && !j.at("tot_sFoulsTeam").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_fouls_team(j.at("tot_sFoulsTeam").get<int64_t>());
        if (j.find("tot_sFreeThrowsAttempted") != j.end() && !j.at("tot_sFreeThrowsAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_free_throws_attempted(j.at("tot_sFreeThrowsAttempted").get<int64_t>());
        if (j.find("tot_sFreeThrowsMade") != j.end() && !j.at("tot_sFreeThrowsMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_free_throws_made(j.at("tot_sFreeThrowsMade").get<int64_t>());
        if (j.find("tot_sFreeThrowsPercentage") != j.end() && !j.at("tot_sFreeThrowsPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_free_throws_percentage(j.at("tot_sFreeThrowsPercentage").get<int64_t>());
        if (j.find("tot_sLeadChanges") != j.end() && !j.at("tot_sLeadChanges").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_lead_changes(j.at("tot_sLeadChanges").get<int64_t>());
        if (j.find("tot_sMinutes") != j.end() && !j.at("tot_sMinutes").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_minutes(j.at("tot_sMinutes").get<int64_t>());
        if (j.find("tot_sPoints") != j.end() && !j.at("tot_sPoints").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_points(j.at("tot_sPoints").get<int64_t>());
        if (j.find("tot_sPointsFastBreak") != j.end() && !j.at("tot_sPointsFastBreak").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_points_fast_break(j.at("tot_sPointsFastBreak").get<int64_t>());
        if (j.find("tot_sPointsFromTurnovers") != j.end() && !j.at("tot_sPointsFromTurnovers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_points_from_turnovers(j.at("tot_sPointsFromTurnovers").get<int64_t>());
        if (j.find("tot_sPointsInThePaint") != j.end() && !j.at("tot_sPointsInThePaint").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_points_in_the_paint(j.at("tot_sPointsInThePaint").get<int64_t>());
        if (j.find("tot_sPointsSecondChance") != j.end() && !j.at("tot_sPointsSecondChance").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_points_second_chance(j.at("tot_sPointsSecondChance").get<int64_t>());
        if (j.find("tot_sReboundsDefensive") != j.end() && !j.at("tot_sReboundsDefensive").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_rebounds_defensive(j.at("tot_sReboundsDefensive").get<int64_t>());
        if (j.find("tot_sReboundsOffensive") != j.end() && !j.at("tot_sReboundsOffensive").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_rebounds_offensive(j.at("tot_sReboundsOffensive").get<int64_t>());
        if (j.find("tot_sReboundsTeam") != j.end() && !j.at("tot_sReboundsTeam").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_rebounds_team(j.at("tot_sReboundsTeam").get<int64_t>());
        if (j.find("tot_sReboundsTeamDefensive") != j.end() && !j.at("tot_sReboundsTeamDefensive").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_rebounds_team_defensive(j.at("tot_sReboundsTeamDefensive").get<int64_t>());
        if (j.find("tot_sReboundsTeamOffensive") != j.end() && !j.at("tot_sReboundsTeamOffensive").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_rebounds_team_offensive(j.at("tot_sReboundsTeamOffensive").get<int64_t>());
        if (j.find("tot_sReboundsTotal") != j.end() && !j.at("tot_sReboundsTotal").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_rebounds_total(j.at("tot_sReboundsTotal").get<int64_t>());
        if (j.find("tot_sSteals") != j.end() && !j.at("tot_sSteals").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_steals(j.at("tot_sSteals").get<int64_t>());
        if (j.find("tot_sThreePointersAttempted") != j.end() && !j.at("tot_sThreePointersAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_three_pointers_attempted(j.at("tot_sThreePointersAttempted").get<int64_t>());
        if (j.find("tot_sThreePointersMade") != j.end() && !j.at("tot_sThreePointersMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_three_pointers_made(j.at("tot_sThreePointersMade").get<int64_t>());
        if (j.find("tot_sThreePointersPercentage") != j.end() && !j.at("tot_sThreePointersPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_three_pointers_percentage(j.at("tot_sThreePointersPercentage").get<int64_t>());
        x.set_tot_s_time_leading(j.at("tot_sTimeLeading").get<double>());
        if (j.find("tot_sTimesScoresLevel") != j.end() && !j.at("tot_sTimesScoresLevel").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_times_scores_level(j.at("tot_sTimesScoresLevel").get<int64_t>());
        if (j.find("tot_sTurnovers") != j.end() && !j.at("tot_sTurnovers").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_turnovers(j.at("tot_sTurnovers").get<int64_t>());
        if (j.find("tot_sTurnoversTeam") != j.end() && !j.at("tot_sTurnoversTeam").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_turnovers_team(j.at("tot_sTurnoversTeam").get<int64_t>());
        if (j.find("tot_sTwoPointersAttempted") != j.end() && !j.at("tot_sTwoPointersAttempted").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_two_pointers_attempted(j.at("tot_sTwoPointersAttempted").get<int64_t>());
        if (j.find("tot_sTwoPointersMade") != j.end() && !j.at("tot_sTwoPointersMade").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_two_pointers_made(j.at("tot_sTwoPointersMade").get<int64_t>());
        if (j.find("tot_sTwoPointersPercentage") != j.end() && !j.at("tot_sTwoPointersPercentage").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tot_s_two_pointers_percentage(j.at("tot_sTwoPointersPercentage").get<int64_t>());
    }

    inline void to_json(json & j, const Tm & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["codeInternational"] = x.get_code_international();
        j["fouls"] = x.get_fouls();
        j["full_score"] = x.get_full_score();
        j["lds"] = x.get_lds();
        j["logo"] = x.get_logo();
        j["name"] = x.get_name();
        j["nameInternational"] = x.get_name_international();
        j["p1_score"] = x.get_p1_score();
        j["p2_score"] = x.get_p2_score();
        j["p3_score"] = x.get_p3_score();
        j["p4_score"] = x.get_p4_score();
        j["pl"] = x.get_pl();
        j["score"] = x.get_score();
        j["scoring"] = x.get_scoring();
        j["shortName"] = x.get_short_name();
        j["shortNameInternational"] = x.get_short_name_international();
        j["shot"] = x.get_shot();
        j["timeouts"] = x.get_timeouts();
        j["tot_eff_1"] = x.get_tot_eff_1();
        j["tot_eff_2"] = x.get_tot_eff_2();
        j["tot_eff_3"] = x.get_tot_eff_3();
        j["tot_eff_4"] = x.get_tot_eff_4();
        j["tot_eff_5"] = x.get_tot_eff_5();
        j["tot_eff_6"] = x.get_tot_eff_6();
        j["tot_eff_7"] = x.get_tot_eff_7();
        j["tot_sAssists"] = x.get_tot_s_assists();
        j["tot_sBenchPoints"] = x.get_tot_s_bench_points();
        j["tot_sBiggestLead"] = x.get_tot_s_biggest_lead();
        j["tot_sBiggestScoringRun"] = x.get_tot_s_biggest_scoring_run();
        j["tot_sBlocks"] = x.get_tot_s_blocks();
        j["tot_sBlocksReceived"] = x.get_tot_s_blocks_received();
        j["tot_sFieldGoalsAttempted"] = x.get_tot_s_field_goals_attempted();
        j["tot_sFieldGoalsMade"] = x.get_tot_s_field_goals_made();
        j["tot_sFieldGoalsPercentage"] = x.get_tot_s_field_goals_percentage();
        j["tot_sFoulsOn"] = x.get_tot_s_fouls_on();
        j["tot_sFoulsPersonal"] = x.get_tot_s_fouls_personal();
        j["tot_sFoulsTeam"] = x.get_tot_s_fouls_team();
        j["tot_sFreeThrowsAttempted"] = x.get_tot_s_free_throws_attempted();
        j["tot_sFreeThrowsMade"] = x.get_tot_s_free_throws_made();
        j["tot_sFreeThrowsPercentage"] = x.get_tot_s_free_throws_percentage();
        j["tot_sLeadChanges"] = x.get_tot_s_lead_changes();
        j["tot_sMinutes"] = x.get_tot_s_minutes();
        j["tot_sPoints"] = x.get_tot_s_points();
        j["tot_sPointsFastBreak"] = x.get_tot_s_points_fast_break();
        j["tot_sPointsFromTurnovers"] = x.get_tot_s_points_from_turnovers();
        j["tot_sPointsInThePaint"] = x.get_tot_s_points_in_the_paint();
        j["tot_sPointsSecondChance"] = x.get_tot_s_points_second_chance();
        j["tot_sReboundsDefensive"] = x.get_tot_s_rebounds_defensive();
        j["tot_sReboundsOffensive"] = x.get_tot_s_rebounds_offensive();
        j["tot_sReboundsTeam"] = x.get_tot_s_rebounds_team();
        j["tot_sReboundsTeamDefensive"] = x.get_tot_s_rebounds_team_defensive();
        j["tot_sReboundsTeamOffensive"] = x.get_tot_s_rebounds_team_offensive();
        j["tot_sReboundsTotal"] = x.get_tot_s_rebounds_total();
        j["tot_sSteals"] = x.get_tot_s_steals();
        j["tot_sThreePointersAttempted"] = x.get_tot_s_three_pointers_attempted();
        j["tot_sThreePointersMade"] = x.get_tot_s_three_pointers_made();
        j["tot_sThreePointersPercentage"] = x.get_tot_s_three_pointers_percentage();
        j["tot_sTimeLeading"] = x.get_tot_s_time_leading();
        j["tot_sTimesScoresLevel"] = x.get_tot_s_times_scores_level();
        j["tot_sTurnovers"] = x.get_tot_s_turnovers();
        j["tot_sTurnoversTeam"] = x.get_tot_s_turnovers_team();
        j["tot_sTwoPointersAttempted"] = x.get_tot_s_two_pointers_attempted();
        j["tot_sTwoPointersMade"] = x.get_tot_s_two_pointers_made();
        j["tot_sTwoPointersPercentage"] = x.get_tot_s_two_pointers_percentage();
    }

    inline void from_json(const json & j, Totallds& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_s_assists(j.at("sAssists").get<std::map<std::string, Scorer>>());
        x.set_s_blocks(j.at("sBlocks").get<std::map<std::string, Scorer>>());
        x.set_s_points(j.at("sPoints").get<std::map<std::string, Scorer>>());
        x.set_s_rebounds_total(j.at("sReboundsTotal").get<std::map<std::string, Scorer>>());
        x.set_s_steals(j.at("sSteals").get<std::map<std::string, Scorer>>());
    }

    inline void to_json(json & j, const Totallds & x) {
        j = json::object();
        j["sAssists"] = x.get_s_assists();
        j["sBlocks"] = x.get_s_blocks();
        j["sPoints"] = x.get_s_points();
        j["sReboundsTotal"] = x.get_s_rebounds_total();
        j["sSteals"] = x.get_s_steals();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("attendance") != j.end() && !j.at("attendance").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_attendance(j.at("attendance").get<int64_t>());
        x.set_clock(j.at("clock").get<std::string>());
        if (j.find("disableMatch") != j.end() && !j.at("disableMatch").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_disable_match(j.at("disableMatch").get<int64_t>());
        if (j.find("inOT") != j.end() && !j.at("inOT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_in_ot(j.at("inOT").get<int64_t>());
        x.set_leaddata(j.at("leaddata").get<std::vector<std::vector<LeaddatumElement>>>());
        x.set_officials_referee1(j.at("officials_referee1").get<std::string>());
        x.set_officials_referee2(j.at("officials_referee2").get<std::string>());
        x.set_officials_referee3(j.at("officials_referee3").get<std::string>());
        x.set_othermatches(j.at("othermatches").get<std::vector<Othermatch>>());
        x.set_pbp(j.at("pbp").get<std::vector<Pbp>>());
        if (j.find("period") != j.end() && !j.at("period").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_period(j.at("period").get<int64_t>());
        if (j.find("periodLengthOVERTIME") != j.end() && !j.at("periodLengthOVERTIME").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_period_length_overtime(j.at("periodLengthOVERTIME").get<int64_t>());
        if (j.find("periodLengthREGULAR") != j.end() && !j.at("periodLengthREGULAR").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_period_length_regular(j.at("periodLengthREGULAR").get<int64_t>());
        x.set_period_type(j.at("periodType").get<PerType>());
        if (j.find("periodsMax") != j.end() && !j.at("periodsMax").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_periods_max(j.at("periodsMax").get<int64_t>());
        x.set_scorers(j.at("scorers").get<std::map<std::string, std::vector<Scorer>>>());
        x.set_timeline(j.at("timeline").get<std::vector<nlohmann::json>>());
        x.set_tm(j.at("tm").get<std::map<std::string, Tm>>());
        if (j.find("totalTimeAdded") != j.end() && !j.at("totalTimeAdded").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total_time_added(j.at("totalTimeAdded").get<int64_t>());
        x.set_totallds(j.at("totallds").get<Totallds>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["attendance"] = x.get_attendance();
        j["clock"] = x.get_clock();
        j["disableMatch"] = x.get_disable_match();
        j["inOT"] = x.get_in_ot();
        j["leaddata"] = x.get_leaddata();
        j["officials_referee1"] = x.get_officials_referee1();
        j["officials_referee2"] = x.get_officials_referee2();
        j["officials_referee3"] = x.get_officials_referee3();
        j["othermatches"] = x.get_othermatches();
        j["pbp"] = x.get_pbp();
        j["period"] = x.get_period();
        j["periodLengthOVERTIME"] = x.get_period_length_overtime();
        j["periodLengthREGULAR"] = x.get_period_length_regular();
        j["periodType"] = x.get_period_type();
        j["periodsMax"] = x.get_periods_max();
        j["scorers"] = x.get_scorers();
        j["timeline"] = x.get_timeline();
        j["tm"] = x.get_tm();
        j["totalTimeAdded"] = x.get_total_time_added();
        j["totallds"] = x.get_totallds();
    }

    inline void from_json(const json & j, LeaddatumEnum & x) {
        if (j == "") x = LeaddatumEnum::EMPTY;
        else if (j == "P1") x = LeaddatumEnum::P1;
        else if (j == "P2") x = LeaddatumEnum::P2;
        else if (j == "P3") x = LeaddatumEnum::P3;
        else if (j == "P4") x = LeaddatumEnum::P4;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"LeaddatumEnum\""); }
    }

    inline void to_json(json & j, const LeaddatumEnum & x) {
        switch (x) {
            case LeaddatumEnum::EMPTY: j = ""; break;
            case LeaddatumEnum::P1: j = "P1"; break;
            case LeaddatumEnum::P2: j = "P2"; break;
            case LeaddatumEnum::P3: j = "P3"; break;
            case LeaddatumEnum::P4: j = "P4"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"LeaddatumEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, PerType & x) {
        if (j == "REGULAR") x = PerType::REGULAR;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PerType\""); }
    }

    inline void to_json(json & j, const PerType & x) {
        switch (x) {
            case PerType::REGULAR: j = "REGULAR"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"PerType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ActionType & x) {
        if (j == "game") x = ActionType::GAME;
        else if (j == "period") x = ActionType::PERIOD;
        else if (j == "3pt") x = ActionType::THE_3_PT;
        else if (j == "2pt") x = ActionType::THE_2_PT;
        else if (j == "rebound") x = ActionType::REBOUND;
        else if (j == "timeout") x = ActionType::TIMEOUT;
        else if (j == "foulon") x = ActionType::FOULON;
        else if (j == "foul") x = ActionType::FOUL;
        else if (j == "assist") x = ActionType::ASSIST;
        else if (j == "substitution") x = ActionType::SUBSTITUTION;
        else if (j == "freethrow") x = ActionType::FREETHROW;
        else if (j == "steal") x = ActionType::STEAL;
        else if (j == "turnover") x = ActionType::TURNOVER;
        else if (j == "block") x = ActionType::BLOCK;
        else if (j == "jumpball") x = ActionType::JUMPBALL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ActionType\""); }
    }

    inline void to_json(json & j, const ActionType & x) {
        switch (x) {
            case ActionType::GAME: j = "game"; break;
            case ActionType::PERIOD: j = "period"; break;
            case ActionType::THE_3_PT: j = "3pt"; break;
            case ActionType::THE_2_PT: j = "2pt"; break;
            case ActionType::REBOUND: j = "rebound"; break;
            case ActionType::TIMEOUT: j = "timeout"; break;
            case ActionType::FOULON: j = "foulon"; break;
            case ActionType::FOUL: j = "foul"; break;
            case ActionType::ASSIST: j = "assist"; break;
            case ActionType::SUBSTITUTION: j = "substitution"; break;
            case ActionType::FREETHROW: j = "freethrow"; break;
            case ActionType::STEAL: j = "steal"; break;
            case ActionType::TURNOVER: j = "turnover"; break;
            case ActionType::BLOCK: j = "block"; break;
            case ActionType::JUMPBALL: j = "jumpball"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ActionType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FamilyNameInitial & x) {
        if (j == "R") x = FamilyNameInitial::R;
        else if (j == "M") x = FamilyNameInitial::M;
        else if (j == "s") x = FamilyNameInitial::S;
        else if (j == "C") x = FamilyNameInitial::C;
        else if (j == "O") x = FamilyNameInitial::O;
        else if (j == "W") x = FamilyNameInitial::W;
        else if (j == "A") x = FamilyNameInitial::A;
        else if (j == "P") x = FamilyNameInitial::P;
        else if (j == "V") x = FamilyNameInitial::V;
        else if (j == "I") x = FamilyNameInitial::I;
        else if (j == "J") x = FamilyNameInitial::J;
        else if (j == "S") x = FamilyNameInitial::FAMILY_NAME_INITIAL_S;
        else if (j == "H") x = FamilyNameInitial::H;
        else if (j == "B") x = FamilyNameInitial::B;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FamilyNameInitial\""); }
    }

    inline void to_json(json & j, const FamilyNameInitial & x) {
        switch (x) {
            case FamilyNameInitial::R: j = "R"; break;
            case FamilyNameInitial::M: j = "M"; break;
            case FamilyNameInitial::S: j = "s"; break;
            case FamilyNameInitial::C: j = "C"; break;
            case FamilyNameInitial::O: j = "O"; break;
            case FamilyNameInitial::W: j = "W"; break;
            case FamilyNameInitial::A: j = "A"; break;
            case FamilyNameInitial::P: j = "P"; break;
            case FamilyNameInitial::V: j = "V"; break;
            case FamilyNameInitial::I: j = "I"; break;
            case FamilyNameInitial::J: j = "J"; break;
            case FamilyNameInitial::FAMILY_NAME_INITIAL_S: j = "S"; break;
            case FamilyNameInitial::H: j = "H"; break;
            case FamilyNameInitial::B: j = "B"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FamilyNameInitial\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FirstNameInitial & x) {
        if (j == "D") x = FirstNameInitial::D;
        else if (j == "J") x = FirstNameInitial::J;
        else if (j == "T") x = FirstNameInitial::T;
        else if (j == "C") x = FirstNameInitial::C;
        else if (j == "O") x = FirstNameInitial::O;
        else if (j == "H") x = FirstNameInitial::H;
        else if (j == "L") x = FirstNameInitial::L;
        else if (j == "A") x = FirstNameInitial::A;
        else if (j == "K") x = FirstNameInitial::K;
        else if (j == "R") x = FirstNameInitial::R;
        else if (j == "B") x = FirstNameInitial::B;
        else if (j == "N") x = FirstNameInitial::N;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FirstNameInitial\""); }
    }

    inline void to_json(json & j, const FirstNameInitial & x) {
        switch (x) {
            case FirstNameInitial::D: j = "D"; break;
            case FirstNameInitial::J: j = "J"; break;
            case FirstNameInitial::T: j = "T"; break;
            case FirstNameInitial::C: j = "C"; break;
            case FirstNameInitial::O: j = "O"; break;
            case FirstNameInitial::H: j = "H"; break;
            case FirstNameInitial::L: j = "L"; break;
            case FirstNameInitial::A: j = "A"; break;
            case FirstNameInitial::K: j = "K"; break;
            case FirstNameInitial::R: j = "R"; break;
            case FirstNameInitial::B: j = "B"; break;
            case FirstNameInitial::N: j = "N"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FirstNameInitial\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ScoreboardName & x) {
        if (j == "") x = ScoreboardName::EMPTY;
        else if (j == "T. s") x = ScoreboardName::T_S;
        else if (j == "R. Ihata") x = ScoreboardName::R_IHATA;
        else if (j == "D. Jones") x = ScoreboardName::D_JONES;
        else if (j == "B. Valentine") x = ScoreboardName::B_VALENTINE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ScoreboardName\""); }
    }

    inline void to_json(json & j, const ScoreboardName & x) {
        switch (x) {
            case ScoreboardName::EMPTY: j = ""; break;
            case ScoreboardName::T_S: j = "T. s"; break;
            case ScoreboardName::R_IHATA: j = "R. Ihata"; break;
            case ScoreboardName::D_JONES: j = "D. Jones"; break;
            case ScoreboardName::B_VALENTINE: j = "B. Valentine"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ScoreboardName\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SubType & x) {
        if (j == "jumpshot") x = SubType::JUMPSHOT;
        else if (j == "layup") x = SubType::LAYUP;
        else if (j == "dunk") x = SubType::DUNK;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SubType\""); }
    }

    inline void to_json(json & j, const SubType & x) {
        switch (x) {
            case SubType::JUMPSHOT: j = "jumpshot"; break;
            case SubType::LAYUP: j = "layup"; break;
            case SubType::DUNK: j = "dunk"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SubType\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::LeaddatumEnum, int64_t>>::from_json(const json & j, std::variant<quicktype::LeaddatumEnum, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<quicktype::LeaddatumEnum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LeaddatumEnum, int64_t>>::to_json(json & j, const std::variant<quicktype::LeaddatumEnum, int64_t> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::LeaddatumEnum>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<int64_t, std::string>>::from_json(const json & j, std::variant<int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::string>>::to_json(json & j, const std::variant<int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<int64_t>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
