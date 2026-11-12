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

    using Protrusive = std::variant<std::vector<std::optional<int64_t>>, double>;

    class PulpitismClass {
        public:
        PulpitismClass() = default;
        virtual ~PulpitismClass() = default;

        private:
        nlohmann::json abnet;
        nlohmann::json buckhorn;
        nlohmann::json calciform;
        nlohmann::json chelophore;
        nlohmann::json cogitation;
        nlohmann::json decreeable;
        nlohmann::json despicable;
        nlohmann::json isodiazo;
        nlohmann::json jadedly;
        nlohmann::json leptochlorite;
        nlohmann::json nursling;
        nlohmann::json palamedean;
        nlohmann::json photoheliograph;
        nlohmann::json pipewood;
        nlohmann::json roberd;
        nlohmann::json statable;
        nlohmann::json superassume;
        nlohmann::json syllabe;
        nlohmann::json toughhead;
        nlohmann::json underburn;

        public:
        nlohmann::json const & get_abnet() const { return abnet; }
        nlohmann::json & get_mutable_abnet() { return abnet; }
        void set_abnet(nlohmann::json const & value) { this->abnet = value; }

        nlohmann::json const & get_buckhorn() const { return buckhorn; }
        nlohmann::json & get_mutable_buckhorn() { return buckhorn; }
        void set_buckhorn(nlohmann::json const & value) { this->buckhorn = value; }

        nlohmann::json const & get_calciform() const { return calciform; }
        nlohmann::json & get_mutable_calciform() { return calciform; }
        void set_calciform(nlohmann::json const & value) { this->calciform = value; }

        nlohmann::json const & get_chelophore() const { return chelophore; }
        nlohmann::json & get_mutable_chelophore() { return chelophore; }
        void set_chelophore(nlohmann::json const & value) { this->chelophore = value; }

        nlohmann::json const & get_cogitation() const { return cogitation; }
        nlohmann::json & get_mutable_cogitation() { return cogitation; }
        void set_cogitation(nlohmann::json const & value) { this->cogitation = value; }

        nlohmann::json const & get_decreeable() const { return decreeable; }
        nlohmann::json & get_mutable_decreeable() { return decreeable; }
        void set_decreeable(nlohmann::json const & value) { this->decreeable = value; }

        nlohmann::json const & get_despicable() const { return despicable; }
        nlohmann::json & get_mutable_despicable() { return despicable; }
        void set_despicable(nlohmann::json const & value) { this->despicable = value; }

        nlohmann::json const & get_isodiazo() const { return isodiazo; }
        nlohmann::json & get_mutable_isodiazo() { return isodiazo; }
        void set_isodiazo(nlohmann::json const & value) { this->isodiazo = value; }

        nlohmann::json const & get_jadedly() const { return jadedly; }
        nlohmann::json & get_mutable_jadedly() { return jadedly; }
        void set_jadedly(nlohmann::json const & value) { this->jadedly = value; }

        nlohmann::json const & get_leptochlorite() const { return leptochlorite; }
        nlohmann::json & get_mutable_leptochlorite() { return leptochlorite; }
        void set_leptochlorite(nlohmann::json const & value) { this->leptochlorite = value; }

        nlohmann::json const & get_nursling() const { return nursling; }
        nlohmann::json & get_mutable_nursling() { return nursling; }
        void set_nursling(nlohmann::json const & value) { this->nursling = value; }

        nlohmann::json const & get_palamedean() const { return palamedean; }
        nlohmann::json & get_mutable_palamedean() { return palamedean; }
        void set_palamedean(nlohmann::json const & value) { this->palamedean = value; }

        nlohmann::json const & get_photoheliograph() const { return photoheliograph; }
        nlohmann::json & get_mutable_photoheliograph() { return photoheliograph; }
        void set_photoheliograph(nlohmann::json const & value) { this->photoheliograph = value; }

        nlohmann::json const & get_pipewood() const { return pipewood; }
        nlohmann::json & get_mutable_pipewood() { return pipewood; }
        void set_pipewood(nlohmann::json const & value) { this->pipewood = value; }

        nlohmann::json const & get_roberd() const { return roberd; }
        nlohmann::json & get_mutable_roberd() { return roberd; }
        void set_roberd(nlohmann::json const & value) { this->roberd = value; }

        nlohmann::json const & get_statable() const { return statable; }
        nlohmann::json & get_mutable_statable() { return statable; }
        void set_statable(nlohmann::json const & value) { this->statable = value; }

        nlohmann::json const & get_superassume() const { return superassume; }
        nlohmann::json & get_mutable_superassume() { return superassume; }
        void set_superassume(nlohmann::json const & value) { this->superassume = value; }

        nlohmann::json const & get_syllabe() const { return syllabe; }
        nlohmann::json & get_mutable_syllabe() { return syllabe; }
        void set_syllabe(nlohmann::json const & value) { this->syllabe = value; }

        nlohmann::json const & get_toughhead() const { return toughhead; }
        nlohmann::json & get_mutable_toughhead() { return toughhead; }
        void set_toughhead(nlohmann::json const & value) { this->toughhead = value; }

        nlohmann::json const & get_underburn() const { return underburn; }
        nlohmann::json & get_mutable_underburn() { return underburn; }
        void set_underburn(nlohmann::json const & value) { this->underburn = value; }
    };

    using PulpitismElement = std::variant<std::vector<int64_t>, PulpitismClass, double>;

    class PyodermiaClass {
        public:
        PyodermiaClass() = default;
        virtual ~PyodermiaClass() = default;

        private:
        nlohmann::json aphoristically;
        nlohmann::json apophyllous;
        nlohmann::json cognize;
        nlohmann::json dermonosology;
        nlohmann::json gyppo;
        nlohmann::json ither;
        nlohmann::json juglandaceous;
        nlohmann::json litho;
        nlohmann::json macropterous;
        nlohmann::json photographer;
        nlohmann::json romancing;
        nlohmann::json rumness;
        nlohmann::json somniloquist;
        nlohmann::json stressfully;
        nlohmann::json tactically;
        nlohmann::json tracheophony;
        nlohmann::json unappositely;
        nlohmann::json unclothedly;
        nlohmann::json unimplied;
        nlohmann::json unsyncopated;

        public:
        nlohmann::json const & get_aphoristically() const { return aphoristically; }
        nlohmann::json & get_mutable_aphoristically() { return aphoristically; }
        void set_aphoristically(nlohmann::json const & value) { this->aphoristically = value; }

        nlohmann::json const & get_apophyllous() const { return apophyllous; }
        nlohmann::json & get_mutable_apophyllous() { return apophyllous; }
        void set_apophyllous(nlohmann::json const & value) { this->apophyllous = value; }

        nlohmann::json const & get_cognize() const { return cognize; }
        nlohmann::json & get_mutable_cognize() { return cognize; }
        void set_cognize(nlohmann::json const & value) { this->cognize = value; }

        nlohmann::json const & get_dermonosology() const { return dermonosology; }
        nlohmann::json & get_mutable_dermonosology() { return dermonosology; }
        void set_dermonosology(nlohmann::json const & value) { this->dermonosology = value; }

        nlohmann::json const & get_gyppo() const { return gyppo; }
        nlohmann::json & get_mutable_gyppo() { return gyppo; }
        void set_gyppo(nlohmann::json const & value) { this->gyppo = value; }

        nlohmann::json const & get_ither() const { return ither; }
        nlohmann::json & get_mutable_ither() { return ither; }
        void set_ither(nlohmann::json const & value) { this->ither = value; }

        nlohmann::json const & get_juglandaceous() const { return juglandaceous; }
        nlohmann::json & get_mutable_juglandaceous() { return juglandaceous; }
        void set_juglandaceous(nlohmann::json const & value) { this->juglandaceous = value; }

        nlohmann::json const & get_litho() const { return litho; }
        nlohmann::json & get_mutable_litho() { return litho; }
        void set_litho(nlohmann::json const & value) { this->litho = value; }

        nlohmann::json const & get_macropterous() const { return macropterous; }
        nlohmann::json & get_mutable_macropterous() { return macropterous; }
        void set_macropterous(nlohmann::json const & value) { this->macropterous = value; }

        nlohmann::json const & get_photographer() const { return photographer; }
        nlohmann::json & get_mutable_photographer() { return photographer; }
        void set_photographer(nlohmann::json const & value) { this->photographer = value; }

        nlohmann::json const & get_romancing() const { return romancing; }
        nlohmann::json & get_mutable_romancing() { return romancing; }
        void set_romancing(nlohmann::json const & value) { this->romancing = value; }

        nlohmann::json const & get_rumness() const { return rumness; }
        nlohmann::json & get_mutable_rumness() { return rumness; }
        void set_rumness(nlohmann::json const & value) { this->rumness = value; }

        nlohmann::json const & get_somniloquist() const { return somniloquist; }
        nlohmann::json & get_mutable_somniloquist() { return somniloquist; }
        void set_somniloquist(nlohmann::json const & value) { this->somniloquist = value; }

        nlohmann::json const & get_stressfully() const { return stressfully; }
        nlohmann::json & get_mutable_stressfully() { return stressfully; }
        void set_stressfully(nlohmann::json const & value) { this->stressfully = value; }

        nlohmann::json const & get_tactically() const { return tactically; }
        nlohmann::json & get_mutable_tactically() { return tactically; }
        void set_tactically(nlohmann::json const & value) { this->tactically = value; }

        nlohmann::json const & get_tracheophony() const { return tracheophony; }
        nlohmann::json & get_mutable_tracheophony() { return tracheophony; }
        void set_tracheophony(nlohmann::json const & value) { this->tracheophony = value; }

        nlohmann::json const & get_unappositely() const { return unappositely; }
        nlohmann::json & get_mutable_unappositely() { return unappositely; }
        void set_unappositely(nlohmann::json const & value) { this->unappositely = value; }

        nlohmann::json const & get_unclothedly() const { return unclothedly; }
        nlohmann::json & get_mutable_unclothedly() { return unclothedly; }
        void set_unclothedly(nlohmann::json const & value) { this->unclothedly = value; }

        nlohmann::json const & get_unimplied() const { return unimplied; }
        nlohmann::json & get_mutable_unimplied() { return unimplied; }
        void set_unimplied(nlohmann::json const & value) { this->unimplied = value; }

        nlohmann::json const & get_unsyncopated() const { return unsyncopated; }
        nlohmann::json & get_mutable_unsyncopated() { return unsyncopated; }
        void set_unsyncopated(nlohmann::json const & value) { this->unsyncopated = value; }
    };

    using PyodermiaElement = std::variant<PyodermiaClass, int64_t>;

    class QuebrachineClass {
        public:
        QuebrachineClass() = default;
        virtual ~QuebrachineClass() = default;

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

    using QuebrachineElement = std::optional<std::variant<bool, QuebrachineClass>>;

    using Querier = std::variant<bool, std::map<std::string, int64_t>>;

    using Rebarbative = std::variant<std::vector<int64_t>, bool, double>;

    class Reimagine {
        public:
        Reimagine() = default;
        virtual ~Reimagine() = default;

        private:
        nlohmann::json adducible;
        nlohmann::json anabolin;
        nlohmann::json brainy;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        nlohmann::json chrysamine;
        std::optional<std::string> disdiapason;
        nlohmann::json fluxweed;
        nlohmann::json glaucine;
        nlohmann::json grobianism;
        nlohmann::json hermo;
        nlohmann::json hieroglyphist;
        std::optional<bool> homocerc;
        nlohmann::json icteroid;
        nlohmann::json immortal;
        nlohmann::json impetulant;
        nlohmann::json irrigate;
        nlohmann::json myxedema;
        nlohmann::json nonbookish;
        nlohmann::json onyx;
        nlohmann::json repasser;
        nlohmann::json septomarginal;
        nlohmann::json subdie;
        nlohmann::json tibiometatarsal;
        nlohmann::json waltzlike;

        public:
        nlohmann::json const & get_adducible() const { return adducible; }
        nlohmann::json & get_mutable_adducible() { return adducible; }
        void set_adducible(nlohmann::json const & value) { this->adducible = value; }

        nlohmann::json const & get_anabolin() const { return anabolin; }
        nlohmann::json & get_mutable_anabolin() { return anabolin; }
        void set_anabolin(nlohmann::json const & value) { this->anabolin = value; }

        nlohmann::json const & get_brainy() const { return brainy; }
        nlohmann::json & get_mutable_brainy() { return brainy; }
        void set_brainy(nlohmann::json const & value) { this->brainy = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        nlohmann::json const & get_chrysamine() const { return chrysamine; }
        nlohmann::json & get_mutable_chrysamine() { return chrysamine; }
        void set_chrysamine(nlohmann::json const & value) { this->chrysamine = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_fluxweed() const { return fluxweed; }
        nlohmann::json & get_mutable_fluxweed() { return fluxweed; }
        void set_fluxweed(nlohmann::json const & value) { this->fluxweed = value; }

        nlohmann::json const & get_glaucine() const { return glaucine; }
        nlohmann::json & get_mutable_glaucine() { return glaucine; }
        void set_glaucine(nlohmann::json const & value) { this->glaucine = value; }

        nlohmann::json const & get_grobianism() const { return grobianism; }
        nlohmann::json & get_mutable_grobianism() { return grobianism; }
        void set_grobianism(nlohmann::json const & value) { this->grobianism = value; }

        nlohmann::json const & get_hermo() const { return hermo; }
        nlohmann::json & get_mutable_hermo() { return hermo; }
        void set_hermo(nlohmann::json const & value) { this->hermo = value; }

        nlohmann::json const & get_hieroglyphist() const { return hieroglyphist; }
        nlohmann::json & get_mutable_hieroglyphist() { return hieroglyphist; }
        void set_hieroglyphist(nlohmann::json const & value) { this->hieroglyphist = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_icteroid() const { return icteroid; }
        nlohmann::json & get_mutable_icteroid() { return icteroid; }
        void set_icteroid(nlohmann::json const & value) { this->icteroid = value; }

        nlohmann::json const & get_immortal() const { return immortal; }
        nlohmann::json & get_mutable_immortal() { return immortal; }
        void set_immortal(nlohmann::json const & value) { this->immortal = value; }

        nlohmann::json const & get_impetulant() const { return impetulant; }
        nlohmann::json & get_mutable_impetulant() { return impetulant; }
        void set_impetulant(nlohmann::json const & value) { this->impetulant = value; }

        nlohmann::json const & get_irrigate() const { return irrigate; }
        nlohmann::json & get_mutable_irrigate() { return irrigate; }
        void set_irrigate(nlohmann::json const & value) { this->irrigate = value; }

        nlohmann::json const & get_myxedema() const { return myxedema; }
        nlohmann::json & get_mutable_myxedema() { return myxedema; }
        void set_myxedema(nlohmann::json const & value) { this->myxedema = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_onyx() const { return onyx; }
        nlohmann::json & get_mutable_onyx() { return onyx; }
        void set_onyx(nlohmann::json const & value) { this->onyx = value; }

        nlohmann::json const & get_repasser() const { return repasser; }
        nlohmann::json & get_mutable_repasser() { return repasser; }
        void set_repasser(nlohmann::json const & value) { this->repasser = value; }

        nlohmann::json const & get_septomarginal() const { return septomarginal; }
        nlohmann::json & get_mutable_septomarginal() { return septomarginal; }
        void set_septomarginal(nlohmann::json const & value) { this->septomarginal = value; }

        nlohmann::json const & get_subdie() const { return subdie; }
        nlohmann::json & get_mutable_subdie() { return subdie; }
        void set_subdie(nlohmann::json const & value) { this->subdie = value; }

        nlohmann::json const & get_tibiometatarsal() const { return tibiometatarsal; }
        nlohmann::json & get_mutable_tibiometatarsal() { return tibiometatarsal; }
        void set_tibiometatarsal(nlohmann::json const & value) { this->tibiometatarsal = value; }

        nlohmann::json const & get_waltzlike() const { return waltzlike; }
        nlohmann::json & get_mutable_waltzlike() { return waltzlike; }
        void set_waltzlike(nlohmann::json const & value) { this->waltzlike = value; }
    };

    class Ressaut {
        public:
        Ressaut() = default;
        virtual ~Ressaut() = default;

        private:
        std::string apperceptive;
        std::string cuttoo;
        std::string douser;
        std::string drinkproof;
        std::string forementioned;
        std::string freesia;
        std::string genevieve;
        std::string hyperdiabolical;
        std::string hypocone;
        std::string irreverentially;
        std::string jumart;
        std::string mimosaceae;
        std::string mollicrush;
        std::string nedder;
        std::string retinasphalt;
        std::string sough;
        std::string steading;
        std::string theopaschitism;
        std::string undurableness;
        std::string unmingleable;

        public:
        std::string const & get_apperceptive() const { return apperceptive; }
        std::string & get_mutable_apperceptive() { return apperceptive; }
        void set_apperceptive(std::string const & value) { this->apperceptive = value; }

        std::string const & get_cuttoo() const { return cuttoo; }
        std::string & get_mutable_cuttoo() { return cuttoo; }
        void set_cuttoo(std::string const & value) { this->cuttoo = value; }

        std::string const & get_douser() const { return douser; }
        std::string & get_mutable_douser() { return douser; }
        void set_douser(std::string const & value) { this->douser = value; }

        std::string const & get_drinkproof() const { return drinkproof; }
        std::string & get_mutable_drinkproof() { return drinkproof; }
        void set_drinkproof(std::string const & value) { this->drinkproof = value; }

        std::string const & get_forementioned() const { return forementioned; }
        std::string & get_mutable_forementioned() { return forementioned; }
        void set_forementioned(std::string const & value) { this->forementioned = value; }

        std::string const & get_freesia() const { return freesia; }
        std::string & get_mutable_freesia() { return freesia; }
        void set_freesia(std::string const & value) { this->freesia = value; }

        std::string const & get_genevieve() const { return genevieve; }
        std::string & get_mutable_genevieve() { return genevieve; }
        void set_genevieve(std::string const & value) { this->genevieve = value; }

        std::string const & get_hyperdiabolical() const { return hyperdiabolical; }
        std::string & get_mutable_hyperdiabolical() { return hyperdiabolical; }
        void set_hyperdiabolical(std::string const & value) { this->hyperdiabolical = value; }

        std::string const & get_hypocone() const { return hypocone; }
        std::string & get_mutable_hypocone() { return hypocone; }
        void set_hypocone(std::string const & value) { this->hypocone = value; }

        std::string const & get_irreverentially() const { return irreverentially; }
        std::string & get_mutable_irreverentially() { return irreverentially; }
        void set_irreverentially(std::string const & value) { this->irreverentially = value; }

        std::string const & get_jumart() const { return jumart; }
        std::string & get_mutable_jumart() { return jumart; }
        void set_jumart(std::string const & value) { this->jumart = value; }

        std::string const & get_mimosaceae() const { return mimosaceae; }
        std::string & get_mutable_mimosaceae() { return mimosaceae; }
        void set_mimosaceae(std::string const & value) { this->mimosaceae = value; }

        std::string const & get_mollicrush() const { return mollicrush; }
        std::string & get_mutable_mollicrush() { return mollicrush; }
        void set_mollicrush(std::string const & value) { this->mollicrush = value; }

        std::string const & get_nedder() const { return nedder; }
        std::string & get_mutable_nedder() { return nedder; }
        void set_nedder(std::string const & value) { this->nedder = value; }

        std::string const & get_retinasphalt() const { return retinasphalt; }
        std::string & get_mutable_retinasphalt() { return retinasphalt; }
        void set_retinasphalt(std::string const & value) { this->retinasphalt = value; }

        std::string const & get_sough() const { return sough; }
        std::string & get_mutable_sough() { return sough; }
        void set_sough(std::string const & value) { this->sough = value; }

        std::string const & get_steading() const { return steading; }
        std::string & get_mutable_steading() { return steading; }
        void set_steading(std::string const & value) { this->steading = value; }

        std::string const & get_theopaschitism() const { return theopaschitism; }
        std::string & get_mutable_theopaschitism() { return theopaschitism; }
        void set_theopaschitism(std::string const & value) { this->theopaschitism = value; }

        std::string const & get_undurableness() const { return undurableness; }
        std::string & get_mutable_undurableness() { return undurableness; }
        void set_undurableness(std::string const & value) { this->undurableness = value; }

        std::string const & get_unmingleable() const { return unmingleable; }
        std::string & get_mutable_unmingleable() { return unmingleable; }
        void set_unmingleable(std::string const & value) { this->unmingleable = value; }
    };

    using Retrocervical = std::variant<std::vector<std::optional<int64_t>>, int64_t>;

    using Revert = std::variant<bool, std::string>;

    class RewriteClass {
        public:
        RewriteClass() = default;
        virtual ~RewriteClass() = default;

        private:
        nlohmann::json accountancy;
        nlohmann::json cacotrophic;
        nlohmann::json contest;
        nlohmann::json couthily;
        nlohmann::json falculate;
        nlohmann::json foreseize;
        nlohmann::json hyades;
        nlohmann::json lemnad;
        nlohmann::json monotheistically;
        nlohmann::json nonflying;
        nlohmann::json ptenoglossa;
        nlohmann::json repatch;
        nlohmann::json rodman;
        nlohmann::json strung;
        nlohmann::json titmal;
        nlohmann::json twalpennyworth;
        nlohmann::json unblamable;
        nlohmann::json vertical;
        nlohmann::json whiggification;
        nlohmann::json yardman;

        public:
        nlohmann::json const & get_accountancy() const { return accountancy; }
        nlohmann::json & get_mutable_accountancy() { return accountancy; }
        void set_accountancy(nlohmann::json const & value) { this->accountancy = value; }

        nlohmann::json const & get_cacotrophic() const { return cacotrophic; }
        nlohmann::json & get_mutable_cacotrophic() { return cacotrophic; }
        void set_cacotrophic(nlohmann::json const & value) { this->cacotrophic = value; }

        nlohmann::json const & get_contest() const { return contest; }
        nlohmann::json & get_mutable_contest() { return contest; }
        void set_contest(nlohmann::json const & value) { this->contest = value; }

        nlohmann::json const & get_couthily() const { return couthily; }
        nlohmann::json & get_mutable_couthily() { return couthily; }
        void set_couthily(nlohmann::json const & value) { this->couthily = value; }

        nlohmann::json const & get_falculate() const { return falculate; }
        nlohmann::json & get_mutable_falculate() { return falculate; }
        void set_falculate(nlohmann::json const & value) { this->falculate = value; }

        nlohmann::json const & get_foreseize() const { return foreseize; }
        nlohmann::json & get_mutable_foreseize() { return foreseize; }
        void set_foreseize(nlohmann::json const & value) { this->foreseize = value; }

        nlohmann::json const & get_hyades() const { return hyades; }
        nlohmann::json & get_mutable_hyades() { return hyades; }
        void set_hyades(nlohmann::json const & value) { this->hyades = value; }

        nlohmann::json const & get_lemnad() const { return lemnad; }
        nlohmann::json & get_mutable_lemnad() { return lemnad; }
        void set_lemnad(nlohmann::json const & value) { this->lemnad = value; }

        nlohmann::json const & get_monotheistically() const { return monotheistically; }
        nlohmann::json & get_mutable_monotheistically() { return monotheistically; }
        void set_monotheistically(nlohmann::json const & value) { this->monotheistically = value; }

        nlohmann::json const & get_nonflying() const { return nonflying; }
        nlohmann::json & get_mutable_nonflying() { return nonflying; }
        void set_nonflying(nlohmann::json const & value) { this->nonflying = value; }

        nlohmann::json const & get_ptenoglossa() const { return ptenoglossa; }
        nlohmann::json & get_mutable_ptenoglossa() { return ptenoglossa; }
        void set_ptenoglossa(nlohmann::json const & value) { this->ptenoglossa = value; }

        nlohmann::json const & get_repatch() const { return repatch; }
        nlohmann::json & get_mutable_repatch() { return repatch; }
        void set_repatch(nlohmann::json const & value) { this->repatch = value; }

        nlohmann::json const & get_rodman() const { return rodman; }
        nlohmann::json & get_mutable_rodman() { return rodman; }
        void set_rodman(nlohmann::json const & value) { this->rodman = value; }

        nlohmann::json const & get_strung() const { return strung; }
        nlohmann::json & get_mutable_strung() { return strung; }
        void set_strung(nlohmann::json const & value) { this->strung = value; }

        nlohmann::json const & get_titmal() const { return titmal; }
        nlohmann::json & get_mutable_titmal() { return titmal; }
        void set_titmal(nlohmann::json const & value) { this->titmal = value; }

        nlohmann::json const & get_twalpennyworth() const { return twalpennyworth; }
        nlohmann::json & get_mutable_twalpennyworth() { return twalpennyworth; }
        void set_twalpennyworth(nlohmann::json const & value) { this->twalpennyworth = value; }

        nlohmann::json const & get_unblamable() const { return unblamable; }
        nlohmann::json & get_mutable_unblamable() { return unblamable; }
        void set_unblamable(nlohmann::json const & value) { this->unblamable = value; }

        nlohmann::json const & get_vertical() const { return vertical; }
        nlohmann::json & get_mutable_vertical() { return vertical; }
        void set_vertical(nlohmann::json const & value) { this->vertical = value; }

        nlohmann::json const & get_whiggification() const { return whiggification; }
        nlohmann::json & get_mutable_whiggification() { return whiggification; }
        void set_whiggification(nlohmann::json const & value) { this->whiggification = value; }

        nlohmann::json const & get_yardman() const { return yardman; }
        nlohmann::json & get_mutable_yardman() { return yardman; }
        void set_yardman(nlohmann::json const & value) { this->yardman = value; }
    };

    using RewriteElement = std::variant<std::vector<nlohmann::json>, RewriteClass, double>;

    using Saccoderm = std::optional<std::variant<std::vector<int64_t>, std::string>>;

    class SantirClass {
        public:
        SantirClass() = default;
        virtual ~SantirClass() = default;

        private:
        nlohmann::json admiredly;
        nlohmann::json demicaponier;
        nlohmann::json epitympanic;
        nlohmann::json investitor;
        nlohmann::json lupiform;
        nlohmann::json monoflagellate;
        nlohmann::json paleoethnic;
        nlohmann::json prediscountable;
        nlohmann::json rhetoricals;
        nlohmann::json roomth;
        nlohmann::json saccharose;
        nlohmann::json septonasal;
        nlohmann::json serpenticide;
        nlohmann::json setarious;
        nlohmann::json spaework;
        nlohmann::json stylite;
        nlohmann::json suessiones;
        nlohmann::json timelily;
        nlohmann::json unprofaned;
        nlohmann::json vorticular;

        public:
        nlohmann::json const & get_admiredly() const { return admiredly; }
        nlohmann::json & get_mutable_admiredly() { return admiredly; }
        void set_admiredly(nlohmann::json const & value) { this->admiredly = value; }

        nlohmann::json const & get_demicaponier() const { return demicaponier; }
        nlohmann::json & get_mutable_demicaponier() { return demicaponier; }
        void set_demicaponier(nlohmann::json const & value) { this->demicaponier = value; }

        nlohmann::json const & get_epitympanic() const { return epitympanic; }
        nlohmann::json & get_mutable_epitympanic() { return epitympanic; }
        void set_epitympanic(nlohmann::json const & value) { this->epitympanic = value; }

        nlohmann::json const & get_investitor() const { return investitor; }
        nlohmann::json & get_mutable_investitor() { return investitor; }
        void set_investitor(nlohmann::json const & value) { this->investitor = value; }

        nlohmann::json const & get_lupiform() const { return lupiform; }
        nlohmann::json & get_mutable_lupiform() { return lupiform; }
        void set_lupiform(nlohmann::json const & value) { this->lupiform = value; }

        nlohmann::json const & get_monoflagellate() const { return monoflagellate; }
        nlohmann::json & get_mutable_monoflagellate() { return monoflagellate; }
        void set_monoflagellate(nlohmann::json const & value) { this->monoflagellate = value; }

        nlohmann::json const & get_paleoethnic() const { return paleoethnic; }
        nlohmann::json & get_mutable_paleoethnic() { return paleoethnic; }
        void set_paleoethnic(nlohmann::json const & value) { this->paleoethnic = value; }

        nlohmann::json const & get_prediscountable() const { return prediscountable; }
        nlohmann::json & get_mutable_prediscountable() { return prediscountable; }
        void set_prediscountable(nlohmann::json const & value) { this->prediscountable = value; }

        nlohmann::json const & get_rhetoricals() const { return rhetoricals; }
        nlohmann::json & get_mutable_rhetoricals() { return rhetoricals; }
        void set_rhetoricals(nlohmann::json const & value) { this->rhetoricals = value; }

        nlohmann::json const & get_roomth() const { return roomth; }
        nlohmann::json & get_mutable_roomth() { return roomth; }
        void set_roomth(nlohmann::json const & value) { this->roomth = value; }

        nlohmann::json const & get_saccharose() const { return saccharose; }
        nlohmann::json & get_mutable_saccharose() { return saccharose; }
        void set_saccharose(nlohmann::json const & value) { this->saccharose = value; }

        nlohmann::json const & get_septonasal() const { return septonasal; }
        nlohmann::json & get_mutable_septonasal() { return septonasal; }
        void set_septonasal(nlohmann::json const & value) { this->septonasal = value; }

        nlohmann::json const & get_serpenticide() const { return serpenticide; }
        nlohmann::json & get_mutable_serpenticide() { return serpenticide; }
        void set_serpenticide(nlohmann::json const & value) { this->serpenticide = value; }

        nlohmann::json const & get_setarious() const { return setarious; }
        nlohmann::json & get_mutable_setarious() { return setarious; }
        void set_setarious(nlohmann::json const & value) { this->setarious = value; }

        nlohmann::json const & get_spaework() const { return spaework; }
        nlohmann::json & get_mutable_spaework() { return spaework; }
        void set_spaework(nlohmann::json const & value) { this->spaework = value; }

        nlohmann::json const & get_stylite() const { return stylite; }
        nlohmann::json & get_mutable_stylite() { return stylite; }
        void set_stylite(nlohmann::json const & value) { this->stylite = value; }

        nlohmann::json const & get_suessiones() const { return suessiones; }
        nlohmann::json & get_mutable_suessiones() { return suessiones; }
        void set_suessiones(nlohmann::json const & value) { this->suessiones = value; }

        nlohmann::json const & get_timelily() const { return timelily; }
        nlohmann::json & get_mutable_timelily() { return timelily; }
        void set_timelily(nlohmann::json const & value) { this->timelily = value; }

        nlohmann::json const & get_unprofaned() const { return unprofaned; }
        nlohmann::json & get_mutable_unprofaned() { return unprofaned; }
        void set_unprofaned(nlohmann::json const & value) { this->unprofaned = value; }

        nlohmann::json const & get_vorticular() const { return vorticular; }
        nlohmann::json & get_mutable_vorticular() { return vorticular; }
        void set_vorticular(nlohmann::json const & value) { this->vorticular = value; }
    };

    using SantirElement = std::variant<SantirClass, double>;

    using Saprophilous = std::optional<std::variant<std::map<std::string, int64_t>, std::string>>;

    class SaxtenClass {
        public:
        SaxtenClass() = default;
        virtual ~SaxtenClass() = default;

        private:
        nlohmann::json algarrobilla;
        nlohmann::json bowgrace;
        std::optional<double> catharticalness;
        nlohmann::json centaurid;
        std::optional<int64_t> chirotherium;
        std::optional<std::string> disdiapason;
        nlohmann::json flix;
        nlohmann::json germanely;
        std::optional<bool> homocerc;
        nlohmann::json inhume;
        nlohmann::json lepidote;
        nlohmann::json megalochirous;
        nlohmann::json ninepenny;
        nlohmann::json nonbookish;
        nlohmann::json nondeist;
        nlohmann::json nymphaeaceous;
        nlohmann::json parietofrontal;
        nlohmann::json sancyite;
        nlohmann::json subjectivist;
        nlohmann::json tibiad;
        nlohmann::json transonic;
        nlohmann::json tripetalous;
        nlohmann::json trunchman;
        nlohmann::json urger;
        nlohmann::json withdrawnness;

        public:
        nlohmann::json const & get_algarrobilla() const { return algarrobilla; }
        nlohmann::json & get_mutable_algarrobilla() { return algarrobilla; }
        void set_algarrobilla(nlohmann::json const & value) { this->algarrobilla = value; }

        nlohmann::json const & get_bowgrace() const { return bowgrace; }
        nlohmann::json & get_mutable_bowgrace() { return bowgrace; }
        void set_bowgrace(nlohmann::json const & value) { this->bowgrace = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        nlohmann::json const & get_centaurid() const { return centaurid; }
        nlohmann::json & get_mutable_centaurid() { return centaurid; }
        void set_centaurid(nlohmann::json const & value) { this->centaurid = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_flix() const { return flix; }
        nlohmann::json & get_mutable_flix() { return flix; }
        void set_flix(nlohmann::json const & value) { this->flix = value; }

        nlohmann::json const & get_germanely() const { return germanely; }
        nlohmann::json & get_mutable_germanely() { return germanely; }
        void set_germanely(nlohmann::json const & value) { this->germanely = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_inhume() const { return inhume; }
        nlohmann::json & get_mutable_inhume() { return inhume; }
        void set_inhume(nlohmann::json const & value) { this->inhume = value; }

        nlohmann::json const & get_lepidote() const { return lepidote; }
        nlohmann::json & get_mutable_lepidote() { return lepidote; }
        void set_lepidote(nlohmann::json const & value) { this->lepidote = value; }

        nlohmann::json const & get_megalochirous() const { return megalochirous; }
        nlohmann::json & get_mutable_megalochirous() { return megalochirous; }
        void set_megalochirous(nlohmann::json const & value) { this->megalochirous = value; }

        nlohmann::json const & get_ninepenny() const { return ninepenny; }
        nlohmann::json & get_mutable_ninepenny() { return ninepenny; }
        void set_ninepenny(nlohmann::json const & value) { this->ninepenny = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_nondeist() const { return nondeist; }
        nlohmann::json & get_mutable_nondeist() { return nondeist; }
        void set_nondeist(nlohmann::json const & value) { this->nondeist = value; }

        nlohmann::json const & get_nymphaeaceous() const { return nymphaeaceous; }
        nlohmann::json & get_mutable_nymphaeaceous() { return nymphaeaceous; }
        void set_nymphaeaceous(nlohmann::json const & value) { this->nymphaeaceous = value; }

        nlohmann::json const & get_parietofrontal() const { return parietofrontal; }
        nlohmann::json & get_mutable_parietofrontal() { return parietofrontal; }
        void set_parietofrontal(nlohmann::json const & value) { this->parietofrontal = value; }

        nlohmann::json const & get_sancyite() const { return sancyite; }
        nlohmann::json & get_mutable_sancyite() { return sancyite; }
        void set_sancyite(nlohmann::json const & value) { this->sancyite = value; }

        nlohmann::json const & get_subjectivist() const { return subjectivist; }
        nlohmann::json & get_mutable_subjectivist() { return subjectivist; }
        void set_subjectivist(nlohmann::json const & value) { this->subjectivist = value; }

        nlohmann::json const & get_tibiad() const { return tibiad; }
        nlohmann::json & get_mutable_tibiad() { return tibiad; }
        void set_tibiad(nlohmann::json const & value) { this->tibiad = value; }

        nlohmann::json const & get_transonic() const { return transonic; }
        nlohmann::json & get_mutable_transonic() { return transonic; }
        void set_transonic(nlohmann::json const & value) { this->transonic = value; }

        nlohmann::json const & get_tripetalous() const { return tripetalous; }
        nlohmann::json & get_mutable_tripetalous() { return tripetalous; }
        void set_tripetalous(nlohmann::json const & value) { this->tripetalous = value; }

        nlohmann::json const & get_trunchman() const { return trunchman; }
        nlohmann::json & get_mutable_trunchman() { return trunchman; }
        void set_trunchman(nlohmann::json const & value) { this->trunchman = value; }

        nlohmann::json const & get_urger() const { return urger; }
        nlohmann::json & get_mutable_urger() { return urger; }
        void set_urger(nlohmann::json const & value) { this->urger = value; }

        nlohmann::json const & get_withdrawnness() const { return withdrawnness; }
        nlohmann::json & get_mutable_withdrawnness() { return withdrawnness; }
        void set_withdrawnness(nlohmann::json const & value) { this->withdrawnness = value; }
    };

    using SaxtenElement = std::variant<SaxtenClass, std::string>;

    class Scatty {
        public:
        Scatty() = default;
        virtual ~Scatty() = default;

        private:
        nlohmann::json aeriferous;
        nlohmann::json antical;
        nlohmann::json antighostism;
        nlohmann::json arcanum;
        nlohmann::json autotrophy;
        nlohmann::json baronial;
        nlohmann::json caffeine;
        nlohmann::json gorgoniacean;
        nlohmann::json heroical;
        nlohmann::json hydropical;
        nlohmann::json mechanology;
        nlohmann::json musicopoetic;
        nlohmann::json officiality;
        nlohmann::json oftentimes;
        nlohmann::json ophthalmotonometer;
        nlohmann::json reflectively;
        nlohmann::json springer;
        nlohmann::json tabasco;
        nlohmann::json teleianthous;
        nlohmann::json uncombated;

        public:
        nlohmann::json const & get_aeriferous() const { return aeriferous; }
        nlohmann::json & get_mutable_aeriferous() { return aeriferous; }
        void set_aeriferous(nlohmann::json const & value) { this->aeriferous = value; }

        nlohmann::json const & get_antical() const { return antical; }
        nlohmann::json & get_mutable_antical() { return antical; }
        void set_antical(nlohmann::json const & value) { this->antical = value; }

        nlohmann::json const & get_antighostism() const { return antighostism; }
        nlohmann::json & get_mutable_antighostism() { return antighostism; }
        void set_antighostism(nlohmann::json const & value) { this->antighostism = value; }

        nlohmann::json const & get_arcanum() const { return arcanum; }
        nlohmann::json & get_mutable_arcanum() { return arcanum; }
        void set_arcanum(nlohmann::json const & value) { this->arcanum = value; }

        nlohmann::json const & get_autotrophy() const { return autotrophy; }
        nlohmann::json & get_mutable_autotrophy() { return autotrophy; }
        void set_autotrophy(nlohmann::json const & value) { this->autotrophy = value; }

        nlohmann::json const & get_baronial() const { return baronial; }
        nlohmann::json & get_mutable_baronial() { return baronial; }
        void set_baronial(nlohmann::json const & value) { this->baronial = value; }

        nlohmann::json const & get_caffeine() const { return caffeine; }
        nlohmann::json & get_mutable_caffeine() { return caffeine; }
        void set_caffeine(nlohmann::json const & value) { this->caffeine = value; }

        nlohmann::json const & get_gorgoniacean() const { return gorgoniacean; }
        nlohmann::json & get_mutable_gorgoniacean() { return gorgoniacean; }
        void set_gorgoniacean(nlohmann::json const & value) { this->gorgoniacean = value; }

        nlohmann::json const & get_heroical() const { return heroical; }
        nlohmann::json & get_mutable_heroical() { return heroical; }
        void set_heroical(nlohmann::json const & value) { this->heroical = value; }

        nlohmann::json const & get_hydropical() const { return hydropical; }
        nlohmann::json & get_mutable_hydropical() { return hydropical; }
        void set_hydropical(nlohmann::json const & value) { this->hydropical = value; }

        nlohmann::json const & get_mechanology() const { return mechanology; }
        nlohmann::json & get_mutable_mechanology() { return mechanology; }
        void set_mechanology(nlohmann::json const & value) { this->mechanology = value; }

        nlohmann::json const & get_musicopoetic() const { return musicopoetic; }
        nlohmann::json & get_mutable_musicopoetic() { return musicopoetic; }
        void set_musicopoetic(nlohmann::json const & value) { this->musicopoetic = value; }

        nlohmann::json const & get_officiality() const { return officiality; }
        nlohmann::json & get_mutable_officiality() { return officiality; }
        void set_officiality(nlohmann::json const & value) { this->officiality = value; }

        nlohmann::json const & get_oftentimes() const { return oftentimes; }
        nlohmann::json & get_mutable_oftentimes() { return oftentimes; }
        void set_oftentimes(nlohmann::json const & value) { this->oftentimes = value; }

        nlohmann::json const & get_ophthalmotonometer() const { return ophthalmotonometer; }
        nlohmann::json & get_mutable_ophthalmotonometer() { return ophthalmotonometer; }
        void set_ophthalmotonometer(nlohmann::json const & value) { this->ophthalmotonometer = value; }

        nlohmann::json const & get_reflectively() const { return reflectively; }
        nlohmann::json & get_mutable_reflectively() { return reflectively; }
        void set_reflectively(nlohmann::json const & value) { this->reflectively = value; }

        nlohmann::json const & get_springer() const { return springer; }
        nlohmann::json & get_mutable_springer() { return springer; }
        void set_springer(nlohmann::json const & value) { this->springer = value; }

        nlohmann::json const & get_tabasco() const { return tabasco; }
        nlohmann::json & get_mutable_tabasco() { return tabasco; }
        void set_tabasco(nlohmann::json const & value) { this->tabasco = value; }

        nlohmann::json const & get_teleianthous() const { return teleianthous; }
        nlohmann::json & get_mutable_teleianthous() { return teleianthous; }
        void set_teleianthous(nlohmann::json const & value) { this->teleianthous = value; }

        nlohmann::json const & get_uncombated() const { return uncombated; }
        nlohmann::json & get_mutable_uncombated() { return uncombated; }
        void set_uncombated(nlohmann::json const & value) { this->uncombated = value; }
    };

    using Scoffer = std::optional<std::variant<std::vector<nlohmann::json>, std::map<std::string, int64_t>>>;

    using Scrampum = std::optional<std::variant<std::vector<int64_t>, bool>>;

    using Serpentinic = std::variant<std::vector<int64_t>, double>;

    using Shadowable = std::variant<std::vector<std::optional<int64_t>>, bool>;

    class SisteringClass {
        public:
        SisteringClass() = default;
        virtual ~SisteringClass() = default;

        private:
        nlohmann::json amphicarpic;
        nlohmann::json chianti;
        nlohmann::json frigorific;
        nlohmann::json haplomi;
        nlohmann::json hyperkinesis;
        nlohmann::json laudable;
        nlohmann::json madwoman;
        nlohmann::json maimedly;
        nlohmann::json micropterygidae;
        nlohmann::json microrhabdus;
        nlohmann::json nondense;
        nlohmann::json phlebemphraxis;
        nlohmann::json redsear;
        nlohmann::json schismatical;
        nlohmann::json tartryl;
        nlohmann::json unabhorred;
        nlohmann::json undeliberateness;
        nlohmann::json unmixable;
        nlohmann::json untruckling;
        nlohmann::json vineal;

        public:
        nlohmann::json const & get_amphicarpic() const { return amphicarpic; }
        nlohmann::json & get_mutable_amphicarpic() { return amphicarpic; }
        void set_amphicarpic(nlohmann::json const & value) { this->amphicarpic = value; }

        nlohmann::json const & get_chianti() const { return chianti; }
        nlohmann::json & get_mutable_chianti() { return chianti; }
        void set_chianti(nlohmann::json const & value) { this->chianti = value; }

        nlohmann::json const & get_frigorific() const { return frigorific; }
        nlohmann::json & get_mutable_frigorific() { return frigorific; }
        void set_frigorific(nlohmann::json const & value) { this->frigorific = value; }

        nlohmann::json const & get_haplomi() const { return haplomi; }
        nlohmann::json & get_mutable_haplomi() { return haplomi; }
        void set_haplomi(nlohmann::json const & value) { this->haplomi = value; }

        nlohmann::json const & get_hyperkinesis() const { return hyperkinesis; }
        nlohmann::json & get_mutable_hyperkinesis() { return hyperkinesis; }
        void set_hyperkinesis(nlohmann::json const & value) { this->hyperkinesis = value; }

        nlohmann::json const & get_laudable() const { return laudable; }
        nlohmann::json & get_mutable_laudable() { return laudable; }
        void set_laudable(nlohmann::json const & value) { this->laudable = value; }

        nlohmann::json const & get_madwoman() const { return madwoman; }
        nlohmann::json & get_mutable_madwoman() { return madwoman; }
        void set_madwoman(nlohmann::json const & value) { this->madwoman = value; }

        nlohmann::json const & get_maimedly() const { return maimedly; }
        nlohmann::json & get_mutable_maimedly() { return maimedly; }
        void set_maimedly(nlohmann::json const & value) { this->maimedly = value; }

        nlohmann::json const & get_micropterygidae() const { return micropterygidae; }
        nlohmann::json & get_mutable_micropterygidae() { return micropterygidae; }
        void set_micropterygidae(nlohmann::json const & value) { this->micropterygidae = value; }

        nlohmann::json const & get_microrhabdus() const { return microrhabdus; }
        nlohmann::json & get_mutable_microrhabdus() { return microrhabdus; }
        void set_microrhabdus(nlohmann::json const & value) { this->microrhabdus = value; }

        nlohmann::json const & get_nondense() const { return nondense; }
        nlohmann::json & get_mutable_nondense() { return nondense; }
        void set_nondense(nlohmann::json const & value) { this->nondense = value; }

        nlohmann::json const & get_phlebemphraxis() const { return phlebemphraxis; }
        nlohmann::json & get_mutable_phlebemphraxis() { return phlebemphraxis; }
        void set_phlebemphraxis(nlohmann::json const & value) { this->phlebemphraxis = value; }

        nlohmann::json const & get_redsear() const { return redsear; }
        nlohmann::json & get_mutable_redsear() { return redsear; }
        void set_redsear(nlohmann::json const & value) { this->redsear = value; }

        nlohmann::json const & get_schismatical() const { return schismatical; }
        nlohmann::json & get_mutable_schismatical() { return schismatical; }
        void set_schismatical(nlohmann::json const & value) { this->schismatical = value; }

        nlohmann::json const & get_tartryl() const { return tartryl; }
        nlohmann::json & get_mutable_tartryl() { return tartryl; }
        void set_tartryl(nlohmann::json const & value) { this->tartryl = value; }

        nlohmann::json const & get_unabhorred() const { return unabhorred; }
        nlohmann::json & get_mutable_unabhorred() { return unabhorred; }
        void set_unabhorred(nlohmann::json const & value) { this->unabhorred = value; }

        nlohmann::json const & get_undeliberateness() const { return undeliberateness; }
        nlohmann::json & get_mutable_undeliberateness() { return undeliberateness; }
        void set_undeliberateness(nlohmann::json const & value) { this->undeliberateness = value; }

        nlohmann::json const & get_unmixable() const { return unmixable; }
        nlohmann::json & get_mutable_unmixable() { return unmixable; }
        void set_unmixable(nlohmann::json const & value) { this->unmixable = value; }

        nlohmann::json const & get_untruckling() const { return untruckling; }
        nlohmann::json & get_mutable_untruckling() { return untruckling; }
        void set_untruckling(nlohmann::json const & value) { this->untruckling = value; }

        nlohmann::json const & get_vineal() const { return vineal; }
        nlohmann::json & get_mutable_vineal() { return vineal; }
        void set_vineal(nlohmann::json const & value) { this->vineal = value; }
    };

    using SisteringElement = std::variant<std::vector<nlohmann::json>, SisteringClass, int64_t>;

    class Staghunting {
        public:
        Staghunting() = default;
        virtual ~Staghunting() = default;

        private:
        std::optional<int64_t> calorimetric;
        std::optional<int64_t> canid;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> ditriglyphic;
        std::optional<int64_t> floriferousness;
        std::optional<int64_t> gamelike;
        std::optional<int64_t> grig;
        std::optional<bool> homocerc;
        std::optional<int64_t> interloan;
        std::optional<int64_t> lithotomy;
        std::optional<int64_t> loric;
        std::optional<int64_t> membranocoriaceous;
        std::optional<int64_t> membranogenic;
        nlohmann::json nonbookish;
        std::optional<int64_t> overtrump;
        std::optional<int64_t> scotino;
        std::optional<int64_t> seasonable;
        std::optional<int64_t> sephen;
        std::optional<int64_t> stigmarioid;
        std::optional<int64_t> tired;
        std::optional<int64_t> trifid;
        std::optional<int64_t> undefeatedly;
        std::optional<int64_t> ungirlish;

        public:
        std::optional<int64_t> const & get_calorimetric() const { return calorimetric; }
        std::optional<int64_t> & get_mutable_calorimetric() { return calorimetric; }
        void set_calorimetric(std::optional<int64_t> const & value) { this->calorimetric = value; }

        std::optional<int64_t> const & get_canid() const { return canid; }
        std::optional<int64_t> & get_mutable_canid() { return canid; }
        void set_canid(std::optional<int64_t> const & value) { this->canid = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_ditriglyphic() const { return ditriglyphic; }
        std::optional<int64_t> & get_mutable_ditriglyphic() { return ditriglyphic; }
        void set_ditriglyphic(std::optional<int64_t> const & value) { this->ditriglyphic = value; }

        std::optional<int64_t> const & get_floriferousness() const { return floriferousness; }
        std::optional<int64_t> & get_mutable_floriferousness() { return floriferousness; }
        void set_floriferousness(std::optional<int64_t> const & value) { this->floriferousness = value; }

        std::optional<int64_t> const & get_gamelike() const { return gamelike; }
        std::optional<int64_t> & get_mutable_gamelike() { return gamelike; }
        void set_gamelike(std::optional<int64_t> const & value) { this->gamelike = value; }

        std::optional<int64_t> const & get_grig() const { return grig; }
        std::optional<int64_t> & get_mutable_grig() { return grig; }
        void set_grig(std::optional<int64_t> const & value) { this->grig = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_interloan() const { return interloan; }
        std::optional<int64_t> & get_mutable_interloan() { return interloan; }
        void set_interloan(std::optional<int64_t> const & value) { this->interloan = value; }

        std::optional<int64_t> const & get_lithotomy() const { return lithotomy; }
        std::optional<int64_t> & get_mutable_lithotomy() { return lithotomy; }
        void set_lithotomy(std::optional<int64_t> const & value) { this->lithotomy = value; }

        std::optional<int64_t> const & get_loric() const { return loric; }
        std::optional<int64_t> & get_mutable_loric() { return loric; }
        void set_loric(std::optional<int64_t> const & value) { this->loric = value; }

        std::optional<int64_t> const & get_membranocoriaceous() const { return membranocoriaceous; }
        std::optional<int64_t> & get_mutable_membranocoriaceous() { return membranocoriaceous; }
        void set_membranocoriaceous(std::optional<int64_t> const & value) { this->membranocoriaceous = value; }

        std::optional<int64_t> const & get_membranogenic() const { return membranogenic; }
        std::optional<int64_t> & get_mutable_membranogenic() { return membranogenic; }
        void set_membranogenic(std::optional<int64_t> const & value) { this->membranogenic = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_overtrump() const { return overtrump; }
        std::optional<int64_t> & get_mutable_overtrump() { return overtrump; }
        void set_overtrump(std::optional<int64_t> const & value) { this->overtrump = value; }

        std::optional<int64_t> const & get_scotino() const { return scotino; }
        std::optional<int64_t> & get_mutable_scotino() { return scotino; }
        void set_scotino(std::optional<int64_t> const & value) { this->scotino = value; }

        std::optional<int64_t> const & get_seasonable() const { return seasonable; }
        std::optional<int64_t> & get_mutable_seasonable() { return seasonable; }
        void set_seasonable(std::optional<int64_t> const & value) { this->seasonable = value; }

        std::optional<int64_t> const & get_sephen() const { return sephen; }
        std::optional<int64_t> & get_mutable_sephen() { return sephen; }
        void set_sephen(std::optional<int64_t> const & value) { this->sephen = value; }

        std::optional<int64_t> const & get_stigmarioid() const { return stigmarioid; }
        std::optional<int64_t> & get_mutable_stigmarioid() { return stigmarioid; }
        void set_stigmarioid(std::optional<int64_t> const & value) { this->stigmarioid = value; }

        std::optional<int64_t> const & get_tired() const { return tired; }
        std::optional<int64_t> & get_mutable_tired() { return tired; }
        void set_tired(std::optional<int64_t> const & value) { this->tired = value; }

        std::optional<int64_t> const & get_trifid() const { return trifid; }
        std::optional<int64_t> & get_mutable_trifid() { return trifid; }
        void set_trifid(std::optional<int64_t> const & value) { this->trifid = value; }

        std::optional<int64_t> const & get_undefeatedly() const { return undefeatedly; }
        std::optional<int64_t> & get_mutable_undefeatedly() { return undefeatedly; }
        void set_undefeatedly(std::optional<int64_t> const & value) { this->undefeatedly = value; }

        std::optional<int64_t> const & get_ungirlish() const { return ungirlish; }
        std::optional<int64_t> & get_mutable_ungirlish() { return ungirlish; }
        void set_ungirlish(std::optional<int64_t> const & value) { this->ungirlish = value; }
    };

    using Stagmometer = std::variant<std::vector<std::optional<int64_t>>, std::string>;

    using Stimulability = std::variant<bool, int64_t, std::map<std::string, int64_t>>;

    using Strangleable = std::variant<std::vector<nlohmann::json>, double>;

    class StrenuosityClass {
        public:
        StrenuosityClass() = default;
        virtual ~StrenuosityClass() = default;

        private:
        std::optional<int64_t> bliss;
        std::optional<int64_t> buccate;
        std::optional<int64_t> bulletproof;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> crumblingness;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> engagedly;
        std::optional<int64_t> fightable;
        std::optional<int64_t> hoariness;
        std::optional<bool> homocerc;
        std::optional<int64_t> hypopodium;
        std::optional<int64_t> luxurist;
        std::optional<int64_t> mechanician;
        nlohmann::json nonbookish;
        std::optional<int64_t> onopordon;
        std::optional<int64_t> podgily;
        std::optional<int64_t> reformableness;
        std::optional<int64_t> scatterbrains;
        std::optional<int64_t> seminuria;
        std::optional<int64_t> sodomite;
        std::optional<int64_t> tramp;
        std::optional<int64_t> undueness;
        std::optional<int64_t> worthily;
        std::optional<int64_t> yankeeist;

        public:
        std::optional<int64_t> const & get_bliss() const { return bliss; }
        std::optional<int64_t> & get_mutable_bliss() { return bliss; }
        void set_bliss(std::optional<int64_t> const & value) { this->bliss = value; }

        std::optional<int64_t> const & get_buccate() const { return buccate; }
        std::optional<int64_t> & get_mutable_buccate() { return buccate; }
        void set_buccate(std::optional<int64_t> const & value) { this->buccate = value; }

        std::optional<int64_t> const & get_bulletproof() const { return bulletproof; }
        std::optional<int64_t> & get_mutable_bulletproof() { return bulletproof; }
        void set_bulletproof(std::optional<int64_t> const & value) { this->bulletproof = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_crumblingness() const { return crumblingness; }
        std::optional<int64_t> & get_mutable_crumblingness() { return crumblingness; }
        void set_crumblingness(std::optional<int64_t> const & value) { this->crumblingness = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_engagedly() const { return engagedly; }
        std::optional<int64_t> & get_mutable_engagedly() { return engagedly; }
        void set_engagedly(std::optional<int64_t> const & value) { this->engagedly = value; }

        std::optional<int64_t> const & get_fightable() const { return fightable; }
        std::optional<int64_t> & get_mutable_fightable() { return fightable; }
        void set_fightable(std::optional<int64_t> const & value) { this->fightable = value; }

        std::optional<int64_t> const & get_hoariness() const { return hoariness; }
        std::optional<int64_t> & get_mutable_hoariness() { return hoariness; }
        void set_hoariness(std::optional<int64_t> const & value) { this->hoariness = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_hypopodium() const { return hypopodium; }
        std::optional<int64_t> & get_mutable_hypopodium() { return hypopodium; }
        void set_hypopodium(std::optional<int64_t> const & value) { this->hypopodium = value; }

        std::optional<int64_t> const & get_luxurist() const { return luxurist; }
        std::optional<int64_t> & get_mutable_luxurist() { return luxurist; }
        void set_luxurist(std::optional<int64_t> const & value) { this->luxurist = value; }

        std::optional<int64_t> const & get_mechanician() const { return mechanician; }
        std::optional<int64_t> & get_mutable_mechanician() { return mechanician; }
        void set_mechanician(std::optional<int64_t> const & value) { this->mechanician = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_onopordon() const { return onopordon; }
        std::optional<int64_t> & get_mutable_onopordon() { return onopordon; }
        void set_onopordon(std::optional<int64_t> const & value) { this->onopordon = value; }

        std::optional<int64_t> const & get_podgily() const { return podgily; }
        std::optional<int64_t> & get_mutable_podgily() { return podgily; }
        void set_podgily(std::optional<int64_t> const & value) { this->podgily = value; }

        std::optional<int64_t> const & get_reformableness() const { return reformableness; }
        std::optional<int64_t> & get_mutable_reformableness() { return reformableness; }
        void set_reformableness(std::optional<int64_t> const & value) { this->reformableness = value; }

        std::optional<int64_t> const & get_scatterbrains() const { return scatterbrains; }
        std::optional<int64_t> & get_mutable_scatterbrains() { return scatterbrains; }
        void set_scatterbrains(std::optional<int64_t> const & value) { this->scatterbrains = value; }

        std::optional<int64_t> const & get_seminuria() const { return seminuria; }
        std::optional<int64_t> & get_mutable_seminuria() { return seminuria; }
        void set_seminuria(std::optional<int64_t> const & value) { this->seminuria = value; }

        std::optional<int64_t> const & get_sodomite() const { return sodomite; }
        std::optional<int64_t> & get_mutable_sodomite() { return sodomite; }
        void set_sodomite(std::optional<int64_t> const & value) { this->sodomite = value; }

        std::optional<int64_t> const & get_tramp() const { return tramp; }
        std::optional<int64_t> & get_mutable_tramp() { return tramp; }
        void set_tramp(std::optional<int64_t> const & value) { this->tramp = value; }

        std::optional<int64_t> const & get_undueness() const { return undueness; }
        std::optional<int64_t> & get_mutable_undueness() { return undueness; }
        void set_undueness(std::optional<int64_t> const & value) { this->undueness = value; }

        std::optional<int64_t> const & get_worthily() const { return worthily; }
        std::optional<int64_t> & get_mutable_worthily() { return worthily; }
        void set_worthily(std::optional<int64_t> const & value) { this->worthily = value; }

        std::optional<int64_t> const & get_yankeeist() const { return yankeeist; }
        std::optional<int64_t> & get_mutable_yankeeist() { return yankeeist; }
        void set_yankeeist(std::optional<int64_t> const & value) { this->yankeeist = value; }
    };

    using StrenuosityElement = std::variant<std::vector<nlohmann::json>, StrenuosityClass>;

    using Tabaxir = std::variant<bool, double>;

    using Talpiform = std::optional<std::variant<QuebrachineClass, double>>;

    using Thwack = std::variant<bool, QuebrachineClass, double>;

    using Tortricine = std::variant<std::vector<std::optional<int64_t>>, QuebrachineClass>;

    class TruantcyClass {
        public:
        TruantcyClass() = default;
        virtual ~TruantcyClass() = default;

        private:
        nlohmann::json alfiona;
        nlohmann::json ascaridiasis;
        nlohmann::json bungey;
        std::optional<double> catharticalness;
        nlohmann::json ceroxyle;
        std::optional<int64_t> chirotherium;
        nlohmann::json chorology;
        std::optional<std::string> disdiapason;
        nlohmann::json enmarble;
        nlohmann::json epeira;
        nlohmann::json eurylaimi;
        nlohmann::json germination;
        nlohmann::json hallelujah;
        std::optional<bool> homocerc;
        nlohmann::json lev;
        nlohmann::json mouthing;
        nlohmann::json nonbookish;
        nlohmann::json philliloo;
        nlohmann::json planetal;
        nlohmann::json poney;
        nlohmann::json punctualist;
        nlohmann::json returnlessly;
        nlohmann::json skelder;
        nlohmann::json windwaywardly;
        nlohmann::json yuman;

        public:
        nlohmann::json const & get_alfiona() const { return alfiona; }
        nlohmann::json & get_mutable_alfiona() { return alfiona; }
        void set_alfiona(nlohmann::json const & value) { this->alfiona = value; }

        nlohmann::json const & get_ascaridiasis() const { return ascaridiasis; }
        nlohmann::json & get_mutable_ascaridiasis() { return ascaridiasis; }
        void set_ascaridiasis(nlohmann::json const & value) { this->ascaridiasis = value; }

        nlohmann::json const & get_bungey() const { return bungey; }
        nlohmann::json & get_mutable_bungey() { return bungey; }
        void set_bungey(nlohmann::json const & value) { this->bungey = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        nlohmann::json const & get_ceroxyle() const { return ceroxyle; }
        nlohmann::json & get_mutable_ceroxyle() { return ceroxyle; }
        void set_ceroxyle(nlohmann::json const & value) { this->ceroxyle = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        nlohmann::json const & get_chorology() const { return chorology; }
        nlohmann::json & get_mutable_chorology() { return chorology; }
        void set_chorology(nlohmann::json const & value) { this->chorology = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        nlohmann::json const & get_enmarble() const { return enmarble; }
        nlohmann::json & get_mutable_enmarble() { return enmarble; }
        void set_enmarble(nlohmann::json const & value) { this->enmarble = value; }

        nlohmann::json const & get_epeira() const { return epeira; }
        nlohmann::json & get_mutable_epeira() { return epeira; }
        void set_epeira(nlohmann::json const & value) { this->epeira = value; }

        nlohmann::json const & get_eurylaimi() const { return eurylaimi; }
        nlohmann::json & get_mutable_eurylaimi() { return eurylaimi; }
        void set_eurylaimi(nlohmann::json const & value) { this->eurylaimi = value; }

        nlohmann::json const & get_germination() const { return germination; }
        nlohmann::json & get_mutable_germination() { return germination; }
        void set_germination(nlohmann::json const & value) { this->germination = value; }

        nlohmann::json const & get_hallelujah() const { return hallelujah; }
        nlohmann::json & get_mutable_hallelujah() { return hallelujah; }
        void set_hallelujah(nlohmann::json const & value) { this->hallelujah = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        nlohmann::json const & get_lev() const { return lev; }
        nlohmann::json & get_mutable_lev() { return lev; }
        void set_lev(nlohmann::json const & value) { this->lev = value; }

        nlohmann::json const & get_mouthing() const { return mouthing; }
        nlohmann::json & get_mutable_mouthing() { return mouthing; }
        void set_mouthing(nlohmann::json const & value) { this->mouthing = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        nlohmann::json const & get_philliloo() const { return philliloo; }
        nlohmann::json & get_mutable_philliloo() { return philliloo; }
        void set_philliloo(nlohmann::json const & value) { this->philliloo = value; }

        nlohmann::json const & get_planetal() const { return planetal; }
        nlohmann::json & get_mutable_planetal() { return planetal; }
        void set_planetal(nlohmann::json const & value) { this->planetal = value; }

        nlohmann::json const & get_poney() const { return poney; }
        nlohmann::json & get_mutable_poney() { return poney; }
        void set_poney(nlohmann::json const & value) { this->poney = value; }

        nlohmann::json const & get_punctualist() const { return punctualist; }
        nlohmann::json & get_mutable_punctualist() { return punctualist; }
        void set_punctualist(nlohmann::json const & value) { this->punctualist = value; }

        nlohmann::json const & get_returnlessly() const { return returnlessly; }
        nlohmann::json & get_mutable_returnlessly() { return returnlessly; }
        void set_returnlessly(nlohmann::json const & value) { this->returnlessly = value; }

        nlohmann::json const & get_skelder() const { return skelder; }
        nlohmann::json & get_mutable_skelder() { return skelder; }
        void set_skelder(nlohmann::json const & value) { this->skelder = value; }

        nlohmann::json const & get_windwaywardly() const { return windwaywardly; }
        nlohmann::json & get_mutable_windwaywardly() { return windwaywardly; }
        void set_windwaywardly(nlohmann::json const & value) { this->windwaywardly = value; }

        nlohmann::json const & get_yuman() const { return yuman; }
        nlohmann::json & get_mutable_yuman() { return yuman; }
        void set_yuman(nlohmann::json const & value) { this->yuman = value; }
    };

    using TruantcyElement = std::variant<bool, TruantcyClass>;

    using Unbeginning = std::variant<std::vector<nlohmann::json>, std::map<std::string, int64_t>, std::string>;

    using Undesirability = std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>;

    using Unerasing = std::variant<std::vector<nlohmann::json>, int64_t, std::map<std::string, int64_t>>;

    using Unguentarium = std::optional<std::variant<std::vector<nlohmann::json>, int64_t>>;

    class UnimpeachablyClass {
        public:
        UnimpeachablyClass() = default;
        virtual ~UnimpeachablyClass() = default;

        private:
        std::optional<int64_t> acerin;
        std::optional<int64_t> bobadil;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> chlorophylligenous;
        std::optional<int64_t> conversational;
        std::optional<int64_t> demiowl;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> ectorhinal;
        std::optional<int64_t> gamblesomeness;
        std::optional<bool> homocerc;
        std::optional<int64_t> irrorate;
        std::optional<int64_t> kindergartening;
        std::optional<int64_t> lateritic;
        std::optional<int64_t> mespil;
        std::optional<int64_t> misconfiguration;
        nlohmann::json nonbookish;
        std::optional<int64_t> planometry;
        std::optional<int64_t> quiina;
        std::optional<int64_t> robert;
        std::optional<int64_t> rot;
        std::optional<int64_t> subcinctorium;
        std::optional<int64_t> tussocker;
        std::optional<int64_t> ultraproud;
        std::optional<int64_t> unsuggestedness;

        public:
        std::optional<int64_t> const & get_acerin() const { return acerin; }
        std::optional<int64_t> & get_mutable_acerin() { return acerin; }
        void set_acerin(std::optional<int64_t> const & value) { this->acerin = value; }

        std::optional<int64_t> const & get_bobadil() const { return bobadil; }
        std::optional<int64_t> & get_mutable_bobadil() { return bobadil; }
        void set_bobadil(std::optional<int64_t> const & value) { this->bobadil = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_chlorophylligenous() const { return chlorophylligenous; }
        std::optional<int64_t> & get_mutable_chlorophylligenous() { return chlorophylligenous; }
        void set_chlorophylligenous(std::optional<int64_t> const & value) { this->chlorophylligenous = value; }

        std::optional<int64_t> const & get_conversational() const { return conversational; }
        std::optional<int64_t> & get_mutable_conversational() { return conversational; }
        void set_conversational(std::optional<int64_t> const & value) { this->conversational = value; }

        std::optional<int64_t> const & get_demiowl() const { return demiowl; }
        std::optional<int64_t> & get_mutable_demiowl() { return demiowl; }
        void set_demiowl(std::optional<int64_t> const & value) { this->demiowl = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_ectorhinal() const { return ectorhinal; }
        std::optional<int64_t> & get_mutable_ectorhinal() { return ectorhinal; }
        void set_ectorhinal(std::optional<int64_t> const & value) { this->ectorhinal = value; }

        std::optional<int64_t> const & get_gamblesomeness() const { return gamblesomeness; }
        std::optional<int64_t> & get_mutable_gamblesomeness() { return gamblesomeness; }
        void set_gamblesomeness(std::optional<int64_t> const & value) { this->gamblesomeness = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_irrorate() const { return irrorate; }
        std::optional<int64_t> & get_mutable_irrorate() { return irrorate; }
        void set_irrorate(std::optional<int64_t> const & value) { this->irrorate = value; }

        std::optional<int64_t> const & get_kindergartening() const { return kindergartening; }
        std::optional<int64_t> & get_mutable_kindergartening() { return kindergartening; }
        void set_kindergartening(std::optional<int64_t> const & value) { this->kindergartening = value; }

        std::optional<int64_t> const & get_lateritic() const { return lateritic; }
        std::optional<int64_t> & get_mutable_lateritic() { return lateritic; }
        void set_lateritic(std::optional<int64_t> const & value) { this->lateritic = value; }

        std::optional<int64_t> const & get_mespil() const { return mespil; }
        std::optional<int64_t> & get_mutable_mespil() { return mespil; }
        void set_mespil(std::optional<int64_t> const & value) { this->mespil = value; }

        std::optional<int64_t> const & get_misconfiguration() const { return misconfiguration; }
        std::optional<int64_t> & get_mutable_misconfiguration() { return misconfiguration; }
        void set_misconfiguration(std::optional<int64_t> const & value) { this->misconfiguration = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_planometry() const { return planometry; }
        std::optional<int64_t> & get_mutable_planometry() { return planometry; }
        void set_planometry(std::optional<int64_t> const & value) { this->planometry = value; }

        std::optional<int64_t> const & get_quiina() const { return quiina; }
        std::optional<int64_t> & get_mutable_quiina() { return quiina; }
        void set_quiina(std::optional<int64_t> const & value) { this->quiina = value; }

        std::optional<int64_t> const & get_robert() const { return robert; }
        std::optional<int64_t> & get_mutable_robert() { return robert; }
        void set_robert(std::optional<int64_t> const & value) { this->robert = value; }

        std::optional<int64_t> const & get_rot() const { return rot; }
        std::optional<int64_t> & get_mutable_rot() { return rot; }
        void set_rot(std::optional<int64_t> const & value) { this->rot = value; }

        std::optional<int64_t> const & get_subcinctorium() const { return subcinctorium; }
        std::optional<int64_t> & get_mutable_subcinctorium() { return subcinctorium; }
        void set_subcinctorium(std::optional<int64_t> const & value) { this->subcinctorium = value; }

        std::optional<int64_t> const & get_tussocker() const { return tussocker; }
        std::optional<int64_t> & get_mutable_tussocker() { return tussocker; }
        void set_tussocker(std::optional<int64_t> const & value) { this->tussocker = value; }

        std::optional<int64_t> const & get_ultraproud() const { return ultraproud; }
        std::optional<int64_t> & get_mutable_ultraproud() { return ultraproud; }
        void set_ultraproud(std::optional<int64_t> const & value) { this->ultraproud = value; }

        std::optional<int64_t> const & get_unsuggestedness() const { return unsuggestedness; }
        std::optional<int64_t> & get_mutable_unsuggestedness() { return unsuggestedness; }
        void set_unsuggestedness(std::optional<int64_t> const & value) { this->unsuggestedness = value; }
    };

    using UnimpeachablyElement = std::variant<bool, UnimpeachablyClass>;

    using Unmortgaged = std::optional<std::variant<double, std::map<std::string, int64_t>>>;

    using Unobstructed = std::optional<std::variant<QuebrachineClass, int64_t>>;

    using Unreceptivity = std::variant<std::vector<nlohmann::json>, int64_t, std::string>;

    using Unsatisfactoriness = std::variant<std::vector<int64_t>, bool, int64_t>;

    class UnstressedClass {
        public:
        UnstressedClass() = default;
        virtual ~UnstressedClass() = default;

        private:
        nlohmann::json alain;
        nlohmann::json amphirhina;
        nlohmann::json antimachinery;
        nlohmann::json coldish;
        nlohmann::json crantara;
        nlohmann::json distinguishing;
        nlohmann::json elytroposis;
        nlohmann::json gentianwort;
        nlohmann::json heliosis;
        nlohmann::json instrumental;
        nlohmann::json introinflection;
        nlohmann::json kala;
        nlohmann::json lincolnian;
        nlohmann::json metad;
        nlohmann::json sarcophilus;
        nlohmann::json swingingly;
        nlohmann::json unconformity;
        nlohmann::json undecreed;
        nlohmann::json venerable;
        nlohmann::json vowellessness;

        public:
        nlohmann::json const & get_alain() const { return alain; }
        nlohmann::json & get_mutable_alain() { return alain; }
        void set_alain(nlohmann::json const & value) { this->alain = value; }

        nlohmann::json const & get_amphirhina() const { return amphirhina; }
        nlohmann::json & get_mutable_amphirhina() { return amphirhina; }
        void set_amphirhina(nlohmann::json const & value) { this->amphirhina = value; }

        nlohmann::json const & get_antimachinery() const { return antimachinery; }
        nlohmann::json & get_mutable_antimachinery() { return antimachinery; }
        void set_antimachinery(nlohmann::json const & value) { this->antimachinery = value; }

        nlohmann::json const & get_coldish() const { return coldish; }
        nlohmann::json & get_mutable_coldish() { return coldish; }
        void set_coldish(nlohmann::json const & value) { this->coldish = value; }

        nlohmann::json const & get_crantara() const { return crantara; }
        nlohmann::json & get_mutable_crantara() { return crantara; }
        void set_crantara(nlohmann::json const & value) { this->crantara = value; }

        nlohmann::json const & get_distinguishing() const { return distinguishing; }
        nlohmann::json & get_mutable_distinguishing() { return distinguishing; }
        void set_distinguishing(nlohmann::json const & value) { this->distinguishing = value; }

        nlohmann::json const & get_elytroposis() const { return elytroposis; }
        nlohmann::json & get_mutable_elytroposis() { return elytroposis; }
        void set_elytroposis(nlohmann::json const & value) { this->elytroposis = value; }

        nlohmann::json const & get_gentianwort() const { return gentianwort; }
        nlohmann::json & get_mutable_gentianwort() { return gentianwort; }
        void set_gentianwort(nlohmann::json const & value) { this->gentianwort = value; }

        nlohmann::json const & get_heliosis() const { return heliosis; }
        nlohmann::json & get_mutable_heliosis() { return heliosis; }
        void set_heliosis(nlohmann::json const & value) { this->heliosis = value; }

        nlohmann::json const & get_instrumental() const { return instrumental; }
        nlohmann::json & get_mutable_instrumental() { return instrumental; }
        void set_instrumental(nlohmann::json const & value) { this->instrumental = value; }

        nlohmann::json const & get_introinflection() const { return introinflection; }
        nlohmann::json & get_mutable_introinflection() { return introinflection; }
        void set_introinflection(nlohmann::json const & value) { this->introinflection = value; }

        nlohmann::json const & get_kala() const { return kala; }
        nlohmann::json & get_mutable_kala() { return kala; }
        void set_kala(nlohmann::json const & value) { this->kala = value; }

        nlohmann::json const & get_lincolnian() const { return lincolnian; }
        nlohmann::json & get_mutable_lincolnian() { return lincolnian; }
        void set_lincolnian(nlohmann::json const & value) { this->lincolnian = value; }

        nlohmann::json const & get_metad() const { return metad; }
        nlohmann::json & get_mutable_metad() { return metad; }
        void set_metad(nlohmann::json const & value) { this->metad = value; }

        nlohmann::json const & get_sarcophilus() const { return sarcophilus; }
        nlohmann::json & get_mutable_sarcophilus() { return sarcophilus; }
        void set_sarcophilus(nlohmann::json const & value) { this->sarcophilus = value; }

        nlohmann::json const & get_swingingly() const { return swingingly; }
        nlohmann::json & get_mutable_swingingly() { return swingingly; }
        void set_swingingly(nlohmann::json const & value) { this->swingingly = value; }

        nlohmann::json const & get_unconformity() const { return unconformity; }
        nlohmann::json & get_mutable_unconformity() { return unconformity; }
        void set_unconformity(nlohmann::json const & value) { this->unconformity = value; }

        nlohmann::json const & get_undecreed() const { return undecreed; }
        nlohmann::json & get_mutable_undecreed() { return undecreed; }
        void set_undecreed(nlohmann::json const & value) { this->undecreed = value; }

        nlohmann::json const & get_venerable() const { return venerable; }
        nlohmann::json & get_mutable_venerable() { return venerable; }
        void set_venerable(nlohmann::json const & value) { this->venerable = value; }

        nlohmann::json const & get_vowellessness() const { return vowellessness; }
        nlohmann::json & get_mutable_vowellessness() { return vowellessness; }
        void set_vowellessness(nlohmann::json const & value) { this->vowellessness = value; }
    };

    using UnstressedElement = std::variant<bool, UnstressedClass, std::string>;

    using Untasked = std::variant<std::vector<nlohmann::json>, double, std::map<std::string, int64_t>>;

    using Unvarying = std::variant<bool, double, std::map<std::string, int64_t>>;

    using Vehemently = std::optional<std::variant<std::vector<nlohmann::json>, bool>>;

    using Whitepot = std::variant<QuebrachineClass, double>;

    class WrothyClass {
        public:
        WrothyClass() = default;
        virtual ~WrothyClass() = default;

        private:
        nlohmann::json aeschynanthus;
        nlohmann::json aquiferous;
        nlohmann::json cheapener;
        nlohmann::json enumeration;
        nlohmann::json ephesine;
        nlohmann::json escadrille;
        nlohmann::json estrous;
        nlohmann::json interestedly;
        nlohmann::json katakinetomer;
        nlohmann::json mortification;
        nlohmann::json morula;
        nlohmann::json orthosymmetrical;
        nlohmann::json overbark;
        nlohmann::json politist;
        nlohmann::json qualified;
        nlohmann::json sphenomalar;
        nlohmann::json throatful;
        nlohmann::json transhumance;
        nlohmann::json triandrian;
        nlohmann::json unbooked;

        public:
        nlohmann::json const & get_aeschynanthus() const { return aeschynanthus; }
        nlohmann::json & get_mutable_aeschynanthus() { return aeschynanthus; }
        void set_aeschynanthus(nlohmann::json const & value) { this->aeschynanthus = value; }

        nlohmann::json const & get_aquiferous() const { return aquiferous; }
        nlohmann::json & get_mutable_aquiferous() { return aquiferous; }
        void set_aquiferous(nlohmann::json const & value) { this->aquiferous = value; }

        nlohmann::json const & get_cheapener() const { return cheapener; }
        nlohmann::json & get_mutable_cheapener() { return cheapener; }
        void set_cheapener(nlohmann::json const & value) { this->cheapener = value; }

        nlohmann::json const & get_enumeration() const { return enumeration; }
        nlohmann::json & get_mutable_enumeration() { return enumeration; }
        void set_enumeration(nlohmann::json const & value) { this->enumeration = value; }

        nlohmann::json const & get_ephesine() const { return ephesine; }
        nlohmann::json & get_mutable_ephesine() { return ephesine; }
        void set_ephesine(nlohmann::json const & value) { this->ephesine = value; }

        nlohmann::json const & get_escadrille() const { return escadrille; }
        nlohmann::json & get_mutable_escadrille() { return escadrille; }
        void set_escadrille(nlohmann::json const & value) { this->escadrille = value; }

        nlohmann::json const & get_estrous() const { return estrous; }
        nlohmann::json & get_mutable_estrous() { return estrous; }
        void set_estrous(nlohmann::json const & value) { this->estrous = value; }

        nlohmann::json const & get_interestedly() const { return interestedly; }
        nlohmann::json & get_mutable_interestedly() { return interestedly; }
        void set_interestedly(nlohmann::json const & value) { this->interestedly = value; }

        nlohmann::json const & get_katakinetomer() const { return katakinetomer; }
        nlohmann::json & get_mutable_katakinetomer() { return katakinetomer; }
        void set_katakinetomer(nlohmann::json const & value) { this->katakinetomer = value; }

        nlohmann::json const & get_mortification() const { return mortification; }
        nlohmann::json & get_mutable_mortification() { return mortification; }
        void set_mortification(nlohmann::json const & value) { this->mortification = value; }

        nlohmann::json const & get_morula() const { return morula; }
        nlohmann::json & get_mutable_morula() { return morula; }
        void set_morula(nlohmann::json const & value) { this->morula = value; }

        nlohmann::json const & get_orthosymmetrical() const { return orthosymmetrical; }
        nlohmann::json & get_mutable_orthosymmetrical() { return orthosymmetrical; }
        void set_orthosymmetrical(nlohmann::json const & value) { this->orthosymmetrical = value; }

        nlohmann::json const & get_overbark() const { return overbark; }
        nlohmann::json & get_mutable_overbark() { return overbark; }
        void set_overbark(nlohmann::json const & value) { this->overbark = value; }

        nlohmann::json const & get_politist() const { return politist; }
        nlohmann::json & get_mutable_politist() { return politist; }
        void set_politist(nlohmann::json const & value) { this->politist = value; }

        nlohmann::json const & get_qualified() const { return qualified; }
        nlohmann::json & get_mutable_qualified() { return qualified; }
        void set_qualified(nlohmann::json const & value) { this->qualified = value; }

        nlohmann::json const & get_sphenomalar() const { return sphenomalar; }
        nlohmann::json & get_mutable_sphenomalar() { return sphenomalar; }
        void set_sphenomalar(nlohmann::json const & value) { this->sphenomalar = value; }

        nlohmann::json const & get_throatful() const { return throatful; }
        nlohmann::json & get_mutable_throatful() { return throatful; }
        void set_throatful(nlohmann::json const & value) { this->throatful = value; }

        nlohmann::json const & get_transhumance() const { return transhumance; }
        nlohmann::json & get_mutable_transhumance() { return transhumance; }
        void set_transhumance(nlohmann::json const & value) { this->transhumance = value; }

        nlohmann::json const & get_triandrian() const { return triandrian; }
        nlohmann::json & get_mutable_triandrian() { return triandrian; }
        void set_triandrian(nlohmann::json const & value) { this->triandrian = value; }

        nlohmann::json const & get_unbooked() const { return unbooked; }
        nlohmann::json & get_mutable_unbooked() { return unbooked; }
        void set_unbooked(nlohmann::json const & value) { this->unbooked = value; }
    };

    using WrothyElement = std::variant<std::vector<nlohmann::json>, WrothyClass>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Protrusive> protrusive;
        std::vector<PulpitismElement> pulpitism;
        std::vector<PyodermiaElement> pyodermia;
        std::vector<QuebrachineElement> quebrachine;
        std::vector<Querier> querier;
        std::vector<Rebarbative> rebarbative;
        std::vector<Reimagine> reimagine;
        Ressaut ressaut;
        std::vector<Retrocervical> retrocervical;
        std::vector<Revert> revert;
        std::vector<RewriteElement> rewrite;
        std::vector<Saccoderm> saccoderm;
        std::vector<SantirElement> santir;
        std::vector<Saprophilous> saprophilous;
        std::vector<SaxtenElement> saxten;
        std::vector<std::optional<Scatty>> scatty;
        std::vector<Scoffer> scoffer;
        std::vector<Scrampum> scrampum;
        double semantic;
        std::vector<Serpentinic> serpentinic;
        std::vector<Shadowable> shadowable;
        std::vector<SisteringElement> sistering;
        std::vector<Staghunting> staghunting;
        std::vector<Stagmometer> stagmometer;
        std::vector<Stimulability> stimulability;
        std::vector<Strangleable> strangleable;
        std::vector<StrenuosityElement> strenuosity;
        std::vector<Tabaxir> tabaxir;
        std::vector<Talpiform> talpiform;
        std::vector<Thwack> thwack;
        std::vector<std::optional<double>> to;
        std::vector<Tortricine> tortricine;
        std::vector<TruantcyElement> truantcy;
        std::vector<std::string> turgesce;
        std::vector<Unbeginning> unbeginning;
        std::vector<double> underdunged;
        std::vector<Undesirability> undesirability;
        std::vector<Unerasing> unerasing;
        std::vector<Unguentarium> unguentarium;
        std::vector<UnimpeachablyElement> unimpeachably;
        std::vector<Unmortgaged> unmortgaged;
        std::vector<Unobstructed> unobstructed;
        std::vector<Unreceptivity> unreceptivity;
        std::vector<Unsatisfactoriness> unsatisfactoriness;
        std::vector<int64_t> unsecurity;
        std::vector<UnstressedElement> unstressed;
        std::vector<Untasked> untasked;
        std::vector<Unvarying> unvarying;
        std::vector<Vehemently> vehemently;
        std::map<std::string, bool> warriorship;
        std::vector<Whitepot> whitepot;
        std::vector<WrothyElement> wrothy;

        public:
        std::vector<Protrusive> const & get_protrusive() const { return protrusive; }
        std::vector<Protrusive> & get_mutable_protrusive() { return protrusive; }
        void set_protrusive(std::vector<Protrusive> const & value) { this->protrusive = value; }

        std::vector<PulpitismElement> const & get_pulpitism() const { return pulpitism; }
        std::vector<PulpitismElement> & get_mutable_pulpitism() { return pulpitism; }
        void set_pulpitism(std::vector<PulpitismElement> const & value) { this->pulpitism = value; }

        std::vector<PyodermiaElement> const & get_pyodermia() const { return pyodermia; }
        std::vector<PyodermiaElement> & get_mutable_pyodermia() { return pyodermia; }
        void set_pyodermia(std::vector<PyodermiaElement> const & value) { this->pyodermia = value; }

        std::vector<QuebrachineElement> const & get_quebrachine() const { return quebrachine; }
        std::vector<QuebrachineElement> & get_mutable_quebrachine() { return quebrachine; }
        void set_quebrachine(std::vector<QuebrachineElement> const & value) { this->quebrachine = value; }

        std::vector<Querier> const & get_querier() const { return querier; }
        std::vector<Querier> & get_mutable_querier() { return querier; }
        void set_querier(std::vector<Querier> const & value) { this->querier = value; }

        std::vector<Rebarbative> const & get_rebarbative() const { return rebarbative; }
        std::vector<Rebarbative> & get_mutable_rebarbative() { return rebarbative; }
        void set_rebarbative(std::vector<Rebarbative> const & value) { this->rebarbative = value; }

        std::vector<Reimagine> const & get_reimagine() const { return reimagine; }
        std::vector<Reimagine> & get_mutable_reimagine() { return reimagine; }
        void set_reimagine(std::vector<Reimagine> const & value) { this->reimagine = value; }

        Ressaut const & get_ressaut() const { return ressaut; }
        Ressaut & get_mutable_ressaut() { return ressaut; }
        void set_ressaut(Ressaut const & value) { this->ressaut = value; }

        std::vector<Retrocervical> const & get_retrocervical() const { return retrocervical; }
        std::vector<Retrocervical> & get_mutable_retrocervical() { return retrocervical; }
        void set_retrocervical(std::vector<Retrocervical> const & value) { this->retrocervical = value; }

        std::vector<Revert> const & get_revert() const { return revert; }
        std::vector<Revert> & get_mutable_revert() { return revert; }
        void set_revert(std::vector<Revert> const & value) { this->revert = value; }

        std::vector<RewriteElement> const & get_rewrite() const { return rewrite; }
        std::vector<RewriteElement> & get_mutable_rewrite() { return rewrite; }
        void set_rewrite(std::vector<RewriteElement> const & value) { this->rewrite = value; }

        std::vector<Saccoderm> const & get_saccoderm() const { return saccoderm; }
        std::vector<Saccoderm> & get_mutable_saccoderm() { return saccoderm; }
        void set_saccoderm(std::vector<Saccoderm> const & value) { this->saccoderm = value; }

        std::vector<SantirElement> const & get_santir() const { return santir; }
        std::vector<SantirElement> & get_mutable_santir() { return santir; }
        void set_santir(std::vector<SantirElement> const & value) { this->santir = value; }

        std::vector<Saprophilous> const & get_saprophilous() const { return saprophilous; }
        std::vector<Saprophilous> & get_mutable_saprophilous() { return saprophilous; }
        void set_saprophilous(std::vector<Saprophilous> const & value) { this->saprophilous = value; }

        std::vector<SaxtenElement> const & get_saxten() const { return saxten; }
        std::vector<SaxtenElement> & get_mutable_saxten() { return saxten; }
        void set_saxten(std::vector<SaxtenElement> const & value) { this->saxten = value; }

        std::vector<std::optional<Scatty>> const & get_scatty() const { return scatty; }
        std::vector<std::optional<Scatty>> & get_mutable_scatty() { return scatty; }
        void set_scatty(std::vector<std::optional<Scatty>> const & value) { this->scatty = value; }

        std::vector<Scoffer> const & get_scoffer() const { return scoffer; }
        std::vector<Scoffer> & get_mutable_scoffer() { return scoffer; }
        void set_scoffer(std::vector<Scoffer> const & value) { this->scoffer = value; }

        std::vector<Scrampum> const & get_scrampum() const { return scrampum; }
        std::vector<Scrampum> & get_mutable_scrampum() { return scrampum; }
        void set_scrampum(std::vector<Scrampum> const & value) { this->scrampum = value; }

        double const & get_semantic() const { return semantic; }
        double & get_mutable_semantic() { return semantic; }
        void set_semantic(double const & value) { this->semantic = value; }

        std::vector<Serpentinic> const & get_serpentinic() const { return serpentinic; }
        std::vector<Serpentinic> & get_mutable_serpentinic() { return serpentinic; }
        void set_serpentinic(std::vector<Serpentinic> const & value) { this->serpentinic = value; }

        std::vector<Shadowable> const & get_shadowable() const { return shadowable; }
        std::vector<Shadowable> & get_mutable_shadowable() { return shadowable; }
        void set_shadowable(std::vector<Shadowable> const & value) { this->shadowable = value; }

        std::vector<SisteringElement> const & get_sistering() const { return sistering; }
        std::vector<SisteringElement> & get_mutable_sistering() { return sistering; }
        void set_sistering(std::vector<SisteringElement> const & value) { this->sistering = value; }

        std::vector<Staghunting> const & get_staghunting() const { return staghunting; }
        std::vector<Staghunting> & get_mutable_staghunting() { return staghunting; }
        void set_staghunting(std::vector<Staghunting> const & value) { this->staghunting = value; }

        std::vector<Stagmometer> const & get_stagmometer() const { return stagmometer; }
        std::vector<Stagmometer> & get_mutable_stagmometer() { return stagmometer; }
        void set_stagmometer(std::vector<Stagmometer> const & value) { this->stagmometer = value; }

        std::vector<Stimulability> const & get_stimulability() const { return stimulability; }
        std::vector<Stimulability> & get_mutable_stimulability() { return stimulability; }
        void set_stimulability(std::vector<Stimulability> const & value) { this->stimulability = value; }

        std::vector<Strangleable> const & get_strangleable() const { return strangleable; }
        std::vector<Strangleable> & get_mutable_strangleable() { return strangleable; }
        void set_strangleable(std::vector<Strangleable> const & value) { this->strangleable = value; }

        std::vector<StrenuosityElement> const & get_strenuosity() const { return strenuosity; }
        std::vector<StrenuosityElement> & get_mutable_strenuosity() { return strenuosity; }
        void set_strenuosity(std::vector<StrenuosityElement> const & value) { this->strenuosity = value; }

        std::vector<Tabaxir> const & get_tabaxir() const { return tabaxir; }
        std::vector<Tabaxir> & get_mutable_tabaxir() { return tabaxir; }
        void set_tabaxir(std::vector<Tabaxir> const & value) { this->tabaxir = value; }

        std::vector<Talpiform> const & get_talpiform() const { return talpiform; }
        std::vector<Talpiform> & get_mutable_talpiform() { return talpiform; }
        void set_talpiform(std::vector<Talpiform> const & value) { this->talpiform = value; }

        std::vector<Thwack> const & get_thwack() const { return thwack; }
        std::vector<Thwack> & get_mutable_thwack() { return thwack; }
        void set_thwack(std::vector<Thwack> const & value) { this->thwack = value; }

        std::vector<std::optional<double>> const & get_to() const { return to; }
        std::vector<std::optional<double>> & get_mutable_to() { return to; }
        void set_to(std::vector<std::optional<double>> const & value) { this->to = value; }

        std::vector<Tortricine> const & get_tortricine() const { return tortricine; }
        std::vector<Tortricine> & get_mutable_tortricine() { return tortricine; }
        void set_tortricine(std::vector<Tortricine> const & value) { this->tortricine = value; }

        std::vector<TruantcyElement> const & get_truantcy() const { return truantcy; }
        std::vector<TruantcyElement> & get_mutable_truantcy() { return truantcy; }
        void set_truantcy(std::vector<TruantcyElement> const & value) { this->truantcy = value; }

        std::vector<std::string> const & get_turgesce() const { return turgesce; }
        std::vector<std::string> & get_mutable_turgesce() { return turgesce; }
        void set_turgesce(std::vector<std::string> const & value) { this->turgesce = value; }

        std::vector<Unbeginning> const & get_unbeginning() const { return unbeginning; }
        std::vector<Unbeginning> & get_mutable_unbeginning() { return unbeginning; }
        void set_unbeginning(std::vector<Unbeginning> const & value) { this->unbeginning = value; }

        std::vector<double> const & get_underdunged() const { return underdunged; }
        std::vector<double> & get_mutable_underdunged() { return underdunged; }
        void set_underdunged(std::vector<double> const & value) { this->underdunged = value; }

        std::vector<Undesirability> const & get_undesirability() const { return undesirability; }
        std::vector<Undesirability> & get_mutable_undesirability() { return undesirability; }
        void set_undesirability(std::vector<Undesirability> const & value) { this->undesirability = value; }

        std::vector<Unerasing> const & get_unerasing() const { return unerasing; }
        std::vector<Unerasing> & get_mutable_unerasing() { return unerasing; }
        void set_unerasing(std::vector<Unerasing> const & value) { this->unerasing = value; }

        std::vector<Unguentarium> const & get_unguentarium() const { return unguentarium; }
        std::vector<Unguentarium> & get_mutable_unguentarium() { return unguentarium; }
        void set_unguentarium(std::vector<Unguentarium> const & value) { this->unguentarium = value; }

        std::vector<UnimpeachablyElement> const & get_unimpeachably() const { return unimpeachably; }
        std::vector<UnimpeachablyElement> & get_mutable_unimpeachably() { return unimpeachably; }
        void set_unimpeachably(std::vector<UnimpeachablyElement> const & value) { this->unimpeachably = value; }

        std::vector<Unmortgaged> const & get_unmortgaged() const { return unmortgaged; }
        std::vector<Unmortgaged> & get_mutable_unmortgaged() { return unmortgaged; }
        void set_unmortgaged(std::vector<Unmortgaged> const & value) { this->unmortgaged = value; }

        std::vector<Unobstructed> const & get_unobstructed() const { return unobstructed; }
        std::vector<Unobstructed> & get_mutable_unobstructed() { return unobstructed; }
        void set_unobstructed(std::vector<Unobstructed> const & value) { this->unobstructed = value; }

        std::vector<Unreceptivity> const & get_unreceptivity() const { return unreceptivity; }
        std::vector<Unreceptivity> & get_mutable_unreceptivity() { return unreceptivity; }
        void set_unreceptivity(std::vector<Unreceptivity> const & value) { this->unreceptivity = value; }

        std::vector<Unsatisfactoriness> const & get_unsatisfactoriness() const { return unsatisfactoriness; }
        std::vector<Unsatisfactoriness> & get_mutable_unsatisfactoriness() { return unsatisfactoriness; }
        void set_unsatisfactoriness(std::vector<Unsatisfactoriness> const & value) { this->unsatisfactoriness = value; }

        std::vector<int64_t> const & get_unsecurity() const { return unsecurity; }
        std::vector<int64_t> & get_mutable_unsecurity() { return unsecurity; }
        void set_unsecurity(std::vector<int64_t> const & value) { this->unsecurity = value; }

        std::vector<UnstressedElement> const & get_unstressed() const { return unstressed; }
        std::vector<UnstressedElement> & get_mutable_unstressed() { return unstressed; }
        void set_unstressed(std::vector<UnstressedElement> const & value) { this->unstressed = value; }

        std::vector<Untasked> const & get_untasked() const { return untasked; }
        std::vector<Untasked> & get_mutable_untasked() { return untasked; }
        void set_untasked(std::vector<Untasked> const & value) { this->untasked = value; }

        std::vector<Unvarying> const & get_unvarying() const { return unvarying; }
        std::vector<Unvarying> & get_mutable_unvarying() { return unvarying; }
        void set_unvarying(std::vector<Unvarying> const & value) { this->unvarying = value; }

        std::vector<Vehemently> const & get_vehemently() const { return vehemently; }
        std::vector<Vehemently> & get_mutable_vehemently() { return vehemently; }
        void set_vehemently(std::vector<Vehemently> const & value) { this->vehemently = value; }

        std::map<std::string, bool> const & get_warriorship() const { return warriorship; }
        std::map<std::string, bool> & get_mutable_warriorship() { return warriorship; }
        void set_warriorship(std::map<std::string, bool> const & value) { this->warriorship = value; }

        std::vector<Whitepot> const & get_whitepot() const { return whitepot; }
        std::vector<Whitepot> & get_mutable_whitepot() { return whitepot; }
        void set_whitepot(std::vector<Whitepot> const & value) { this->whitepot = value; }

        std::vector<WrothyElement> const & get_wrothy() const { return wrothy; }
        std::vector<WrothyElement> & get_mutable_wrothy() { return wrothy; }
        void set_wrothy(std::vector<WrothyElement> const & value) { this->wrothy = value; }
    };
}

namespace quicktype {
void from_json(json const & j, PulpitismClass & x);
void to_json(json & j, PulpitismClass const & x);

void from_json(json const & j, PyodermiaClass & x);
void to_json(json & j, PyodermiaClass const & x);

void from_json(json const & j, QuebrachineClass & x);
void to_json(json & j, QuebrachineClass const & x);

void from_json(json const & j, Reimagine & x);
void to_json(json & j, Reimagine const & x);

void from_json(json const & j, Ressaut & x);
void to_json(json & j, Ressaut const & x);

void from_json(json const & j, RewriteClass & x);
void to_json(json & j, RewriteClass const & x);

void from_json(json const & j, SantirClass & x);
void to_json(json & j, SantirClass const & x);

void from_json(json const & j, SaxtenClass & x);
void to_json(json & j, SaxtenClass const & x);

void from_json(json const & j, Scatty & x);
void to_json(json & j, Scatty const & x);

void from_json(json const & j, SisteringClass & x);
void to_json(json & j, SisteringClass const & x);

void from_json(json const & j, Staghunting & x);
void to_json(json & j, Staghunting const & x);

void from_json(json const & j, StrenuosityClass & x);
void to_json(json & j, StrenuosityClass const & x);

void from_json(json const & j, TruantcyClass & x);
void to_json(json & j, TruantcyClass const & x);

void from_json(json const & j, UnimpeachablyClass & x);
void to_json(json & j, UnimpeachablyClass const & x);

void from_json(json const & j, UnstressedClass & x);
void to_json(json & j, UnstressedClass const & x);

void from_json(json const & j, WrothyClass & x);
void to_json(json & j, WrothyClass const & x);

void from_json(json const & j, TopLevel & x);
void to_json(json & j, TopLevel const & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, double>> {
    static void from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, double> & x);
    static void to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PyodermiaClass, int64_t>> {
    static void from_json(json const & j, std::variant<quicktype::PyodermiaClass, int64_t> & x);
    static void to_json(json & j, std::variant<quicktype::PyodermiaClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::QuebrachineClass>> {
    static void from_json(json const & j, std::variant<bool, quicktype::QuebrachineClass> & x);
    static void to_json(json & j, std::variant<bool, quicktype::QuebrachineClass> const & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<bool, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, double>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool, double> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<bool, std::string>> {
    static void from_json(json const & j, std::variant<bool, std::string> & x);
    static void to_json(json & j, std::variant<bool, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::RewriteClass, double>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::RewriteClass, double> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::RewriteClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SantirClass, double>> {
    static void from_json(json const & j, std::variant<quicktype::SantirClass, double> & x);
    static void to_json(json & j, std::variant<quicktype::SantirClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<std::map<std::string, int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SaxtenClass, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::SaxtenClass, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::SaxtenClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, double> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, bool>> {
    static void from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, bool> & x);
    static void to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, bool> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::SisteringClass, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, int64_t, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<bool, int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<bool, int64_t, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double>> {
    static void from_json(json const & j, std::variant<std::vector<json>, double> & x);
    static void to_json(json & j, std::variant<std::vector<json>, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::StrenuosityClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::StrenuosityClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::StrenuosityClass> const & x);
};

template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(json const & j, std::variant<bool, double> & x);
    static void to_json(json & j, std::variant<bool, double> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::QuebrachineClass, double>> {
    static void from_json(json const & j, std::variant<quicktype::QuebrachineClass, double> & x);
    static void to_json(json & j, std::variant<quicktype::QuebrachineClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::QuebrachineClass, double>> {
    static void from_json(json const & j, std::variant<bool, quicktype::QuebrachineClass, double> & x);
    static void to_json(json & j, std::variant<bool, quicktype::QuebrachineClass, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass>> {
    static void from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> & x);
    static void to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::TruantcyClass>> {
    static void from_json(json const & j, std::variant<bool, quicktype::TruantcyClass> & x);
    static void to_json(json & j, std::variant<bool, quicktype::TruantcyClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<json>, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<json>, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::UnimpeachablyClass>> {
    static void from_json(json const & j, std::variant<bool, quicktype::UnimpeachablyClass> & x);
    static void to_json(json & j, std::variant<bool, quicktype::UnimpeachablyClass> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<double, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::QuebrachineClass, int64_t>> {
    static void from_json(json const & j, std::variant<quicktype::QuebrachineClass, int64_t> & x);
    static void to_json(json & j, std::variant<quicktype::QuebrachineClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<json>, int64_t, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<json>, int64_t, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::UnstressedClass, std::string>> {
    static void from_json(json const & j, std::variant<bool, quicktype::UnstressedClass, std::string> & x);
    static void to_json(json & j, std::variant<bool, quicktype::UnstressedClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<json>, double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<json>, double, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<bool, double, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<bool, double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<bool, double, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::WrothyClass>> {
    static void from_json(json const & j, std::variant<std::vector<json>, quicktype::WrothyClass> & x);
    static void to_json(json & j, std::variant<std::vector<json>, quicktype::WrothyClass> const & x);
};
}
namespace quicktype {
    inline void from_json(json const & j, PulpitismClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_abnet(get_untyped(j, "abnet"));
        x.set_buckhorn(get_untyped(j, "buckhorn"));
        x.set_calciform(get_untyped(j, "calciform"));
        x.set_chelophore(get_untyped(j, "chelophore"));
        x.set_cogitation(get_untyped(j, "cogitation"));
        x.set_decreeable(get_untyped(j, "decreeable"));
        x.set_despicable(get_untyped(j, "despicable"));
        x.set_isodiazo(get_untyped(j, "isodiazo"));
        x.set_jadedly(get_untyped(j, "jadedly"));
        x.set_leptochlorite(get_untyped(j, "leptochlorite"));
        x.set_nursling(get_untyped(j, "nursling"));
        x.set_palamedean(get_untyped(j, "palamedean"));
        x.set_photoheliograph(get_untyped(j, "photoheliograph"));
        x.set_pipewood(get_untyped(j, "pipewood"));
        x.set_roberd(get_untyped(j, "roberd"));
        x.set_statable(get_untyped(j, "statable"));
        x.set_superassume(get_untyped(j, "superassume"));
        x.set_syllabe(get_untyped(j, "syllabe"));
        x.set_toughhead(get_untyped(j, "toughhead"));
        x.set_underburn(get_untyped(j, "underburn"));
    }

    inline void to_json(json & j, PulpitismClass const & x) {
        j = json::object();
        j["abnet"] = x.get_abnet();
        j["buckhorn"] = x.get_buckhorn();
        j["calciform"] = x.get_calciform();
        j["chelophore"] = x.get_chelophore();
        j["cogitation"] = x.get_cogitation();
        j["decreeable"] = x.get_decreeable();
        j["despicable"] = x.get_despicable();
        j["isodiazo"] = x.get_isodiazo();
        j["jadedly"] = x.get_jadedly();
        j["leptochlorite"] = x.get_leptochlorite();
        j["nursling"] = x.get_nursling();
        j["palamedean"] = x.get_palamedean();
        j["photoheliograph"] = x.get_photoheliograph();
        j["pipewood"] = x.get_pipewood();
        j["roberd"] = x.get_roberd();
        j["statable"] = x.get_statable();
        j["superassume"] = x.get_superassume();
        j["syllabe"] = x.get_syllabe();
        j["toughhead"] = x.get_toughhead();
        j["underburn"] = x.get_underburn();
    }

    inline void from_json(json const & j, PyodermiaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_aphoristically(get_untyped(j, "aphoristically"));
        x.set_apophyllous(get_untyped(j, "apophyllous"));
        x.set_cognize(get_untyped(j, "cognize"));
        x.set_dermonosology(get_untyped(j, "dermonosology"));
        x.set_gyppo(get_untyped(j, "Gyppo"));
        x.set_ither(get_untyped(j, "ither"));
        x.set_juglandaceous(get_untyped(j, "juglandaceous"));
        x.set_litho(get_untyped(j, "litho"));
        x.set_macropterous(get_untyped(j, "macropterous"));
        x.set_photographer(get_untyped(j, "photographer"));
        x.set_romancing(get_untyped(j, "romancing"));
        x.set_rumness(get_untyped(j, "rumness"));
        x.set_somniloquist(get_untyped(j, "somniloquist"));
        x.set_stressfully(get_untyped(j, "stressfully"));
        x.set_tactically(get_untyped(j, "tactically"));
        x.set_tracheophony(get_untyped(j, "tracheophony"));
        x.set_unappositely(get_untyped(j, "unappositely"));
        x.set_unclothedly(get_untyped(j, "unclothedly"));
        x.set_unimplied(get_untyped(j, "unimplied"));
        x.set_unsyncopated(get_untyped(j, "unsyncopated"));
    }

    inline void to_json(json & j, PyodermiaClass const & x) {
        j = json::object();
        j["aphoristically"] = x.get_aphoristically();
        j["apophyllous"] = x.get_apophyllous();
        j["cognize"] = x.get_cognize();
        j["dermonosology"] = x.get_dermonosology();
        j["Gyppo"] = x.get_gyppo();
        j["ither"] = x.get_ither();
        j["juglandaceous"] = x.get_juglandaceous();
        j["litho"] = x.get_litho();
        j["macropterous"] = x.get_macropterous();
        j["photographer"] = x.get_photographer();
        j["romancing"] = x.get_romancing();
        j["rumness"] = x.get_rumness();
        j["somniloquist"] = x.get_somniloquist();
        j["stressfully"] = x.get_stressfully();
        j["tactically"] = x.get_tactically();
        j["tracheophony"] = x.get_tracheophony();
        j["unappositely"] = x.get_unappositely();
        j["unclothedly"] = x.get_unclothedly();
        j["unimplied"] = x.get_unimplied();
        j["unsyncopated"] = x.get_unsyncopated();
    }

    inline void from_json(json const & j, QuebrachineClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_catharticalness(j.at("catharticalness").get<double>());
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_chirotherium(j.at("Chirotherium").get<int64_t>());
        x.set_disdiapason(j.at("disdiapason").get<std::string>());
        x.set_homocerc(j.at("homocerc").get<bool>());
        x.set_nonbookish(get_untyped(j, "nonbookish"));
    }

    inline void to_json(json & j, QuebrachineClass const & x) {
        j = json::object();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["homocerc"] = x.get_homocerc();
        j["nonbookish"] = x.get_nonbookish();
    }

    inline void from_json(json const & j, Reimagine& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_adducible(get_untyped(j, "adducible"));
        x.set_anabolin(get_untyped(j, "anabolin"));
        x.set_brainy(get_untyped(j, "brainy"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        x.set_chrysamine(get_untyped(j, "chrysamine"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_fluxweed(get_untyped(j, "fluxweed"));
        x.set_glaucine(get_untyped(j, "glaucine"));
        x.set_grobianism(get_untyped(j, "grobianism"));
        x.set_hermo(get_untyped(j, "Hermo"));
        x.set_hieroglyphist(get_untyped(j, "hieroglyphist"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_icteroid(get_untyped(j, "icteroid"));
        x.set_immortal(get_untyped(j, "immortal"));
        x.set_impetulant(get_untyped(j, "impetulant"));
        x.set_irrigate(get_untyped(j, "irrigate"));
        x.set_myxedema(get_untyped(j, "myxedema"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_onyx(get_untyped(j, "onyx"));
        x.set_repasser(get_untyped(j, "repasser"));
        x.set_septomarginal(get_untyped(j, "septomarginal"));
        x.set_subdie(get_untyped(j, "subdie"));
        x.set_tibiometatarsal(get_untyped(j, "tibiometatarsal"));
        x.set_waltzlike(get_untyped(j, "waltzlike"));
    }

    inline void to_json(json & j, Reimagine const & x) {
        j = json::object();
        j["adducible"] = x.get_adducible();
        j["anabolin"] = x.get_anabolin();
        j["brainy"] = x.get_brainy();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["chrysamine"] = x.get_chrysamine();
        j["disdiapason"] = x.get_disdiapason();
        j["fluxweed"] = x.get_fluxweed();
        j["glaucine"] = x.get_glaucine();
        j["grobianism"] = x.get_grobianism();
        j["Hermo"] = x.get_hermo();
        j["hieroglyphist"] = x.get_hieroglyphist();
        j["homocerc"] = x.get_homocerc();
        j["icteroid"] = x.get_icteroid();
        j["immortal"] = x.get_immortal();
        j["impetulant"] = x.get_impetulant();
        j["irrigate"] = x.get_irrigate();
        j["myxedema"] = x.get_myxedema();
        j["nonbookish"] = x.get_nonbookish();
        j["onyx"] = x.get_onyx();
        j["repasser"] = x.get_repasser();
        j["septomarginal"] = x.get_septomarginal();
        j["subdie"] = x.get_subdie();
        j["tibiometatarsal"] = x.get_tibiometatarsal();
        j["waltzlike"] = x.get_waltzlike();
    }

    inline void from_json(json const & j, Ressaut& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_apperceptive(j.at("apperceptive").get<std::string>());
        x.set_cuttoo(j.at("cuttoo").get<std::string>());
        x.set_douser(j.at("douser").get<std::string>());
        x.set_drinkproof(j.at("drinkproof").get<std::string>());
        x.set_forementioned(j.at("forementioned").get<std::string>());
        x.set_freesia(j.at("Freesia").get<std::string>());
        x.set_genevieve(j.at("Genevieve").get<std::string>());
        x.set_hyperdiabolical(j.at("hyperdiabolical").get<std::string>());
        x.set_hypocone(j.at("hypocone").get<std::string>());
        x.set_irreverentially(j.at("irreverentially").get<std::string>());
        x.set_jumart(j.at("jumart").get<std::string>());
        x.set_mimosaceae(j.at("Mimosaceae").get<std::string>());
        x.set_mollicrush(j.at("mollicrush").get<std::string>());
        x.set_nedder(j.at("nedder").get<std::string>());
        x.set_retinasphalt(j.at("retinasphalt").get<std::string>());
        x.set_sough(j.at("sough").get<std::string>());
        x.set_steading(j.at("steading").get<std::string>());
        x.set_theopaschitism(j.at("Theopaschitism").get<std::string>());
        x.set_undurableness(j.at("undurableness").get<std::string>());
        x.set_unmingleable(j.at("unmingleable").get<std::string>());
    }

    inline void to_json(json & j, Ressaut const & x) {
        j = json::object();
        j["apperceptive"] = x.get_apperceptive();
        j["cuttoo"] = x.get_cuttoo();
        j["douser"] = x.get_douser();
        j["drinkproof"] = x.get_drinkproof();
        j["forementioned"] = x.get_forementioned();
        j["Freesia"] = x.get_freesia();
        j["Genevieve"] = x.get_genevieve();
        j["hyperdiabolical"] = x.get_hyperdiabolical();
        j["hypocone"] = x.get_hypocone();
        j["irreverentially"] = x.get_irreverentially();
        j["jumart"] = x.get_jumart();
        j["Mimosaceae"] = x.get_mimosaceae();
        j["mollicrush"] = x.get_mollicrush();
        j["nedder"] = x.get_nedder();
        j["retinasphalt"] = x.get_retinasphalt();
        j["sough"] = x.get_sough();
        j["steading"] = x.get_steading();
        j["Theopaschitism"] = x.get_theopaschitism();
        j["undurableness"] = x.get_undurableness();
        j["unmingleable"] = x.get_unmingleable();
    }

    inline void from_json(json const & j, RewriteClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_accountancy(get_untyped(j, "accountancy"));
        x.set_cacotrophic(get_untyped(j, "cacotrophic"));
        x.set_contest(get_untyped(j, "contest"));
        x.set_couthily(get_untyped(j, "couthily"));
        x.set_falculate(get_untyped(j, "falculate"));
        x.set_foreseize(get_untyped(j, "foreseize"));
        x.set_hyades(get_untyped(j, "Hyades"));
        x.set_lemnad(get_untyped(j, "lemnad"));
        x.set_monotheistically(get_untyped(j, "monotheistically"));
        x.set_nonflying(get_untyped(j, "nonflying"));
        x.set_ptenoglossa(get_untyped(j, "Ptenoglossa"));
        x.set_repatch(get_untyped(j, "repatch"));
        x.set_rodman(get_untyped(j, "rodman"));
        x.set_strung(get_untyped(j, "strung"));
        x.set_titmal(get_untyped(j, "titmal"));
        x.set_twalpennyworth(get_untyped(j, "twalpennyworth"));
        x.set_unblamable(get_untyped(j, "unblamable"));
        x.set_vertical(get_untyped(j, "vertical"));
        x.set_whiggification(get_untyped(j, "Whiggification"));
        x.set_yardman(get_untyped(j, "yardman"));
    }

    inline void to_json(json & j, RewriteClass const & x) {
        j = json::object();
        j["accountancy"] = x.get_accountancy();
        j["cacotrophic"] = x.get_cacotrophic();
        j["contest"] = x.get_contest();
        j["couthily"] = x.get_couthily();
        j["falculate"] = x.get_falculate();
        j["foreseize"] = x.get_foreseize();
        j["Hyades"] = x.get_hyades();
        j["lemnad"] = x.get_lemnad();
        j["monotheistically"] = x.get_monotheistically();
        j["nonflying"] = x.get_nonflying();
        j["Ptenoglossa"] = x.get_ptenoglossa();
        j["repatch"] = x.get_repatch();
        j["rodman"] = x.get_rodman();
        j["strung"] = x.get_strung();
        j["titmal"] = x.get_titmal();
        j["twalpennyworth"] = x.get_twalpennyworth();
        j["unblamable"] = x.get_unblamable();
        j["vertical"] = x.get_vertical();
        j["Whiggification"] = x.get_whiggification();
        j["yardman"] = x.get_yardman();
    }

    inline void from_json(json const & j, SantirClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_admiredly(get_untyped(j, "admiredly"));
        x.set_demicaponier(get_untyped(j, "demicaponier"));
        x.set_epitympanic(get_untyped(j, "epitympanic"));
        x.set_investitor(get_untyped(j, "investitor"));
        x.set_lupiform(get_untyped(j, "lupiform"));
        x.set_monoflagellate(get_untyped(j, "monoflagellate"));
        x.set_paleoethnic(get_untyped(j, "paleoethnic"));
        x.set_prediscountable(get_untyped(j, "prediscountable"));
        x.set_rhetoricals(get_untyped(j, "rhetoricals"));
        x.set_roomth(get_untyped(j, "roomth"));
        x.set_saccharose(get_untyped(j, "saccharose"));
        x.set_septonasal(get_untyped(j, "septonasal"));
        x.set_serpenticide(get_untyped(j, "serpenticide"));
        x.set_setarious(get_untyped(j, "setarious"));
        x.set_spaework(get_untyped(j, "spaework"));
        x.set_stylite(get_untyped(j, "stylite"));
        x.set_suessiones(get_untyped(j, "Suessiones"));
        x.set_timelily(get_untyped(j, "timelily"));
        x.set_unprofaned(get_untyped(j, "unprofaned"));
        x.set_vorticular(get_untyped(j, "vorticular"));
    }

    inline void to_json(json & j, SantirClass const & x) {
        j = json::object();
        j["admiredly"] = x.get_admiredly();
        j["demicaponier"] = x.get_demicaponier();
        j["epitympanic"] = x.get_epitympanic();
        j["investitor"] = x.get_investitor();
        j["lupiform"] = x.get_lupiform();
        j["monoflagellate"] = x.get_monoflagellate();
        j["paleoethnic"] = x.get_paleoethnic();
        j["prediscountable"] = x.get_prediscountable();
        j["rhetoricals"] = x.get_rhetoricals();
        j["roomth"] = x.get_roomth();
        j["saccharose"] = x.get_saccharose();
        j["septonasal"] = x.get_septonasal();
        j["serpenticide"] = x.get_serpenticide();
        j["setarious"] = x.get_setarious();
        j["spaework"] = x.get_spaework();
        j["stylite"] = x.get_stylite();
        j["Suessiones"] = x.get_suessiones();
        j["timelily"] = x.get_timelily();
        j["unprofaned"] = x.get_unprofaned();
        j["vorticular"] = x.get_vorticular();
    }

    inline void from_json(json const & j, SaxtenClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_algarrobilla(get_untyped(j, "algarrobilla"));
        x.set_bowgrace(get_untyped(j, "bowgrace"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        x.set_centaurid(get_untyped(j, "Centaurid"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_flix(get_untyped(j, "flix"));
        x.set_germanely(get_untyped(j, "germanely"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_inhume(get_untyped(j, "inhume"));
        x.set_lepidote(get_untyped(j, "lepidote"));
        x.set_megalochirous(get_untyped(j, "megalochirous"));
        x.set_ninepenny(get_untyped(j, "ninepenny"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_nondeist(get_untyped(j, "nondeist"));
        x.set_nymphaeaceous(get_untyped(j, "nymphaeaceous"));
        x.set_parietofrontal(get_untyped(j, "parietofrontal"));
        x.set_sancyite(get_untyped(j, "sancyite"));
        x.set_subjectivist(get_untyped(j, "subjectivist"));
        x.set_tibiad(get_untyped(j, "tibiad"));
        x.set_transonic(get_untyped(j, "transonic"));
        x.set_tripetalous(get_untyped(j, "tripetalous"));
        x.set_trunchman(get_untyped(j, "trunchman"));
        x.set_urger(get_untyped(j, "urger"));
        x.set_withdrawnness(get_untyped(j, "withdrawnness"));
    }

    inline void to_json(json & j, SaxtenClass const & x) {
        j = json::object();
        j["algarrobilla"] = x.get_algarrobilla();
        j["bowgrace"] = x.get_bowgrace();
        j["catharticalness"] = x.get_catharticalness();
        j["Centaurid"] = x.get_centaurid();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["flix"] = x.get_flix();
        j["germanely"] = x.get_germanely();
        j["homocerc"] = x.get_homocerc();
        j["inhume"] = x.get_inhume();
        j["lepidote"] = x.get_lepidote();
        j["megalochirous"] = x.get_megalochirous();
        j["ninepenny"] = x.get_ninepenny();
        j["nonbookish"] = x.get_nonbookish();
        j["nondeist"] = x.get_nondeist();
        j["nymphaeaceous"] = x.get_nymphaeaceous();
        j["parietofrontal"] = x.get_parietofrontal();
        j["sancyite"] = x.get_sancyite();
        j["subjectivist"] = x.get_subjectivist();
        j["tibiad"] = x.get_tibiad();
        j["transonic"] = x.get_transonic();
        j["tripetalous"] = x.get_tripetalous();
        j["trunchman"] = x.get_trunchman();
        j["urger"] = x.get_urger();
        j["withdrawnness"] = x.get_withdrawnness();
    }

    inline void from_json(json const & j, Scatty& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_aeriferous(get_untyped(j, "aeriferous"));
        x.set_antical(get_untyped(j, "antical"));
        x.set_antighostism(get_untyped(j, "antighostism"));
        x.set_arcanum(get_untyped(j, "arcanum"));
        x.set_autotrophy(get_untyped(j, "autotrophy"));
        x.set_baronial(get_untyped(j, "baronial"));
        x.set_caffeine(get_untyped(j, "caffeine"));
        x.set_gorgoniacean(get_untyped(j, "gorgoniacean"));
        x.set_heroical(get_untyped(j, "heroical"));
        x.set_hydropical(get_untyped(j, "hydropical"));
        x.set_mechanology(get_untyped(j, "mechanology"));
        x.set_musicopoetic(get_untyped(j, "musicopoetic"));
        x.set_officiality(get_untyped(j, "officiality"));
        x.set_oftentimes(get_untyped(j, "oftentimes"));
        x.set_ophthalmotonometer(get_untyped(j, "ophthalmotonometer"));
        x.set_reflectively(get_untyped(j, "reflectively"));
        x.set_springer(get_untyped(j, "springer"));
        x.set_tabasco(get_untyped(j, "Tabasco"));
        x.set_teleianthous(get_untyped(j, "teleianthous"));
        x.set_uncombated(get_untyped(j, "uncombated"));
    }

    inline void to_json(json & j, Scatty const & x) {
        j = json::object();
        j["aeriferous"] = x.get_aeriferous();
        j["antical"] = x.get_antical();
        j["antighostism"] = x.get_antighostism();
        j["arcanum"] = x.get_arcanum();
        j["autotrophy"] = x.get_autotrophy();
        j["baronial"] = x.get_baronial();
        j["caffeine"] = x.get_caffeine();
        j["gorgoniacean"] = x.get_gorgoniacean();
        j["heroical"] = x.get_heroical();
        j["hydropical"] = x.get_hydropical();
        j["mechanology"] = x.get_mechanology();
        j["musicopoetic"] = x.get_musicopoetic();
        j["officiality"] = x.get_officiality();
        j["oftentimes"] = x.get_oftentimes();
        j["ophthalmotonometer"] = x.get_ophthalmotonometer();
        j["reflectively"] = x.get_reflectively();
        j["springer"] = x.get_springer();
        j["Tabasco"] = x.get_tabasco();
        j["teleianthous"] = x.get_teleianthous();
        j["uncombated"] = x.get_uncombated();
    }

    inline void from_json(json const & j, SisteringClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_amphicarpic(get_untyped(j, "amphicarpic"));
        x.set_chianti(get_untyped(j, "Chianti"));
        x.set_frigorific(get_untyped(j, "frigorific"));
        x.set_haplomi(get_untyped(j, "Haplomi"));
        x.set_hyperkinesis(get_untyped(j, "hyperkinesis"));
        x.set_laudable(get_untyped(j, "laudable"));
        x.set_madwoman(get_untyped(j, "madwoman"));
        x.set_maimedly(get_untyped(j, "maimedly"));
        x.set_micropterygidae(get_untyped(j, "Micropterygidae"));
        x.set_microrhabdus(get_untyped(j, "microrhabdus"));
        x.set_nondense(get_untyped(j, "nondense"));
        x.set_phlebemphraxis(get_untyped(j, "phlebemphraxis"));
        x.set_redsear(get_untyped(j, "redsear"));
        x.set_schismatical(get_untyped(j, "schismatical"));
        x.set_tartryl(get_untyped(j, "tartryl"));
        x.set_unabhorred(get_untyped(j, "unabhorred"));
        x.set_undeliberateness(get_untyped(j, "undeliberateness"));
        x.set_unmixable(get_untyped(j, "unmixable"));
        x.set_untruckling(get_untyped(j, "untruckling"));
        x.set_vineal(get_untyped(j, "vineal"));
    }

    inline void to_json(json & j, SisteringClass const & x) {
        j = json::object();
        j["amphicarpic"] = x.get_amphicarpic();
        j["Chianti"] = x.get_chianti();
        j["frigorific"] = x.get_frigorific();
        j["Haplomi"] = x.get_haplomi();
        j["hyperkinesis"] = x.get_hyperkinesis();
        j["laudable"] = x.get_laudable();
        j["madwoman"] = x.get_madwoman();
        j["maimedly"] = x.get_maimedly();
        j["Micropterygidae"] = x.get_micropterygidae();
        j["microrhabdus"] = x.get_microrhabdus();
        j["nondense"] = x.get_nondense();
        j["phlebemphraxis"] = x.get_phlebemphraxis();
        j["redsear"] = x.get_redsear();
        j["schismatical"] = x.get_schismatical();
        j["tartryl"] = x.get_tartryl();
        j["unabhorred"] = x.get_unabhorred();
        j["undeliberateness"] = x.get_undeliberateness();
        j["unmixable"] = x.get_unmixable();
        j["untruckling"] = x.get_untruckling();
        j["vineal"] = x.get_vineal();
    }

    inline void from_json(json const & j, Staghunting& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("calorimetric") != j.end() && !j.at("calorimetric").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("calorimetric") != j.end() && j.at("calorimetric").is_null()) throw std::runtime_error("Unexpected null");
        x.set_calorimetric(get_stack_optional<int64_t>(j, "calorimetric"));
        if (j.find("canid") != j.end() && !j.at("canid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("canid") != j.end() && j.at("canid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_canid(get_stack_optional<int64_t>(j, "canid"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("ditriglyphic") != j.end() && !j.at("ditriglyphic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ditriglyphic") != j.end() && j.at("ditriglyphic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ditriglyphic(get_stack_optional<int64_t>(j, "ditriglyphic"));
        if (j.find("floriferousness") != j.end() && !j.at("floriferousness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("floriferousness") != j.end() && j.at("floriferousness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_floriferousness(get_stack_optional<int64_t>(j, "floriferousness"));
        if (j.find("gamelike") != j.end() && !j.at("gamelike").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("gamelike") != j.end() && j.at("gamelike").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gamelike(get_stack_optional<int64_t>(j, "gamelike"));
        if (j.find("grig") != j.end() && !j.at("grig").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("grig") != j.end() && j.at("grig").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grig(get_stack_optional<int64_t>(j, "grig"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("interloan") != j.end() && !j.at("interloan").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("interloan") != j.end() && j.at("interloan").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interloan(get_stack_optional<int64_t>(j, "interloan"));
        if (j.find("lithotomy") != j.end() && !j.at("lithotomy").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lithotomy") != j.end() && j.at("lithotomy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lithotomy(get_stack_optional<int64_t>(j, "lithotomy"));
        if (j.find("loric") != j.end() && !j.at("loric").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("loric") != j.end() && j.at("loric").is_null()) throw std::runtime_error("Unexpected null");
        x.set_loric(get_stack_optional<int64_t>(j, "loric"));
        if (j.find("membranocoriaceous") != j.end() && !j.at("membranocoriaceous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("membranocoriaceous") != j.end() && j.at("membranocoriaceous").is_null()) throw std::runtime_error("Unexpected null");
        x.set_membranocoriaceous(get_stack_optional<int64_t>(j, "membranocoriaceous"));
        if (j.find("membranogenic") != j.end() && !j.at("membranogenic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("membranogenic") != j.end() && j.at("membranogenic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_membranogenic(get_stack_optional<int64_t>(j, "membranogenic"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("overtrump") != j.end() && !j.at("overtrump").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("overtrump") != j.end() && j.at("overtrump").is_null()) throw std::runtime_error("Unexpected null");
        x.set_overtrump(get_stack_optional<int64_t>(j, "overtrump"));
        if (j.find("scotino") != j.end() && !j.at("scotino").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("scotino") != j.end() && j.at("scotino").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scotino(get_stack_optional<int64_t>(j, "scotino"));
        if (j.find("seasonable") != j.end() && !j.at("seasonable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("seasonable") != j.end() && j.at("seasonable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_seasonable(get_stack_optional<int64_t>(j, "seasonable"));
        if (j.find("sephen") != j.end() && !j.at("sephen").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sephen") != j.end() && j.at("sephen").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sephen(get_stack_optional<int64_t>(j, "sephen"));
        if (j.find("stigmarioid") != j.end() && !j.at("stigmarioid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("stigmarioid") != j.end() && j.at("stigmarioid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stigmarioid(get_stack_optional<int64_t>(j, "stigmarioid"));
        if (j.find("tired") != j.end() && !j.at("tired").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tired") != j.end() && j.at("tired").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tired(get_stack_optional<int64_t>(j, "tired"));
        if (j.find("trifid") != j.end() && !j.at("trifid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("trifid") != j.end() && j.at("trifid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_trifid(get_stack_optional<int64_t>(j, "trifid"));
        if (j.find("undefeatedly") != j.end() && !j.at("undefeatedly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("undefeatedly") != j.end() && j.at("undefeatedly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_undefeatedly(get_stack_optional<int64_t>(j, "undefeatedly"));
        if (j.find("ungirlish") != j.end() && !j.at("ungirlish").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ungirlish") != j.end() && j.at("ungirlish").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ungirlish(get_stack_optional<int64_t>(j, "ungirlish"));
    }

    inline void to_json(json & j, Staghunting const & x) {
        j = json::object();
        j["calorimetric"] = x.get_calorimetric();
        j["canid"] = x.get_canid();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["ditriglyphic"] = x.get_ditriglyphic();
        j["floriferousness"] = x.get_floriferousness();
        j["gamelike"] = x.get_gamelike();
        j["grig"] = x.get_grig();
        j["homocerc"] = x.get_homocerc();
        j["interloan"] = x.get_interloan();
        j["lithotomy"] = x.get_lithotomy();
        j["loric"] = x.get_loric();
        j["membranocoriaceous"] = x.get_membranocoriaceous();
        j["membranogenic"] = x.get_membranogenic();
        j["nonbookish"] = x.get_nonbookish();
        j["overtrump"] = x.get_overtrump();
        j["scotino"] = x.get_scotino();
        j["seasonable"] = x.get_seasonable();
        j["sephen"] = x.get_sephen();
        j["stigmarioid"] = x.get_stigmarioid();
        j["tired"] = x.get_tired();
        j["trifid"] = x.get_trifid();
        j["undefeatedly"] = x.get_undefeatedly();
        j["ungirlish"] = x.get_ungirlish();
    }

    inline void from_json(json const & j, StrenuosityClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bliss") != j.end() && !j.at("bliss").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("bliss") != j.end() && j.at("bliss").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bliss(get_stack_optional<int64_t>(j, "bliss"));
        if (j.find("buccate") != j.end() && !j.at("buccate").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("buccate") != j.end() && j.at("buccate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_buccate(get_stack_optional<int64_t>(j, "buccate"));
        if (j.find("bulletproof") != j.end() && !j.at("bulletproof").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("bulletproof") != j.end() && j.at("bulletproof").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bulletproof(get_stack_optional<int64_t>(j, "bulletproof"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("crumblingness") != j.end() && !j.at("crumblingness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("crumblingness") != j.end() && j.at("crumblingness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_crumblingness(get_stack_optional<int64_t>(j, "crumblingness"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("engagedly") != j.end() && !j.at("engagedly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("engagedly") != j.end() && j.at("engagedly").is_null()) throw std::runtime_error("Unexpected null");
        x.set_engagedly(get_stack_optional<int64_t>(j, "engagedly"));
        if (j.find("fightable") != j.end() && !j.at("fightable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("fightable") != j.end() && j.at("fightable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fightable(get_stack_optional<int64_t>(j, "fightable"));
        if (j.find("hoariness") != j.end() && !j.at("hoariness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hoariness") != j.end() && j.at("hoariness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hoariness(get_stack_optional<int64_t>(j, "hoariness"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("hypopodium") != j.end() && !j.at("hypopodium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hypopodium") != j.end() && j.at("hypopodium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hypopodium(get_stack_optional<int64_t>(j, "hypopodium"));
        if (j.find("luxurist") != j.end() && !j.at("luxurist").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("luxurist") != j.end() && j.at("luxurist").is_null()) throw std::runtime_error("Unexpected null");
        x.set_luxurist(get_stack_optional<int64_t>(j, "luxurist"));
        if (j.find("mechanician") != j.end() && !j.at("mechanician").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mechanician") != j.end() && j.at("mechanician").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mechanician(get_stack_optional<int64_t>(j, "mechanician"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("Onopordon") != j.end() && !j.at("Onopordon").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Onopordon") != j.end() && j.at("Onopordon").is_null()) throw std::runtime_error("Unexpected null");
        x.set_onopordon(get_stack_optional<int64_t>(j, "Onopordon"));
        if (j.find("podgily") != j.end() && !j.at("podgily").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("podgily") != j.end() && j.at("podgily").is_null()) throw std::runtime_error("Unexpected null");
        x.set_podgily(get_stack_optional<int64_t>(j, "podgily"));
        if (j.find("reformableness") != j.end() && !j.at("reformableness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("reformableness") != j.end() && j.at("reformableness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reformableness(get_stack_optional<int64_t>(j, "reformableness"));
        if (j.find("scatterbrains") != j.end() && !j.at("scatterbrains").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("scatterbrains") != j.end() && j.at("scatterbrains").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scatterbrains(get_stack_optional<int64_t>(j, "scatterbrains"));
        if (j.find("seminuria") != j.end() && !j.at("seminuria").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("seminuria") != j.end() && j.at("seminuria").is_null()) throw std::runtime_error("Unexpected null");
        x.set_seminuria(get_stack_optional<int64_t>(j, "seminuria"));
        if (j.find("Sodomite") != j.end() && !j.at("Sodomite").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Sodomite") != j.end() && j.at("Sodomite").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sodomite(get_stack_optional<int64_t>(j, "Sodomite"));
        if (j.find("tramp") != j.end() && !j.at("tramp").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tramp") != j.end() && j.at("tramp").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tramp(get_stack_optional<int64_t>(j, "tramp"));
        if (j.find("undueness") != j.end() && !j.at("undueness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("undueness") != j.end() && j.at("undueness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_undueness(get_stack_optional<int64_t>(j, "undueness"));
        if (j.find("worthily") != j.end() && !j.at("worthily").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("worthily") != j.end() && j.at("worthily").is_null()) throw std::runtime_error("Unexpected null");
        x.set_worthily(get_stack_optional<int64_t>(j, "worthily"));
        if (j.find("Yankeeist") != j.end() && !j.at("Yankeeist").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Yankeeist") != j.end() && j.at("Yankeeist").is_null()) throw std::runtime_error("Unexpected null");
        x.set_yankeeist(get_stack_optional<int64_t>(j, "Yankeeist"));
    }

    inline void to_json(json & j, StrenuosityClass const & x) {
        j = json::object();
        j["bliss"] = x.get_bliss();
        j["buccate"] = x.get_buccate();
        j["bulletproof"] = x.get_bulletproof();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["crumblingness"] = x.get_crumblingness();
        j["disdiapason"] = x.get_disdiapason();
        j["engagedly"] = x.get_engagedly();
        j["fightable"] = x.get_fightable();
        j["hoariness"] = x.get_hoariness();
        j["homocerc"] = x.get_homocerc();
        j["hypopodium"] = x.get_hypopodium();
        j["luxurist"] = x.get_luxurist();
        j["mechanician"] = x.get_mechanician();
        j["nonbookish"] = x.get_nonbookish();
        j["Onopordon"] = x.get_onopordon();
        j["podgily"] = x.get_podgily();
        j["reformableness"] = x.get_reformableness();
        j["scatterbrains"] = x.get_scatterbrains();
        j["seminuria"] = x.get_seminuria();
        j["Sodomite"] = x.get_sodomite();
        j["tramp"] = x.get_tramp();
        j["undueness"] = x.get_undueness();
        j["worthily"] = x.get_worthily();
        j["Yankeeist"] = x.get_yankeeist();
    }

    inline void from_json(json const & j, TruantcyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_alfiona(get_untyped(j, "alfiona"));
        x.set_ascaridiasis(get_untyped(j, "ascaridiasis"));
        x.set_bungey(get_untyped(j, "bungey"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        x.set_ceroxyle(get_untyped(j, "ceroxyle"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        x.set_chorology(get_untyped(j, "chorology"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        x.set_enmarble(get_untyped(j, "enmarble"));
        x.set_epeira(get_untyped(j, "Epeira"));
        x.set_eurylaimi(get_untyped(j, "Eurylaimi"));
        x.set_germination(get_untyped(j, "germination"));
        x.set_hallelujah(get_untyped(j, "hallelujah"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        x.set_lev(get_untyped(j, "lev"));
        x.set_mouthing(get_untyped(j, "mouthing"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        x.set_philliloo(get_untyped(j, "philliloo"));
        x.set_planetal(get_untyped(j, "planetal"));
        x.set_poney(get_untyped(j, "poney"));
        x.set_punctualist(get_untyped(j, "punctualist"));
        x.set_returnlessly(get_untyped(j, "returnlessly"));
        x.set_skelder(get_untyped(j, "skelder"));
        x.set_windwaywardly(get_untyped(j, "windwaywardly"));
        x.set_yuman(get_untyped(j, "Yuman"));
    }

    inline void to_json(json & j, TruantcyClass const & x) {
        j = json::object();
        j["alfiona"] = x.get_alfiona();
        j["ascaridiasis"] = x.get_ascaridiasis();
        j["bungey"] = x.get_bungey();
        j["catharticalness"] = x.get_catharticalness();
        j["ceroxyle"] = x.get_ceroxyle();
        j["Chirotherium"] = x.get_chirotherium();
        j["chorology"] = x.get_chorology();
        j["disdiapason"] = x.get_disdiapason();
        j["enmarble"] = x.get_enmarble();
        j["Epeira"] = x.get_epeira();
        j["Eurylaimi"] = x.get_eurylaimi();
        j["germination"] = x.get_germination();
        j["hallelujah"] = x.get_hallelujah();
        j["homocerc"] = x.get_homocerc();
        j["lev"] = x.get_lev();
        j["mouthing"] = x.get_mouthing();
        j["nonbookish"] = x.get_nonbookish();
        j["philliloo"] = x.get_philliloo();
        j["planetal"] = x.get_planetal();
        j["poney"] = x.get_poney();
        j["punctualist"] = x.get_punctualist();
        j["returnlessly"] = x.get_returnlessly();
        j["skelder"] = x.get_skelder();
        j["windwaywardly"] = x.get_windwaywardly();
        j["Yuman"] = x.get_yuman();
    }

    inline void from_json(json const & j, UnimpeachablyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("acerin") != j.end() && !j.at("acerin").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("acerin") != j.end() && j.at("acerin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_acerin(get_stack_optional<int64_t>(j, "acerin"));
        if (j.find("Bobadil") != j.end() && !j.at("Bobadil").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Bobadil") != j.end() && j.at("Bobadil").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bobadil(get_stack_optional<int64_t>(j, "Bobadil"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("chlorophylligenous") != j.end() && !j.at("chlorophylligenous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("chlorophylligenous") != j.end() && j.at("chlorophylligenous").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chlorophylligenous(get_stack_optional<int64_t>(j, "chlorophylligenous"));
        if (j.find("conversational") != j.end() && !j.at("conversational").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("conversational") != j.end() && j.at("conversational").is_null()) throw std::runtime_error("Unexpected null");
        x.set_conversational(get_stack_optional<int64_t>(j, "conversational"));
        if (j.find("demiowl") != j.end() && !j.at("demiowl").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("demiowl") != j.end() && j.at("demiowl").is_null()) throw std::runtime_error("Unexpected null");
        x.set_demiowl(get_stack_optional<int64_t>(j, "demiowl"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("ectorhinal") != j.end() && !j.at("ectorhinal").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ectorhinal") != j.end() && j.at("ectorhinal").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ectorhinal(get_stack_optional<int64_t>(j, "ectorhinal"));
        if (j.find("gamblesomeness") != j.end() && !j.at("gamblesomeness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("gamblesomeness") != j.end() && j.at("gamblesomeness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gamblesomeness(get_stack_optional<int64_t>(j, "gamblesomeness"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("irrorate") != j.end() && !j.at("irrorate").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("irrorate") != j.end() && j.at("irrorate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_irrorate(get_stack_optional<int64_t>(j, "irrorate"));
        if (j.find("kindergartening") != j.end() && !j.at("kindergartening").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("kindergartening") != j.end() && j.at("kindergartening").is_null()) throw std::runtime_error("Unexpected null");
        x.set_kindergartening(get_stack_optional<int64_t>(j, "kindergartening"));
        if (j.find("lateritic") != j.end() && !j.at("lateritic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lateritic") != j.end() && j.at("lateritic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lateritic(get_stack_optional<int64_t>(j, "lateritic"));
        if (j.find("mespil") != j.end() && !j.at("mespil").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mespil") != j.end() && j.at("mespil").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mespil(get_stack_optional<int64_t>(j, "mespil"));
        if (j.find("misconfiguration") != j.end() && !j.at("misconfiguration").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("misconfiguration") != j.end() && j.at("misconfiguration").is_null()) throw std::runtime_error("Unexpected null");
        x.set_misconfiguration(get_stack_optional<int64_t>(j, "misconfiguration"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("planometry") != j.end() && !j.at("planometry").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("planometry") != j.end() && j.at("planometry").is_null()) throw std::runtime_error("Unexpected null");
        x.set_planometry(get_stack_optional<int64_t>(j, "planometry"));
        if (j.find("Quiina") != j.end() && !j.at("Quiina").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Quiina") != j.end() && j.at("Quiina").is_null()) throw std::runtime_error("Unexpected null");
        x.set_quiina(get_stack_optional<int64_t>(j, "Quiina"));
        if (j.find("Robert") != j.end() && !j.at("Robert").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Robert") != j.end() && j.at("Robert").is_null()) throw std::runtime_error("Unexpected null");
        x.set_robert(get_stack_optional<int64_t>(j, "Robert"));
        if (j.find("rot") != j.end() && !j.at("rot").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("rot") != j.end() && j.at("rot").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rot(get_stack_optional<int64_t>(j, "rot"));
        if (j.find("subcinctorium") != j.end() && !j.at("subcinctorium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("subcinctorium") != j.end() && j.at("subcinctorium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_subcinctorium(get_stack_optional<int64_t>(j, "subcinctorium"));
        if (j.find("tussocker") != j.end() && !j.at("tussocker").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tussocker") != j.end() && j.at("tussocker").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tussocker(get_stack_optional<int64_t>(j, "tussocker"));
        if (j.find("ultraproud") != j.end() && !j.at("ultraproud").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ultraproud") != j.end() && j.at("ultraproud").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ultraproud(get_stack_optional<int64_t>(j, "ultraproud"));
        if (j.find("unsuggestedness") != j.end() && !j.at("unsuggestedness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unsuggestedness") != j.end() && j.at("unsuggestedness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unsuggestedness(get_stack_optional<int64_t>(j, "unsuggestedness"));
    }

    inline void to_json(json & j, UnimpeachablyClass const & x) {
        j = json::object();
        j["acerin"] = x.get_acerin();
        j["Bobadil"] = x.get_bobadil();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["chlorophylligenous"] = x.get_chlorophylligenous();
        j["conversational"] = x.get_conversational();
        j["demiowl"] = x.get_demiowl();
        j["disdiapason"] = x.get_disdiapason();
        j["ectorhinal"] = x.get_ectorhinal();
        j["gamblesomeness"] = x.get_gamblesomeness();
        j["homocerc"] = x.get_homocerc();
        j["irrorate"] = x.get_irrorate();
        j["kindergartening"] = x.get_kindergartening();
        j["lateritic"] = x.get_lateritic();
        j["mespil"] = x.get_mespil();
        j["misconfiguration"] = x.get_misconfiguration();
        j["nonbookish"] = x.get_nonbookish();
        j["planometry"] = x.get_planometry();
        j["Quiina"] = x.get_quiina();
        j["Robert"] = x.get_robert();
        j["rot"] = x.get_rot();
        j["subcinctorium"] = x.get_subcinctorium();
        j["tussocker"] = x.get_tussocker();
        j["ultraproud"] = x.get_ultraproud();
        j["unsuggestedness"] = x.get_unsuggestedness();
    }

    inline void from_json(json const & j, UnstressedClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_alain(get_untyped(j, "Alain"));
        x.set_amphirhina(get_untyped(j, "Amphirhina"));
        x.set_antimachinery(get_untyped(j, "antimachinery"));
        x.set_coldish(get_untyped(j, "coldish"));
        x.set_crantara(get_untyped(j, "crantara"));
        x.set_distinguishing(get_untyped(j, "distinguishing"));
        x.set_elytroposis(get_untyped(j, "elytroposis"));
        x.set_gentianwort(get_untyped(j, "gentianwort"));
        x.set_heliosis(get_untyped(j, "heliosis"));
        x.set_instrumental(get_untyped(j, "instrumental"));
        x.set_introinflection(get_untyped(j, "introinflection"));
        x.set_kala(get_untyped(j, "kala"));
        x.set_lincolnian(get_untyped(j, "Lincolnian"));
        x.set_metad(get_untyped(j, "metad"));
        x.set_sarcophilus(get_untyped(j, "Sarcophilus"));
        x.set_swingingly(get_untyped(j, "swingingly"));
        x.set_unconformity(get_untyped(j, "unconformity"));
        x.set_undecreed(get_untyped(j, "undecreed"));
        x.set_venerable(get_untyped(j, "venerable"));
        x.set_vowellessness(get_untyped(j, "vowellessness"));
    }

    inline void to_json(json & j, UnstressedClass const & x) {
        j = json::object();
        j["Alain"] = x.get_alain();
        j["Amphirhina"] = x.get_amphirhina();
        j["antimachinery"] = x.get_antimachinery();
        j["coldish"] = x.get_coldish();
        j["crantara"] = x.get_crantara();
        j["distinguishing"] = x.get_distinguishing();
        j["elytroposis"] = x.get_elytroposis();
        j["gentianwort"] = x.get_gentianwort();
        j["heliosis"] = x.get_heliosis();
        j["instrumental"] = x.get_instrumental();
        j["introinflection"] = x.get_introinflection();
        j["kala"] = x.get_kala();
        j["Lincolnian"] = x.get_lincolnian();
        j["metad"] = x.get_metad();
        j["Sarcophilus"] = x.get_sarcophilus();
        j["swingingly"] = x.get_swingingly();
        j["unconformity"] = x.get_unconformity();
        j["undecreed"] = x.get_undecreed();
        j["venerable"] = x.get_venerable();
        j["vowellessness"] = x.get_vowellessness();
    }

    inline void from_json(json const & j, WrothyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_aeschynanthus(get_untyped(j, "Aeschynanthus"));
        x.set_aquiferous(get_untyped(j, "aquiferous"));
        x.set_cheapener(get_untyped(j, "cheapener"));
        x.set_enumeration(get_untyped(j, "enumeration"));
        x.set_ephesine(get_untyped(j, "Ephesine"));
        x.set_escadrille(get_untyped(j, "escadrille"));
        x.set_estrous(get_untyped(j, "estrous"));
        x.set_interestedly(get_untyped(j, "interestedly"));
        x.set_katakinetomer(get_untyped(j, "katakinetomer"));
        x.set_mortification(get_untyped(j, "mortification"));
        x.set_morula(get_untyped(j, "morula"));
        x.set_orthosymmetrical(get_untyped(j, "orthosymmetrical"));
        x.set_overbark(get_untyped(j, "overbark"));
        x.set_politist(get_untyped(j, "politist"));
        x.set_qualified(get_untyped(j, "qualified"));
        x.set_sphenomalar(get_untyped(j, "sphenomalar"));
        x.set_throatful(get_untyped(j, "throatful"));
        x.set_transhumance(get_untyped(j, "transhumance"));
        x.set_triandrian(get_untyped(j, "triandrian"));
        x.set_unbooked(get_untyped(j, "unbooked"));
    }

    inline void to_json(json & j, WrothyClass const & x) {
        j = json::object();
        j["Aeschynanthus"] = x.get_aeschynanthus();
        j["aquiferous"] = x.get_aquiferous();
        j["cheapener"] = x.get_cheapener();
        j["enumeration"] = x.get_enumeration();
        j["Ephesine"] = x.get_ephesine();
        j["escadrille"] = x.get_escadrille();
        j["estrous"] = x.get_estrous();
        j["interestedly"] = x.get_interestedly();
        j["katakinetomer"] = x.get_katakinetomer();
        j["mortification"] = x.get_mortification();
        j["morula"] = x.get_morula();
        j["orthosymmetrical"] = x.get_orthosymmetrical();
        j["overbark"] = x.get_overbark();
        j["politist"] = x.get_politist();
        j["qualified"] = x.get_qualified();
        j["sphenomalar"] = x.get_sphenomalar();
        j["throatful"] = x.get_throatful();
        j["transhumance"] = x.get_transhumance();
        j["triandrian"] = x.get_triandrian();
        j["unbooked"] = x.get_unbooked();
    }

    inline void from_json(json const & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_protrusive(j.at("protrusive").get<std::vector<Protrusive>>());
        x.set_pulpitism(j.at("pulpitism").get<std::vector<PulpitismElement>>());
        x.set_pyodermia(j.at("pyodermia").get<std::vector<PyodermiaElement>>());
        x.set_quebrachine(j.at("quebrachine").get<std::vector<QuebrachineElement>>());
        x.set_querier(j.at("querier").get<std::vector<Querier>>());
        x.set_rebarbative(j.at("rebarbative").get<std::vector<Rebarbative>>());
        x.set_reimagine(j.at("reimagine").get<std::vector<Reimagine>>());
        x.set_ressaut(j.at("ressaut").get<Ressaut>());
        x.set_retrocervical(j.at("retrocervical").get<std::vector<Retrocervical>>());
        x.set_revert(j.at("revert").get<std::vector<Revert>>());
        x.set_rewrite(j.at("rewrite").get<std::vector<RewriteElement>>());
        x.set_saccoderm(j.at("saccoderm").get<std::vector<Saccoderm>>());
        x.set_santir(j.at("santir").get<std::vector<SantirElement>>());
        x.set_saprophilous(j.at("saprophilous").get<std::vector<Saprophilous>>());
        x.set_saxten(j.at("saxten").get<std::vector<SaxtenElement>>());
        x.set_scatty(j.at("scatty").get<std::vector<std::optional<Scatty>>>());
        x.set_scoffer(j.at("scoffer").get<std::vector<Scoffer>>());
        x.set_scrampum(j.at("scrampum").get<std::vector<Scrampum>>());
        x.set_semantic(j.at("semantic").get<double>());
        x.set_serpentinic(j.at("serpentinic").get<std::vector<Serpentinic>>());
        x.set_shadowable(j.at("shadowable").get<std::vector<Shadowable>>());
        x.set_sistering(j.at("sistering").get<std::vector<SisteringElement>>());
        x.set_staghunting(j.at("staghunting").get<std::vector<Staghunting>>());
        x.set_stagmometer(j.at("stagmometer").get<std::vector<Stagmometer>>());
        x.set_stimulability(j.at("stimulability").get<std::vector<Stimulability>>());
        x.set_strangleable(j.at("strangleable").get<std::vector<Strangleable>>());
        x.set_strenuosity(j.at("strenuosity").get<std::vector<StrenuosityElement>>());
        x.set_tabaxir(j.at("tabaxir").get<std::vector<Tabaxir>>());
        x.set_talpiform(j.at("talpiform").get<std::vector<Talpiform>>());
        x.set_thwack(j.at("thwack").get<std::vector<Thwack>>());
        x.set_to(j.at("to").get<std::vector<std::optional<double>>>());
        x.set_tortricine(j.at("tortricine").get<std::vector<Tortricine>>());
        x.set_truantcy(j.at("truantcy").get<std::vector<TruantcyElement>>());
        x.set_turgesce(j.at("turgesce").get<std::vector<std::string>>());
        x.set_unbeginning(j.at("unbeginning").get<std::vector<Unbeginning>>());
        x.set_underdunged(j.at("underdunged").get<std::vector<double>>());
        x.set_undesirability(j.at("undesirability").get<std::vector<Undesirability>>());
        x.set_unerasing(j.at("unerasing").get<std::vector<Unerasing>>());
        x.set_unguentarium(j.at("unguentarium").get<std::vector<Unguentarium>>());
        x.set_unimpeachably(j.at("unimpeachably").get<std::vector<UnimpeachablyElement>>());
        x.set_unmortgaged(j.at("unmortgaged").get<std::vector<Unmortgaged>>());
        x.set_unobstructed(j.at("unobstructed").get<std::vector<Unobstructed>>());
        x.set_unreceptivity(j.at("unreceptivity").get<std::vector<Unreceptivity>>());
        x.set_unsatisfactoriness(j.at("unsatisfactoriness").get<std::vector<Unsatisfactoriness>>());
        x.set_unsecurity(j.at("unsecurity").get<std::vector<int64_t>>());
        x.set_unstressed(j.at("unstressed").get<std::vector<UnstressedElement>>());
        x.set_untasked(j.at("untasked").get<std::vector<Untasked>>());
        x.set_unvarying(j.at("unvarying").get<std::vector<Unvarying>>());
        x.set_vehemently(j.at("vehemently").get<std::vector<Vehemently>>());
        x.set_warriorship(j.at("warriorship").get<std::map<std::string, bool>>());
        x.set_whitepot(j.at("whitepot").get<std::vector<Whitepot>>());
        x.set_wrothy(j.at("wrothy").get<std::vector<WrothyElement>>());
    }

    inline void to_json(json & j, TopLevel const & x) {
        j = json::object();
        j["protrusive"] = x.get_protrusive();
        j["pulpitism"] = x.get_pulpitism();
        j["pyodermia"] = x.get_pyodermia();
        j["quebrachine"] = x.get_quebrachine();
        j["querier"] = x.get_querier();
        j["rebarbative"] = x.get_rebarbative();
        j["reimagine"] = x.get_reimagine();
        j["ressaut"] = x.get_ressaut();
        j["retrocervical"] = x.get_retrocervical();
        j["revert"] = x.get_revert();
        j["rewrite"] = x.get_rewrite();
        j["saccoderm"] = x.get_saccoderm();
        j["santir"] = x.get_santir();
        j["saprophilous"] = x.get_saprophilous();
        j["saxten"] = x.get_saxten();
        j["scatty"] = x.get_scatty();
        j["scoffer"] = x.get_scoffer();
        j["scrampum"] = x.get_scrampum();
        j["semantic"] = x.get_semantic();
        j["serpentinic"] = x.get_serpentinic();
        j["shadowable"] = x.get_shadowable();
        j["sistering"] = x.get_sistering();
        j["staghunting"] = x.get_staghunting();
        j["stagmometer"] = x.get_stagmometer();
        j["stimulability"] = x.get_stimulability();
        j["strangleable"] = x.get_strangleable();
        j["strenuosity"] = x.get_strenuosity();
        j["tabaxir"] = x.get_tabaxir();
        j["talpiform"] = x.get_talpiform();
        j["thwack"] = x.get_thwack();
        j["to"] = x.get_to();
        j["tortricine"] = x.get_tortricine();
        j["truantcy"] = x.get_truantcy();
        j["turgesce"] = x.get_turgesce();
        j["unbeginning"] = x.get_unbeginning();
        j["underdunged"] = x.get_underdunged();
        j["undesirability"] = x.get_undesirability();
        j["unerasing"] = x.get_unerasing();
        j["unguentarium"] = x.get_unguentarium();
        j["unimpeachably"] = x.get_unimpeachably();
        j["unmortgaged"] = x.get_unmortgaged();
        j["unobstructed"] = x.get_unobstructed();
        j["unreceptivity"] = x.get_unreceptivity();
        j["unsatisfactoriness"] = x.get_unsatisfactoriness();
        j["unsecurity"] = x.get_unsecurity();
        j["unstressed"] = x.get_unstressed();
        j["untasked"] = x.get_untasked();
        j["unvarying"] = x.get_unvarying();
        j["vehemently"] = x.get_vehemently();
        j["warriorship"] = x.get_warriorship();
        j["whitepot"] = x.get_whitepot();
        j["wrothy"] = x.get_wrothy();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, double>>::from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, double>>::to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::PulpitismClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::PulpitismClass>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::PyodermiaClass, int64_t>>::from_json(json const & j, std::variant<quicktype::PyodermiaClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::PyodermiaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PyodermiaClass, int64_t>>::to_json(json & j, std::variant<quicktype::PyodermiaClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::PyodermiaClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass>>::from_json(json const & j, std::variant<bool, quicktype::QuebrachineClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass>>::to_json(json & j, std::variant<bool, quicktype::QuebrachineClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::QuebrachineClass>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, double>>::from_json(json const & j, std::variant<std::vector<int64_t>, bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, double>>::to_json(json & j, std::variant<std::vector<int64_t>, bool, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, int64_t>>::from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, int64_t>>::to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::RewriteClass, double>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::RewriteClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::RewriteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::RewriteClass, double>>::to_json(json & j, std::variant<std::vector<json>, quicktype::RewriteClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::RewriteClass>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::string>>::from_json(json const & j, std::variant<std::vector<int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::string>>::to_json(json & j, std::variant<std::vector<int64_t>, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SantirClass, double>>::from_json(json const & j, std::variant<quicktype::SantirClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SantirClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SantirClass, double>>::to_json(json & j, std::variant<quicktype::SantirClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SantirClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
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

    inline void adl_serializer<std::variant<quicktype::SaxtenClass, std::string>>::from_json(json const & j, std::variant<quicktype::SaxtenClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::SaxtenClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SaxtenClass, std::string>>::to_json(json & j, std::variant<quicktype::SaxtenClass, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SaxtenClass>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool>>::from_json(json const & j, std::variant<std::vector<int64_t>, bool> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool>>::to_json(json & j, std::variant<std::vector<int64_t>, bool> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, bool>>::from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, bool> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, bool>>::to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, bool> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::SisteringClass, int64_t>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::SisteringClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::SisteringClass, int64_t>>::to_json(json & j, std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::SisteringClass>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::string>>::from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::string>>::to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, int64_t, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<bool, int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, int64_t, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<bool, int64_t, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            case 2:
                j = std::get<std::map<std::string, int64_t>>(x);
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::StrenuosityClass>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::StrenuosityClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::StrenuosityClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::StrenuosityClass>>::to_json(json & j, std::variant<std::vector<json>, quicktype::StrenuosityClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::StrenuosityClass>(x);
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

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, double>>::from_json(json const & j, std::variant<quicktype::QuebrachineClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, double>>::to_json(json & j, std::variant<quicktype::QuebrachineClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::QuebrachineClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass, double>>::from_json(json const & j, std::variant<bool, quicktype::QuebrachineClass, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass, double>>::to_json(json & j, std::variant<bool, quicktype::QuebrachineClass, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::QuebrachineClass>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass>>::from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass>>::to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<quicktype::QuebrachineClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::TruantcyClass>>::from_json(json const & j, std::variant<bool, quicktype::TruantcyClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::TruantcyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::TruantcyClass>>::to_json(json & j, std::variant<bool, quicktype::TruantcyClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::TruantcyClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string>>::from_json(json const & j, std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string>>::to_json(json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>>::from_json(json const & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>>::to_json(json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
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

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            case 2:
                j = std::get<std::map<std::string, int64_t>>(x);
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

    inline void adl_serializer<std::variant<bool, quicktype::UnimpeachablyClass>>::from_json(json const & j, std::variant<bool, quicktype::UnimpeachablyClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::UnimpeachablyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::UnimpeachablyClass>>::to_json(json & j, std::variant<bool, quicktype::UnimpeachablyClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::UnimpeachablyClass>(x);
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

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, int64_t>>::from_json(json const & j, std::variant<quicktype::QuebrachineClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, int64_t>>::to_json(json & j, std::variant<quicktype::QuebrachineClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::QuebrachineClass>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::string>>::from_json(json const & j, std::variant<std::vector<json>, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::string>>::to_json(json & j, std::variant<std::vector<json>, int64_t, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, int64_t>>::from_json(json const & j, std::variant<std::vector<int64_t>, bool, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, int64_t>>::to_json(json & j, std::variant<std::vector<int64_t>, bool, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
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

    inline void adl_serializer<std::variant<bool, quicktype::UnstressedClass, std::string>>::from_json(json const & j, std::variant<bool, quicktype::UnstressedClass, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::UnstressedClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::UnstressedClass, std::string>>::to_json(json & j, std::variant<bool, quicktype::UnstressedClass, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::UnstressedClass>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, double, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<json>, double, std::map<std::string, int64_t>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, double, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<json>, double, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, double, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<bool, double, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<bool, double, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<std::map<std::string, int64_t>>(x);
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::WrothyClass>>::from_json(json const & j, std::variant<std::vector<json>, quicktype::WrothyClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::WrothyClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::WrothyClass>>::to_json(json & j, std::variant<std::vector<json>, quicktype::WrothyClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::WrothyClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
