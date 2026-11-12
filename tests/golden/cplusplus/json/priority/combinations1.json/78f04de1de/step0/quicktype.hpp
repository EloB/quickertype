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
        nlohmann::json const & get_apotropaion() const { return apotropaion; }
        nlohmann::json & get_mutable_apotropaion() { return apotropaion; }
        void set_apotropaion(nlohmann::json const & value) { this->apotropaion = value; }

        nlohmann::json const & get_casuary() const { return casuary; }
        nlohmann::json & get_mutable_casuary() { return casuary; }
        void set_casuary(nlohmann::json const & value) { this->casuary = value; }

        nlohmann::json const & get_creaker() const { return creaker; }
        nlohmann::json & get_mutable_creaker() { return creaker; }
        void set_creaker(nlohmann::json const & value) { this->creaker = value; }

        nlohmann::json const & get_disqualification() const { return disqualification; }
        nlohmann::json & get_mutable_disqualification() { return disqualification; }
        void set_disqualification(nlohmann::json const & value) { this->disqualification = value; }

        nlohmann::json const & get_imperatorious() const { return imperatorious; }
        nlohmann::json & get_mutable_imperatorious() { return imperatorious; }
        void set_imperatorious(nlohmann::json const & value) { this->imperatorious = value; }

        nlohmann::json const & get_impermeabilize() const { return impermeabilize; }
        nlohmann::json & get_mutable_impermeabilize() { return impermeabilize; }
        void set_impermeabilize(nlohmann::json const & value) { this->impermeabilize = value; }

        nlohmann::json const & get_metastoma() const { return metastoma; }
        nlohmann::json & get_mutable_metastoma() { return metastoma; }
        void set_metastoma(nlohmann::json const & value) { this->metastoma = value; }

        nlohmann::json const & get_noctidiurnal() const { return noctidiurnal; }
        nlohmann::json & get_mutable_noctidiurnal() { return noctidiurnal; }
        void set_noctidiurnal(nlohmann::json const & value) { this->noctidiurnal = value; }

        nlohmann::json const & get_nonreserve() const { return nonreserve; }
        nlohmann::json & get_mutable_nonreserve() { return nonreserve; }
        void set_nonreserve(nlohmann::json const & value) { this->nonreserve = value; }

        nlohmann::json const & get_ophthalmotonometry() const { return ophthalmotonometry; }
        nlohmann::json & get_mutable_ophthalmotonometry() { return ophthalmotonometry; }
        void set_ophthalmotonometry(nlohmann::json const & value) { this->ophthalmotonometry = value; }

        nlohmann::json const & get_pailful() const { return pailful; }
        nlohmann::json & get_mutable_pailful() { return pailful; }
        void set_pailful(nlohmann::json const & value) { this->pailful = value; }

        nlohmann::json const & get_pigfish() const { return pigfish; }
        nlohmann::json & get_mutable_pigfish() { return pigfish; }
        void set_pigfish(nlohmann::json const & value) { this->pigfish = value; }

        nlohmann::json const & get_pongee() const { return pongee; }
        nlohmann::json & get_mutable_pongee() { return pongee; }
        void set_pongee(nlohmann::json const & value) { this->pongee = value; }

        nlohmann::json const & get_prosodical() const { return prosodical; }
        nlohmann::json & get_mutable_prosodical() { return prosodical; }
        void set_prosodical(nlohmann::json const & value) { this->prosodical = value; }

        nlohmann::json const & get_scrofuloderm() const { return scrofuloderm; }
        nlohmann::json & get_mutable_scrofuloderm() { return scrofuloderm; }
        void set_scrofuloderm(nlohmann::json const & value) { this->scrofuloderm = value; }

        nlohmann::json const & get_storekeeping() const { return storekeeping; }
        nlohmann::json & get_mutable_storekeeping() { return storekeeping; }
        void set_storekeeping(nlohmann::json const & value) { this->storekeeping = value; }

        nlohmann::json const & get_therologist() const { return therologist; }
        nlohmann::json & get_mutable_therologist() { return therologist; }
        void set_therologist(nlohmann::json const & value) { this->therologist = value; }

        nlohmann::json const & get_tolowa() const { return tolowa; }
        nlohmann::json & get_mutable_tolowa() { return tolowa; }
        void set_tolowa(nlohmann::json const & value) { this->tolowa = value; }

        nlohmann::json const & get_tradeful() const { return tradeful; }
        nlohmann::json & get_mutable_tradeful() { return tradeful; }
        void set_tradeful(nlohmann::json const & value) { this->tradeful = value; }

        nlohmann::json const & get_unriveting() const { return unriveting; }
        nlohmann::json & get_mutable_unriveting() { return unriveting; }
        void set_unriveting(nlohmann::json const & value) { this->unriveting = value; }
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
        nlohmann::json const & get_angioneurotic() const { return angioneurotic; }
        nlohmann::json & get_mutable_angioneurotic() { return angioneurotic; }
        void set_angioneurotic(nlohmann::json const & value) { this->angioneurotic = value; }

        nlohmann::json const & get_availment() const { return availment; }
        nlohmann::json & get_mutable_availment() { return availment; }
        void set_availment(nlohmann::json const & value) { this->availment = value; }

        nlohmann::json const & get_bladelet() const { return bladelet; }
        nlohmann::json & get_mutable_bladelet() { return bladelet; }
        void set_bladelet(nlohmann::json const & value) { this->bladelet = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        nlohmann::json const & get_caulis() const { return caulis; }
        nlohmann::json & get_mutable_caulis() { return caulis; }
        void set_caulis(nlohmann::json const & value) { this->caulis = value; }

        nlohmann::json const & get_chalcus() const { return chalcus; }
        nlohmann::json & get_mutable_chalcus() { return chalcus; }
        void set_chalcus(nlohmann::json const & value) { this->chalcus = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_enteradenological() const { return enteradenological; }
        nlohmann::json & get_mutable_enteradenological() { return enteradenological; }
        void set_enteradenological(nlohmann::json const & value) { this->enteradenological = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_imporosity() const { return imporosity; }
        nlohmann::json & get_mutable_imporosity() { return imporosity; }
        void set_imporosity(nlohmann::json const & value) { this->imporosity = value; }

        nlohmann::json const & get_insistently() const { return insistently; }
        nlohmann::json & get_mutable_insistently() { return insistently; }
        void set_insistently(nlohmann::json const & value) { this->insistently = value; }

        nlohmann::json const & get_intraparietal() const { return intraparietal; }
        nlohmann::json & get_mutable_intraparietal() { return intraparietal; }
        void set_intraparietal(nlohmann::json const & value) { this->intraparietal = value; }

        nlohmann::json const & get_ivied() const { return ivied; }
        nlohmann::json & get_mutable_ivied() { return ivied; }
        void set_ivied(nlohmann::json const & value) { this->ivied = value; }

        nlohmann::json const & get_maureen() const { return maureen; }
        nlohmann::json & get_mutable_maureen() { return maureen; }
        void set_maureen(nlohmann::json const & value) { this->maureen = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_nostochine() const { return nostochine; }
        nlohmann::json & get_mutable_nostochine() { return nostochine; }
        void set_nostochine(nlohmann::json const & value) { this->nostochine = value; }

        nlohmann::json const & get_nutcracker() const { return nutcracker; }
        nlohmann::json & get_mutable_nutcracker() { return nutcracker; }
        void set_nutcracker(nlohmann::json const & value) { this->nutcracker = value; }

        nlohmann::json const & get_ofttimes() const { return ofttimes; }
        nlohmann::json & get_mutable_ofttimes() { return ofttimes; }
        void set_ofttimes(nlohmann::json const & value) { this->ofttimes = value; }

        nlohmann::json const & get_phenocryst() const { return phenocryst; }
        nlohmann::json & get_mutable_phenocryst() { return phenocryst; }
        void set_phenocryst(nlohmann::json const & value) { this->phenocryst = value; }

        nlohmann::json const & get_precoincident() const { return precoincident; }
        nlohmann::json & get_mutable_precoincident() { return precoincident; }
        void set_precoincident(nlohmann::json const & value) { this->precoincident = value; }

        nlohmann::json const & get_ramiferous() const { return ramiferous; }
        nlohmann::json & get_mutable_ramiferous() { return ramiferous; }
        void set_ramiferous(nlohmann::json const & value) { this->ramiferous = value; }

        nlohmann::json const & get_stagmometer() const { return stagmometer; }
        nlohmann::json & get_mutable_stagmometer() { return stagmometer; }
        void set_stagmometer(nlohmann::json const & value) { this->stagmometer = value; }

        nlohmann::json const & get_tetherball() const { return tetherball; }
        nlohmann::json & get_mutable_tetherball() { return tetherball; }
        void set_tetherball(nlohmann::json const & value) { this->tetherball = value; }

        nlohmann::json const & get_unshy() const { return unshy; }
        nlohmann::json & get_mutable_unshy() { return unshy; }
        void set_unshy(nlohmann::json const & value) { this->unshy = value; }
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
        nlohmann::json const & get_amidosulphonal() const { return amidosulphonal; }
        nlohmann::json & get_mutable_amidosulphonal() { return amidosulphonal; }
        void set_amidosulphonal(nlohmann::json const & value) { this->amidosulphonal = value; }

        nlohmann::json const & get_benny() const { return benny; }
        nlohmann::json & get_mutable_benny() { return benny; }
        void set_benny(nlohmann::json const & value) { this->benny = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_ensnare() const { return ensnare; }
        nlohmann::json & get_mutable_ensnare() { return ensnare; }
        void set_ensnare(nlohmann::json const & value) { this->ensnare = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_hybridizer() const { return hybridizer; }
        nlohmann::json & get_mutable_hybridizer() { return hybridizer; }
        void set_hybridizer(nlohmann::json const & value) { this->hybridizer = value; }

        nlohmann::json const & get_leastwise() const { return leastwise; }
        nlohmann::json & get_mutable_leastwise() { return leastwise; }
        void set_leastwise(nlohmann::json const & value) { this->leastwise = value; }

        nlohmann::json const & get_lof() const { return lof; }
        nlohmann::json & get_mutable_lof() { return lof; }
        void set_lof(nlohmann::json const & value) { this->lof = value; }

        nlohmann::json const & get_monkhood() const { return monkhood; }
        nlohmann::json & get_mutable_monkhood() { return monkhood; }
        void set_monkhood(nlohmann::json const & value) { this->monkhood = value; }

        nlohmann::json const & get_netherlandish() const { return netherlandish; }
        nlohmann::json & get_mutable_netherlandish() { return netherlandish; }
        void set_netherlandish(nlohmann::json const & value) { this->netherlandish = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_peonism() const { return peonism; }
        nlohmann::json & get_mutable_peonism() { return peonism; }
        void set_peonism(nlohmann::json const & value) { this->peonism = value; }

        nlohmann::json const & get_phonelescope() const { return phonelescope; }
        nlohmann::json & get_mutable_phonelescope() { return phonelescope; }
        void set_phonelescope(nlohmann::json const & value) { this->phonelescope = value; }

        nlohmann::json const & get_porphyrogeniture() const { return porphyrogeniture; }
        nlohmann::json & get_mutable_porphyrogeniture() { return porphyrogeniture; }
        void set_porphyrogeniture(nlohmann::json const & value) { this->porphyrogeniture = value; }

        nlohmann::json const & get_preindemnify() const { return preindemnify; }
        nlohmann::json & get_mutable_preindemnify() { return preindemnify; }
        void set_preindemnify(nlohmann::json const & value) { this->preindemnify = value; }

        nlohmann::json const & get_rosal() const { return rosal; }
        nlohmann::json & get_mutable_rosal() { return rosal; }
        void set_rosal(nlohmann::json const & value) { this->rosal = value; }

        nlohmann::json const & get_scalenous() const { return scalenous; }
        nlohmann::json & get_mutable_scalenous() { return scalenous; }
        void set_scalenous(nlohmann::json const & value) { this->scalenous = value; }

        nlohmann::json const & get_scopine() const { return scopine; }
        nlohmann::json & get_mutable_scopine() { return scopine; }
        void set_scopine(nlohmann::json const & value) { this->scopine = value; }

        nlohmann::json const & get_sedaceae() const { return sedaceae; }
        nlohmann::json & get_mutable_sedaceae() { return sedaceae; }
        void set_sedaceae(nlohmann::json const & value) { this->sedaceae = value; }

        nlohmann::json const & get_suberinize() const { return suberinize; }
        nlohmann::json & get_mutable_suberinize() { return suberinize; }
        void set_suberinize(nlohmann::json const & value) { this->suberinize = value; }

        nlohmann::json const & get_symbiot() const { return symbiot; }
        nlohmann::json & get_mutable_symbiot() { return symbiot; }
        void set_symbiot(nlohmann::json const & value) { this->symbiot = value; }

        nlohmann::json const & get_tablefellow() const { return tablefellow; }
        nlohmann::json & get_mutable_tablefellow() { return tablefellow; }
        void set_tablefellow(nlohmann::json const & value) { this->tablefellow = value; }

        nlohmann::json const & get_unchargeable() const { return unchargeable; }
        nlohmann::json & get_mutable_unchargeable() { return unchargeable; }
        void set_unchargeable(nlohmann::json const & value) { this->unchargeable = value; }
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
        nlohmann::json const & get_ammonolytic() const { return ammonolytic; }
        nlohmann::json & get_mutable_ammonolytic() { return ammonolytic; }
        void set_ammonolytic(nlohmann::json const & value) { this->ammonolytic = value; }

        nlohmann::json const & get_bushmaster() const { return bushmaster; }
        nlohmann::json & get_mutable_bushmaster() { return bushmaster; }
        void set_bushmaster(nlohmann::json const & value) { this->bushmaster = value; }

        nlohmann::json const & get_considering() const { return considering; }
        nlohmann::json & get_mutable_considering() { return considering; }
        void set_considering(nlohmann::json const & value) { this->considering = value; }

        nlohmann::json const & get_consuetudinary() const { return consuetudinary; }
        nlohmann::json & get_mutable_consuetudinary() { return consuetudinary; }
        void set_consuetudinary(nlohmann::json const & value) { this->consuetudinary = value; }

        nlohmann::json const & get_embarras() const { return embarras; }
        nlohmann::json & get_mutable_embarras() { return embarras; }
        void set_embarras(nlohmann::json const & value) { this->embarras = value; }

        nlohmann::json const & get_fineness() const { return fineness; }
        nlohmann::json & get_mutable_fineness() { return fineness; }
        void set_fineness(nlohmann::json const & value) { this->fineness = value; }

        nlohmann::json const & get_flaithship() const { return flaithship; }
        nlohmann::json & get_mutable_flaithship() { return flaithship; }
        void set_flaithship(nlohmann::json const & value) { this->flaithship = value; }

        nlohmann::json const & get_flavia() const { return flavia; }
        nlohmann::json & get_mutable_flavia() { return flavia; }
        void set_flavia(nlohmann::json const & value) { this->flavia = value; }

        nlohmann::json const & get_gruffly() const { return gruffly; }
        nlohmann::json & get_mutable_gruffly() { return gruffly; }
        void set_gruffly(nlohmann::json const & value) { this->gruffly = value; }

        nlohmann::json const & get_hedychium() const { return hedychium; }
        nlohmann::json & get_mutable_hedychium() { return hedychium; }
        void set_hedychium(nlohmann::json const & value) { this->hedychium = value; }

        nlohmann::json const & get_leadwort() const { return leadwort; }
        nlohmann::json & get_mutable_leadwort() { return leadwort; }
        void set_leadwort(nlohmann::json const & value) { this->leadwort = value; }

        nlohmann::json const & get_overseriously() const { return overseriously; }
        nlohmann::json & get_mutable_overseriously() { return overseriously; }
        void set_overseriously(nlohmann::json const & value) { this->overseriously = value; }

        nlohmann::json const & get_parabola() const { return parabola; }
        nlohmann::json & get_mutable_parabola() { return parabola; }
        void set_parabola(nlohmann::json const & value) { this->parabola = value; }

        nlohmann::json const & get_pectinatodenticulate() const { return pectinatodenticulate; }
        nlohmann::json & get_mutable_pectinatodenticulate() { return pectinatodenticulate; }
        void set_pectinatodenticulate(nlohmann::json const & value) { this->pectinatodenticulate = value; }

        nlohmann::json const & get_popean() const { return popean; }
        nlohmann::json & get_mutable_popean() { return popean; }
        void set_popean(nlohmann::json const & value) { this->popean = value; }

        nlohmann::json const & get_pornocrat() const { return pornocrat; }
        nlohmann::json & get_mutable_pornocrat() { return pornocrat; }
        void set_pornocrat(nlohmann::json const & value) { this->pornocrat = value; }

        nlohmann::json const & get_quadrisect() const { return quadrisect; }
        nlohmann::json & get_mutable_quadrisect() { return quadrisect; }
        void set_quadrisect(nlohmann::json const & value) { this->quadrisect = value; }

        nlohmann::json const & get_seriality() const { return seriality; }
        nlohmann::json & get_mutable_seriality() { return seriality; }
        void set_seriality(nlohmann::json const & value) { this->seriality = value; }

        nlohmann::json const & get_vamphorn() const { return vamphorn; }
        nlohmann::json & get_mutable_vamphorn() { return vamphorn; }
        void set_vamphorn(nlohmann::json const & value) { this->vamphorn = value; }

        nlohmann::json const & get_wharp() const { return wharp; }
        nlohmann::json & get_mutable_wharp() { return wharp; }
        void set_wharp(nlohmann::json const & value) { this->wharp = value; }
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
        nlohmann::json const & get_bockerel() const { return bockerel; }
        nlohmann::json & get_mutable_bockerel() { return bockerel; }
        void set_bockerel(nlohmann::json const & value) { this->bockerel = value; }

        nlohmann::json const & get_boulder() const { return boulder; }
        nlohmann::json & get_mutable_boulder() { return boulder; }
        void set_boulder(nlohmann::json const & value) { this->boulder = value; }

        nlohmann::json const & get_churrus() const { return churrus; }
        nlohmann::json & get_mutable_churrus() { return churrus; }
        void set_churrus(nlohmann::json const & value) { this->churrus = value; }

        nlohmann::json const & get_counterdigged() const { return counterdigged; }
        nlohmann::json & get_mutable_counterdigged() { return counterdigged; }
        void set_counterdigged(nlohmann::json const & value) { this->counterdigged = value; }

        nlohmann::json const & get_dialogite() const { return dialogite; }
        nlohmann::json & get_mutable_dialogite() { return dialogite; }
        void set_dialogite(nlohmann::json const & value) { this->dialogite = value; }

        nlohmann::json const & get_digenic() const { return digenic; }
        nlohmann::json & get_mutable_digenic() { return digenic; }
        void set_digenic(nlohmann::json const & value) { this->digenic = value; }

        nlohmann::json const & get_dunbird() const { return dunbird; }
        nlohmann::json & get_mutable_dunbird() { return dunbird; }
        void set_dunbird(nlohmann::json const & value) { this->dunbird = value; }

        nlohmann::json const & get_ergatogyne() const { return ergatogyne; }
        nlohmann::json & get_mutable_ergatogyne() { return ergatogyne; }
        void set_ergatogyne(nlohmann::json const & value) { this->ergatogyne = value; }

        nlohmann::json const & get_fiendful() const { return fiendful; }
        nlohmann::json & get_mutable_fiendful() { return fiendful; }
        void set_fiendful(nlohmann::json const & value) { this->fiendful = value; }

        nlohmann::json const & get_jackrod() const { return jackrod; }
        nlohmann::json & get_mutable_jackrod() { return jackrod; }
        void set_jackrod(nlohmann::json const & value) { this->jackrod = value; }

        nlohmann::json const & get_jehovistic() const { return jehovistic; }
        nlohmann::json & get_mutable_jehovistic() { return jehovistic; }
        void set_jehovistic(nlohmann::json const & value) { this->jehovistic = value; }

        nlohmann::json const & get_paninean() const { return paninean; }
        nlohmann::json & get_mutable_paninean() { return paninean; }
        void set_paninean(nlohmann::json const & value) { this->paninean = value; }

        nlohmann::json const & get_panther() const { return panther; }
        nlohmann::json & get_mutable_panther() { return panther; }
        void set_panther(nlohmann::json const & value) { this->panther = value; }

        nlohmann::json const & get_placentigerous() const { return placentigerous; }
        nlohmann::json & get_mutable_placentigerous() { return placentigerous; }
        void set_placentigerous(nlohmann::json const & value) { this->placentigerous = value; }

        nlohmann::json const & get_romney() const { return romney; }
        nlohmann::json & get_mutable_romney() { return romney; }
        void set_romney(nlohmann::json const & value) { this->romney = value; }

        nlohmann::json const & get_sparm() const { return sparm; }
        nlohmann::json & get_mutable_sparm() { return sparm; }
        void set_sparm(nlohmann::json const & value) { this->sparm = value; }

        nlohmann::json const & get_tocsin() const { return tocsin; }
        nlohmann::json & get_mutable_tocsin() { return tocsin; }
        void set_tocsin(nlohmann::json const & value) { this->tocsin = value; }

        nlohmann::json const & get_unnicked() const { return unnicked; }
        nlohmann::json & get_mutable_unnicked() { return unnicked; }
        void set_unnicked(nlohmann::json const & value) { this->unnicked = value; }

        nlohmann::json const & get_unstavable() const { return unstavable; }
        nlohmann::json & get_mutable_unstavable() { return unstavable; }
        void set_unstavable(nlohmann::json const & value) { this->unstavable = value; }

        nlohmann::json const & get_windfirm() const { return windfirm; }
        nlohmann::json & get_mutable_windfirm() { return windfirm; }
        void set_windfirm(nlohmann::json const & value) { this->windfirm = value; }
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
        nlohmann::json const & get_amoreuxia() const { return amoreuxia; }
        nlohmann::json & get_mutable_amoreuxia() { return amoreuxia; }
        void set_amoreuxia(nlohmann::json const & value) { this->amoreuxia = value; }

        nlohmann::json const & get_ani() const { return ani; }
        nlohmann::json & get_mutable_ani() { return ani; }
        void set_ani(nlohmann::json const & value) { this->ani = value; }

        nlohmann::json const & get_bernicle() const { return bernicle; }
        nlohmann::json & get_mutable_bernicle() { return bernicle; }
        void set_bernicle(nlohmann::json const & value) { this->bernicle = value; }

        nlohmann::json const & get_blackwasher() const { return blackwasher; }
        nlohmann::json & get_mutable_blackwasher() { return blackwasher; }
        void set_blackwasher(nlohmann::json const & value) { this->blackwasher = value; }

        nlohmann::json const & get_blowhard() const { return blowhard; }
        nlohmann::json & get_mutable_blowhard() { return blowhard; }
        void set_blowhard(nlohmann::json const & value) { this->blowhard = value; }

        nlohmann::json const & get_broma() const { return broma; }
        nlohmann::json & get_mutable_broma() { return broma; }
        void set_broma(nlohmann::json const & value) { this->broma = value; }

        nlohmann::json const & get_closecross() const { return closecross; }
        nlohmann::json & get_mutable_closecross() { return closecross; }
        void set_closecross(nlohmann::json const & value) { this->closecross = value; }

        nlohmann::json const & get_congregationalism() const { return congregationalism; }
        nlohmann::json & get_mutable_congregationalism() { return congregationalism; }
        void set_congregationalism(nlohmann::json const & value) { this->congregationalism = value; }

        nlohmann::json const & get_grayly() const { return grayly; }
        nlohmann::json & get_mutable_grayly() { return grayly; }
        void set_grayly(nlohmann::json const & value) { this->grayly = value; }

        nlohmann::json const & get_historically() const { return historically; }
        nlohmann::json & get_mutable_historically() { return historically; }
        void set_historically(nlohmann::json const & value) { this->historically = value; }

        nlohmann::json const & get_hoast() const { return hoast; }
        nlohmann::json & get_mutable_hoast() { return hoast; }
        void set_hoast(nlohmann::json const & value) { this->hoast = value; }

        nlohmann::json const & get_irretentive() const { return irretentive; }
        nlohmann::json & get_mutable_irretentive() { return irretentive; }
        void set_irretentive(nlohmann::json const & value) { this->irretentive = value; }

        nlohmann::json const & get_parcener() const { return parcener; }
        nlohmann::json & get_mutable_parcener() { return parcener; }
        void set_parcener(nlohmann::json const & value) { this->parcener = value; }

        nlohmann::json const & get_pedder() const { return pedder; }
        nlohmann::json & get_mutable_pedder() { return pedder; }
        void set_pedder(nlohmann::json const & value) { this->pedder = value; }

        nlohmann::json const & get_pseudoanatomic() const { return pseudoanatomic; }
        nlohmann::json & get_mutable_pseudoanatomic() { return pseudoanatomic; }
        void set_pseudoanatomic(nlohmann::json const & value) { this->pseudoanatomic = value; }

        nlohmann::json const & get_rhizocarpian() const { return rhizocarpian; }
        nlohmann::json & get_mutable_rhizocarpian() { return rhizocarpian; }
        void set_rhizocarpian(nlohmann::json const & value) { this->rhizocarpian = value; }

        nlohmann::json const & get_samel() const { return samel; }
        nlohmann::json & get_mutable_samel() { return samel; }
        void set_samel(nlohmann::json const & value) { this->samel = value; }

        nlohmann::json const & get_silker() const { return silker; }
        nlohmann::json & get_mutable_silker() { return silker; }
        void set_silker(nlohmann::json const & value) { this->silker = value; }

        nlohmann::json const & get_subdentated() const { return subdentated; }
        nlohmann::json & get_mutable_subdentated() { return subdentated; }
        void set_subdentated(nlohmann::json const & value) { this->subdentated = value; }

        nlohmann::json const & get_subobscure() const { return subobscure; }
        nlohmann::json & get_mutable_subobscure() { return subobscure; }
        void set_subobscure(nlohmann::json const & value) { this->subobscure = value; }
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
        nlohmann::json const & get_comradely() const { return comradely; }
        nlohmann::json & get_mutable_comradely() { return comradely; }
        void set_comradely(nlohmann::json const & value) { this->comradely = value; }

        nlohmann::json const & get_diacanthous() const { return diacanthous; }
        nlohmann::json & get_mutable_diacanthous() { return diacanthous; }
        void set_diacanthous(nlohmann::json const & value) { this->diacanthous = value; }

        nlohmann::json const & get_feminineness() const { return feminineness; }
        nlohmann::json & get_mutable_feminineness() { return feminineness; }
        void set_feminineness(nlohmann::json const & value) { this->feminineness = value; }

        nlohmann::json const & get_gossamered() const { return gossamered; }
        nlohmann::json & get_mutable_gossamered() { return gossamered; }
        void set_gossamered(nlohmann::json const & value) { this->gossamered = value; }

        nlohmann::json const & get_hibernia() const { return hibernia; }
        nlohmann::json & get_mutable_hibernia() { return hibernia; }
        void set_hibernia(nlohmann::json const & value) { this->hibernia = value; }

        nlohmann::json const & get_hibiscus() const { return hibiscus; }
        nlohmann::json & get_mutable_hibiscus() { return hibiscus; }
        void set_hibiscus(nlohmann::json const & value) { this->hibiscus = value; }

        nlohmann::json const & get_lepidosauria() const { return lepidosauria; }
        nlohmann::json & get_mutable_lepidosauria() { return lepidosauria; }
        void set_lepidosauria(nlohmann::json const & value) { this->lepidosauria = value; }

        nlohmann::json const & get_lollingly() const { return lollingly; }
        nlohmann::json & get_mutable_lollingly() { return lollingly; }
        void set_lollingly(nlohmann::json const & value) { this->lollingly = value; }

        nlohmann::json const & get_manager() const { return manager; }
        nlohmann::json & get_mutable_manager() { return manager; }
        void set_manager(nlohmann::json const & value) { this->manager = value; }

        nlohmann::json const & get_mechanic() const { return mechanic; }
        nlohmann::json & get_mutable_mechanic() { return mechanic; }
        void set_mechanic(nlohmann::json const & value) { this->mechanic = value; }

        nlohmann::json const & get_overminuteness() const { return overminuteness; }
        nlohmann::json & get_mutable_overminuteness() { return overminuteness; }
        void set_overminuteness(nlohmann::json const & value) { this->overminuteness = value; }

        nlohmann::json const & get_papelonne() const { return papelonne; }
        nlohmann::json & get_mutable_papelonne() { return papelonne; }
        void set_papelonne(nlohmann::json const & value) { this->papelonne = value; }

        nlohmann::json const & get_plebification() const { return plebification; }
        nlohmann::json & get_mutable_plebification() { return plebification; }
        void set_plebification(nlohmann::json const & value) { this->plebification = value; }

        nlohmann::json const & get_pugmiller() const { return pugmiller; }
        nlohmann::json & get_mutable_pugmiller() { return pugmiller; }
        void set_pugmiller(nlohmann::json const & value) { this->pugmiller = value; }

        nlohmann::json const & get_recoveror() const { return recoveror; }
        nlohmann::json & get_mutable_recoveror() { return recoveror; }
        void set_recoveror(nlohmann::json const & value) { this->recoveror = value; }

        nlohmann::json const & get_spermatoblastic() const { return spermatoblastic; }
        nlohmann::json & get_mutable_spermatoblastic() { return spermatoblastic; }
        void set_spermatoblastic(nlohmann::json const & value) { this->spermatoblastic = value; }

        nlohmann::json const & get_syllidae() const { return syllidae; }
        nlohmann::json & get_mutable_syllidae() { return syllidae; }
        void set_syllidae(nlohmann::json const & value) { this->syllidae = value; }

        nlohmann::json const & get_ungyved() const { return ungyved; }
        nlohmann::json & get_mutable_ungyved() { return ungyved; }
        void set_ungyved(nlohmann::json const & value) { this->ungyved = value; }

        nlohmann::json const & get_whirlabout() const { return whirlabout; }
        nlohmann::json & get_mutable_whirlabout() { return whirlabout; }
        void set_whirlabout(nlohmann::json const & value) { this->whirlabout = value; }

        nlohmann::json const & get_woodenware() const { return woodenware; }
        nlohmann::json & get_mutable_woodenware() { return woodenware; }
        void set_woodenware(nlohmann::json const & value) { this->woodenware = value; }
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
        nlohmann::json const & get_abranchian() const { return abranchian; }
        nlohmann::json & get_mutable_abranchian() { return abranchian; }
        void set_abranchian(nlohmann::json const & value) { this->abranchian = value; }

        nlohmann::json const & get_aculeiform() const { return aculeiform; }
        nlohmann::json & get_mutable_aculeiform() { return aculeiform; }
        void set_aculeiform(nlohmann::json const & value) { this->aculeiform = value; }

        nlohmann::json const & get_adiaphoristic() const { return adiaphoristic; }
        nlohmann::json & get_mutable_adiaphoristic() { return adiaphoristic; }
        void set_adiaphoristic(nlohmann::json const & value) { this->adiaphoristic = value; }

        nlohmann::json const & get_adoptionism() const { return adoptionism; }
        nlohmann::json & get_mutable_adoptionism() { return adoptionism; }
        void set_adoptionism(nlohmann::json const & value) { this->adoptionism = value; }

        nlohmann::json const & get_anglic() const { return anglic; }
        nlohmann::json & get_mutable_anglic() { return anglic; }
        void set_anglic(nlohmann::json const & value) { this->anglic = value; }

        nlohmann::json const & get_antrotomy() const { return antrotomy; }
        nlohmann::json & get_mutable_antrotomy() { return antrotomy; }
        void set_antrotomy(nlohmann::json const & value) { this->antrotomy = value; }

        nlohmann::json const & get_coerciveness() const { return coerciveness; }
        nlohmann::json & get_mutable_coerciveness() { return coerciveness; }
        void set_coerciveness(nlohmann::json const & value) { this->coerciveness = value; }

        nlohmann::json const & get_decorist() const { return decorist; }
        nlohmann::json & get_mutable_decorist() { return decorist; }
        void set_decorist(nlohmann::json const & value) { this->decorist = value; }

        nlohmann::json const & get_duckhood() const { return duckhood; }
        nlohmann::json & get_mutable_duckhood() { return duckhood; }
        void set_duckhood(nlohmann::json const & value) { this->duckhood = value; }

        nlohmann::json const & get_heteromeri() const { return heteromeri; }
        nlohmann::json & get_mutable_heteromeri() { return heteromeri; }
        void set_heteromeri(nlohmann::json const & value) { this->heteromeri = value; }

        nlohmann::json const & get_hypochnose() const { return hypochnose; }
        nlohmann::json & get_mutable_hypochnose() { return hypochnose; }
        void set_hypochnose(nlohmann::json const & value) { this->hypochnose = value; }

        nlohmann::json const & get_lochage() const { return lochage; }
        nlohmann::json & get_mutable_lochage() { return lochage; }
        void set_lochage(nlohmann::json const & value) { this->lochage = value; }

        nlohmann::json const & get_melee() const { return melee; }
        nlohmann::json & get_mutable_melee() { return melee; }
        void set_melee(nlohmann::json const & value) { this->melee = value; }

        nlohmann::json const & get_nonconformitant() const { return nonconformitant; }
        nlohmann::json & get_mutable_nonconformitant() { return nonconformitant; }
        void set_nonconformitant(nlohmann::json const & value) { this->nonconformitant = value; }

        nlohmann::json const & get_poinsettia() const { return poinsettia; }
        nlohmann::json & get_mutable_poinsettia() { return poinsettia; }
        void set_poinsettia(nlohmann::json const & value) { this->poinsettia = value; }

        nlohmann::json const & get_putatively() const { return putatively; }
        nlohmann::json & get_mutable_putatively() { return putatively; }
        void set_putatively(nlohmann::json const & value) { this->putatively = value; }

        nlohmann::json const & get_semivolatile() const { return semivolatile; }
        nlohmann::json & get_mutable_semivolatile() { return semivolatile; }
        void set_semivolatile(nlohmann::json const & value) { this->semivolatile = value; }

        nlohmann::json const & get_soleas() const { return soleas; }
        nlohmann::json & get_mutable_soleas() { return soleas; }
        void set_soleas(nlohmann::json const & value) { this->soleas = value; }

        nlohmann::json const & get_unfastenable() const { return unfastenable; }
        nlohmann::json & get_mutable_unfastenable() { return unfastenable; }
        void set_unfastenable(nlohmann::json const & value) { this->unfastenable = value; }

        nlohmann::json const & get_unmillinered() const { return unmillinered; }
        nlohmann::json & get_mutable_unmillinered() { return unmillinered; }
        void set_unmillinered(nlohmann::json const & value) { this->unmillinered = value; }
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
        nlohmann::json const & get_apoise() const { return apoise; }
        nlohmann::json & get_mutable_apoise() { return apoise; }
        void set_apoise(nlohmann::json const & value) { this->apoise = value; }

        nlohmann::json const & get_astronomize() const { return astronomize; }
        nlohmann::json & get_mutable_astronomize() { return astronomize; }
        void set_astronomize(nlohmann::json const & value) { this->astronomize = value; }

        nlohmann::json const & get_cockhorse() const { return cockhorse; }
        nlohmann::json & get_mutable_cockhorse() { return cockhorse; }
        void set_cockhorse(nlohmann::json const & value) { this->cockhorse = value; }

        nlohmann::json const & get_copular() const { return copular; }
        nlohmann::json & get_mutable_copular() { return copular; }
        void set_copular(nlohmann::json const & value) { this->copular = value; }

        nlohmann::json const & get_dagomba() const { return dagomba; }
        nlohmann::json & get_mutable_dagomba() { return dagomba; }
        void set_dagomba(nlohmann::json const & value) { this->dagomba = value; }

        nlohmann::json const & get_draffy() const { return draffy; }
        nlohmann::json & get_mutable_draffy() { return draffy; }
        void set_draffy(nlohmann::json const & value) { this->draffy = value; }

        nlohmann::json const & get_foreigner() const { return foreigner; }
        nlohmann::json & get_mutable_foreigner() { return foreigner; }
        void set_foreigner(nlohmann::json const & value) { this->foreigner = value; }

        nlohmann::json const & get_guyandot() const { return guyandot; }
        nlohmann::json & get_mutable_guyandot() { return guyandot; }
        void set_guyandot(nlohmann::json const & value) { this->guyandot = value; }

        nlohmann::json const & get_neurogliosis() const { return neurogliosis; }
        nlohmann::json & get_mutable_neurogliosis() { return neurogliosis; }
        void set_neurogliosis(nlohmann::json const & value) { this->neurogliosis = value; }

        nlohmann::json const & get_osmious() const { return osmious; }
        nlohmann::json & get_mutable_osmious() { return osmious; }
        void set_osmious(nlohmann::json const & value) { this->osmious = value; }

        nlohmann::json const & get_palpitate() const { return palpitate; }
        nlohmann::json & get_mutable_palpitate() { return palpitate; }
        void set_palpitate(nlohmann::json const & value) { this->palpitate = value; }

        nlohmann::json const & get_rebukeable() const { return rebukeable; }
        nlohmann::json & get_mutable_rebukeable() { return rebukeable; }
        void set_rebukeable(nlohmann::json const & value) { this->rebukeable = value; }

        nlohmann::json const & get_reinwardtia() const { return reinwardtia; }
        nlohmann::json & get_mutable_reinwardtia() { return reinwardtia; }
        void set_reinwardtia(nlohmann::json const & value) { this->reinwardtia = value; }

        nlohmann::json const & get_reservatory() const { return reservatory; }
        nlohmann::json & get_mutable_reservatory() { return reservatory; }
        void set_reservatory(nlohmann::json const & value) { this->reservatory = value; }

        nlohmann::json const & get_scalt() const { return scalt; }
        nlohmann::json & get_mutable_scalt() { return scalt; }
        void set_scalt(nlohmann::json const & value) { this->scalt = value; }

        nlohmann::json const & get_scripturalize() const { return scripturalize; }
        nlohmann::json & get_mutable_scripturalize() { return scripturalize; }
        void set_scripturalize(nlohmann::json const & value) { this->scripturalize = value; }

        nlohmann::json const & get_tintometer() const { return tintometer; }
        nlohmann::json & get_mutable_tintometer() { return tintometer; }
        void set_tintometer(nlohmann::json const & value) { this->tintometer = value; }

        nlohmann::json const & get_tritoness() const { return tritoness; }
        nlohmann::json & get_mutable_tritoness() { return tritoness; }
        void set_tritoness(nlohmann::json const & value) { this->tritoness = value; }

        nlohmann::json const & get_undergrade() const { return undergrade; }
        nlohmann::json & get_mutable_undergrade() { return undergrade; }
        void set_undergrade(nlohmann::json const & value) { this->undergrade = value; }

        nlohmann::json const & get_undermountain() const { return undermountain; }
        nlohmann::json & get_mutable_undermountain() { return undermountain; }
        void set_undermountain(nlohmann::json const & value) { this->undermountain = value; }
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
        nlohmann::json const & get_albarco() const { return albarco; }
        nlohmann::json & get_mutable_albarco() { return albarco; }
        void set_albarco(nlohmann::json const & value) { this->albarco = value; }

        nlohmann::json const & get_bunodonta() const { return bunodonta; }
        nlohmann::json & get_mutable_bunodonta() { return bunodonta; }
        void set_bunodonta(nlohmann::json const & value) { this->bunodonta = value; }

        nlohmann::json const & get_hornify() const { return hornify; }
        nlohmann::json & get_mutable_hornify() { return hornify; }
        void set_hornify(nlohmann::json const & value) { this->hornify = value; }

        nlohmann::json const & get_hydrocorisae() const { return hydrocorisae; }
        nlohmann::json & get_mutable_hydrocorisae() { return hydrocorisae; }
        void set_hydrocorisae(nlohmann::json const & value) { this->hydrocorisae = value; }

        nlohmann::json const & get_hypoglossus() const { return hypoglossus; }
        nlohmann::json & get_mutable_hypoglossus() { return hypoglossus; }
        void set_hypoglossus(nlohmann::json const & value) { this->hypoglossus = value; }

        nlohmann::json const & get_inexpiably() const { return inexpiably; }
        nlohmann::json & get_mutable_inexpiably() { return inexpiably; }
        void set_inexpiably(nlohmann::json const & value) { this->inexpiably = value; }

        nlohmann::json const & get_ingratitude() const { return ingratitude; }
        nlohmann::json & get_mutable_ingratitude() { return ingratitude; }
        void set_ingratitude(nlohmann::json const & value) { this->ingratitude = value; }

        nlohmann::json const & get_ladyfly() const { return ladyfly; }
        nlohmann::json & get_mutable_ladyfly() { return ladyfly; }
        void set_ladyfly(nlohmann::json const & value) { this->ladyfly = value; }

        nlohmann::json const & get_medicament() const { return medicament; }
        nlohmann::json & get_mutable_medicament() { return medicament; }
        void set_medicament(nlohmann::json const & value) { this->medicament = value; }

        nlohmann::json const & get_monogrammatic() const { return monogrammatic; }
        nlohmann::json & get_mutable_monogrammatic() { return monogrammatic; }
        void set_monogrammatic(nlohmann::json const & value) { this->monogrammatic = value; }

        nlohmann::json const & get_nobbut() const { return nobbut; }
        nlohmann::json & get_mutable_nobbut() { return nobbut; }
        void set_nobbut(nlohmann::json const & value) { this->nobbut = value; }

        nlohmann::json const & get_notacanthidae() const { return notacanthidae; }
        nlohmann::json & get_mutable_notacanthidae() { return notacanthidae; }
        void set_notacanthidae(nlohmann::json const & value) { this->notacanthidae = value; }

        nlohmann::json const & get_polyplacophore() const { return polyplacophore; }
        nlohmann::json & get_mutable_polyplacophore() { return polyplacophore; }
        void set_polyplacophore(nlohmann::json const & value) { this->polyplacophore = value; }

        nlohmann::json const & get_proexercise() const { return proexercise; }
        nlohmann::json & get_mutable_proexercise() { return proexercise; }
        void set_proexercise(nlohmann::json const & value) { this->proexercise = value; }

        nlohmann::json const & get_protoplast() const { return protoplast; }
        nlohmann::json & get_mutable_protoplast() { return protoplast; }
        void set_protoplast(nlohmann::json const & value) { this->protoplast = value; }

        nlohmann::json const & get_puzzling() const { return puzzling; }
        nlohmann::json & get_mutable_puzzling() { return puzzling; }
        void set_puzzling(nlohmann::json const & value) { this->puzzling = value; }

        nlohmann::json const & get_splanchnoskeleton() const { return splanchnoskeleton; }
        nlohmann::json & get_mutable_splanchnoskeleton() { return splanchnoskeleton; }
        void set_splanchnoskeleton(nlohmann::json const & value) { this->splanchnoskeleton = value; }

        nlohmann::json const & get_unloveliness() const { return unloveliness; }
        nlohmann::json & get_mutable_unloveliness() { return unloveliness; }
        void set_unloveliness(nlohmann::json const & value) { this->unloveliness = value; }

        nlohmann::json const & get_unquarantined() const { return unquarantined; }
        nlohmann::json & get_mutable_unquarantined() { return unquarantined; }
        void set_unquarantined(nlohmann::json const & value) { this->unquarantined = value; }

        nlohmann::json const & get_unrenounceable() const { return unrenounceable; }
        nlohmann::json & get_mutable_unrenounceable() { return unrenounceable; }
        void set_unrenounceable(nlohmann::json const & value) { this->unrenounceable = value; }
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
        nlohmann::json const & get_acrogamy() const { return acrogamy; }
        nlohmann::json & get_mutable_acrogamy() { return acrogamy; }
        void set_acrogamy(nlohmann::json const & value) { this->acrogamy = value; }

        nlohmann::json const & get_amelification() const { return amelification; }
        nlohmann::json & get_mutable_amelification() { return amelification; }
        void set_amelification(nlohmann::json const & value) { this->amelification = value; }

        nlohmann::json const & get_autobiographic() const { return autobiographic; }
        nlohmann::json & get_mutable_autobiographic() { return autobiographic; }
        void set_autobiographic(nlohmann::json const & value) { this->autobiographic = value; }

        nlohmann::json const & get_berat() const { return berat; }
        nlohmann::json & get_mutable_berat() { return berat; }
        void set_berat(nlohmann::json const & value) { this->berat = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_disproportionably() const { return disproportionably; }
        nlohmann::json & get_mutable_disproportionably() { return disproportionably; }
        void set_disproportionably(nlohmann::json const & value) { this->disproportionably = value; }

        nlohmann::json const & get_erythrite() const { return erythrite; }
        nlohmann::json & get_mutable_erythrite() { return erythrite; }
        void set_erythrite(nlohmann::json const & value) { this->erythrite = value; }

        nlohmann::json const & get_graphic() const { return graphic; }
        nlohmann::json & get_mutable_graphic() { return graphic; }
        void set_graphic(nlohmann::json const & value) { this->graphic = value; }

        nlohmann::json const & get_hepatological() const { return hepatological; }
        nlohmann::json & get_mutable_hepatological() { return hepatological; }
        void set_hepatological(nlohmann::json const & value) { this->hepatological = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_incommensurably() const { return incommensurably; }
        nlohmann::json & get_mutable_incommensurably() { return incommensurably; }
        void set_incommensurably(nlohmann::json const & value) { this->incommensurably = value; }

        nlohmann::json const & get_misaffirm() const { return misaffirm; }
        nlohmann::json & get_mutable_misaffirm() { return misaffirm; }
        void set_misaffirm(nlohmann::json const & value) { this->misaffirm = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_pocketbook() const { return pocketbook; }
        nlohmann::json & get_mutable_pocketbook() { return pocketbook; }
        void set_pocketbook(nlohmann::json const & value) { this->pocketbook = value; }

        nlohmann::json const & get_sclerometric() const { return sclerometric; }
        nlohmann::json & get_mutable_sclerometric() { return sclerometric; }
        void set_sclerometric(nlohmann::json const & value) { this->sclerometric = value; }

        nlohmann::json const & get_stambouline() const { return stambouline; }
        nlohmann::json & get_mutable_stambouline() { return stambouline; }
        void set_stambouline(nlohmann::json const & value) { this->stambouline = value; }

        nlohmann::json const & get_stickpin() const { return stickpin; }
        nlohmann::json & get_mutable_stickpin() { return stickpin; }
        void set_stickpin(nlohmann::json const & value) { this->stickpin = value; }

        nlohmann::json const & get_tubulure() const { return tubulure; }
        nlohmann::json & get_mutable_tubulure() { return tubulure; }
        void set_tubulure(nlohmann::json const & value) { this->tubulure = value; }

        nlohmann::json const & get_undelated() const { return undelated; }
        nlohmann::json & get_mutable_undelated() { return undelated; }
        void set_undelated(nlohmann::json const & value) { this->undelated = value; }

        nlohmann::json const & get_unsalt() const { return unsalt; }
        nlohmann::json & get_mutable_unsalt() { return unsalt; }
        void set_unsalt(nlohmann::json const & value) { this->unsalt = value; }

        nlohmann::json const & get_untutelar() const { return untutelar; }
        nlohmann::json & get_mutable_untutelar() { return untutelar; }
        void set_untutelar(nlohmann::json const & value) { this->untutelar = value; }

        nlohmann::json const & get_vagrant() const { return vagrant; }
        nlohmann::json & get_mutable_vagrant() { return vagrant; }
        void set_vagrant(nlohmann::json const & value) { this->vagrant = value; }

        nlohmann::json const & get_walt() const { return walt; }
        nlohmann::json & get_mutable_walt() { return walt; }
        void set_walt(nlohmann::json const & value) { this->walt = value; }
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
        double const & get_assapan() const { return assapan; }
        double & get_mutable_assapan() { return assapan; }
        void set_assapan(double const & value) { this->assapan = value; }

        bool const & get_benefactorship() const { return benefactorship; }
        bool & get_mutable_benefactorship() { return benefactorship; }
        void set_benefactorship(bool const & value) { this->benefactorship = value; }

        std::string const & get_triseriatim() const { return triseriatim; }
        std::string & get_mutable_triseriatim() { return triseriatim; }
        void set_triseriatim(std::string const & value) { this->triseriatim = value; }

        int64_t const & get_tubbing() const { return tubbing; }
        int64_t & get_mutable_tubbing() { return tubbing; }
        void set_tubbing(int64_t const & value) { this->tubbing = value; }

        nlohmann::json const & get_untrimmed() const { return untrimmed; }
        nlohmann::json & get_mutable_untrimmed() { return untrimmed; }
        void set_untrimmed(nlohmann::json const & value) { this->untrimmed = value; }
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
        std::string const & get_centrodesmose() const { return centrodesmose; }
        std::string & get_mutable_centrodesmose() { return centrodesmose; }
        void set_centrodesmose(std::string const & value) { this->centrodesmose = value; }

        std::vector<CerographElement> const & get_cerograph() const { return cerograph; }
        std::vector<CerographElement> & get_mutable_cerograph() { return cerograph; }
        void set_cerograph(std::vector<CerographElement> const & value) { this->cerograph = value; }

        std::vector<ChemotherapeuticElement> const & get_chemotherapeutics() const { return chemotherapeutics; }
        std::vector<ChemotherapeuticElement> & get_mutable_chemotherapeutics() { return chemotherapeutics; }
        void set_chemotherapeutics(std::vector<ChemotherapeuticElement> const & value) { this->chemotherapeutics = value; }

        std::vector<CimeliaElement> const & get_cimelia() const { return cimelia; }
        std::vector<CimeliaElement> & get_mutable_cimelia() { return cimelia; }
        void set_cimelia(std::vector<CimeliaElement> const & value) { this->cimelia = value; }

        int64_t const & get_citrated() const { return citrated; }
        int64_t & get_mutable_citrated() { return citrated; }
        void set_citrated(int64_t const & value) { this->citrated = value; }

        std::vector<Clinodome> const & get_clinodome() const { return clinodome; }
        std::vector<Clinodome> & get_mutable_clinodome() { return clinodome; }
        void set_clinodome(std::vector<Clinodome> const & value) { this->clinodome = value; }

        std::vector<CoadjustElement> const & get_coadjust() const { return coadjust; }
        std::vector<CoadjustElement> & get_mutable_coadjust() { return coadjust; }
        void set_coadjust(std::vector<CoadjustElement> const & value) { this->coadjust = value; }

        std::vector<Consilience> const & get_consilience() const { return consilience; }
        std::vector<Consilience> & get_mutable_consilience() { return consilience; }
        void set_consilience(std::vector<Consilience> const & value) { this->consilience = value; }

        std::vector<Constructor> const & get_constructor() const { return constructor; }
        std::vector<Constructor> & get_mutable_constructor() { return constructor; }
        void set_constructor(std::vector<Constructor> const & value) { this->constructor = value; }

        std::vector<Continuative> const & get_continuative() const { return continuative; }
        std::vector<Continuative> & get_mutable_continuative() { return continuative; }
        void set_continuative(std::vector<Continuative> const & value) { this->continuative = value; }

        std::vector<CredulityElement> const & get_credulity() const { return credulity; }
        std::vector<CredulityElement> & get_mutable_credulity() { return credulity; }
        void set_credulity(std::vector<CredulityElement> const & value) { this->credulity = value; }

        std::vector<Creviced> const & get_creviced() const { return creviced; }
        std::vector<Creviced> & get_mutable_creviced() { return creviced; }
        void set_creviced(std::vector<Creviced> const & value) { this->creviced = value; }

        std::vector<std::vector<std::optional<int64_t>>> const & get_cubiculum() const { return cubiculum; }
        std::vector<std::vector<std::optional<int64_t>>> & get_mutable_cubiculum() { return cubiculum; }
        void set_cubiculum(std::vector<std::vector<std::optional<int64_t>>> const & value) { this->cubiculum = value; }

        std::vector<DeruralizeElement> const & get_deruralize() const { return deruralize; }
        std::vector<DeruralizeElement> & get_mutable_deruralize() { return deruralize; }
        void set_deruralize(std::vector<DeruralizeElement> const & value) { this->deruralize = value; }

        std::vector<DiaereseElement> const & get_diaereses() const { return diaereses; }
        std::vector<DiaereseElement> & get_mutable_diaereses() { return diaereses; }
        void set_diaereses(std::vector<DiaereseElement> const & value) { this->diaereses = value; }

        std::vector<std::optional<std::vector<nlohmann::json>>> const & get_dissolution() const { return dissolution; }
        std::vector<std::optional<std::vector<nlohmann::json>>> & get_mutable_dissolution() { return dissolution; }
        void set_dissolution(std::vector<std::optional<std::vector<nlohmann::json>>> const & value) { this->dissolution = value; }

        std::vector<Downstroke> const & get_downstroke() const { return downstroke; }
        std::vector<Downstroke> & get_mutable_downstroke() { return downstroke; }
        void set_downstroke(std::vector<Downstroke> const & value) { this->downstroke = value; }

        std::vector<std::optional<double>> const & get_electrotautomerism() const { return electrotautomerism; }
        std::vector<std::optional<double>> & get_mutable_electrotautomerism() { return electrotautomerism; }
        void set_electrotautomerism(std::vector<std::optional<double>> const & value) { this->electrotautomerism = value; }

        std::vector<Eleutheromania> const & get_eleutheromania() const { return eleutheromania; }
        std::vector<Eleutheromania> & get_mutable_eleutheromania() { return eleutheromania; }
        void set_eleutheromania(std::vector<Eleutheromania> const & value) { this->eleutheromania = value; }

        Encrust const & get_encrust() const { return encrust; }
        Encrust & get_mutable_encrust() { return encrust; }
        void set_encrust(Encrust const & value) { this->encrust = value; }

        std::vector<Entomoid> const & get_entomoid() const { return entomoid; }
        std::vector<Entomoid> & get_mutable_entomoid() { return entomoid; }
        void set_entomoid(std::vector<Entomoid> const & value) { this->entomoid = value; }

        std::vector<Epipaleolithic> const & get_epipaleolithic() const { return epipaleolithic; }
        std::vector<Epipaleolithic> & get_mutable_epipaleolithic() { return epipaleolithic; }
        void set_epipaleolithic(std::vector<Epipaleolithic> const & value) { this->epipaleolithic = value; }

        std::vector<Expropriable> const & get_expropriable() const { return expropriable; }
        std::vector<Expropriable> & get_mutable_expropriable() { return expropriable; }
        void set_expropriable(std::vector<Expropriable> const & value) { this->expropriable = value; }

        std::vector<FagginglyElement> const & get_faggingly() const { return faggingly; }
        std::vector<FagginglyElement> & get_mutable_faggingly() { return faggingly; }
        void set_faggingly(std::vector<FagginglyElement> const & value) { this->faggingly = value; }

        std::vector<FenkElement> const & get_fenks() const { return fenks; }
        std::vector<FenkElement> & get_mutable_fenks() { return fenks; }
        void set_fenks(std::vector<FenkElement> const & value) { this->fenks = value; }

        std::vector<FlagmakingElement> const & get_flagmaking() const { return flagmaking; }
        std::vector<FlagmakingElement> & get_mutable_flagmaking() { return flagmaking; }
        void set_flagmaking(std::vector<FlagmakingElement> const & value) { this->flagmaking = value; }

        std::vector<Fluorometer> const & get_fluorometer() const { return fluorometer; }
        std::vector<Fluorometer> & get_mutable_fluorometer() { return fluorometer; }
        void set_fluorometer(std::vector<Fluorometer> const & value) { this->fluorometer = value; }

        std::vector<std::optional<int64_t>> const & get_fulsome() const { return fulsome; }
        std::vector<std::optional<int64_t>> & get_mutable_fulsome() { return fulsome; }
        void set_fulsome(std::vector<std::optional<int64_t>> const & value) { this->fulsome = value; }

        std::vector<Fuzzy> const & get_fuzzy() const { return fuzzy; }
        std::vector<Fuzzy> & get_mutable_fuzzy() { return fuzzy; }
        void set_fuzzy(std::vector<Fuzzy> const & value) { this->fuzzy = value; }

        std::vector<Gardenward> const & get_gardenwards() const { return gardenwards; }
        std::vector<Gardenward> & get_mutable_gardenwards() { return gardenwards; }
        void set_gardenwards(std::vector<Gardenward> const & value) { this->gardenwards = value; }

        std::vector<Generalissimo> const & get_generalissimo() const { return generalissimo; }
        std::vector<Generalissimo> & get_mutable_generalissimo() { return generalissimo; }
        void set_generalissimo(std::vector<Generalissimo> const & value) { this->generalissimo = value; }

        std::vector<std::optional<std::map<std::string, int64_t>>> const & get_habeas() const { return habeas; }
        std::vector<std::optional<std::map<std::string, int64_t>>> & get_mutable_habeas() { return habeas; }
        void set_habeas(std::vector<std::optional<std::map<std::string, int64_t>>> const & value) { this->habeas = value; }

        std::vector<Hemicrystalline> const & get_hemicrystalline() const { return hemicrystalline; }
        std::vector<Hemicrystalline> & get_mutable_hemicrystalline() { return hemicrystalline; }
        void set_hemicrystalline(std::vector<Hemicrystalline> const & value) { this->hemicrystalline = value; }

        std::vector<HemocoeleElement> const & get_hemocoele() const { return hemocoele; }
        std::vector<HemocoeleElement> & get_mutable_hemocoele() { return hemocoele; }
        void set_hemocoele(std::vector<HemocoeleElement> const & value) { this->hemocoele = value; }

        std::vector<Hoister> const & get_hoister() const { return hoister; }
        std::vector<Hoister> & get_mutable_hoister() { return hoister; }
        void set_hoister(std::vector<Hoister> const & value) { this->hoister = value; }

        std::vector<Hyperpiesi> const & get_hyperpiesis() const { return hyperpiesis; }
        std::vector<Hyperpiesi> & get_mutable_hyperpiesis() { return hyperpiesis; }
        void set_hyperpiesis(std::vector<Hyperpiesi> const & value) { this->hyperpiesis = value; }

        std::vector<Hyppish> const & get_hyppish() const { return hyppish; }
        std::vector<Hyppish> & get_mutable_hyppish() { return hyppish; }
        void set_hyppish(std::vector<Hyppish> const & value) { this->hyppish = value; }

        std::vector<Idealizer> const & get_idealizer() const { return idealizer; }
        std::vector<Idealizer> & get_mutable_idealizer() { return idealizer; }
        void set_idealizer(std::vector<Idealizer> const & value) { this->idealizer = value; }

        std::vector<Incrustator> const & get_incrustator() const { return incrustator; }
        std::vector<Incrustator> & get_mutable_incrustator() { return incrustator; }
        void set_incrustator(std::vector<Incrustator> const & value) { this->incrustator = value; }

        std::vector<Intentiveness> const & get_intentiveness() const { return intentiveness; }
        std::vector<Intentiveness> & get_mutable_intentiveness() { return intentiveness; }
        void set_intentiveness(std::vector<Intentiveness> const & value) { this->intentiveness = value; }

        Interacinar const & get_interacinar() const { return interacinar; }
        Interacinar & get_mutable_interacinar() { return interacinar; }
        void set_interacinar(Interacinar const & value) { this->interacinar = value; }

        std::vector<std::optional<std::vector<int64_t>>> const & get_intercorrelation() const { return intercorrelation; }
        std::vector<std::optional<std::vector<int64_t>>> & get_mutable_intercorrelation() { return intercorrelation; }
        void set_intercorrelation(std::vector<std::optional<std::vector<int64_t>>> const & value) { this->intercorrelation = value; }

        std::vector<Jacutinga> const & get_jacutinga() const { return jacutinga; }
        std::vector<Jacutinga> & get_mutable_jacutinga() { return jacutinga; }
        void set_jacutinga(std::vector<Jacutinga> const & value) { this->jacutinga = value; }
    };
}

namespace quicktype {
void from_json(json const & j, CerographClass & x);
void to_json(json & j, CerographClass const & x);

void from_json(json const & j, ChemotherapeuticClass & x);
void to_json(json & j, ChemotherapeuticClass const & x);

void from_json(json const & j, CimeliaClass & x);
void to_json(json & j, CimeliaClass const & x);

void from_json(json const & j, CoadjustClass & x);
void to_json(json & j, CoadjustClass const & x);

void from_json(json const & j, CredulityClass & x);
void to_json(json & j, CredulityClass const & x);

void from_json(json const & j, DeruralizeClass & x);
void to_json(json & j, DeruralizeClass const & x);

void from_json(json const & j, DiaereseClass & x);
void to_json(json & j, DiaereseClass const & x);

void from_json(json const & j, Encrust & x);
void to_json(json & j, Encrust const & x);

void from_json(json const & j, FagginglyClass & x);
void to_json(json & j, FagginglyClass const & x);

void from_json(json const & j, FenkClass & x);
void to_json(json & j, FenkClass const & x);

void from_json(json const & j, FlagmakingClass & x);
void to_json(json & j, FlagmakingClass const & x);

void from_json(json const & j, HemocoeleClass & x);
void to_json(json & j, HemocoeleClass const & x);

void from_json(json const & j, Interacinar & x);
void to_json(json & j, Interacinar const & x);

void from_json(json const & j, TopLevel & x);
void to_json(json & j, TopLevel const & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::CerographClass, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::CerographClass, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::CerographClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ChemotherapeuticClass, int64_t>> {
    static void from_json(json const & j, std::variant<quicktype::ChemotherapeuticClass, int64_t> & x);
    static void to_json(json & j, std::variant<quicktype::ChemotherapeuticClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::CimeliaClass>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::CimeliaClass> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::CimeliaClass> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(json const & j, std::variant<double, std::string> & x);
    static void to_json(json & j, std::variant<double, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CoadjustClass, double>> {
    static void from_json(json const & j, std::variant<quicktype::CoadjustClass, double> & x);
    static void to_json(json & j, std::variant<quicktype::CoadjustClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<double, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(json const & j, std::variant<bool, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, std::variant<bool, std::map<std::string, std::optional<int64_t>>> const & x);
};

template <>
struct adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<std::map<std::string, int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CredulityClass, int64_t, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::CredulityClass, int64_t, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::CredulityClass, int64_t, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<bool, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<bool, std::map<std::string, int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, quicktype::DeruralizeClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<double, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<double, std::map<std::string, int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CimeliaClass, int64_t>> {
    static void from_json(json const & j, std::variant<quicktype::CimeliaClass, int64_t> & x);
    static void to_json(json & j, std::variant<quicktype::CimeliaClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, double> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, double>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::CimeliaClass, double> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FagginglyClass, double>> {
    static void from_json(json const & j, std::variant<quicktype::FagginglyClass, double> & x);
    static void to_json(json & j, std::variant<quicktype::FagginglyClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::FenkClass, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::FenkClass, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::FenkClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::FlagmakingClass, double>> {
    static void from_json(json const & j, std::variant<bool, quicktype::FlagmakingClass, double> & x);
    static void to_json(json & j, std::variant<bool, quicktype::FlagmakingClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(json const & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, std::variant<int64_t, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(json const & j, std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<bool, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CimeliaClass, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::CimeliaClass, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::CimeliaClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::HemocoeleClass>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::CimeliaClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::CimeliaClass> const & x);
};

template <>
struct adl_serializer<std::variant<bool, std::string>> {
    static void from_json(json const & j, std::variant<bool, std::string> & x);
    static void to_json(json & j, std::variant<bool, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, int64_t, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, int64_t, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::CimeliaClass, double, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::CimeliaClass, double, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::CimeliaClass, double, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> const & x);
};
}
namespace quicktype {
    inline void from_json(json const & j, CerographClass& x) {
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

    inline void to_json(json & j, CerographClass const & x) {
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

    inline void from_json(json const & j, ChemotherapeuticClass& x) {
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

    inline void to_json(json & j, ChemotherapeuticClass const & x) {
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

    inline void from_json(json const & j, CimeliaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_catharticalness(j.at("catharticalness").get<double>());
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_chirotherium(j.at("Chirotherium").get<int64_t>());
        x.set_disdiapason(j.at("disdiapason").get<std::string>());
        x.set_homocerc(j.at("homocerc").get<bool>());
        x.set_nonbookish(get_untyped(j, "nonbookish"));
    }

    inline void to_json(json & j, CimeliaClass const & x) {
        j = json::object();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["homocerc"] = x.get_homocerc();
        j["nonbookish"] = x.get_nonbookish();
    }

    inline void from_json(json const & j, CoadjustClass& x) {
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

    inline void to_json(json & j, CoadjustClass const & x) {
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

    inline void from_json(json const & j, CredulityClass& x) {
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

    inline void to_json(json & j, CredulityClass const & x) {
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

    inline void from_json(json const & j, DeruralizeClass& x) {
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

    inline void to_json(json & j, DeruralizeClass const & x) {
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

    inline void from_json(json const & j, DiaereseClass& x) {
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

    inline void to_json(json & j, DiaereseClass const & x) {
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

    inline void from_json(json const & j, Encrust& x) {
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

    inline void to_json(json & j, Encrust const & x) {
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

    inline void from_json(json const & j, FagginglyClass& x) {
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

    inline void to_json(json & j, FagginglyClass const & x) {
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

    inline void from_json(json const & j, FenkClass& x) {
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

    inline void to_json(json & j, FenkClass const & x) {
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

    inline void from_json(json const & j, FlagmakingClass& x) {
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

    inline void to_json(json & j, FlagmakingClass const & x) {
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

    inline void from_json(json const & j, HemocoeleClass& x) {
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

    inline void to_json(json & j, HemocoeleClass const & x) {
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

    inline void from_json(json const & j, Interacinar& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_assapan(j.at("assapan").get<double>());
        x.set_benefactorship(j.at("benefactorship").get<bool>());
        x.set_triseriatim(j.at("triseriatim").get<std::string>());
        if (j.find("tubbing") != j.end() && !j.at("tubbing").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tubbing(j.at("tubbing").get<int64_t>());
        x.set_untrimmed(get_untyped(j, "untrimmed"));
    }

    inline void to_json(json & j, Interacinar const & x) {
        j = json::object();
        j["assapan"] = x.get_assapan();
        j["benefactorship"] = x.get_benefactorship();
        j["triseriatim"] = x.get_triseriatim();
        j["tubbing"] = x.get_tubbing();
        j["untrimmed"] = x.get_untrimmed();
    }

    inline void from_json(json const & j, TopLevel& x) {
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

    inline void to_json(json & j, TopLevel const & x) {
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
    inline void adl_serializer<std::variant<quicktype::CerographClass, std::string>>::from_json(json const & j, std::variant<quicktype::CerographClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CerographClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CerographClass, std::string>>::to_json(json & j, std::variant<quicktype::CerographClass, std::string> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::ChemotherapeuticClass, int64_t>>::from_json(json const & j, std::variant<quicktype::ChemotherapeuticClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::ChemotherapeuticClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ChemotherapeuticClass, int64_t>>::to_json(json & j, std::variant<quicktype::ChemotherapeuticClass, int64_t> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::CimeliaClass>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::CimeliaClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::CimeliaClass>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::CimeliaClass> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::CoadjustClass, double>>::from_json(json const & j, std::variant<quicktype::CoadjustClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CoadjustClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CoadjustClass, double>>::to_json(json & j, std::variant<quicktype::CoadjustClass, double> const & x) {
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

    inline void adl_serializer<std::variant<bool, std::map<std::string, std::optional<int64_t>>>>::from_json(json const & j, std::variant<bool, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, std::variant<bool, std::map<std::string, std::optional<int64_t>>> const & x) {
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

    inline void adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>>::from_json(json const & j, std::variant<std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>>::to_json(json & j, std::variant<std::map<std::string, int64_t>, std::string> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::CredulityClass, int64_t, std::string>>::from_json(json const & j, std::variant<quicktype::CredulityClass, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CredulityClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CredulityClass, int64_t, std::string>>::to_json(json & j, std::variant<quicktype::CredulityClass, int64_t, std::string> const & x) {
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

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>, std::string>>::from_json(json const & j, std::variant<bool, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>, std::string>>::to_json(json & j, std::variant<bool, std::map<std::string, int64_t>, std::string> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::DeruralizeClass>>::from_json(json const & j, std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::DeruralizeClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::DeruralizeClass>>::to_json(json & j, std::variant<std::vector<json>, bool, quicktype::DeruralizeClass> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass>>::from_json(json const & j, std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::DiaereseClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass>>::to_json(json & j, std::variant<std::vector<int64_t>, bool, quicktype::DiaereseClass> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::string>>::from_json(json const & j, std::variant<std::vector<json>, bool, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::string>>::to_json(json & j, std::variant<std::vector<json>, bool, std::string> const & x) {
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

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>, std::string>>::from_json(json const & j, std::variant<double, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, int64_t>, std::string>>::to_json(json & j, std::variant<double, std::map<std::string, int64_t>, std::string> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, int64_t>>::from_json(json const & j, std::variant<quicktype::CimeliaClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, int64_t>>::to_json(json & j, std::variant<quicktype::CimeliaClass, int64_t> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, double>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::CimeliaClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, double>>::to_json(json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, double> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::FagginglyClass, double>>::from_json(json const & j, std::variant<quicktype::FagginglyClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FagginglyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FagginglyClass, double>>::to_json(json & j, std::variant<quicktype::FagginglyClass, double> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::FenkClass, std::string>>::from_json(json const & j, std::variant<quicktype::FenkClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::FenkClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::FenkClass, std::string>>::to_json(json & j, std::variant<quicktype::FenkClass, std::string> const & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::FlagmakingClass, double>>::from_json(json const & j, std::variant<bool, quicktype::FlagmakingClass, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::FlagmakingClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::FlagmakingClass, double>>::to_json(json & j, std::variant<bool, quicktype::FlagmakingClass, double> const & x) {
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

    inline void adl_serializer<std::variant<int64_t, std::string>>::from_json(json const & j, std::variant<int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::string>>::to_json(json & j, std::variant<int64_t, std::string> const & x) {
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

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>>::from_json(json const & j, std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, std::variant<int64_t, std::map<std::string, std::optional<int64_t>>> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::string>>::from_json(json const & j, std::variant<std::vector<int64_t>, bool, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::string>>::to_json(json & j, std::variant<std::vector<int64_t>, bool, std::string> const & x) {
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

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<bool, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<bool, std::map<std::string, int64_t>> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, std::string>>::from_json(json const & j, std::variant<quicktype::CimeliaClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, std::string>>::to_json(json & j, std::variant<quicktype::CimeliaClass, std::string> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::HemocoeleClass>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::HemocoeleClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::HemocoeleClass>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::HemocoeleClass> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::CimeliaClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass>>::to_json(json & j, std::variant<std::vector<json>, quicktype::CimeliaClass> const & x) {
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

    inline void adl_serializer<std::variant<bool, std::string>>::from_json(json const & j, std::variant<bool, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::string>>::to_json(json & j, std::variant<bool, std::string> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t>>::to_json(json & j, std::variant<std::vector<json>, quicktype::CimeliaClass, int64_t> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::string>>::from_json(json const & j, std::variant<std::vector<int64_t>, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::string>>::to_json(json & j, std::variant<std::vector<int64_t>, int64_t, std::string> const & x) {
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

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, double, std::string>>::from_json(json const & j, std::variant<quicktype::CimeliaClass, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::CimeliaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::CimeliaClass, double, std::string>>::to_json(json & j, std::variant<quicktype::CimeliaClass, double, std::string> const & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>>::from_json(json const & j, std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>> const & x) {
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
