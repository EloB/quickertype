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

    class CerographClass {
        public:
        CerographClass() = default;
        virtual ~CerographClass() = default;

        private:
        nlohmann::json apotropaion;
        nlohmann::json casuary;
        nlohmann::json creaker;
        nlohmann::json disqualification;
        nlohmann::json imperatorious;
        nlohmann::json impermeabilize;
        nlohmann::json metastoma;
        nlohmann::json noctidiurnal;
        nlohmann::json nonreserve;
        nlohmann::json ophthalmotonometry;
        nlohmann::json pailful;
        nlohmann::json pigfish;
        nlohmann::json pongee;
        nlohmann::json prosodical;
        nlohmann::json scrofuloderm;
        nlohmann::json storekeeping;
        nlohmann::json therologist;
        nlohmann::json tolowa;
        nlohmann::json tradeful;
        nlohmann::json unriveting;

        public:
        const nlohmann::json & get_apotropaion() const { return apotropaion; }
        nlohmann::json & get_mutable_apotropaion() { return apotropaion; }
        void set_apotropaion(const nlohmann::json & value) { this->apotropaion = value; }

        const nlohmann::json & get_casuary() const { return casuary; }
        nlohmann::json & get_mutable_casuary() { return casuary; }
        void set_casuary(const nlohmann::json & value) { this->casuary = value; }

        const nlohmann::json & get_creaker() const { return creaker; }
        nlohmann::json & get_mutable_creaker() { return creaker; }
        void set_creaker(const nlohmann::json & value) { this->creaker = value; }

        const nlohmann::json & get_disqualification() const { return disqualification; }
        nlohmann::json & get_mutable_disqualification() { return disqualification; }
        void set_disqualification(const nlohmann::json & value) { this->disqualification = value; }

        const nlohmann::json & get_imperatorious() const { return imperatorious; }
        nlohmann::json & get_mutable_imperatorious() { return imperatorious; }
        void set_imperatorious(const nlohmann::json & value) { this->imperatorious = value; }

        const nlohmann::json & get_impermeabilize() const { return impermeabilize; }
        nlohmann::json & get_mutable_impermeabilize() { return impermeabilize; }
        void set_impermeabilize(const nlohmann::json & value) { this->impermeabilize = value; }

        const nlohmann::json & get_metastoma() const { return metastoma; }
        nlohmann::json & get_mutable_metastoma() { return metastoma; }
        void set_metastoma(const nlohmann::json & value) { this->metastoma = value; }

        const nlohmann::json & get_noctidiurnal() const { return noctidiurnal; }
        nlohmann::json & get_mutable_noctidiurnal() { return noctidiurnal; }
        void set_noctidiurnal(const nlohmann::json & value) { this->noctidiurnal = value; }

        const nlohmann::json & get_nonreserve() const { return nonreserve; }
        nlohmann::json & get_mutable_nonreserve() { return nonreserve; }
        void set_nonreserve(const nlohmann::json & value) { this->nonreserve = value; }

        const nlohmann::json & get_ophthalmotonometry() const { return ophthalmotonometry; }
        nlohmann::json & get_mutable_ophthalmotonometry() { return ophthalmotonometry; }
        void set_ophthalmotonometry(const nlohmann::json & value) { this->ophthalmotonometry = value; }

        const nlohmann::json & get_pailful() const { return pailful; }
        nlohmann::json & get_mutable_pailful() { return pailful; }
        void set_pailful(const nlohmann::json & value) { this->pailful = value; }

        const nlohmann::json & get_pigfish() const { return pigfish; }
        nlohmann::json & get_mutable_pigfish() { return pigfish; }
        void set_pigfish(const nlohmann::json & value) { this->pigfish = value; }

        const nlohmann::json & get_pongee() const { return pongee; }
        nlohmann::json & get_mutable_pongee() { return pongee; }
        void set_pongee(const nlohmann::json & value) { this->pongee = value; }

        const nlohmann::json & get_prosodical() const { return prosodical; }
        nlohmann::json & get_mutable_prosodical() { return prosodical; }
        void set_prosodical(const nlohmann::json & value) { this->prosodical = value; }

        const nlohmann::json & get_scrofuloderm() const { return scrofuloderm; }
        nlohmann::json & get_mutable_scrofuloderm() { return scrofuloderm; }
        void set_scrofuloderm(const nlohmann::json & value) { this->scrofuloderm = value; }

        const nlohmann::json & get_storekeeping() const { return storekeeping; }
        nlohmann::json & get_mutable_storekeeping() { return storekeeping; }
        void set_storekeeping(const nlohmann::json & value) { this->storekeeping = value; }

        const nlohmann::json & get_therologist() const { return therologist; }
        nlohmann::json & get_mutable_therologist() { return therologist; }
        void set_therologist(const nlohmann::json & value) { this->therologist = value; }

        const nlohmann::json & get_tolowa() const { return tolowa; }
        nlohmann::json & get_mutable_tolowa() { return tolowa; }
        void set_tolowa(const nlohmann::json & value) { this->tolowa = value; }

        const nlohmann::json & get_tradeful() const { return tradeful; }
        nlohmann::json & get_mutable_tradeful() { return tradeful; }
        void set_tradeful(const nlohmann::json & value) { this->tradeful = value; }

        const nlohmann::json & get_unriveting() const { return unriveting; }
        nlohmann::json & get_mutable_unriveting() { return unriveting; }
        void set_unriveting(const nlohmann::json & value) { this->unriveting = value; }
    };

    using CerographElement = std::optional<std::variant<CerographClass, std::string>>;

    class ChemotherapeuticClass {
        public:
        ChemotherapeuticClass() = default;
        virtual ~ChemotherapeuticClass() = default;

        private:
        nlohmann::json angioneurotic;
        nlohmann::json availment;
        nlohmann::json bladelet;
        std::optional<double> catharticalness;
        nlohmann::json caulis;
        nlohmann::json chalcus;
        std::optional<int64_t> chirotherium;
        std::optional<std::string> disdiapason;
        nlohmann::json enteradenological;
        std::optional<bool> homocerc;
        nlohmann::json imporosity;
        nlohmann::json insistently;
        nlohmann::json intraparietal;
        nlohmann::json ivied;
        nlohmann::json maureen;
        nlohmann::json nonbookish;
        nlohmann::json nostochine;
        nlohmann::json nutcracker;
        nlohmann::json ofttimes;
        nlohmann::json phenocryst;
        nlohmann::json precoincident;
        nlohmann::json ramiferous;
        nlohmann::json stagmometer;
        nlohmann::json tetherball;
        nlohmann::json unshy;

        public:
        const nlohmann::json & get_angioneurotic() const { return angioneurotic; }
        nlohmann::json & get_mutable_angioneurotic() { return angioneurotic; }
        void set_angioneurotic(const nlohmann::json & value) { this->angioneurotic = value; }

        const nlohmann::json & get_availment() const { return availment; }
        nlohmann::json & get_mutable_availment() { return availment; }
        void set_availment(const nlohmann::json & value) { this->availment = value; }

        const nlohmann::json & get_bladelet() const { return bladelet; }
        nlohmann::json & get_mutable_bladelet() { return bladelet; }
        void set_bladelet(const nlohmann::json & value) { this->bladelet = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const nlohmann::json & get_caulis() const { return caulis; }
        nlohmann::json & get_mutable_caulis() { return caulis; }
        void set_caulis(const nlohmann::json & value) { this->caulis = value; }

        const nlohmann::json & get_chalcus() const { return chalcus; }
        nlohmann::json & get_mutable_chalcus() { return chalcus; }
        void set_chalcus(const nlohmann::json & value) { this->chalcus = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const nlohmann::json & get_enteradenological() const { return enteradenological; }
        nlohmann::json & get_mutable_enteradenological() { return enteradenological; }
        void set_enteradenological(const nlohmann::json & value) { this->enteradenological = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const nlohmann::json & get_imporosity() const { return imporosity; }
        nlohmann::json & get_mutable_imporosity() { return imporosity; }
        void set_imporosity(const nlohmann::json & value) { this->imporosity = value; }

        const nlohmann::json & get_insistently() const { return insistently; }
        nlohmann::json & get_mutable_insistently() { return insistently; }
        void set_insistently(const nlohmann::json & value) { this->insistently = value; }

        const nlohmann::json & get_intraparietal() const { return intraparietal; }
        nlohmann::json & get_mutable_intraparietal() { return intraparietal; }
        void set_intraparietal(const nlohmann::json & value) { this->intraparietal = value; }

        const nlohmann::json & get_ivied() const { return ivied; }
        nlohmann::json & get_mutable_ivied() { return ivied; }
        void set_ivied(const nlohmann::json & value) { this->ivied = value; }

        const nlohmann::json & get_maureen() const { return maureen; }
        nlohmann::json & get_mutable_maureen() { return maureen; }
        void set_maureen(const nlohmann::json & value) { this->maureen = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const nlohmann::json & get_nostochine() const { return nostochine; }
        nlohmann::json & get_mutable_nostochine() { return nostochine; }
        void set_nostochine(const nlohmann::json & value) { this->nostochine = value; }

        const nlohmann::json & get_nutcracker() const { return nutcracker; }
        nlohmann::json & get_mutable_nutcracker() { return nutcracker; }
        void set_nutcracker(const nlohmann::json & value) { this->nutcracker = value; }

        const nlohmann::json & get_ofttimes() const { return ofttimes; }
        nlohmann::json & get_mutable_ofttimes() { return ofttimes; }
        void set_ofttimes(const nlohmann::json & value) { this->ofttimes = value; }

        const nlohmann::json & get_phenocryst() const { return phenocryst; }
        nlohmann::json & get_mutable_phenocryst() { return phenocryst; }
        void set_phenocryst(const nlohmann::json & value) { this->phenocryst = value; }

        const nlohmann::json & get_precoincident() const { return precoincident; }
        nlohmann::json & get_mutable_precoincident() { return precoincident; }
        void set_precoincident(const nlohmann::json & value) { this->precoincident = value; }

        const nlohmann::json & get_ramiferous() const { return ramiferous; }
        nlohmann::json & get_mutable_ramiferous() { return ramiferous; }
        void set_ramiferous(const nlohmann::json & value) { this->ramiferous = value; }

        const nlohmann::json & get_stagmometer() const { return stagmometer; }
        nlohmann::json & get_mutable_stagmometer() { return stagmometer; }
        void set_stagmometer(const nlohmann::json & value) { this->stagmometer = value; }

        const nlohmann::json & get_tetherball() const { return tetherball; }
        nlohmann::json & get_mutable_tetherball() { return tetherball; }
        void set_tetherball(const nlohmann::json & value) { this->tetherball = value; }

        const nlohmann::json & get_unshy() const { return unshy; }
        nlohmann::json & get_mutable_unshy() { return unshy; }
        void set_unshy(const nlohmann::json & value) { this->unshy = value; }
    };

    using ChemotherapeuticElement = std::variant<ChemotherapeuticClass, int64_t>;

    class CimeliaClass {
        public:
        CimeliaClass() = default;
        virtual ~CimeliaClass() = default;

        private:
        double catharticalness;
        int64_t chirotherium;
        std::string disdiapason;
        bool homocerc;
        nlohmann::json nonbookish;

        public:
        const double & get_catharticalness() const { return catharticalness; }
        double & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const double & value) { this->catharticalness = value; }

        const int64_t & get_chirotherium() const { return chirotherium; }
        int64_t & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const int64_t & value) { this->chirotherium = value; }

        const std::string & get_disdiapason() const { return disdiapason; }
        std::string & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::string & value) { this->disdiapason = value; }

        const bool & get_homocerc() const { return homocerc; }
        bool & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const bool & value) { this->homocerc = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }
    };

    using CimeliaElement = std::optional<std::variant<std::vector<int64_t>, CimeliaClass>>;

    using Clinodome = std::variant<double, std::string>;

    class CoadjustClass {
        public:
        CoadjustClass() = default;
        virtual ~CoadjustClass() = default;

        private:
        nlohmann::json amidosulphonal;
        nlohmann::json benny;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<std::string> disdiapason;
        nlohmann::json ensnare;
        std::optional<bool> homocerc;
        nlohmann::json hybridizer;
        nlohmann::json leastwise;
        nlohmann::json lof;
        nlohmann::json monkhood;
        nlohmann::json netherlandish;
        nlohmann::json nonbookish;
        nlohmann::json peonism;
        nlohmann::json phonelescope;
        nlohmann::json porphyrogeniture;
        nlohmann::json preindemnify;
        nlohmann::json rosal;
        nlohmann::json scalenous;
        nlohmann::json scopine;
        nlohmann::json sedaceae;
        nlohmann::json suberinize;
        nlohmann::json symbiot;
        nlohmann::json tablefellow;
        nlohmann::json unchargeable;

        public:
        const nlohmann::json & get_amidosulphonal() const { return amidosulphonal; }
        nlohmann::json & get_mutable_amidosulphonal() { return amidosulphonal; }
        void set_amidosulphonal(const nlohmann::json & value) { this->amidosulphonal = value; }

        const nlohmann::json & get_benny() const { return benny; }
        nlohmann::json & get_mutable_benny() { return benny; }
        void set_benny(const nlohmann::json & value) { this->benny = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const nlohmann::json & get_ensnare() const { return ensnare; }
        nlohmann::json & get_mutable_ensnare() { return ensnare; }
        void set_ensnare(const nlohmann::json & value) { this->ensnare = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const nlohmann::json & get_hybridizer() const { return hybridizer; }
        nlohmann::json & get_mutable_hybridizer() { return hybridizer; }
        void set_hybridizer(const nlohmann::json & value) { this->hybridizer = value; }

        const nlohmann::json & get_leastwise() const { return leastwise; }
        nlohmann::json & get_mutable_leastwise() { return leastwise; }
        void set_leastwise(const nlohmann::json & value) { this->leastwise = value; }

        const nlohmann::json & get_lof() const { return lof; }
        nlohmann::json & get_mutable_lof() { return lof; }
        void set_lof(const nlohmann::json & value) { this->lof = value; }

        const nlohmann::json & get_monkhood() const { return monkhood; }
        nlohmann::json & get_mutable_monkhood() { return monkhood; }
        void set_monkhood(const nlohmann::json & value) { this->monkhood = value; }

        const nlohmann::json & get_netherlandish() const { return netherlandish; }
        nlohmann::json & get_mutable_netherlandish() { return netherlandish; }
        void set_netherlandish(const nlohmann::json & value) { this->netherlandish = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const nlohmann::json & get_peonism() const { return peonism; }
        nlohmann::json & get_mutable_peonism() { return peonism; }
        void set_peonism(const nlohmann::json & value) { this->peonism = value; }

        const nlohmann::json & get_phonelescope() const { return phonelescope; }
        nlohmann::json & get_mutable_phonelescope() { return phonelescope; }
        void set_phonelescope(const nlohmann::json & value) { this->phonelescope = value; }

        const nlohmann::json & get_porphyrogeniture() const { return porphyrogeniture; }
        nlohmann::json & get_mutable_porphyrogeniture() { return porphyrogeniture; }
        void set_porphyrogeniture(const nlohmann::json & value) { this->porphyrogeniture = value; }

        const nlohmann::json & get_preindemnify() const { return preindemnify; }
        nlohmann::json & get_mutable_preindemnify() { return preindemnify; }
        void set_preindemnify(const nlohmann::json & value) { this->preindemnify = value; }

        const nlohmann::json & get_rosal() const { return rosal; }
        nlohmann::json & get_mutable_rosal() { return rosal; }
        void set_rosal(const nlohmann::json & value) { this->rosal = value; }

        const nlohmann::json & get_scalenous() const { return scalenous; }
        nlohmann::json & get_mutable_scalenous() { return scalenous; }
        void set_scalenous(const nlohmann::json & value) { this->scalenous = value; }

        const nlohmann::json & get_scopine() const { return scopine; }
        nlohmann::json & get_mutable_scopine() { return scopine; }
        void set_scopine(const nlohmann::json & value) { this->scopine = value; }

        const nlohmann::json & get_sedaceae() const { return sedaceae; }
        nlohmann::json & get_mutable_sedaceae() { return sedaceae; }
        void set_sedaceae(const nlohmann::json & value) { this->sedaceae = value; }

        const nlohmann::json & get_suberinize() const { return suberinize; }
        nlohmann::json & get_mutable_suberinize() { return suberinize; }
        void set_suberinize(const nlohmann::json & value) { this->suberinize = value; }

        const nlohmann::json & get_symbiot() const { return symbiot; }
        nlohmann::json & get_mutable_symbiot() { return symbiot; }
        void set_symbiot(const nlohmann::json & value) { this->symbiot = value; }

        const nlohmann::json & get_tablefellow() const { return tablefellow; }
        nlohmann::json & get_mutable_tablefellow() { return tablefellow; }
        void set_tablefellow(const nlohmann::json & value) { this->tablefellow = value; }

        const nlohmann::json & get_unchargeable() const { return unchargeable; }
        nlohmann::json & get_mutable_unchargeable() { return unchargeable; }
        void set_unchargeable(const nlohmann::json & value) { this->unchargeable = value; }
    };

    using CoadjustElement = std::variant<CoadjustClass, double>;

    using Consilience = std::variant<double, std::map<std::string, int64_t>>;

    using Constructor = std::variant<bool, std::map<std::string, std::optional<int64_t>>>;

    using Continuative = std::variant<std::map<std::string, int64_t>, std::string>;

    class CredulityClass {
        public:
        CredulityClass() = default;
        virtual ~CredulityClass() = default;

        private:
        nlohmann::json ammonolytic;
        nlohmann::json bushmaster;
        nlohmann::json considering;
        nlohmann::json consuetudinary;
        nlohmann::json embarras;
        nlohmann::json fineness;
        nlohmann::json flaithship;
        nlohmann::json flavia;
        nlohmann::json gruffly;
        nlohmann::json hedychium;
        nlohmann::json leadwort;
        nlohmann::json overseriously;
        nlohmann::json parabola;
        nlohmann::json pectinatodenticulate;
        nlohmann::json popean;
        nlohmann::json pornocrat;
        nlohmann::json quadrisect;
        nlohmann::json seriality;
        nlohmann::json vamphorn;
        nlohmann::json wharp;

        public:
        const nlohmann::json & get_ammonolytic() const { return ammonolytic; }
        nlohmann::json & get_mutable_ammonolytic() { return ammonolytic; }
        void set_ammonolytic(const nlohmann::json & value) { this->ammonolytic = value; }

        const nlohmann::json & get_bushmaster() const { return bushmaster; }
        nlohmann::json & get_mutable_bushmaster() { return bushmaster; }
        void set_bushmaster(const nlohmann::json & value) { this->bushmaster = value; }

        const nlohmann::json & get_considering() const { return considering; }
        nlohmann::json & get_mutable_considering() { return considering; }
        void set_considering(const nlohmann::json & value) { this->considering = value; }

        const nlohmann::json & get_consuetudinary() const { return consuetudinary; }
        nlohmann::json & get_mutable_consuetudinary() { return consuetudinary; }
        void set_consuetudinary(const nlohmann::json & value) { this->consuetudinary = value; }

        const nlohmann::json & get_embarras() const { return embarras; }
        nlohmann::json & get_mutable_embarras() { return embarras; }
        void set_embarras(const nlohmann::json & value) { this->embarras = value; }

        const nlohmann::json & get_fineness() const { return fineness; }
        nlohmann::json & get_mutable_fineness() { return fineness; }
        void set_fineness(const nlohmann::json & value) { this->fineness = value; }

        const nlohmann::json & get_flaithship() const { return flaithship; }
        nlohmann::json & get_mutable_flaithship() { return flaithship; }
        void set_flaithship(const nlohmann::json & value) { this->flaithship = value; }

        const nlohmann::json & get_flavia() const { return flavia; }
        nlohmann::json & get_mutable_flavia() { return flavia; }
        void set_flavia(const nlohmann::json & value) { this->flavia = value; }

        const nlohmann::json & get_gruffly() const { return gruffly; }
        nlohmann::json & get_mutable_gruffly() { return gruffly; }
        void set_gruffly(const nlohmann::json & value) { this->gruffly = value; }

        const nlohmann::json & get_hedychium() const { return hedychium; }
        nlohmann::json & get_mutable_hedychium() { return hedychium; }
        void set_hedychium(const nlohmann::json & value) { this->hedychium = value; }

        const nlohmann::json & get_leadwort() const { return leadwort; }
        nlohmann::json & get_mutable_leadwort() { return leadwort; }
        void set_leadwort(const nlohmann::json & value) { this->leadwort = value; }

        const nlohmann::json & get_overseriously() const { return overseriously; }
        nlohmann::json & get_mutable_overseriously() { return overseriously; }
        void set_overseriously(const nlohmann::json & value) { this->overseriously = value; }

        const nlohmann::json & get_parabola() const { return parabola; }
        nlohmann::json & get_mutable_parabola() { return parabola; }
        void set_parabola(const nlohmann::json & value) { this->parabola = value; }

        const nlohmann::json & get_pectinatodenticulate() const { return pectinatodenticulate; }
        nlohmann::json & get_mutable_pectinatodenticulate() { return pectinatodenticulate; }
        void set_pectinatodenticulate(const nlohmann::json & value) { this->pectinatodenticulate = value; }

        const nlohmann::json & get_popean() const { return popean; }
        nlohmann::json & get_mutable_popean() { return popean; }
        void set_popean(const nlohmann::json & value) { this->popean = value; }

        const nlohmann::json & get_pornocrat() const { return pornocrat; }
        nlohmann::json & get_mutable_pornocrat() { return pornocrat; }
        void set_pornocrat(const nlohmann::json & value) { this->pornocrat = value; }

        const nlohmann::json & get_quadrisect() const { return quadrisect; }
        nlohmann::json & get_mutable_quadrisect() { return quadrisect; }
        void set_quadrisect(const nlohmann::json & value) { this->quadrisect = value; }

        const nlohmann::json & get_seriality() const { return seriality; }
        nlohmann::json & get_mutable_seriality() { return seriality; }
        void set_seriality(const nlohmann::json & value) { this->seriality = value; }

        const nlohmann::json & get_vamphorn() const { return vamphorn; }
        nlohmann::json & get_mutable_vamphorn() { return vamphorn; }
        void set_vamphorn(const nlohmann::json & value) { this->vamphorn = value; }

        const nlohmann::json & get_wharp() const { return wharp; }
        nlohmann::json & get_mutable_wharp() { return wharp; }
        void set_wharp(const nlohmann::json & value) { this->wharp = value; }
    };

    using CredulityElement = std::variant<CredulityClass, int64_t, std::string>;

    using Creviced = std::variant<bool, std::map<std::string, int64_t>, std::string>;

    class DeruralizeClass {
        public:
        DeruralizeClass() = default;
        virtual ~DeruralizeClass() = default;

        private:
        nlohmann::json bockerel;
        nlohmann::json boulder;
        nlohmann::json churrus;
        nlohmann::json counterdigged;
        nlohmann::json dialogite;
        nlohmann::json digenic;
        nlohmann::json dunbird;
        nlohmann::json ergatogyne;
        nlohmann::json fiendful;
        nlohmann::json jackrod;
        nlohmann::json jehovistic;
        nlohmann::json paninean;
        nlohmann::json panther;
        nlohmann::json placentigerous;
        nlohmann::json romney;
        nlohmann::json sparm;
        nlohmann::json tocsin;
        nlohmann::json unnicked;
        nlohmann::json unstavable;
        nlohmann::json windfirm;

        public:
        const nlohmann::json & get_bockerel() const { return bockerel; }
        nlohmann::json & get_mutable_bockerel() { return bockerel; }
        void set_bockerel(const nlohmann::json & value) { this->bockerel = value; }

        const nlohmann::json & get_boulder() const { return boulder; }
        nlohmann::json & get_mutable_boulder() { return boulder; }
        void set_boulder(const nlohmann::json & value) { this->boulder = value; }

        const nlohmann::json & get_churrus() const { return churrus; }
        nlohmann::json & get_mutable_churrus() { return churrus; }
        void set_churrus(const nlohmann::json & value) { this->churrus = value; }

        const nlohmann::json & get_counterdigged() const { return counterdigged; }
        nlohmann::json & get_mutable_counterdigged() { return counterdigged; }
        void set_counterdigged(const nlohmann::json & value) { this->counterdigged = value; }

        const nlohmann::json & get_dialogite() const { return dialogite; }
        nlohmann::json & get_mutable_dialogite() { return dialogite; }
        void set_dialogite(const nlohmann::json & value) { this->dialogite = value; }

        const nlohmann::json & get_digenic() const { return digenic; }
        nlohmann::json & get_mutable_digenic() { return digenic; }
        void set_digenic(const nlohmann::json & value) { this->digenic = value; }

        const nlohmann::json & get_dunbird() const { return dunbird; }
        nlohmann::json & get_mutable_dunbird() { return dunbird; }
        void set_dunbird(const nlohmann::json & value) { this->dunbird = value; }

        const nlohmann::json & get_ergatogyne() const { return ergatogyne; }
        nlohmann::json & get_mutable_ergatogyne() { return ergatogyne; }
        void set_ergatogyne(const nlohmann::json & value) { this->ergatogyne = value; }

        const nlohmann::json & get_fiendful() const { return fiendful; }
        nlohmann::json & get_mutable_fiendful() { return fiendful; }
        void set_fiendful(const nlohmann::json & value) { this->fiendful = value; }

        const nlohmann::json & get_jackrod() const { return jackrod; }
        nlohmann::json & get_mutable_jackrod() { return jackrod; }
        void set_jackrod(const nlohmann::json & value) { this->jackrod = value; }

        const nlohmann::json & get_jehovistic() const { return jehovistic; }
        nlohmann::json & get_mutable_jehovistic() { return jehovistic; }
        void set_jehovistic(const nlohmann::json & value) { this->jehovistic = value; }

        const nlohmann::json & get_paninean() const { return paninean; }
        nlohmann::json & get_mutable_paninean() { return paninean; }
        void set_paninean(const nlohmann::json & value) { this->paninean = value; }

        const nlohmann::json & get_panther() const { return panther; }
        nlohmann::json & get_mutable_panther() { return panther; }
        void set_panther(const nlohmann::json & value) { this->panther = value; }

        const nlohmann::json & get_placentigerous() const { return placentigerous; }
        nlohmann::json & get_mutable_placentigerous() { return placentigerous; }
        void set_placentigerous(const nlohmann::json & value) { this->placentigerous = value; }

        const nlohmann::json & get_romney() const { return romney; }
        nlohmann::json & get_mutable_romney() { return romney; }
        void set_romney(const nlohmann::json & value) { this->romney = value; }

        const nlohmann::json & get_sparm() const { return sparm; }
        nlohmann::json & get_mutable_sparm() { return sparm; }
        void set_sparm(const nlohmann::json & value) { this->sparm = value; }

        const nlohmann::json & get_tocsin() const { return tocsin; }
        nlohmann::json & get_mutable_tocsin() { return tocsin; }
        void set_tocsin(const nlohmann::json & value) { this->tocsin = value; }

        const nlohmann::json & get_unnicked() const { return unnicked; }
        nlohmann::json & get_mutable_unnicked() { return unnicked; }
        void set_unnicked(const nlohmann::json & value) { this->unnicked = value; }

        const nlohmann::json & get_unstavable() const { return unstavable; }
        nlohmann::json & get_mutable_unstavable() { return unstavable; }
        void set_unstavable(const nlohmann::json & value) { this->unstavable = value; }

        const nlohmann::json & get_windfirm() const { return windfirm; }
        nlohmann::json & get_mutable_windfirm() { return windfirm; }
        void set_windfirm(const nlohmann::json & value) { this->windfirm = value; }
    };

    using DeruralizeElement = std::variant<std::vector<nlohmann::json>, bool, DeruralizeClass>;

    class DiaereseClass {
        public:
        DiaereseClass() = default;
        virtual ~DiaereseClass() = default;

        private:
        nlohmann::json amoreuxia;
        nlohmann::json ani;
        nlohmann::json bernicle;
        nlohmann::json blackwasher;
        nlohmann::json blowhard;
        nlohmann::json broma;
        nlohmann::json closecross;
        nlohmann::json congregationalism;
        nlohmann::json grayly;
        nlohmann::json historically;
        nlohmann::json hoast;
        nlohmann::json irretentive;
        nlohmann::json parcener;
        nlohmann::json pedder;
        nlohmann::json pseudoanatomic;
        nlohmann::json rhizocarpian;
        nlohmann::json samel;
        nlohmann::json silker;
        nlohmann::json subdentated;
        nlohmann::json subobscure;

        public:
        const nlohmann::json & get_amoreuxia() const { return amoreuxia; }
        nlohmann::json & get_mutable_amoreuxia() { return amoreuxia; }
        void set_amoreuxia(const nlohmann::json & value) { this->amoreuxia = value; }

        const nlohmann::json & get_ani() const { return ani; }
        nlohmann::json & get_mutable_ani() { return ani; }
        void set_ani(const nlohmann::json & value) { this->ani = value; }

        const nlohmann::json & get_bernicle() const { return bernicle; }
        nlohmann::json & get_mutable_bernicle() { return bernicle; }
        void set_bernicle(const nlohmann::json & value) { this->bernicle = value; }

        const nlohmann::json & get_blackwasher() const { return blackwasher; }
        nlohmann::json & get_mutable_blackwasher() { return blackwasher; }
        void set_blackwasher(const nlohmann::json & value) { this->blackwasher = value; }

        const nlohmann::json & get_blowhard() const { return blowhard; }
        nlohmann::json & get_mutable_blowhard() { return blowhard; }
        void set_blowhard(const nlohmann::json & value) { this->blowhard = value; }

        const nlohmann::json & get_broma() const { return broma; }
        nlohmann::json & get_mutable_broma() { return broma; }
        void set_broma(const nlohmann::json & value) { this->broma = value; }

        const nlohmann::json & get_closecross() const { return closecross; }
        nlohmann::json & get_mutable_closecross() { return closecross; }
        void set_closecross(const nlohmann::json & value) { this->closecross = value; }

        const nlohmann::json & get_congregationalism() const { return congregationalism; }
        nlohmann::json & get_mutable_congregationalism() { return congregationalism; }
        void set_congregationalism(const nlohmann::json & value) { this->congregationalism = value; }

        const nlohmann::json & get_grayly() const { return grayly; }
        nlohmann::json & get_mutable_grayly() { return grayly; }
        void set_grayly(const nlohmann::json & value) { this->grayly = value; }

        const nlohmann::json & get_historically() const { return historically; }
        nlohmann::json & get_mutable_historically() { return historically; }
        void set_historically(const nlohmann::json & value) { this->historically = value; }

        const nlohmann::json & get_hoast() const { return hoast; }
        nlohmann::json & get_mutable_hoast() { return hoast; }
        void set_hoast(const nlohmann::json & value) { this->hoast = value; }

        const nlohmann::json & get_irretentive() const { return irretentive; }
        nlohmann::json & get_mutable_irretentive() { return irretentive; }
        void set_irretentive(const nlohmann::json & value) { this->irretentive = value; }

        const nlohmann::json & get_parcener() const { return parcener; }
        nlohmann::json & get_mutable_parcener() { return parcener; }
        void set_parcener(const nlohmann::json & value) { this->parcener = value; }

        const nlohmann::json & get_pedder() const { return pedder; }
        nlohmann::json & get_mutable_pedder() { return pedder; }
        void set_pedder(const nlohmann::json & value) { this->pedder = value; }

        const nlohmann::json & get_pseudoanatomic() const { return pseudoanatomic; }
        nlohmann::json & get_mutable_pseudoanatomic() { return pseudoanatomic; }
        void set_pseudoanatomic(const nlohmann::json & value) { this->pseudoanatomic = value; }

        const nlohmann::json & get_rhizocarpian() const { return rhizocarpian; }
        nlohmann::json & get_mutable_rhizocarpian() { return rhizocarpian; }
        void set_rhizocarpian(const nlohmann::json & value) { this->rhizocarpian = value; }

        const nlohmann::json & get_samel() const { return samel; }
        nlohmann::json & get_mutable_samel() { return samel; }
        void set_samel(const nlohmann::json & value) { this->samel = value; }

        const nlohmann::json & get_silker() const { return silker; }
        nlohmann::json & get_mutable_silker() { return silker; }
        void set_silker(const nlohmann::json & value) { this->silker = value; }

        const nlohmann::json & get_subdentated() const { return subdentated; }
        nlohmann::json & get_mutable_subdentated() { return subdentated; }
        void set_subdentated(const nlohmann::json & value) { this->subdentated = value; }

        const nlohmann::json & get_subobscure() const { return subobscure; }
        nlohmann::json & get_mutable_subobscure() { return subobscure; }
        void set_subobscure(const nlohmann::json & value) { this->subobscure = value; }
    };

    using DiaereseElement = std::variant<std::vector<int64_t>, bool, DiaereseClass>;

    using Downstroke = std::variant<std::vector<nlohmann::json>, bool, std::string>;

    using Eleutheromania = std::variant<double, std::map<std::string, int64_t>, std::string>;

    class Encrust {
        public:
        Encrust() = default;
        virtual ~Encrust() = default;

        private:
        nlohmann::json comradely;
        nlohmann::json diacanthous;
        nlohmann::json feminineness;
        nlohmann::json gossamered;
        nlohmann::json hibernia;
        nlohmann::json hibiscus;
        nlohmann::json lepidosauria;
        nlohmann::json lollingly;
        nlohmann::json manager;
        nlohmann::json mechanic;
        nlohmann::json overminuteness;
        nlohmann::json papelonne;
        nlohmann::json plebification;
        nlohmann::json pugmiller;
        nlohmann::json recoveror;
        nlohmann::json spermatoblastic;
        nlohmann::json syllidae;
        nlohmann::json ungyved;
        nlohmann::json whirlabout;
        nlohmann::json woodenware;

        public:
        const nlohmann::json & get_comradely() const { return comradely; }
        nlohmann::json & get_mutable_comradely() { return comradely; }
        void set_comradely(const nlohmann::json & value) { this->comradely = value; }

        const nlohmann::json & get_diacanthous() const { return diacanthous; }
        nlohmann::json & get_mutable_diacanthous() { return diacanthous; }
        void set_diacanthous(const nlohmann::json & value) { this->diacanthous = value; }

        const nlohmann::json & get_feminineness() const { return feminineness; }
        nlohmann::json & get_mutable_feminineness() { return feminineness; }
        void set_feminineness(const nlohmann::json & value) { this->feminineness = value; }

        const nlohmann::json & get_gossamered() const { return gossamered; }
        nlohmann::json & get_mutable_gossamered() { return gossamered; }
        void set_gossamered(const nlohmann::json & value) { this->gossamered = value; }

        const nlohmann::json & get_hibernia() const { return hibernia; }
        nlohmann::json & get_mutable_hibernia() { return hibernia; }
        void set_hibernia(const nlohmann::json & value) { this->hibernia = value; }

        const nlohmann::json & get_hibiscus() const { return hibiscus; }
        nlohmann::json & get_mutable_hibiscus() { return hibiscus; }
        void set_hibiscus(const nlohmann::json & value) { this->hibiscus = value; }

        const nlohmann::json & get_lepidosauria() const { return lepidosauria; }
        nlohmann::json & get_mutable_lepidosauria() { return lepidosauria; }
        void set_lepidosauria(const nlohmann::json & value) { this->lepidosauria = value; }

        const nlohmann::json & get_lollingly() const { return lollingly; }
        nlohmann::json & get_mutable_lollingly() { return lollingly; }
        void set_lollingly(const nlohmann::json & value) { this->lollingly = value; }

        const nlohmann::json & get_manager() const { return manager; }
        nlohmann::json & get_mutable_manager() { return manager; }
        void set_manager(const nlohmann::json & value) { this->manager = value; }

        const nlohmann::json & get_mechanic() const { return mechanic; }
        nlohmann::json & get_mutable_mechanic() { return mechanic; }
        void set_mechanic(const nlohmann::json & value) { this->mechanic = value; }

        const nlohmann::json & get_overminuteness() const { return overminuteness; }
        nlohmann::json & get_mutable_overminuteness() { return overminuteness; }
        void set_overminuteness(const nlohmann::json & value) { this->overminuteness = value; }

        const nlohmann::json & get_papelonne() const { return papelonne; }
        nlohmann::json & get_mutable_papelonne() { return papelonne; }
        void set_papelonne(const nlohmann::json & value) { this->papelonne = value; }

        const nlohmann::json & get_plebification() const { return plebification; }
        nlohmann::json & get_mutable_plebification() { return plebification; }
        void set_plebification(const nlohmann::json & value) { this->plebification = value; }

        const nlohmann::json & get_pugmiller() const { return pugmiller; }
        nlohmann::json & get_mutable_pugmiller() { return pugmiller; }
        void set_pugmiller(const nlohmann::json & value) { this->pugmiller = value; }

        const nlohmann::json & get_recoveror() const { return recoveror; }
        nlohmann::json & get_mutable_recoveror() { return recoveror; }
        void set_recoveror(const nlohmann::json & value) { this->recoveror = value; }

        const nlohmann::json & get_spermatoblastic() const { return spermatoblastic; }
        nlohmann::json & get_mutable_spermatoblastic() { return spermatoblastic; }
        void set_spermatoblastic(const nlohmann::json & value) { this->spermatoblastic = value; }

        const nlohmann::json & get_syllidae() const { return syllidae; }
        nlohmann::json & get_mutable_syllidae() { return syllidae; }
        void set_syllidae(const nlohmann::json & value) { this->syllidae = value; }

        const nlohmann::json & get_ungyved() const { return ungyved; }
        nlohmann::json & get_mutable_ungyved() { return ungyved; }
        void set_ungyved(const nlohmann::json & value) { this->ungyved = value; }

        const nlohmann::json & get_whirlabout() const { return whirlabout; }
        nlohmann::json & get_mutable_whirlabout() { return whirlabout; }
        void set_whirlabout(const nlohmann::json & value) { this->whirlabout = value; }

        const nlohmann::json & get_woodenware() const { return woodenware; }
        nlohmann::json & get_mutable_woodenware() { return woodenware; }
        void set_woodenware(const nlohmann::json & value) { this->woodenware = value; }
    };

    using Entomoid = std::variant<CimeliaClass, int64_t>;

    using Epipaleolithic = std::variant<std::vector<int64_t>, double>;

    using Expropriable = std::variant<std::vector<nlohmann::json>, CimeliaClass, double>;

    class FagginglyClass {
        public:
        FagginglyClass() = default;
        virtual ~FagginglyClass() = default;

        private:
        nlohmann::json abranchian;
        nlohmann::json aculeiform;
        nlohmann::json adiaphoristic;
        nlohmann::json adoptionism;
        nlohmann::json anglic;
        nlohmann::json antrotomy;
        nlohmann::json coerciveness;
        nlohmann::json decorist;
        nlohmann::json duckhood;
        nlohmann::json heteromeri;
        nlohmann::json hypochnose;
        nlohmann::json lochage;
        nlohmann::json melee;
        nlohmann::json nonconformitant;
        nlohmann::json poinsettia;
        nlohmann::json putatively;
        nlohmann::json semivolatile;
        nlohmann::json soleas;
        nlohmann::json unfastenable;
        nlohmann::json unmillinered;

        public:
        const nlohmann::json & get_abranchian() const { return abranchian; }
        nlohmann::json & get_mutable_abranchian() { return abranchian; }
        void set_abranchian(const nlohmann::json & value) { this->abranchian = value; }

        const nlohmann::json & get_aculeiform() const { return aculeiform; }
        nlohmann::json & get_mutable_aculeiform() { return aculeiform; }
        void set_aculeiform(const nlohmann::json & value) { this->aculeiform = value; }

        const nlohmann::json & get_adiaphoristic() const { return adiaphoristic; }
        nlohmann::json & get_mutable_adiaphoristic() { return adiaphoristic; }
        void set_adiaphoristic(const nlohmann::json & value) { this->adiaphoristic = value; }

        const nlohmann::json & get_adoptionism() const { return adoptionism; }
        nlohmann::json & get_mutable_adoptionism() { return adoptionism; }
        void set_adoptionism(const nlohmann::json & value) { this->adoptionism = value; }

        const nlohmann::json & get_anglic() const { return anglic; }
        nlohmann::json & get_mutable_anglic() { return anglic; }
        void set_anglic(const nlohmann::json & value) { this->anglic = value; }

        const nlohmann::json & get_antrotomy() const { return antrotomy; }
        nlohmann::json & get_mutable_antrotomy() { return antrotomy; }
        void set_antrotomy(const nlohmann::json & value) { this->antrotomy = value; }

        const nlohmann::json & get_coerciveness() const { return coerciveness; }
        nlohmann::json & get_mutable_coerciveness() { return coerciveness; }
        void set_coerciveness(const nlohmann::json & value) { this->coerciveness = value; }

        const nlohmann::json & get_decorist() const { return decorist; }
        nlohmann::json & get_mutable_decorist() { return decorist; }
        void set_decorist(const nlohmann::json & value) { this->decorist = value; }

        const nlohmann::json & get_duckhood() const { return duckhood; }
        nlohmann::json & get_mutable_duckhood() { return duckhood; }
        void set_duckhood(const nlohmann::json & value) { this->duckhood = value; }

        const nlohmann::json & get_heteromeri() const { return heteromeri; }
        nlohmann::json & get_mutable_heteromeri() { return heteromeri; }
        void set_heteromeri(const nlohmann::json & value) { this->heteromeri = value; }

        const nlohmann::json & get_hypochnose() const { return hypochnose; }
        nlohmann::json & get_mutable_hypochnose() { return hypochnose; }
        void set_hypochnose(const nlohmann::json & value) { this->hypochnose = value; }

        const nlohmann::json & get_lochage() const { return lochage; }
        nlohmann::json & get_mutable_lochage() { return lochage; }
        void set_lochage(const nlohmann::json & value) { this->lochage = value; }

        const nlohmann::json & get_melee() const { return melee; }
        nlohmann::json & get_mutable_melee() { return melee; }
        void set_melee(const nlohmann::json & value) { this->melee = value; }

        const nlohmann::json & get_nonconformitant() const { return nonconformitant; }
        nlohmann::json & get_mutable_nonconformitant() { return nonconformitant; }
        void set_nonconformitant(const nlohmann::json & value) { this->nonconformitant = value; }

        const nlohmann::json & get_poinsettia() const { return poinsettia; }
        nlohmann::json & get_mutable_poinsettia() { return poinsettia; }
        void set_poinsettia(const nlohmann::json & value) { this->poinsettia = value; }

        const nlohmann::json & get_putatively() const { return putatively; }
        nlohmann::json & get_mutable_putatively() { return putatively; }
        void set_putatively(const nlohmann::json & value) { this->putatively = value; }

        const nlohmann::json & get_semivolatile() const { return semivolatile; }
        nlohmann::json & get_mutable_semivolatile() { return semivolatile; }
        void set_semivolatile(const nlohmann::json & value) { this->semivolatile = value; }

        const nlohmann::json & get_soleas() const { return soleas; }
        nlohmann::json & get_mutable_soleas() { return soleas; }
        void set_soleas(const nlohmann::json & value) { this->soleas = value; }

        const nlohmann::json & get_unfastenable() const { return unfastenable; }
        nlohmann::json & get_mutable_unfastenable() { return unfastenable; }
        void set_unfastenable(const nlohmann::json & value) { this->unfastenable = value; }

        const nlohmann::json & get_unmillinered() const { return unmillinered; }
        nlohmann::json & get_mutable_unmillinered() { return unmillinered; }
        void set_unmillinered(const nlohmann::json & value) { this->unmillinered = value; }
    };

    using FagginglyElement = std::variant<FagginglyClass, double>;

    class FenkClass {
        public:
        FenkClass() = default;
        virtual ~FenkClass() = default;

        private:
        nlohmann::json apoise;
        nlohmann::json astronomize;
        nlohmann::json cockhorse;
        nlohmann::json copular;
        nlohmann::json dagomba;
        nlohmann::json draffy;
        nlohmann::json foreigner;
        nlohmann::json guyandot;
        nlohmann::json neurogliosis;
        nlohmann::json osmious;
        nlohmann::json palpitate;
        nlohmann::json rebukeable;
        nlohmann::json reinwardtia;
        nlohmann::json reservatory;
        nlohmann::json scalt;
        nlohmann::json scripturalize;
        nlohmann::json tintometer;
        nlohmann::json tritoness;
        nlohmann::json undergrade;
        nlohmann::json undermountain;

        public:
        const nlohmann::json & get_apoise() const { return apoise; }
        nlohmann::json & get_mutable_apoise() { return apoise; }
        void set_apoise(const nlohmann::json & value) { this->apoise = value; }

        const nlohmann::json & get_astronomize() const { return astronomize; }
        nlohmann::json & get_mutable_astronomize() { return astronomize; }
        void set_astronomize(const nlohmann::json & value) { this->astronomize = value; }

        const nlohmann::json & get_cockhorse() const { return cockhorse; }
        nlohmann::json & get_mutable_cockhorse() { return cockhorse; }
        void set_cockhorse(const nlohmann::json & value) { this->cockhorse = value; }

        const nlohmann::json & get_copular() const { return copular; }
        nlohmann::json & get_mutable_copular() { return copular; }
        void set_copular(const nlohmann::json & value) { this->copular = value; }

        const nlohmann::json & get_dagomba() const { return dagomba; }
        nlohmann::json & get_mutable_dagomba() { return dagomba; }
        void set_dagomba(const nlohmann::json & value) { this->dagomba = value; }

        const nlohmann::json & get_draffy() const { return draffy; }
        nlohmann::json & get_mutable_draffy() { return draffy; }
        void set_draffy(const nlohmann::json & value) { this->draffy = value; }

        const nlohmann::json & get_foreigner() const { return foreigner; }
        nlohmann::json & get_mutable_foreigner() { return foreigner; }
        void set_foreigner(const nlohmann::json & value) { this->foreigner = value; }

        const nlohmann::json & get_guyandot() const { return guyandot; }
        nlohmann::json & get_mutable_guyandot() { return guyandot; }
        void set_guyandot(const nlohmann::json & value) { this->guyandot = value; }

        const nlohmann::json & get_neurogliosis() const { return neurogliosis; }
        nlohmann::json & get_mutable_neurogliosis() { return neurogliosis; }
        void set_neurogliosis(const nlohmann::json & value) { this->neurogliosis = value; }

        const nlohmann::json & get_osmious() const { return osmious; }
        nlohmann::json & get_mutable_osmious() { return osmious; }
        void set_osmious(const nlohmann::json & value) { this->osmious = value; }

        const nlohmann::json & get_palpitate() const { return palpitate; }
        nlohmann::json & get_mutable_palpitate() { return palpitate; }
        void set_palpitate(const nlohmann::json & value) { this->palpitate = value; }

        const nlohmann::json & get_rebukeable() const { return rebukeable; }
        nlohmann::json & get_mutable_rebukeable() { return rebukeable; }
        void set_rebukeable(const nlohmann::json & value) { this->rebukeable = value; }

        const nlohmann::json & get_reinwardtia() const { return reinwardtia; }
        nlohmann::json & get_mutable_reinwardtia() { return reinwardtia; }
        void set_reinwardtia(const nlohmann::json & value) { this->reinwardtia = value; }

        const nlohmann::json & get_reservatory() const { return reservatory; }
        nlohmann::json & get_mutable_reservatory() { return reservatory; }
        void set_reservatory(const nlohmann::json & value) { this->reservatory = value; }

        const nlohmann::json & get_scalt() const { return scalt; }
        nlohmann::json & get_mutable_scalt() { return scalt; }
        void set_scalt(const nlohmann::json & value) { this->scalt = value; }

        const nlohmann::json & get_scripturalize() const { return scripturalize; }
        nlohmann::json & get_mutable_scripturalize() { return scripturalize; }
        void set_scripturalize(const nlohmann::json & value) { this->scripturalize = value; }

        const nlohmann::json & get_tintometer() const { return tintometer; }
        nlohmann::json & get_mutable_tintometer() { return tintometer; }
        void set_tintometer(const nlohmann::json & value) { this->tintometer = value; }

        const nlohmann::json & get_tritoness() const { return tritoness; }
        nlohmann::json & get_mutable_tritoness() { return tritoness; }
        void set_tritoness(const nlohmann::json & value) { this->tritoness = value; }

        const nlohmann::json & get_undergrade() const { return undergrade; }
        nlohmann::json & get_mutable_undergrade() { return undergrade; }
        void set_undergrade(const nlohmann::json & value) { this->undergrade = value; }

        const nlohmann::json & get_undermountain() const { return undermountain; }
        nlohmann::json & get_mutable_undermountain() { return undermountain; }
        void set_undermountain(const nlohmann::json & value) { this->undermountain = value; }
    };

    using FenkElement = std::variant<FenkClass, std::string>;

    class FlagmakingClass {
        public:
        FlagmakingClass() = default;
        virtual ~FlagmakingClass() = default;

        private:
        nlohmann::json albarco;
        nlohmann::json bunodonta;
        nlohmann::json hornify;
        nlohmann::json hydrocorisae;
        nlohmann::json hypoglossus;
        nlohmann::json inexpiably;
        nlohmann::json ingratitude;
        nlohmann::json ladyfly;
        nlohmann::json medicament;
        nlohmann::json monogrammatic;
        nlohmann::json nobbut;
        nlohmann::json notacanthidae;
        nlohmann::json polyplacophore;
        nlohmann::json proexercise;
        nlohmann::json protoplast;
        nlohmann::json puzzling;
        nlohmann::json splanchnoskeleton;
        nlohmann::json unloveliness;
        nlohmann::json unquarantined;
        nlohmann::json unrenounceable;

        public:
        const nlohmann::json & get_albarco() const { return albarco; }
        nlohmann::json & get_mutable_albarco() { return albarco; }
        void set_albarco(const nlohmann::json & value) { this->albarco = value; }

        const nlohmann::json & get_bunodonta() const { return bunodonta; }
        nlohmann::json & get_mutable_bunodonta() { return bunodonta; }
        void set_bunodonta(const nlohmann::json & value) { this->bunodonta = value; }

        const nlohmann::json & get_hornify() const { return hornify; }
        nlohmann::json & get_mutable_hornify() { return hornify; }
        void set_hornify(const nlohmann::json & value) { this->hornify = value; }

        const nlohmann::json & get_hydrocorisae() const { return hydrocorisae; }
        nlohmann::json & get_mutable_hydrocorisae() { return hydrocorisae; }
        void set_hydrocorisae(const nlohmann::json & value) { this->hydrocorisae = value; }

        const nlohmann::json & get_hypoglossus() const { return hypoglossus; }
        nlohmann::json & get_mutable_hypoglossus() { return hypoglossus; }
        void set_hypoglossus(const nlohmann::json & value) { this->hypoglossus = value; }

        const nlohmann::json & get_inexpiably() const { return inexpiably; }
        nlohmann::json & get_mutable_inexpiably() { return inexpiably; }
        void set_inexpiably(const nlohmann::json & value) { this->inexpiably = value; }

        const nlohmann::json & get_ingratitude() const { return ingratitude; }
        nlohmann::json & get_mutable_ingratitude() { return ingratitude; }
        void set_ingratitude(const nlohmann::json & value) { this->ingratitude = value; }

        const nlohmann::json & get_ladyfly() const { return ladyfly; }
        nlohmann::json & get_mutable_ladyfly() { return ladyfly; }
        void set_ladyfly(const nlohmann::json & value) { this->ladyfly = value; }

        const nlohmann::json & get_medicament() const { return medicament; }
        nlohmann::json & get_mutable_medicament() { return medicament; }
        void set_medicament(const nlohmann::json & value) { this->medicament = value; }

        const nlohmann::json & get_monogrammatic() const { return monogrammatic; }
        nlohmann::json & get_mutable_monogrammatic() { return monogrammatic; }
        void set_monogrammatic(const nlohmann::json & value) { this->monogrammatic = value; }

        const nlohmann::json & get_nobbut() const { return nobbut; }
        nlohmann::json & get_mutable_nobbut() { return nobbut; }
        void set_nobbut(const nlohmann::json & value) { this->nobbut = value; }

        const nlohmann::json & get_notacanthidae() const { return notacanthidae; }
        nlohmann::json & get_mutable_notacanthidae() { return notacanthidae; }
        void set_notacanthidae(const nlohmann::json & value) { this->notacanthidae = value; }

        const nlohmann::json & get_polyplacophore() const { return polyplacophore; }
        nlohmann::json & get_mutable_polyplacophore() { return polyplacophore; }
        void set_polyplacophore(const nlohmann::json & value) { this->polyplacophore = value; }

        const nlohmann::json & get_proexercise() const { return proexercise; }
        nlohmann::json & get_mutable_proexercise() { return proexercise; }
        void set_proexercise(const nlohmann::json & value) { this->proexercise = value; }

        const nlohmann::json & get_protoplast() const { return protoplast; }
        nlohmann::json & get_mutable_protoplast() { return protoplast; }
        void set_protoplast(const nlohmann::json & value) { this->protoplast = value; }

        const nlohmann::json & get_puzzling() const { return puzzling; }
        nlohmann::json & get_mutable_puzzling() { return puzzling; }
        void set_puzzling(const nlohmann::json & value) { this->puzzling = value; }

        const nlohmann::json & get_splanchnoskeleton() const { return splanchnoskeleton; }
        nlohmann::json & get_mutable_splanchnoskeleton() { return splanchnoskeleton; }
        void set_splanchnoskeleton(const nlohmann::json & value) { this->splanchnoskeleton = value; }

        const nlohmann::json & get_unloveliness() const { return unloveliness; }
        nlohmann::json & get_mutable_unloveliness() { return unloveliness; }
        void set_unloveliness(const nlohmann::json & value) { this->unloveliness = value; }

        const nlohmann::json & get_unquarantined() const { return unquarantined; }
        nlohmann::json & get_mutable_unquarantined() { return unquarantined; }
        void set_unquarantined(const nlohmann::json & value) { this->unquarantined = value; }

        const nlohmann::json & get_unrenounceable() const { return unrenounceable; }
        nlohmann::json & get_mutable_unrenounceable() { return unrenounceable; }
        void set_unrenounceable(const nlohmann::json & value) { this->unrenounceable = value; }
    };

    using FlagmakingElement = std::variant<bool, FlagmakingClass, double>;

    using Fluorometer = std::optional<std::variant<int64_t, std::string>>;

    using Fuzzy = std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>;

    using Gardenward = std::variant<std::vector<int64_t>, bool, std::string>;

    using Generalissimo = std::optional<std::variant<bool, std::map<std::string, int64_t>>>;

    using Hemicrystalline = std::variant<CimeliaClass, std::string>;

    class HemocoeleClass {
        public:
        HemocoeleClass() = default;
        virtual ~HemocoeleClass() = default;

        private:
        nlohmann::json acrogamy;
        nlohmann::json amelification;
        nlohmann::json autobiographic;
        nlohmann::json berat;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<std::string> disdiapason;
        nlohmann::json disproportionably;
        nlohmann::json erythrite;
        nlohmann::json graphic;
        nlohmann::json hepatological;
        std::optional<bool> homocerc;
        nlohmann::json incommensurably;
        nlohmann::json misaffirm;
        nlohmann::json nonbookish;
        nlohmann::json pocketbook;
        nlohmann::json sclerometric;
        nlohmann::json stambouline;
        nlohmann::json stickpin;
        nlohmann::json tubulure;
        nlohmann::json undelated;
        nlohmann::json unsalt;
        nlohmann::json untutelar;
        nlohmann::json vagrant;
        nlohmann::json walt;

        public:
        const nlohmann::json & get_acrogamy() const { return acrogamy; }
        nlohmann::json & get_mutable_acrogamy() { return acrogamy; }
        void set_acrogamy(const nlohmann::json & value) { this->acrogamy = value; }

        const nlohmann::json & get_amelification() const { return amelification; }
        nlohmann::json & get_mutable_amelification() { return amelification; }
        void set_amelification(const nlohmann::json & value) { this->amelification = value; }

        const nlohmann::json & get_autobiographic() const { return autobiographic; }
        nlohmann::json & get_mutable_autobiographic() { return autobiographic; }
        void set_autobiographic(const nlohmann::json & value) { this->autobiographic = value; }

        const nlohmann::json & get_berat() const { return berat; }
        nlohmann::json & get_mutable_berat() { return berat; }
        void set_berat(const nlohmann::json & value) { this->berat = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const nlohmann::json & get_disproportionably() const { return disproportionably; }
        nlohmann::json & get_mutable_disproportionably() { return disproportionably; }
        void set_disproportionably(const nlohmann::json & value) { this->disproportionably = value; }

        const nlohmann::json & get_erythrite() const { return erythrite; }
        nlohmann::json & get_mutable_erythrite() { return erythrite; }
        void set_erythrite(const nlohmann::json & value) { this->erythrite = value; }

        const nlohmann::json & get_graphic() const { return graphic; }
        nlohmann::json & get_mutable_graphic() { return graphic; }
        void set_graphic(const nlohmann::json & value) { this->graphic = value; }

        const nlohmann::json & get_hepatological() const { return hepatological; }
        nlohmann::json & get_mutable_hepatological() { return hepatological; }
        void set_hepatological(const nlohmann::json & value) { this->hepatological = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const nlohmann::json & get_incommensurably() const { return incommensurably; }
        nlohmann::json & get_mutable_incommensurably() { return incommensurably; }
        void set_incommensurably(const nlohmann::json & value) { this->incommensurably = value; }

        const nlohmann::json & get_misaffirm() const { return misaffirm; }
        nlohmann::json & get_mutable_misaffirm() { return misaffirm; }
        void set_misaffirm(const nlohmann::json & value) { this->misaffirm = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const nlohmann::json & get_pocketbook() const { return pocketbook; }
        nlohmann::json & get_mutable_pocketbook() { return pocketbook; }
        void set_pocketbook(const nlohmann::json & value) { this->pocketbook = value; }

        const nlohmann::json & get_sclerometric() const { return sclerometric; }
        nlohmann::json & get_mutable_sclerometric() { return sclerometric; }
        void set_sclerometric(const nlohmann::json & value) { this->sclerometric = value; }

        const nlohmann::json & get_stambouline() const { return stambouline; }
        nlohmann::json & get_mutable_stambouline() { return stambouline; }
        void set_stambouline(const nlohmann::json & value) { this->stambouline = value; }

        const nlohmann::json & get_stickpin() const { return stickpin; }
        nlohmann::json & get_mutable_stickpin() { return stickpin; }
        void set_stickpin(const nlohmann::json & value) { this->stickpin = value; }

        const nlohmann::json & get_tubulure() const { return tubulure; }
        nlohmann::json & get_mutable_tubulure() { return tubulure; }
        void set_tubulure(const nlohmann::json & value) { this->tubulure = value; }

        const nlohmann::json & get_undelated() const { return undelated; }
        nlohmann::json & get_mutable_undelated() { return undelated; }
        void set_undelated(const nlohmann::json & value) { this->undelated = value; }

        const nlohmann::json & get_unsalt() const { return unsalt; }
        nlohmann::json & get_mutable_unsalt() { return unsalt; }
        void set_unsalt(const nlohmann::json & value) { this->unsalt = value; }

        const nlohmann::json & get_untutelar() const { return untutelar; }
        nlohmann::json & get_mutable_untutelar() { return untutelar; }
        void set_untutelar(const nlohmann::json & value) { this->untutelar = value; }

        const nlohmann::json & get_vagrant() const { return vagrant; }
        nlohmann::json & get_mutable_vagrant() { return vagrant; }
        void set_vagrant(const nlohmann::json & value) { this->vagrant = value; }

        const nlohmann::json & get_walt() const { return walt; }
        nlohmann::json & get_mutable_walt() { return walt; }
        void set_walt(const nlohmann::json & value) { this->walt = value; }
    };

    using HemocoeleElement = std::variant<std::vector<int64_t>, HemocoeleClass>;

    using Hoister = std::optional<std::variant<CimeliaClass, std::string>>;

    using Hyperpiesi = std::optional<std::variant<std::vector<nlohmann::json>, CimeliaClass>>;

    using Hyppish = std::optional<std::variant<bool, std::string>>;

    using Idealizer = std::variant<std::vector<nlohmann::json>, CimeliaClass, int64_t>;

    using Incrustator = std::variant<std::vector<int64_t>, int64_t, std::string>;

    using Intentiveness = std::variant<CimeliaClass, double, std::string>;

    class Interacinar {
        public:
        Interacinar() = default;
        virtual ~Interacinar() = default;

        private:
        double assapan;
        bool benefactorship;
        std::string triseriatim;
        int64_t tubbing;
        nlohmann::json untrimmed;

        public:
        const double & get_assapan() const { return assapan; }
        double & get_mutable_assapan() { return assapan; }
        void set_assapan(const double & value) { this->assapan = value; }

        const bool & get_benefactorship() const { return benefactorship; }
        bool & get_mutable_benefactorship() { return benefactorship; }
        void set_benefactorship(const bool & value) { this->benefactorship = value; }

        const std::string & get_triseriatim() const { return triseriatim; }
        std::string & get_mutable_triseriatim() { return triseriatim; }
        void set_triseriatim(const std::string & value) { this->triseriatim = value; }

        const int64_t & get_tubbing() const { return tubbing; }
        int64_t & get_mutable_tubbing() { return tubbing; }
        void set_tubbing(const int64_t & value) { this->tubbing = value; }

        const nlohmann::json & get_untrimmed() const { return untrimmed; }
        nlohmann::json & get_mutable_untrimmed() { return untrimmed; }
        void set_untrimmed(const nlohmann::json & value) { this->untrimmed = value; }
    };

    using Jacutinga = std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string centrodesmose;
        std::vector<CerographElement> cerograph;
        std::vector<ChemotherapeuticElement> chemotherapeutics;
        std::vector<CimeliaElement> cimelia;
        int64_t citrated;
        std::vector<Clinodome> clinodome;
        std::vector<CoadjustElement> coadjust;
        std::vector<Consilience> consilience;
        std::vector<Constructor> constructor;
        std::vector<Continuative> continuative;
        std::vector<CredulityElement> credulity;
        std::vector<Creviced> creviced;
        std::vector<std::vector<std::optional<int64_t>>> cubiculum;
        std::vector<DeruralizeElement> deruralize;
        std::vector<DiaereseElement> diaereses;
        std::vector<std::optional<std::vector<nlohmann::json>>> dissolution;
        std::vector<Downstroke> downstroke;
        std::vector<std::optional<double>> electrotautomerism;
        std::vector<Eleutheromania> eleutheromania;
        Encrust encrust;
        std::vector<Entomoid> entomoid;
        std::vector<Epipaleolithic> epipaleolithic;
        std::vector<Expropriable> expropriable;
        std::vector<FagginglyElement> faggingly;
        std::vector<FenkElement> fenks;
        std::vector<FlagmakingElement> flagmaking;
        std::vector<Fluorometer> fluorometer;
        std::vector<std::optional<int64_t>> fulsome;
        std::vector<Fuzzy> fuzzy;
        std::vector<Gardenward> gardenwards;
        std::vector<Generalissimo> generalissimo;
        std::vector<std::optional<std::map<std::string, int64_t>>> habeas;
        std::vector<Hemicrystalline> hemicrystalline;
        std::vector<HemocoeleElement> hemocoele;
        std::vector<Hoister> hoister;
        std::vector<Hyperpiesi> hyperpiesis;
        std::vector<Hyppish> hyppish;
        std::vector<Idealizer> idealizer;
        std::vector<Incrustator> incrustator;
        std::vector<Intentiveness> intentiveness;
        Interacinar interacinar;
        std::vector<std::optional<std::vector<int64_t>>> intercorrelation;
        std::vector<Jacutinga> jacutinga;

        public:
        const std::string & get_centrodesmose() const { return centrodesmose; }
        std::string & get_mutable_centrodesmose() { return centrodesmose; }
        void set_centrodesmose(const std::string & value) { this->centrodesmose = value; }

        const std::vector<CerographElement> & get_cerograph() const { return cerograph; }
        std::vector<CerographElement> & get_mutable_cerograph() { return cerograph; }
        void set_cerograph(const std::vector<CerographElement> & value) { this->cerograph = value; }

        const std::vector<ChemotherapeuticElement> & get_chemotherapeutics() const { return chemotherapeutics; }
        std::vector<ChemotherapeuticElement> & get_mutable_chemotherapeutics() { return chemotherapeutics; }
        void set_chemotherapeutics(const std::vector<ChemotherapeuticElement> & value) { this->chemotherapeutics = value; }

        const std::vector<CimeliaElement> & get_cimelia() const { return cimelia; }
        std::vector<CimeliaElement> & get_mutable_cimelia() { return cimelia; }
        void set_cimelia(const std::vector<CimeliaElement> & value) { this->cimelia = value; }

        const int64_t & get_citrated() const { return citrated; }
        int64_t & get_mutable_citrated() { return citrated; }
        void set_citrated(const int64_t & value) { this->citrated = value; }

        const std::vector<Clinodome> & get_clinodome() const { return clinodome; }
        std::vector<Clinodome> & get_mutable_clinodome() { return clinodome; }
        void set_clinodome(const std::vector<Clinodome> & value) { this->clinodome = value; }

        const std::vector<CoadjustElement> & get_coadjust() const { return coadjust; }
        std::vector<CoadjustElement> & get_mutable_coadjust() { return coadjust; }
        void set_coadjust(const std::vector<CoadjustElement> & value) { this->coadjust = value; }

        const std::vector<Consilience> & get_consilience() const { return consilience; }
        std::vector<Consilience> & get_mutable_consilience() { return consilience; }
        void set_consilience(const std::vector<Consilience> & value) { this->consilience = value; }

        const std::vector<Constructor> & get_constructor() const { return constructor; }
        std::vector<Constructor> & get_mutable_constructor() { return constructor; }
        void set_constructor(const std::vector<Constructor> & value) { this->constructor = value; }

        const std::vector<Continuative> & get_continuative() const { return continuative; }
        std::vector<Continuative> & get_mutable_continuative() { return continuative; }
        void set_continuative(const std::vector<Continuative> & value) { this->continuative = value; }

        const std::vector<CredulityElement> & get_credulity() const { return credulity; }
        std::vector<CredulityElement> & get_mutable_credulity() { return credulity; }
        void set_credulity(const std::vector<CredulityElement> & value) { this->credulity = value; }

        const std::vector<Creviced> & get_creviced() const { return creviced; }
        std::vector<Creviced> & get_mutable_creviced() { return creviced; }
        void set_creviced(const std::vector<Creviced> & value) { this->creviced = value; }

        const std::vector<std::vector<std::optional<int64_t>>> & get_cubiculum() const { return cubiculum; }
        std::vector<std::vector<std::optional<int64_t>>> & get_mutable_cubiculum() { return cubiculum; }
        void set_cubiculum(const std::vector<std::vector<std::optional<int64_t>>> & value) { this->cubiculum = value; }

        const std::vector<DeruralizeElement> & get_deruralize() const { return deruralize; }
        std::vector<DeruralizeElement> & get_mutable_deruralize() { return deruralize; }
        void set_deruralize(const std::vector<DeruralizeElement> & value) { this->deruralize = value; }

        const std::vector<DiaereseElement> & get_diaereses() const { return diaereses; }
        std::vector<DiaereseElement> & get_mutable_diaereses() { return diaereses; }
        void set_diaereses(const std::vector<DiaereseElement> & value) { this->diaereses = value; }

        const std::vector<std::optional<std::vector<nlohmann::json>>> & get_dissolution() const { return dissolution; }
        std::vector<std::optional<std::vector<nlohmann::json>>> & get_mutable_dissolution() { return dissolution; }
        void set_dissolution(const std::vector<std::optional<std::vector<nlohmann::json>>> & value) { this->dissolution = value; }

        const std::vector<Downstroke> & get_downstroke() const { return downstroke; }
        std::vector<Downstroke> & get_mutable_downstroke() { return downstroke; }
        void set_downstroke(const std::vector<Downstroke> & value) { this->downstroke = value; }

        const std::vector<std::optional<double>> & get_electrotautomerism() const { return electrotautomerism; }
        std::vector<std::optional<double>> & get_mutable_electrotautomerism() { return electrotautomerism; }
        void set_electrotautomerism(const std::vector<std::optional<double>> & value) { this->electrotautomerism = value; }

        const std::vector<Eleutheromania> & get_eleutheromania() const { return eleutheromania; }
        std::vector<Eleutheromania> & get_mutable_eleutheromania() { return eleutheromania; }
        void set_eleutheromania(const std::vector<Eleutheromania> & value) { this->eleutheromania = value; }

        const Encrust & get_encrust() const { return encrust; }
        Encrust & get_mutable_encrust() { return encrust; }
        void set_encrust(const Encrust & value) { this->encrust = value; }

        const std::vector<Entomoid> & get_entomoid() const { return entomoid; }
        std::vector<Entomoid> & get_mutable_entomoid() { return entomoid; }
        void set_entomoid(const std::vector<Entomoid> & value) { this->entomoid = value; }

        const std::vector<Epipaleolithic> & get_epipaleolithic() const { return epipaleolithic; }
        std::vector<Epipaleolithic> & get_mutable_epipaleolithic() { return epipaleolithic; }
        void set_epipaleolithic(const std::vector<Epipaleolithic> & value) { this->epipaleolithic = value; }

        const std::vector<Expropriable> & get_expropriable() const { return expropriable; }
        std::vector<Expropriable> & get_mutable_expropriable() { return expropriable; }
        void set_expropriable(const std::vector<Expropriable> & value) { this->expropriable = value; }

        const std::vector<FagginglyElement> & get_faggingly() const { return faggingly; }
        std::vector<FagginglyElement> & get_mutable_faggingly() { return faggingly; }
        void set_faggingly(const std::vector<FagginglyElement> & value) { this->faggingly = value; }

        const std::vector<FenkElement> & get_fenks() const { return fenks; }
        std::vector<FenkElement> & get_mutable_fenks() { return fenks; }
        void set_fenks(const std::vector<FenkElement> & value) { this->fenks = value; }

        const std::vector<FlagmakingElement> & get_flagmaking() const { return flagmaking; }
        std::vector<FlagmakingElement> & get_mutable_flagmaking() { return flagmaking; }
        void set_flagmaking(const std::vector<FlagmakingElement> & value) { this->flagmaking = value; }

        const std::vector<Fluorometer> & get_fluorometer() const { return fluorometer; }
        std::vector<Fluorometer> & get_mutable_fluorometer() { return fluorometer; }
        void set_fluorometer(const std::vector<Fluorometer> & value) { this->fluorometer = value; }

        const std::vector<std::optional<int64_t>> & get_fulsome() const { return fulsome; }
        std::vector<std::optional<int64_t>> & get_mutable_fulsome() { return fulsome; }
        void set_fulsome(const std::vector<std::optional<int64_t>> & value) { this->fulsome = value; }

        const std::vector<Fuzzy> & get_fuzzy() const { return fuzzy; }
        std::vector<Fuzzy> & get_mutable_fuzzy() { return fuzzy; }
        void set_fuzzy(const std::vector<Fuzzy> & value) { this->fuzzy = value; }

        const std::vector<Gardenward> & get_gardenwards() const { return gardenwards; }
        std::vector<Gardenward> & get_mutable_gardenwards() { return gardenwards; }
        void set_gardenwards(const std::vector<Gardenward> & value) { this->gardenwards = value; }

        const std::vector<Generalissimo> & get_generalissimo() const { return generalissimo; }
        std::vector<Generalissimo> & get_mutable_generalissimo() { return generalissimo; }
        void set_generalissimo(const std::vector<Generalissimo> & value) { this->generalissimo = value; }

        const std::vector<std::optional<std::map<std::string, int64_t>>> & get_habeas() const { return habeas; }
        std::vector<std::optional<std::map<std::string, int64_t>>> & get_mutable_habeas() { return habeas; }
        void set_habeas(const std::vector<std::optional<std::map<std::string, int64_t>>> & value) { this->habeas = value; }

        const std::vector<Hemicrystalline> & get_hemicrystalline() const { return hemicrystalline; }
        std::vector<Hemicrystalline> & get_mutable_hemicrystalline() { return hemicrystalline; }
        void set_hemicrystalline(const std::vector<Hemicrystalline> & value) { this->hemicrystalline = value; }

        const std::vector<HemocoeleElement> & get_hemocoele() const { return hemocoele; }
        std::vector<HemocoeleElement> & get_mutable_hemocoele() { return hemocoele; }
        void set_hemocoele(const std::vector<HemocoeleElement> & value) { this->hemocoele = value; }

        const std::vector<Hoister> & get_hoister() const { return hoister; }
        std::vector<Hoister> & get_mutable_hoister() { return hoister; }
        void set_hoister(const std::vector<Hoister> & value) { this->hoister = value; }

        const std::vector<Hyperpiesi> & get_hyperpiesis() const { return hyperpiesis; }
        std::vector<Hyperpiesi> & get_mutable_hyperpiesis() { return hyperpiesis; }
        void set_hyperpiesis(const std::vector<Hyperpiesi> & value) { this->hyperpiesis = value; }

        const std::vector<Hyppish> & get_hyppish() const { return hyppish; }
        std::vector<Hyppish> & get_mutable_hyppish() { return hyppish; }
        void set_hyppish(const std::vector<Hyppish> & value) { this->hyppish = value; }

        const std::vector<Idealizer> & get_idealizer() const { return idealizer; }
        std::vector<Idealizer> & get_mutable_idealizer() { return idealizer; }
        void set_idealizer(const std::vector<Idealizer> & value) { this->idealizer = value; }

        const std::vector<Incrustator> & get_incrustator() const { return incrustator; }
        std::vector<Incrustator> & get_mutable_incrustator() { return incrustator; }
        void set_incrustator(const std::vector<Incrustator> & value) { this->incrustator = value; }

        const std::vector<Intentiveness> & get_intentiveness() const { return intentiveness; }
        std::vector<Intentiveness> & get_mutable_intentiveness() { return intentiveness; }
        void set_intentiveness(const std::vector<Intentiveness> & value) { this->intentiveness = value; }

        const Interacinar & get_interacinar() const { return interacinar; }
        Interacinar & get_mutable_interacinar() { return interacinar; }
        void set_interacinar(const Interacinar & value) { this->interacinar = value; }

        const std::vector<std::optional<std::vector<int64_t>>> & get_intercorrelation() const { return intercorrelation; }
        std::vector<std::optional<std::vector<int64_t>>> & get_mutable_intercorrelation() { return intercorrelation; }
        void set_intercorrelation(const std::vector<std::optional<std::vector<int64_t>>> & value) { this->intercorrelation = value; }

        const std::vector<Jacutinga> & get_jacutinga() const { return jacutinga; }
        std::vector<Jacutinga> & get_mutable_jacutinga() { return jacutinga; }
        void set_jacutinga(const std::vector<Jacutinga> & value) { this->jacutinga = value; }
    };
}

namespace quicktype {
void from_json(const json & j, CerographClass & x);
void to_json(json & j, const CerographClass & x);

void from_json(const json & j, ChemotherapeuticClass & x);
void to_json(json & j, const ChemotherapeuticClass & x);

void from_json(const json & j, CimeliaClass & x);
void to_json(json & j, const CimeliaClass & x);

void from_json(const json & j, CoadjustClass & x);
void to_json(json & j, const CoadjustClass & x);

void from_json(const json & j, CredulityClass & x);
void to_json(json & j, const CredulityClass & x);

void from_json(const json & j, DeruralizeClass & x);
void to_json(json & j, const DeruralizeClass & x);

void from_json(const json & j, DiaereseClass & x);
void to_json(json & j, const DiaereseClass & x);

void from_json(const json & j, Encrust & x);
void to_json(json & j, const Encrust & x);

void from_json(const json & j, FagginglyClass & x);
void to_json(json & j, const FagginglyClass & x);

void from_json(const json & j, FenkClass & x);
void to_json(json & j, const FenkClass & x);

void from_json(const json & j, FlagmakingClass & x);
void to_json(json & j, const FlagmakingClass & x);

void from_json(const json & j, HemocoeleClass & x);
void to_json(json & j, const HemocoeleClass & x);

void from_json(const json & j, Interacinar & x);
void to_json(json & j, const Interacinar & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::CerographClass, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::CerographClass, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::CerographClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ChemotherapeuticClass, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::ChemotherapeuticClass, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::ChemotherapeuticClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::CimeliaClass>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::CimeliaClass> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::CimeliaClass> & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(const json & j, std::variant<double, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CoadjustClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::CoadjustClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::CoadjustClass, double> & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<double, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(const json & j, std::variant<bool, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, const std::variant<bool, std::map<std::string, std::optional<int64_t>>> & x);
};

template <>
struct adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<std::map<std::string, int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CredulityClass, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::CredulityClass, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::CredulityClass, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<bool, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<bool, std::map<std::string, int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, quicktype::DeruralizeClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, std::string> & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<double, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::map<std::string, int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CimeliaClass, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::CimeliaClass, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::CimeliaClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, double> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, double>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, double> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::CimeliaClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FagginglyClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::FagginglyClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::FagginglyClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FenkClass, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::FenkClass, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::FenkClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::FlagmakingClass, double>> {
    static void from_json(const json & j, std::variant<bool, quicktype::FlagmakingClass, double> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::FlagmakingClass, double> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(const json & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(const json & j, std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, const std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<bool, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CimeliaClass, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::CimeliaClass, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::CimeliaClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::HemocoeleClass>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::CimeliaClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::CimeliaClass> & x);
};

template <>
struct adl_serializer<std::variant<bool, std::string>> {
    static void from_json(const json & j, std::variant<bool, std::string> & x);
    static void to_json(json & j, const std::variant<bool, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CimeliaClass, double, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::CimeliaClass, double, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::CimeliaClass, double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, CerographClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_apotropaion(get_untyped(j, "apotropaion"));
        x.set_casuary(get_untyped(j, "casuary"));
        x.set_creaker(get_untyped(j, "creaker"));
        x.set_disqualification(get_untyped(j, "disqualification"));
        x.set_imperatorious(get_untyped(j, "imperatorious"));
        x.set_impermeabilize(get_untyped(j, "impermeabilize"));
        x.set_metastoma(get_untyped(j, "metastoma"));
        x.set_noctidiurnal(get_untyped(j, "noctidiurnal"));
        x.set_nonreserve(get_untyped(j, "nonreserve"));
        x.set_ophthalmotonometry(get_untyped(j, "ophthalmotonometry"));
        x.set_pailful(get_untyped(j, "pailful"));
        x.set_pigfish(get_untyped(j, "pigfish"));
        x.set_pongee(get_untyped(j, "pongee"));
        x.set_prosodical(get_untyped(j, "prosodical"));
        x.set_scrofuloderm(get_untyped(j, "scrofuloderm"));
        x.set_storekeeping(get_untyped(j, "storekeeping"));
        x.set_therologist(get_untyped(j, "therologist"));
        x.set_tolowa(get_untyped(j, "Tolowa"));
        x.set_tradeful(get_untyped(j, "tradeful"));
        x.set_unriveting(get_untyped(j, "unriveting"));
    }

    inline void to_json(json & j, const CerographClass & x) {
        j = json::object();
        j["apotropaion"] = x.get_apotropaion();
        j["casuary"] = x.get_casuary();
        j["creaker"] = x.get_creaker();
        j["disqualification"] = x.get_disqualification();
        j["imperatorious"] = x.get_imperatorious();
        j["impermeabilize"] = x.get_impermeabilize();
        j["metastoma"] = x.get_metastoma();
        j["noctidiurnal"] = x.get_noctidiurnal();
        j["nonreserve"] = x.get_nonreserve();
        j["ophthalmotonometry"] = x.get_ophthalmotonometry();
        j["pailful"] = x.get_pailful();
        j["pigfish"] = x.get_pigfish();
        j["pongee"] = x.get_pongee();
        j["prosodical"] = x.get_prosodical();
        j["scrofuloderm"] = x.get_scrofuloderm();
        j["storekeeping"] = x.get_storekeeping();
        j["therologist"] = x.get_therologist();
        j["Tolowa"] = x.get_tolowa();
        j["tradeful"] = x.get_tradeful();
        j["unriveting"] = x.get_unriveting();
    }

    inline void from_json(const json & j, ChemotherapeuticClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_angioneurotic(get_untyped(j, "angioneurotic"));
        x.set_availment(get_untyped(j, "availment"));
        x.set_bladelet(get_untyped(j, "bladelet"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        x.set_caulis(get_untyped(j, "caulis"));
        x.set_chalcus(get_untyped(j, "chalcus"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_enteradenological(get_untyped(j, "enteradenological"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_imporosity(get_untyped(j, "imporosity"));
        x.set_insistently(get_untyped(j, "insistently"));
        x.set_intraparietal(get_untyped(j, "intraparietal"));
        x.set_ivied(get_untyped(j, "ivied"));
        x.set_maureen(get_untyped(j, "Maureen"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_nostochine(get_untyped(j, "nostochine"));
        x.set_nutcracker(get_untyped(j, "nutcracker"));
        x.set_ofttimes(get_untyped(j, "ofttimes"));
        x.set_phenocryst(get_untyped(j, "phenocryst"));
        x.set_precoincident(get_untyped(j, "precoincident"));
        x.set_ramiferous(get_untyped(j, "ramiferous"));
        x.set_stagmometer(get_untyped(j, "stagmometer"));
        x.set_tetherball(get_untyped(j, "tetherball"));
        x.set_unshy(get_untyped(j, "unshy"));
    }

    inline void to_json(json & j, const ChemotherapeuticClass & x) {
        j = json::object();
        j["angioneurotic"] = x.get_angioneurotic();
        j["availment"] = x.get_availment();
        j["bladelet"] = x.get_bladelet();
        j["catharticalness"] = x.get_catharticalness();
        j["caulis"] = x.get_caulis();
        j["chalcus"] = x.get_chalcus();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["enteradenological"] = x.get_enteradenological();
        j["homocerc"] = x.get_homocerc();
        j["imporosity"] = x.get_imporosity();
        j["insistently"] = x.get_insistently();
        j["intraparietal"] = x.get_intraparietal();
        j["ivied"] = x.get_ivied();
        j["Maureen"] = x.get_maureen();
        j["nonbookish"] = x.get_nonbookish();
        j["nostochine"] = x.get_nostochine();
        j["nutcracker"] = x.get_nutcracker();
        j["ofttimes"] = x.get_ofttimes();
        j["phenocryst"] = x.get_phenocryst();
        j["precoincident"] = x.get_precoincident();
        j["ramiferous"] = x.get_ramiferous();
        j["stagmometer"] = x.get_stagmometer();
        j["tetherball"] = x.get_tetherball();
        j["unshy"] = x.get_unshy();
    }

    inline void from_json(const json & j, CimeliaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_catharticalness(j.at("catharticalness").get<double>());
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_chirotherium(j.at("Chirotherium").get<int64_t>());
        x.set_disdiapason(j.at("disdiapason").get<std::string>());
        x.set_homocerc(j.at("homocerc").get<bool>());
        x.set_nonbookish(get_untyped(j, "nonbookish"));
    }

    inline void to_json(json & j, const CimeliaClass & x) {
        j = json::object();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["homocerc"] = x.get_homocerc();
        j["nonbookish"] = x.get_nonbookish();
    }

    inline void from_json(const json & j, CoadjustClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_amidosulphonal(get_untyped(j, "amidosulphonal"));
        x.set_benny(get_untyped(j, "Benny"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_ensnare(get_untyped(j, "ensnare"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_hybridizer(get_untyped(j, "hybridizer"));
        x.set_leastwise(get_untyped(j, "leastwise"));
        x.set_lof(get_untyped(j, "lof"));
        x.set_monkhood(get_untyped(j, "monkhood"));
        x.set_netherlandish(get_untyped(j, "Netherlandish"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_peonism(get_untyped(j, "peonism"));
        x.set_phonelescope(get_untyped(j, "Phonelescope"));
        x.set_porphyrogeniture(get_untyped(j, "porphyrogeniture"));
        x.set_preindemnify(get_untyped(j, "preindemnify"));
        x.set_rosal(get_untyped(j, "rosal"));
        x.set_scalenous(get_untyped(j, "scalenous"));
        x.set_scopine(get_untyped(j, "scopine"));
        x.set_sedaceae(get_untyped(j, "Sedaceae"));
        x.set_suberinize(get_untyped(j, "suberinize"));
        x.set_symbiot(get_untyped(j, "symbiot"));
        x.set_tablefellow(get_untyped(j, "tablefellow"));
        x.set_unchargeable(get_untyped(j, "unchargeable"));
    }

    inline void to_json(json & j, const CoadjustClass & x) {
        j = json::object();
        j["amidosulphonal"] = x.get_amidosulphonal();
        j["Benny"] = x.get_benny();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["ensnare"] = x.get_ensnare();
        j["homocerc"] = x.get_homocerc();
        j["hybridizer"] = x.get_hybridizer();
        j["leastwise"] = x.get_leastwise();
        j["lof"] = x.get_lof();
        j["monkhood"] = x.get_monkhood();
        j["Netherlandish"] = x.get_netherlandish();
        j["nonbookish"] = x.get_nonbookish();
        j["peonism"] = x.get_peonism();
        j["Phonelescope"] = x.get_phonelescope();
        j["porphyrogeniture"] = x.get_porphyrogeniture();
        j["preindemnify"] = x.get_preindemnify();
        j["rosal"] = x.get_rosal();
        j["scalenous"] = x.get_scalenous();
        j["scopine"] = x.get_scopine();
        j["Sedaceae"] = x.get_sedaceae();
        j["suberinize"] = x.get_suberinize();
        j["symbiot"] = x.get_symbiot();
        j["tablefellow"] = x.get_tablefellow();
        j["unchargeable"] = x.get_unchargeable();
    }

    inline void from_json(const json & j, CredulityClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_ammonolytic(get_untyped(j, "ammonolytic"));
        x.set_bushmaster(get_untyped(j, "bushmaster"));
        x.set_considering(get_untyped(j, "considering"));
        x.set_consuetudinary(get_untyped(j, "consuetudinary"));
        x.set_embarras(get_untyped(j, "embarras"));
        x.set_fineness(get_untyped(j, "fineness"));
        x.set_flaithship(get_untyped(j, "flaithship"));
        x.set_flavia(get_untyped(j, "Flavia"));
        x.set_gruffly(get_untyped(j, "gruffly"));
        x.set_hedychium(get_untyped(j, "Hedychium"));
        x.set_leadwort(get_untyped(j, "leadwort"));
        x.set_overseriously(get_untyped(j, "overseriously"));
        x.set_parabola(get_untyped(j, "parabola"));
        x.set_pectinatodenticulate(get_untyped(j, "pectinatodenticulate"));
        x.set_popean(get_untyped(j, "Popean"));
        x.set_pornocrat(get_untyped(j, "pornocrat"));
        x.set_quadrisect(get_untyped(j, "quadrisect"));
        x.set_seriality(get_untyped(j, "seriality"));
        x.set_vamphorn(get_untyped(j, "vamphorn"));
        x.set_wharp(get_untyped(j, "wharp"));
    }

    inline void to_json(json & j, const CredulityClass & x) {
        j = json::object();
        j["ammonolytic"] = x.get_ammonolytic();
        j["bushmaster"] = x.get_bushmaster();
        j["considering"] = x.get_considering();
        j["consuetudinary"] = x.get_consuetudinary();
        j["embarras"] = x.get_embarras();
        j["fineness"] = x.get_fineness();
        j["flaithship"] = x.get_flaithship();
        j["Flavia"] = x.get_flavia();
        j["gruffly"] = x.get_gruffly();
        j["Hedychium"] = x.get_hedychium();
        j["leadwort"] = x.get_leadwort();
        j["overseriously"] = x.get_overseriously();
        j["parabola"] = x.get_parabola();
        j["pectinatodenticulate"] = x.get_pectinatodenticulate();
        j["Popean"] = x.get_popean();
        j["pornocrat"] = x.get_pornocrat();
        j["quadrisect"] = x.get_quadrisect();
        j["seriality"] = x.get_seriality();
        j["vamphorn"] = x.get_vamphorn();
        j["wharp"] = x.get_wharp();
    }

    inline void from_json(const json & j, DeruralizeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bockerel(get_untyped(j, "bockerel"));
        x.set_boulder(get_untyped(j, "boulder"));
        x.set_churrus(get_untyped(j, "churrus"));
        x.set_counterdigged(get_untyped(j, "counterdigged"));
        x.set_dialogite(get_untyped(j, "dialogite"));
        x.set_digenic(get_untyped(j, "digenic"));
        x.set_dunbird(get_untyped(j, "dunbird"));
        x.set_ergatogyne(get_untyped(j, "ergatogyne"));
        x.set_fiendful(get_untyped(j, "fiendful"));
        x.set_jackrod(get_untyped(j, "jackrod"));
        x.set_jehovistic(get_untyped(j, "Jehovistic"));
        x.set_paninean(get_untyped(j, "Paninean"));
        x.set_panther(get_untyped(j, "panther"));
        x.set_placentigerous(get_untyped(j, "placentigerous"));
        x.set_romney(get_untyped(j, "Romney"));
        x.set_sparm(get_untyped(j, "sparm"));
        x.set_tocsin(get_untyped(j, "tocsin"));
        x.set_unnicked(get_untyped(j, "unnicked"));
        x.set_unstavable(get_untyped(j, "unstavable"));
        x.set_windfirm(get_untyped(j, "windfirm"));
    }

    inline void to_json(json & j, const DeruralizeClass & x) {
        j = json::object();
        j["bockerel"] = x.get_bockerel();
        j["boulder"] = x.get_boulder();
        j["churrus"] = x.get_churrus();
        j["counterdigged"] = x.get_counterdigged();
        j["dialogite"] = x.get_dialogite();
        j["digenic"] = x.get_digenic();
        j["dunbird"] = x.get_dunbird();
        j["ergatogyne"] = x.get_ergatogyne();
        j["fiendful"] = x.get_fiendful();
        j["jackrod"] = x.get_jackrod();
        j["Jehovistic"] = x.get_jehovistic();
        j["Paninean"] = x.get_paninean();
        j["panther"] = x.get_panther();
        j["placentigerous"] = x.get_placentigerous();
        j["Romney"] = x.get_romney();
        j["sparm"] = x.get_sparm();
        j["tocsin"] = x.get_tocsin();
        j["unnicked"] = x.get_unnicked();
        j["unstavable"] = x.get_unstavable();
        j["windfirm"] = x.get_windfirm();
    }

    inline void from_json(const json & j, DiaereseClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_amoreuxia(get_untyped(j, "Amoreuxia"));
        x.set_ani(get_untyped(j, "ani"));
        x.set_bernicle(get_untyped(j, "bernicle"));
        x.set_blackwasher(get_untyped(j, "blackwasher"));
        x.set_blowhard(get_untyped(j, "blowhard"));
        x.set_broma(get_untyped(j, "broma"));
        x.set_closecross(get_untyped(j, "closecross"));
        x.set_congregationalism(get_untyped(j, "congregationalism"));
        x.set_grayly(get_untyped(j, "grayly"));
        x.set_historically(get_untyped(j, "historically"));
        x.set_hoast(get_untyped(j, "hoast"));
        x.set_irretentive(get_untyped(j, "irretentive"));
        x.set_parcener(get_untyped(j, "parcener"));
        x.set_pedder(get_untyped(j, "pedder"));
        x.set_pseudoanatomic(get_untyped(j, "pseudoanatomic"));
        x.set_rhizocarpian(get_untyped(j, "rhizocarpian"));
        x.set_samel(get_untyped(j, "samel"));
        x.set_silker(get_untyped(j, "silker"));
        x.set_subdentated(get_untyped(j, "subdentated"));
        x.set_subobscure(get_untyped(j, "subobscure"));
    }

    inline void to_json(json & j, const DiaereseClass & x) {
        j = json::object();
        j["Amoreuxia"] = x.get_amoreuxia();
        j["ani"] = x.get_ani();
        j["bernicle"] = x.get_bernicle();
        j["blackwasher"] = x.get_blackwasher();
        j["blowhard"] = x.get_blowhard();
        j["broma"] = x.get_broma();
        j["closecross"] = x.get_closecross();
        j["congregationalism"] = x.get_congregationalism();
        j["grayly"] = x.get_grayly();
        j["historically"] = x.get_historically();
        j["hoast"] = x.get_hoast();
        j["irretentive"] = x.get_irretentive();
        j["parcener"] = x.get_parcener();
        j["pedder"] = x.get_pedder();
        j["pseudoanatomic"] = x.get_pseudoanatomic();
        j["rhizocarpian"] = x.get_rhizocarpian();
        j["samel"] = x.get_samel();
        j["silker"] = x.get_silker();
        j["subdentated"] = x.get_subdentated();
        j["subobscure"] = x.get_subobscure();
    }

    inline void from_json(const json & j, Encrust& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_comradely(get_untyped(j, "comradely"));
        x.set_diacanthous(get_untyped(j, "diacanthous"));
        x.set_feminineness(get_untyped(j, "feminineness"));
        x.set_gossamered(get_untyped(j, "gossamered"));
        x.set_hibernia(get_untyped(j, "Hibernia"));
        x.set_hibiscus(get_untyped(j, "Hibiscus"));
        x.set_lepidosauria(get_untyped(j, "Lepidosauria"));
        x.set_lollingly(get_untyped(j, "lollingly"));
        x.set_manager(get_untyped(j, "manager"));
        x.set_mechanic(get_untyped(j, "mechanic"));
        x.set_overminuteness(get_untyped(j, "overminuteness"));
        x.set_papelonne(get_untyped(j, "papelonne"));
        x.set_plebification(get_untyped(j, "plebification"));
        x.set_pugmiller(get_untyped(j, "pugmiller"));
        x.set_recoveror(get_untyped(j, "recoveror"));
        x.set_spermatoblastic(get_untyped(j, "spermatoblastic"));
        x.set_syllidae(get_untyped(j, "Syllidae"));
        x.set_ungyved(get_untyped(j, "ungyved"));
        x.set_whirlabout(get_untyped(j, "whirlabout"));
        x.set_woodenware(get_untyped(j, "woodenware"));
    }

    inline void to_json(json & j, const Encrust & x) {
        j = json::object();
        j["comradely"] = x.get_comradely();
        j["diacanthous"] = x.get_diacanthous();
        j["feminineness"] = x.get_feminineness();
        j["gossamered"] = x.get_gossamered();
        j["Hibernia"] = x.get_hibernia();
        j["Hibiscus"] = x.get_hibiscus();
        j["Lepidosauria"] = x.get_lepidosauria();
        j["lollingly"] = x.get_lollingly();
        j["manager"] = x.get_manager();
        j["mechanic"] = x.get_mechanic();
        j["overminuteness"] = x.get_overminuteness();
        j["papelonne"] = x.get_papelonne();
        j["plebification"] = x.get_plebification();
        j["pugmiller"] = x.get_pugmiller();
        j["recoveror"] = x.get_recoveror();
        j["spermatoblastic"] = x.get_spermatoblastic();
        j["Syllidae"] = x.get_syllidae();
        j["ungyved"] = x.get_ungyved();
        j["whirlabout"] = x.get_whirlabout();
        j["woodenware"] = x.get_woodenware();
    }

    inline void from_json(const json & j, FagginglyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_abranchian(get_untyped(j, "abranchian"));
        x.set_aculeiform(get_untyped(j, "aculeiform"));
        x.set_adiaphoristic(get_untyped(j, "adiaphoristic"));
        x.set_adoptionism(get_untyped(j, "adoptionism"));
        x.set_anglic(get_untyped(j, "Anglic"));
        x.set_antrotomy(get_untyped(j, "antrotomy"));
        x.set_coerciveness(get_untyped(j, "coerciveness"));
        x.set_decorist(get_untyped(j, "decorist"));
        x.set_duckhood(get_untyped(j, "duckhood"));
        x.set_heteromeri(get_untyped(j, "Heteromeri"));
        x.set_hypochnose(get_untyped(j, "hypochnose"));
        x.set_lochage(get_untyped(j, "lochage"));
        x.set_melee(get_untyped(j, "melee"));
        x.set_nonconformitant(get_untyped(j, "nonconformitant"));
        x.set_poinsettia(get_untyped(j, "Poinsettia"));
        x.set_putatively(get_untyped(j, "putatively"));
        x.set_semivolatile(get_untyped(j, "semivolatile"));
        x.set_soleas(get_untyped(j, "soleas"));
        x.set_unfastenable(get_untyped(j, "unfastenable"));
        x.set_unmillinered(get_untyped(j, "unmillinered"));
    }

    inline void to_json(json & j, const FagginglyClass & x) {
        j = json::object();
        j["abranchian"] = x.get_abranchian();
        j["aculeiform"] = x.get_aculeiform();
        j["adiaphoristic"] = x.get_adiaphoristic();
        j["adoptionism"] = x.get_adoptionism();
        j["Anglic"] = x.get_anglic();
        j["antrotomy"] = x.get_antrotomy();
        j["coerciveness"] = x.get_coerciveness();
        j["decorist"] = x.get_decorist();
        j["duckhood"] = x.get_duckhood();
        j["Heteromeri"] = x.get_heteromeri();
        j["hypochnose"] = x.get_hypochnose();
        j["lochage"] = x.get_lochage();
        j["melee"] = x.get_melee();
        j["nonconformitant"] = x.get_nonconformitant();
        j["Poinsettia"] = x.get_poinsettia();
        j["putatively"] = x.get_putatively();
        j["semivolatile"] = x.get_semivolatile();
        j["soleas"] = x.get_soleas();
        j["unfastenable"] = x.get_unfastenable();
        j["unmillinered"] = x.get_unmillinered();
    }

    inline void from_json(const json & j, FenkClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_apoise(get_untyped(j, "apoise"));
        x.set_astronomize(get_untyped(j, "astronomize"));
        x.set_cockhorse(get_untyped(j, "cockhorse"));
        x.set_copular(get_untyped(j, "copular"));
        x.set_dagomba(get_untyped(j, "Dagomba"));
        x.set_draffy(get_untyped(j, "draffy"));
        x.set_foreigner(get_untyped(j, "foreigner"));
        x.set_guyandot(get_untyped(j, "Guyandot"));
        x.set_neurogliosis(get_untyped(j, "neurogliosis"));
        x.set_osmious(get_untyped(j, "osmious"));
        x.set_palpitate(get_untyped(j, "palpitate"));
        x.set_rebukeable(get_untyped(j, "rebukeable"));
        x.set_reinwardtia(get_untyped(j, "Reinwardtia"));
        x.set_reservatory(get_untyped(j, "reservatory"));
        x.set_scalt(get_untyped(j, "scalt"));
        x.set_scripturalize(get_untyped(j, "scripturalize"));
        x.set_tintometer(get_untyped(j, "tintometer"));
        x.set_tritoness(get_untyped(j, "Tritoness"));
        x.set_undergrade(get_untyped(j, "undergrade"));
        x.set_undermountain(get_untyped(j, "undermountain"));
    }

    inline void to_json(json & j, const FenkClass & x) {
        j = json::object();
        j["apoise"] = x.get_apoise();
        j["astronomize"] = x.get_astronomize();
        j["cockhorse"] = x.get_cockhorse();
        j["copular"] = x.get_copular();
        j["Dagomba"] = x.get_dagomba();
        j["draffy"] = x.get_draffy();
        j["foreigner"] = x.get_foreigner();
        j["Guyandot"] = x.get_guyandot();
        j["neurogliosis"] = x.get_neurogliosis();
        j["osmious"] = x.get_osmious();
        j["palpitate"] = x.get_palpitate();
        j["rebukeable"] = x.get_rebukeable();
        j["Reinwardtia"] = x.get_reinwardtia();
        j["reservatory"] = x.get_reservatory();
        j["scalt"] = x.get_scalt();
        j["scripturalize"] = x.get_scripturalize();
        j["tintometer"] = x.get_tintometer();
        j["Tritoness"] = x.get_tritoness();
        j["undergrade"] = x.get_undergrade();
        j["undermountain"] = x.get_undermountain();
    }

    inline void from_json(const json & j, FlagmakingClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_albarco(get_untyped(j, "albarco"));
        x.set_bunodonta(get_untyped(j, "Bunodonta"));
        x.set_hornify(get_untyped(j, "hornify"));
        x.set_hydrocorisae(get_untyped(j, "Hydrocorisae"));
        x.set_hypoglossus(get_untyped(j, "hypoglossus"));
        x.set_inexpiably(get_untyped(j, "inexpiably"));
        x.set_ingratitude(get_untyped(j, "ingratitude"));
        x.set_ladyfly(get_untyped(j, "ladyfly"));
        x.set_medicament(get_untyped(j, "medicament"));
        x.set_monogrammatic(get_untyped(j, "monogrammatic"));
        x.set_nobbut(get_untyped(j, "nobbut"));
        x.set_notacanthidae(get_untyped(j, "Notacanthidae"));
        x.set_polyplacophore(get_untyped(j, "polyplacophore"));
        x.set_proexercise(get_untyped(j, "proexercise"));
        x.set_protoplast(get_untyped(j, "protoplast"));
        x.set_puzzling(get_untyped(j, "puzzling"));
        x.set_splanchnoskeleton(get_untyped(j, "splanchnoskeleton"));
        x.set_unloveliness(get_untyped(j, "unloveliness"));
        x.set_unquarantined(get_untyped(j, "unquarantined"));
        x.set_unrenounceable(get_untyped(j, "unrenounceable"));
    }

    inline void to_json(json & j, const FlagmakingClass & x) {
        j = json::object();
        j["albarco"] = x.get_albarco();
        j["Bunodonta"] = x.get_bunodonta();
        j["hornify"] = x.get_hornify();
        j["Hydrocorisae"] = x.get_hydrocorisae();
        j["hypoglossus"] = x.get_hypoglossus();
        j["inexpiably"] = x.get_inexpiably();
        j["ingratitude"] = x.get_ingratitude();
        j["ladyfly"] = x.get_ladyfly();
        j["medicament"] = x.get_medicament();
        j["monogrammatic"] = x.get_monogrammatic();
        j["nobbut"] = x.get_nobbut();
        j["Notacanthidae"] = x.get_notacanthidae();
        j["polyplacophore"] = x.get_polyplacophore();
        j["proexercise"] = x.get_proexercise();
        j["protoplast"] = x.get_protoplast();
        j["puzzling"] = x.get_puzzling();
        j["splanchnoskeleton"] = x.get_splanchnoskeleton();
        j["unloveliness"] = x.get_unloveliness();
        j["unquarantined"] = x.get_unquarantined();
        j["unrenounceable"] = x.get_unrenounceable();
    }

    inline void from_json(const json & j, HemocoeleClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_acrogamy(get_untyped(j, "acrogamy"));
        x.set_amelification(get_untyped(j, "amelification"));
        x.set_autobiographic(get_untyped(j, "autobiographic"));
        x.set_berat(get_untyped(j, "berat"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_disproportionably(get_untyped(j, "disproportionably"));
        x.set_erythrite(get_untyped(j, "erythrite"));
        x.set_graphic(get_untyped(j, "graphic"));
        x.set_hepatological(get_untyped(j, "hepatological"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_incommensurably(get_untyped(j, "incommensurably"));
        x.set_misaffirm(get_untyped(j, "misaffirm"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_pocketbook(get_untyped(j, "pocketbook"));
        x.set_sclerometric(get_untyped(j, "sclerometric"));
        x.set_stambouline(get_untyped(j, "stambouline"));
        x.set_stickpin(get_untyped(j, "stickpin"));
        x.set_tubulure(get_untyped(j, "tubulure"));
        x.set_undelated(get_untyped(j, "undelated"));
        x.set_unsalt(get_untyped(j, "unsalt"));
        x.set_untutelar(get_untyped(j, "untutelar"));
        x.set_vagrant(get_untyped(j, "vagrant"));
        x.set_walt(get_untyped(j, "Walt"));
    }

    inline void to_json(json & j, const HemocoeleClass & x) {
        j = json::object();
        j["acrogamy"] = x.get_acrogamy();
        j["amelification"] = x.get_amelification();
        j["autobiographic"] = x.get_autobiographic();
        j["berat"] = x.get_berat();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["disproportionably"] = x.get_disproportionably();
        j["erythrite"] = x.get_erythrite();
        j["graphic"] = x.get_graphic();
        j["hepatological"] = x.get_hepatological();
        j["homocerc"] = x.get_homocerc();
        j["incommensurably"] = x.get_incommensurably();
        j["misaffirm"] = x.get_misaffirm();
        j["nonbookish"] = x.get_nonbookish();
        j["pocketbook"] = x.get_pocketbook();
        j["sclerometric"] = x.get_sclerometric();
        j["stambouline"] = x.get_stambouline();
        j["stickpin"] = x.get_stickpin();
        j["tubulure"] = x.get_tubulure();
        j["undelated"] = x.get_undelated();
        j["unsalt"] = x.get_unsalt();
        j["untutelar"] = x.get_untutelar();
        j["vagrant"] = x.get_vagrant();
        j["Walt"] = x.get_walt();
    }

    inline void from_json(const json & j, Interacinar& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_assapan(j.at("assapan").get<double>());
        x.set_benefactorship(j.at("benefactorship").get<bool>());
        x.set_triseriatim(j.at("triseriatim").get<std::string>());
        if (j.find("tubbing") != j.end() && !j.at("tubbing").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tubbing(j.at("tubbing").get<int64_t>());
        x.set_untrimmed(get_untyped(j, "untrimmed"));
    }

    inline void to_json(json & j, const Interacinar & x) {
        j = json::object();
        j["assapan"] = x.get_assapan();
        j["benefactorship"] = x.get_benefactorship();
        j["triseriatim"] = x.get_triseriatim();
        j["tubbing"] = x.get_tubbing();
        j["untrimmed"] = x.get_untrimmed();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_centrodesmose(j.at("centrodesmose").get<std::string>());
        x.set_cerograph(j.at("cerograph").get<std::vector<CerographElement>>());
        x.set_chemotherapeutics(j.at("chemotherapeutics").get<std::vector<ChemotherapeuticElement>>());
        x.set_cimelia(j.at("cimelia").get<std::vector<CimeliaElement>>());
        if (j.find("citrated") != j.end() && !j.at("citrated").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_citrated(j.at("citrated").get<int64_t>());
        x.set_clinodome(j.at("clinodome").get<std::vector<Clinodome>>());
        x.set_coadjust(j.at("coadjust").get<std::vector<CoadjustElement>>());
        x.set_consilience(j.at("consilience").get<std::vector<Consilience>>());
        x.set_constructor(j.at("constructor").get<std::vector<Constructor>>());
        x.set_continuative(j.at("continuative").get<std::vector<Continuative>>());
        x.set_credulity(j.at("credulity").get<std::vector<CredulityElement>>());
        x.set_creviced(j.at("creviced").get<std::vector<Creviced>>());
        x.set_cubiculum(j.at("cubiculum").get<std::vector<std::vector<std::optional<int64_t>>>>());
        x.set_deruralize(j.at("deruralize").get<std::vector<DeruralizeElement>>());
        x.set_diaereses(j.at("diaereses").get<std::vector<DiaereseElement>>());
        x.set_dissolution(j.at("dissolution").get<std::vector<std::optional<std::vector<nlohmann::json>>>>());
        x.set_downstroke(j.at("downstroke").get<std::vector<Downstroke>>());
        x.set_electrotautomerism(j.at("electrotautomerism").get<std::vector<std::optional<double>>>());
        x.set_eleutheromania(j.at("eleutheromania").get<std::vector<Eleutheromania>>());
        x.set_encrust(j.at("encrust").get<Encrust>());
        x.set_entomoid(j.at("entomoid").get<std::vector<Entomoid>>());
        x.set_epipaleolithic(j.at("epipaleolithic").get<std::vector<Epipaleolithic>>());
        x.set_expropriable(j.at("expropriable").get<std::vector<Expropriable>>());
        x.set_faggingly(j.at("faggingly").get<std::vector<FagginglyElement>>());
        x.set_fenks(j.at("fenks").get<std::vector<FenkElement>>());
        x.set_flagmaking(j.at("flagmaking").get<std::vector<FlagmakingElement>>());
        x.set_fluorometer(j.at("fluorometer").get<std::vector<Fluorometer>>());
        x.set_fulsome(j.at("fulsome").get<std::vector<std::optional<int64_t>>>());
        x.set_fuzzy(j.at("fuzzy").get<std::vector<Fuzzy>>());
        x.set_gardenwards(j.at("gardenwards").get<std::vector<Gardenward>>());
        x.set_generalissimo(j.at("generalissimo").get<std::vector<Generalissimo>>());
        x.set_habeas(j.at("habeas").get<std::vector<std::optional<std::map<std::string, int64_t>>>>());
        x.set_hemicrystalline(j.at("hemicrystalline").get<std::vector<Hemicrystalline>>());
        x.set_hemocoele(j.at("hemocoele").get<std::vector<HemocoeleElement>>());
        x.set_hoister(j.at("hoister").get<std::vector<Hoister>>());
        x.set_hyperpiesis(j.at("hyperpiesis").get<std::vector<Hyperpiesi>>());
        x.set_hyppish(j.at("hyppish").get<std::vector<Hyppish>>());
        x.set_idealizer(j.at("idealizer").get<std::vector<Idealizer>>());
        x.set_incrustator(j.at("incrustator").get<std::vector<Incrustator>>());
        x.set_intentiveness(j.at("intentiveness").get<std::vector<Intentiveness>>());
        x.set_interacinar(j.at("interacinar").get<Interacinar>());
        x.set_intercorrelation(j.at("intercorrelation").get<std::vector<std::optional<std::vector<int64_t>>>>());
        x.set_jacutinga(j.at("jacutinga").get<std::vector<Jacutinga>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["centrodesmose"] = x.get_centrodesmose();
        j["cerograph"] = x.get_cerograph();
        j["chemotherapeutics"] = x.get_chemotherapeutics();
        j["cimelia"] = x.get_cimelia();
        j["citrated"] = x.get_citrated();
        j["clinodome"] = x.get_clinodome();
        j["coadjust"] = x.get_coadjust();
        j["consilience"] = x.get_consilience();
        j["constructor"] = x.get_constructor();
        j["continuative"] = x.get_continuative();
        j["credulity"] = x.get_credulity();
        j["creviced"] = x.get_creviced();
        j["cubiculum"] = x.get_cubiculum();
        j["deruralize"] = x.get_deruralize();
        j["diaereses"] = x.get_diaereses();
        j["dissolution"] = x.get_dissolution();
        j["downstroke"] = x.get_downstroke();
        j["electrotautomerism"] = x.get_electrotautomerism();
        j["eleutheromania"] = x.get_eleutheromania();
        j["encrust"] = x.get_encrust();
        j["entomoid"] = x.get_entomoid();
        j["epipaleolithic"] = x.get_epipaleolithic();
        j["expropriable"] = x.get_expropriable();
        j["faggingly"] = x.get_faggingly();
        j["fenks"] = x.get_fenks();
        j["flagmaking"] = x.get_flagmaking();
        j["fluorometer"] = x.get_fluorometer();
        j["fulsome"] = x.get_fulsome();
        j["fuzzy"] = x.get_fuzzy();
        j["gardenwards"] = x.get_gardenwards();
        j["generalissimo"] = x.get_generalissimo();
        j["habeas"] = x.get_habeas();
        j["hemicrystalline"] = x.get_hemicrystalline();
        j["hemocoele"] = x.get_hemocoele();
        j["hoister"] = x.get_hoister();
        j["hyperpiesis"] = x.get_hyperpiesis();
        j["hyppish"] = x.get_hyppish();
        j["idealizer"] = x.get_idealizer();
        j["incrustator"] = x.get_incrustator();
        j["intentiveness"] = x.get_intentiveness();
        j["interacinar"] = x.get_interacinar();
        j["intercorrelation"] = x.get_intercorrelation();
        j["jacutinga"] = x.get_jacutinga();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::CerographClass, std::string>>::from_json(const json & j, std::variant<quicktype::CerographClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CerographClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CerographClass, std::string>>::to_json(json & j, const std::variant<quicktype::CerographClass, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CerographClass>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ChemotherapeuticClass, int64_t>>::from_json(const json & j, std::variant<quicktype::ChemotherapeuticClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::ChemotherapeuticClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ChemotherapeuticClass, int64_t>>::to_json(json & j, const std::variant<quicktype::ChemotherapeuticClass, int64_t> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ChemotherapeuticClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::CimeliaClass>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::CimeliaClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::CimeliaClass>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::CimeliaClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::CimeliaClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, std::string>>::from_json(const json & j, std::variant<double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::string>>::to_json(json & j, const std::variant<double, std::string> & x) {
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

    inline void adl_serializer<std::variant<quicktype::CoadjustClass, double>>::from_json(const json & j, std::variant<quicktype::CoadjustClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CoadjustClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CoadjustClass, double>>::to_json(json & j, const std::variant<quicktype::CoadjustClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CoadjustClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<double, std::map<std::string, int64_t>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<double, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<bool, std::map<std::string, std::optional<int64_t>>>>::from_json(const json & j, std::variant<bool, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, const std::variant<bool, std::map<std::string, std::optional<int64_t>>> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, std::optional<int64_t>>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>>::from_json(const json & j, std::variant<std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>>::to_json(json & j, const std::variant<std::map<std::string, int64_t>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CredulityClass, int64_t, std::string>>::from_json(const json & j, std::variant<quicktype::CredulityClass, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CredulityClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CredulityClass, int64_t, std::string>>::to_json(json & j, const std::variant<quicktype::CredulityClass, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CredulityClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>, std::string>>::from_json(const json & j, std::variant<bool, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>, std::string>>::to_json(json & j, const std::variant<bool, std::map<std::string, int64_t>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::DeruralizeClass>>::from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::DeruralizeClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::DeruralizeClass>>::to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<quicktype::DeruralizeClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::DiaereseClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<quicktype::DiaereseClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::string>>::from_json(const json & j, std::variant<std::vector<json>, bool, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::string>>::to_json(json & j, const std::variant<std::vector<json>, bool, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>, std::string>>::from_json(const json & j, std::variant<double, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>, std::string>>::to_json(json & j, const std::variant<double, std::map<std::string, int64_t>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<double>(x);
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

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, int64_t>>::from_json(const json & j, std::variant<quicktype::CimeliaClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, int64_t>>::to_json(json & j, const std::variant<quicktype::CimeliaClass, int64_t> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CimeliaClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double>>::from_json(const json & j, std::variant<std::vector<int64_t>, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double>>::to_json(json & j, const std::variant<std::vector<int64_t>, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, double>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, double>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::CimeliaClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::CimeliaClass>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::FagginglyClass, double>>::from_json(const json & j, std::variant<quicktype::FagginglyClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FagginglyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FagginglyClass, double>>::to_json(json & j, const std::variant<quicktype::FagginglyClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::FagginglyClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::FenkClass, std::string>>::from_json(const json & j, std::variant<quicktype::FenkClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::FenkClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FenkClass, std::string>>::to_json(json & j, const std::variant<quicktype::FenkClass, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::FenkClass>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::FlagmakingClass, double>>::from_json(const json & j, std::variant<bool, quicktype::FlagmakingClass, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FlagmakingClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::FlagmakingClass, double>>::to_json(json & j, const std::variant<bool, quicktype::FlagmakingClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::FlagmakingClass>(x);
                break;
            case 2:
                j = std::get<double>(x);
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

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>>::from_json(const json & j, std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, const std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<int64_t>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, std::optional<int64_t>>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<bool, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<bool, std::map<std::string, int64_t>> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, std::string>>::from_json(const json & j, std::variant<quicktype::CimeliaClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, std::string>>::to_json(json & j, const std::variant<quicktype::CimeliaClass, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CimeliaClass>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::HemocoeleClass>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::HemocoeleClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::HemocoeleClass>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::HemocoeleClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::CimeliaClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::CimeliaClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::CimeliaClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, std::string>>::from_json(const json & j, std::variant<bool, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::string>>::to_json(json & j, const std::variant<bool, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::CimeliaClass>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, double, std::string>>::from_json(const json & j, std::variant<quicktype::CimeliaClass, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, double, std::string>>::to_json(json & j, const std::variant<quicktype::CimeliaClass, double, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::CimeliaClass>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>>::from_json(const json & j, std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, const std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, std::optional<int64_t>>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
