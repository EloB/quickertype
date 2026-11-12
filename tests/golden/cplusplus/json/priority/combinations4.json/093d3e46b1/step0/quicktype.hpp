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
        const nlohmann::json & get_abnet() const { return abnet; }
        nlohmann::json & get_mutable_abnet() { return abnet; }
        void set_abnet(const nlohmann::json & value) { this->abnet = value; }

        const nlohmann::json & get_buckhorn() const { return buckhorn; }
        nlohmann::json & get_mutable_buckhorn() { return buckhorn; }
        void set_buckhorn(const nlohmann::json & value) { this->buckhorn = value; }

        const nlohmann::json & get_calciform() const { return calciform; }
        nlohmann::json & get_mutable_calciform() { return calciform; }
        void set_calciform(const nlohmann::json & value) { this->calciform = value; }

        const nlohmann::json & get_chelophore() const { return chelophore; }
        nlohmann::json & get_mutable_chelophore() { return chelophore; }
        void set_chelophore(const nlohmann::json & value) { this->chelophore = value; }

        const nlohmann::json & get_cogitation() const { return cogitation; }
        nlohmann::json & get_mutable_cogitation() { return cogitation; }
        void set_cogitation(const nlohmann::json & value) { this->cogitation = value; }

        const nlohmann::json & get_decreeable() const { return decreeable; }
        nlohmann::json & get_mutable_decreeable() { return decreeable; }
        void set_decreeable(const nlohmann::json & value) { this->decreeable = value; }

        const nlohmann::json & get_despicable() const { return despicable; }
        nlohmann::json & get_mutable_despicable() { return despicable; }
        void set_despicable(const nlohmann::json & value) { this->despicable = value; }

        const nlohmann::json & get_isodiazo() const { return isodiazo; }
        nlohmann::json & get_mutable_isodiazo() { return isodiazo; }
        void set_isodiazo(const nlohmann::json & value) { this->isodiazo = value; }

        const nlohmann::json & get_jadedly() const { return jadedly; }
        nlohmann::json & get_mutable_jadedly() { return jadedly; }
        void set_jadedly(const nlohmann::json & value) { this->jadedly = value; }

        const nlohmann::json & get_leptochlorite() const { return leptochlorite; }
        nlohmann::json & get_mutable_leptochlorite() { return leptochlorite; }
        void set_leptochlorite(const nlohmann::json & value) { this->leptochlorite = value; }

        const nlohmann::json & get_nursling() const { return nursling; }
        nlohmann::json & get_mutable_nursling() { return nursling; }
        void set_nursling(const nlohmann::json & value) { this->nursling = value; }

        const nlohmann::json & get_palamedean() const { return palamedean; }
        nlohmann::json & get_mutable_palamedean() { return palamedean; }
        void set_palamedean(const nlohmann::json & value) { this->palamedean = value; }

        const nlohmann::json & get_photoheliograph() const { return photoheliograph; }
        nlohmann::json & get_mutable_photoheliograph() { return photoheliograph; }
        void set_photoheliograph(const nlohmann::json & value) { this->photoheliograph = value; }

        const nlohmann::json & get_pipewood() const { return pipewood; }
        nlohmann::json & get_mutable_pipewood() { return pipewood; }
        void set_pipewood(const nlohmann::json & value) { this->pipewood = value; }

        const nlohmann::json & get_roberd() const { return roberd; }
        nlohmann::json & get_mutable_roberd() { return roberd; }
        void set_roberd(const nlohmann::json & value) { this->roberd = value; }

        const nlohmann::json & get_statable() const { return statable; }
        nlohmann::json & get_mutable_statable() { return statable; }
        void set_statable(const nlohmann::json & value) { this->statable = value; }

        const nlohmann::json & get_superassume() const { return superassume; }
        nlohmann::json & get_mutable_superassume() { return superassume; }
        void set_superassume(const nlohmann::json & value) { this->superassume = value; }

        const nlohmann::json & get_syllabe() const { return syllabe; }
        nlohmann::json & get_mutable_syllabe() { return syllabe; }
        void set_syllabe(const nlohmann::json & value) { this->syllabe = value; }

        const nlohmann::json & get_toughhead() const { return toughhead; }
        nlohmann::json & get_mutable_toughhead() { return toughhead; }
        void set_toughhead(const nlohmann::json & value) { this->toughhead = value; }

        const nlohmann::json & get_underburn() const { return underburn; }
        nlohmann::json & get_mutable_underburn() { return underburn; }
        void set_underburn(const nlohmann::json & value) { this->underburn = value; }
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
        const nlohmann::json & get_aphoristically() const { return aphoristically; }
        nlohmann::json & get_mutable_aphoristically() { return aphoristically; }
        void set_aphoristically(const nlohmann::json & value) { this->aphoristically = value; }

        const nlohmann::json & get_apophyllous() const { return apophyllous; }
        nlohmann::json & get_mutable_apophyllous() { return apophyllous; }
        void set_apophyllous(const nlohmann::json & value) { this->apophyllous = value; }

        const nlohmann::json & get_cognize() const { return cognize; }
        nlohmann::json & get_mutable_cognize() { return cognize; }
        void set_cognize(const nlohmann::json & value) { this->cognize = value; }

        const nlohmann::json & get_dermonosology() const { return dermonosology; }
        nlohmann::json & get_mutable_dermonosology() { return dermonosology; }
        void set_dermonosology(const nlohmann::json & value) { this->dermonosology = value; }

        const nlohmann::json & get_gyppo() const { return gyppo; }
        nlohmann::json & get_mutable_gyppo() { return gyppo; }
        void set_gyppo(const nlohmann::json & value) { this->gyppo = value; }

        const nlohmann::json & get_ither() const { return ither; }
        nlohmann::json & get_mutable_ither() { return ither; }
        void set_ither(const nlohmann::json & value) { this->ither = value; }

        const nlohmann::json & get_juglandaceous() const { return juglandaceous; }
        nlohmann::json & get_mutable_juglandaceous() { return juglandaceous; }
        void set_juglandaceous(const nlohmann::json & value) { this->juglandaceous = value; }

        const nlohmann::json & get_litho() const { return litho; }
        nlohmann::json & get_mutable_litho() { return litho; }
        void set_litho(const nlohmann::json & value) { this->litho = value; }

        const nlohmann::json & get_macropterous() const { return macropterous; }
        nlohmann::json & get_mutable_macropterous() { return macropterous; }
        void set_macropterous(const nlohmann::json & value) { this->macropterous = value; }

        const nlohmann::json & get_photographer() const { return photographer; }
        nlohmann::json & get_mutable_photographer() { return photographer; }
        void set_photographer(const nlohmann::json & value) { this->photographer = value; }

        const nlohmann::json & get_romancing() const { return romancing; }
        nlohmann::json & get_mutable_romancing() { return romancing; }
        void set_romancing(const nlohmann::json & value) { this->romancing = value; }

        const nlohmann::json & get_rumness() const { return rumness; }
        nlohmann::json & get_mutable_rumness() { return rumness; }
        void set_rumness(const nlohmann::json & value) { this->rumness = value; }

        const nlohmann::json & get_somniloquist() const { return somniloquist; }
        nlohmann::json & get_mutable_somniloquist() { return somniloquist; }
        void set_somniloquist(const nlohmann::json & value) { this->somniloquist = value; }

        const nlohmann::json & get_stressfully() const { return stressfully; }
        nlohmann::json & get_mutable_stressfully() { return stressfully; }
        void set_stressfully(const nlohmann::json & value) { this->stressfully = value; }

        const nlohmann::json & get_tactically() const { return tactically; }
        nlohmann::json & get_mutable_tactically() { return tactically; }
        void set_tactically(const nlohmann::json & value) { this->tactically = value; }

        const nlohmann::json & get_tracheophony() const { return tracheophony; }
        nlohmann::json & get_mutable_tracheophony() { return tracheophony; }
        void set_tracheophony(const nlohmann::json & value) { this->tracheophony = value; }

        const nlohmann::json & get_unappositely() const { return unappositely; }
        nlohmann::json & get_mutable_unappositely() { return unappositely; }
        void set_unappositely(const nlohmann::json & value) { this->unappositely = value; }

        const nlohmann::json & get_unclothedly() const { return unclothedly; }
        nlohmann::json & get_mutable_unclothedly() { return unclothedly; }
        void set_unclothedly(const nlohmann::json & value) { this->unclothedly = value; }

        const nlohmann::json & get_unimplied() const { return unimplied; }
        nlohmann::json & get_mutable_unimplied() { return unimplied; }
        void set_unimplied(const nlohmann::json & value) { this->unimplied = value; }

        const nlohmann::json & get_unsyncopated() const { return unsyncopated; }
        nlohmann::json & get_mutable_unsyncopated() { return unsyncopated; }
        void set_unsyncopated(const nlohmann::json & value) { this->unsyncopated = value; }
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
        const nlohmann::json & get_adducible() const { return adducible; }
        nlohmann::json & get_mutable_adducible() { return adducible; }
        void set_adducible(const nlohmann::json & value) { this->adducible = value; }

        const nlohmann::json & get_anabolin() const { return anabolin; }
        nlohmann::json & get_mutable_anabolin() { return anabolin; }
        void set_anabolin(const nlohmann::json & value) { this->anabolin = value; }

        const nlohmann::json & get_brainy() const { return brainy; }
        nlohmann::json & get_mutable_brainy() { return brainy; }
        void set_brainy(const nlohmann::json & value) { this->brainy = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const nlohmann::json & get_chrysamine() const { return chrysamine; }
        nlohmann::json & get_mutable_chrysamine() { return chrysamine; }
        void set_chrysamine(const nlohmann::json & value) { this->chrysamine = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const nlohmann::json & get_fluxweed() const { return fluxweed; }
        nlohmann::json & get_mutable_fluxweed() { return fluxweed; }
        void set_fluxweed(const nlohmann::json & value) { this->fluxweed = value; }

        const nlohmann::json & get_glaucine() const { return glaucine; }
        nlohmann::json & get_mutable_glaucine() { return glaucine; }
        void set_glaucine(const nlohmann::json & value) { this->glaucine = value; }

        const nlohmann::json & get_grobianism() const { return grobianism; }
        nlohmann::json & get_mutable_grobianism() { return grobianism; }
        void set_grobianism(const nlohmann::json & value) { this->grobianism = value; }

        const nlohmann::json & get_hermo() const { return hermo; }
        nlohmann::json & get_mutable_hermo() { return hermo; }
        void set_hermo(const nlohmann::json & value) { this->hermo = value; }

        const nlohmann::json & get_hieroglyphist() const { return hieroglyphist; }
        nlohmann::json & get_mutable_hieroglyphist() { return hieroglyphist; }
        void set_hieroglyphist(const nlohmann::json & value) { this->hieroglyphist = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const nlohmann::json & get_icteroid() const { return icteroid; }
        nlohmann::json & get_mutable_icteroid() { return icteroid; }
        void set_icteroid(const nlohmann::json & value) { this->icteroid = value; }

        const nlohmann::json & get_immortal() const { return immortal; }
        nlohmann::json & get_mutable_immortal() { return immortal; }
        void set_immortal(const nlohmann::json & value) { this->immortal = value; }

        const nlohmann::json & get_impetulant() const { return impetulant; }
        nlohmann::json & get_mutable_impetulant() { return impetulant; }
        void set_impetulant(const nlohmann::json & value) { this->impetulant = value; }

        const nlohmann::json & get_irrigate() const { return irrigate; }
        nlohmann::json & get_mutable_irrigate() { return irrigate; }
        void set_irrigate(const nlohmann::json & value) { this->irrigate = value; }

        const nlohmann::json & get_myxedema() const { return myxedema; }
        nlohmann::json & get_mutable_myxedema() { return myxedema; }
        void set_myxedema(const nlohmann::json & value) { this->myxedema = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const nlohmann::json & get_onyx() const { return onyx; }
        nlohmann::json & get_mutable_onyx() { return onyx; }
        void set_onyx(const nlohmann::json & value) { this->onyx = value; }

        const nlohmann::json & get_repasser() const { return repasser; }
        nlohmann::json & get_mutable_repasser() { return repasser; }
        void set_repasser(const nlohmann::json & value) { this->repasser = value; }

        const nlohmann::json & get_septomarginal() const { return septomarginal; }
        nlohmann::json & get_mutable_septomarginal() { return septomarginal; }
        void set_septomarginal(const nlohmann::json & value) { this->septomarginal = value; }

        const nlohmann::json & get_subdie() const { return subdie; }
        nlohmann::json & get_mutable_subdie() { return subdie; }
        void set_subdie(const nlohmann::json & value) { this->subdie = value; }

        const nlohmann::json & get_tibiometatarsal() const { return tibiometatarsal; }
        nlohmann::json & get_mutable_tibiometatarsal() { return tibiometatarsal; }
        void set_tibiometatarsal(const nlohmann::json & value) { this->tibiometatarsal = value; }

        const nlohmann::json & get_waltzlike() const { return waltzlike; }
        nlohmann::json & get_mutable_waltzlike() { return waltzlike; }
        void set_waltzlike(const nlohmann::json & value) { this->waltzlike = value; }
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
        const std::string & get_apperceptive() const { return apperceptive; }
        std::string & get_mutable_apperceptive() { return apperceptive; }
        void set_apperceptive(const std::string & value) { this->apperceptive = value; }

        const std::string & get_cuttoo() const { return cuttoo; }
        std::string & get_mutable_cuttoo() { return cuttoo; }
        void set_cuttoo(const std::string & value) { this->cuttoo = value; }

        const std::string & get_douser() const { return douser; }
        std::string & get_mutable_douser() { return douser; }
        void set_douser(const std::string & value) { this->douser = value; }

        const std::string & get_drinkproof() const { return drinkproof; }
        std::string & get_mutable_drinkproof() { return drinkproof; }
        void set_drinkproof(const std::string & value) { this->drinkproof = value; }

        const std::string & get_forementioned() const { return forementioned; }
        std::string & get_mutable_forementioned() { return forementioned; }
        void set_forementioned(const std::string & value) { this->forementioned = value; }

        const std::string & get_freesia() const { return freesia; }
        std::string & get_mutable_freesia() { return freesia; }
        void set_freesia(const std::string & value) { this->freesia = value; }

        const std::string & get_genevieve() const { return genevieve; }
        std::string & get_mutable_genevieve() { return genevieve; }
        void set_genevieve(const std::string & value) { this->genevieve = value; }

        const std::string & get_hyperdiabolical() const { return hyperdiabolical; }
        std::string & get_mutable_hyperdiabolical() { return hyperdiabolical; }
        void set_hyperdiabolical(const std::string & value) { this->hyperdiabolical = value; }

        const std::string & get_hypocone() const { return hypocone; }
        std::string & get_mutable_hypocone() { return hypocone; }
        void set_hypocone(const std::string & value) { this->hypocone = value; }

        const std::string & get_irreverentially() const { return irreverentially; }
        std::string & get_mutable_irreverentially() { return irreverentially; }
        void set_irreverentially(const std::string & value) { this->irreverentially = value; }

        const std::string & get_jumart() const { return jumart; }
        std::string & get_mutable_jumart() { return jumart; }
        void set_jumart(const std::string & value) { this->jumart = value; }

        const std::string & get_mimosaceae() const { return mimosaceae; }
        std::string & get_mutable_mimosaceae() { return mimosaceae; }
        void set_mimosaceae(const std::string & value) { this->mimosaceae = value; }

        const std::string & get_mollicrush() const { return mollicrush; }
        std::string & get_mutable_mollicrush() { return mollicrush; }
        void set_mollicrush(const std::string & value) { this->mollicrush = value; }

        const std::string & get_nedder() const { return nedder; }
        std::string & get_mutable_nedder() { return nedder; }
        void set_nedder(const std::string & value) { this->nedder = value; }

        const std::string & get_retinasphalt() const { return retinasphalt; }
        std::string & get_mutable_retinasphalt() { return retinasphalt; }
        void set_retinasphalt(const std::string & value) { this->retinasphalt = value; }

        const std::string & get_sough() const { return sough; }
        std::string & get_mutable_sough() { return sough; }
        void set_sough(const std::string & value) { this->sough = value; }

        const std::string & get_steading() const { return steading; }
        std::string & get_mutable_steading() { return steading; }
        void set_steading(const std::string & value) { this->steading = value; }

        const std::string & get_theopaschitism() const { return theopaschitism; }
        std::string & get_mutable_theopaschitism() { return theopaschitism; }
        void set_theopaschitism(const std::string & value) { this->theopaschitism = value; }

        const std::string & get_undurableness() const { return undurableness; }
        std::string & get_mutable_undurableness() { return undurableness; }
        void set_undurableness(const std::string & value) { this->undurableness = value; }

        const std::string & get_unmingleable() const { return unmingleable; }
        std::string & get_mutable_unmingleable() { return unmingleable; }
        void set_unmingleable(const std::string & value) { this->unmingleable = value; }
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
        const nlohmann::json & get_accountancy() const { return accountancy; }
        nlohmann::json & get_mutable_accountancy() { return accountancy; }
        void set_accountancy(const nlohmann::json & value) { this->accountancy = value; }

        const nlohmann::json & get_cacotrophic() const { return cacotrophic; }
        nlohmann::json & get_mutable_cacotrophic() { return cacotrophic; }
        void set_cacotrophic(const nlohmann::json & value) { this->cacotrophic = value; }

        const nlohmann::json & get_contest() const { return contest; }
        nlohmann::json & get_mutable_contest() { return contest; }
        void set_contest(const nlohmann::json & value) { this->contest = value; }

        const nlohmann::json & get_couthily() const { return couthily; }
        nlohmann::json & get_mutable_couthily() { return couthily; }
        void set_couthily(const nlohmann::json & value) { this->couthily = value; }

        const nlohmann::json & get_falculate() const { return falculate; }
        nlohmann::json & get_mutable_falculate() { return falculate; }
        void set_falculate(const nlohmann::json & value) { this->falculate = value; }

        const nlohmann::json & get_foreseize() const { return foreseize; }
        nlohmann::json & get_mutable_foreseize() { return foreseize; }
        void set_foreseize(const nlohmann::json & value) { this->foreseize = value; }

        const nlohmann::json & get_hyades() const { return hyades; }
        nlohmann::json & get_mutable_hyades() { return hyades; }
        void set_hyades(const nlohmann::json & value) { this->hyades = value; }

        const nlohmann::json & get_lemnad() const { return lemnad; }
        nlohmann::json & get_mutable_lemnad() { return lemnad; }
        void set_lemnad(const nlohmann::json & value) { this->lemnad = value; }

        const nlohmann::json & get_monotheistically() const { return monotheistically; }
        nlohmann::json & get_mutable_monotheistically() { return monotheistically; }
        void set_monotheistically(const nlohmann::json & value) { this->monotheistically = value; }

        const nlohmann::json & get_nonflying() const { return nonflying; }
        nlohmann::json & get_mutable_nonflying() { return nonflying; }
        void set_nonflying(const nlohmann::json & value) { this->nonflying = value; }

        const nlohmann::json & get_ptenoglossa() const { return ptenoglossa; }
        nlohmann::json & get_mutable_ptenoglossa() { return ptenoglossa; }
        void set_ptenoglossa(const nlohmann::json & value) { this->ptenoglossa = value; }

        const nlohmann::json & get_repatch() const { return repatch; }
        nlohmann::json & get_mutable_repatch() { return repatch; }
        void set_repatch(const nlohmann::json & value) { this->repatch = value; }

        const nlohmann::json & get_rodman() const { return rodman; }
        nlohmann::json & get_mutable_rodman() { return rodman; }
        void set_rodman(const nlohmann::json & value) { this->rodman = value; }

        const nlohmann::json & get_strung() const { return strung; }
        nlohmann::json & get_mutable_strung() { return strung; }
        void set_strung(const nlohmann::json & value) { this->strung = value; }

        const nlohmann::json & get_titmal() const { return titmal; }
        nlohmann::json & get_mutable_titmal() { return titmal; }
        void set_titmal(const nlohmann::json & value) { this->titmal = value; }

        const nlohmann::json & get_twalpennyworth() const { return twalpennyworth; }
        nlohmann::json & get_mutable_twalpennyworth() { return twalpennyworth; }
        void set_twalpennyworth(const nlohmann::json & value) { this->twalpennyworth = value; }

        const nlohmann::json & get_unblamable() const { return unblamable; }
        nlohmann::json & get_mutable_unblamable() { return unblamable; }
        void set_unblamable(const nlohmann::json & value) { this->unblamable = value; }

        const nlohmann::json & get_vertical() const { return vertical; }
        nlohmann::json & get_mutable_vertical() { return vertical; }
        void set_vertical(const nlohmann::json & value) { this->vertical = value; }

        const nlohmann::json & get_whiggification() const { return whiggification; }
        nlohmann::json & get_mutable_whiggification() { return whiggification; }
        void set_whiggification(const nlohmann::json & value) { this->whiggification = value; }

        const nlohmann::json & get_yardman() const { return yardman; }
        nlohmann::json & get_mutable_yardman() { return yardman; }
        void set_yardman(const nlohmann::json & value) { this->yardman = value; }
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
        const nlohmann::json & get_admiredly() const { return admiredly; }
        nlohmann::json & get_mutable_admiredly() { return admiredly; }
        void set_admiredly(const nlohmann::json & value) { this->admiredly = value; }

        const nlohmann::json & get_demicaponier() const { return demicaponier; }
        nlohmann::json & get_mutable_demicaponier() { return demicaponier; }
        void set_demicaponier(const nlohmann::json & value) { this->demicaponier = value; }

        const nlohmann::json & get_epitympanic() const { return epitympanic; }
        nlohmann::json & get_mutable_epitympanic() { return epitympanic; }
        void set_epitympanic(const nlohmann::json & value) { this->epitympanic = value; }

        const nlohmann::json & get_investitor() const { return investitor; }
        nlohmann::json & get_mutable_investitor() { return investitor; }
        void set_investitor(const nlohmann::json & value) { this->investitor = value; }

        const nlohmann::json & get_lupiform() const { return lupiform; }
        nlohmann::json & get_mutable_lupiform() { return lupiform; }
        void set_lupiform(const nlohmann::json & value) { this->lupiform = value; }

        const nlohmann::json & get_monoflagellate() const { return monoflagellate; }
        nlohmann::json & get_mutable_monoflagellate() { return monoflagellate; }
        void set_monoflagellate(const nlohmann::json & value) { this->monoflagellate = value; }

        const nlohmann::json & get_paleoethnic() const { return paleoethnic; }
        nlohmann::json & get_mutable_paleoethnic() { return paleoethnic; }
        void set_paleoethnic(const nlohmann::json & value) { this->paleoethnic = value; }

        const nlohmann::json & get_prediscountable() const { return prediscountable; }
        nlohmann::json & get_mutable_prediscountable() { return prediscountable; }
        void set_prediscountable(const nlohmann::json & value) { this->prediscountable = value; }

        const nlohmann::json & get_rhetoricals() const { return rhetoricals; }
        nlohmann::json & get_mutable_rhetoricals() { return rhetoricals; }
        void set_rhetoricals(const nlohmann::json & value) { this->rhetoricals = value; }

        const nlohmann::json & get_roomth() const { return roomth; }
        nlohmann::json & get_mutable_roomth() { return roomth; }
        void set_roomth(const nlohmann::json & value) { this->roomth = value; }

        const nlohmann::json & get_saccharose() const { return saccharose; }
        nlohmann::json & get_mutable_saccharose() { return saccharose; }
        void set_saccharose(const nlohmann::json & value) { this->saccharose = value; }

        const nlohmann::json & get_septonasal() const { return septonasal; }
        nlohmann::json & get_mutable_septonasal() { return septonasal; }
        void set_septonasal(const nlohmann::json & value) { this->septonasal = value; }

        const nlohmann::json & get_serpenticide() const { return serpenticide; }
        nlohmann::json & get_mutable_serpenticide() { return serpenticide; }
        void set_serpenticide(const nlohmann::json & value) { this->serpenticide = value; }

        const nlohmann::json & get_setarious() const { return setarious; }
        nlohmann::json & get_mutable_setarious() { return setarious; }
        void set_setarious(const nlohmann::json & value) { this->setarious = value; }

        const nlohmann::json & get_spaework() const { return spaework; }
        nlohmann::json & get_mutable_spaework() { return spaework; }
        void set_spaework(const nlohmann::json & value) { this->spaework = value; }

        const nlohmann::json & get_stylite() const { return stylite; }
        nlohmann::json & get_mutable_stylite() { return stylite; }
        void set_stylite(const nlohmann::json & value) { this->stylite = value; }

        const nlohmann::json & get_suessiones() const { return suessiones; }
        nlohmann::json & get_mutable_suessiones() { return suessiones; }
        void set_suessiones(const nlohmann::json & value) { this->suessiones = value; }

        const nlohmann::json & get_timelily() const { return timelily; }
        nlohmann::json & get_mutable_timelily() { return timelily; }
        void set_timelily(const nlohmann::json & value) { this->timelily = value; }

        const nlohmann::json & get_unprofaned() const { return unprofaned; }
        nlohmann::json & get_mutable_unprofaned() { return unprofaned; }
        void set_unprofaned(const nlohmann::json & value) { this->unprofaned = value; }

        const nlohmann::json & get_vorticular() const { return vorticular; }
        nlohmann::json & get_mutable_vorticular() { return vorticular; }
        void set_vorticular(const nlohmann::json & value) { this->vorticular = value; }
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
        const nlohmann::json & get_algarrobilla() const { return algarrobilla; }
        nlohmann::json & get_mutable_algarrobilla() { return algarrobilla; }
        void set_algarrobilla(const nlohmann::json & value) { this->algarrobilla = value; }

        const nlohmann::json & get_bowgrace() const { return bowgrace; }
        nlohmann::json & get_mutable_bowgrace() { return bowgrace; }
        void set_bowgrace(const nlohmann::json & value) { this->bowgrace = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const nlohmann::json & get_centaurid() const { return centaurid; }
        nlohmann::json & get_mutable_centaurid() { return centaurid; }
        void set_centaurid(const nlohmann::json & value) { this->centaurid = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const nlohmann::json & get_flix() const { return flix; }
        nlohmann::json & get_mutable_flix() { return flix; }
        void set_flix(const nlohmann::json & value) { this->flix = value; }

        const nlohmann::json & get_germanely() const { return germanely; }
        nlohmann::json & get_mutable_germanely() { return germanely; }
        void set_germanely(const nlohmann::json & value) { this->germanely = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const nlohmann::json & get_inhume() const { return inhume; }
        nlohmann::json & get_mutable_inhume() { return inhume; }
        void set_inhume(const nlohmann::json & value) { this->inhume = value; }

        const nlohmann::json & get_lepidote() const { return lepidote; }
        nlohmann::json & get_mutable_lepidote() { return lepidote; }
        void set_lepidote(const nlohmann::json & value) { this->lepidote = value; }

        const nlohmann::json & get_megalochirous() const { return megalochirous; }
        nlohmann::json & get_mutable_megalochirous() { return megalochirous; }
        void set_megalochirous(const nlohmann::json & value) { this->megalochirous = value; }

        const nlohmann::json & get_ninepenny() const { return ninepenny; }
        nlohmann::json & get_mutable_ninepenny() { return ninepenny; }
        void set_ninepenny(const nlohmann::json & value) { this->ninepenny = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const nlohmann::json & get_nondeist() const { return nondeist; }
        nlohmann::json & get_mutable_nondeist() { return nondeist; }
        void set_nondeist(const nlohmann::json & value) { this->nondeist = value; }

        const nlohmann::json & get_nymphaeaceous() const { return nymphaeaceous; }
        nlohmann::json & get_mutable_nymphaeaceous() { return nymphaeaceous; }
        void set_nymphaeaceous(const nlohmann::json & value) { this->nymphaeaceous = value; }

        const nlohmann::json & get_parietofrontal() const { return parietofrontal; }
        nlohmann::json & get_mutable_parietofrontal() { return parietofrontal; }
        void set_parietofrontal(const nlohmann::json & value) { this->parietofrontal = value; }

        const nlohmann::json & get_sancyite() const { return sancyite; }
        nlohmann::json & get_mutable_sancyite() { return sancyite; }
        void set_sancyite(const nlohmann::json & value) { this->sancyite = value; }

        const nlohmann::json & get_subjectivist() const { return subjectivist; }
        nlohmann::json & get_mutable_subjectivist() { return subjectivist; }
        void set_subjectivist(const nlohmann::json & value) { this->subjectivist = value; }

        const nlohmann::json & get_tibiad() const { return tibiad; }
        nlohmann::json & get_mutable_tibiad() { return tibiad; }
        void set_tibiad(const nlohmann::json & value) { this->tibiad = value; }

        const nlohmann::json & get_transonic() const { return transonic; }
        nlohmann::json & get_mutable_transonic() { return transonic; }
        void set_transonic(const nlohmann::json & value) { this->transonic = value; }

        const nlohmann::json & get_tripetalous() const { return tripetalous; }
        nlohmann::json & get_mutable_tripetalous() { return tripetalous; }
        void set_tripetalous(const nlohmann::json & value) { this->tripetalous = value; }

        const nlohmann::json & get_trunchman() const { return trunchman; }
        nlohmann::json & get_mutable_trunchman() { return trunchman; }
        void set_trunchman(const nlohmann::json & value) { this->trunchman = value; }

        const nlohmann::json & get_urger() const { return urger; }
        nlohmann::json & get_mutable_urger() { return urger; }
        void set_urger(const nlohmann::json & value) { this->urger = value; }

        const nlohmann::json & get_withdrawnness() const { return withdrawnness; }
        nlohmann::json & get_mutable_withdrawnness() { return withdrawnness; }
        void set_withdrawnness(const nlohmann::json & value) { this->withdrawnness = value; }
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
        const nlohmann::json & get_aeriferous() const { return aeriferous; }
        nlohmann::json & get_mutable_aeriferous() { return aeriferous; }
        void set_aeriferous(const nlohmann::json & value) { this->aeriferous = value; }

        const nlohmann::json & get_antical() const { return antical; }
        nlohmann::json & get_mutable_antical() { return antical; }
        void set_antical(const nlohmann::json & value) { this->antical = value; }

        const nlohmann::json & get_antighostism() const { return antighostism; }
        nlohmann::json & get_mutable_antighostism() { return antighostism; }
        void set_antighostism(const nlohmann::json & value) { this->antighostism = value; }

        const nlohmann::json & get_arcanum() const { return arcanum; }
        nlohmann::json & get_mutable_arcanum() { return arcanum; }
        void set_arcanum(const nlohmann::json & value) { this->arcanum = value; }

        const nlohmann::json & get_autotrophy() const { return autotrophy; }
        nlohmann::json & get_mutable_autotrophy() { return autotrophy; }
        void set_autotrophy(const nlohmann::json & value) { this->autotrophy = value; }

        const nlohmann::json & get_baronial() const { return baronial; }
        nlohmann::json & get_mutable_baronial() { return baronial; }
        void set_baronial(const nlohmann::json & value) { this->baronial = value; }

        const nlohmann::json & get_caffeine() const { return caffeine; }
        nlohmann::json & get_mutable_caffeine() { return caffeine; }
        void set_caffeine(const nlohmann::json & value) { this->caffeine = value; }

        const nlohmann::json & get_gorgoniacean() const { return gorgoniacean; }
        nlohmann::json & get_mutable_gorgoniacean() { return gorgoniacean; }
        void set_gorgoniacean(const nlohmann::json & value) { this->gorgoniacean = value; }

        const nlohmann::json & get_heroical() const { return heroical; }
        nlohmann::json & get_mutable_heroical() { return heroical; }
        void set_heroical(const nlohmann::json & value) { this->heroical = value; }

        const nlohmann::json & get_hydropical() const { return hydropical; }
        nlohmann::json & get_mutable_hydropical() { return hydropical; }
        void set_hydropical(const nlohmann::json & value) { this->hydropical = value; }

        const nlohmann::json & get_mechanology() const { return mechanology; }
        nlohmann::json & get_mutable_mechanology() { return mechanology; }
        void set_mechanology(const nlohmann::json & value) { this->mechanology = value; }

        const nlohmann::json & get_musicopoetic() const { return musicopoetic; }
        nlohmann::json & get_mutable_musicopoetic() { return musicopoetic; }
        void set_musicopoetic(const nlohmann::json & value) { this->musicopoetic = value; }

        const nlohmann::json & get_officiality() const { return officiality; }
        nlohmann::json & get_mutable_officiality() { return officiality; }
        void set_officiality(const nlohmann::json & value) { this->officiality = value; }

        const nlohmann::json & get_oftentimes() const { return oftentimes; }
        nlohmann::json & get_mutable_oftentimes() { return oftentimes; }
        void set_oftentimes(const nlohmann::json & value) { this->oftentimes = value; }

        const nlohmann::json & get_ophthalmotonometer() const { return ophthalmotonometer; }
        nlohmann::json & get_mutable_ophthalmotonometer() { return ophthalmotonometer; }
        void set_ophthalmotonometer(const nlohmann::json & value) { this->ophthalmotonometer = value; }

        const nlohmann::json & get_reflectively() const { return reflectively; }
        nlohmann::json & get_mutable_reflectively() { return reflectively; }
        void set_reflectively(const nlohmann::json & value) { this->reflectively = value; }

        const nlohmann::json & get_springer() const { return springer; }
        nlohmann::json & get_mutable_springer() { return springer; }
        void set_springer(const nlohmann::json & value) { this->springer = value; }

        const nlohmann::json & get_tabasco() const { return tabasco; }
        nlohmann::json & get_mutable_tabasco() { return tabasco; }
        void set_tabasco(const nlohmann::json & value) { this->tabasco = value; }

        const nlohmann::json & get_teleianthous() const { return teleianthous; }
        nlohmann::json & get_mutable_teleianthous() { return teleianthous; }
        void set_teleianthous(const nlohmann::json & value) { this->teleianthous = value; }

        const nlohmann::json & get_uncombated() const { return uncombated; }
        nlohmann::json & get_mutable_uncombated() { return uncombated; }
        void set_uncombated(const nlohmann::json & value) { this->uncombated = value; }
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
        const nlohmann::json & get_amphicarpic() const { return amphicarpic; }
        nlohmann::json & get_mutable_amphicarpic() { return amphicarpic; }
        void set_amphicarpic(const nlohmann::json & value) { this->amphicarpic = value; }

        const nlohmann::json & get_chianti() const { return chianti; }
        nlohmann::json & get_mutable_chianti() { return chianti; }
        void set_chianti(const nlohmann::json & value) { this->chianti = value; }

        const nlohmann::json & get_frigorific() const { return frigorific; }
        nlohmann::json & get_mutable_frigorific() { return frigorific; }
        void set_frigorific(const nlohmann::json & value) { this->frigorific = value; }

        const nlohmann::json & get_haplomi() const { return haplomi; }
        nlohmann::json & get_mutable_haplomi() { return haplomi; }
        void set_haplomi(const nlohmann::json & value) { this->haplomi = value; }

        const nlohmann::json & get_hyperkinesis() const { return hyperkinesis; }
        nlohmann::json & get_mutable_hyperkinesis() { return hyperkinesis; }
        void set_hyperkinesis(const nlohmann::json & value) { this->hyperkinesis = value; }

        const nlohmann::json & get_laudable() const { return laudable; }
        nlohmann::json & get_mutable_laudable() { return laudable; }
        void set_laudable(const nlohmann::json & value) { this->laudable = value; }

        const nlohmann::json & get_madwoman() const { return madwoman; }
        nlohmann::json & get_mutable_madwoman() { return madwoman; }
        void set_madwoman(const nlohmann::json & value) { this->madwoman = value; }

        const nlohmann::json & get_maimedly() const { return maimedly; }
        nlohmann::json & get_mutable_maimedly() { return maimedly; }
        void set_maimedly(const nlohmann::json & value) { this->maimedly = value; }

        const nlohmann::json & get_micropterygidae() const { return micropterygidae; }
        nlohmann::json & get_mutable_micropterygidae() { return micropterygidae; }
        void set_micropterygidae(const nlohmann::json & value) { this->micropterygidae = value; }

        const nlohmann::json & get_microrhabdus() const { return microrhabdus; }
        nlohmann::json & get_mutable_microrhabdus() { return microrhabdus; }
        void set_microrhabdus(const nlohmann::json & value) { this->microrhabdus = value; }

        const nlohmann::json & get_nondense() const { return nondense; }
        nlohmann::json & get_mutable_nondense() { return nondense; }
        void set_nondense(const nlohmann::json & value) { this->nondense = value; }

        const nlohmann::json & get_phlebemphraxis() const { return phlebemphraxis; }
        nlohmann::json & get_mutable_phlebemphraxis() { return phlebemphraxis; }
        void set_phlebemphraxis(const nlohmann::json & value) { this->phlebemphraxis = value; }

        const nlohmann::json & get_redsear() const { return redsear; }
        nlohmann::json & get_mutable_redsear() { return redsear; }
        void set_redsear(const nlohmann::json & value) { this->redsear = value; }

        const nlohmann::json & get_schismatical() const { return schismatical; }
        nlohmann::json & get_mutable_schismatical() { return schismatical; }
        void set_schismatical(const nlohmann::json & value) { this->schismatical = value; }

        const nlohmann::json & get_tartryl() const { return tartryl; }
        nlohmann::json & get_mutable_tartryl() { return tartryl; }
        void set_tartryl(const nlohmann::json & value) { this->tartryl = value; }

        const nlohmann::json & get_unabhorred() const { return unabhorred; }
        nlohmann::json & get_mutable_unabhorred() { return unabhorred; }
        void set_unabhorred(const nlohmann::json & value) { this->unabhorred = value; }

        const nlohmann::json & get_undeliberateness() const { return undeliberateness; }
        nlohmann::json & get_mutable_undeliberateness() { return undeliberateness; }
        void set_undeliberateness(const nlohmann::json & value) { this->undeliberateness = value; }

        const nlohmann::json & get_unmixable() const { return unmixable; }
        nlohmann::json & get_mutable_unmixable() { return unmixable; }
        void set_unmixable(const nlohmann::json & value) { this->unmixable = value; }

        const nlohmann::json & get_untruckling() const { return untruckling; }
        nlohmann::json & get_mutable_untruckling() { return untruckling; }
        void set_untruckling(const nlohmann::json & value) { this->untruckling = value; }

        const nlohmann::json & get_vineal() const { return vineal; }
        nlohmann::json & get_mutable_vineal() { return vineal; }
        void set_vineal(const nlohmann::json & value) { this->vineal = value; }
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
        const std::optional<int64_t> & get_calorimetric() const { return calorimetric; }
        std::optional<int64_t> & get_mutable_calorimetric() { return calorimetric; }
        void set_calorimetric(const std::optional<int64_t> & value) { this->calorimetric = value; }

        const std::optional<int64_t> & get_canid() const { return canid; }
        std::optional<int64_t> & get_mutable_canid() { return canid; }
        void set_canid(const std::optional<int64_t> & value) { this->canid = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const std::optional<int64_t> & get_ditriglyphic() const { return ditriglyphic; }
        std::optional<int64_t> & get_mutable_ditriglyphic() { return ditriglyphic; }
        void set_ditriglyphic(const std::optional<int64_t> & value) { this->ditriglyphic = value; }

        const std::optional<int64_t> & get_floriferousness() const { return floriferousness; }
        std::optional<int64_t> & get_mutable_floriferousness() { return floriferousness; }
        void set_floriferousness(const std::optional<int64_t> & value) { this->floriferousness = value; }

        const std::optional<int64_t> & get_gamelike() const { return gamelike; }
        std::optional<int64_t> & get_mutable_gamelike() { return gamelike; }
        void set_gamelike(const std::optional<int64_t> & value) { this->gamelike = value; }

        const std::optional<int64_t> & get_grig() const { return grig; }
        std::optional<int64_t> & get_mutable_grig() { return grig; }
        void set_grig(const std::optional<int64_t> & value) { this->grig = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const std::optional<int64_t> & get_interloan() const { return interloan; }
        std::optional<int64_t> & get_mutable_interloan() { return interloan; }
        void set_interloan(const std::optional<int64_t> & value) { this->interloan = value; }

        const std::optional<int64_t> & get_lithotomy() const { return lithotomy; }
        std::optional<int64_t> & get_mutable_lithotomy() { return lithotomy; }
        void set_lithotomy(const std::optional<int64_t> & value) { this->lithotomy = value; }

        const std::optional<int64_t> & get_loric() const { return loric; }
        std::optional<int64_t> & get_mutable_loric() { return loric; }
        void set_loric(const std::optional<int64_t> & value) { this->loric = value; }

        const std::optional<int64_t> & get_membranocoriaceous() const { return membranocoriaceous; }
        std::optional<int64_t> & get_mutable_membranocoriaceous() { return membranocoriaceous; }
        void set_membranocoriaceous(const std::optional<int64_t> & value) { this->membranocoriaceous = value; }

        const std::optional<int64_t> & get_membranogenic() const { return membranogenic; }
        std::optional<int64_t> & get_mutable_membranogenic() { return membranogenic; }
        void set_membranogenic(const std::optional<int64_t> & value) { this->membranogenic = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const std::optional<int64_t> & get_overtrump() const { return overtrump; }
        std::optional<int64_t> & get_mutable_overtrump() { return overtrump; }
        void set_overtrump(const std::optional<int64_t> & value) { this->overtrump = value; }

        const std::optional<int64_t> & get_scotino() const { return scotino; }
        std::optional<int64_t> & get_mutable_scotino() { return scotino; }
        void set_scotino(const std::optional<int64_t> & value) { this->scotino = value; }

        const std::optional<int64_t> & get_seasonable() const { return seasonable; }
        std::optional<int64_t> & get_mutable_seasonable() { return seasonable; }
        void set_seasonable(const std::optional<int64_t> & value) { this->seasonable = value; }

        const std::optional<int64_t> & get_sephen() const { return sephen; }
        std::optional<int64_t> & get_mutable_sephen() { return sephen; }
        void set_sephen(const std::optional<int64_t> & value) { this->sephen = value; }

        const std::optional<int64_t> & get_stigmarioid() const { return stigmarioid; }
        std::optional<int64_t> & get_mutable_stigmarioid() { return stigmarioid; }
        void set_stigmarioid(const std::optional<int64_t> & value) { this->stigmarioid = value; }

        const std::optional<int64_t> & get_tired() const { return tired; }
        std::optional<int64_t> & get_mutable_tired() { return tired; }
        void set_tired(const std::optional<int64_t> & value) { this->tired = value; }

        const std::optional<int64_t> & get_trifid() const { return trifid; }
        std::optional<int64_t> & get_mutable_trifid() { return trifid; }
        void set_trifid(const std::optional<int64_t> & value) { this->trifid = value; }

        const std::optional<int64_t> & get_undefeatedly() const { return undefeatedly; }
        std::optional<int64_t> & get_mutable_undefeatedly() { return undefeatedly; }
        void set_undefeatedly(const std::optional<int64_t> & value) { this->undefeatedly = value; }

        const std::optional<int64_t> & get_ungirlish() const { return ungirlish; }
        std::optional<int64_t> & get_mutable_ungirlish() { return ungirlish; }
        void set_ungirlish(const std::optional<int64_t> & value) { this->ungirlish = value; }
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
        const std::optional<int64_t> & get_bliss() const { return bliss; }
        std::optional<int64_t> & get_mutable_bliss() { return bliss; }
        void set_bliss(const std::optional<int64_t> & value) { this->bliss = value; }

        const std::optional<int64_t> & get_buccate() const { return buccate; }
        std::optional<int64_t> & get_mutable_buccate() { return buccate; }
        void set_buccate(const std::optional<int64_t> & value) { this->buccate = value; }

        const std::optional<int64_t> & get_bulletproof() const { return bulletproof; }
        std::optional<int64_t> & get_mutable_bulletproof() { return bulletproof; }
        void set_bulletproof(const std::optional<int64_t> & value) { this->bulletproof = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const std::optional<int64_t> & get_crumblingness() const { return crumblingness; }
        std::optional<int64_t> & get_mutable_crumblingness() { return crumblingness; }
        void set_crumblingness(const std::optional<int64_t> & value) { this->crumblingness = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const std::optional<int64_t> & get_engagedly() const { return engagedly; }
        std::optional<int64_t> & get_mutable_engagedly() { return engagedly; }
        void set_engagedly(const std::optional<int64_t> & value) { this->engagedly = value; }

        const std::optional<int64_t> & get_fightable() const { return fightable; }
        std::optional<int64_t> & get_mutable_fightable() { return fightable; }
        void set_fightable(const std::optional<int64_t> & value) { this->fightable = value; }

        const std::optional<int64_t> & get_hoariness() const { return hoariness; }
        std::optional<int64_t> & get_mutable_hoariness() { return hoariness; }
        void set_hoariness(const std::optional<int64_t> & value) { this->hoariness = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const std::optional<int64_t> & get_hypopodium() const { return hypopodium; }
        std::optional<int64_t> & get_mutable_hypopodium() { return hypopodium; }
        void set_hypopodium(const std::optional<int64_t> & value) { this->hypopodium = value; }

        const std::optional<int64_t> & get_luxurist() const { return luxurist; }
        std::optional<int64_t> & get_mutable_luxurist() { return luxurist; }
        void set_luxurist(const std::optional<int64_t> & value) { this->luxurist = value; }

        const std::optional<int64_t> & get_mechanician() const { return mechanician; }
        std::optional<int64_t> & get_mutable_mechanician() { return mechanician; }
        void set_mechanician(const std::optional<int64_t> & value) { this->mechanician = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const std::optional<int64_t> & get_onopordon() const { return onopordon; }
        std::optional<int64_t> & get_mutable_onopordon() { return onopordon; }
        void set_onopordon(const std::optional<int64_t> & value) { this->onopordon = value; }

        const std::optional<int64_t> & get_podgily() const { return podgily; }
        std::optional<int64_t> & get_mutable_podgily() { return podgily; }
        void set_podgily(const std::optional<int64_t> & value) { this->podgily = value; }

        const std::optional<int64_t> & get_reformableness() const { return reformableness; }
        std::optional<int64_t> & get_mutable_reformableness() { return reformableness; }
        void set_reformableness(const std::optional<int64_t> & value) { this->reformableness = value; }

        const std::optional<int64_t> & get_scatterbrains() const { return scatterbrains; }
        std::optional<int64_t> & get_mutable_scatterbrains() { return scatterbrains; }
        void set_scatterbrains(const std::optional<int64_t> & value) { this->scatterbrains = value; }

        const std::optional<int64_t> & get_seminuria() const { return seminuria; }
        std::optional<int64_t> & get_mutable_seminuria() { return seminuria; }
        void set_seminuria(const std::optional<int64_t> & value) { this->seminuria = value; }

        const std::optional<int64_t> & get_sodomite() const { return sodomite; }
        std::optional<int64_t> & get_mutable_sodomite() { return sodomite; }
        void set_sodomite(const std::optional<int64_t> & value) { this->sodomite = value; }

        const std::optional<int64_t> & get_tramp() const { return tramp; }
        std::optional<int64_t> & get_mutable_tramp() { return tramp; }
        void set_tramp(const std::optional<int64_t> & value) { this->tramp = value; }

        const std::optional<int64_t> & get_undueness() const { return undueness; }
        std::optional<int64_t> & get_mutable_undueness() { return undueness; }
        void set_undueness(const std::optional<int64_t> & value) { this->undueness = value; }

        const std::optional<int64_t> & get_worthily() const { return worthily; }
        std::optional<int64_t> & get_mutable_worthily() { return worthily; }
        void set_worthily(const std::optional<int64_t> & value) { this->worthily = value; }

        const std::optional<int64_t> & get_yankeeist() const { return yankeeist; }
        std::optional<int64_t> & get_mutable_yankeeist() { return yankeeist; }
        void set_yankeeist(const std::optional<int64_t> & value) { this->yankeeist = value; }
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
        const nlohmann::json & get_alfiona() const { return alfiona; }
        nlohmann::json & get_mutable_alfiona() { return alfiona; }
        void set_alfiona(const nlohmann::json & value) { this->alfiona = value; }

        const nlohmann::json & get_ascaridiasis() const { return ascaridiasis; }
        nlohmann::json & get_mutable_ascaridiasis() { return ascaridiasis; }
        void set_ascaridiasis(const nlohmann::json & value) { this->ascaridiasis = value; }

        const nlohmann::json & get_bungey() const { return bungey; }
        nlohmann::json & get_mutable_bungey() { return bungey; }
        void set_bungey(const nlohmann::json & value) { this->bungey = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const nlohmann::json & get_ceroxyle() const { return ceroxyle; }
        nlohmann::json & get_mutable_ceroxyle() { return ceroxyle; }
        void set_ceroxyle(const nlohmann::json & value) { this->ceroxyle = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const nlohmann::json & get_chorology() const { return chorology; }
        nlohmann::json & get_mutable_chorology() { return chorology; }
        void set_chorology(const nlohmann::json & value) { this->chorology = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const nlohmann::json & get_enmarble() const { return enmarble; }
        nlohmann::json & get_mutable_enmarble() { return enmarble; }
        void set_enmarble(const nlohmann::json & value) { this->enmarble = value; }

        const nlohmann::json & get_epeira() const { return epeira; }
        nlohmann::json & get_mutable_epeira() { return epeira; }
        void set_epeira(const nlohmann::json & value) { this->epeira = value; }

        const nlohmann::json & get_eurylaimi() const { return eurylaimi; }
        nlohmann::json & get_mutable_eurylaimi() { return eurylaimi; }
        void set_eurylaimi(const nlohmann::json & value) { this->eurylaimi = value; }

        const nlohmann::json & get_germination() const { return germination; }
        nlohmann::json & get_mutable_germination() { return germination; }
        void set_germination(const nlohmann::json & value) { this->germination = value; }

        const nlohmann::json & get_hallelujah() const { return hallelujah; }
        nlohmann::json & get_mutable_hallelujah() { return hallelujah; }
        void set_hallelujah(const nlohmann::json & value) { this->hallelujah = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const nlohmann::json & get_lev() const { return lev; }
        nlohmann::json & get_mutable_lev() { return lev; }
        void set_lev(const nlohmann::json & value) { this->lev = value; }

        const nlohmann::json & get_mouthing() const { return mouthing; }
        nlohmann::json & get_mutable_mouthing() { return mouthing; }
        void set_mouthing(const nlohmann::json & value) { this->mouthing = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const nlohmann::json & get_philliloo() const { return philliloo; }
        nlohmann::json & get_mutable_philliloo() { return philliloo; }
        void set_philliloo(const nlohmann::json & value) { this->philliloo = value; }

        const nlohmann::json & get_planetal() const { return planetal; }
        nlohmann::json & get_mutable_planetal() { return planetal; }
        void set_planetal(const nlohmann::json & value) { this->planetal = value; }

        const nlohmann::json & get_poney() const { return poney; }
        nlohmann::json & get_mutable_poney() { return poney; }
        void set_poney(const nlohmann::json & value) { this->poney = value; }

        const nlohmann::json & get_punctualist() const { return punctualist; }
        nlohmann::json & get_mutable_punctualist() { return punctualist; }
        void set_punctualist(const nlohmann::json & value) { this->punctualist = value; }

        const nlohmann::json & get_returnlessly() const { return returnlessly; }
        nlohmann::json & get_mutable_returnlessly() { return returnlessly; }
        void set_returnlessly(const nlohmann::json & value) { this->returnlessly = value; }

        const nlohmann::json & get_skelder() const { return skelder; }
        nlohmann::json & get_mutable_skelder() { return skelder; }
        void set_skelder(const nlohmann::json & value) { this->skelder = value; }

        const nlohmann::json & get_windwaywardly() const { return windwaywardly; }
        nlohmann::json & get_mutable_windwaywardly() { return windwaywardly; }
        void set_windwaywardly(const nlohmann::json & value) { this->windwaywardly = value; }

        const nlohmann::json & get_yuman() const { return yuman; }
        nlohmann::json & get_mutable_yuman() { return yuman; }
        void set_yuman(const nlohmann::json & value) { this->yuman = value; }
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
        const std::optional<int64_t> & get_acerin() const { return acerin; }
        std::optional<int64_t> & get_mutable_acerin() { return acerin; }
        void set_acerin(const std::optional<int64_t> & value) { this->acerin = value; }

        const std::optional<int64_t> & get_bobadil() const { return bobadil; }
        std::optional<int64_t> & get_mutable_bobadil() { return bobadil; }
        void set_bobadil(const std::optional<int64_t> & value) { this->bobadil = value; }

        const std::optional<double> & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(const std::optional<double> & value) { this->catharticalness = value; }

        const std::optional<int64_t> & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(const std::optional<int64_t> & value) { this->chirotherium = value; }

        const std::optional<int64_t> & get_chlorophylligenous() const { return chlorophylligenous; }
        std::optional<int64_t> & get_mutable_chlorophylligenous() { return chlorophylligenous; }
        void set_chlorophylligenous(const std::optional<int64_t> & value) { this->chlorophylligenous = value; }

        const std::optional<int64_t> & get_conversational() const { return conversational; }
        std::optional<int64_t> & get_mutable_conversational() { return conversational; }
        void set_conversational(const std::optional<int64_t> & value) { this->conversational = value; }

        const std::optional<int64_t> & get_demiowl() const { return demiowl; }
        std::optional<int64_t> & get_mutable_demiowl() { return demiowl; }
        void set_demiowl(const std::optional<int64_t> & value) { this->demiowl = value; }

        const std::optional<std::string> & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(const std::optional<std::string> & value) { this->disdiapason = value; }

        const std::optional<int64_t> & get_ectorhinal() const { return ectorhinal; }
        std::optional<int64_t> & get_mutable_ectorhinal() { return ectorhinal; }
        void set_ectorhinal(const std::optional<int64_t> & value) { this->ectorhinal = value; }

        const std::optional<int64_t> & get_gamblesomeness() const { return gamblesomeness; }
        std::optional<int64_t> & get_mutable_gamblesomeness() { return gamblesomeness; }
        void set_gamblesomeness(const std::optional<int64_t> & value) { this->gamblesomeness = value; }

        const std::optional<bool> & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(const std::optional<bool> & value) { this->homocerc = value; }

        const std::optional<int64_t> & get_irrorate() const { return irrorate; }
        std::optional<int64_t> & get_mutable_irrorate() { return irrorate; }
        void set_irrorate(const std::optional<int64_t> & value) { this->irrorate = value; }

        const std::optional<int64_t> & get_kindergartening() const { return kindergartening; }
        std::optional<int64_t> & get_mutable_kindergartening() { return kindergartening; }
        void set_kindergartening(const std::optional<int64_t> & value) { this->kindergartening = value; }

        const std::optional<int64_t> & get_lateritic() const { return lateritic; }
        std::optional<int64_t> & get_mutable_lateritic() { return lateritic; }
        void set_lateritic(const std::optional<int64_t> & value) { this->lateritic = value; }

        const std::optional<int64_t> & get_mespil() const { return mespil; }
        std::optional<int64_t> & get_mutable_mespil() { return mespil; }
        void set_mespil(const std::optional<int64_t> & value) { this->mespil = value; }

        const std::optional<int64_t> & get_misconfiguration() const { return misconfiguration; }
        std::optional<int64_t> & get_mutable_misconfiguration() { return misconfiguration; }
        void set_misconfiguration(const std::optional<int64_t> & value) { this->misconfiguration = value; }

        const nlohmann::json & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(const nlohmann::json & value) { this->nonbookish = value; }

        const std::optional<int64_t> & get_planometry() const { return planometry; }
        std::optional<int64_t> & get_mutable_planometry() { return planometry; }
        void set_planometry(const std::optional<int64_t> & value) { this->planometry = value; }

        const std::optional<int64_t> & get_quiina() const { return quiina; }
        std::optional<int64_t> & get_mutable_quiina() { return quiina; }
        void set_quiina(const std::optional<int64_t> & value) { this->quiina = value; }

        const std::optional<int64_t> & get_robert() const { return robert; }
        std::optional<int64_t> & get_mutable_robert() { return robert; }
        void set_robert(const std::optional<int64_t> & value) { this->robert = value; }

        const std::optional<int64_t> & get_rot() const { return rot; }
        std::optional<int64_t> & get_mutable_rot() { return rot; }
        void set_rot(const std::optional<int64_t> & value) { this->rot = value; }

        const std::optional<int64_t> & get_subcinctorium() const { return subcinctorium; }
        std::optional<int64_t> & get_mutable_subcinctorium() { return subcinctorium; }
        void set_subcinctorium(const std::optional<int64_t> & value) { this->subcinctorium = value; }

        const std::optional<int64_t> & get_tussocker() const { return tussocker; }
        std::optional<int64_t> & get_mutable_tussocker() { return tussocker; }
        void set_tussocker(const std::optional<int64_t> & value) { this->tussocker = value; }

        const std::optional<int64_t> & get_ultraproud() const { return ultraproud; }
        std::optional<int64_t> & get_mutable_ultraproud() { return ultraproud; }
        void set_ultraproud(const std::optional<int64_t> & value) { this->ultraproud = value; }

        const std::optional<int64_t> & get_unsuggestedness() const { return unsuggestedness; }
        std::optional<int64_t> & get_mutable_unsuggestedness() { return unsuggestedness; }
        void set_unsuggestedness(const std::optional<int64_t> & value) { this->unsuggestedness = value; }
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
        const nlohmann::json & get_alain() const { return alain; }
        nlohmann::json & get_mutable_alain() { return alain; }
        void set_alain(const nlohmann::json & value) { this->alain = value; }

        const nlohmann::json & get_amphirhina() const { return amphirhina; }
        nlohmann::json & get_mutable_amphirhina() { return amphirhina; }
        void set_amphirhina(const nlohmann::json & value) { this->amphirhina = value; }

        const nlohmann::json & get_antimachinery() const { return antimachinery; }
        nlohmann::json & get_mutable_antimachinery() { return antimachinery; }
        void set_antimachinery(const nlohmann::json & value) { this->antimachinery = value; }

        const nlohmann::json & get_coldish() const { return coldish; }
        nlohmann::json & get_mutable_coldish() { return coldish; }
        void set_coldish(const nlohmann::json & value) { this->coldish = value; }

        const nlohmann::json & get_crantara() const { return crantara; }
        nlohmann::json & get_mutable_crantara() { return crantara; }
        void set_crantara(const nlohmann::json & value) { this->crantara = value; }

        const nlohmann::json & get_distinguishing() const { return distinguishing; }
        nlohmann::json & get_mutable_distinguishing() { return distinguishing; }
        void set_distinguishing(const nlohmann::json & value) { this->distinguishing = value; }

        const nlohmann::json & get_elytroposis() const { return elytroposis; }
        nlohmann::json & get_mutable_elytroposis() { return elytroposis; }
        void set_elytroposis(const nlohmann::json & value) { this->elytroposis = value; }

        const nlohmann::json & get_gentianwort() const { return gentianwort; }
        nlohmann::json & get_mutable_gentianwort() { return gentianwort; }
        void set_gentianwort(const nlohmann::json & value) { this->gentianwort = value; }

        const nlohmann::json & get_heliosis() const { return heliosis; }
        nlohmann::json & get_mutable_heliosis() { return heliosis; }
        void set_heliosis(const nlohmann::json & value) { this->heliosis = value; }

        const nlohmann::json & get_instrumental() const { return instrumental; }
        nlohmann::json & get_mutable_instrumental() { return instrumental; }
        void set_instrumental(const nlohmann::json & value) { this->instrumental = value; }

        const nlohmann::json & get_introinflection() const { return introinflection; }
        nlohmann::json & get_mutable_introinflection() { return introinflection; }
        void set_introinflection(const nlohmann::json & value) { this->introinflection = value; }

        const nlohmann::json & get_kala() const { return kala; }
        nlohmann::json & get_mutable_kala() { return kala; }
        void set_kala(const nlohmann::json & value) { this->kala = value; }

        const nlohmann::json & get_lincolnian() const { return lincolnian; }
        nlohmann::json & get_mutable_lincolnian() { return lincolnian; }
        void set_lincolnian(const nlohmann::json & value) { this->lincolnian = value; }

        const nlohmann::json & get_metad() const { return metad; }
        nlohmann::json & get_mutable_metad() { return metad; }
        void set_metad(const nlohmann::json & value) { this->metad = value; }

        const nlohmann::json & get_sarcophilus() const { return sarcophilus; }
        nlohmann::json & get_mutable_sarcophilus() { return sarcophilus; }
        void set_sarcophilus(const nlohmann::json & value) { this->sarcophilus = value; }

        const nlohmann::json & get_swingingly() const { return swingingly; }
        nlohmann::json & get_mutable_swingingly() { return swingingly; }
        void set_swingingly(const nlohmann::json & value) { this->swingingly = value; }

        const nlohmann::json & get_unconformity() const { return unconformity; }
        nlohmann::json & get_mutable_unconformity() { return unconformity; }
        void set_unconformity(const nlohmann::json & value) { this->unconformity = value; }

        const nlohmann::json & get_undecreed() const { return undecreed; }
        nlohmann::json & get_mutable_undecreed() { return undecreed; }
        void set_undecreed(const nlohmann::json & value) { this->undecreed = value; }

        const nlohmann::json & get_venerable() const { return venerable; }
        nlohmann::json & get_mutable_venerable() { return venerable; }
        void set_venerable(const nlohmann::json & value) { this->venerable = value; }

        const nlohmann::json & get_vowellessness() const { return vowellessness; }
        nlohmann::json & get_mutable_vowellessness() { return vowellessness; }
        void set_vowellessness(const nlohmann::json & value) { this->vowellessness = value; }
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
        const nlohmann::json & get_aeschynanthus() const { return aeschynanthus; }
        nlohmann::json & get_mutable_aeschynanthus() { return aeschynanthus; }
        void set_aeschynanthus(const nlohmann::json & value) { this->aeschynanthus = value; }

        const nlohmann::json & get_aquiferous() const { return aquiferous; }
        nlohmann::json & get_mutable_aquiferous() { return aquiferous; }
        void set_aquiferous(const nlohmann::json & value) { this->aquiferous = value; }

        const nlohmann::json & get_cheapener() const { return cheapener; }
        nlohmann::json & get_mutable_cheapener() { return cheapener; }
        void set_cheapener(const nlohmann::json & value) { this->cheapener = value; }

        const nlohmann::json & get_enumeration() const { return enumeration; }
        nlohmann::json & get_mutable_enumeration() { return enumeration; }
        void set_enumeration(const nlohmann::json & value) { this->enumeration = value; }

        const nlohmann::json & get_ephesine() const { return ephesine; }
        nlohmann::json & get_mutable_ephesine() { return ephesine; }
        void set_ephesine(const nlohmann::json & value) { this->ephesine = value; }

        const nlohmann::json & get_escadrille() const { return escadrille; }
        nlohmann::json & get_mutable_escadrille() { return escadrille; }
        void set_escadrille(const nlohmann::json & value) { this->escadrille = value; }

        const nlohmann::json & get_estrous() const { return estrous; }
        nlohmann::json & get_mutable_estrous() { return estrous; }
        void set_estrous(const nlohmann::json & value) { this->estrous = value; }

        const nlohmann::json & get_interestedly() const { return interestedly; }
        nlohmann::json & get_mutable_interestedly() { return interestedly; }
        void set_interestedly(const nlohmann::json & value) { this->interestedly = value; }

        const nlohmann::json & get_katakinetomer() const { return katakinetomer; }
        nlohmann::json & get_mutable_katakinetomer() { return katakinetomer; }
        void set_katakinetomer(const nlohmann::json & value) { this->katakinetomer = value; }

        const nlohmann::json & get_mortification() const { return mortification; }
        nlohmann::json & get_mutable_mortification() { return mortification; }
        void set_mortification(const nlohmann::json & value) { this->mortification = value; }

        const nlohmann::json & get_morula() const { return morula; }
        nlohmann::json & get_mutable_morula() { return morula; }
        void set_morula(const nlohmann::json & value) { this->morula = value; }

        const nlohmann::json & get_orthosymmetrical() const { return orthosymmetrical; }
        nlohmann::json & get_mutable_orthosymmetrical() { return orthosymmetrical; }
        void set_orthosymmetrical(const nlohmann::json & value) { this->orthosymmetrical = value; }

        const nlohmann::json & get_overbark() const { return overbark; }
        nlohmann::json & get_mutable_overbark() { return overbark; }
        void set_overbark(const nlohmann::json & value) { this->overbark = value; }

        const nlohmann::json & get_politist() const { return politist; }
        nlohmann::json & get_mutable_politist() { return politist; }
        void set_politist(const nlohmann::json & value) { this->politist = value; }

        const nlohmann::json & get_qualified() const { return qualified; }
        nlohmann::json & get_mutable_qualified() { return qualified; }
        void set_qualified(const nlohmann::json & value) { this->qualified = value; }

        const nlohmann::json & get_sphenomalar() const { return sphenomalar; }
        nlohmann::json & get_mutable_sphenomalar() { return sphenomalar; }
        void set_sphenomalar(const nlohmann::json & value) { this->sphenomalar = value; }

        const nlohmann::json & get_throatful() const { return throatful; }
        nlohmann::json & get_mutable_throatful() { return throatful; }
        void set_throatful(const nlohmann::json & value) { this->throatful = value; }

        const nlohmann::json & get_transhumance() const { return transhumance; }
        nlohmann::json & get_mutable_transhumance() { return transhumance; }
        void set_transhumance(const nlohmann::json & value) { this->transhumance = value; }

        const nlohmann::json & get_triandrian() const { return triandrian; }
        nlohmann::json & get_mutable_triandrian() { return triandrian; }
        void set_triandrian(const nlohmann::json & value) { this->triandrian = value; }

        const nlohmann::json & get_unbooked() const { return unbooked; }
        nlohmann::json & get_mutable_unbooked() { return unbooked; }
        void set_unbooked(const nlohmann::json & value) { this->unbooked = value; }
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
        const std::vector<Protrusive> & get_protrusive() const { return protrusive; }
        std::vector<Protrusive> & get_mutable_protrusive() { return protrusive; }
        void set_protrusive(const std::vector<Protrusive> & value) { this->protrusive = value; }

        const std::vector<PulpitismElement> & get_pulpitism() const { return pulpitism; }
        std::vector<PulpitismElement> & get_mutable_pulpitism() { return pulpitism; }
        void set_pulpitism(const std::vector<PulpitismElement> & value) { this->pulpitism = value; }

        const std::vector<PyodermiaElement> & get_pyodermia() const { return pyodermia; }
        std::vector<PyodermiaElement> & get_mutable_pyodermia() { return pyodermia; }
        void set_pyodermia(const std::vector<PyodermiaElement> & value) { this->pyodermia = value; }

        const std::vector<QuebrachineElement> & get_quebrachine() const { return quebrachine; }
        std::vector<QuebrachineElement> & get_mutable_quebrachine() { return quebrachine; }
        void set_quebrachine(const std::vector<QuebrachineElement> & value) { this->quebrachine = value; }

        const std::vector<Querier> & get_querier() const { return querier; }
        std::vector<Querier> & get_mutable_querier() { return querier; }
        void set_querier(const std::vector<Querier> & value) { this->querier = value; }

        const std::vector<Rebarbative> & get_rebarbative() const { return rebarbative; }
        std::vector<Rebarbative> & get_mutable_rebarbative() { return rebarbative; }
        void set_rebarbative(const std::vector<Rebarbative> & value) { this->rebarbative = value; }

        const std::vector<Reimagine> & get_reimagine() const { return reimagine; }
        std::vector<Reimagine> & get_mutable_reimagine() { return reimagine; }
        void set_reimagine(const std::vector<Reimagine> & value) { this->reimagine = value; }

        const Ressaut & get_ressaut() const { return ressaut; }
        Ressaut & get_mutable_ressaut() { return ressaut; }
        void set_ressaut(const Ressaut & value) { this->ressaut = value; }

        const std::vector<Retrocervical> & get_retrocervical() const { return retrocervical; }
        std::vector<Retrocervical> & get_mutable_retrocervical() { return retrocervical; }
        void set_retrocervical(const std::vector<Retrocervical> & value) { this->retrocervical = value; }

        const std::vector<Revert> & get_revert() const { return revert; }
        std::vector<Revert> & get_mutable_revert() { return revert; }
        void set_revert(const std::vector<Revert> & value) { this->revert = value; }

        const std::vector<RewriteElement> & get_rewrite() const { return rewrite; }
        std::vector<RewriteElement> & get_mutable_rewrite() { return rewrite; }
        void set_rewrite(const std::vector<RewriteElement> & value) { this->rewrite = value; }

        const std::vector<Saccoderm> & get_saccoderm() const { return saccoderm; }
        std::vector<Saccoderm> & get_mutable_saccoderm() { return saccoderm; }
        void set_saccoderm(const std::vector<Saccoderm> & value) { this->saccoderm = value; }

        const std::vector<SantirElement> & get_santir() const { return santir; }
        std::vector<SantirElement> & get_mutable_santir() { return santir; }
        void set_santir(const std::vector<SantirElement> & value) { this->santir = value; }

        const std::vector<Saprophilous> & get_saprophilous() const { return saprophilous; }
        std::vector<Saprophilous> & get_mutable_saprophilous() { return saprophilous; }
        void set_saprophilous(const std::vector<Saprophilous> & value) { this->saprophilous = value; }

        const std::vector<SaxtenElement> & get_saxten() const { return saxten; }
        std::vector<SaxtenElement> & get_mutable_saxten() { return saxten; }
        void set_saxten(const std::vector<SaxtenElement> & value) { this->saxten = value; }

        const std::vector<std::optional<Scatty>> & get_scatty() const { return scatty; }
        std::vector<std::optional<Scatty>> & get_mutable_scatty() { return scatty; }
        void set_scatty(const std::vector<std::optional<Scatty>> & value) { this->scatty = value; }

        const std::vector<Scoffer> & get_scoffer() const { return scoffer; }
        std::vector<Scoffer> & get_mutable_scoffer() { return scoffer; }
        void set_scoffer(const std::vector<Scoffer> & value) { this->scoffer = value; }

        const std::vector<Scrampum> & get_scrampum() const { return scrampum; }
        std::vector<Scrampum> & get_mutable_scrampum() { return scrampum; }
        void set_scrampum(const std::vector<Scrampum> & value) { this->scrampum = value; }

        const double & get_semantic() const { return semantic; }
        double & get_mutable_semantic() { return semantic; }
        void set_semantic(const double & value) { this->semantic = value; }

        const std::vector<Serpentinic> & get_serpentinic() const { return serpentinic; }
        std::vector<Serpentinic> & get_mutable_serpentinic() { return serpentinic; }
        void set_serpentinic(const std::vector<Serpentinic> & value) { this->serpentinic = value; }

        const std::vector<Shadowable> & get_shadowable() const { return shadowable; }
        std::vector<Shadowable> & get_mutable_shadowable() { return shadowable; }
        void set_shadowable(const std::vector<Shadowable> & value) { this->shadowable = value; }

        const std::vector<SisteringElement> & get_sistering() const { return sistering; }
        std::vector<SisteringElement> & get_mutable_sistering() { return sistering; }
        void set_sistering(const std::vector<SisteringElement> & value) { this->sistering = value; }

        const std::vector<Staghunting> & get_staghunting() const { return staghunting; }
        std::vector<Staghunting> & get_mutable_staghunting() { return staghunting; }
        void set_staghunting(const std::vector<Staghunting> & value) { this->staghunting = value; }

        const std::vector<Stagmometer> & get_stagmometer() const { return stagmometer; }
        std::vector<Stagmometer> & get_mutable_stagmometer() { return stagmometer; }
        void set_stagmometer(const std::vector<Stagmometer> & value) { this->stagmometer = value; }

        const std::vector<Stimulability> & get_stimulability() const { return stimulability; }
        std::vector<Stimulability> & get_mutable_stimulability() { return stimulability; }
        void set_stimulability(const std::vector<Stimulability> & value) { this->stimulability = value; }

        const std::vector<Strangleable> & get_strangleable() const { return strangleable; }
        std::vector<Strangleable> & get_mutable_strangleable() { return strangleable; }
        void set_strangleable(const std::vector<Strangleable> & value) { this->strangleable = value; }

        const std::vector<StrenuosityElement> & get_strenuosity() const { return strenuosity; }
        std::vector<StrenuosityElement> & get_mutable_strenuosity() { return strenuosity; }
        void set_strenuosity(const std::vector<StrenuosityElement> & value) { this->strenuosity = value; }

        const std::vector<Tabaxir> & get_tabaxir() const { return tabaxir; }
        std::vector<Tabaxir> & get_mutable_tabaxir() { return tabaxir; }
        void set_tabaxir(const std::vector<Tabaxir> & value) { this->tabaxir = value; }

        const std::vector<Talpiform> & get_talpiform() const { return talpiform; }
        std::vector<Talpiform> & get_mutable_talpiform() { return talpiform; }
        void set_talpiform(const std::vector<Talpiform> & value) { this->talpiform = value; }

        const std::vector<Thwack> & get_thwack() const { return thwack; }
        std::vector<Thwack> & get_mutable_thwack() { return thwack; }
        void set_thwack(const std::vector<Thwack> & value) { this->thwack = value; }

        const std::vector<std::optional<double>> & get_to() const { return to; }
        std::vector<std::optional<double>> & get_mutable_to() { return to; }
        void set_to(const std::vector<std::optional<double>> & value) { this->to = value; }

        const std::vector<Tortricine> & get_tortricine() const { return tortricine; }
        std::vector<Tortricine> & get_mutable_tortricine() { return tortricine; }
        void set_tortricine(const std::vector<Tortricine> & value) { this->tortricine = value; }

        const std::vector<TruantcyElement> & get_truantcy() const { return truantcy; }
        std::vector<TruantcyElement> & get_mutable_truantcy() { return truantcy; }
        void set_truantcy(const std::vector<TruantcyElement> & value) { this->truantcy = value; }

        const std::vector<std::string> & get_turgesce() const { return turgesce; }
        std::vector<std::string> & get_mutable_turgesce() { return turgesce; }
        void set_turgesce(const std::vector<std::string> & value) { this->turgesce = value; }

        const std::vector<Unbeginning> & get_unbeginning() const { return unbeginning; }
        std::vector<Unbeginning> & get_mutable_unbeginning() { return unbeginning; }
        void set_unbeginning(const std::vector<Unbeginning> & value) { this->unbeginning = value; }

        const std::vector<double> & get_underdunged() const { return underdunged; }
        std::vector<double> & get_mutable_underdunged() { return underdunged; }
        void set_underdunged(const std::vector<double> & value) { this->underdunged = value; }

        const std::vector<Undesirability> & get_undesirability() const { return undesirability; }
        std::vector<Undesirability> & get_mutable_undesirability() { return undesirability; }
        void set_undesirability(const std::vector<Undesirability> & value) { this->undesirability = value; }

        const std::vector<Unerasing> & get_unerasing() const { return unerasing; }
        std::vector<Unerasing> & get_mutable_unerasing() { return unerasing; }
        void set_unerasing(const std::vector<Unerasing> & value) { this->unerasing = value; }

        const std::vector<Unguentarium> & get_unguentarium() const { return unguentarium; }
        std::vector<Unguentarium> & get_mutable_unguentarium() { return unguentarium; }
        void set_unguentarium(const std::vector<Unguentarium> & value) { this->unguentarium = value; }

        const std::vector<UnimpeachablyElement> & get_unimpeachably() const { return unimpeachably; }
        std::vector<UnimpeachablyElement> & get_mutable_unimpeachably() { return unimpeachably; }
        void set_unimpeachably(const std::vector<UnimpeachablyElement> & value) { this->unimpeachably = value; }

        const std::vector<Unmortgaged> & get_unmortgaged() const { return unmortgaged; }
        std::vector<Unmortgaged> & get_mutable_unmortgaged() { return unmortgaged; }
        void set_unmortgaged(const std::vector<Unmortgaged> & value) { this->unmortgaged = value; }

        const std::vector<Unobstructed> & get_unobstructed() const { return unobstructed; }
        std::vector<Unobstructed> & get_mutable_unobstructed() { return unobstructed; }
        void set_unobstructed(const std::vector<Unobstructed> & value) { this->unobstructed = value; }

        const std::vector<Unreceptivity> & get_unreceptivity() const { return unreceptivity; }
        std::vector<Unreceptivity> & get_mutable_unreceptivity() { return unreceptivity; }
        void set_unreceptivity(const std::vector<Unreceptivity> & value) { this->unreceptivity = value; }

        const std::vector<Unsatisfactoriness> & get_unsatisfactoriness() const { return unsatisfactoriness; }
        std::vector<Unsatisfactoriness> & get_mutable_unsatisfactoriness() { return unsatisfactoriness; }
        void set_unsatisfactoriness(const std::vector<Unsatisfactoriness> & value) { this->unsatisfactoriness = value; }

        const std::vector<int64_t> & get_unsecurity() const { return unsecurity; }
        std::vector<int64_t> & get_mutable_unsecurity() { return unsecurity; }
        void set_unsecurity(const std::vector<int64_t> & value) { this->unsecurity = value; }

        const std::vector<UnstressedElement> & get_unstressed() const { return unstressed; }
        std::vector<UnstressedElement> & get_mutable_unstressed() { return unstressed; }
        void set_unstressed(const std::vector<UnstressedElement> & value) { this->unstressed = value; }

        const std::vector<Untasked> & get_untasked() const { return untasked; }
        std::vector<Untasked> & get_mutable_untasked() { return untasked; }
        void set_untasked(const std::vector<Untasked> & value) { this->untasked = value; }

        const std::vector<Unvarying> & get_unvarying() const { return unvarying; }
        std::vector<Unvarying> & get_mutable_unvarying() { return unvarying; }
        void set_unvarying(const std::vector<Unvarying> & value) { this->unvarying = value; }

        const std::vector<Vehemently> & get_vehemently() const { return vehemently; }
        std::vector<Vehemently> & get_mutable_vehemently() { return vehemently; }
        void set_vehemently(const std::vector<Vehemently> & value) { this->vehemently = value; }

        const std::map<std::string, bool> & get_warriorship() const { return warriorship; }
        std::map<std::string, bool> & get_mutable_warriorship() { return warriorship; }
        void set_warriorship(const std::map<std::string, bool> & value) { this->warriorship = value; }

        const std::vector<Whitepot> & get_whitepot() const { return whitepot; }
        std::vector<Whitepot> & get_mutable_whitepot() { return whitepot; }
        void set_whitepot(const std::vector<Whitepot> & value) { this->whitepot = value; }

        const std::vector<WrothyElement> & get_wrothy() const { return wrothy; }
        std::vector<WrothyElement> & get_mutable_wrothy() { return wrothy; }
        void set_wrothy(const std::vector<WrothyElement> & value) { this->wrothy = value; }
    };
}

namespace quicktype {
void from_json(const json & j, PulpitismClass & x);
void to_json(json & j, const PulpitismClass & x);

void from_json(const json & j, PyodermiaClass & x);
void to_json(json & j, const PyodermiaClass & x);

void from_json(const json & j, QuebrachineClass & x);
void to_json(json & j, const QuebrachineClass & x);

void from_json(const json & j, Reimagine & x);
void to_json(json & j, const Reimagine & x);

void from_json(const json & j, Ressaut & x);
void to_json(json & j, const Ressaut & x);

void from_json(const json & j, RewriteClass & x);
void to_json(json & j, const RewriteClass & x);

void from_json(const json & j, SantirClass & x);
void to_json(json & j, const SantirClass & x);

void from_json(const json & j, SaxtenClass & x);
void to_json(json & j, const SaxtenClass & x);

void from_json(const json & j, Scatty & x);
void to_json(json & j, const Scatty & x);

void from_json(const json & j, SisteringClass & x);
void to_json(json & j, const SisteringClass & x);

void from_json(const json & j, Staghunting & x);
void to_json(json & j, const Staghunting & x);

void from_json(const json & j, StrenuosityClass & x);
void to_json(json & j, const StrenuosityClass & x);

void from_json(const json & j, TruantcyClass & x);
void to_json(json & j, const TruantcyClass & x);

void from_json(const json & j, UnimpeachablyClass & x);
void to_json(json & j, const UnimpeachablyClass & x);

void from_json(const json & j, UnstressedClass & x);
void to_json(json & j, const UnstressedClass & x);

void from_json(const json & j, WrothyClass & x);
void to_json(json & j, const WrothyClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, double>> {
    static void from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, double> & x);
    static void to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PyodermiaClass, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::PyodermiaClass, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::PyodermiaClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::QuebrachineClass>> {
    static void from_json(const json & j, std::variant<bool, quicktype::QuebrachineClass> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::QuebrachineClass> & x);
};

template <>
struct adl_serializer<std::variant<bool, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<bool, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, double>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool, double> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<bool, std::string>> {
    static void from_json(const json & j, std::variant<bool, std::string> & x);
    static void to_json(json & j, const std::variant<bool, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::RewriteClass, double>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::RewriteClass, double> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::RewriteClass, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SantirClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::SantirClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::SantirClass, double> & x);
};

template <>
struct adl_serializer<std::variant<std::map<std::string, int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<std::map<std::string, int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SaxtenClass, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::SaxtenClass, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::SaxtenClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, double> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, bool>> {
    static void from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, bool> & x);
    static void to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, bool> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::SisteringClass, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, int64_t, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<bool, int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<bool, int64_t, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double>> {
    static void from_json(const json & j, std::variant<std::vector<json>, double> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::StrenuosityClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::StrenuosityClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::StrenuosityClass> & x);
};

template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(const json & j, std::variant<bool, double> & x);
    static void to_json(json & j, const std::variant<bool, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::QuebrachineClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::QuebrachineClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::QuebrachineClass, double> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::QuebrachineClass, double>> {
    static void from_json(const json & j, std::variant<bool, quicktype::QuebrachineClass, double> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::QuebrachineClass, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass>> {
    static void from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> & x);
    static void to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::TruantcyClass>> {
    static void from_json(const json & j, std::variant<bool, quicktype::TruantcyClass> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::TruantcyClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<json>, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::UnimpeachablyClass>> {
    static void from_json(const json & j, std::variant<bool, quicktype::UnimpeachablyClass> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::UnimpeachablyClass> & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<double, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::QuebrachineClass, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::QuebrachineClass, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::QuebrachineClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::UnstressedClass, std::string>> {
    static void from_json(const json & j, std::variant<bool, quicktype::UnstressedClass, std::string> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::UnstressedClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<json>, double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, double, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<bool, double, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<bool, double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<bool, double, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::WrothyClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::WrothyClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::WrothyClass> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, PulpitismClass& x) {
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

    inline void to_json(json & j, const PulpitismClass & x) {
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

    inline void from_json(const json & j, PyodermiaClass& x) {
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

    inline void to_json(json & j, const PyodermiaClass & x) {
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

    inline void from_json(const json & j, QuebrachineClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_catharticalness(j.at("catharticalness").get<double>());
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_chirotherium(j.at("Chirotherium").get<int64_t>());
        x.set_disdiapason(j.at("disdiapason").get<std::string>());
        x.set_homocerc(j.at("homocerc").get<bool>());
        x.set_nonbookish(get_untyped(j, "nonbookish"));
    }

    inline void to_json(json & j, const QuebrachineClass & x) {
        j = json::object();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["homocerc"] = x.get_homocerc();
        j["nonbookish"] = x.get_nonbookish();
    }

    inline void from_json(const json & j, Reimagine& x) {
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

    inline void to_json(json & j, const Reimagine & x) {
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

    inline void from_json(const json & j, Ressaut& x) {
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

    inline void to_json(json & j, const Ressaut & x) {
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

    inline void from_json(const json & j, RewriteClass& x) {
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

    inline void to_json(json & j, const RewriteClass & x) {
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

    inline void from_json(const json & j, SantirClass& x) {
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

    inline void to_json(json & j, const SantirClass & x) {
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

    inline void from_json(const json & j, SaxtenClass& x) {
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

    inline void to_json(json & j, const SaxtenClass & x) {
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

    inline void from_json(const json & j, Scatty& x) {
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

    inline void to_json(json & j, const Scatty & x) {
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

    inline void from_json(const json & j, SisteringClass& x) {
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

    inline void to_json(json & j, const SisteringClass & x) {
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

    inline void from_json(const json & j, Staghunting& x) {
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

    inline void to_json(json & j, const Staghunting & x) {
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

    inline void from_json(const json & j, StrenuosityClass& x) {
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

    inline void to_json(json & j, const StrenuosityClass & x) {
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

    inline void from_json(const json & j, TruantcyClass& x) {
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

    inline void to_json(json & j, const TruantcyClass & x) {
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

    inline void from_json(const json & j, UnimpeachablyClass& x) {
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

    inline void to_json(json & j, const UnimpeachablyClass & x) {
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

    inline void from_json(const json & j, UnstressedClass& x) {
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

    inline void to_json(json & j, const UnstressedClass & x) {
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

    inline void from_json(const json & j, WrothyClass& x) {
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

    inline void to_json(json & j, const WrothyClass & x) {
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

    inline void from_json(const json & j, TopLevel& x) {
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

    inline void to_json(json & j, const TopLevel & x) {
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
    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, double>>::from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, double>>::to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::PulpitismClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::PulpitismClass, double> & x) {
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

    inline void adl_serializer<std::variant<quicktype::PyodermiaClass, int64_t>>::from_json(const json & j, std::variant<quicktype::PyodermiaClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::PyodermiaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PyodermiaClass, int64_t>>::to_json(json & j, const std::variant<quicktype::PyodermiaClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass>>::from_json(const json & j, std::variant<bool, quicktype::QuebrachineClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass>>::to_json(json & j, const std::variant<bool, quicktype::QuebrachineClass> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, double>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, double>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, int64_t>>::from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, int64_t>>::to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::RewriteClass, double>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::RewriteClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::RewriteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::RewriteClass, double>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::RewriteClass, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, std::string> & x) {
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

    inline void adl_serializer<std::variant<quicktype::SantirClass, double>>::from_json(const json & j, std::variant<quicktype::SantirClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::SantirClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SantirClass, double>>::to_json(json & j, const std::variant<quicktype::SantirClass, double> & x) {
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

    inline void adl_serializer<std::variant<quicktype::SaxtenClass, std::string>>::from_json(const json & j, std::variant<quicktype::SaxtenClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::SaxtenClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SaxtenClass, std::string>>::to_json(json & j, const std::variant<quicktype::SaxtenClass, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<json>, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool> & x) {
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, bool>>::from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, bool> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, bool>>::to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, bool> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::SisteringClass, int64_t>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::SisteringClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::SisteringClass, int64_t>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::SisteringClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::string>>::from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::string>>::to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, std::string> & x) {
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

    inline void adl_serializer<std::variant<bool, int64_t, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<bool, int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, int64_t, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<bool, int64_t, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, double>>::from_json(const json & j, std::variant<std::vector<json>, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, double>>::to_json(json & j, const std::variant<std::vector<json>, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::StrenuosityClass>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::StrenuosityClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::StrenuosityClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::StrenuosityClass>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::StrenuosityClass> & x) {
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

    inline void adl_serializer<std::variant<bool, double>>::from_json(const json & j, std::variant<bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double>>::to_json(json & j, const std::variant<bool, double> & x) {
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

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, double>>::from_json(const json & j, std::variant<quicktype::QuebrachineClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, double>>::to_json(json & j, const std::variant<quicktype::QuebrachineClass, double> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass, double>>::from_json(const json & j, std::variant<bool, quicktype::QuebrachineClass, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::QuebrachineClass, double>>::to_json(json & j, const std::variant<bool, quicktype::QuebrachineClass, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass>>::from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass>>::to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, quicktype::QuebrachineClass> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::TruantcyClass>>::from_json(const json & j, std::variant<bool, quicktype::TruantcyClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::TruantcyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::TruantcyClass>>::to_json(json & j, const std::variant<bool, quicktype::TruantcyClass> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string>>::from_json(const json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string>>::to_json(json & j, const std::variant<std::vector<json>, std::map<std::string, int64_t>, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<json>, int64_t, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, int64_t>>::from_json(const json & j, std::variant<std::vector<json>, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t>>::to_json(json & j, const std::variant<std::vector<json>, int64_t> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::UnimpeachablyClass>>::from_json(const json & j, std::variant<bool, quicktype::UnimpeachablyClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::UnimpeachablyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::UnimpeachablyClass>>::to_json(json & j, const std::variant<bool, quicktype::UnimpeachablyClass> & x) {
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

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, int64_t>>::from_json(const json & j, std::variant<quicktype::QuebrachineClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::QuebrachineClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::QuebrachineClass, int64_t>>::to_json(json & j, const std::variant<quicktype::QuebrachineClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::string>>::from_json(const json & j, std::variant<std::vector<json>, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, int64_t, std::string>>::to_json(json & j, const std::variant<std::vector<json>, int64_t, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, int64_t>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, int64_t>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool, int64_t> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::UnstressedClass, std::string>>::from_json(const json & j, std::variant<bool, quicktype::UnstressedClass, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::UnstressedClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::UnstressedClass, std::string>>::to_json(json & j, const std::variant<bool, quicktype::UnstressedClass, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, double, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<json>, double, std::map<std::string, int64_t>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, double, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<json>, double, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<bool, double, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<bool, double, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<bool, double, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, bool>>::from_json(const json & j, std::variant<std::vector<json>, bool> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool>>::to_json(json & j, const std::variant<std::vector<json>, bool> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::WrothyClass>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::WrothyClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::WrothyClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::WrothyClass>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::WrothyClass> & x) {
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
