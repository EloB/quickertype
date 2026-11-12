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
        static void to_json(json & j, std::shared_ptr<T> const & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(json const & j) {
            if (j.is_null()) return std::shared_ptr<T>(); else return std::make_shared<T>(j.get<T>());
        }
    };
    template <typename T>
    struct adl_serializer<std::optional<T>> {
        static void to_json(json & j, std::optional<T> const & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::optional<T> from_json(json const & j) {
            if (j.is_null()) return std::optional<T>(); else return std::make_optional<T>(j.get<T>());
        }
    };
}
#endif

namespace quicktype {
    using nlohmann::json;

    #ifndef NLOHMANN_UNTYPED_quicktype_HELPER
    #define NLOHMANN_UNTYPED_quicktype_HELPER
    inline json get_untyped(json const & j, char const * property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }

    inline json get_untyped(json const & j, std::string property) {
        return get_untyped(j, property.data());
    }
    #endif

    #ifndef NLOHMANN_OPTIONAL_quicktype_HELPER
    #define NLOHMANN_OPTIONAL_quicktype_HELPER
    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(json const & j, char const * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(json const & j, std::string property) {
        return get_heap_optional<T>(j, property.data());
    }
    template <typename T>
    inline std::optional<T> get_stack_optional(json const & j, char const * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::optional<T>>();
        }
        return std::optional<T>();
    }

    template <typename T>
    inline std::optional<T> get_stack_optional(json const & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    class JurorClass {
        public:
        JurorClass() = default;
        virtual ~JurorClass() = default;

        private:
        nlohmann::json adipsy;
        nlohmann::json auxiliator;
        nlohmann::json benda;
        nlohmann::json benjamin;
        nlohmann::json brandling;
        nlohmann::json epicurishly;
        nlohmann::json eremochaetous;
        nlohmann::json marten;
        nlohmann::json monocline;
        nlohmann::json olea;
        nlohmann::json palgat;
        nlohmann::json pennyworth;
        nlohmann::json pioury;
        nlohmann::json pragmatistic;
        nlohmann::json stylelessness;
        nlohmann::json systematical;
        nlohmann::json thready;
        nlohmann::json uncontemporary;
        nlohmann::json uncouched;
        nlohmann::json uninhabitedness;

        public:
        nlohmann::json const & get_adipsy() const { return adipsy; }
        nlohmann::json & get_mutable_adipsy() { return adipsy; }
        void set_adipsy(nlohmann::json const & value) { this->adipsy = value; }

        nlohmann::json const & get_auxiliator() const { return auxiliator; }
        nlohmann::json & get_mutable_auxiliator() { return auxiliator; }
        void set_auxiliator(nlohmann::json const & value) { this->auxiliator = value; }

        nlohmann::json const & get_benda() const { return benda; }
        nlohmann::json & get_mutable_benda() { return benda; }
        void set_benda(nlohmann::json const & value) { this->benda = value; }

        nlohmann::json const & get_benjamin() const { return benjamin; }
        nlohmann::json & get_mutable_benjamin() { return benjamin; }
        void set_benjamin(nlohmann::json const & value) { this->benjamin = value; }

        nlohmann::json const & get_brandling() const { return brandling; }
        nlohmann::json & get_mutable_brandling() { return brandling; }
        void set_brandling(nlohmann::json const & value) { this->brandling = value; }

        nlohmann::json const & get_epicurishly() const { return epicurishly; }
        nlohmann::json & get_mutable_epicurishly() { return epicurishly; }
        void set_epicurishly(nlohmann::json const & value) { this->epicurishly = value; }

        nlohmann::json const & get_eremochaetous() const { return eremochaetous; }
        nlohmann::json & get_mutable_eremochaetous() { return eremochaetous; }
        void set_eremochaetous(nlohmann::json const & value) { this->eremochaetous = value; }

        nlohmann::json const & get_marten() const { return marten; }
        nlohmann::json & get_mutable_marten() { return marten; }
        void set_marten(nlohmann::json const & value) { this->marten = value; }

        nlohmann::json const & get_monocline() const { return monocline; }
        nlohmann::json & get_mutable_monocline() { return monocline; }
        void set_monocline(nlohmann::json const & value) { this->monocline = value; }

        nlohmann::json const & get_olea() const { return olea; }
        nlohmann::json & get_mutable_olea() { return olea; }
        void set_olea(nlohmann::json const & value) { this->olea = value; }

        nlohmann::json const & get_palgat() const { return palgat; }
        nlohmann::json & get_mutable_palgat() { return palgat; }
        void set_palgat(nlohmann::json const & value) { this->palgat = value; }

        nlohmann::json const & get_pennyworth() const { return pennyworth; }
        nlohmann::json & get_mutable_pennyworth() { return pennyworth; }
        void set_pennyworth(nlohmann::json const & value) { this->pennyworth = value; }

        nlohmann::json const & get_pioury() const { return pioury; }
        nlohmann::json & get_mutable_pioury() { return pioury; }
        void set_pioury(nlohmann::json const & value) { this->pioury = value; }

        nlohmann::json const & get_pragmatistic() const { return pragmatistic; }
        nlohmann::json & get_mutable_pragmatistic() { return pragmatistic; }
        void set_pragmatistic(nlohmann::json const & value) { this->pragmatistic = value; }

        nlohmann::json const & get_stylelessness() const { return stylelessness; }
        nlohmann::json & get_mutable_stylelessness() { return stylelessness; }
        void set_stylelessness(nlohmann::json const & value) { this->stylelessness = value; }

        nlohmann::json const & get_systematical() const { return systematical; }
        nlohmann::json & get_mutable_systematical() { return systematical; }
        void set_systematical(nlohmann::json const & value) { this->systematical = value; }

        nlohmann::json const & get_thready() const { return thready; }
        nlohmann::json & get_mutable_thready() { return thready; }
        void set_thready(nlohmann::json const & value) { this->thready = value; }

        nlohmann::json const & get_uncontemporary() const { return uncontemporary; }
        nlohmann::json & get_mutable_uncontemporary() { return uncontemporary; }
        void set_uncontemporary(nlohmann::json const & value) { this->uncontemporary = value; }

        nlohmann::json const & get_uncouched() const { return uncouched; }
        nlohmann::json & get_mutable_uncouched() { return uncouched; }
        void set_uncouched(nlohmann::json const & value) { this->uncouched = value; }

        nlohmann::json const & get_uninhabitedness() const { return uninhabitedness; }
        nlohmann::json & get_mutable_uninhabitedness() { return uninhabitedness; }
        void set_uninhabitedness(nlohmann::json const & value) { this->uninhabitedness = value; }
    };

    using JurorElement = std::variant<bool, JurorClass>;

    using Kongoni = std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>;

    class LadronismClass {
        public:
        LadronismClass() = default;
        virtual ~LadronismClass() = default;

        private:
        nlohmann::json acclaimer;
        nlohmann::json achree;
        nlohmann::json base;
        nlohmann::json conundrumize;
        nlohmann::json degerminator;
        nlohmann::json describable;
        nlohmann::json exasperatedly;
        nlohmann::json heroine;
        nlohmann::json indazin;
        nlohmann::json luteous;
        nlohmann::json papular;
        nlohmann::json pritch;
        nlohmann::json prodenia;
        nlohmann::json seege;
        nlohmann::json shopgirl;
        nlohmann::json tragedietta;
        nlohmann::json unsparse;
        nlohmann::json uplook;
        nlohmann::json vermiformis;
        nlohmann::json whafabout;

        public:
        nlohmann::json const & get_acclaimer() const { return acclaimer; }
        nlohmann::json & get_mutable_acclaimer() { return acclaimer; }
        void set_acclaimer(nlohmann::json const & value) { this->acclaimer = value; }

        nlohmann::json const & get_achree() const { return achree; }
        nlohmann::json & get_mutable_achree() { return achree; }
        void set_achree(nlohmann::json const & value) { this->achree = value; }

        nlohmann::json const & get_base() const { return base; }
        nlohmann::json & get_mutable_base() { return base; }
        void set_base(nlohmann::json const & value) { this->base = value; }

        nlohmann::json const & get_conundrumize() const { return conundrumize; }
        nlohmann::json & get_mutable_conundrumize() { return conundrumize; }
        void set_conundrumize(nlohmann::json const & value) { this->conundrumize = value; }

        nlohmann::json const & get_degerminator() const { return degerminator; }
        nlohmann::json & get_mutable_degerminator() { return degerminator; }
        void set_degerminator(nlohmann::json const & value) { this->degerminator = value; }

        nlohmann::json const & get_describable() const { return describable; }
        nlohmann::json & get_mutable_describable() { return describable; }
        void set_describable(nlohmann::json const & value) { this->describable = value; }

        nlohmann::json const & get_exasperatedly() const { return exasperatedly; }
        nlohmann::json & get_mutable_exasperatedly() { return exasperatedly; }
        void set_exasperatedly(nlohmann::json const & value) { this->exasperatedly = value; }

        nlohmann::json const & get_heroine() const { return heroine; }
        nlohmann::json & get_mutable_heroine() { return heroine; }
        void set_heroine(nlohmann::json const & value) { this->heroine = value; }

        nlohmann::json const & get_indazin() const { return indazin; }
        nlohmann::json & get_mutable_indazin() { return indazin; }
        void set_indazin(nlohmann::json const & value) { this->indazin = value; }

        nlohmann::json const & get_luteous() const { return luteous; }
        nlohmann::json & get_mutable_luteous() { return luteous; }
        void set_luteous(nlohmann::json const & value) { this->luteous = value; }

        nlohmann::json const & get_papular() const { return papular; }
        nlohmann::json & get_mutable_papular() { return papular; }
        void set_papular(nlohmann::json const & value) { this->papular = value; }

        nlohmann::json const & get_pritch() const { return pritch; }
        nlohmann::json & get_mutable_pritch() { return pritch; }
        void set_pritch(nlohmann::json const & value) { this->pritch = value; }

        nlohmann::json const & get_prodenia() const { return prodenia; }
        nlohmann::json & get_mutable_prodenia() { return prodenia; }
        void set_prodenia(nlohmann::json const & value) { this->prodenia = value; }

        nlohmann::json const & get_seege() const { return seege; }
        nlohmann::json & get_mutable_seege() { return seege; }
        void set_seege(nlohmann::json const & value) { this->seege = value; }

        nlohmann::json const & get_shopgirl() const { return shopgirl; }
        nlohmann::json & get_mutable_shopgirl() { return shopgirl; }
        void set_shopgirl(nlohmann::json const & value) { this->shopgirl = value; }

        nlohmann::json const & get_tragedietta() const { return tragedietta; }
        nlohmann::json & get_mutable_tragedietta() { return tragedietta; }
        void set_tragedietta(nlohmann::json const & value) { this->tragedietta = value; }

        nlohmann::json const & get_unsparse() const { return unsparse; }
        nlohmann::json & get_mutable_unsparse() { return unsparse; }
        void set_unsparse(nlohmann::json const & value) { this->unsparse = value; }

        nlohmann::json const & get_uplook() const { return uplook; }
        nlohmann::json & get_mutable_uplook() { return uplook; }
        void set_uplook(nlohmann::json const & value) { this->uplook = value; }

        nlohmann::json const & get_vermiformis() const { return vermiformis; }
        nlohmann::json & get_mutable_vermiformis() { return vermiformis; }
        void set_vermiformis(nlohmann::json const & value) { this->vermiformis = value; }

        nlohmann::json const & get_whafabout() const { return whafabout; }
        nlohmann::json & get_mutable_whafabout() { return whafabout; }
        void set_whafabout(nlohmann::json const & value) { this->whafabout = value; }
    };

    using LadronismElement = std::variant<LadronismClass, double, std::string>;

    class LandlubberlyClass {
        public:
        LandlubberlyClass() = default;
        virtual ~LandlubberlyClass() = default;

        private:
        nlohmann::json acropoleis;
        nlohmann::json aminate;
        nlohmann::json amyraldism;
        nlohmann::json bipenniform;
        nlohmann::json bugre;
        nlohmann::json calycule;
        nlohmann::json caoutchouc;
        nlohmann::json disprover;
        nlohmann::json fitroot;
        nlohmann::json fulgently;
        nlohmann::json kickup;
        nlohmann::json laevoversion;
        nlohmann::json moter;
        nlohmann::json objectivity;
        nlohmann::json posterity;
        nlohmann::json postnuptial;
        nlohmann::json precedentary;
        nlohmann::json saddling;
        nlohmann::json subcurrent;
        nlohmann::json unrecriminative;

        public:
        nlohmann::json const & get_acropoleis() const { return acropoleis; }
        nlohmann::json & get_mutable_acropoleis() { return acropoleis; }
        void set_acropoleis(nlohmann::json const & value) { this->acropoleis = value; }

        nlohmann::json const & get_aminate() const { return aminate; }
        nlohmann::json & get_mutable_aminate() { return aminate; }
        void set_aminate(nlohmann::json const & value) { this->aminate = value; }

        nlohmann::json const & get_amyraldism() const { return amyraldism; }
        nlohmann::json & get_mutable_amyraldism() { return amyraldism; }
        void set_amyraldism(nlohmann::json const & value) { this->amyraldism = value; }

        nlohmann::json const & get_bipenniform() const { return bipenniform; }
        nlohmann::json & get_mutable_bipenniform() { return bipenniform; }
        void set_bipenniform(nlohmann::json const & value) { this->bipenniform = value; }

        nlohmann::json const & get_bugre() const { return bugre; }
        nlohmann::json & get_mutable_bugre() { return bugre; }
        void set_bugre(nlohmann::json const & value) { this->bugre = value; }

        nlohmann::json const & get_calycule() const { return calycule; }
        nlohmann::json & get_mutable_calycule() { return calycule; }
        void set_calycule(nlohmann::json const & value) { this->calycule = value; }

        nlohmann::json const & get_caoutchouc() const { return caoutchouc; }
        nlohmann::json & get_mutable_caoutchouc() { return caoutchouc; }
        void set_caoutchouc(nlohmann::json const & value) { this->caoutchouc = value; }

        nlohmann::json const & get_disprover() const { return disprover; }
        nlohmann::json & get_mutable_disprover() { return disprover; }
        void set_disprover(nlohmann::json const & value) { this->disprover = value; }

        nlohmann::json const & get_fitroot() const { return fitroot; }
        nlohmann::json & get_mutable_fitroot() { return fitroot; }
        void set_fitroot(nlohmann::json const & value) { this->fitroot = value; }

        nlohmann::json const & get_fulgently() const { return fulgently; }
        nlohmann::json & get_mutable_fulgently() { return fulgently; }
        void set_fulgently(nlohmann::json const & value) { this->fulgently = value; }

        nlohmann::json const & get_kickup() const { return kickup; }
        nlohmann::json & get_mutable_kickup() { return kickup; }
        void set_kickup(nlohmann::json const & value) { this->kickup = value; }

        nlohmann::json const & get_laevoversion() const { return laevoversion; }
        nlohmann::json & get_mutable_laevoversion() { return laevoversion; }
        void set_laevoversion(nlohmann::json const & value) { this->laevoversion = value; }

        nlohmann::json const & get_moter() const { return moter; }
        nlohmann::json & get_mutable_moter() { return moter; }
        void set_moter(nlohmann::json const & value) { this->moter = value; }

        nlohmann::json const & get_objectivity() const { return objectivity; }
        nlohmann::json & get_mutable_objectivity() { return objectivity; }
        void set_objectivity(nlohmann::json const & value) { this->objectivity = value; }

        nlohmann::json const & get_posterity() const { return posterity; }
        nlohmann::json & get_mutable_posterity() { return posterity; }
        void set_posterity(nlohmann::json const & value) { this->posterity = value; }

        nlohmann::json const & get_postnuptial() const { return postnuptial; }
        nlohmann::json & get_mutable_postnuptial() { return postnuptial; }
        void set_postnuptial(nlohmann::json const & value) { this->postnuptial = value; }

        nlohmann::json const & get_precedentary() const { return precedentary; }
        nlohmann::json & get_mutable_precedentary() { return precedentary; }
        void set_precedentary(nlohmann::json const & value) { this->precedentary = value; }

        nlohmann::json const & get_saddling() const { return saddling; }
        nlohmann::json & get_mutable_saddling() { return saddling; }
        void set_saddling(nlohmann::json const & value) { this->saddling = value; }

        nlohmann::json const & get_subcurrent() const { return subcurrent; }
        nlohmann::json & get_mutable_subcurrent() { return subcurrent; }
        void set_subcurrent(nlohmann::json const & value) { this->subcurrent = value; }

        nlohmann::json const & get_unrecriminative() const { return unrecriminative; }
        nlohmann::json & get_mutable_unrecriminative() { return unrecriminative; }
        void set_unrecriminative(nlohmann::json const & value) { this->unrecriminative = value; }
    };

    using LandlubberlyElement = std::variant<bool, LandlubberlyClass, int64_t>;

    using Listener = std::variant<std::vector<nlohmann::json>, int64_t>;

    class LupusClass {
        public:
        LupusClass() = default;
        virtual ~LupusClass() = default;

        private:
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> chlorioninae;
        std::optional<int64_t> corvinae;
        std::optional<int64_t> crassina;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> exiguity;
        std::optional<int64_t> farcist;
        std::optional<int64_t> holographical;
        std::optional<bool> homocerc;
        std::optional<int64_t> ichthyophagan;
        std::optional<int64_t> implacable;
        nlohmann::json nonbookish;
        std::optional<int64_t> outshiner;
        std::optional<int64_t> overweather;
        std::optional<int64_t> protonegroid;
        std::optional<int64_t> shallowish;
        std::optional<int64_t> snoke;
        std::optional<int64_t> snout;
        std::optional<int64_t> surveillance;
        std::optional<int64_t> threshingtime;
        std::optional<int64_t> thysanocarpus;
        std::optional<int64_t> unsignificantly;
        std::optional<int64_t> unsnap;
        std::optional<int64_t> vendible;

        public:
        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_chlorioninae() const { return chlorioninae; }
        std::optional<int64_t> & get_mutable_chlorioninae() { return chlorioninae; }
        void set_chlorioninae(std::optional<int64_t> const & value) { this->chlorioninae = value; }

        std::optional<int64_t> const & get_corvinae() const { return corvinae; }
        std::optional<int64_t> & get_mutable_corvinae() { return corvinae; }
        void set_corvinae(std::optional<int64_t> const & value) { this->corvinae = value; }

        std::optional<int64_t> const & get_crassina() const { return crassina; }
        std::optional<int64_t> & get_mutable_crassina() { return crassina; }
        void set_crassina(std::optional<int64_t> const & value) { this->crassina = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_exiguity() const { return exiguity; }
        std::optional<int64_t> & get_mutable_exiguity() { return exiguity; }
        void set_exiguity(std::optional<int64_t> const & value) { this->exiguity = value; }

        std::optional<int64_t> const & get_farcist() const { return farcist; }
        std::optional<int64_t> & get_mutable_farcist() { return farcist; }
        void set_farcist(std::optional<int64_t> const & value) { this->farcist = value; }

        std::optional<int64_t> const & get_holographical() const { return holographical; }
        std::optional<int64_t> & get_mutable_holographical() { return holographical; }
        void set_holographical(std::optional<int64_t> const & value) { this->holographical = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_ichthyophagan() const { return ichthyophagan; }
        std::optional<int64_t> & get_mutable_ichthyophagan() { return ichthyophagan; }
        void set_ichthyophagan(std::optional<int64_t> const & value) { this->ichthyophagan = value; }

        std::optional<int64_t> const & get_implacable() const { return implacable; }
        std::optional<int64_t> & get_mutable_implacable() { return implacable; }
        void set_implacable(std::optional<int64_t> const & value) { this->implacable = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_outshiner() const { return outshiner; }
        std::optional<int64_t> & get_mutable_outshiner() { return outshiner; }
        void set_outshiner(std::optional<int64_t> const & value) { this->outshiner = value; }

        std::optional<int64_t> const & get_overweather() const { return overweather; }
        std::optional<int64_t> & get_mutable_overweather() { return overweather; }
        void set_overweather(std::optional<int64_t> const & value) { this->overweather = value; }

        std::optional<int64_t> const & get_protonegroid() const { return protonegroid; }
        std::optional<int64_t> & get_mutable_protonegroid() { return protonegroid; }
        void set_protonegroid(std::optional<int64_t> const & value) { this->protonegroid = value; }

        std::optional<int64_t> const & get_shallowish() const { return shallowish; }
        std::optional<int64_t> & get_mutable_shallowish() { return shallowish; }
        void set_shallowish(std::optional<int64_t> const & value) { this->shallowish = value; }

        std::optional<int64_t> const & get_snoke() const { return snoke; }
        std::optional<int64_t> & get_mutable_snoke() { return snoke; }
        void set_snoke(std::optional<int64_t> const & value) { this->snoke = value; }

        std::optional<int64_t> const & get_snout() const { return snout; }
        std::optional<int64_t> & get_mutable_snout() { return snout; }
        void set_snout(std::optional<int64_t> const & value) { this->snout = value; }

        std::optional<int64_t> const & get_surveillance() const { return surveillance; }
        std::optional<int64_t> & get_mutable_surveillance() { return surveillance; }
        void set_surveillance(std::optional<int64_t> const & value) { this->surveillance = value; }

        std::optional<int64_t> const & get_threshingtime() const { return threshingtime; }
        std::optional<int64_t> & get_mutable_threshingtime() { return threshingtime; }
        void set_threshingtime(std::optional<int64_t> const & value) { this->threshingtime = value; }

        std::optional<int64_t> const & get_thysanocarpus() const { return thysanocarpus; }
        std::optional<int64_t> & get_mutable_thysanocarpus() { return thysanocarpus; }
        void set_thysanocarpus(std::optional<int64_t> const & value) { this->thysanocarpus = value; }

        std::optional<int64_t> const & get_unsignificantly() const { return unsignificantly; }
        std::optional<int64_t> & get_mutable_unsignificantly() { return unsignificantly; }
        void set_unsignificantly(std::optional<int64_t> const & value) { this->unsignificantly = value; }

        std::optional<int64_t> const & get_unsnap() const { return unsnap; }
        std::optional<int64_t> & get_mutable_unsnap() { return unsnap; }
        void set_unsnap(std::optional<int64_t> const & value) { this->unsnap = value; }

        std::optional<int64_t> const & get_vendible() const { return vendible; }
        std::optional<int64_t> & get_mutable_vendible() { return vendible; }
        void set_vendible(std::optional<int64_t> const & value) { this->vendible = value; }
    };

    using LupusElement = std::variant<LupusClass, int64_t>;

    class Maslin {
        public:
        Maslin() = default;
        virtual ~Maslin() = default;

        private:
        std::optional<int64_t> alicant;
        nlohmann::json antiatonement;
        std::optional<int64_t> anticorrosive;
        nlohmann::json aphidozer;
        nlohmann::json bakuninist;
        std::optional<int64_t> be;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> chub;
        std::optional<int64_t> cuprosilicon;
        std::optional<int64_t> curtailedly;
        std::optional<int64_t> dellenite;
        std::optional<int64_t> dimitry;
        std::optional<std::string> disdiapason;
        nlohmann::json edifying;
        std::optional<int64_t> ethmoiditis;
        nlohmann::json gastralgy;
        std::optional<int64_t> goatherd;
        std::optional<int64_t> hammerdress;
        nlohmann::json hangfire;
        std::optional<bool> homocerc;
        std::optional<int64_t> lacunosity;
        nlohmann::json longiloquence;
        std::optional<int64_t> mameliere;
        nlohmann::json motherless;
        nlohmann::json nonbookish;
        nlohmann::json noncorrodible;
        nlohmann::json nonsensicality;
        std::optional<int64_t> oafishly;
        nlohmann::json pfund;
        nlohmann::json preadvisory;
        nlohmann::json retroflexed;
        std::optional<int64_t> saccharulmic;
        std::optional<int64_t> scowlful;
        nlohmann::json secluded;
        nlohmann::json slackage;
        std::optional<int64_t> sphaeridial;
        nlohmann::json spondulics;
        std::optional<int64_t> subsecive;
        nlohmann::json swellmobsman;
        std::optional<int64_t> trachyglossate;
        nlohmann::json trialogue;
        std::optional<int64_t> unassuaged;
        nlohmann::json ungross;
        nlohmann::json unjudiciously;

        public:
        std::optional<int64_t> const & get_alicant() const { return alicant; }
        std::optional<int64_t> & get_mutable_alicant() { return alicant; }
        void set_alicant(std::optional<int64_t> const & value) { this->alicant = value; }

        nlohmann::json const & get_antiatonement() const { return antiatonement; }
        nlohmann::json & get_mutable_antiatonement() { return antiatonement; }
        void set_antiatonement(nlohmann::json const & value) { this->antiatonement = value; }

        std::optional<int64_t> const & get_anticorrosive() const { return anticorrosive; }
        std::optional<int64_t> & get_mutable_anticorrosive() { return anticorrosive; }
        void set_anticorrosive(std::optional<int64_t> const & value) { this->anticorrosive = value; }

        nlohmann::json const & get_aphidozer() const { return aphidozer; }
        nlohmann::json & get_mutable_aphidozer() { return aphidozer; }
        void set_aphidozer(nlohmann::json const & value) { this->aphidozer = value; }

        nlohmann::json const & get_bakuninist() const { return bakuninist; }
        nlohmann::json & get_mutable_bakuninist() { return bakuninist; }
        void set_bakuninist(nlohmann::json const & value) { this->bakuninist = value; }

        std::optional<int64_t> const & get_be() const { return be; }
        std::optional<int64_t> & get_mutable_be() { return be; }
        void set_be(std::optional<int64_t> const & value) { this->be = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_chub() const { return chub; }
        std::optional<int64_t> & get_mutable_chub() { return chub; }
        void set_chub(std::optional<int64_t> const & value) { this->chub = value; }

        std::optional<int64_t> const & get_cuprosilicon() const { return cuprosilicon; }
        std::optional<int64_t> & get_mutable_cuprosilicon() { return cuprosilicon; }
        void set_cuprosilicon(std::optional<int64_t> const & value) { this->cuprosilicon = value; }

        std::optional<int64_t> const & get_curtailedly() const { return curtailedly; }
        std::optional<int64_t> & get_mutable_curtailedly() { return curtailedly; }
        void set_curtailedly(std::optional<int64_t> const & value) { this->curtailedly = value; }

        std::optional<int64_t> const & get_dellenite() const { return dellenite; }
        std::optional<int64_t> & get_mutable_dellenite() { return dellenite; }
        void set_dellenite(std::optional<int64_t> const & value) { this->dellenite = value; }

        std::optional<int64_t> const & get_dimitry() const { return dimitry; }
        std::optional<int64_t> & get_mutable_dimitry() { return dimitry; }
        void set_dimitry(std::optional<int64_t> const & value) { this->dimitry = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_edifying() const { return edifying; }
        nlohmann::json & get_mutable_edifying() { return edifying; }
        void set_edifying(nlohmann::json const & value) { this->edifying = value; }

        std::optional<int64_t> const & get_ethmoiditis() const { return ethmoiditis; }
        std::optional<int64_t> & get_mutable_ethmoiditis() { return ethmoiditis; }
        void set_ethmoiditis(std::optional<int64_t> const & value) { this->ethmoiditis = value; }

        nlohmann::json const & get_gastralgy() const { return gastralgy; }
        nlohmann::json & get_mutable_gastralgy() { return gastralgy; }
        void set_gastralgy(nlohmann::json const & value) { this->gastralgy = value; }

        std::optional<int64_t> const & get_goatherd() const { return goatherd; }
        std::optional<int64_t> & get_mutable_goatherd() { return goatherd; }
        void set_goatherd(std::optional<int64_t> const & value) { this->goatherd = value; }

        std::optional<int64_t> const & get_hammerdress() const { return hammerdress; }
        std::optional<int64_t> & get_mutable_hammerdress() { return hammerdress; }
        void set_hammerdress(std::optional<int64_t> const & value) { this->hammerdress = value; }

        nlohmann::json const & get_hangfire() const { return hangfire; }
        nlohmann::json & get_mutable_hangfire() { return hangfire; }
        void set_hangfire(nlohmann::json const & value) { this->hangfire = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_lacunosity() const { return lacunosity; }
        std::optional<int64_t> & get_mutable_lacunosity() { return lacunosity; }
        void set_lacunosity(std::optional<int64_t> const & value) { this->lacunosity = value; }

        nlohmann::json const & get_longiloquence() const { return longiloquence; }
        nlohmann::json & get_mutable_longiloquence() { return longiloquence; }
        void set_longiloquence(nlohmann::json const & value) { this->longiloquence = value; }

        std::optional<int64_t> const & get_mameliere() const { return mameliere; }
        std::optional<int64_t> & get_mutable_mameliere() { return mameliere; }
        void set_mameliere(std::optional<int64_t> const & value) { this->mameliere = value; }

        nlohmann::json const & get_motherless() const { return motherless; }
        nlohmann::json & get_mutable_motherless() { return motherless; }
        void set_motherless(nlohmann::json const & value) { this->motherless = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_noncorrodible() const { return noncorrodible; }
        nlohmann::json & get_mutable_noncorrodible() { return noncorrodible; }
        void set_noncorrodible(nlohmann::json const & value) { this->noncorrodible = value; }

        nlohmann::json const & get_nonsensicality() const { return nonsensicality; }
        nlohmann::json & get_mutable_nonsensicality() { return nonsensicality; }
        void set_nonsensicality(nlohmann::json const & value) { this->nonsensicality = value; }

        std::optional<int64_t> const & get_oafishly() const { return oafishly; }
        std::optional<int64_t> & get_mutable_oafishly() { return oafishly; }
        void set_oafishly(std::optional<int64_t> const & value) { this->oafishly = value; }

        nlohmann::json const & get_pfund() const { return pfund; }
        nlohmann::json & get_mutable_pfund() { return pfund; }
        void set_pfund(nlohmann::json const & value) { this->pfund = value; }

        nlohmann::json const & get_preadvisory() const { return preadvisory; }
        nlohmann::json & get_mutable_preadvisory() { return preadvisory; }
        void set_preadvisory(nlohmann::json const & value) { this->preadvisory = value; }

        nlohmann::json const & get_retroflexed() const { return retroflexed; }
        nlohmann::json & get_mutable_retroflexed() { return retroflexed; }
        void set_retroflexed(nlohmann::json const & value) { this->retroflexed = value; }

        std::optional<int64_t> const & get_saccharulmic() const { return saccharulmic; }
        std::optional<int64_t> & get_mutable_saccharulmic() { return saccharulmic; }
        void set_saccharulmic(std::optional<int64_t> const & value) { this->saccharulmic = value; }

        std::optional<int64_t> const & get_scowlful() const { return scowlful; }
        std::optional<int64_t> & get_mutable_scowlful() { return scowlful; }
        void set_scowlful(std::optional<int64_t> const & value) { this->scowlful = value; }

        nlohmann::json const & get_secluded() const { return secluded; }
        nlohmann::json & get_mutable_secluded() { return secluded; }
        void set_secluded(nlohmann::json const & value) { this->secluded = value; }

        nlohmann::json const & get_slackage() const { return slackage; }
        nlohmann::json & get_mutable_slackage() { return slackage; }
        void set_slackage(nlohmann::json const & value) { this->slackage = value; }

        std::optional<int64_t> const & get_sphaeridial() const { return sphaeridial; }
        std::optional<int64_t> & get_mutable_sphaeridial() { return sphaeridial; }
        void set_sphaeridial(std::optional<int64_t> const & value) { this->sphaeridial = value; }

        nlohmann::json const & get_spondulics() const { return spondulics; }
        nlohmann::json & get_mutable_spondulics() { return spondulics; }
        void set_spondulics(nlohmann::json const & value) { this->spondulics = value; }

        std::optional<int64_t> const & get_subsecive() const { return subsecive; }
        std::optional<int64_t> & get_mutable_subsecive() { return subsecive; }
        void set_subsecive(std::optional<int64_t> const & value) { this->subsecive = value; }

        nlohmann::json const & get_swellmobsman() const { return swellmobsman; }
        nlohmann::json & get_mutable_swellmobsman() { return swellmobsman; }
        void set_swellmobsman(nlohmann::json const & value) { this->swellmobsman = value; }

        std::optional<int64_t> const & get_trachyglossate() const { return trachyglossate; }
        std::optional<int64_t> & get_mutable_trachyglossate() { return trachyglossate; }
        void set_trachyglossate(std::optional<int64_t> const & value) { this->trachyglossate = value; }

        nlohmann::json const & get_trialogue() const { return trialogue; }
        nlohmann::json & get_mutable_trialogue() { return trialogue; }
        void set_trialogue(nlohmann::json const & value) { this->trialogue = value; }

        std::optional<int64_t> const & get_unassuaged() const { return unassuaged; }
        std::optional<int64_t> & get_mutable_unassuaged() { return unassuaged; }
        void set_unassuaged(std::optional<int64_t> const & value) { this->unassuaged = value; }

        nlohmann::json const & get_ungross() const { return ungross; }
        nlohmann::json & get_mutable_ungross() { return ungross; }
        void set_ungross(nlohmann::json const & value) { this->ungross = value; }

        nlohmann::json const & get_unjudiciously() const { return unjudiciously; }
        nlohmann::json & get_mutable_unjudiciously() { return unjudiciously; }
        void set_unjudiciously(nlohmann::json const & value) { this->unjudiciously = value; }
    };

    class MonaziteClass {
        public:
        MonaziteClass() = default;
        virtual ~MonaziteClass() = default;

        private:
        double catharticalness;
        int64_t chirotherium;
        std::string disdiapason;
        bool homocerc;
        nlohmann::json nonbookish;

        public:
        double const & get_catharticalness() const { return catharticalness; }
        double & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(double const & value) { this->catharticalness = value; }

        int64_t const & get_chirotherium() const { return chirotherium; }
        int64_t & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(int64_t const & value) { this->chirotherium = value; }

        std::string const & get_disdiapason() const { return disdiapason; }
        std::string & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::string const & value) { this->disdiapason = value; }

        bool const & get_homocerc() const { return homocerc; }
        bool & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(bool const & value) { this->homocerc = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }
    };

    using MonaziteElement = std::variant<MonaziteClass, double>;

    using Monoliteral = std::variant<std::vector<nlohmann::json>, bool>;

    class MonotheisticallyClass {
        public:
        MonotheisticallyClass() = default;
        virtual ~MonotheisticallyClass() = default;

        private:
        nlohmann::json blaspheme;
        std::optional<double> catharticalness;
        nlohmann::json celiosalpingectomy;
        std::optional<int64_t> chirotherium;
        nlohmann::json consummativeness;
        std::optional<std::string> disdiapason;
        nlohmann::json egestive;
        nlohmann::json enchylema;
        nlohmann::json gasconade;
        nlohmann::json holidayer;
        std::optional<bool> homocerc;
        nlohmann::json intuitionalism;
        nlohmann::json lophiostomate;
        nlohmann::json nonbookish;
        nlohmann::json nonvolition;
        nlohmann::json palatableness;
        nlohmann::json pimpery;
        nlohmann::json previolation;
        nlohmann::json reconveyance;
        nlohmann::json registership;
        nlohmann::json rhyacolite;
        nlohmann::json smithereens;
        nlohmann::json superedification;
        nlohmann::json trust;
        nlohmann::json whitestone;

        public:
        nlohmann::json const & get_blaspheme() const { return blaspheme; }
        nlohmann::json & get_mutable_blaspheme() { return blaspheme; }
        void set_blaspheme(nlohmann::json const & value) { this->blaspheme = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        nlohmann::json const & get_celiosalpingectomy() const { return celiosalpingectomy; }
        nlohmann::json & get_mutable_celiosalpingectomy() { return celiosalpingectomy; }
        void set_celiosalpingectomy(nlohmann::json const & value) { this->celiosalpingectomy = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        nlohmann::json const & get_consummativeness() const { return consummativeness; }
        nlohmann::json & get_mutable_consummativeness() { return consummativeness; }
        void set_consummativeness(nlohmann::json const & value) { this->consummativeness = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_egestive() const { return egestive; }
        nlohmann::json & get_mutable_egestive() { return egestive; }
        void set_egestive(nlohmann::json const & value) { this->egestive = value; }

        nlohmann::json const & get_enchylema() const { return enchylema; }
        nlohmann::json & get_mutable_enchylema() { return enchylema; }
        void set_enchylema(nlohmann::json const & value) { this->enchylema = value; }

        nlohmann::json const & get_gasconade() const { return gasconade; }
        nlohmann::json & get_mutable_gasconade() { return gasconade; }
        void set_gasconade(nlohmann::json const & value) { this->gasconade = value; }

        nlohmann::json const & get_holidayer() const { return holidayer; }
        nlohmann::json & get_mutable_holidayer() { return holidayer; }
        void set_holidayer(nlohmann::json const & value) { this->holidayer = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_intuitionalism() const { return intuitionalism; }
        nlohmann::json & get_mutable_intuitionalism() { return intuitionalism; }
        void set_intuitionalism(nlohmann::json const & value) { this->intuitionalism = value; }

        nlohmann::json const & get_lophiostomate() const { return lophiostomate; }
        nlohmann::json & get_mutable_lophiostomate() { return lophiostomate; }
        void set_lophiostomate(nlohmann::json const & value) { this->lophiostomate = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_nonvolition() const { return nonvolition; }
        nlohmann::json & get_mutable_nonvolition() { return nonvolition; }
        void set_nonvolition(nlohmann::json const & value) { this->nonvolition = value; }

        nlohmann::json const & get_palatableness() const { return palatableness; }
        nlohmann::json & get_mutable_palatableness() { return palatableness; }
        void set_palatableness(nlohmann::json const & value) { this->palatableness = value; }

        nlohmann::json const & get_pimpery() const { return pimpery; }
        nlohmann::json & get_mutable_pimpery() { return pimpery; }
        void set_pimpery(nlohmann::json const & value) { this->pimpery = value; }

        nlohmann::json const & get_previolation() const { return previolation; }
        nlohmann::json & get_mutable_previolation() { return previolation; }
        void set_previolation(nlohmann::json const & value) { this->previolation = value; }

        nlohmann::json const & get_reconveyance() const { return reconveyance; }
        nlohmann::json & get_mutable_reconveyance() { return reconveyance; }
        void set_reconveyance(nlohmann::json const & value) { this->reconveyance = value; }

        nlohmann::json const & get_registership() const { return registership; }
        nlohmann::json & get_mutable_registership() { return registership; }
        void set_registership(nlohmann::json const & value) { this->registership = value; }

        nlohmann::json const & get_rhyacolite() const { return rhyacolite; }
        nlohmann::json & get_mutable_rhyacolite() { return rhyacolite; }
        void set_rhyacolite(nlohmann::json const & value) { this->rhyacolite = value; }

        nlohmann::json const & get_smithereens() const { return smithereens; }
        nlohmann::json & get_mutable_smithereens() { return smithereens; }
        void set_smithereens(nlohmann::json const & value) { this->smithereens = value; }

        nlohmann::json const & get_superedification() const { return superedification; }
        nlohmann::json & get_mutable_superedification() { return superedification; }
        void set_superedification(nlohmann::json const & value) { this->superedification = value; }

        nlohmann::json const & get_trust() const { return trust; }
        nlohmann::json & get_mutable_trust() { return trust; }
        void set_trust(nlohmann::json const & value) { this->trust = value; }

        nlohmann::json const & get_whitestone() const { return whitestone; }
        nlohmann::json & get_mutable_whitestone() { return whitestone; }
        void set_whitestone(nlohmann::json const & value) { this->whitestone = value; }
    };

    using MonotheisticallyElement = std::variant<std::vector<nlohmann::json>, MonotheisticallyClass>;

    using Montage = std::variant<std::vector<nlohmann::json>, double, std::string>;

    using Moralness = std::optional<std::variant<std::vector<nlohmann::json>, double>>;

    using Mulishly = std::optional<std::variant<std::vector<int64_t>, double>>;

    using Myoscope = std::variant<std::vector<nlohmann::json>, bool, int64_t>;

    using Neuromastic = std::variant<std::vector<nlohmann::json>, double>;

    class Noncontributing {
        public:
        Noncontributing() = default;
        virtual ~Noncontributing() = default;

        private:
        std::string estevin;
        double jolterhead;
        int64_t sauternes;
        bool sparsely;
        nlohmann::json unrequested;

        public:
        std::string const & get_estevin() const { return estevin; }
        std::string & get_mutable_estevin() { return estevin; }
        void set_estevin(std::string const & value) { this->estevin = value; }

        double const & get_jolterhead() const { return jolterhead; }
        double & get_mutable_jolterhead() { return jolterhead; }
        void set_jolterhead(double const & value) { this->jolterhead = value; }

        int64_t const & get_sauternes() const { return sauternes; }
        int64_t & get_mutable_sauternes() { return sauternes; }
        void set_sauternes(int64_t const & value) { this->sauternes = value; }

        bool const & get_sparsely() const { return sparsely; }
        bool & get_mutable_sparsely() { return sparsely; }
        void set_sparsely(bool const & value) { this->sparsely = value; }

        nlohmann::json const & get_unrequested() const { return unrequested; }
        nlohmann::json & get_mutable_unrequested() { return unrequested; }
        void set_unrequested(nlohmann::json const & value) { this->unrequested = value; }
    };

    using Nonnervous = std::variant<bool, int64_t>;

    using Nonvaluation = std::variant<std::vector<nlohmann::json>, bool, double>;

    class OccupationalistClass {
        public:
        OccupationalistClass() = default;
        virtual ~OccupationalistClass() = default;

        private:
        nlohmann::json beholdable;
        nlohmann::json brotuliform;
        nlohmann::json chimakum;
        nlohmann::json doodler;
        nlohmann::json emulsin;
        nlohmann::json fin;
        nlohmann::json flourishing;
        nlohmann::json flueless;
        nlohmann::json furtively;
        nlohmann::json gritter;
        nlohmann::json interwish;
        nlohmann::json monoxylic;
        nlohmann::json myristic;
        nlohmann::json nightwear;
        nlohmann::json peruser;
        nlohmann::json theoastrological;
        nlohmann::json thumby;
        nlohmann::json tingitid;
        nlohmann::json trailless;
        nlohmann::json unpocketed;

        public:
        nlohmann::json const & get_beholdable() const { return beholdable; }
        nlohmann::json & get_mutable_beholdable() { return beholdable; }
        void set_beholdable(nlohmann::json const & value) { this->beholdable = value; }

        nlohmann::json const & get_brotuliform() const { return brotuliform; }
        nlohmann::json & get_mutable_brotuliform() { return brotuliform; }
        void set_brotuliform(nlohmann::json const & value) { this->brotuliform = value; }

        nlohmann::json const & get_chimakum() const { return chimakum; }
        nlohmann::json & get_mutable_chimakum() { return chimakum; }
        void set_chimakum(nlohmann::json const & value) { this->chimakum = value; }

        nlohmann::json const & get_doodler() const { return doodler; }
        nlohmann::json & get_mutable_doodler() { return doodler; }
        void set_doodler(nlohmann::json const & value) { this->doodler = value; }

        nlohmann::json const & get_emulsin() const { return emulsin; }
        nlohmann::json & get_mutable_emulsin() { return emulsin; }
        void set_emulsin(nlohmann::json const & value) { this->emulsin = value; }

        nlohmann::json const & get_fin() const { return fin; }
        nlohmann::json & get_mutable_fin() { return fin; }
        void set_fin(nlohmann::json const & value) { this->fin = value; }

        nlohmann::json const & get_flourishing() const { return flourishing; }
        nlohmann::json & get_mutable_flourishing() { return flourishing; }
        void set_flourishing(nlohmann::json const & value) { this->flourishing = value; }

        nlohmann::json const & get_flueless() const { return flueless; }
        nlohmann::json & get_mutable_flueless() { return flueless; }
        void set_flueless(nlohmann::json const & value) { this->flueless = value; }

        nlohmann::json const & get_furtively() const { return furtively; }
        nlohmann::json & get_mutable_furtively() { return furtively; }
        void set_furtively(nlohmann::json const & value) { this->furtively = value; }

        nlohmann::json const & get_gritter() const { return gritter; }
        nlohmann::json & get_mutable_gritter() { return gritter; }
        void set_gritter(nlohmann::json const & value) { this->gritter = value; }

        nlohmann::json const & get_interwish() const { return interwish; }
        nlohmann::json & get_mutable_interwish() { return interwish; }
        void set_interwish(nlohmann::json const & value) { this->interwish = value; }

        nlohmann::json const & get_monoxylic() const { return monoxylic; }
        nlohmann::json & get_mutable_monoxylic() { return monoxylic; }
        void set_monoxylic(nlohmann::json const & value) { this->monoxylic = value; }

        nlohmann::json const & get_myristic() const { return myristic; }
        nlohmann::json & get_mutable_myristic() { return myristic; }
        void set_myristic(nlohmann::json const & value) { this->myristic = value; }

        nlohmann::json const & get_nightwear() const { return nightwear; }
        nlohmann::json & get_mutable_nightwear() { return nightwear; }
        void set_nightwear(nlohmann::json const & value) { this->nightwear = value; }

        nlohmann::json const & get_peruser() const { return peruser; }
        nlohmann::json & get_mutable_peruser() { return peruser; }
        void set_peruser(nlohmann::json const & value) { this->peruser = value; }

        nlohmann::json const & get_theoastrological() const { return theoastrological; }
        nlohmann::json & get_mutable_theoastrological() { return theoastrological; }
        void set_theoastrological(nlohmann::json const & value) { this->theoastrological = value; }

        nlohmann::json const & get_thumby() const { return thumby; }
        nlohmann::json & get_mutable_thumby() { return thumby; }
        void set_thumby(nlohmann::json const & value) { this->thumby = value; }

        nlohmann::json const & get_tingitid() const { return tingitid; }
        nlohmann::json & get_mutable_tingitid() { return tingitid; }
        void set_tingitid(nlohmann::json const & value) { this->tingitid = value; }

        nlohmann::json const & get_trailless() const { return trailless; }
        nlohmann::json & get_mutable_trailless() { return trailless; }
        void set_trailless(nlohmann::json const & value) { this->trailless = value; }

        nlohmann::json const & get_unpocketed() const { return unpocketed; }
        nlohmann::json & get_mutable_unpocketed() { return unpocketed; }
        void set_unpocketed(nlohmann::json const & value) { this->unpocketed = value; }
    };

    using OccupationalistElement = std::optional<std::variant<std::vector<nlohmann::json>, OccupationalistClass>>;

    class OutrivalClass {
        public:
        OutrivalClass() = default;
        virtual ~OutrivalClass() = default;

        private:
        nlohmann::json adroitly;
        nlohmann::json bridehood;
        nlohmann::json castoroides;
        nlohmann::json czechoslovak;
        nlohmann::json diagenesis;
        nlohmann::json dihexahedron;
        nlohmann::json dopester;
        nlohmann::json eumerism;
        nlohmann::json flyness;
        nlohmann::json fouler;
        nlohmann::json laudanosine;
        nlohmann::json lingulidae;
        nlohmann::json minutary;
        nlohmann::json mitra;
        nlohmann::json opisthorchiasis;
        nlohmann::json pensively;
        nlohmann::json pubigerous;
        nlohmann::json rebellious;
        nlohmann::json recodify;
        nlohmann::json unpaced;

        public:
        nlohmann::json const & get_adroitly() const { return adroitly; }
        nlohmann::json & get_mutable_adroitly() { return adroitly; }
        void set_adroitly(nlohmann::json const & value) { this->adroitly = value; }

        nlohmann::json const & get_bridehood() const { return bridehood; }
        nlohmann::json & get_mutable_bridehood() { return bridehood; }
        void set_bridehood(nlohmann::json const & value) { this->bridehood = value; }

        nlohmann::json const & get_castoroides() const { return castoroides; }
        nlohmann::json & get_mutable_castoroides() { return castoroides; }
        void set_castoroides(nlohmann::json const & value) { this->castoroides = value; }

        nlohmann::json const & get_czechoslovak() const { return czechoslovak; }
        nlohmann::json & get_mutable_czechoslovak() { return czechoslovak; }
        void set_czechoslovak(nlohmann::json const & value) { this->czechoslovak = value; }

        nlohmann::json const & get_diagenesis() const { return diagenesis; }
        nlohmann::json & get_mutable_diagenesis() { return diagenesis; }
        void set_diagenesis(nlohmann::json const & value) { this->diagenesis = value; }

        nlohmann::json const & get_dihexahedron() const { return dihexahedron; }
        nlohmann::json & get_mutable_dihexahedron() { return dihexahedron; }
        void set_dihexahedron(nlohmann::json const & value) { this->dihexahedron = value; }

        nlohmann::json const & get_dopester() const { return dopester; }
        nlohmann::json & get_mutable_dopester() { return dopester; }
        void set_dopester(nlohmann::json const & value) { this->dopester = value; }

        nlohmann::json const & get_eumerism() const { return eumerism; }
        nlohmann::json & get_mutable_eumerism() { return eumerism; }
        void set_eumerism(nlohmann::json const & value) { this->eumerism = value; }

        nlohmann::json const & get_flyness() const { return flyness; }
        nlohmann::json & get_mutable_flyness() { return flyness; }
        void set_flyness(nlohmann::json const & value) { this->flyness = value; }

        nlohmann::json const & get_fouler() const { return fouler; }
        nlohmann::json & get_mutable_fouler() { return fouler; }
        void set_fouler(nlohmann::json const & value) { this->fouler = value; }

        nlohmann::json const & get_laudanosine() const { return laudanosine; }
        nlohmann::json & get_mutable_laudanosine() { return laudanosine; }
        void set_laudanosine(nlohmann::json const & value) { this->laudanosine = value; }

        nlohmann::json const & get_lingulidae() const { return lingulidae; }
        nlohmann::json & get_mutable_lingulidae() { return lingulidae; }
        void set_lingulidae(nlohmann::json const & value) { this->lingulidae = value; }

        nlohmann::json const & get_minutary() const { return minutary; }
        nlohmann::json & get_mutable_minutary() { return minutary; }
        void set_minutary(nlohmann::json const & value) { this->minutary = value; }

        nlohmann::json const & get_mitra() const { return mitra; }
        nlohmann::json & get_mutable_mitra() { return mitra; }
        void set_mitra(nlohmann::json const & value) { this->mitra = value; }

        nlohmann::json const & get_opisthorchiasis() const { return opisthorchiasis; }
        nlohmann::json & get_mutable_opisthorchiasis() { return opisthorchiasis; }
        void set_opisthorchiasis(nlohmann::json const & value) { this->opisthorchiasis = value; }

        nlohmann::json const & get_pensively() const { return pensively; }
        nlohmann::json & get_mutable_pensively() { return pensively; }
        void set_pensively(nlohmann::json const & value) { this->pensively = value; }

        nlohmann::json const & get_pubigerous() const { return pubigerous; }
        nlohmann::json & get_mutable_pubigerous() { return pubigerous; }
        void set_pubigerous(nlohmann::json const & value) { this->pubigerous = value; }

        nlohmann::json const & get_rebellious() const { return rebellious; }
        nlohmann::json & get_mutable_rebellious() { return rebellious; }
        void set_rebellious(nlohmann::json const & value) { this->rebellious = value; }

        nlohmann::json const & get_recodify() const { return recodify; }
        nlohmann::json & get_mutable_recodify() { return recodify; }
        void set_recodify(nlohmann::json const & value) { this->recodify = value; }

        nlohmann::json const & get_unpaced() const { return unpaced; }
        nlohmann::json & get_mutable_unpaced() { return unpaced; }
        void set_unpaced(nlohmann::json const & value) { this->unpaced = value; }
    };

    using OutrivalElement = std::optional<std::variant<OutrivalClass, double>>;

    using Paleographically = std::variant<double, std::map<std::string, std::optional<int64_t>>>;

    using Pamphletwise = std::variant<int64_t, std::map<std::string, int64_t>, std::string>;

    using Pediatric = std::optional<std::variant<bool, double>>;

    class PiaculumClass {
        public:
        PiaculumClass() = default;
        virtual ~PiaculumClass() = default;

        private:
        std::optional<int64_t> alada;
        std::optional<int64_t> amphistomous;
        std::optional<int64_t> boysenberry;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> decardinalize;
        std::optional<int64_t> discouragement;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> doitrified;
        std::optional<int64_t> hexaspermous;
        std::optional<bool> homocerc;
        std::optional<int64_t> insinking;
        std::optional<int64_t> loathfulness;
        std::optional<int64_t> miasmatical;
        std::optional<int64_t> neurofibril;
        nlohmann::json nonbookish;
        std::optional<int64_t> phonendoscope;
        std::optional<int64_t> pilferment;
        std::optional<int64_t> predismissory;
        std::optional<int64_t> preinscription;
        std::optional<int64_t> quotative;
        std::optional<int64_t> sienna;
        std::optional<int64_t> thorax;
        std::optional<int64_t> yachting;
        std::optional<int64_t> zipper;

        public:
        std::optional<int64_t> const & get_alada() const { return alada; }
        std::optional<int64_t> & get_mutable_alada() { return alada; }
        void set_alada(std::optional<int64_t> const & value) { this->alada = value; }

        std::optional<int64_t> const & get_amphistomous() const { return amphistomous; }
        std::optional<int64_t> & get_mutable_amphistomous() { return amphistomous; }
        void set_amphistomous(std::optional<int64_t> const & value) { this->amphistomous = value; }

        std::optional<int64_t> const & get_boysenberry() const { return boysenberry; }
        std::optional<int64_t> & get_mutable_boysenberry() { return boysenberry; }
        void set_boysenberry(std::optional<int64_t> const & value) { this->boysenberry = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_decardinalize() const { return decardinalize; }
        std::optional<int64_t> & get_mutable_decardinalize() { return decardinalize; }
        void set_decardinalize(std::optional<int64_t> const & value) { this->decardinalize = value; }

        std::optional<int64_t> const & get_discouragement() const { return discouragement; }
        std::optional<int64_t> & get_mutable_discouragement() { return discouragement; }
        void set_discouragement(std::optional<int64_t> const & value) { this->discouragement = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_doitrified() const { return doitrified; }
        std::optional<int64_t> & get_mutable_doitrified() { return doitrified; }
        void set_doitrified(std::optional<int64_t> const & value) { this->doitrified = value; }

        std::optional<int64_t> const & get_hexaspermous() const { return hexaspermous; }
        std::optional<int64_t> & get_mutable_hexaspermous() { return hexaspermous; }
        void set_hexaspermous(std::optional<int64_t> const & value) { this->hexaspermous = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_insinking() const { return insinking; }
        std::optional<int64_t> & get_mutable_insinking() { return insinking; }
        void set_insinking(std::optional<int64_t> const & value) { this->insinking = value; }

        std::optional<int64_t> const & get_loathfulness() const { return loathfulness; }
        std::optional<int64_t> & get_mutable_loathfulness() { return loathfulness; }
        void set_loathfulness(std::optional<int64_t> const & value) { this->loathfulness = value; }

        std::optional<int64_t> const & get_miasmatical() const { return miasmatical; }
        std::optional<int64_t> & get_mutable_miasmatical() { return miasmatical; }
        void set_miasmatical(std::optional<int64_t> const & value) { this->miasmatical = value; }

        std::optional<int64_t> const & get_neurofibril() const { return neurofibril; }
        std::optional<int64_t> & get_mutable_neurofibril() { return neurofibril; }
        void set_neurofibril(std::optional<int64_t> const & value) { this->neurofibril = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_phonendoscope() const { return phonendoscope; }
        std::optional<int64_t> & get_mutable_phonendoscope() { return phonendoscope; }
        void set_phonendoscope(std::optional<int64_t> const & value) { this->phonendoscope = value; }

        std::optional<int64_t> const & get_pilferment() const { return pilferment; }
        std::optional<int64_t> & get_mutable_pilferment() { return pilferment; }
        void set_pilferment(std::optional<int64_t> const & value) { this->pilferment = value; }

        std::optional<int64_t> const & get_predismissory() const { return predismissory; }
        std::optional<int64_t> & get_mutable_predismissory() { return predismissory; }
        void set_predismissory(std::optional<int64_t> const & value) { this->predismissory = value; }

        std::optional<int64_t> const & get_preinscription() const { return preinscription; }
        std::optional<int64_t> & get_mutable_preinscription() { return preinscription; }
        void set_preinscription(std::optional<int64_t> const & value) { this->preinscription = value; }

        std::optional<int64_t> const & get_quotative() const { return quotative; }
        std::optional<int64_t> & get_mutable_quotative() { return quotative; }
        void set_quotative(std::optional<int64_t> const & value) { this->quotative = value; }

        std::optional<int64_t> const & get_sienna() const { return sienna; }
        std::optional<int64_t> & get_mutable_sienna() { return sienna; }
        void set_sienna(std::optional<int64_t> const & value) { this->sienna = value; }

        std::optional<int64_t> const & get_thorax() const { return thorax; }
        std::optional<int64_t> & get_mutable_thorax() { return thorax; }
        void set_thorax(std::optional<int64_t> const & value) { this->thorax = value; }

        std::optional<int64_t> const & get_yachting() const { return yachting; }
        std::optional<int64_t> & get_mutable_yachting() { return yachting; }
        void set_yachting(std::optional<int64_t> const & value) { this->yachting = value; }

        std::optional<int64_t> const & get_zipper() const { return zipper; }
        std::optional<int64_t> & get_mutable_zipper() { return zipper; }
        void set_zipper(std::optional<int64_t> const & value) { this->zipper = value; }
    };

    using PiaculumElement = std::variant<PiaculumClass, double>;

    using Piccadilly = std::optional<std::variant<double, std::string>>;

    using Piffler = std::variant<std::vector<nlohmann::json>, MonaziteClass>;

    using Pithful = std::optional<std::variant<bool, int64_t>>;

    using Placuntiti = std::variant<int64_t, std::map<std::string, int64_t>>;

    using Plectopterous = std::variant<double, std::map<std::string, int64_t>>;

    class Pneumocele {
        public:
        Pneumocele() = default;
        virtual ~Pneumocele() = default;

        private:
        nlohmann::json carbonarism;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        nlohmann::json cineolic;
        nlohmann::json cobbly;
        nlohmann::json conchyliferous;
        nlohmann::json congregation;
        std::optional<std::string> disdiapason;
        nlohmann::json enterotomy;
        nlohmann::json entophytal;
        nlohmann::json fewtrils;
        nlohmann::json herem;
        std::optional<bool> homocerc;
        nlohmann::json koniga;
        nlohmann::json meticulosity;
        nlohmann::json micky;
        nlohmann::json mismarriage;
        nlohmann::json neurotrophic;
        nlohmann::json nonbookish;
        nlohmann::json persuasively;
        nlohmann::json replaceable;
        nlohmann::json silex;
        nlohmann::json taillight;
        nlohmann::json unjealous;
        nlohmann::json visitorial;

        public:
        nlohmann::json const & get_carbonarism() const { return carbonarism; }
        nlohmann::json & get_mutable_carbonarism() { return carbonarism; }
        void set_carbonarism(nlohmann::json const & value) { this->carbonarism = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        nlohmann::json const & get_cineolic() const { return cineolic; }
        nlohmann::json & get_mutable_cineolic() { return cineolic; }
        void set_cineolic(nlohmann::json const & value) { this->cineolic = value; }

        nlohmann::json const & get_cobbly() const { return cobbly; }
        nlohmann::json & get_mutable_cobbly() { return cobbly; }
        void set_cobbly(nlohmann::json const & value) { this->cobbly = value; }

        nlohmann::json const & get_conchyliferous() const { return conchyliferous; }
        nlohmann::json & get_mutable_conchyliferous() { return conchyliferous; }
        void set_conchyliferous(nlohmann::json const & value) { this->conchyliferous = value; }

        nlohmann::json const & get_congregation() const { return congregation; }
        nlohmann::json & get_mutable_congregation() { return congregation; }
        void set_congregation(nlohmann::json const & value) { this->congregation = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_enterotomy() const { return enterotomy; }
        nlohmann::json & get_mutable_enterotomy() { return enterotomy; }
        void set_enterotomy(nlohmann::json const & value) { this->enterotomy = value; }

        nlohmann::json const & get_entophytal() const { return entophytal; }
        nlohmann::json & get_mutable_entophytal() { return entophytal; }
        void set_entophytal(nlohmann::json const & value) { this->entophytal = value; }

        nlohmann::json const & get_fewtrils() const { return fewtrils; }
        nlohmann::json & get_mutable_fewtrils() { return fewtrils; }
        void set_fewtrils(nlohmann::json const & value) { this->fewtrils = value; }

        nlohmann::json const & get_herem() const { return herem; }
        nlohmann::json & get_mutable_herem() { return herem; }
        void set_herem(nlohmann::json const & value) { this->herem = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_koniga() const { return koniga; }
        nlohmann::json & get_mutable_koniga() { return koniga; }
        void set_koniga(nlohmann::json const & value) { this->koniga = value; }

        nlohmann::json const & get_meticulosity() const { return meticulosity; }
        nlohmann::json & get_mutable_meticulosity() { return meticulosity; }
        void set_meticulosity(nlohmann::json const & value) { this->meticulosity = value; }

        nlohmann::json const & get_micky() const { return micky; }
        nlohmann::json & get_mutable_micky() { return micky; }
        void set_micky(nlohmann::json const & value) { this->micky = value; }

        nlohmann::json const & get_mismarriage() const { return mismarriage; }
        nlohmann::json & get_mutable_mismarriage() { return mismarriage; }
        void set_mismarriage(nlohmann::json const & value) { this->mismarriage = value; }

        nlohmann::json const & get_neurotrophic() const { return neurotrophic; }
        nlohmann::json & get_mutable_neurotrophic() { return neurotrophic; }
        void set_neurotrophic(nlohmann::json const & value) { this->neurotrophic = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_persuasively() const { return persuasively; }
        nlohmann::json & get_mutable_persuasively() { return persuasively; }
        void set_persuasively(nlohmann::json const & value) { this->persuasively = value; }

        nlohmann::json const & get_replaceable() const { return replaceable; }
        nlohmann::json & get_mutable_replaceable() { return replaceable; }
        void set_replaceable(nlohmann::json const & value) { this->replaceable = value; }

        nlohmann::json const & get_silex() const { return silex; }
        nlohmann::json & get_mutable_silex() { return silex; }
        void set_silex(nlohmann::json const & value) { this->silex = value; }

        nlohmann::json const & get_taillight() const { return taillight; }
        nlohmann::json & get_mutable_taillight() { return taillight; }
        void set_taillight(nlohmann::json const & value) { this->taillight = value; }

        nlohmann::json const & get_unjealous() const { return unjealous; }
        nlohmann::json & get_mutable_unjealous() { return unjealous; }
        void set_unjealous(nlohmann::json const & value) { this->unjealous = value; }

        nlohmann::json const & get_visitorial() const { return visitorial; }
        nlohmann::json & get_mutable_visitorial() { return visitorial; }
        void set_visitorial(nlohmann::json const & value) { this->visitorial = value; }
    };

    using Poliorcetic = std::variant<bool, MonaziteClass>;

    using Poormaster = std::optional<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>>;

    class PotwhiskyClass {
        public:
        PotwhiskyClass() = default;
        virtual ~PotwhiskyClass() = default;

        private:
        nlohmann::json arciform;
        nlohmann::json cresolin;
        nlohmann::json disheartener;
        nlohmann::json disproportionable;
        nlohmann::json euchorda;
        nlohmann::json ferryway;
        nlohmann::json filamentiferous;
        nlohmann::json flemish;
        nlohmann::json forgainst;
        nlohmann::json grainering;
        nlohmann::json irrevoluble;
        nlohmann::json kindredship;
        nlohmann::json pinguitudinous;
        nlohmann::json simpletonic;
        nlohmann::json singsong;
        nlohmann::json submergement;
        nlohmann::json supraoesophagal;
        nlohmann::json thrashel;
        nlohmann::json tyremesis;
        nlohmann::json yoruba;

        public:
        nlohmann::json const & get_arciform() const { return arciform; }
        nlohmann::json & get_mutable_arciform() { return arciform; }
        void set_arciform(nlohmann::json const & value) { this->arciform = value; }

        nlohmann::json const & get_cresolin() const { return cresolin; }
        nlohmann::json & get_mutable_cresolin() { return cresolin; }
        void set_cresolin(nlohmann::json const & value) { this->cresolin = value; }

        nlohmann::json const & get_disheartener() const { return disheartener; }
        nlohmann::json & get_mutable_disheartener() { return disheartener; }
        void set_disheartener(nlohmann::json const & value) { this->disheartener = value; }

        nlohmann::json const & get_disproportionable() const { return disproportionable; }
        nlohmann::json & get_mutable_disproportionable() { return disproportionable; }
        void set_disproportionable(nlohmann::json const & value) { this->disproportionable = value; }

        nlohmann::json const & get_euchorda() const { return euchorda; }
        nlohmann::json & get_mutable_euchorda() { return euchorda; }
        void set_euchorda(nlohmann::json const & value) { this->euchorda = value; }

        nlohmann::json const & get_ferryway() const { return ferryway; }
        nlohmann::json & get_mutable_ferryway() { return ferryway; }
        void set_ferryway(nlohmann::json const & value) { this->ferryway = value; }

        nlohmann::json const & get_filamentiferous() const { return filamentiferous; }
        nlohmann::json & get_mutable_filamentiferous() { return filamentiferous; }
        void set_filamentiferous(nlohmann::json const & value) { this->filamentiferous = value; }

        nlohmann::json const & get_flemish() const { return flemish; }
        nlohmann::json & get_mutable_flemish() { return flemish; }
        void set_flemish(nlohmann::json const & value) { this->flemish = value; }

        nlohmann::json const & get_forgainst() const { return forgainst; }
        nlohmann::json & get_mutable_forgainst() { return forgainst; }
        void set_forgainst(nlohmann::json const & value) { this->forgainst = value; }

        nlohmann::json const & get_grainering() const { return grainering; }
        nlohmann::json & get_mutable_grainering() { return grainering; }
        void set_grainering(nlohmann::json const & value) { this->grainering = value; }

        nlohmann::json const & get_irrevoluble() const { return irrevoluble; }
        nlohmann::json & get_mutable_irrevoluble() { return irrevoluble; }
        void set_irrevoluble(nlohmann::json const & value) { this->irrevoluble = value; }

        nlohmann::json const & get_kindredship() const { return kindredship; }
        nlohmann::json & get_mutable_kindredship() { return kindredship; }
        void set_kindredship(nlohmann::json const & value) { this->kindredship = value; }

        nlohmann::json const & get_pinguitudinous() const { return pinguitudinous; }
        nlohmann::json & get_mutable_pinguitudinous() { return pinguitudinous; }
        void set_pinguitudinous(nlohmann::json const & value) { this->pinguitudinous = value; }

        nlohmann::json const & get_simpletonic() const { return simpletonic; }
        nlohmann::json & get_mutable_simpletonic() { return simpletonic; }
        void set_simpletonic(nlohmann::json const & value) { this->simpletonic = value; }

        nlohmann::json const & get_singsong() const { return singsong; }
        nlohmann::json & get_mutable_singsong() { return singsong; }
        void set_singsong(nlohmann::json const & value) { this->singsong = value; }

        nlohmann::json const & get_submergement() const { return submergement; }
        nlohmann::json & get_mutable_submergement() { return submergement; }
        void set_submergement(nlohmann::json const & value) { this->submergement = value; }

        nlohmann::json const & get_supraoesophagal() const { return supraoesophagal; }
        nlohmann::json & get_mutable_supraoesophagal() { return supraoesophagal; }
        void set_supraoesophagal(nlohmann::json const & value) { this->supraoesophagal = value; }

        nlohmann::json const & get_thrashel() const { return thrashel; }
        nlohmann::json & get_mutable_thrashel() { return thrashel; }
        void set_thrashel(nlohmann::json const & value) { this->thrashel = value; }

        nlohmann::json const & get_tyremesis() const { return tyremesis; }
        nlohmann::json & get_mutable_tyremesis() { return tyremesis; }
        void set_tyremesis(nlohmann::json const & value) { this->tyremesis = value; }

        nlohmann::json const & get_yoruba() const { return yoruba; }
        nlohmann::json & get_mutable_yoruba() { return yoruba; }
        void set_yoruba(nlohmann::json const & value) { this->yoruba = value; }
    };

    using PotwhiskyElement = std::optional<std::variant<PotwhiskyClass, int64_t>>;

    using Practicalizer = std::variant<std::vector<nlohmann::json>, MonaziteClass, std::string>;

    class PrefreshmanClass {
        public:
        PrefreshmanClass() = default;
        virtual ~PrefreshmanClass() = default;

        private:
        nlohmann::json azorubine;
        nlohmann::json choroiditis;
        nlohmann::json coagulatory;
        nlohmann::json cyclorama;
        nlohmann::json dolphus;
        nlohmann::json duckhearted;
        nlohmann::json ficus;
        nlohmann::json gemaric;
        nlohmann::json jugation;
        nlohmann::json myoliposis;
        nlohmann::json nonnomination;
        nlohmann::json palay;
        nlohmann::json pentactinal;
        nlohmann::json phaet;
        nlohmann::json piquant;
        nlohmann::json registration;
        nlohmann::json remancipation;
        nlohmann::json scutatiform;
        nlohmann::json theodolite;
        nlohmann::json underward;

        public:
        nlohmann::json const & get_azorubine() const { return azorubine; }
        nlohmann::json & get_mutable_azorubine() { return azorubine; }
        void set_azorubine(nlohmann::json const & value) { this->azorubine = value; }

        nlohmann::json const & get_choroiditis() const { return choroiditis; }
        nlohmann::json & get_mutable_choroiditis() { return choroiditis; }
        void set_choroiditis(nlohmann::json const & value) { this->choroiditis = value; }

        nlohmann::json const & get_coagulatory() const { return coagulatory; }
        nlohmann::json & get_mutable_coagulatory() { return coagulatory; }
        void set_coagulatory(nlohmann::json const & value) { this->coagulatory = value; }

        nlohmann::json const & get_cyclorama() const { return cyclorama; }
        nlohmann::json & get_mutable_cyclorama() { return cyclorama; }
        void set_cyclorama(nlohmann::json const & value) { this->cyclorama = value; }

        nlohmann::json const & get_dolphus() const { return dolphus; }
        nlohmann::json & get_mutable_dolphus() { return dolphus; }
        void set_dolphus(nlohmann::json const & value) { this->dolphus = value; }

        nlohmann::json const & get_duckhearted() const { return duckhearted; }
        nlohmann::json & get_mutable_duckhearted() { return duckhearted; }
        void set_duckhearted(nlohmann::json const & value) { this->duckhearted = value; }

        nlohmann::json const & get_ficus() const { return ficus; }
        nlohmann::json & get_mutable_ficus() { return ficus; }
        void set_ficus(nlohmann::json const & value) { this->ficus = value; }

        nlohmann::json const & get_gemaric() const { return gemaric; }
        nlohmann::json & get_mutable_gemaric() { return gemaric; }
        void set_gemaric(nlohmann::json const & value) { this->gemaric = value; }

        nlohmann::json const & get_jugation() const { return jugation; }
        nlohmann::json & get_mutable_jugation() { return jugation; }
        void set_jugation(nlohmann::json const & value) { this->jugation = value; }

        nlohmann::json const & get_myoliposis() const { return myoliposis; }
        nlohmann::json & get_mutable_myoliposis() { return myoliposis; }
        void set_myoliposis(nlohmann::json const & value) { this->myoliposis = value; }

        nlohmann::json const & get_nonnomination() const { return nonnomination; }
        nlohmann::json & get_mutable_nonnomination() { return nonnomination; }
        void set_nonnomination(nlohmann::json const & value) { this->nonnomination = value; }

        nlohmann::json const & get_palay() const { return palay; }
        nlohmann::json & get_mutable_palay() { return palay; }
        void set_palay(nlohmann::json const & value) { this->palay = value; }

        nlohmann::json const & get_pentactinal() const { return pentactinal; }
        nlohmann::json & get_mutable_pentactinal() { return pentactinal; }
        void set_pentactinal(nlohmann::json const & value) { this->pentactinal = value; }

        nlohmann::json const & get_phaet() const { return phaet; }
        nlohmann::json & get_mutable_phaet() { return phaet; }
        void set_phaet(nlohmann::json const & value) { this->phaet = value; }

        nlohmann::json const & get_piquant() const { return piquant; }
        nlohmann::json & get_mutable_piquant() { return piquant; }
        void set_piquant(nlohmann::json const & value) { this->piquant = value; }

        nlohmann::json const & get_registration() const { return registration; }
        nlohmann::json & get_mutable_registration() { return registration; }
        void set_registration(nlohmann::json const & value) { this->registration = value; }

        nlohmann::json const & get_remancipation() const { return remancipation; }
        nlohmann::json & get_mutable_remancipation() { return remancipation; }
        void set_remancipation(nlohmann::json const & value) { this->remancipation = value; }

        nlohmann::json const & get_scutatiform() const { return scutatiform; }
        nlohmann::json & get_mutable_scutatiform() { return scutatiform; }
        void set_scutatiform(nlohmann::json const & value) { this->scutatiform = value; }

        nlohmann::json const & get_theodolite() const { return theodolite; }
        nlohmann::json & get_mutable_theodolite() { return theodolite; }
        void set_theodolite(nlohmann::json const & value) { this->theodolite = value; }

        nlohmann::json const & get_underward() const { return underward; }
        nlohmann::json & get_mutable_underward() { return underward; }
        void set_underward(nlohmann::json const & value) { this->underward = value; }
    };

    using PrefreshmanElement = std::variant<std::vector<nlohmann::json>, PrefreshmanClass, std::string>;

    using Prehensility = std::variant<std::vector<nlohmann::json>, bool, MonaziteClass>;

    using Prevoidance = std::variant<std::vector<int64_t>, MonaziteClass, int64_t>;

    using Protext = std::variant<std::vector<int64_t>, bool, MonaziteClass>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<JurorElement> juror;
        std::vector<Kongoni> kongoni;
        std::vector<LadronismElement> ladronism;
        std::vector<LandlubberlyElement> landlubberly;
        std::vector<Listener> listener;
        std::vector<LupusElement> lupus;
        std::vector<Maslin> maslin;
        std::vector<MonaziteElement> monazite;
        std::vector<Monoliteral> monoliteral;
        std::vector<MonotheisticallyElement> monotheistically;
        std::vector<Montage> montage;
        std::vector<Moralness> moralness;
        std::vector<std::optional<MonaziteClass>> mowra;
        std::vector<Mulishly> mulishly;
        std::vector<Myoscope> myoscope;
        std::vector<std::optional<std::vector<std::optional<int64_t>>>> nach;
        std::vector<Neuromastic> neuromastic;
        std::vector<Noncontributing> noncontributing;
        std::vector<Nonnervous> nonnervous;
        std::vector<Nonvaluation> nonvaluation;
        std::vector<OccupationalistElement> occupationalist;
        std::vector<OutrivalElement> outrival;
        std::vector<Paleographically> paleographically;
        std::vector<Pamphletwise> pamphletwise;
        std::vector<Pediatric> pediatrics;
        std::vector<bool> perceptive;
        std::vector<PiaculumElement> piaculum;
        std::vector<Piccadilly> piccadilly;
        std::vector<Piffler> piffler;
        std::vector<Pithful> pithful;
        std::vector<Placuntiti> placuntitis;
        std::vector<Plectopterous> plectopterous;
        std::vector<std::optional<Pneumocele>> pneumocele;
        std::vector<Poliorcetic> poliorcetic;
        std::vector<Poormaster> poormaster;
        std::vector<PotwhiskyElement> potwhisky;
        std::vector<Practicalizer> practicalizer;
        std::vector<PrefreshmanElement> prefreshman;
        std::vector<Prehensility> prehensility;
        std::vector<Prevoidance> prevoidance;
        std::vector<std::map<std::string, std::optional<int64_t>>> probant;
        std::vector<Protext> protext;

        public:
        std::vector<JurorElement> const & get_juror() const { return juror; }
        std::vector<JurorElement> & get_mutable_juror() { return juror; }
        void set_juror(std::vector<JurorElement> const & value) { this->juror = value; }

        std::vector<Kongoni> const & get_kongoni() const { return kongoni; }
        std::vector<Kongoni> & get_mutable_kongoni() { return kongoni; }
        void set_kongoni(std::vector<Kongoni> const & value) { this->kongoni = value; }

        std::vector<LadronismElement> const & get_ladronism() const { return ladronism; }
        std::vector<LadronismElement> & get_mutable_ladronism() { return ladronism; }
        void set_ladronism(std::vector<LadronismElement> const & value) { this->ladronism = value; }

        std::vector<LandlubberlyElement> const & get_landlubberly() const { return landlubberly; }
        std::vector<LandlubberlyElement> & get_mutable_landlubberly() { return landlubberly; }
        void set_landlubberly(std::vector<LandlubberlyElement> const & value) { this->landlubberly = value; }

        std::vector<Listener> const & get_listener() const { return listener; }
        std::vector<Listener> & get_mutable_listener() { return listener; }
        void set_listener(std::vector<Listener> const & value) { this->listener = value; }

        std::vector<LupusElement> const & get_lupus() const { return lupus; }
        std::vector<LupusElement> & get_mutable_lupus() { return lupus; }
        void set_lupus(std::vector<LupusElement> const & value) { this->lupus = value; }

        std::vector<Maslin> const & get_maslin() const { return maslin; }
        std::vector<Maslin> & get_mutable_maslin() { return maslin; }
        void set_maslin(std::vector<Maslin> const & value) { this->maslin = value; }

        std::vector<MonaziteElement> const & get_monazite() const { return monazite; }
        std::vector<MonaziteElement> & get_mutable_monazite() { return monazite; }
        void set_monazite(std::vector<MonaziteElement> const & value) { this->monazite = value; }

        std::vector<Monoliteral> const & get_monoliteral() const { return monoliteral; }
        std::vector<Monoliteral> & get_mutable_monoliteral() { return monoliteral; }
        void set_monoliteral(std::vector<Monoliteral> const & value) { this->monoliteral = value; }

        std::vector<MonotheisticallyElement> const & get_monotheistically() const { return monotheistically; }
        std::vector<MonotheisticallyElement> & get_mutable_monotheistically() { return monotheistically; }
        void set_monotheistically(std::vector<MonotheisticallyElement> const & value) { this->monotheistically = value; }

        std::vector<Montage> const & get_montage() const { return montage; }
        std::vector<Montage> & get_mutable_montage() { return montage; }
        void set_montage(std::vector<Montage> const & value) { this->montage = value; }

        std::vector<Moralness> const & get_moralness() const { return moralness; }
        std::vector<Moralness> & get_mutable_moralness() { return moralness; }
        void set_moralness(std::vector<Moralness> const & value) { this->moralness = value; }

        std::vector<std::optional<MonaziteClass>> const & get_mowra() const { return mowra; }
        std::vector<std::optional<MonaziteClass>> & get_mutable_mowra() { return mowra; }
        void set_mowra(std::vector<std::optional<MonaziteClass>> const & value) { this->mowra = value; }

        std::vector<Mulishly> const & get_mulishly() const { return mulishly; }
        std::vector<Mulishly> & get_mutable_mulishly() { return mulishly; }
        void set_mulishly(std::vector<Mulishly> const & value) { this->mulishly = value; }

        std::vector<Myoscope> const & get_myoscope() const { return myoscope; }
        std::vector<Myoscope> & get_mutable_myoscope() { return myoscope; }
        void set_myoscope(std::vector<Myoscope> const & value) { this->myoscope = value; }

        std::vector<std::optional<std::vector<std::optional<int64_t>>>> const & get_nach() const { return nach; }
        std::vector<std::optional<std::vector<std::optional<int64_t>>>> & get_mutable_nach() { return nach; }
        void set_nach(std::vector<std::optional<std::vector<std::optional<int64_t>>>> const & value) { this->nach = value; }

        std::vector<Neuromastic> const & get_neuromastic() const { return neuromastic; }
        std::vector<Neuromastic> & get_mutable_neuromastic() { return neuromastic; }
        void set_neuromastic(std::vector<Neuromastic> const & value) { this->neuromastic = value; }

        std::vector<Noncontributing> const & get_noncontributing() const { return noncontributing; }
        std::vector<Noncontributing> & get_mutable_noncontributing() { return noncontributing; }
        void set_noncontributing(std::vector<Noncontributing> const & value) { this->noncontributing = value; }

        std::vector<Nonnervous> const & get_nonnervous() const { return nonnervous; }
        std::vector<Nonnervous> & get_mutable_nonnervous() { return nonnervous; }
        void set_nonnervous(std::vector<Nonnervous> const & value) { this->nonnervous = value; }

        std::vector<Nonvaluation> const & get_nonvaluation() const { return nonvaluation; }
        std::vector<Nonvaluation> & get_mutable_nonvaluation() { return nonvaluation; }
        void set_nonvaluation(std::vector<Nonvaluation> const & value) { this->nonvaluation = value; }

        std::vector<OccupationalistElement> const & get_occupationalist() const { return occupationalist; }
        std::vector<OccupationalistElement> & get_mutable_occupationalist() { return occupationalist; }
        void set_occupationalist(std::vector<OccupationalistElement> const & value) { this->occupationalist = value; }

        std::vector<OutrivalElement> const & get_outrival() const { return outrival; }
        std::vector<OutrivalElement> & get_mutable_outrival() { return outrival; }
        void set_outrival(std::vector<OutrivalElement> const & value) { this->outrival = value; }

        std::vector<Paleographically> const & get_paleographically() const { return paleographically; }
        std::vector<Paleographically> & get_mutable_paleographically() { return paleographically; }
        void set_paleographically(std::vector<Paleographically> const & value) { this->paleographically = value; }

        std::vector<Pamphletwise> const & get_pamphletwise() const { return pamphletwise; }
        std::vector<Pamphletwise> & get_mutable_pamphletwise() { return pamphletwise; }
        void set_pamphletwise(std::vector<Pamphletwise> const & value) { this->pamphletwise = value; }

        std::vector<Pediatric> const & get_pediatrics() const { return pediatrics; }
        std::vector<Pediatric> & get_mutable_pediatrics() { return pediatrics; }
        void set_pediatrics(std::vector<Pediatric> const & value) { this->pediatrics = value; }

        std::vector<bool> const & get_perceptive() const { return perceptive; }
        std::vector<bool> & get_mutable_perceptive() { return perceptive; }
        void set_perceptive(std::vector<bool> const & value) { this->perceptive = value; }

        std::vector<PiaculumElement> const & get_piaculum() const { return piaculum; }
        std::vector<PiaculumElement> & get_mutable_piaculum() { return piaculum; }
        void set_piaculum(std::vector<PiaculumElement> const & value) { this->piaculum = value; }

        std::vector<Piccadilly> const & get_piccadilly() const { return piccadilly; }
        std::vector<Piccadilly> & get_mutable_piccadilly() { return piccadilly; }
        void set_piccadilly(std::vector<Piccadilly> const & value) { this->piccadilly = value; }

        std::vector<Piffler> const & get_piffler() const { return piffler; }
        std::vector<Piffler> & get_mutable_piffler() { return piffler; }
        void set_piffler(std::vector<Piffler> const & value) { this->piffler = value; }

        std::vector<Pithful> const & get_pithful() const { return pithful; }
        std::vector<Pithful> & get_mutable_pithful() { return pithful; }
        void set_pithful(std::vector<Pithful> const & value) { this->pithful = value; }

        std::vector<Placuntiti> const & get_placuntitis() const { return placuntitis; }
        std::vector<Placuntiti> & get_mutable_placuntitis() { return placuntitis; }
        void set_placuntitis(std::vector<Placuntiti> const & value) { this->placuntitis = value; }

        std::vector<Plectopterous> const & get_plectopterous() const { return plectopterous; }
        std::vector<Plectopterous> & get_mutable_plectopterous() { return plectopterous; }
        void set_plectopterous(std::vector<Plectopterous> const & value) { this->plectopterous = value; }

        std::vector<std::optional<Pneumocele>> const & get_pneumocele() const { return pneumocele; }
        std::vector<std::optional<Pneumocele>> & get_mutable_pneumocele() { return pneumocele; }
        void set_pneumocele(std::vector<std::optional<Pneumocele>> const & value) { this->pneumocele = value; }

        std::vector<Poliorcetic> const & get_poliorcetic() const { return poliorcetic; }
        std::vector<Poliorcetic> & get_mutable_poliorcetic() { return poliorcetic; }
        void set_poliorcetic(std::vector<Poliorcetic> const & value) { this->poliorcetic = value; }

        std::vector<Poormaster> const & get_poormaster() const { return poormaster; }
        std::vector<Poormaster> & get_mutable_poormaster() { return poormaster; }
        void set_poormaster(std::vector<Poormaster> const & value) { this->poormaster = value; }

        std::vector<PotwhiskyElement> const & get_potwhisky() const { return potwhisky; }
        std::vector<PotwhiskyElement> & get_mutable_potwhisky() { return potwhisky; }
        void set_potwhisky(std::vector<PotwhiskyElement> const & value) { this->potwhisky = value; }

        std::vector<Practicalizer> const & get_practicalizer() const { return practicalizer; }
        std::vector<Practicalizer> & get_mutable_practicalizer() { return practicalizer; }
        void set_practicalizer(std::vector<Practicalizer> const & value) { this->practicalizer = value; }

        std::vector<PrefreshmanElement> const & get_prefreshman() const { return prefreshman; }
        std::vector<PrefreshmanElement> & get_mutable_prefreshman() { return prefreshman; }
        void set_prefreshman(std::vector<PrefreshmanElement> const & value) { this->prefreshman = value; }

        std::vector<Prehensility> const & get_prehensility() const { return prehensility; }
        std::vector<Prehensility> & get_mutable_prehensility() { return prehensility; }
        void set_prehensility(std::vector<Prehensility> const & value) { this->prehensility = value; }

        std::vector<Prevoidance> const & get_prevoidance() const { return prevoidance; }
        std::vector<Prevoidance> & get_mutable_prevoidance() { return prevoidance; }
        void set_prevoidance(std::vector<Prevoidance> const & value) { this->prevoidance = value; }

        std::vector<std::map<std::string, std::optional<int64_t>>> const & get_probant() const { return probant; }
        std::vector<std::map<std::string, std::optional<int64_t>>> & get_mutable_probant() { return probant; }
        void set_probant(std::vector<std::map<std::string, std::optional<int64_t>>> const & value) { this->probant = value; }

        std::vector<Protext> const & get_protext() const { return protext; }
        std::vector<Protext> & get_mutable_protext() { return protext; }
        void set_protext(std::vector<Protext> const & value) { this->protext = value; }
    };
}

namespace quicktype {
void from_json(json const & j, JurorClass & x);
void to_json(json & j, JurorClass const & x);

void from_json(json const & j, LadronismClass & x);
void to_json(json & j, LadronismClass const & x);

void from_json(json const & j, LandlubberlyClass & x);
void to_json(json & j, LandlubberlyClass const & x);

void from_json(json const & j, LupusClass & x);
void to_json(json & j, LupusClass const & x);

void from_json(json const & j, Maslin & x);
void to_json(json & j, Maslin const & x);

void from_json(json const & j, MonaziteClass & x);
void to_json(json & j, MonaziteClass const & x);

void from_json(json const & j, MonotheisticallyClass & x);
void to_json(json & j, MonotheisticallyClass const & x);

void from_json(json const & j, Noncontributing & x);
void to_json(json & j, Noncontributing const & x);

void from_json(json const & j, OccupationalistClass & x);
void to_json(json & j, OccupationalistClass const & x);

void from_json(json const & j, OutrivalClass & x);
void to_json(json & j, OutrivalClass const & x);

void from_json(json const & j, PiaculumClass & x);
void to_json(json & j, PiaculumClass const & x);

void from_json(json const & j, Pneumocele & x);
void to_json(json & j, Pneumocele const & x);

void from_json(json const & j, PotwhiskyClass & x);
void to_json(json & j, PotwhiskyClass const & x);

void from_json(json const & j, PrefreshmanClass & x);
void to_json(json & j, PrefreshmanClass const & x);

void from_json(json const & j, TopLevel & x);
void to_json(json & j, TopLevel const & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, quicktype::JurorClass>> {
    static void from_json(json const & j, std::variant<bool, quicktype::JurorClass> & x);
    static void to_json(json & j, std::variant<bool, quicktype::JurorClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LadronismClass, double, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::LadronismClass, double, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::LadronismClass, double, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::LandlubberlyClass, int64_t>> {
    static void from_json(json const & j, std::variant<bool, quicktype::LandlubberlyClass, int64_t> & x);
    static void to_json(json & j, std::variant<bool, quicktype::LandlubberlyClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<json>, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<json>, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LupusClass, int64_t>> {
    static void from_json(json const & j, std::variant<quicktype::LupusClass, int64_t> & x);
    static void to_json(json & j, std::variant<quicktype::LupusClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::MonaziteClass, double>> {
    static void from_json(json const & j, std::variant<quicktype::MonaziteClass, double> & x);
    static void to_json(json & j, std::variant<quicktype::MonaziteClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::MonotheisticallyClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::MonotheisticallyClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::MonotheisticallyClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<json>, double, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<json>, double, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double>> {
    static void from_json(json const & j, std::variant<std::vector<json>, double> & x);
    static void to_json(json & j, std::variant<std::vector<json>, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, double> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<bool, int64_t>> {
    static void from_json(json const & j, std::variant<bool, int64_t> & x);
    static void to_json(json & j, std::variant<bool, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, double>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool, double> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::OccupationalistClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::OccupationalistClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::OccupationalistClass> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::OutrivalClass, double>> {
    static void from_json(json const & j, std::variant<quicktype::OutrivalClass, double> & x);
    static void to_json(json & j, std::variant<quicktype::OutrivalClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(json const & j, std::variant<double, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, std::variant<double, std::map<std::string, std::optional<int64_t>>> const & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<int64_t, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<int64_t, std::map<std::string, int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(json const & j, std::variant<bool, double> & x);
    static void to_json(json & j, std::variant<bool, double> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PiaculumClass, double>> {
    static void from_json(json const & j, std::variant<quicktype::PiaculumClass, double> & x);
    static void to_json(json & j, std::variant<quicktype::PiaculumClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(json const & j, std::variant<double, std::string> & x);
    static void to_json(json & j, std::variant<double, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::MonaziteClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::MonaziteClass> const & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<int64_t, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<double, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::MonaziteClass>> {
    static void from_json(json const & j, std::variant<bool, quicktype::MonaziteClass> & x);
    static void to_json(json & j, std::variant<bool, quicktype::MonaziteClass> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PotwhiskyClass, int64_t>> {
    static void from_json(json const & j, std::variant<quicktype::PotwhiskyClass, int64_t> & x);
    static void to_json(json & j, std::variant<quicktype::PotwhiskyClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, quicktype::MonaziteClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool, quicktype::MonaziteClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool, quicktype::MonaziteClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> const & x);
};
}
namespace quicktype {
    inline void from_json(json const & j, JurorClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_adipsy(get_untyped(j, "adipsy"));
        x.set_auxiliator(get_untyped(j, "auxiliator"));
        x.set_benda(get_untyped(j, "benda"));
        x.set_benjamin(get_untyped(j, "benjamin"));
        x.set_brandling(get_untyped(j, "brandling"));
        x.set_epicurishly(get_untyped(j, "epicurishly"));
        x.set_eremochaetous(get_untyped(j, "eremochaetous"));
        x.set_marten(get_untyped(j, "marten"));
        x.set_monocline(get_untyped(j, "monocline"));
        x.set_olea(get_untyped(j, "Olea"));
        x.set_palgat(get_untyped(j, "palgat"));
        x.set_pennyworth(get_untyped(j, "pennyworth"));
        x.set_pioury(get_untyped(j, "pioury"));
        x.set_pragmatistic(get_untyped(j, "pragmatistic"));
        x.set_stylelessness(get_untyped(j, "stylelessness"));
        x.set_systematical(get_untyped(j, "systematical"));
        x.set_thready(get_untyped(j, "thready"));
        x.set_uncontemporary(get_untyped(j, "uncontemporary"));
        x.set_uncouched(get_untyped(j, "uncouched"));
        x.set_uninhabitedness(get_untyped(j, "uninhabitedness"));
    }

    inline void to_json(json & j, JurorClass const & x) {
        j = json::object();
        j["adipsy"] = x.get_adipsy();
        j["auxiliator"] = x.get_auxiliator();
        j["benda"] = x.get_benda();
        j["benjamin"] = x.get_benjamin();
        j["brandling"] = x.get_brandling();
        j["epicurishly"] = x.get_epicurishly();
        j["eremochaetous"] = x.get_eremochaetous();
        j["marten"] = x.get_marten();
        j["monocline"] = x.get_monocline();
        j["Olea"] = x.get_olea();
        j["palgat"] = x.get_palgat();
        j["pennyworth"] = x.get_pennyworth();
        j["pioury"] = x.get_pioury();
        j["pragmatistic"] = x.get_pragmatistic();
        j["stylelessness"] = x.get_stylelessness();
        j["systematical"] = x.get_systematical();
        j["thready"] = x.get_thready();
        j["uncontemporary"] = x.get_uncontemporary();
        j["uncouched"] = x.get_uncouched();
        j["uninhabitedness"] = x.get_uninhabitedness();
    }

    inline void from_json(json const & j, LadronismClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_acclaimer(get_untyped(j, "acclaimer"));
        x.set_achree(get_untyped(j, "achree"));
        x.set_base(get_untyped(j, "base"));
        x.set_conundrumize(get_untyped(j, "conundrumize"));
        x.set_degerminator(get_untyped(j, "degerminator"));
        x.set_describable(get_untyped(j, "describable"));
        x.set_exasperatedly(get_untyped(j, "exasperatedly"));
        x.set_heroine(get_untyped(j, "heroine"));
        x.set_indazin(get_untyped(j, "indazin"));
        x.set_luteous(get_untyped(j, "luteous"));
        x.set_papular(get_untyped(j, "papular"));
        x.set_pritch(get_untyped(j, "pritch"));
        x.set_prodenia(get_untyped(j, "Prodenia"));
        x.set_seege(get_untyped(j, "seege"));
        x.set_shopgirl(get_untyped(j, "shopgirl"));
        x.set_tragedietta(get_untyped(j, "tragedietta"));
        x.set_unsparse(get_untyped(j, "unsparse"));
        x.set_uplook(get_untyped(j, "uplook"));
        x.set_vermiformis(get_untyped(j, "vermiformis"));
        x.set_whafabout(get_untyped(j, "whafabout"));
    }

    inline void to_json(json & j, LadronismClass const & x) {
        j = json::object();
        j["acclaimer"] = x.get_acclaimer();
        j["achree"] = x.get_achree();
        j["base"] = x.get_base();
        j["conundrumize"] = x.get_conundrumize();
        j["degerminator"] = x.get_degerminator();
        j["describable"] = x.get_describable();
        j["exasperatedly"] = x.get_exasperatedly();
        j["heroine"] = x.get_heroine();
        j["indazin"] = x.get_indazin();
        j["luteous"] = x.get_luteous();
        j["papular"] = x.get_papular();
        j["pritch"] = x.get_pritch();
        j["Prodenia"] = x.get_prodenia();
        j["seege"] = x.get_seege();
        j["shopgirl"] = x.get_shopgirl();
        j["tragedietta"] = x.get_tragedietta();
        j["unsparse"] = x.get_unsparse();
        j["uplook"] = x.get_uplook();
        j["vermiformis"] = x.get_vermiformis();
        j["whafabout"] = x.get_whafabout();
    }

    inline void from_json(json const & j, LandlubberlyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_acropoleis(get_untyped(j, "acropoleis"));
        x.set_aminate(get_untyped(j, "aminate"));
        x.set_amyraldism(get_untyped(j, "Amyraldism"));
        x.set_bipenniform(get_untyped(j, "bipenniform"));
        x.set_bugre(get_untyped(j, "bugre"));
        x.set_calycule(get_untyped(j, "calycule"));
        x.set_caoutchouc(get_untyped(j, "caoutchouc"));
        x.set_disprover(get_untyped(j, "disprover"));
        x.set_fitroot(get_untyped(j, "fitroot"));
        x.set_fulgently(get_untyped(j, "fulgently"));
        x.set_kickup(get_untyped(j, "kickup"));
        x.set_laevoversion(get_untyped(j, "laevoversion"));
        x.set_moter(get_untyped(j, "moter"));
        x.set_objectivity(get_untyped(j, "objectivity"));
        x.set_posterity(get_untyped(j, "posterity"));
        x.set_postnuptial(get_untyped(j, "postnuptial"));
        x.set_precedentary(get_untyped(j, "precedentary"));
        x.set_saddling(get_untyped(j, "saddling"));
        x.set_subcurrent(get_untyped(j, "subcurrent"));
        x.set_unrecriminative(get_untyped(j, "unrecriminative"));
    }

    inline void to_json(json & j, LandlubberlyClass const & x) {
        j = json::object();
        j["acropoleis"] = x.get_acropoleis();
        j["aminate"] = x.get_aminate();
        j["Amyraldism"] = x.get_amyraldism();
        j["bipenniform"] = x.get_bipenniform();
        j["bugre"] = x.get_bugre();
        j["calycule"] = x.get_calycule();
        j["caoutchouc"] = x.get_caoutchouc();
        j["disprover"] = x.get_disprover();
        j["fitroot"] = x.get_fitroot();
        j["fulgently"] = x.get_fulgently();
        j["kickup"] = x.get_kickup();
        j["laevoversion"] = x.get_laevoversion();
        j["moter"] = x.get_moter();
        j["objectivity"] = x.get_objectivity();
        j["posterity"] = x.get_posterity();
        j["postnuptial"] = x.get_postnuptial();
        j["precedentary"] = x.get_precedentary();
        j["saddling"] = x.get_saddling();
        j["subcurrent"] = x.get_subcurrent();
        j["unrecriminative"] = x.get_unrecriminative();
    }

    inline void from_json(json const & j, LupusClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("Chlorioninae") != j.end() && !j.at("Chlorioninae").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chlorioninae") != j.end() && j.at("Chlorioninae").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chlorioninae(get_stack_optional<int64_t>(j, "Chlorioninae"));
        if (j.find("Corvinae") != j.end() && !j.at("Corvinae").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Corvinae") != j.end() && j.at("Corvinae").is_null()) throw std::runtime_error("Unexpected null");
        x.set_corvinae(get_stack_optional<int64_t>(j, "Corvinae"));
        if (j.find("Crassina") != j.end() && !j.at("Crassina").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Crassina") != j.end() && j.at("Crassina").is_null()) throw std::runtime_error("Unexpected null");
        x.set_crassina(get_stack_optional<int64_t>(j, "Crassina"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("exiguity") != j.end() && !j.at("exiguity").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("exiguity") != j.end() && j.at("exiguity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_exiguity(get_stack_optional<int64_t>(j, "exiguity"));
        if (j.find("farcist") != j.end() && !j.at("farcist").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("farcist") != j.end() && j.at("farcist").is_null()) throw std::runtime_error("Unexpected null");
        x.set_farcist(get_stack_optional<int64_t>(j, "farcist"));
        if (j.find("holographical") != j.end() && !j.at("holographical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("holographical") != j.end() && j.at("holographical").is_null()) throw std::runtime_error("Unexpected null");
        x.set_holographical(get_stack_optional<int64_t>(j, "holographical"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("ichthyophagan") != j.end() && !j.at("ichthyophagan").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ichthyophagan") != j.end() && j.at("ichthyophagan").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ichthyophagan(get_stack_optional<int64_t>(j, "ichthyophagan"));
        if (j.find("implacable") != j.end() && !j.at("implacable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("implacable") != j.end() && j.at("implacable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_implacable(get_stack_optional<int64_t>(j, "implacable"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("outshiner") != j.end() && !j.at("outshiner").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("outshiner") != j.end() && j.at("outshiner").is_null()) throw std::runtime_error("Unexpected null");
        x.set_outshiner(get_stack_optional<int64_t>(j, "outshiner"));
        if (j.find("overweather") != j.end() && !j.at("overweather").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("overweather") != j.end() && j.at("overweather").is_null()) throw std::runtime_error("Unexpected null");
        x.set_overweather(get_stack_optional<int64_t>(j, "overweather"));
        if (j.find("protonegroid") != j.end() && !j.at("protonegroid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("protonegroid") != j.end() && j.at("protonegroid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_protonegroid(get_stack_optional<int64_t>(j, "protonegroid"));
        if (j.find("shallowish") != j.end() && !j.at("shallowish").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("shallowish") != j.end() && j.at("shallowish").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shallowish(get_stack_optional<int64_t>(j, "shallowish"));
        if (j.find("snoke") != j.end() && !j.at("snoke").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("snoke") != j.end() && j.at("snoke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_snoke(get_stack_optional<int64_t>(j, "snoke"));
        if (j.find("snout") != j.end() && !j.at("snout").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("snout") != j.end() && j.at("snout").is_null()) throw std::runtime_error("Unexpected null");
        x.set_snout(get_stack_optional<int64_t>(j, "snout"));
        if (j.find("surveillance") != j.end() && !j.at("surveillance").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("surveillance") != j.end() && j.at("surveillance").is_null()) throw std::runtime_error("Unexpected null");
        x.set_surveillance(get_stack_optional<int64_t>(j, "surveillance"));
        if (j.find("threshingtime") != j.end() && !j.at("threshingtime").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("threshingtime") != j.end() && j.at("threshingtime").is_null()) throw std::runtime_error("Unexpected null");
        x.set_threshingtime(get_stack_optional<int64_t>(j, "threshingtime"));
        if (j.find("Thysanocarpus") != j.end() && !j.at("Thysanocarpus").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Thysanocarpus") != j.end() && j.at("Thysanocarpus").is_null()) throw std::runtime_error("Unexpected null");
        x.set_thysanocarpus(get_stack_optional<int64_t>(j, "Thysanocarpus"));
        if (j.find("unsignificantly") != j.end() && !j.at("unsignificantly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unsignificantly") != j.end() && j.at("unsignificantly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unsignificantly(get_stack_optional<int64_t>(j, "unsignificantly"));
        if (j.find("unsnap") != j.end() && !j.at("unsnap").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unsnap") != j.end() && j.at("unsnap").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unsnap(get_stack_optional<int64_t>(j, "unsnap"));
        if (j.find("vendible") != j.end() && !j.at("vendible").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("vendible") != j.end() && j.at("vendible").is_null()) throw std::runtime_error("Unexpected null");
        x.set_vendible(get_stack_optional<int64_t>(j, "vendible"));
    }

    inline void to_json(json & j, LupusClass const & x) {
        j = json::object();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["Chlorioninae"] = x.get_chlorioninae();
        j["Corvinae"] = x.get_corvinae();
        j["Crassina"] = x.get_crassina();
        j["disdiapason"] = x.get_disdiapason();
        j["exiguity"] = x.get_exiguity();
        j["farcist"] = x.get_farcist();
        j["holographical"] = x.get_holographical();
        j["homocerc"] = x.get_homocerc();
        j["ichthyophagan"] = x.get_ichthyophagan();
        j["implacable"] = x.get_implacable();
        j["nonbookish"] = x.get_nonbookish();
        j["outshiner"] = x.get_outshiner();
        j["overweather"] = x.get_overweather();
        j["protonegroid"] = x.get_protonegroid();
        j["shallowish"] = x.get_shallowish();
        j["snoke"] = x.get_snoke();
        j["snout"] = x.get_snout();
        j["surveillance"] = x.get_surveillance();
        j["threshingtime"] = x.get_threshingtime();
        j["Thysanocarpus"] = x.get_thysanocarpus();
        j["unsignificantly"] = x.get_unsignificantly();
        j["unsnap"] = x.get_unsnap();
        j["vendible"] = x.get_vendible();
    }

    inline void from_json(json const & j, Maslin& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Alicant") != j.end() && !j.at("Alicant").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Alicant") != j.end() && j.at("Alicant").is_null()) throw std::runtime_error("Unexpected null");
        x.set_alicant(get_stack_optional<int64_t>(j, "Alicant"));
        x.set_antiatonement(get_untyped(j, "antiatonement"));
        if (j.find("anticorrosive") != j.end() && !j.at("anticorrosive").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("anticorrosive") != j.end() && j.at("anticorrosive").is_null()) throw std::runtime_error("Unexpected null");
        x.set_anticorrosive(get_stack_optional<int64_t>(j, "anticorrosive"));
        x.set_aphidozer(get_untyped(j, "aphidozer"));
        x.set_bakuninist(get_untyped(j, "Bakuninist"));
        if (j.find("be") != j.end() && !j.at("be").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("be") != j.end() && j.at("be").is_null()) throw std::runtime_error("Unexpected null");
        x.set_be(get_stack_optional<int64_t>(j, "be"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("chub") != j.end() && !j.at("chub").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("chub") != j.end() && j.at("chub").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chub(get_stack_optional<int64_t>(j, "chub"));
        if (j.find("cuprosilicon") != j.end() && !j.at("cuprosilicon").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("cuprosilicon") != j.end() && j.at("cuprosilicon").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cuprosilicon(get_stack_optional<int64_t>(j, "cuprosilicon"));
        if (j.find("curtailedly") != j.end() && !j.at("curtailedly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("curtailedly") != j.end() && j.at("curtailedly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_curtailedly(get_stack_optional<int64_t>(j, "curtailedly"));
        if (j.find("dellenite") != j.end() && !j.at("dellenite").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("dellenite") != j.end() && j.at("dellenite").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dellenite(get_stack_optional<int64_t>(j, "dellenite"));
        if (j.find("Dimitry") != j.end() && !j.at("Dimitry").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Dimitry") != j.end() && j.at("Dimitry").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dimitry(get_stack_optional<int64_t>(j, "Dimitry"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_edifying(get_untyped(j, "edifying"));
        if (j.find("ethmoiditis") != j.end() && !j.at("ethmoiditis").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ethmoiditis") != j.end() && j.at("ethmoiditis").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ethmoiditis(get_stack_optional<int64_t>(j, "ethmoiditis"));
        x.set_gastralgy(get_untyped(j, "gastralgy"));
        if (j.find("goatherd") != j.end() && !j.at("goatherd").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("goatherd") != j.end() && j.at("goatherd").is_null()) throw std::runtime_error("Unexpected null");
        x.set_goatherd(get_stack_optional<int64_t>(j, "goatherd"));
        if (j.find("hammerdress") != j.end() && !j.at("hammerdress").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hammerdress") != j.end() && j.at("hammerdress").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hammerdress(get_stack_optional<int64_t>(j, "hammerdress"));
        x.set_hangfire(get_untyped(j, "hangfire"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("lacunosity") != j.end() && !j.at("lacunosity").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lacunosity") != j.end() && j.at("lacunosity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lacunosity(get_stack_optional<int64_t>(j, "lacunosity"));
        x.set_longiloquence(get_untyped(j, "longiloquence"));
        if (j.find("mameliere") != j.end() && !j.at("mameliere").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mameliere") != j.end() && j.at("mameliere").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mameliere(get_stack_optional<int64_t>(j, "mameliere"));
        x.set_motherless(get_untyped(j, "motherless"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_noncorrodible(get_untyped(j, "noncorrodible"));
        x.set_nonsensicality(get_untyped(j, "nonsensicality"));
        if (j.find("oafishly") != j.end() && !j.at("oafishly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("oafishly") != j.end() && j.at("oafishly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_oafishly(get_stack_optional<int64_t>(j, "oafishly"));
        x.set_pfund(get_untyped(j, "pfund"));
        x.set_preadvisory(get_untyped(j, "preadvisory"));
        x.set_retroflexed(get_untyped(j, "retroflexed"));
        if (j.find("saccharulmic") != j.end() && !j.at("saccharulmic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("saccharulmic") != j.end() && j.at("saccharulmic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_saccharulmic(get_stack_optional<int64_t>(j, "saccharulmic"));
        if (j.find("scowlful") != j.end() && !j.at("scowlful").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("scowlful") != j.end() && j.at("scowlful").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scowlful(get_stack_optional<int64_t>(j, "scowlful"));
        x.set_secluded(get_untyped(j, "secluded"));
        x.set_slackage(get_untyped(j, "slackage"));
        if (j.find("sphaeridial") != j.end() && !j.at("sphaeridial").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sphaeridial") != j.end() && j.at("sphaeridial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sphaeridial(get_stack_optional<int64_t>(j, "sphaeridial"));
        x.set_spondulics(get_untyped(j, "spondulics"));
        if (j.find("subsecive") != j.end() && !j.at("subsecive").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("subsecive") != j.end() && j.at("subsecive").is_null()) throw std::runtime_error("Unexpected null");
        x.set_subsecive(get_stack_optional<int64_t>(j, "subsecive"));
        x.set_swellmobsman(get_untyped(j, "swellmobsman"));
        if (j.find("trachyglossate") != j.end() && !j.at("trachyglossate").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("trachyglossate") != j.end() && j.at("trachyglossate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_trachyglossate(get_stack_optional<int64_t>(j, "trachyglossate"));
        x.set_trialogue(get_untyped(j, "trialogue"));
        if (j.find("unassuaged") != j.end() && !j.at("unassuaged").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unassuaged") != j.end() && j.at("unassuaged").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unassuaged(get_stack_optional<int64_t>(j, "unassuaged"));
        x.set_ungross(get_untyped(j, "ungross"));
        x.set_unjudiciously(get_untyped(j, "unjudiciously"));
    }

    inline void to_json(json & j, Maslin const & x) {
        j = json::object();
        j["Alicant"] = x.get_alicant();
        j["antiatonement"] = x.get_antiatonement();
        j["anticorrosive"] = x.get_anticorrosive();
        j["aphidozer"] = x.get_aphidozer();
        j["Bakuninist"] = x.get_bakuninist();
        j["be"] = x.get_be();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["chub"] = x.get_chub();
        j["cuprosilicon"] = x.get_cuprosilicon();
        j["curtailedly"] = x.get_curtailedly();
        j["dellenite"] = x.get_dellenite();
        j["Dimitry"] = x.get_dimitry();
        j["disdiapason"] = x.get_disdiapason();
        j["edifying"] = x.get_edifying();
        j["ethmoiditis"] = x.get_ethmoiditis();
        j["gastralgy"] = x.get_gastralgy();
        j["goatherd"] = x.get_goatherd();
        j["hammerdress"] = x.get_hammerdress();
        j["hangfire"] = x.get_hangfire();
        j["homocerc"] = x.get_homocerc();
        j["lacunosity"] = x.get_lacunosity();
        j["longiloquence"] = x.get_longiloquence();
        j["mameliere"] = x.get_mameliere();
        j["motherless"] = x.get_motherless();
        j["nonbookish"] = x.get_nonbookish();
        j["noncorrodible"] = x.get_noncorrodible();
        j["nonsensicality"] = x.get_nonsensicality();
        j["oafishly"] = x.get_oafishly();
        j["pfund"] = x.get_pfund();
        j["preadvisory"] = x.get_preadvisory();
        j["retroflexed"] = x.get_retroflexed();
        j["saccharulmic"] = x.get_saccharulmic();
        j["scowlful"] = x.get_scowlful();
        j["secluded"] = x.get_secluded();
        j["slackage"] = x.get_slackage();
        j["sphaeridial"] = x.get_sphaeridial();
        j["spondulics"] = x.get_spondulics();
        j["subsecive"] = x.get_subsecive();
        j["swellmobsman"] = x.get_swellmobsman();
        j["trachyglossate"] = x.get_trachyglossate();
        j["trialogue"] = x.get_trialogue();
        j["unassuaged"] = x.get_unassuaged();
        j["ungross"] = x.get_ungross();
        j["unjudiciously"] = x.get_unjudiciously();
    }

    inline void from_json(json const & j, MonaziteClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_catharticalness(j.at("catharticalness").get<double>());
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_chirotherium(j.at("Chirotherium").get<int64_t>());
        x.set_disdiapason(j.at("disdiapason").get<std::string>());
        x.set_homocerc(j.at("homocerc").get<bool>());
        x.set_nonbookish(get_untyped(j, "nonbookish"));
    }

    inline void to_json(json & j, MonaziteClass const & x) {
        j = json::object();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["homocerc"] = x.get_homocerc();
        j["nonbookish"] = x.get_nonbookish();
    }

    inline void from_json(json const & j, MonotheisticallyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_blaspheme(get_untyped(j, "blaspheme"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        x.set_celiosalpingectomy(get_untyped(j, "celiosalpingectomy"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        x.set_consummativeness(get_untyped(j, "consummativeness"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_egestive(get_untyped(j, "egestive"));
        x.set_enchylema(get_untyped(j, "enchylema"));
        x.set_gasconade(get_untyped(j, "gasconade"));
        x.set_holidayer(get_untyped(j, "holidayer"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_intuitionalism(get_untyped(j, "intuitionalism"));
        x.set_lophiostomate(get_untyped(j, "lophiostomate"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_nonvolition(get_untyped(j, "nonvolition"));
        x.set_palatableness(get_untyped(j, "palatableness"));
        x.set_pimpery(get_untyped(j, "pimpery"));
        x.set_previolation(get_untyped(j, "previolation"));
        x.set_reconveyance(get_untyped(j, "reconveyance"));
        x.set_registership(get_untyped(j, "registership"));
        x.set_rhyacolite(get_untyped(j, "rhyacolite"));
        x.set_smithereens(get_untyped(j, "smithereens"));
        x.set_superedification(get_untyped(j, "superedification"));
        x.set_trust(get_untyped(j, "trust"));
        x.set_whitestone(get_untyped(j, "whitestone"));
    }

    inline void to_json(json & j, MonotheisticallyClass const & x) {
        j = json::object();
        j["blaspheme"] = x.get_blaspheme();
        j["catharticalness"] = x.get_catharticalness();
        j["celiosalpingectomy"] = x.get_celiosalpingectomy();
        j["Chirotherium"] = x.get_chirotherium();
        j["consummativeness"] = x.get_consummativeness();
        j["disdiapason"] = x.get_disdiapason();
        j["egestive"] = x.get_egestive();
        j["enchylema"] = x.get_enchylema();
        j["gasconade"] = x.get_gasconade();
        j["holidayer"] = x.get_holidayer();
        j["homocerc"] = x.get_homocerc();
        j["intuitionalism"] = x.get_intuitionalism();
        j["lophiostomate"] = x.get_lophiostomate();
        j["nonbookish"] = x.get_nonbookish();
        j["nonvolition"] = x.get_nonvolition();
        j["palatableness"] = x.get_palatableness();
        j["pimpery"] = x.get_pimpery();
        j["previolation"] = x.get_previolation();
        j["reconveyance"] = x.get_reconveyance();
        j["registership"] = x.get_registership();
        j["rhyacolite"] = x.get_rhyacolite();
        j["smithereens"] = x.get_smithereens();
        j["superedification"] = x.get_superedification();
        j["trust"] = x.get_trust();
        j["whitestone"] = x.get_whitestone();
    }

    inline void from_json(json const & j, Noncontributing& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_estevin(j.at("estevin").get<std::string>());
        x.set_jolterhead(j.at("jolterhead").get<double>());
        if (j.find("sauternes") != j.end() && !j.at("sauternes").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sauternes(j.at("sauternes").get<int64_t>());
        x.set_sparsely(j.at("sparsely").get<bool>());
        x.set_unrequested(get_untyped(j, "unrequested"));
    }

    inline void to_json(json & j, Noncontributing const & x) {
        j = json::object();
        j["estevin"] = x.get_estevin();
        j["jolterhead"] = x.get_jolterhead();
        j["sauternes"] = x.get_sauternes();
        j["sparsely"] = x.get_sparsely();
        j["unrequested"] = x.get_unrequested();
    }

    inline void from_json(json const & j, OccupationalistClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_beholdable(get_untyped(j, "beholdable"));
        x.set_brotuliform(get_untyped(j, "brotuliform"));
        x.set_chimakum(get_untyped(j, "Chimakum"));
        x.set_doodler(get_untyped(j, "doodler"));
        x.set_emulsin(get_untyped(j, "emulsin"));
        x.set_fin(get_untyped(j, "Fin"));
        x.set_flourishing(get_untyped(j, "flourishing"));
        x.set_flueless(get_untyped(j, "flueless"));
        x.set_furtively(get_untyped(j, "furtively"));
        x.set_gritter(get_untyped(j, "gritter"));
        x.set_interwish(get_untyped(j, "interwish"));
        x.set_monoxylic(get_untyped(j, "monoxylic"));
        x.set_myristic(get_untyped(j, "myristic"));
        x.set_nightwear(get_untyped(j, "nightwear"));
        x.set_peruser(get_untyped(j, "peruser"));
        x.set_theoastrological(get_untyped(j, "theoastrological"));
        x.set_thumby(get_untyped(j, "thumby"));
        x.set_tingitid(get_untyped(j, "tingitid"));
        x.set_trailless(get_untyped(j, "trailless"));
        x.set_unpocketed(get_untyped(j, "unpocketed"));
    }

    inline void to_json(json & j, OccupationalistClass const & x) {
        j = json::object();
        j["beholdable"] = x.get_beholdable();
        j["brotuliform"] = x.get_brotuliform();
        j["Chimakum"] = x.get_chimakum();
        j["doodler"] = x.get_doodler();
        j["emulsin"] = x.get_emulsin();
        j["Fin"] = x.get_fin();
        j["flourishing"] = x.get_flourishing();
        j["flueless"] = x.get_flueless();
        j["furtively"] = x.get_furtively();
        j["gritter"] = x.get_gritter();
        j["interwish"] = x.get_interwish();
        j["monoxylic"] = x.get_monoxylic();
        j["myristic"] = x.get_myristic();
        j["nightwear"] = x.get_nightwear();
        j["peruser"] = x.get_peruser();
        j["theoastrological"] = x.get_theoastrological();
        j["thumby"] = x.get_thumby();
        j["tingitid"] = x.get_tingitid();
        j["trailless"] = x.get_trailless();
        j["unpocketed"] = x.get_unpocketed();
    }

    inline void from_json(json const & j, OutrivalClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_adroitly(get_untyped(j, "adroitly"));
        x.set_bridehood(get_untyped(j, "bridehood"));
        x.set_castoroides(get_untyped(j, "Castoroides"));
        x.set_czechoslovak(get_untyped(j, "Czechoslovak"));
        x.set_diagenesis(get_untyped(j, "diagenesis"));
        x.set_dihexahedron(get_untyped(j, "dihexahedron"));
        x.set_dopester(get_untyped(j, "dopester"));
        x.set_eumerism(get_untyped(j, "eumerism"));
        x.set_flyness(get_untyped(j, "flyness"));
        x.set_fouler(get_untyped(j, "fouler"));
        x.set_laudanosine(get_untyped(j, "laudanosine"));
        x.set_lingulidae(get_untyped(j, "Lingulidae"));
        x.set_minutary(get_untyped(j, "minutary"));
        x.set_mitra(get_untyped(j, "mitra"));
        x.set_opisthorchiasis(get_untyped(j, "opisthorchiasis"));
        x.set_pensively(get_untyped(j, "pensively"));
        x.set_pubigerous(get_untyped(j, "pubigerous"));
        x.set_rebellious(get_untyped(j, "rebellious"));
        x.set_recodify(get_untyped(j, "recodify"));
        x.set_unpaced(get_untyped(j, "unpaced"));
    }

    inline void to_json(json & j, OutrivalClass const & x) {
        j = json::object();
        j["adroitly"] = x.get_adroitly();
        j["bridehood"] = x.get_bridehood();
        j["Castoroides"] = x.get_castoroides();
        j["Czechoslovak"] = x.get_czechoslovak();
        j["diagenesis"] = x.get_diagenesis();
        j["dihexahedron"] = x.get_dihexahedron();
        j["dopester"] = x.get_dopester();
        j["eumerism"] = x.get_eumerism();
        j["flyness"] = x.get_flyness();
        j["fouler"] = x.get_fouler();
        j["laudanosine"] = x.get_laudanosine();
        j["Lingulidae"] = x.get_lingulidae();
        j["minutary"] = x.get_minutary();
        j["mitra"] = x.get_mitra();
        j["opisthorchiasis"] = x.get_opisthorchiasis();
        j["pensively"] = x.get_pensively();
        j["pubigerous"] = x.get_pubigerous();
        j["rebellious"] = x.get_rebellious();
        j["recodify"] = x.get_recodify();
        j["unpaced"] = x.get_unpaced();
    }

    inline void from_json(json const & j, PiaculumClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("alada") != j.end() && !j.at("alada").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("alada") != j.end() && j.at("alada").is_null()) throw std::runtime_error("Unexpected null");
        x.set_alada(get_stack_optional<int64_t>(j, "alada"));
        if (j.find("amphistomous") != j.end() && !j.at("amphistomous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("amphistomous") != j.end() && j.at("amphistomous").is_null()) throw std::runtime_error("Unexpected null");
        x.set_amphistomous(get_stack_optional<int64_t>(j, "amphistomous"));
        if (j.find("boysenberry") != j.end() && !j.at("boysenberry").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("boysenberry") != j.end() && j.at("boysenberry").is_null()) throw std::runtime_error("Unexpected null");
        x.set_boysenberry(get_stack_optional<int64_t>(j, "boysenberry"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("decardinalize") != j.end() && !j.at("decardinalize").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("decardinalize") != j.end() && j.at("decardinalize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_decardinalize(get_stack_optional<int64_t>(j, "decardinalize"));
        if (j.find("discouragement") != j.end() && !j.at("discouragement").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("discouragement") != j.end() && j.at("discouragement").is_null()) throw std::runtime_error("Unexpected null");
        x.set_discouragement(get_stack_optional<int64_t>(j, "discouragement"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("doitrified") != j.end() && !j.at("doitrified").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("doitrified") != j.end() && j.at("doitrified").is_null()) throw std::runtime_error("Unexpected null");
        x.set_doitrified(get_stack_optional<int64_t>(j, "doitrified"));
        if (j.find("hexaspermous") != j.end() && !j.at("hexaspermous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hexaspermous") != j.end() && j.at("hexaspermous").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hexaspermous(get_stack_optional<int64_t>(j, "hexaspermous"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("insinking") != j.end() && !j.at("insinking").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("insinking") != j.end() && j.at("insinking").is_null()) throw std::runtime_error("Unexpected null");
        x.set_insinking(get_stack_optional<int64_t>(j, "insinking"));
        if (j.find("loathfulness") != j.end() && !j.at("loathfulness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("loathfulness") != j.end() && j.at("loathfulness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_loathfulness(get_stack_optional<int64_t>(j, "loathfulness"));
        if (j.find("miasmatical") != j.end() && !j.at("miasmatical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("miasmatical") != j.end() && j.at("miasmatical").is_null()) throw std::runtime_error("Unexpected null");
        x.set_miasmatical(get_stack_optional<int64_t>(j, "miasmatical"));
        if (j.find("neurofibril") != j.end() && !j.at("neurofibril").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("neurofibril") != j.end() && j.at("neurofibril").is_null()) throw std::runtime_error("Unexpected null");
        x.set_neurofibril(get_stack_optional<int64_t>(j, "neurofibril"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("phonendoscope") != j.end() && !j.at("phonendoscope").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("phonendoscope") != j.end() && j.at("phonendoscope").is_null()) throw std::runtime_error("Unexpected null");
        x.set_phonendoscope(get_stack_optional<int64_t>(j, "phonendoscope"));
        if (j.find("pilferment") != j.end() && !j.at("pilferment").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("pilferment") != j.end() && j.at("pilferment").is_null()) throw std::runtime_error("Unexpected null");
        x.set_pilferment(get_stack_optional<int64_t>(j, "pilferment"));
        if (j.find("predismissory") != j.end() && !j.at("predismissory").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("predismissory") != j.end() && j.at("predismissory").is_null()) throw std::runtime_error("Unexpected null");
        x.set_predismissory(get_stack_optional<int64_t>(j, "predismissory"));
        if (j.find("preinscription") != j.end() && !j.at("preinscription").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("preinscription") != j.end() && j.at("preinscription").is_null()) throw std::runtime_error("Unexpected null");
        x.set_preinscription(get_stack_optional<int64_t>(j, "preinscription"));
        if (j.find("quotative") != j.end() && !j.at("quotative").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("quotative") != j.end() && j.at("quotative").is_null()) throw std::runtime_error("Unexpected null");
        x.set_quotative(get_stack_optional<int64_t>(j, "quotative"));
        if (j.find("sienna") != j.end() && !j.at("sienna").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sienna") != j.end() && j.at("sienna").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sienna(get_stack_optional<int64_t>(j, "sienna"));
        if (j.find("thorax") != j.end() && !j.at("thorax").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("thorax") != j.end() && j.at("thorax").is_null()) throw std::runtime_error("Unexpected null");
        x.set_thorax(get_stack_optional<int64_t>(j, "thorax"));
        if (j.find("yachting") != j.end() && !j.at("yachting").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("yachting") != j.end() && j.at("yachting").is_null()) throw std::runtime_error("Unexpected null");
        x.set_yachting(get_stack_optional<int64_t>(j, "yachting"));
        if (j.find("Zipper") != j.end() && !j.at("Zipper").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Zipper") != j.end() && j.at("Zipper").is_null()) throw std::runtime_error("Unexpected null");
        x.set_zipper(get_stack_optional<int64_t>(j, "Zipper"));
    }

    inline void to_json(json & j, PiaculumClass const & x) {
        j = json::object();
        j["alada"] = x.get_alada();
        j["amphistomous"] = x.get_amphistomous();
        j["boysenberry"] = x.get_boysenberry();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["decardinalize"] = x.get_decardinalize();
        j["discouragement"] = x.get_discouragement();
        j["disdiapason"] = x.get_disdiapason();
        j["doitrified"] = x.get_doitrified();
        j["hexaspermous"] = x.get_hexaspermous();
        j["homocerc"] = x.get_homocerc();
        j["insinking"] = x.get_insinking();
        j["loathfulness"] = x.get_loathfulness();
        j["miasmatical"] = x.get_miasmatical();
        j["neurofibril"] = x.get_neurofibril();
        j["nonbookish"] = x.get_nonbookish();
        j["phonendoscope"] = x.get_phonendoscope();
        j["pilferment"] = x.get_pilferment();
        j["predismissory"] = x.get_predismissory();
        j["preinscription"] = x.get_preinscription();
        j["quotative"] = x.get_quotative();
        j["sienna"] = x.get_sienna();
        j["thorax"] = x.get_thorax();
        j["yachting"] = x.get_yachting();
        j["Zipper"] = x.get_zipper();
    }

    inline void from_json(json const & j, Pneumocele& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_carbonarism(get_untyped(j, "Carbonarism"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        x.set_cineolic(get_untyped(j, "cineolic"));
        x.set_cobbly(get_untyped(j, "cobbly"));
        x.set_conchyliferous(get_untyped(j, "conchyliferous"));
        x.set_congregation(get_untyped(j, "congregation"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_enterotomy(get_untyped(j, "enterotomy"));
        x.set_entophytal(get_untyped(j, "entophytal"));
        x.set_fewtrils(get_untyped(j, "fewtrils"));
        x.set_herem(get_untyped(j, "herem"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_koniga(get_untyped(j, "Koniga"));
        x.set_meticulosity(get_untyped(j, "meticulosity"));
        x.set_micky(get_untyped(j, "Micky"));
        x.set_mismarriage(get_untyped(j, "mismarriage"));
        x.set_neurotrophic(get_untyped(j, "neurotrophic"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_persuasively(get_untyped(j, "persuasively"));
        x.set_replaceable(get_untyped(j, "replaceable"));
        x.set_silex(get_untyped(j, "silex"));
        x.set_taillight(get_untyped(j, "taillight"));
        x.set_unjealous(get_untyped(j, "unjealous"));
        x.set_visitorial(get_untyped(j, "visitorial"));
    }

    inline void to_json(json & j, Pneumocele const & x) {
        j = json::object();
        j["Carbonarism"] = x.get_carbonarism();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["cineolic"] = x.get_cineolic();
        j["cobbly"] = x.get_cobbly();
        j["conchyliferous"] = x.get_conchyliferous();
        j["congregation"] = x.get_congregation();
        j["disdiapason"] = x.get_disdiapason();
        j["enterotomy"] = x.get_enterotomy();
        j["entophytal"] = x.get_entophytal();
        j["fewtrils"] = x.get_fewtrils();
        j["herem"] = x.get_herem();
        j["homocerc"] = x.get_homocerc();
        j["Koniga"] = x.get_koniga();
        j["meticulosity"] = x.get_meticulosity();
        j["Micky"] = x.get_micky();
        j["mismarriage"] = x.get_mismarriage();
        j["neurotrophic"] = x.get_neurotrophic();
        j["nonbookish"] = x.get_nonbookish();
        j["persuasively"] = x.get_persuasively();
        j["replaceable"] = x.get_replaceable();
        j["silex"] = x.get_silex();
        j["taillight"] = x.get_taillight();
        j["unjealous"] = x.get_unjealous();
        j["visitorial"] = x.get_visitorial();
    }

    inline void from_json(json const & j, PotwhiskyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_arciform(get_untyped(j, "arciform"));
        x.set_cresolin(get_untyped(j, "cresolin"));
        x.set_disheartener(get_untyped(j, "disheartener"));
        x.set_disproportionable(get_untyped(j, "disproportionable"));
        x.set_euchorda(get_untyped(j, "Euchorda"));
        x.set_ferryway(get_untyped(j, "ferryway"));
        x.set_filamentiferous(get_untyped(j, "filamentiferous"));
        x.set_flemish(get_untyped(j, "flemish"));
        x.set_forgainst(get_untyped(j, "forgainst"));
        x.set_grainering(get_untyped(j, "grainering"));
        x.set_irrevoluble(get_untyped(j, "irrevoluble"));
        x.set_kindredship(get_untyped(j, "kindredship"));
        x.set_pinguitudinous(get_untyped(j, "pinguitudinous"));
        x.set_simpletonic(get_untyped(j, "simpletonic"));
        x.set_singsong(get_untyped(j, "singsong"));
        x.set_submergement(get_untyped(j, "submergement"));
        x.set_supraoesophagal(get_untyped(j, "supraoesophagal"));
        x.set_thrashel(get_untyped(j, "thrashel"));
        x.set_tyremesis(get_untyped(j, "tyremesis"));
        x.set_yoruba(get_untyped(j, "Yoruba"));
    }

    inline void to_json(json & j, PotwhiskyClass const & x) {
        j = json::object();
        j["arciform"] = x.get_arciform();
        j["cresolin"] = x.get_cresolin();
        j["disheartener"] = x.get_disheartener();
        j["disproportionable"] = x.get_disproportionable();
        j["Euchorda"] = x.get_euchorda();
        j["ferryway"] = x.get_ferryway();
        j["filamentiferous"] = x.get_filamentiferous();
        j["flemish"] = x.get_flemish();
        j["forgainst"] = x.get_forgainst();
        j["grainering"] = x.get_grainering();
        j["irrevoluble"] = x.get_irrevoluble();
        j["kindredship"] = x.get_kindredship();
        j["pinguitudinous"] = x.get_pinguitudinous();
        j["simpletonic"] = x.get_simpletonic();
        j["singsong"] = x.get_singsong();
        j["submergement"] = x.get_submergement();
        j["supraoesophagal"] = x.get_supraoesophagal();
        j["thrashel"] = x.get_thrashel();
        j["tyremesis"] = x.get_tyremesis();
        j["Yoruba"] = x.get_yoruba();
    }

    inline void from_json(json const & j, PrefreshmanClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_azorubine(get_untyped(j, "azorubine"));
        x.set_choroiditis(get_untyped(j, "choroiditis"));
        x.set_coagulatory(get_untyped(j, "coagulatory"));
        x.set_cyclorama(get_untyped(j, "cyclorama"));
        x.set_dolphus(get_untyped(j, "Dolphus"));
        x.set_duckhearted(get_untyped(j, "duckhearted"));
        x.set_ficus(get_untyped(j, "Ficus"));
        x.set_gemaric(get_untyped(j, "Gemaric"));
        x.set_jugation(get_untyped(j, "jugation"));
        x.set_myoliposis(get_untyped(j, "myoliposis"));
        x.set_nonnomination(get_untyped(j, "nonnomination"));
        x.set_palay(get_untyped(j, "palay"));
        x.set_pentactinal(get_untyped(j, "pentactinal"));
        x.set_phaet(get_untyped(j, "Phaet"));
        x.set_piquant(get_untyped(j, "piquant"));
        x.set_registration(get_untyped(j, "registration"));
        x.set_remancipation(get_untyped(j, "remancipation"));
        x.set_scutatiform(get_untyped(j, "scutatiform"));
        x.set_theodolite(get_untyped(j, "theodolite"));
        x.set_underward(get_untyped(j, "underward"));
    }

    inline void to_json(json & j, PrefreshmanClass const & x) {
        j = json::object();
        j["azorubine"] = x.get_azorubine();
        j["choroiditis"] = x.get_choroiditis();
        j["coagulatory"] = x.get_coagulatory();
        j["cyclorama"] = x.get_cyclorama();
        j["Dolphus"] = x.get_dolphus();
        j["duckhearted"] = x.get_duckhearted();
        j["Ficus"] = x.get_ficus();
        j["Gemaric"] = x.get_gemaric();
        j["jugation"] = x.get_jugation();
        j["myoliposis"] = x.get_myoliposis();
        j["nonnomination"] = x.get_nonnomination();
        j["palay"] = x.get_palay();
        j["pentactinal"] = x.get_pentactinal();
        j["Phaet"] = x.get_phaet();
        j["piquant"] = x.get_piquant();
        j["registration"] = x.get_registration();
        j["remancipation"] = x.get_remancipation();
        j["scutatiform"] = x.get_scutatiform();
        j["theodolite"] = x.get_theodolite();
        j["underward"] = x.get_underward();
    }

    inline void from_json(json const & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_juror(j.at("juror").get<std::vector<JurorElement>>());
        x.set_kongoni(j.at("kongoni").get<std::vector<Kongoni>>());
        x.set_ladronism(j.at("ladronism").get<std::vector<LadronismElement>>());
        x.set_landlubberly(j.at("landlubberly").get<std::vector<LandlubberlyElement>>());
        x.set_listener(j.at("listener").get<std::vector<Listener>>());
        x.set_lupus(j.at("lupus").get<std::vector<LupusElement>>());
        x.set_maslin(j.at("maslin").get<std::vector<Maslin>>());
        x.set_monazite(j.at("monazite").get<std::vector<MonaziteElement>>());
        x.set_monoliteral(j.at("monoliteral").get<std::vector<Monoliteral>>());
        x.set_monotheistically(j.at("monotheistically").get<std::vector<MonotheisticallyElement>>());
        x.set_montage(j.at("montage").get<std::vector<Montage>>());
        x.set_moralness(j.at("moralness").get<std::vector<Moralness>>());
        x.set_mowra(j.at("mowra").get<std::vector<std::optional<MonaziteClass>>>());
        x.set_mulishly(j.at("mulishly").get<std::vector<Mulishly>>());
        x.set_myoscope(j.at("myoscope").get<std::vector<Myoscope>>());
        x.set_nach(j.at("nach").get<std::vector<std::optional<std::vector<std::optional<int64_t>>>>>());
        x.set_neuromastic(j.at("neuromastic").get<std::vector<Neuromastic>>());
        x.set_noncontributing(j.at("noncontributing").get<std::vector<Noncontributing>>());
        x.set_nonnervous(j.at("nonnervous").get<std::vector<Nonnervous>>());
        x.set_nonvaluation(j.at("nonvaluation").get<std::vector<Nonvaluation>>());
        x.set_occupationalist(j.at("occupationalist").get<std::vector<OccupationalistElement>>());
        x.set_outrival(j.at("outrival").get<std::vector<OutrivalElement>>());
        x.set_paleographically(j.at("paleographically").get<std::vector<Paleographically>>());
        x.set_pamphletwise(j.at("pamphletwise").get<std::vector<Pamphletwise>>());
        x.set_pediatrics(j.at("pediatrics").get<std::vector<Pediatric>>());
        x.set_perceptive(j.at("perceptive").get<std::vector<bool>>());
        x.set_piaculum(j.at("piaculum").get<std::vector<PiaculumElement>>());
        x.set_piccadilly(j.at("piccadilly").get<std::vector<Piccadilly>>());
        x.set_piffler(j.at("piffler").get<std::vector<Piffler>>());
        x.set_pithful(j.at("pithful").get<std::vector<Pithful>>());
        x.set_placuntitis(j.at("placuntitis").get<std::vector<Placuntiti>>());
        x.set_plectopterous(j.at("plectopterous").get<std::vector<Plectopterous>>());
        x.set_pneumocele(j.at("pneumocele").get<std::vector<std::optional<Pneumocele>>>());
        x.set_poliorcetic(j.at("poliorcetic").get<std::vector<Poliorcetic>>());
        x.set_poormaster(j.at("poormaster").get<std::vector<Poormaster>>());
        x.set_potwhisky(j.at("potwhisky").get<std::vector<PotwhiskyElement>>());
        x.set_practicalizer(j.at("practicalizer").get<std::vector<Practicalizer>>());
        x.set_prefreshman(j.at("prefreshman").get<std::vector<PrefreshmanElement>>());
        x.set_prehensility(j.at("prehensility").get<std::vector<Prehensility>>());
        x.set_prevoidance(j.at("prevoidance").get<std::vector<Prevoidance>>());
        x.set_probant(j.at("probant").get<std::vector<std::map<std::string, std::optional<int64_t>>>>());
        x.set_protext(j.at("protext").get<std::vector<Protext>>());
    }

    inline void to_json(json & j, TopLevel const & x) {
        j = json::object();
        j["juror"] = x.get_juror();
        j["kongoni"] = x.get_kongoni();
        j["ladronism"] = x.get_ladronism();
        j["landlubberly"] = x.get_landlubberly();
        j["listener"] = x.get_listener();
        j["lupus"] = x.get_lupus();
        j["maslin"] = x.get_maslin();
        j["monazite"] = x.get_monazite();
        j["monoliteral"] = x.get_monoliteral();
        j["monotheistically"] = x.get_monotheistically();
        j["montage"] = x.get_montage();
        j["moralness"] = x.get_moralness();
        j["mowra"] = x.get_mowra();
        j["mulishly"] = x.get_mulishly();
        j["myoscope"] = x.get_myoscope();
        j["nach"] = x.get_nach();
        j["neuromastic"] = x.get_neuromastic();
        j["noncontributing"] = x.get_noncontributing();
        j["nonnervous"] = x.get_nonnervous();
        j["nonvaluation"] = x.get_nonvaluation();
        j["occupationalist"] = x.get_occupationalist();
        j["outrival"] = x.get_outrival();
        j["paleographically"] = x.get_paleographically();
        j["pamphletwise"] = x.get_pamphletwise();
        j["pediatrics"] = x.get_pediatrics();
        j["perceptive"] = x.get_perceptive();
        j["piaculum"] = x.get_piaculum();
        j["piccadilly"] = x.get_piccadilly();
        j["piffler"] = x.get_piffler();
        j["pithful"] = x.get_pithful();
        j["placuntitis"] = x.get_placuntitis();
        j["plectopterous"] = x.get_plectopterous();
        j["pneumocele"] = x.get_pneumocele();
        j["poliorcetic"] = x.get_poliorcetic();
        j["poormaster"] = x.get_poormaster();
        j["potwhisky"] = x.get_potwhisky();
        j["practicalizer"] = x.get_practicalizer();
        j["prefreshman"] = x.get_prefreshman();
        j["prehensility"] = x.get_prehensility();
        j["prevoidance"] = x.get_prevoidance();
        j["probant"] = x.get_probant();
        j["protext"] = x.get_protext();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, quicktype::JurorClass>>::from_json(json const & j, std::variant<bool, quicktype::JurorClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::JurorClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::JurorClass>>::to_json(json & j, std::variant<bool, quicktype::JurorClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::JurorClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::LadronismClass, double, std::string>>::from_json(json const & j, std::variant<quicktype::LadronismClass, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::LadronismClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LadronismClass, double, std::string>>::to_json(json & j, std::variant<quicktype::LadronismClass, double, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::LadronismClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::LandlubberlyClass, int64_t>>::from_json(json const & j, std::variant<bool, quicktype::LandlubberlyClass, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::LandlubberlyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::LandlubberlyClass, int64_t>>::to_json(json & j, std::variant<bool, quicktype::LandlubberlyClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::LandlubberlyClass>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t>>::from_json(json const & j, std::variant<std::vector<json>, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t>>::to_json(json & j, std::variant<std::vector<json>, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::LupusClass, int64_t>>::from_json(json const & j, std::variant<quicktype::LupusClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::LupusClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LupusClass, int64_t>>::to_json(json & j, std::variant<quicktype::LupusClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::LupusClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::MonaziteClass, double>>::from_json(json const & j, std::variant<quicktype::MonaziteClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::MonaziteClass, double>>::to_json(json & j, std::variant<quicktype::MonaziteClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::MonaziteClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool>>::from_json(json const & j, std::variant<std::vector<json>, bool> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool>>::to_json(json & j, std::variant<std::vector<json>, bool> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonotheisticallyClass>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::MonotheisticallyClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::MonotheisticallyClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonotheisticallyClass>>::to_json(json & j, std::variant<std::vector<json>, quicktype::MonotheisticallyClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::MonotheisticallyClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, double, std::string>>::from_json(json const & j, std::variant<std::vector<json>, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, double, std::string>>::to_json(json & j, std::variant<std::vector<json>, double, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, double>>::from_json(json const & j, std::variant<std::vector<json>, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, double>>::to_json(json & j, std::variant<std::vector<json>, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double>>::from_json(json const & j, std::variant<std::vector<int64_t>, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double>>::to_json(json & j, std::variant<std::vector<int64_t>, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, int64_t>>::from_json(json const & j, std::variant<std::vector<json>, bool, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, int64_t>>::to_json(json & j, std::variant<std::vector<json>, bool, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, int64_t>>::from_json(json const & j, std::variant<bool, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, int64_t>>::to_json(json & j, std::variant<bool, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, double>>::from_json(json const & j, std::variant<std::vector<json>, bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, double>>::to_json(json & j, std::variant<std::vector<json>, bool, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::OccupationalistClass>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::OccupationalistClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::OccupationalistClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::OccupationalistClass>>::to_json(json & j, std::variant<std::vector<json>, quicktype::OccupationalistClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::OccupationalistClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::OutrivalClass, double>>::from_json(json const & j, std::variant<quicktype::OutrivalClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::OutrivalClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::OutrivalClass, double>>::to_json(json & j, std::variant<quicktype::OutrivalClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::OutrivalClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, std::optional<int64_t>>>>::from_json(json const & j, std::variant<double, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, std::variant<double, std::map<std::string, std::optional<int64_t>>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<double>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, std::optional<int64_t>>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>, std::string>>::from_json(json const & j, std::variant<int64_t, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>, std::string>>::to_json(json & j, std::variant<int64_t, std::map<std::string, int64_t>, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<int64_t>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, double>>::from_json(json const & j, std::variant<bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double>>::to_json(json & j, std::variant<bool, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::PiaculumClass, double>>::from_json(json const & j, std::variant<quicktype::PiaculumClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::PiaculumClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PiaculumClass, double>>::to_json(json & j, std::variant<quicktype::PiaculumClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::PiaculumClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, std::string>>::from_json(json const & j, std::variant<double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::string>>::to_json(json & j, std::variant<double, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<double>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::MonaziteClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass>>::to_json(json & j, std::variant<std::vector<json>, quicktype::MonaziteClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::MonaziteClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<int64_t, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<int64_t>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<double, std::map<std::string, int64_t>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<double, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<double>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::MonaziteClass>>::from_json(json const & j, std::variant<bool, quicktype::MonaziteClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::MonaziteClass>>::to_json(json & j, std::variant<bool, quicktype::MonaziteClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::MonaziteClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::PotwhiskyClass, int64_t>>::from_json(json const & j, std::variant<quicktype::PotwhiskyClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::PotwhiskyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PotwhiskyClass, int64_t>>::to_json(json & j, std::variant<quicktype::PotwhiskyClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::PotwhiskyClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass, std::string>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass, std::string>>::to_json(json & j, std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::MonaziteClass>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::PrefreshmanClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string>>::to_json(json & j, std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::PrefreshmanClass>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::MonaziteClass>>::from_json(json const & j, std::variant<std::vector<json>, bool, quicktype::MonaziteClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::MonaziteClass>>::to_json(json & j, std::variant<std::vector<json>, bool, quicktype::MonaziteClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<quicktype::MonaziteClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::MonaziteClass>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass>>::from_json(json const & j, std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass>>::to_json(json & j, std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<quicktype::MonaziteClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
