//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

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

    enum class Breed : int { ATROX, SOLITUS, OPIFEX, NANO };

    enum class Firstname : int { EMPTY, CHI };

    enum class Lastname : int { EMPTY, WASHKO };

    enum class Pvptitle : int { FRESHMAN };

    enum class RankTitle : int { PRESIDENT, ADVISOR, VETERAN, APPLICANT };

    enum class Sex : int { NEUTER, MALE, FEMALE };

    class PurpleTopLevel {
        public:
        PurpleTopLevel() = default;
        virtual ~PurpleTopLevel() = default;

        private:
        int64_t alienlevel;
        Breed breed;
        int64_t char_dimension;
        int64_t char_instance;
        std::string defender_rank_title;
        Firstname firstname;
        int64_t headid;
        Lastname lastname;
        int64_t levelx;
        std::string name;
        std::string prof;
        std::string prof_title;
        int64_t pvprating;
        Pvptitle pvptitle;
        int64_t rank;
        RankTitle rank_title;
        Sex sex;

        public:
        const int64_t & get_alienlevel() const { return alienlevel; }
        int64_t & get_mutable_alienlevel() { return alienlevel; }
        void set_alienlevel(const int64_t & value) { this->alienlevel = value; }

        const Breed & get_breed() const { return breed; }
        Breed & get_mutable_breed() { return breed; }
        void set_breed(const Breed & value) { this->breed = value; }

        const int64_t & get_char_dimension() const { return char_dimension; }
        int64_t & get_mutable_char_dimension() { return char_dimension; }
        void set_char_dimension(const int64_t & value) { this->char_dimension = value; }

        const int64_t & get_char_instance() const { return char_instance; }
        int64_t & get_mutable_char_instance() { return char_instance; }
        void set_char_instance(const int64_t & value) { this->char_instance = value; }

        const std::string & get_defender_rank_title() const { return defender_rank_title; }
        std::string & get_mutable_defender_rank_title() { return defender_rank_title; }
        void set_defender_rank_title(const std::string & value) { this->defender_rank_title = value; }

        const Firstname & get_firstname() const { return firstname; }
        Firstname & get_mutable_firstname() { return firstname; }
        void set_firstname(const Firstname & value) { this->firstname = value; }

        const int64_t & get_headid() const { return headid; }
        int64_t & get_mutable_headid() { return headid; }
        void set_headid(const int64_t & value) { this->headid = value; }

        const Lastname & get_lastname() const { return lastname; }
        Lastname & get_mutable_lastname() { return lastname; }
        void set_lastname(const Lastname & value) { this->lastname = value; }

        const int64_t & get_levelx() const { return levelx; }
        int64_t & get_mutable_levelx() { return levelx; }
        void set_levelx(const int64_t & value) { this->levelx = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_prof() const { return prof; }
        std::string & get_mutable_prof() { return prof; }
        void set_prof(const std::string & value) { this->prof = value; }

        const std::string & get_prof_title() const { return prof_title; }
        std::string & get_mutable_prof_title() { return prof_title; }
        void set_prof_title(const std::string & value) { this->prof_title = value; }

        const int64_t & get_pvprating() const { return pvprating; }
        int64_t & get_mutable_pvprating() { return pvprating; }
        void set_pvprating(const int64_t & value) { this->pvprating = value; }

        const Pvptitle & get_pvptitle() const { return pvptitle; }
        Pvptitle & get_mutable_pvptitle() { return pvptitle; }
        void set_pvptitle(const Pvptitle & value) { this->pvptitle = value; }

        const int64_t & get_rank() const { return rank; }
        int64_t & get_mutable_rank() { return rank; }
        void set_rank(const int64_t & value) { this->rank = value; }

        const RankTitle & get_rank_title() const { return rank_title; }
        RankTitle & get_mutable_rank_title() { return rank_title; }
        void set_rank_title(const RankTitle & value) { this->rank_title = value; }

        const Sex & get_sex() const { return sex; }
        Sex & get_mutable_sex() { return sex; }
        void set_sex(const Sex & value) { this->sex = value; }
    };

    class FluffyTopLevel {
        public:
        FluffyTopLevel() = default;
        virtual ~FluffyTopLevel() = default;

        private:
        int64_t adventurercount;
        int64_t agentcount;
        int64_t atroxcount;
        double avglvl;
        int64_t btcount;
        std::string description;
        int64_t doctorcount;
        int64_t enfcount;
        int64_t engineeercount;
        int64_t femalecount;
        int64_t fixercount;
        std::string governingname;
        std::string history;
        int64_t keepercount;
        int64_t macount;
        int64_t malecount;
        int64_t maxlvl;
        int64_t metacount;
        int64_t minlvl;
        int64_t monstercount;
        std::string name;
        int64_t nanocount;
        int64_t nanoracecount;
        int64_t neutercount;
        int64_t nummembers;
        std::string objective;
        int64_t opifexcount;
        int64_t org_dimension;
        int64_t org_instance;
        int64_t shadecount;
        int64_t side;
        std::string side_name;
        int64_t solidercount;
        int64_t solituscount;
        int64_t tradercount;

        public:
        const int64_t & get_adventurercount() const { return adventurercount; }
        int64_t & get_mutable_adventurercount() { return adventurercount; }
        void set_adventurercount(const int64_t & value) { this->adventurercount = value; }

        const int64_t & get_agentcount() const { return agentcount; }
        int64_t & get_mutable_agentcount() { return agentcount; }
        void set_agentcount(const int64_t & value) { this->agentcount = value; }

        const int64_t & get_atroxcount() const { return atroxcount; }
        int64_t & get_mutable_atroxcount() { return atroxcount; }
        void set_atroxcount(const int64_t & value) { this->atroxcount = value; }

        const double & get_avglvl() const { return avglvl; }
        double & get_mutable_avglvl() { return avglvl; }
        void set_avglvl(const double & value) { this->avglvl = value; }

        const int64_t & get_btcount() const { return btcount; }
        int64_t & get_mutable_btcount() { return btcount; }
        void set_btcount(const int64_t & value) { this->btcount = value; }

        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const int64_t & get_doctorcount() const { return doctorcount; }
        int64_t & get_mutable_doctorcount() { return doctorcount; }
        void set_doctorcount(const int64_t & value) { this->doctorcount = value; }

        const int64_t & get_enfcount() const { return enfcount; }
        int64_t & get_mutable_enfcount() { return enfcount; }
        void set_enfcount(const int64_t & value) { this->enfcount = value; }

        const int64_t & get_engineeercount() const { return engineeercount; }
        int64_t & get_mutable_engineeercount() { return engineeercount; }
        void set_engineeercount(const int64_t & value) { this->engineeercount = value; }

        const int64_t & get_femalecount() const { return femalecount; }
        int64_t & get_mutable_femalecount() { return femalecount; }
        void set_femalecount(const int64_t & value) { this->femalecount = value; }

        const int64_t & get_fixercount() const { return fixercount; }
        int64_t & get_mutable_fixercount() { return fixercount; }
        void set_fixercount(const int64_t & value) { this->fixercount = value; }

        const std::string & get_governingname() const { return governingname; }
        std::string & get_mutable_governingname() { return governingname; }
        void set_governingname(const std::string & value) { this->governingname = value; }

        const std::string & get_history() const { return history; }
        std::string & get_mutable_history() { return history; }
        void set_history(const std::string & value) { this->history = value; }

        const int64_t & get_keepercount() const { return keepercount; }
        int64_t & get_mutable_keepercount() { return keepercount; }
        void set_keepercount(const int64_t & value) { this->keepercount = value; }

        const int64_t & get_macount() const { return macount; }
        int64_t & get_mutable_macount() { return macount; }
        void set_macount(const int64_t & value) { this->macount = value; }

        const int64_t & get_malecount() const { return malecount; }
        int64_t & get_mutable_malecount() { return malecount; }
        void set_malecount(const int64_t & value) { this->malecount = value; }

        const int64_t & get_maxlvl() const { return maxlvl; }
        int64_t & get_mutable_maxlvl() { return maxlvl; }
        void set_maxlvl(const int64_t & value) { this->maxlvl = value; }

        const int64_t & get_metacount() const { return metacount; }
        int64_t & get_mutable_metacount() { return metacount; }
        void set_metacount(const int64_t & value) { this->metacount = value; }

        const int64_t & get_minlvl() const { return minlvl; }
        int64_t & get_mutable_minlvl() { return minlvl; }
        void set_minlvl(const int64_t & value) { this->minlvl = value; }

        const int64_t & get_monstercount() const { return monstercount; }
        int64_t & get_mutable_monstercount() { return monstercount; }
        void set_monstercount(const int64_t & value) { this->monstercount = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const int64_t & get_nanocount() const { return nanocount; }
        int64_t & get_mutable_nanocount() { return nanocount; }
        void set_nanocount(const int64_t & value) { this->nanocount = value; }

        const int64_t & get_nanoracecount() const { return nanoracecount; }
        int64_t & get_mutable_nanoracecount() { return nanoracecount; }
        void set_nanoracecount(const int64_t & value) { this->nanoracecount = value; }

        const int64_t & get_neutercount() const { return neutercount; }
        int64_t & get_mutable_neutercount() { return neutercount; }
        void set_neutercount(const int64_t & value) { this->neutercount = value; }

        const int64_t & get_nummembers() const { return nummembers; }
        int64_t & get_mutable_nummembers() { return nummembers; }
        void set_nummembers(const int64_t & value) { this->nummembers = value; }

        const std::string & get_objective() const { return objective; }
        std::string & get_mutable_objective() { return objective; }
        void set_objective(const std::string & value) { this->objective = value; }

        const int64_t & get_opifexcount() const { return opifexcount; }
        int64_t & get_mutable_opifexcount() { return opifexcount; }
        void set_opifexcount(const int64_t & value) { this->opifexcount = value; }

        const int64_t & get_org_dimension() const { return org_dimension; }
        int64_t & get_mutable_org_dimension() { return org_dimension; }
        void set_org_dimension(const int64_t & value) { this->org_dimension = value; }

        const int64_t & get_org_instance() const { return org_instance; }
        int64_t & get_mutable_org_instance() { return org_instance; }
        void set_org_instance(const int64_t & value) { this->org_instance = value; }

        const int64_t & get_shadecount() const { return shadecount; }
        int64_t & get_mutable_shadecount() { return shadecount; }
        void set_shadecount(const int64_t & value) { this->shadecount = value; }

        const int64_t & get_side() const { return side; }
        int64_t & get_mutable_side() { return side; }
        void set_side(const int64_t & value) { this->side = value; }

        const std::string & get_side_name() const { return side_name; }
        std::string & get_mutable_side_name() { return side_name; }
        void set_side_name(const std::string & value) { this->side_name = value; }

        const int64_t & get_solidercount() const { return solidercount; }
        int64_t & get_mutable_solidercount() { return solidercount; }
        void set_solidercount(const int64_t & value) { this->solidercount = value; }

        const int64_t & get_solituscount() const { return solituscount; }
        int64_t & get_mutable_solituscount() { return solituscount; }
        void set_solituscount(const int64_t & value) { this->solituscount = value; }

        const int64_t & get_tradercount() const { return tradercount; }
        int64_t & get_mutable_tradercount() { return tradercount; }
        void set_tradercount(const int64_t & value) { this->tradercount = value; }
    };

    using TopLevelUnion = std::variant<std::vector<PurpleTopLevel>, FluffyTopLevel, std::string>;

    using TopLevel = std::vector<TopLevelUnion>;
}

namespace quicktype {
void from_json(const json & j, PurpleTopLevel & x);
void to_json(json & j, const PurpleTopLevel & x);

void from_json(const json & j, FluffyTopLevel & x);
void to_json(json & j, const FluffyTopLevel & x);

void from_json(const json & j, Breed & x);
void to_json(json & j, const Breed & x);

void from_json(const json & j, Firstname & x);
void to_json(json & j, const Firstname & x);

void from_json(const json & j, Lastname & x);
void to_json(json & j, const Lastname & x);

void from_json(const json & j, Pvptitle & x);
void to_json(json & j, const Pvptitle & x);

void from_json(const json & j, RankTitle & x);
void to_json(json & j, const RankTitle & x);

void from_json(const json & j, Sex & x);
void to_json(json & j, const Sex & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, PurpleTopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ALIENLEVEL") != j.end() && !j.at("ALIENLEVEL").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_alienlevel(j.at("ALIENLEVEL").get<int64_t>());
        x.set_breed(j.at("BREED").get<Breed>());
        if (j.find("CHAR_DIMENSION") != j.end() && !j.at("CHAR_DIMENSION").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_char_dimension(j.at("CHAR_DIMENSION").get<int64_t>());
        if (j.find("CHAR_INSTANCE") != j.end() && !j.at("CHAR_INSTANCE").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_char_instance(j.at("CHAR_INSTANCE").get<int64_t>());
        x.set_defender_rank_title(j.at("DEFENDER_RANK_TITLE").get<std::string>());
        x.set_firstname(j.at("FIRSTNAME").get<Firstname>());
        if (j.find("HEADID") != j.end() && !j.at("HEADID").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_headid(j.at("HEADID").get<int64_t>());
        x.set_lastname(j.at("LASTNAME").get<Lastname>());
        if (j.find("LEVELX") != j.end() && !j.at("LEVELX").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_levelx(j.at("LEVELX").get<int64_t>());
        x.set_name(j.at("NAME").get<std::string>());
        x.set_prof(j.at("PROF").get<std::string>());
        x.set_prof_title(j.at("PROF_TITLE").get<std::string>());
        if (j.find("PVPRATING") != j.end() && !j.at("PVPRATING").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_pvprating(j.at("PVPRATING").get<int64_t>());
        x.set_pvptitle(j.at("PVPTITLE").get<Pvptitle>());
        if (j.find("RANK") != j.end() && !j.at("RANK").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_rank(j.at("RANK").get<int64_t>());
        x.set_rank_title(j.at("RANK_TITLE").get<RankTitle>());
        x.set_sex(j.at("SEX").get<Sex>());
    }

    inline void to_json(json & j, const PurpleTopLevel & x) {
        j = json::object();
        j["ALIENLEVEL"] = x.get_alienlevel();
        j["BREED"] = x.get_breed();
        j["CHAR_DIMENSION"] = x.get_char_dimension();
        j["CHAR_INSTANCE"] = x.get_char_instance();
        j["DEFENDER_RANK_TITLE"] = x.get_defender_rank_title();
        j["FIRSTNAME"] = x.get_firstname();
        j["HEADID"] = x.get_headid();
        j["LASTNAME"] = x.get_lastname();
        j["LEVELX"] = x.get_levelx();
        j["NAME"] = x.get_name();
        j["PROF"] = x.get_prof();
        j["PROF_TITLE"] = x.get_prof_title();
        j["PVPRATING"] = x.get_pvprating();
        j["PVPTITLE"] = x.get_pvptitle();
        j["RANK"] = x.get_rank();
        j["RANK_TITLE"] = x.get_rank_title();
        j["SEX"] = x.get_sex();
    }

    inline void from_json(const json & j, FluffyTopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("ADVENTURERCOUNT") != j.end() && !j.at("ADVENTURERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_adventurercount(j.at("ADVENTURERCOUNT").get<int64_t>());
        if (j.find("AGENTCOUNT") != j.end() && !j.at("AGENTCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_agentcount(j.at("AGENTCOUNT").get<int64_t>());
        if (j.find("ATROXCOUNT") != j.end() && !j.at("ATROXCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_atroxcount(j.at("ATROXCOUNT").get<int64_t>());
        x.set_avglvl(j.at("AVGLVL").get<double>());
        if (j.find("BTCOUNT") != j.end() && !j.at("BTCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_btcount(j.at("BTCOUNT").get<int64_t>());
        x.set_description(j.at("DESCRIPTION").get<std::string>());
        if (j.find("DOCTORCOUNT") != j.end() && !j.at("DOCTORCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_doctorcount(j.at("DOCTORCOUNT").get<int64_t>());
        if (j.find("ENFCOUNT") != j.end() && !j.at("ENFCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_enfcount(j.at("ENFCOUNT").get<int64_t>());
        if (j.find("ENGINEEERCOUNT") != j.end() && !j.at("ENGINEEERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_engineeercount(j.at("ENGINEEERCOUNT").get<int64_t>());
        if (j.find("FEMALECOUNT") != j.end() && !j.at("FEMALECOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_femalecount(j.at("FEMALECOUNT").get<int64_t>());
        if (j.find("FIXERCOUNT") != j.end() && !j.at("FIXERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_fixercount(j.at("FIXERCOUNT").get<int64_t>());
        x.set_governingname(j.at("GOVERNINGNAME").get<std::string>());
        x.set_history(j.at("HISTORY").get<std::string>());
        if (j.find("KEEPERCOUNT") != j.end() && !j.at("KEEPERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_keepercount(j.at("KEEPERCOUNT").get<int64_t>());
        if (j.find("MACOUNT") != j.end() && !j.at("MACOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_macount(j.at("MACOUNT").get<int64_t>());
        if (j.find("MALECOUNT") != j.end() && !j.at("MALECOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_malecount(j.at("MALECOUNT").get<int64_t>());
        if (j.find("MAXLVL") != j.end() && !j.at("MAXLVL").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_maxlvl(j.at("MAXLVL").get<int64_t>());
        if (j.find("METACOUNT") != j.end() && !j.at("METACOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_metacount(j.at("METACOUNT").get<int64_t>());
        if (j.find("MINLVL") != j.end() && !j.at("MINLVL").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_minlvl(j.at("MINLVL").get<int64_t>());
        if (j.find("MONSTERCOUNT") != j.end() && !j.at("MONSTERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_monstercount(j.at("MONSTERCOUNT").get<int64_t>());
        x.set_name(j.at("NAME").get<std::string>());
        if (j.find("NANOCOUNT") != j.end() && !j.at("NANOCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nanocount(j.at("NANOCOUNT").get<int64_t>());
        if (j.find("NANORACECOUNT") != j.end() && !j.at("NANORACECOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nanoracecount(j.at("NANORACECOUNT").get<int64_t>());
        if (j.find("NEUTERCOUNT") != j.end() && !j.at("NEUTERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_neutercount(j.at("NEUTERCOUNT").get<int64_t>());
        if (j.find("NUMMEMBERS") != j.end() && !j.at("NUMMEMBERS").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_nummembers(j.at("NUMMEMBERS").get<int64_t>());
        x.set_objective(j.at("OBJECTIVE").get<std::string>());
        if (j.find("OPIFEXCOUNT") != j.end() && !j.at("OPIFEXCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_opifexcount(j.at("OPIFEXCOUNT").get<int64_t>());
        if (j.find("ORG_DIMENSION") != j.end() && !j.at("ORG_DIMENSION").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_org_dimension(j.at("ORG_DIMENSION").get<int64_t>());
        if (j.find("ORG_INSTANCE") != j.end() && !j.at("ORG_INSTANCE").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_org_instance(j.at("ORG_INSTANCE").get<int64_t>());
        if (j.find("SHADECOUNT") != j.end() && !j.at("SHADECOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_shadecount(j.at("SHADECOUNT").get<int64_t>());
        if (j.find("SIDE") != j.end() && !j.at("SIDE").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_side(j.at("SIDE").get<int64_t>());
        x.set_side_name(j.at("SIDE_NAME").get<std::string>());
        if (j.find("SOLIDERCOUNT") != j.end() && !j.at("SOLIDERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_solidercount(j.at("SOLIDERCOUNT").get<int64_t>());
        if (j.find("SOLITUSCOUNT") != j.end() && !j.at("SOLITUSCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_solituscount(j.at("SOLITUSCOUNT").get<int64_t>());
        if (j.find("TRADERCOUNT") != j.end() && !j.at("TRADERCOUNT").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tradercount(j.at("TRADERCOUNT").get<int64_t>());
    }

    inline void to_json(json & j, const FluffyTopLevel & x) {
        j = json::object();
        j["ADVENTURERCOUNT"] = x.get_adventurercount();
        j["AGENTCOUNT"] = x.get_agentcount();
        j["ATROXCOUNT"] = x.get_atroxcount();
        j["AVGLVL"] = x.get_avglvl();
        j["BTCOUNT"] = x.get_btcount();
        j["DESCRIPTION"] = x.get_description();
        j["DOCTORCOUNT"] = x.get_doctorcount();
        j["ENFCOUNT"] = x.get_enfcount();
        j["ENGINEEERCOUNT"] = x.get_engineeercount();
        j["FEMALECOUNT"] = x.get_femalecount();
        j["FIXERCOUNT"] = x.get_fixercount();
        j["GOVERNINGNAME"] = x.get_governingname();
        j["HISTORY"] = x.get_history();
        j["KEEPERCOUNT"] = x.get_keepercount();
        j["MACOUNT"] = x.get_macount();
        j["MALECOUNT"] = x.get_malecount();
        j["MAXLVL"] = x.get_maxlvl();
        j["METACOUNT"] = x.get_metacount();
        j["MINLVL"] = x.get_minlvl();
        j["MONSTERCOUNT"] = x.get_monstercount();
        j["NAME"] = x.get_name();
        j["NANOCOUNT"] = x.get_nanocount();
        j["NANORACECOUNT"] = x.get_nanoracecount();
        j["NEUTERCOUNT"] = x.get_neutercount();
        j["NUMMEMBERS"] = x.get_nummembers();
        j["OBJECTIVE"] = x.get_objective();
        j["OPIFEXCOUNT"] = x.get_opifexcount();
        j["ORG_DIMENSION"] = x.get_org_dimension();
        j["ORG_INSTANCE"] = x.get_org_instance();
        j["SHADECOUNT"] = x.get_shadecount();
        j["SIDE"] = x.get_side();
        j["SIDE_NAME"] = x.get_side_name();
        j["SOLIDERCOUNT"] = x.get_solidercount();
        j["SOLITUSCOUNT"] = x.get_solituscount();
        j["TRADERCOUNT"] = x.get_tradercount();
    }

    inline void from_json(const json & j, Breed & x) {
        if (j == "Atrox") x = Breed::ATROX;
        else if (j == "Solitus") x = Breed::SOLITUS;
        else if (j == "Opifex") x = Breed::OPIFEX;
        else if (j == "Nano") x = Breed::NANO;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Breed\""); }
    }

    inline void to_json(json & j, const Breed & x) {
        switch (x) {
            case Breed::ATROX: j = "Atrox"; break;
            case Breed::SOLITUS: j = "Solitus"; break;
            case Breed::OPIFEX: j = "Opifex"; break;
            case Breed::NANO: j = "Nano"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Breed\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Firstname & x) {
        if (j == "") x = Firstname::EMPTY;
        else if (j == "Chi") x = Firstname::CHI;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Firstname\""); }
    }

    inline void to_json(json & j, const Firstname & x) {
        switch (x) {
            case Firstname::EMPTY: j = ""; break;
            case Firstname::CHI: j = "Chi"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Firstname\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Lastname & x) {
        if (j == "") x = Lastname::EMPTY;
        else if (j == "Washko") x = Lastname::WASHKO;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Lastname\""); }
    }

    inline void to_json(json & j, const Lastname & x) {
        switch (x) {
            case Lastname::EMPTY: j = ""; break;
            case Lastname::WASHKO: j = "Washko"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Lastname\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Pvptitle & x) {
        if (j == "Freshman") x = Pvptitle::FRESHMAN;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Pvptitle\""); }
    }

    inline void to_json(json & j, const Pvptitle & x) {
        switch (x) {
            case Pvptitle::FRESHMAN: j = "Freshman"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Pvptitle\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, RankTitle & x) {
        if (j == "President") x = RankTitle::PRESIDENT;
        else if (j == "Advisor") x = RankTitle::ADVISOR;
        else if (j == "Veteran") x = RankTitle::VETERAN;
        else if (j == "Applicant") x = RankTitle::APPLICANT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"RankTitle\""); }
    }

    inline void to_json(json & j, const RankTitle & x) {
        switch (x) {
            case RankTitle::PRESIDENT: j = "President"; break;
            case RankTitle::ADVISOR: j = "Advisor"; break;
            case RankTitle::VETERAN: j = "Veteran"; break;
            case RankTitle::APPLICANT: j = "Applicant"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"RankTitle\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Sex & x) {
        if (j == "Neuter") x = Sex::NEUTER;
        else if (j == "Male") x = Sex::MALE;
        else if (j == "Female") x = Sex::FEMALE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Sex\""); }
    }

    inline void to_json(json & j, const Sex & x) {
        switch (x) {
            case Sex::NEUTER: j = "Neuter"; break;
            case Sex::MALE: j = "Male"; break;
            case Sex::FEMALE: j = "Female"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Sex\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel, std::string>>::from_json(const json & j, std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::FluffyTopLevel>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::PurpleTopLevel>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel, std::string>>::to_json(json & j, const std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::PurpleTopLevel>>(x);
                break;
            case 1:
                j = std::get<quicktype::FluffyTopLevel>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
