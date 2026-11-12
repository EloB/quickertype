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

    using Abranchiata = std::optional<std::variant<std::vector<int64_t>, int64_t>>;

    using Academe = std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>;

    using Acquirable = std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>;

    using Aerometry = std::variant<bool, double>;

    using Alexin = std::variant<std::vector<int64_t>, bool>;

    class AlleviateClass {
        public:
        AlleviateClass() = default;
        virtual ~AlleviateClass() = default;

        private:
        nlohmann::json apriori;
        nlohmann::json beggarer;
        nlohmann::json brokenheartedly;
        nlohmann::json debilitation;
        nlohmann::json frike;
        nlohmann::json gastrolith;
        nlohmann::json hulsean;
        nlohmann::json orthocentric;
        nlohmann::json petaly;
        nlohmann::json probudgeting;
        nlohmann::json reacquire;
        nlohmann::json scow;
        nlohmann::json shutoff;
        nlohmann::json subcontiguous;
        nlohmann::json suffumigate;
        nlohmann::json transformable;
        nlohmann::json uncoroneted;
        nlohmann::json unparking;
        nlohmann::json unvarnishedness;
        nlohmann::json wherewithal;

        public:
        nlohmann::json const & get_apriori() const { return apriori; }
        nlohmann::json & get_mutable_apriori() { return apriori; }
        void set_apriori(nlohmann::json const & value) { this->apriori = value; }

        nlohmann::json const & get_beggarer() const { return beggarer; }
        nlohmann::json & get_mutable_beggarer() { return beggarer; }
        void set_beggarer(nlohmann::json const & value) { this->beggarer = value; }

        nlohmann::json const & get_brokenheartedly() const { return brokenheartedly; }
        nlohmann::json & get_mutable_brokenheartedly() { return brokenheartedly; }
        void set_brokenheartedly(nlohmann::json const & value) { this->brokenheartedly = value; }

        nlohmann::json const & get_debilitation() const { return debilitation; }
        nlohmann::json & get_mutable_debilitation() { return debilitation; }
        void set_debilitation(nlohmann::json const & value) { this->debilitation = value; }

        nlohmann::json const & get_frike() const { return frike; }
        nlohmann::json & get_mutable_frike() { return frike; }
        void set_frike(nlohmann::json const & value) { this->frike = value; }

        nlohmann::json const & get_gastrolith() const { return gastrolith; }
        nlohmann::json & get_mutable_gastrolith() { return gastrolith; }
        void set_gastrolith(nlohmann::json const & value) { this->gastrolith = value; }

        nlohmann::json const & get_hulsean() const { return hulsean; }
        nlohmann::json & get_mutable_hulsean() { return hulsean; }
        void set_hulsean(nlohmann::json const & value) { this->hulsean = value; }

        nlohmann::json const & get_orthocentric() const { return orthocentric; }
        nlohmann::json & get_mutable_orthocentric() { return orthocentric; }
        void set_orthocentric(nlohmann::json const & value) { this->orthocentric = value; }

        nlohmann::json const & get_petaly() const { return petaly; }
        nlohmann::json & get_mutable_petaly() { return petaly; }
        void set_petaly(nlohmann::json const & value) { this->petaly = value; }

        nlohmann::json const & get_probudgeting() const { return probudgeting; }
        nlohmann::json & get_mutable_probudgeting() { return probudgeting; }
        void set_probudgeting(nlohmann::json const & value) { this->probudgeting = value; }

        nlohmann::json const & get_reacquire() const { return reacquire; }
        nlohmann::json & get_mutable_reacquire() { return reacquire; }
        void set_reacquire(nlohmann::json const & value) { this->reacquire = value; }

        nlohmann::json const & get_scow() const { return scow; }
        nlohmann::json & get_mutable_scow() { return scow; }
        void set_scow(nlohmann::json const & value) { this->scow = value; }

        nlohmann::json const & get_shutoff() const { return shutoff; }
        nlohmann::json & get_mutable_shutoff() { return shutoff; }
        void set_shutoff(nlohmann::json const & value) { this->shutoff = value; }

        nlohmann::json const & get_subcontiguous() const { return subcontiguous; }
        nlohmann::json & get_mutable_subcontiguous() { return subcontiguous; }
        void set_subcontiguous(nlohmann::json const & value) { this->subcontiguous = value; }

        nlohmann::json const & get_suffumigate() const { return suffumigate; }
        nlohmann::json & get_mutable_suffumigate() { return suffumigate; }
        void set_suffumigate(nlohmann::json const & value) { this->suffumigate = value; }

        nlohmann::json const & get_transformable() const { return transformable; }
        nlohmann::json & get_mutable_transformable() { return transformable; }
        void set_transformable(nlohmann::json const & value) { this->transformable = value; }

        nlohmann::json const & get_uncoroneted() const { return uncoroneted; }
        nlohmann::json & get_mutable_uncoroneted() { return uncoroneted; }
        void set_uncoroneted(nlohmann::json const & value) { this->uncoroneted = value; }

        nlohmann::json const & get_unparking() const { return unparking; }
        nlohmann::json & get_mutable_unparking() { return unparking; }
        void set_unparking(nlohmann::json const & value) { this->unparking = value; }

        nlohmann::json const & get_unvarnishedness() const { return unvarnishedness; }
        nlohmann::json & get_mutable_unvarnishedness() { return unvarnishedness; }
        void set_unvarnishedness(nlohmann::json const & value) { this->unvarnishedness = value; }

        nlohmann::json const & get_wherewithal() const { return wherewithal; }
        nlohmann::json & get_mutable_wherewithal() { return wherewithal; }
        void set_wherewithal(nlohmann::json const & value) { this->wherewithal = value; }
    };

    using AlleviateElement = std::variant<std::vector<std::optional<int64_t>>, AlleviateClass>;

    class Rebecca {
        public:
        Rebecca() = default;
        virtual ~Rebecca() = default;

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

    using Amaa = std::variant<bool, Rebecca, int64_t>;

    using Ambassage = std::variant<std::vector<nlohmann::json>, std::string>;

    class Amphithyron {
        public:
        Amphithyron() = default;
        virtual ~Amphithyron() = default;

        private:
        std::optional<int64_t> akroasis;
        std::optional<int64_t> antiphonical;
        std::optional<int64_t> basebred;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> conductometric;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> ensilation;
        std::optional<int64_t> eyebolt;
        std::optional<int64_t> fistulated;
        std::optional<int64_t> heteropod;
        std::optional<bool> homocerc;
        std::optional<int64_t> juniperus;
        std::optional<int64_t> labyrinthically;
        std::optional<int64_t> martyrization;
        std::optional<int64_t> mispolicy;
        std::optional<int64_t> multipara;
        std::optional<int64_t> nazirite;
        nlohmann::json nonbookish;
        std::optional<int64_t> possessorial;
        std::optional<int64_t> shamed;
        std::optional<int64_t> shelfworn;
        std::optional<int64_t> stagnum;
        std::optional<int64_t> those;
        std::optional<int64_t> undecimal;

        public:
        std::optional<int64_t> const & get_akroasis() const { return akroasis; }
        std::optional<int64_t> & get_mutable_akroasis() { return akroasis; }
        void set_akroasis(std::optional<int64_t> const & value) { this->akroasis = value; }

        std::optional<int64_t> const & get_antiphonical() const { return antiphonical; }
        std::optional<int64_t> & get_mutable_antiphonical() { return antiphonical; }
        void set_antiphonical(std::optional<int64_t> const & value) { this->antiphonical = value; }

        std::optional<int64_t> const & get_basebred() const { return basebred; }
        std::optional<int64_t> & get_mutable_basebred() { return basebred; }
        void set_basebred(std::optional<int64_t> const & value) { this->basebred = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_conductometric() const { return conductometric; }
        std::optional<int64_t> & get_mutable_conductometric() { return conductometric; }
        void set_conductometric(std::optional<int64_t> const & value) { this->conductometric = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_ensilation() const { return ensilation; }
        std::optional<int64_t> & get_mutable_ensilation() { return ensilation; }
        void set_ensilation(std::optional<int64_t> const & value) { this->ensilation = value; }

        std::optional<int64_t> const & get_eyebolt() const { return eyebolt; }
        std::optional<int64_t> & get_mutable_eyebolt() { return eyebolt; }
        void set_eyebolt(std::optional<int64_t> const & value) { this->eyebolt = value; }

        std::optional<int64_t> const & get_fistulated() const { return fistulated; }
        std::optional<int64_t> & get_mutable_fistulated() { return fistulated; }
        void set_fistulated(std::optional<int64_t> const & value) { this->fistulated = value; }

        std::optional<int64_t> const & get_heteropod() const { return heteropod; }
        std::optional<int64_t> & get_mutable_heteropod() { return heteropod; }
        void set_heteropod(std::optional<int64_t> const & value) { this->heteropod = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_juniperus() const { return juniperus; }
        std::optional<int64_t> & get_mutable_juniperus() { return juniperus; }
        void set_juniperus(std::optional<int64_t> const & value) { this->juniperus = value; }

        std::optional<int64_t> const & get_labyrinthically() const { return labyrinthically; }
        std::optional<int64_t> & get_mutable_labyrinthically() { return labyrinthically; }
        void set_labyrinthically(std::optional<int64_t> const & value) { this->labyrinthically = value; }

        std::optional<int64_t> const & get_martyrization() const { return martyrization; }
        std::optional<int64_t> & get_mutable_martyrization() { return martyrization; }
        void set_martyrization(std::optional<int64_t> const & value) { this->martyrization = value; }

        std::optional<int64_t> const & get_mispolicy() const { return mispolicy; }
        std::optional<int64_t> & get_mutable_mispolicy() { return mispolicy; }
        void set_mispolicy(std::optional<int64_t> const & value) { this->mispolicy = value; }

        std::optional<int64_t> const & get_multipara() const { return multipara; }
        std::optional<int64_t> & get_mutable_multipara() { return multipara; }
        void set_multipara(std::optional<int64_t> const & value) { this->multipara = value; }

        std::optional<int64_t> const & get_nazirite() const { return nazirite; }
        std::optional<int64_t> & get_mutable_nazirite() { return nazirite; }
        void set_nazirite(std::optional<int64_t> const & value) { this->nazirite = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_possessorial() const { return possessorial; }
        std::optional<int64_t> & get_mutable_possessorial() { return possessorial; }
        void set_possessorial(std::optional<int64_t> const & value) { this->possessorial = value; }

        std::optional<int64_t> const & get_shamed() const { return shamed; }
        std::optional<int64_t> & get_mutable_shamed() { return shamed; }
        void set_shamed(std::optional<int64_t> const & value) { this->shamed = value; }

        std::optional<int64_t> const & get_shelfworn() const { return shelfworn; }
        std::optional<int64_t> & get_mutable_shelfworn() { return shelfworn; }
        void set_shelfworn(std::optional<int64_t> const & value) { this->shelfworn = value; }

        std::optional<int64_t> const & get_stagnum() const { return stagnum; }
        std::optional<int64_t> & get_mutable_stagnum() { return stagnum; }
        void set_stagnum(std::optional<int64_t> const & value) { this->stagnum = value; }

        std::optional<int64_t> const & get_those() const { return those; }
        std::optional<int64_t> & get_mutable_those() { return those; }
        void set_those(std::optional<int64_t> const & value) { this->those = value; }

        std::optional<int64_t> const & get_undecimal() const { return undecimal; }
        std::optional<int64_t> & get_mutable_undecimal() { return undecimal; }
        void set_undecimal(std::optional<int64_t> const & value) { this->undecimal = value; }
    };

    class AnkeeClass {
        public:
        AnkeeClass() = default;
        virtual ~AnkeeClass() = default;

        private:
        nlohmann::json anomoean;
        nlohmann::json barleyhood;
        nlohmann::json befriender;
        nlohmann::json brutishness;
        nlohmann::json cephalalgy;
        nlohmann::json cirurgian;
        nlohmann::json conventionally;
        nlohmann::json jackshay;
        nlohmann::json milammeter;
        nlohmann::json naja;
        nlohmann::json ombrological;
        nlohmann::json phonasthenia;
        nlohmann::json retrievableness;
        nlohmann::json snakily;
        nlohmann::json swot;
        nlohmann::json tartlet;
        nlohmann::json thiofuran;
        nlohmann::json tracheophone;
        nlohmann::json tuglike;
        nlohmann::json unscratchingly;

        public:
        nlohmann::json const & get_anomoean() const { return anomoean; }
        nlohmann::json & get_mutable_anomoean() { return anomoean; }
        void set_anomoean(nlohmann::json const & value) { this->anomoean = value; }

        nlohmann::json const & get_barleyhood() const { return barleyhood; }
        nlohmann::json & get_mutable_barleyhood() { return barleyhood; }
        void set_barleyhood(nlohmann::json const & value) { this->barleyhood = value; }

        nlohmann::json const & get_befriender() const { return befriender; }
        nlohmann::json & get_mutable_befriender() { return befriender; }
        void set_befriender(nlohmann::json const & value) { this->befriender = value; }

        nlohmann::json const & get_brutishness() const { return brutishness; }
        nlohmann::json & get_mutable_brutishness() { return brutishness; }
        void set_brutishness(nlohmann::json const & value) { this->brutishness = value; }

        nlohmann::json const & get_cephalalgy() const { return cephalalgy; }
        nlohmann::json & get_mutable_cephalalgy() { return cephalalgy; }
        void set_cephalalgy(nlohmann::json const & value) { this->cephalalgy = value; }

        nlohmann::json const & get_cirurgian() const { return cirurgian; }
        nlohmann::json & get_mutable_cirurgian() { return cirurgian; }
        void set_cirurgian(nlohmann::json const & value) { this->cirurgian = value; }

        nlohmann::json const & get_conventionally() const { return conventionally; }
        nlohmann::json & get_mutable_conventionally() { return conventionally; }
        void set_conventionally(nlohmann::json const & value) { this->conventionally = value; }

        nlohmann::json const & get_jackshay() const { return jackshay; }
        nlohmann::json & get_mutable_jackshay() { return jackshay; }
        void set_jackshay(nlohmann::json const & value) { this->jackshay = value; }

        nlohmann::json const & get_milammeter() const { return milammeter; }
        nlohmann::json & get_mutable_milammeter() { return milammeter; }
        void set_milammeter(nlohmann::json const & value) { this->milammeter = value; }

        nlohmann::json const & get_naja() const { return naja; }
        nlohmann::json & get_mutable_naja() { return naja; }
        void set_naja(nlohmann::json const & value) { this->naja = value; }

        nlohmann::json const & get_ombrological() const { return ombrological; }
        nlohmann::json & get_mutable_ombrological() { return ombrological; }
        void set_ombrological(nlohmann::json const & value) { this->ombrological = value; }

        nlohmann::json const & get_phonasthenia() const { return phonasthenia; }
        nlohmann::json & get_mutable_phonasthenia() { return phonasthenia; }
        void set_phonasthenia(nlohmann::json const & value) { this->phonasthenia = value; }

        nlohmann::json const & get_retrievableness() const { return retrievableness; }
        nlohmann::json & get_mutable_retrievableness() { return retrievableness; }
        void set_retrievableness(nlohmann::json const & value) { this->retrievableness = value; }

        nlohmann::json const & get_snakily() const { return snakily; }
        nlohmann::json & get_mutable_snakily() { return snakily; }
        void set_snakily(nlohmann::json const & value) { this->snakily = value; }

        nlohmann::json const & get_swot() const { return swot; }
        nlohmann::json & get_mutable_swot() { return swot; }
        void set_swot(nlohmann::json const & value) { this->swot = value; }

        nlohmann::json const & get_tartlet() const { return tartlet; }
        nlohmann::json & get_mutable_tartlet() { return tartlet; }
        void set_tartlet(nlohmann::json const & value) { this->tartlet = value; }

        nlohmann::json const & get_thiofuran() const { return thiofuran; }
        nlohmann::json & get_mutable_thiofuran() { return thiofuran; }
        void set_thiofuran(nlohmann::json const & value) { this->thiofuran = value; }

        nlohmann::json const & get_tracheophone() const { return tracheophone; }
        nlohmann::json & get_mutable_tracheophone() { return tracheophone; }
        void set_tracheophone(nlohmann::json const & value) { this->tracheophone = value; }

        nlohmann::json const & get_tuglike() const { return tuglike; }
        nlohmann::json & get_mutable_tuglike() { return tuglike; }
        void set_tuglike(nlohmann::json const & value) { this->tuglike = value; }

        nlohmann::json const & get_unscratchingly() const { return unscratchingly; }
        nlohmann::json & get_mutable_unscratchingly() { return unscratchingly; }
        void set_unscratchingly(nlohmann::json const & value) { this->unscratchingly = value; }
    };

    using AnkeeElement = std::variant<std::vector<int64_t>, AnkeeClass, int64_t>;

    class AnsarieClass {
        public:
        AnsarieClass() = default;
        virtual ~AnsarieClass() = default;

        private:
        nlohmann::json accension;
        nlohmann::json alida;
        nlohmann::json asteria;
        nlohmann::json beriberic;
        nlohmann::json edgebone;
        nlohmann::json gastrodialysis;
        nlohmann::json geographic;
        nlohmann::json ictonyx;
        nlohmann::json metrocele;
        nlohmann::json misgraft;
        nlohmann::json monteith;
        nlohmann::json notcher;
        nlohmann::json prorestriction;
        nlohmann::json ramist;
        nlohmann::json throatlet;
        nlohmann::json unfair;
        nlohmann::json unsynonymous;
        nlohmann::json water;
        nlohmann::json zestfully;
        nlohmann::json zincic;

        public:
        nlohmann::json const & get_accension() const { return accension; }
        nlohmann::json & get_mutable_accension() { return accension; }
        void set_accension(nlohmann::json const & value) { this->accension = value; }

        nlohmann::json const & get_alida() const { return alida; }
        nlohmann::json & get_mutable_alida() { return alida; }
        void set_alida(nlohmann::json const & value) { this->alida = value; }

        nlohmann::json const & get_asteria() const { return asteria; }
        nlohmann::json & get_mutable_asteria() { return asteria; }
        void set_asteria(nlohmann::json const & value) { this->asteria = value; }

        nlohmann::json const & get_beriberic() const { return beriberic; }
        nlohmann::json & get_mutable_beriberic() { return beriberic; }
        void set_beriberic(nlohmann::json const & value) { this->beriberic = value; }

        nlohmann::json const & get_edgebone() const { return edgebone; }
        nlohmann::json & get_mutable_edgebone() { return edgebone; }
        void set_edgebone(nlohmann::json const & value) { this->edgebone = value; }

        nlohmann::json const & get_gastrodialysis() const { return gastrodialysis; }
        nlohmann::json & get_mutable_gastrodialysis() { return gastrodialysis; }
        void set_gastrodialysis(nlohmann::json const & value) { this->gastrodialysis = value; }

        nlohmann::json const & get_geographic() const { return geographic; }
        nlohmann::json & get_mutable_geographic() { return geographic; }
        void set_geographic(nlohmann::json const & value) { this->geographic = value; }

        nlohmann::json const & get_ictonyx() const { return ictonyx; }
        nlohmann::json & get_mutable_ictonyx() { return ictonyx; }
        void set_ictonyx(nlohmann::json const & value) { this->ictonyx = value; }

        nlohmann::json const & get_metrocele() const { return metrocele; }
        nlohmann::json & get_mutable_metrocele() { return metrocele; }
        void set_metrocele(nlohmann::json const & value) { this->metrocele = value; }

        nlohmann::json const & get_misgraft() const { return misgraft; }
        nlohmann::json & get_mutable_misgraft() { return misgraft; }
        void set_misgraft(nlohmann::json const & value) { this->misgraft = value; }

        nlohmann::json const & get_monteith() const { return monteith; }
        nlohmann::json & get_mutable_monteith() { return monteith; }
        void set_monteith(nlohmann::json const & value) { this->monteith = value; }

        nlohmann::json const & get_notcher() const { return notcher; }
        nlohmann::json & get_mutable_notcher() { return notcher; }
        void set_notcher(nlohmann::json const & value) { this->notcher = value; }

        nlohmann::json const & get_prorestriction() const { return prorestriction; }
        nlohmann::json & get_mutable_prorestriction() { return prorestriction; }
        void set_prorestriction(nlohmann::json const & value) { this->prorestriction = value; }

        nlohmann::json const & get_ramist() const { return ramist; }
        nlohmann::json & get_mutable_ramist() { return ramist; }
        void set_ramist(nlohmann::json const & value) { this->ramist = value; }

        nlohmann::json const & get_throatlet() const { return throatlet; }
        nlohmann::json & get_mutable_throatlet() { return throatlet; }
        void set_throatlet(nlohmann::json const & value) { this->throatlet = value; }

        nlohmann::json const & get_unfair() const { return unfair; }
        nlohmann::json & get_mutable_unfair() { return unfair; }
        void set_unfair(nlohmann::json const & value) { this->unfair = value; }

        nlohmann::json const & get_unsynonymous() const { return unsynonymous; }
        nlohmann::json & get_mutable_unsynonymous() { return unsynonymous; }
        void set_unsynonymous(nlohmann::json const & value) { this->unsynonymous = value; }

        nlohmann::json const & get_water() const { return water; }
        nlohmann::json & get_mutable_water() { return water; }
        void set_water(nlohmann::json const & value) { this->water = value; }

        nlohmann::json const & get_zestfully() const { return zestfully; }
        nlohmann::json & get_mutable_zestfully() { return zestfully; }
        void set_zestfully(nlohmann::json const & value) { this->zestfully = value; }

        nlohmann::json const & get_zincic() const { return zincic; }
        nlohmann::json & get_mutable_zincic() { return zincic; }
        void set_zincic(nlohmann::json const & value) { this->zincic = value; }
    };

    using AnsarieElement = std::optional<std::variant<std::vector<int64_t>, AnsarieClass>>;

    using Aphasia = std::variant<std::vector<int64_t>, int64_t>;

    using Asprawl = std::variant<double, std::string>;

    using Bedesman = std::variant<bool, double, std::string>;

    using Belard = std::variant<std::vector<int64_t>, Rebecca, double>;

    using Bocking = std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>>;

    using Brawlingly = std::variant<std::vector<nlohmann::json>, std::map<std::string, std::optional<int64_t>>>;

    using Brookie = std::variant<std::vector<int64_t>, Rebecca>;

    using Bumboatman = std::optional<std::variant<std::vector<nlohmann::json>, std::string>>;

    using Calaverite = std::variant<std::vector<int64_t>, std::string>;

    using Catallactic = std::variant<std::vector<nlohmann::json>, bool, std::map<std::string, int64_t>>;

    using Cemental = std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>>;

    class ChytridiaceaeClass {
        public:
        ChytridiaceaeClass() = default;
        virtual ~ChytridiaceaeClass() = default;

        private:
        nlohmann::json batidaceae;
        nlohmann::json brechites;
        nlohmann::json codespairer;
        nlohmann::json emery;
        nlohmann::json enervative;
        nlohmann::json excriminate;
        nlohmann::json goshenite;
        nlohmann::json grime;
        nlohmann::json gritten;
        nlohmann::json hectorly;
        nlohmann::json intermediation;
        nlohmann::json meeterly;
        nlohmann::json narraganset;
        nlohmann::json onymatic;
        nlohmann::json paddlecock;
        nlohmann::json thana;
        nlohmann::json thornily;
        nlohmann::json uckia;
        nlohmann::json unmettle;
        nlohmann::json vorticellid;

        public:
        nlohmann::json const & get_batidaceae() const { return batidaceae; }
        nlohmann::json & get_mutable_batidaceae() { return batidaceae; }
        void set_batidaceae(nlohmann::json const & value) { this->batidaceae = value; }

        nlohmann::json const & get_brechites() const { return brechites; }
        nlohmann::json & get_mutable_brechites() { return brechites; }
        void set_brechites(nlohmann::json const & value) { this->brechites = value; }

        nlohmann::json const & get_codespairer() const { return codespairer; }
        nlohmann::json & get_mutable_codespairer() { return codespairer; }
        void set_codespairer(nlohmann::json const & value) { this->codespairer = value; }

        nlohmann::json const & get_emery() const { return emery; }
        nlohmann::json & get_mutable_emery() { return emery; }
        void set_emery(nlohmann::json const & value) { this->emery = value; }

        nlohmann::json const & get_enervative() const { return enervative; }
        nlohmann::json & get_mutable_enervative() { return enervative; }
        void set_enervative(nlohmann::json const & value) { this->enervative = value; }

        nlohmann::json const & get_excriminate() const { return excriminate; }
        nlohmann::json & get_mutable_excriminate() { return excriminate; }
        void set_excriminate(nlohmann::json const & value) { this->excriminate = value; }

        nlohmann::json const & get_goshenite() const { return goshenite; }
        nlohmann::json & get_mutable_goshenite() { return goshenite; }
        void set_goshenite(nlohmann::json const & value) { this->goshenite = value; }

        nlohmann::json const & get_grime() const { return grime; }
        nlohmann::json & get_mutable_grime() { return grime; }
        void set_grime(nlohmann::json const & value) { this->grime = value; }

        nlohmann::json const & get_gritten() const { return gritten; }
        nlohmann::json & get_mutable_gritten() { return gritten; }
        void set_gritten(nlohmann::json const & value) { this->gritten = value; }

        nlohmann::json const & get_hectorly() const { return hectorly; }
        nlohmann::json & get_mutable_hectorly() { return hectorly; }
        void set_hectorly(nlohmann::json const & value) { this->hectorly = value; }

        nlohmann::json const & get_intermediation() const { return intermediation; }
        nlohmann::json & get_mutable_intermediation() { return intermediation; }
        void set_intermediation(nlohmann::json const & value) { this->intermediation = value; }

        nlohmann::json const & get_meeterly() const { return meeterly; }
        nlohmann::json & get_mutable_meeterly() { return meeterly; }
        void set_meeterly(nlohmann::json const & value) { this->meeterly = value; }

        nlohmann::json const & get_narraganset() const { return narraganset; }
        nlohmann::json & get_mutable_narraganset() { return narraganset; }
        void set_narraganset(nlohmann::json const & value) { this->narraganset = value; }

        nlohmann::json const & get_onymatic() const { return onymatic; }
        nlohmann::json & get_mutable_onymatic() { return onymatic; }
        void set_onymatic(nlohmann::json const & value) { this->onymatic = value; }

        nlohmann::json const & get_paddlecock() const { return paddlecock; }
        nlohmann::json & get_mutable_paddlecock() { return paddlecock; }
        void set_paddlecock(nlohmann::json const & value) { this->paddlecock = value; }

        nlohmann::json const & get_thana() const { return thana; }
        nlohmann::json & get_mutable_thana() { return thana; }
        void set_thana(nlohmann::json const & value) { this->thana = value; }

        nlohmann::json const & get_thornily() const { return thornily; }
        nlohmann::json & get_mutable_thornily() { return thornily; }
        void set_thornily(nlohmann::json const & value) { this->thornily = value; }

        nlohmann::json const & get_uckia() const { return uckia; }
        nlohmann::json & get_mutable_uckia() { return uckia; }
        void set_uckia(nlohmann::json const & value) { this->uckia = value; }

        nlohmann::json const & get_unmettle() const { return unmettle; }
        nlohmann::json & get_mutable_unmettle() { return unmettle; }
        void set_unmettle(nlohmann::json const & value) { this->unmettle = value; }

        nlohmann::json const & get_vorticellid() const { return vorticellid; }
        nlohmann::json & get_mutable_vorticellid() { return vorticellid; }
        void set_vorticellid(nlohmann::json const & value) { this->vorticellid = value; }
    };

    using ChytridiaceaeElement = std::optional<std::variant<bool, ChytridiaceaeClass>>;

    class DiscordiaClass {
        public:
        DiscordiaClass() = default;
        virtual ~DiscordiaClass() = default;

        private:
        std::optional<int64_t> altaic;
        std::optional<int64_t> amoristic;
        std::optional<int64_t> blennophthalmia;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> disciplinability;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> goofer;
        std::optional<bool> homocerc;
        std::optional<int64_t> laryngograph;
        std::optional<int64_t> leucitis;
        std::optional<int64_t> lymphocyst;
        std::optional<int64_t> microcosmology;
        std::optional<int64_t> nauseation;
        nlohmann::json nonbookish;
        std::optional<int64_t> patarin;
        std::optional<int64_t> preliberal;
        std::optional<int64_t> prettifier;
        std::optional<int64_t> rangework;
        std::optional<int64_t> redient;
        std::optional<int64_t> subfusiform;
        std::optional<int64_t> suicidical;
        std::optional<int64_t> swow;
        std::optional<int64_t> wastrel;
        std::optional<int64_t> wingle;

        public:
        std::optional<int64_t> const & get_altaic() const { return altaic; }
        std::optional<int64_t> & get_mutable_altaic() { return altaic; }
        void set_altaic(std::optional<int64_t> const & value) { this->altaic = value; }

        std::optional<int64_t> const & get_amoristic() const { return amoristic; }
        std::optional<int64_t> & get_mutable_amoristic() { return amoristic; }
        void set_amoristic(std::optional<int64_t> const & value) { this->amoristic = value; }

        std::optional<int64_t> const & get_blennophthalmia() const { return blennophthalmia; }
        std::optional<int64_t> & get_mutable_blennophthalmia() { return blennophthalmia; }
        void set_blennophthalmia(std::optional<int64_t> const & value) { this->blennophthalmia = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_disciplinability() const { return disciplinability; }
        std::optional<int64_t> & get_mutable_disciplinability() { return disciplinability; }
        void set_disciplinability(std::optional<int64_t> const & value) { this->disciplinability = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_goofer() const { return goofer; }
        std::optional<int64_t> & get_mutable_goofer() { return goofer; }
        void set_goofer(std::optional<int64_t> const & value) { this->goofer = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_laryngograph() const { return laryngograph; }
        std::optional<int64_t> & get_mutable_laryngograph() { return laryngograph; }
        void set_laryngograph(std::optional<int64_t> const & value) { this->laryngograph = value; }

        std::optional<int64_t> const & get_leucitis() const { return leucitis; }
        std::optional<int64_t> & get_mutable_leucitis() { return leucitis; }
        void set_leucitis(std::optional<int64_t> const & value) { this->leucitis = value; }

        std::optional<int64_t> const & get_lymphocyst() const { return lymphocyst; }
        std::optional<int64_t> & get_mutable_lymphocyst() { return lymphocyst; }
        void set_lymphocyst(std::optional<int64_t> const & value) { this->lymphocyst = value; }

        std::optional<int64_t> const & get_microcosmology() const { return microcosmology; }
        std::optional<int64_t> & get_mutable_microcosmology() { return microcosmology; }
        void set_microcosmology(std::optional<int64_t> const & value) { this->microcosmology = value; }

        std::optional<int64_t> const & get_nauseation() const { return nauseation; }
        std::optional<int64_t> & get_mutable_nauseation() { return nauseation; }
        void set_nauseation(std::optional<int64_t> const & value) { this->nauseation = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_patarin() const { return patarin; }
        std::optional<int64_t> & get_mutable_patarin() { return patarin; }
        void set_patarin(std::optional<int64_t> const & value) { this->patarin = value; }

        std::optional<int64_t> const & get_preliberal() const { return preliberal; }
        std::optional<int64_t> & get_mutable_preliberal() { return preliberal; }
        void set_preliberal(std::optional<int64_t> const & value) { this->preliberal = value; }

        std::optional<int64_t> const & get_prettifier() const { return prettifier; }
        std::optional<int64_t> & get_mutable_prettifier() { return prettifier; }
        void set_prettifier(std::optional<int64_t> const & value) { this->prettifier = value; }

        std::optional<int64_t> const & get_rangework() const { return rangework; }
        std::optional<int64_t> & get_mutable_rangework() { return rangework; }
        void set_rangework(std::optional<int64_t> const & value) { this->rangework = value; }

        std::optional<int64_t> const & get_redient() const { return redient; }
        std::optional<int64_t> & get_mutable_redient() { return redient; }
        void set_redient(std::optional<int64_t> const & value) { this->redient = value; }

        std::optional<int64_t> const & get_subfusiform() const { return subfusiform; }
        std::optional<int64_t> & get_mutable_subfusiform() { return subfusiform; }
        void set_subfusiform(std::optional<int64_t> const & value) { this->subfusiform = value; }

        std::optional<int64_t> const & get_suicidical() const { return suicidical; }
        std::optional<int64_t> & get_mutable_suicidical() { return suicidical; }
        void set_suicidical(std::optional<int64_t> const & value) { this->suicidical = value; }

        std::optional<int64_t> const & get_swow() const { return swow; }
        std::optional<int64_t> & get_mutable_swow() { return swow; }
        void set_swow(std::optional<int64_t> const & value) { this->swow = value; }

        std::optional<int64_t> const & get_wastrel() const { return wastrel; }
        std::optional<int64_t> & get_mutable_wastrel() { return wastrel; }
        void set_wastrel(std::optional<int64_t> const & value) { this->wastrel = value; }

        std::optional<int64_t> const & get_wingle() const { return wingle; }
        std::optional<int64_t> & get_mutable_wingle() { return wingle; }
        void set_wingle(std::optional<int64_t> const & value) { this->wingle = value; }
    };

    using DiscordiaElement = std::variant<std::vector<int64_t>, DiscordiaClass>;

    using Endomyce = std::variant<int64_t, std::string>;

    using Epinephelidae = std::variant<bool, int64_t, std::string>;

    using Eupatorium = std::variant<std::vector<nlohmann::json>, std::map<std::string, int64_t>>;

    class GryphosaurusClass {
        public:
        GryphosaurusClass() = default;
        virtual ~GryphosaurusClass() = default;

        private:
        nlohmann::json amissibility;
        nlohmann::json burushaski;
        nlohmann::json citronin;
        nlohmann::json coplaintiff;
        nlohmann::json disquisitionary;
        nlohmann::json enoplan;
        nlohmann::json faintness;
        nlohmann::json hebetomy;
        nlohmann::json islandry;
        nlohmann::json lameduck;
        nlohmann::json overbattle;
        nlohmann::json overinterested;
        nlohmann::json phrenologic;
        nlohmann::json rainband;
        nlohmann::json shiningly;
        nlohmann::json stamineous;
        nlohmann::json subscapularis;
        nlohmann::json tahami;
        nlohmann::json undaubed;
        nlohmann::json underntime;

        public:
        nlohmann::json const & get_amissibility() const { return amissibility; }
        nlohmann::json & get_mutable_amissibility() { return amissibility; }
        void set_amissibility(nlohmann::json const & value) { this->amissibility = value; }

        nlohmann::json const & get_burushaski() const { return burushaski; }
        nlohmann::json & get_mutable_burushaski() { return burushaski; }
        void set_burushaski(nlohmann::json const & value) { this->burushaski = value; }

        nlohmann::json const & get_citronin() const { return citronin; }
        nlohmann::json & get_mutable_citronin() { return citronin; }
        void set_citronin(nlohmann::json const & value) { this->citronin = value; }

        nlohmann::json const & get_coplaintiff() const { return coplaintiff; }
        nlohmann::json & get_mutable_coplaintiff() { return coplaintiff; }
        void set_coplaintiff(nlohmann::json const & value) { this->coplaintiff = value; }

        nlohmann::json const & get_disquisitionary() const { return disquisitionary; }
        nlohmann::json & get_mutable_disquisitionary() { return disquisitionary; }
        void set_disquisitionary(nlohmann::json const & value) { this->disquisitionary = value; }

        nlohmann::json const & get_enoplan() const { return enoplan; }
        nlohmann::json & get_mutable_enoplan() { return enoplan; }
        void set_enoplan(nlohmann::json const & value) { this->enoplan = value; }

        nlohmann::json const & get_faintness() const { return faintness; }
        nlohmann::json & get_mutable_faintness() { return faintness; }
        void set_faintness(nlohmann::json const & value) { this->faintness = value; }

        nlohmann::json const & get_hebetomy() const { return hebetomy; }
        nlohmann::json & get_mutable_hebetomy() { return hebetomy; }
        void set_hebetomy(nlohmann::json const & value) { this->hebetomy = value; }

        nlohmann::json const & get_islandry() const { return islandry; }
        nlohmann::json & get_mutable_islandry() { return islandry; }
        void set_islandry(nlohmann::json const & value) { this->islandry = value; }

        nlohmann::json const & get_lameduck() const { return lameduck; }
        nlohmann::json & get_mutable_lameduck() { return lameduck; }
        void set_lameduck(nlohmann::json const & value) { this->lameduck = value; }

        nlohmann::json const & get_overbattle() const { return overbattle; }
        nlohmann::json & get_mutable_overbattle() { return overbattle; }
        void set_overbattle(nlohmann::json const & value) { this->overbattle = value; }

        nlohmann::json const & get_overinterested() const { return overinterested; }
        nlohmann::json & get_mutable_overinterested() { return overinterested; }
        void set_overinterested(nlohmann::json const & value) { this->overinterested = value; }

        nlohmann::json const & get_phrenologic() const { return phrenologic; }
        nlohmann::json & get_mutable_phrenologic() { return phrenologic; }
        void set_phrenologic(nlohmann::json const & value) { this->phrenologic = value; }

        nlohmann::json const & get_rainband() const { return rainband; }
        nlohmann::json & get_mutable_rainband() { return rainband; }
        void set_rainband(nlohmann::json const & value) { this->rainband = value; }

        nlohmann::json const & get_shiningly() const { return shiningly; }
        nlohmann::json & get_mutable_shiningly() { return shiningly; }
        void set_shiningly(nlohmann::json const & value) { this->shiningly = value; }

        nlohmann::json const & get_stamineous() const { return stamineous; }
        nlohmann::json & get_mutable_stamineous() { return stamineous; }
        void set_stamineous(nlohmann::json const & value) { this->stamineous = value; }

        nlohmann::json const & get_subscapularis() const { return subscapularis; }
        nlohmann::json & get_mutable_subscapularis() { return subscapularis; }
        void set_subscapularis(nlohmann::json const & value) { this->subscapularis = value; }

        nlohmann::json const & get_tahami() const { return tahami; }
        nlohmann::json & get_mutable_tahami() { return tahami; }
        void set_tahami(nlohmann::json const & value) { this->tahami = value; }

        nlohmann::json const & get_undaubed() const { return undaubed; }
        nlohmann::json & get_mutable_undaubed() { return undaubed; }
        void set_undaubed(nlohmann::json const & value) { this->undaubed = value; }

        nlohmann::json const & get_underntime() const { return underntime; }
        nlohmann::json & get_mutable_underntime() { return underntime; }
        void set_underntime(nlohmann::json const & value) { this->underntime = value; }
    };

    using GryphosaurusElement = std::variant<std::vector<int64_t>, GryphosaurusClass, std::string>;

    using Koryak = std::variant<std::map<std::string, std::optional<int64_t>>, std::string>;

    class LaviniaClass {
        public:
        LaviniaClass() = default;
        virtual ~LaviniaClass() = default;

        private:
        std::optional<int64_t> agitable;
        std::optional<int64_t> asininity;
        std::optional<int64_t> benefiter;
        std::optional<int64_t> bronzelike;
        std::optional<double> catharticalness;
        std::optional<int64_t> chirotherium;
        std::optional<int64_t> cholesteatomatous;
        std::optional<int64_t> deprivement;
        std::optional<std::string> disdiapason;
        std::optional<int64_t> flippantness;
        std::optional<int64_t> fogproof;
        std::optional<bool> homocerc;
        std::optional<int64_t> merrymeeting;
        nlohmann::json nonbookish;
        std::optional<int64_t> overcareful;
        std::optional<int64_t> panaris;
        std::optional<int64_t> preacceptance;
        std::optional<int64_t> quinoxaline;
        std::optional<int64_t> sig;
        std::optional<int64_t> superconfusion;
        std::optional<int64_t> tacana;
        std::optional<int64_t> tillotter;
        std::optional<int64_t> tranquillize;
        std::optional<int64_t> unquestionable;
        std::optional<int64_t> uproute;

        public:
        std::optional<int64_t> const & get_agitable() const { return agitable; }
        std::optional<int64_t> & get_mutable_agitable() { return agitable; }
        void set_agitable(std::optional<int64_t> const & value) { this->agitable = value; }

        std::optional<int64_t> const & get_asininity() const { return asininity; }
        std::optional<int64_t> & get_mutable_asininity() { return asininity; }
        void set_asininity(std::optional<int64_t> const & value) { this->asininity = value; }

        std::optional<int64_t> const & get_benefiter() const { return benefiter; }
        std::optional<int64_t> & get_mutable_benefiter() { return benefiter; }
        void set_benefiter(std::optional<int64_t> const & value) { this->benefiter = value; }

        std::optional<int64_t> const & get_bronzelike() const { return bronzelike; }
        std::optional<int64_t> & get_mutable_bronzelike() { return bronzelike; }
        void set_bronzelike(std::optional<int64_t> const & value) { this->bronzelike = value; }

        std::optional<double> const & get_catharticalness() const { return catharticalness; }
        std::optional<double> & get_mutable_catharticalness() { return catharticalness; }
        void set_catharticalness(std::optional<double> const & value) { this->catharticalness = value; }

        std::optional<int64_t> const & get_chirotherium() const { return chirotherium; }
        std::optional<int64_t> & get_mutable_chirotherium() { return chirotherium; }
        void set_chirotherium(std::optional<int64_t> const & value) { this->chirotherium = value; }

        std::optional<int64_t> const & get_cholesteatomatous() const { return cholesteatomatous; }
        std::optional<int64_t> & get_mutable_cholesteatomatous() { return cholesteatomatous; }
        void set_cholesteatomatous(std::optional<int64_t> const & value) { this->cholesteatomatous = value; }

        std::optional<int64_t> const & get_deprivement() const { return deprivement; }
        std::optional<int64_t> & get_mutable_deprivement() { return deprivement; }
        void set_deprivement(std::optional<int64_t> const & value) { this->deprivement = value; }

        std::optional<std::string> const & get_disdiapason() const { return disdiapason; }
        std::optional<std::string> & get_mutable_disdiapason() { return disdiapason; }
        void set_disdiapason(std::optional<std::string> const & value) { this->disdiapason = value; }

        std::optional<int64_t> const & get_flippantness() const { return flippantness; }
        std::optional<int64_t> & get_mutable_flippantness() { return flippantness; }
        void set_flippantness(std::optional<int64_t> const & value) { this->flippantness = value; }

        std::optional<int64_t> const & get_fogproof() const { return fogproof; }
        std::optional<int64_t> & get_mutable_fogproof() { return fogproof; }
        void set_fogproof(std::optional<int64_t> const & value) { this->fogproof = value; }

        std::optional<bool> const & get_homocerc() const { return homocerc; }
        std::optional<bool> & get_mutable_homocerc() { return homocerc; }
        void set_homocerc(std::optional<bool> const & value) { this->homocerc = value; }

        std::optional<int64_t> const & get_merrymeeting() const { return merrymeeting; }
        std::optional<int64_t> & get_mutable_merrymeeting() { return merrymeeting; }
        void set_merrymeeting(std::optional<int64_t> const & value) { this->merrymeeting = value; }

        nlohmann::json const & get_nonbookish() const { return nonbookish; }
        nlohmann::json & get_mutable_nonbookish() { return nonbookish; }
        void set_nonbookish(nlohmann::json const & value) { this->nonbookish = value; }

        std::optional<int64_t> const & get_overcareful() const { return overcareful; }
        std::optional<int64_t> & get_mutable_overcareful() { return overcareful; }
        void set_overcareful(std::optional<int64_t> const & value) { this->overcareful = value; }

        std::optional<int64_t> const & get_panaris() const { return panaris; }
        std::optional<int64_t> & get_mutable_panaris() { return panaris; }
        void set_panaris(std::optional<int64_t> const & value) { this->panaris = value; }

        std::optional<int64_t> const & get_preacceptance() const { return preacceptance; }
        std::optional<int64_t> & get_mutable_preacceptance() { return preacceptance; }
        void set_preacceptance(std::optional<int64_t> const & value) { this->preacceptance = value; }

        std::optional<int64_t> const & get_quinoxaline() const { return quinoxaline; }
        std::optional<int64_t> & get_mutable_quinoxaline() { return quinoxaline; }
        void set_quinoxaline(std::optional<int64_t> const & value) { this->quinoxaline = value; }

        std::optional<int64_t> const & get_sig() const { return sig; }
        std::optional<int64_t> & get_mutable_sig() { return sig; }
        void set_sig(std::optional<int64_t> const & value) { this->sig = value; }

        std::optional<int64_t> const & get_superconfusion() const { return superconfusion; }
        std::optional<int64_t> & get_mutable_superconfusion() { return superconfusion; }
        void set_superconfusion(std::optional<int64_t> const & value) { this->superconfusion = value; }

        std::optional<int64_t> const & get_tacana() const { return tacana; }
        std::optional<int64_t> & get_mutable_tacana() { return tacana; }
        void set_tacana(std::optional<int64_t> const & value) { this->tacana = value; }

        std::optional<int64_t> const & get_tillotter() const { return tillotter; }
        std::optional<int64_t> & get_mutable_tillotter() { return tillotter; }
        void set_tillotter(std::optional<int64_t> const & value) { this->tillotter = value; }

        std::optional<int64_t> const & get_tranquillize() const { return tranquillize; }
        std::optional<int64_t> & get_mutable_tranquillize() { return tranquillize; }
        void set_tranquillize(std::optional<int64_t> const & value) { this->tranquillize = value; }

        std::optional<int64_t> const & get_unquestionable() const { return unquestionable; }
        std::optional<int64_t> & get_mutable_unquestionable() { return unquestionable; }
        void set_unquestionable(std::optional<int64_t> const & value) { this->unquestionable = value; }

        std::optional<int64_t> const & get_uproute() const { return uproute; }
        std::optional<int64_t> & get_mutable_uproute() { return uproute; }
        void set_uproute(std::optional<int64_t> const & value) { this->uproute = value; }
    };

    using LaviniaElement = std::variant<LaviniaClass, std::string>;

    class OskarClass {
        public:
        OskarClass() = default;
        virtual ~OskarClass() = default;

        private:
        nlohmann::json acrobates;
        nlohmann::json beanshooter;
        nlohmann::json bearhound;
        nlohmann::json cayuga;
        nlohmann::json guarneri;
        nlohmann::json hypochondriacism;
        nlohmann::json indication;
        nlohmann::json jaculative;
        nlohmann::json nagana;
        nlohmann::json netherlandish;
        nlohmann::json noctivagous;
        nlohmann::json nonphysiological;
        nlohmann::json praxis;
        nlohmann::json provision;
        nlohmann::json subterhuman;
        nlohmann::json sunlit;
        nlohmann::json syncraniate;
        nlohmann::json teachment;
        nlohmann::json unmutinous;
        nlohmann::json unstoppable;

        public:
        nlohmann::json const & get_acrobates() const { return acrobates; }
        nlohmann::json & get_mutable_acrobates() { return acrobates; }
        void set_acrobates(nlohmann::json const & value) { this->acrobates = value; }

        nlohmann::json const & get_beanshooter() const { return beanshooter; }
        nlohmann::json & get_mutable_beanshooter() { return beanshooter; }
        void set_beanshooter(nlohmann::json const & value) { this->beanshooter = value; }

        nlohmann::json const & get_bearhound() const { return bearhound; }
        nlohmann::json & get_mutable_bearhound() { return bearhound; }
        void set_bearhound(nlohmann::json const & value) { this->bearhound = value; }

        nlohmann::json const & get_cayuga() const { return cayuga; }
        nlohmann::json & get_mutable_cayuga() { return cayuga; }
        void set_cayuga(nlohmann::json const & value) { this->cayuga = value; }

        nlohmann::json const & get_guarneri() const { return guarneri; }
        nlohmann::json & get_mutable_guarneri() { return guarneri; }
        void set_guarneri(nlohmann::json const & value) { this->guarneri = value; }

        nlohmann::json const & get_hypochondriacism() const { return hypochondriacism; }
        nlohmann::json & get_mutable_hypochondriacism() { return hypochondriacism; }
        void set_hypochondriacism(nlohmann::json const & value) { this->hypochondriacism = value; }

        nlohmann::json const & get_indication() const { return indication; }
        nlohmann::json & get_mutable_indication() { return indication; }
        void set_indication(nlohmann::json const & value) { this->indication = value; }

        nlohmann::json const & get_jaculative() const { return jaculative; }
        nlohmann::json & get_mutable_jaculative() { return jaculative; }
        void set_jaculative(nlohmann::json const & value) { this->jaculative = value; }

        nlohmann::json const & get_nagana() const { return nagana; }
        nlohmann::json & get_mutable_nagana() { return nagana; }
        void set_nagana(nlohmann::json const & value) { this->nagana = value; }

        nlohmann::json const & get_netherlandish() const { return netherlandish; }
        nlohmann::json & get_mutable_netherlandish() { return netherlandish; }
        void set_netherlandish(nlohmann::json const & value) { this->netherlandish = value; }

        nlohmann::json const & get_noctivagous() const { return noctivagous; }
        nlohmann::json & get_mutable_noctivagous() { return noctivagous; }
        void set_noctivagous(nlohmann::json const & value) { this->noctivagous = value; }

        nlohmann::json const & get_nonphysiological() const { return nonphysiological; }
        nlohmann::json & get_mutable_nonphysiological() { return nonphysiological; }
        void set_nonphysiological(nlohmann::json const & value) { this->nonphysiological = value; }

        nlohmann::json const & get_praxis() const { return praxis; }
        nlohmann::json & get_mutable_praxis() { return praxis; }
        void set_praxis(nlohmann::json const & value) { this->praxis = value; }

        nlohmann::json const & get_provision() const { return provision; }
        nlohmann::json & get_mutable_provision() { return provision; }
        void set_provision(nlohmann::json const & value) { this->provision = value; }

        nlohmann::json const & get_subterhuman() const { return subterhuman; }
        nlohmann::json & get_mutable_subterhuman() { return subterhuman; }
        void set_subterhuman(nlohmann::json const & value) { this->subterhuman = value; }

        nlohmann::json const & get_sunlit() const { return sunlit; }
        nlohmann::json & get_mutable_sunlit() { return sunlit; }
        void set_sunlit(nlohmann::json const & value) { this->sunlit = value; }

        nlohmann::json const & get_syncraniate() const { return syncraniate; }
        nlohmann::json & get_mutable_syncraniate() { return syncraniate; }
        void set_syncraniate(nlohmann::json const & value) { this->syncraniate = value; }

        nlohmann::json const & get_teachment() const { return teachment; }
        nlohmann::json & get_mutable_teachment() { return teachment; }
        void set_teachment(nlohmann::json const & value) { this->teachment = value; }

        nlohmann::json const & get_unmutinous() const { return unmutinous; }
        nlohmann::json & get_mutable_unmutinous() { return unmutinous; }
        void set_unmutinous(nlohmann::json const & value) { this->unmutinous = value; }

        nlohmann::json const & get_unstoppable() const { return unstoppable; }
        nlohmann::json & get_mutable_unstoppable() { return unstoppable; }
        void set_unstoppable(nlohmann::json const & value) { this->unstoppable = value; }
    };

    using OskarElement = std::variant<std::vector<int64_t>, OskarClass>;

    using RebeccaElement = std::variant<Rebecca, int64_t, std::string>;

    using Rhomboganoidei = std::variant<std::vector<int64_t>, Rebecca, std::string>;

    using Ruellia = std::variant<bool, Rebecca, std::string>;

    using School = std::optional<std::variant<int64_t, std::map<std::string, int64_t>>>;

    using Shakespearolater = std::variant<std::vector<int64_t>, double, std::string>;

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Abranchiata> abranchiata;
        std::vector<Academe> academe;
        std::vector<Acquirable> acquirable;
        std::vector<Aerometry> aerometry;
        std::vector<Alexin> alexin;
        std::vector<AlleviateElement> alleviate;
        std::vector<Amaa> amaas;
        std::vector<Ambassage> ambassage;
        std::vector<std::optional<Amphithyron>> amphithyron;
        std::vector<std::optional<std::string>> andriana;
        std::vector<AnkeeElement> ankee;
        std::vector<std::optional<std::map<std::string, std::optional<int64_t>>>> annihilator;
        nlohmann::json annulose;
        std::vector<AnsarieElement> ansarie;
        std::vector<Aphasia> aphasia;
        std::vector<Asprawl> asprawl;
        std::vector<std::optional<bool>> attractive;
        std::map<std::string, int64_t> barksome;
        std::vector<Bedesman> bedesman;
        std::vector<Belard> belard;
        std::vector<Bocking> bocking;
        std::vector<Brawlingly> brawlingly;
        std::vector<Brookie> brookie;
        std::vector<Bumboatman> bumboatman;
        std::vector<nlohmann::json> bystreet;
        std::vector<Calaverite> calaverite;
        std::vector<Catallactic> catallactic;
        std::vector<Cemental> cemental;
        std::vector<ChytridiaceaeElement> chytridiaceae;
        std::vector<DiscordiaElement> discordia;
        std::vector<Endomyce> endomyces;
        std::vector<Epinephelidae> epinephelidae;
        std::vector<Eupatorium> eupatorium;
        std::vector<GryphosaurusElement> gryphosaurus;
        std::vector<Koryak> koryak;
        std::vector<LaviniaElement> lavinia;
        std::vector<OskarElement> oskar;
        std::vector<RebeccaElement> rebecca;
        std::vector<Rhomboganoidei> rhomboganoidei;
        bool rigsmal;
        std::vector<Ruellia> ruellia;
        std::vector<School> school;
        std::vector<Shakespearolater> shakespearolater;
        std::vector<double> svan;
        std::map<std::string, double> wayao;

        public:
        std::vector<Abranchiata> const & get_abranchiata() const { return abranchiata; }
        std::vector<Abranchiata> & get_mutable_abranchiata() { return abranchiata; }
        void set_abranchiata(std::vector<Abranchiata> const & value) { this->abranchiata = value; }

        std::vector<Academe> const & get_academe() const { return academe; }
        std::vector<Academe> & get_mutable_academe() { return academe; }
        void set_academe(std::vector<Academe> const & value) { this->academe = value; }

        std::vector<Acquirable> const & get_acquirable() const { return acquirable; }
        std::vector<Acquirable> & get_mutable_acquirable() { return acquirable; }
        void set_acquirable(std::vector<Acquirable> const & value) { this->acquirable = value; }

        std::vector<Aerometry> const & get_aerometry() const { return aerometry; }
        std::vector<Aerometry> & get_mutable_aerometry() { return aerometry; }
        void set_aerometry(std::vector<Aerometry> const & value) { this->aerometry = value; }

        std::vector<Alexin> const & get_alexin() const { return alexin; }
        std::vector<Alexin> & get_mutable_alexin() { return alexin; }
        void set_alexin(std::vector<Alexin> const & value) { this->alexin = value; }

        std::vector<AlleviateElement> const & get_alleviate() const { return alleviate; }
        std::vector<AlleviateElement> & get_mutable_alleviate() { return alleviate; }
        void set_alleviate(std::vector<AlleviateElement> const & value) { this->alleviate = value; }

        std::vector<Amaa> const & get_amaas() const { return amaas; }
        std::vector<Amaa> & get_mutable_amaas() { return amaas; }
        void set_amaas(std::vector<Amaa> const & value) { this->amaas = value; }

        std::vector<Ambassage> const & get_ambassage() const { return ambassage; }
        std::vector<Ambassage> & get_mutable_ambassage() { return ambassage; }
        void set_ambassage(std::vector<Ambassage> const & value) { this->ambassage = value; }

        std::vector<std::optional<Amphithyron>> const & get_amphithyron() const { return amphithyron; }
        std::vector<std::optional<Amphithyron>> & get_mutable_amphithyron() { return amphithyron; }
        void set_amphithyron(std::vector<std::optional<Amphithyron>> const & value) { this->amphithyron = value; }

        std::vector<std::optional<std::string>> const & get_andriana() const { return andriana; }
        std::vector<std::optional<std::string>> & get_mutable_andriana() { return andriana; }
        void set_andriana(std::vector<std::optional<std::string>> const & value) { this->andriana = value; }

        std::vector<AnkeeElement> const & get_ankee() const { return ankee; }
        std::vector<AnkeeElement> & get_mutable_ankee() { return ankee; }
        void set_ankee(std::vector<AnkeeElement> const & value) { this->ankee = value; }

        std::vector<std::optional<std::map<std::string, std::optional<int64_t>>>> const & get_annihilator() const { return annihilator; }
        std::vector<std::optional<std::map<std::string, std::optional<int64_t>>>> & get_mutable_annihilator() { return annihilator; }
        void set_annihilator(std::vector<std::optional<std::map<std::string, std::optional<int64_t>>>> const & value) { this->annihilator = value; }

        nlohmann::json const & get_annulose() const { return annulose; }
        nlohmann::json & get_mutable_annulose() { return annulose; }
        void set_annulose(nlohmann::json const & value) { this->annulose = value; }

        std::vector<AnsarieElement> const & get_ansarie() const { return ansarie; }
        std::vector<AnsarieElement> & get_mutable_ansarie() { return ansarie; }
        void set_ansarie(std::vector<AnsarieElement> const & value) { this->ansarie = value; }

        std::vector<Aphasia> const & get_aphasia() const { return aphasia; }
        std::vector<Aphasia> & get_mutable_aphasia() { return aphasia; }
        void set_aphasia(std::vector<Aphasia> const & value) { this->aphasia = value; }

        std::vector<Asprawl> const & get_asprawl() const { return asprawl; }
        std::vector<Asprawl> & get_mutable_asprawl() { return asprawl; }
        void set_asprawl(std::vector<Asprawl> const & value) { this->asprawl = value; }

        std::vector<std::optional<bool>> const & get_attractive() const { return attractive; }
        std::vector<std::optional<bool>> & get_mutable_attractive() { return attractive; }
        void set_attractive(std::vector<std::optional<bool>> const & value) { this->attractive = value; }

        std::map<std::string, int64_t> const & get_barksome() const { return barksome; }
        std::map<std::string, int64_t> & get_mutable_barksome() { return barksome; }
        void set_barksome(std::map<std::string, int64_t> const & value) { this->barksome = value; }

        std::vector<Bedesman> const & get_bedesman() const { return bedesman; }
        std::vector<Bedesman> & get_mutable_bedesman() { return bedesman; }
        void set_bedesman(std::vector<Bedesman> const & value) { this->bedesman = value; }

        std::vector<Belard> const & get_belard() const { return belard; }
        std::vector<Belard> & get_mutable_belard() { return belard; }
        void set_belard(std::vector<Belard> const & value) { this->belard = value; }

        std::vector<Bocking> const & get_bocking() const { return bocking; }
        std::vector<Bocking> & get_mutable_bocking() { return bocking; }
        void set_bocking(std::vector<Bocking> const & value) { this->bocking = value; }

        std::vector<Brawlingly> const & get_brawlingly() const { return brawlingly; }
        std::vector<Brawlingly> & get_mutable_brawlingly() { return brawlingly; }
        void set_brawlingly(std::vector<Brawlingly> const & value) { this->brawlingly = value; }

        std::vector<Brookie> const & get_brookie() const { return brookie; }
        std::vector<Brookie> & get_mutable_brookie() { return brookie; }
        void set_brookie(std::vector<Brookie> const & value) { this->brookie = value; }

        std::vector<Bumboatman> const & get_bumboatman() const { return bumboatman; }
        std::vector<Bumboatman> & get_mutable_bumboatman() { return bumboatman; }
        void set_bumboatman(std::vector<Bumboatman> const & value) { this->bumboatman = value; }

        std::vector<nlohmann::json> const & get_bystreet() const { return bystreet; }
        std::vector<nlohmann::json> & get_mutable_bystreet() { return bystreet; }
        void set_bystreet(std::vector<nlohmann::json> const & value) { this->bystreet = value; }

        std::vector<Calaverite> const & get_calaverite() const { return calaverite; }
        std::vector<Calaverite> & get_mutable_calaverite() { return calaverite; }
        void set_calaverite(std::vector<Calaverite> const & value) { this->calaverite = value; }

        std::vector<Catallactic> const & get_catallactic() const { return catallactic; }
        std::vector<Catallactic> & get_mutable_catallactic() { return catallactic; }
        void set_catallactic(std::vector<Catallactic> const & value) { this->catallactic = value; }

        std::vector<Cemental> const & get_cemental() const { return cemental; }
        std::vector<Cemental> & get_mutable_cemental() { return cemental; }
        void set_cemental(std::vector<Cemental> const & value) { this->cemental = value; }

        std::vector<ChytridiaceaeElement> const & get_chytridiaceae() const { return chytridiaceae; }
        std::vector<ChytridiaceaeElement> & get_mutable_chytridiaceae() { return chytridiaceae; }
        void set_chytridiaceae(std::vector<ChytridiaceaeElement> const & value) { this->chytridiaceae = value; }

        std::vector<DiscordiaElement> const & get_discordia() const { return discordia; }
        std::vector<DiscordiaElement> & get_mutable_discordia() { return discordia; }
        void set_discordia(std::vector<DiscordiaElement> const & value) { this->discordia = value; }

        std::vector<Endomyce> const & get_endomyces() const { return endomyces; }
        std::vector<Endomyce> & get_mutable_endomyces() { return endomyces; }
        void set_endomyces(std::vector<Endomyce> const & value) { this->endomyces = value; }

        std::vector<Epinephelidae> const & get_epinephelidae() const { return epinephelidae; }
        std::vector<Epinephelidae> & get_mutable_epinephelidae() { return epinephelidae; }
        void set_epinephelidae(std::vector<Epinephelidae> const & value) { this->epinephelidae = value; }

        std::vector<Eupatorium> const & get_eupatorium() const { return eupatorium; }
        std::vector<Eupatorium> & get_mutable_eupatorium() { return eupatorium; }
        void set_eupatorium(std::vector<Eupatorium> const & value) { this->eupatorium = value; }

        std::vector<GryphosaurusElement> const & get_gryphosaurus() const { return gryphosaurus; }
        std::vector<GryphosaurusElement> & get_mutable_gryphosaurus() { return gryphosaurus; }
        void set_gryphosaurus(std::vector<GryphosaurusElement> const & value) { this->gryphosaurus = value; }

        std::vector<Koryak> const & get_koryak() const { return koryak; }
        std::vector<Koryak> & get_mutable_koryak() { return koryak; }
        void set_koryak(std::vector<Koryak> const & value) { this->koryak = value; }

        std::vector<LaviniaElement> const & get_lavinia() const { return lavinia; }
        std::vector<LaviniaElement> & get_mutable_lavinia() { return lavinia; }
        void set_lavinia(std::vector<LaviniaElement> const & value) { this->lavinia = value; }

        std::vector<OskarElement> const & get_oskar() const { return oskar; }
        std::vector<OskarElement> & get_mutable_oskar() { return oskar; }
        void set_oskar(std::vector<OskarElement> const & value) { this->oskar = value; }

        std::vector<RebeccaElement> const & get_rebecca() const { return rebecca; }
        std::vector<RebeccaElement> & get_mutable_rebecca() { return rebecca; }
        void set_rebecca(std::vector<RebeccaElement> const & value) { this->rebecca = value; }

        std::vector<Rhomboganoidei> const & get_rhomboganoidei() const { return rhomboganoidei; }
        std::vector<Rhomboganoidei> & get_mutable_rhomboganoidei() { return rhomboganoidei; }
        void set_rhomboganoidei(std::vector<Rhomboganoidei> const & value) { this->rhomboganoidei = value; }

        bool const & get_rigsmal() const { return rigsmal; }
        bool & get_mutable_rigsmal() { return rigsmal; }
        void set_rigsmal(bool const & value) { this->rigsmal = value; }

        std::vector<Ruellia> const & get_ruellia() const { return ruellia; }
        std::vector<Ruellia> & get_mutable_ruellia() { return ruellia; }
        void set_ruellia(std::vector<Ruellia> const & value) { this->ruellia = value; }

        std::vector<School> const & get_school() const { return school; }
        std::vector<School> & get_mutable_school() { return school; }
        void set_school(std::vector<School> const & value) { this->school = value; }

        std::vector<Shakespearolater> const & get_shakespearolater() const { return shakespearolater; }
        std::vector<Shakespearolater> & get_mutable_shakespearolater() { return shakespearolater; }
        void set_shakespearolater(std::vector<Shakespearolater> const & value) { this->shakespearolater = value; }

        std::vector<double> const & get_svan() const { return svan; }
        std::vector<double> & get_mutable_svan() { return svan; }
        void set_svan(std::vector<double> const & value) { this->svan = value; }

        std::map<std::string, double> const & get_wayao() const { return wayao; }
        std::map<std::string, double> & get_mutable_wayao() { return wayao; }
        void set_wayao(std::map<std::string, double> const & value) { this->wayao = value; }
    };
}

namespace quicktype {
void from_json(json const & j, AlleviateClass & x);
void to_json(json & j, AlleviateClass const & x);

void from_json(json const & j, Rebecca & x);
void to_json(json & j, Rebecca const & x);

void from_json(json const & j, Amphithyron & x);
void to_json(json & j, Amphithyron const & x);

void from_json(json const & j, AnkeeClass & x);
void to_json(json & j, AnkeeClass const & x);

void from_json(json const & j, AnsarieClass & x);
void to_json(json & j, AnsarieClass const & x);

void from_json(json const & j, ChytridiaceaeClass & x);
void to_json(json & j, ChytridiaceaeClass const & x);

void from_json(json const & j, DiscordiaClass & x);
void to_json(json & j, DiscordiaClass const & x);

void from_json(json const & j, GryphosaurusClass & x);
void to_json(json & j, GryphosaurusClass const & x);

void from_json(json const & j, LaviniaClass & x);
void to_json(json & j, LaviniaClass const & x);

void from_json(json const & j, OskarClass & x);
void to_json(json & j, OskarClass const & x);

void from_json(json const & j, TopLevel & x);
void to_json(json & j, TopLevel const & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<int64_t>, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(json const & j, std::variant<bool, double> & x);
    static void to_json(json & j, std::variant<bool, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass>> {
    static void from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> & x);
    static void to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::Rebecca, int64_t>> {
    static void from_json(json const & j, std::variant<bool, quicktype::Rebecca, int64_t> & x);
    static void to_json(json & j, std::variant<bool, quicktype::Rebecca, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<json>, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<json>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnsarieClass>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::AnsarieClass> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::AnsarieClass> const & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(json const & j, std::variant<double, std::string> & x);
    static void to_json(json & j, std::variant<double, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, double, std::string>> {
    static void from_json(json const & j, std::variant<bool, double, std::string> & x);
    static void to_json(json & j, std::variant<bool, double, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, double>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, double> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, double> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(json const & j, std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::Rebecca> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::ChytridiaceaeClass>> {
    static void from_json(json const & j, std::variant<bool, quicktype::ChytridiaceaeClass> & x);
    static void to_json(json & j, std::variant<bool, quicktype::ChytridiaceaeClass> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::DiscordiaClass>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> const & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(json const & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, std::variant<int64_t, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, int64_t, std::string>> {
    static void from_json(json const & j, std::variant<bool, int64_t, std::string> & x);
    static void to_json(json & j, std::variant<bool, int64_t, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::map<std::string, std::optional<int64_t>>, std::string>> {
    static void from_json(json const & j, std::variant<std::map<std::string, std::optional<int64_t>>, std::string> & x);
    static void to_json(json & j, std::variant<std::map<std::string, std::optional<int64_t>>, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LaviniaClass, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::LaviniaClass, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::LaviniaClass, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::OskarClass>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::OskarClass> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::OskarClass> const & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Rebecca, int64_t, std::string>> {
    static void from_json(json const & j, std::variant<quicktype::Rebecca, int64_t, std::string> & x);
    static void to_json(json & j, std::variant<quicktype::Rebecca, int64_t, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::Rebecca, std::string>> {
    static void from_json(json const & j, std::variant<bool, quicktype::Rebecca, std::string> & x);
    static void to_json(json & j, std::variant<bool, quicktype::Rebecca, std::string> const & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>> {
    static void from_json(json const & j, std::variant<int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, std::variant<int64_t, std::map<std::string, int64_t>> const & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double, std::string>> {
    static void from_json(json const & j, std::variant<std::vector<int64_t>, double, std::string> & x);
    static void to_json(json & j, std::variant<std::vector<int64_t>, double, std::string> const & x);
};
}
namespace quicktype {
    inline void from_json(json const & j, AlleviateClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_apriori(get_untyped(j, "apriori"));
        x.set_beggarer(get_untyped(j, "beggarer"));
        x.set_brokenheartedly(get_untyped(j, "brokenheartedly"));
        x.set_debilitation(get_untyped(j, "debilitation"));
        x.set_frike(get_untyped(j, "frike"));
        x.set_gastrolith(get_untyped(j, "gastrolith"));
        x.set_hulsean(get_untyped(j, "Hulsean"));
        x.set_orthocentric(get_untyped(j, "orthocentric"));
        x.set_petaly(get_untyped(j, "petaly"));
        x.set_probudgeting(get_untyped(j, "probudgeting"));
        x.set_reacquire(get_untyped(j, "reacquire"));
        x.set_scow(get_untyped(j, "scow"));
        x.set_shutoff(get_untyped(j, "shutoff"));
        x.set_subcontiguous(get_untyped(j, "subcontiguous"));
        x.set_suffumigate(get_untyped(j, "suffumigate"));
        x.set_transformable(get_untyped(j, "transformable"));
        x.set_uncoroneted(get_untyped(j, "uncoroneted"));
        x.set_unparking(get_untyped(j, "unparking"));
        x.set_unvarnishedness(get_untyped(j, "unvarnishedness"));
        x.set_wherewithal(get_untyped(j, "wherewithal"));
    }

    inline void to_json(json & j, AlleviateClass const & x) {
        j = json::object();
        j["apriori"] = x.get_apriori();
        j["beggarer"] = x.get_beggarer();
        j["brokenheartedly"] = x.get_brokenheartedly();
        j["debilitation"] = x.get_debilitation();
        j["frike"] = x.get_frike();
        j["gastrolith"] = x.get_gastrolith();
        j["Hulsean"] = x.get_hulsean();
        j["orthocentric"] = x.get_orthocentric();
        j["petaly"] = x.get_petaly();
        j["probudgeting"] = x.get_probudgeting();
        j["reacquire"] = x.get_reacquire();
        j["scow"] = x.get_scow();
        j["shutoff"] = x.get_shutoff();
        j["subcontiguous"] = x.get_subcontiguous();
        j["suffumigate"] = x.get_suffumigate();
        j["transformable"] = x.get_transformable();
        j["uncoroneted"] = x.get_uncoroneted();
        j["unparking"] = x.get_unparking();
        j["unvarnishedness"] = x.get_unvarnishedness();
        j["wherewithal"] = x.get_wherewithal();
    }

    inline void from_json(json const & j, Rebecca& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_catharticalness(j.at("catharticalness").get<double>());
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_chirotherium(j.at("Chirotherium").get<int64_t>());
        x.set_disdiapason(j.at("disdiapason").get<std::string>());
        x.set_homocerc(j.at("homocerc").get<bool>());
        x.set_nonbookish(get_untyped(j, "nonbookish"));
    }

    inline void to_json(json & j, Rebecca const & x) {
        j = json::object();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disdiapason"] = x.get_disdiapason();
        j["homocerc"] = x.get_homocerc();
        j["nonbookish"] = x.get_nonbookish();
    }

    inline void from_json(json const & j, Amphithyron& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("akroasis") != j.end() && !j.at("akroasis").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("akroasis") != j.end() && j.at("akroasis").is_null()) throw std::runtime_error("Unexpected null");
        x.set_akroasis(get_stack_optional<int64_t>(j, "akroasis"));
        if (j.find("antiphonical") != j.end() && !j.at("antiphonical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("antiphonical") != j.end() && j.at("antiphonical").is_null()) throw std::runtime_error("Unexpected null");
        x.set_antiphonical(get_stack_optional<int64_t>(j, "antiphonical"));
        if (j.find("basebred") != j.end() && !j.at("basebred").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("basebred") != j.end() && j.at("basebred").is_null()) throw std::runtime_error("Unexpected null");
        x.set_basebred(get_stack_optional<int64_t>(j, "basebred"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("conductometric") != j.end() && !j.at("conductometric").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("conductometric") != j.end() && j.at("conductometric").is_null()) throw std::runtime_error("Unexpected null");
        x.set_conductometric(get_stack_optional<int64_t>(j, "conductometric"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("ensilation") != j.end() && !j.at("ensilation").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ensilation") != j.end() && j.at("ensilation").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ensilation(get_stack_optional<int64_t>(j, "ensilation"));
        if (j.find("eyebolt") != j.end() && !j.at("eyebolt").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("eyebolt") != j.end() && j.at("eyebolt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_eyebolt(get_stack_optional<int64_t>(j, "eyebolt"));
        if (j.find("fistulated") != j.end() && !j.at("fistulated").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("fistulated") != j.end() && j.at("fistulated").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fistulated(get_stack_optional<int64_t>(j, "fistulated"));
        if (j.find("heteropod") != j.end() && !j.at("heteropod").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("heteropod") != j.end() && j.at("heteropod").is_null()) throw std::runtime_error("Unexpected null");
        x.set_heteropod(get_stack_optional<int64_t>(j, "heteropod"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("Juniperus") != j.end() && !j.at("Juniperus").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Juniperus") != j.end() && j.at("Juniperus").is_null()) throw std::runtime_error("Unexpected null");
        x.set_juniperus(get_stack_optional<int64_t>(j, "Juniperus"));
        if (j.find("labyrinthically") != j.end() && !j.at("labyrinthically").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("labyrinthically") != j.end() && j.at("labyrinthically").is_null()) throw std::runtime_error("Unexpected null");
        x.set_labyrinthically(get_stack_optional<int64_t>(j, "labyrinthically"));
        if (j.find("martyrization") != j.end() && !j.at("martyrization").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("martyrization") != j.end() && j.at("martyrization").is_null()) throw std::runtime_error("Unexpected null");
        x.set_martyrization(get_stack_optional<int64_t>(j, "martyrization"));
        if (j.find("mispolicy") != j.end() && !j.at("mispolicy").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mispolicy") != j.end() && j.at("mispolicy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mispolicy(get_stack_optional<int64_t>(j, "mispolicy"));
        if (j.find("multipara") != j.end() && !j.at("multipara").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("multipara") != j.end() && j.at("multipara").is_null()) throw std::runtime_error("Unexpected null");
        x.set_multipara(get_stack_optional<int64_t>(j, "multipara"));
        if (j.find("Nazirite") != j.end() && !j.at("Nazirite").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Nazirite") != j.end() && j.at("Nazirite").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nazirite(get_stack_optional<int64_t>(j, "Nazirite"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("possessorial") != j.end() && !j.at("possessorial").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("possessorial") != j.end() && j.at("possessorial").is_null()) throw std::runtime_error("Unexpected null");
        x.set_possessorial(get_stack_optional<int64_t>(j, "possessorial"));
        if (j.find("shamed") != j.end() && !j.at("shamed").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("shamed") != j.end() && j.at("shamed").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shamed(get_stack_optional<int64_t>(j, "shamed"));
        if (j.find("shelfworn") != j.end() && !j.at("shelfworn").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("shelfworn") != j.end() && j.at("shelfworn").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shelfworn(get_stack_optional<int64_t>(j, "shelfworn"));
        if (j.find("stagnum") != j.end() && !j.at("stagnum").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("stagnum") != j.end() && j.at("stagnum").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stagnum(get_stack_optional<int64_t>(j, "stagnum"));
        if (j.find("Those") != j.end() && !j.at("Those").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Those") != j.end() && j.at("Those").is_null()) throw std::runtime_error("Unexpected null");
        x.set_those(get_stack_optional<int64_t>(j, "Those"));
        if (j.find("undecimal") != j.end() && !j.at("undecimal").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("undecimal") != j.end() && j.at("undecimal").is_null()) throw std::runtime_error("Unexpected null");
        x.set_undecimal(get_stack_optional<int64_t>(j, "undecimal"));
    }

    inline void to_json(json & j, Amphithyron const & x) {
        j = json::object();
        j["akroasis"] = x.get_akroasis();
        j["antiphonical"] = x.get_antiphonical();
        j["basebred"] = x.get_basebred();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["conductometric"] = x.get_conductometric();
        j["disdiapason"] = x.get_disdiapason();
        j["ensilation"] = x.get_ensilation();
        j["eyebolt"] = x.get_eyebolt();
        j["fistulated"] = x.get_fistulated();
        j["heteropod"] = x.get_heteropod();
        j["homocerc"] = x.get_homocerc();
        j["Juniperus"] = x.get_juniperus();
        j["labyrinthically"] = x.get_labyrinthically();
        j["martyrization"] = x.get_martyrization();
        j["mispolicy"] = x.get_mispolicy();
        j["multipara"] = x.get_multipara();
        j["Nazirite"] = x.get_nazirite();
        j["nonbookish"] = x.get_nonbookish();
        j["possessorial"] = x.get_possessorial();
        j["shamed"] = x.get_shamed();
        j["shelfworn"] = x.get_shelfworn();
        j["stagnum"] = x.get_stagnum();
        j["Those"] = x.get_those();
        j["undecimal"] = x.get_undecimal();
    }

    inline void from_json(json const & j, AnkeeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_anomoean(get_untyped(j, "Anomoean"));
        x.set_barleyhood(get_untyped(j, "barleyhood"));
        x.set_befriender(get_untyped(j, "befriender"));
        x.set_brutishness(get_untyped(j, "brutishness"));
        x.set_cephalalgy(get_untyped(j, "cephalalgy"));
        x.set_cirurgian(get_untyped(j, "cirurgian"));
        x.set_conventionally(get_untyped(j, "conventionally"));
        x.set_jackshay(get_untyped(j, "jackshay"));
        x.set_milammeter(get_untyped(j, "milammeter"));
        x.set_naja(get_untyped(j, "Naja"));
        x.set_ombrological(get_untyped(j, "ombrological"));
        x.set_phonasthenia(get_untyped(j, "phonasthenia"));
        x.set_retrievableness(get_untyped(j, "retrievableness"));
        x.set_snakily(get_untyped(j, "snakily"));
        x.set_swot(get_untyped(j, "swot"));
        x.set_tartlet(get_untyped(j, "tartlet"));
        x.set_thiofuran(get_untyped(j, "thiofuran"));
        x.set_tracheophone(get_untyped(j, "tracheophone"));
        x.set_tuglike(get_untyped(j, "tuglike"));
        x.set_unscratchingly(get_untyped(j, "unscratchingly"));
    }

    inline void to_json(json & j, AnkeeClass const & x) {
        j = json::object();
        j["Anomoean"] = x.get_anomoean();
        j["barleyhood"] = x.get_barleyhood();
        j["befriender"] = x.get_befriender();
        j["brutishness"] = x.get_brutishness();
        j["cephalalgy"] = x.get_cephalalgy();
        j["cirurgian"] = x.get_cirurgian();
        j["conventionally"] = x.get_conventionally();
        j["jackshay"] = x.get_jackshay();
        j["milammeter"] = x.get_milammeter();
        j["Naja"] = x.get_naja();
        j["ombrological"] = x.get_ombrological();
        j["phonasthenia"] = x.get_phonasthenia();
        j["retrievableness"] = x.get_retrievableness();
        j["snakily"] = x.get_snakily();
        j["swot"] = x.get_swot();
        j["tartlet"] = x.get_tartlet();
        j["thiofuran"] = x.get_thiofuran();
        j["tracheophone"] = x.get_tracheophone();
        j["tuglike"] = x.get_tuglike();
        j["unscratchingly"] = x.get_unscratchingly();
    }

    inline void from_json(json const & j, AnsarieClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_accension(get_untyped(j, "accension"));
        x.set_alida(get_untyped(j, "Alida"));
        x.set_asteria(get_untyped(j, "asteria"));
        x.set_beriberic(get_untyped(j, "beriberic"));
        x.set_edgebone(get_untyped(j, "edgebone"));
        x.set_gastrodialysis(get_untyped(j, "gastrodialysis"));
        x.set_geographic(get_untyped(j, "geographic"));
        x.set_ictonyx(get_untyped(j, "Ictonyx"));
        x.set_metrocele(get_untyped(j, "metrocele"));
        x.set_misgraft(get_untyped(j, "misgraft"));
        x.set_monteith(get_untyped(j, "monteith"));
        x.set_notcher(get_untyped(j, "notcher"));
        x.set_prorestriction(get_untyped(j, "prorestriction"));
        x.set_ramist(get_untyped(j, "Ramist"));
        x.set_throatlet(get_untyped(j, "throatlet"));
        x.set_unfair(get_untyped(j, "unfair"));
        x.set_unsynonymous(get_untyped(j, "unsynonymous"));
        x.set_water(get_untyped(j, "water"));
        x.set_zestfully(get_untyped(j, "zestfully"));
        x.set_zincic(get_untyped(j, "zincic"));
    }

    inline void to_json(json & j, AnsarieClass const & x) {
        j = json::object();
        j["accension"] = x.get_accension();
        j["Alida"] = x.get_alida();
        j["asteria"] = x.get_asteria();
        j["beriberic"] = x.get_beriberic();
        j["edgebone"] = x.get_edgebone();
        j["gastrodialysis"] = x.get_gastrodialysis();
        j["geographic"] = x.get_geographic();
        j["Ictonyx"] = x.get_ictonyx();
        j["metrocele"] = x.get_metrocele();
        j["misgraft"] = x.get_misgraft();
        j["monteith"] = x.get_monteith();
        j["notcher"] = x.get_notcher();
        j["prorestriction"] = x.get_prorestriction();
        j["Ramist"] = x.get_ramist();
        j["throatlet"] = x.get_throatlet();
        j["unfair"] = x.get_unfair();
        j["unsynonymous"] = x.get_unsynonymous();
        j["water"] = x.get_water();
        j["zestfully"] = x.get_zestfully();
        j["zincic"] = x.get_zincic();
    }

    inline void from_json(json const & j, ChytridiaceaeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_batidaceae(get_untyped(j, "Batidaceae"));
        x.set_brechites(get_untyped(j, "Brechites"));
        x.set_codespairer(get_untyped(j, "codespairer"));
        x.set_emery(get_untyped(j, "Emery"));
        x.set_enervative(get_untyped(j, "enervative"));
        x.set_excriminate(get_untyped(j, "excriminate"));
        x.set_goshenite(get_untyped(j, "goshenite"));
        x.set_grime(get_untyped(j, "grime"));
        x.set_gritten(get_untyped(j, "gritten"));
        x.set_hectorly(get_untyped(j, "hectorly"));
        x.set_intermediation(get_untyped(j, "intermediation"));
        x.set_meeterly(get_untyped(j, "meeterly"));
        x.set_narraganset(get_untyped(j, "Narraganset"));
        x.set_onymatic(get_untyped(j, "onymatic"));
        x.set_paddlecock(get_untyped(j, "paddlecock"));
        x.set_thana(get_untyped(j, "thana"));
        x.set_thornily(get_untyped(j, "thornily"));
        x.set_uckia(get_untyped(j, "uckia"));
        x.set_unmettle(get_untyped(j, "unmettle"));
        x.set_vorticellid(get_untyped(j, "vorticellid"));
    }

    inline void to_json(json & j, ChytridiaceaeClass const & x) {
        j = json::object();
        j["Batidaceae"] = x.get_batidaceae();
        j["Brechites"] = x.get_brechites();
        j["codespairer"] = x.get_codespairer();
        j["Emery"] = x.get_emery();
        j["enervative"] = x.get_enervative();
        j["excriminate"] = x.get_excriminate();
        j["goshenite"] = x.get_goshenite();
        j["grime"] = x.get_grime();
        j["gritten"] = x.get_gritten();
        j["hectorly"] = x.get_hectorly();
        j["intermediation"] = x.get_intermediation();
        j["meeterly"] = x.get_meeterly();
        j["Narraganset"] = x.get_narraganset();
        j["onymatic"] = x.get_onymatic();
        j["paddlecock"] = x.get_paddlecock();
        j["thana"] = x.get_thana();
        j["thornily"] = x.get_thornily();
        j["uckia"] = x.get_uckia();
        j["unmettle"] = x.get_unmettle();
        j["vorticellid"] = x.get_vorticellid();
    }

    inline void from_json(json const & j, DiscordiaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Altaic") != j.end() && !j.at("Altaic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Altaic") != j.end() && j.at("Altaic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_altaic(get_stack_optional<int64_t>(j, "Altaic"));
        if (j.find("amoristic") != j.end() && !j.at("amoristic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("amoristic") != j.end() && j.at("amoristic").is_null()) throw std::runtime_error("Unexpected null");
        x.set_amoristic(get_stack_optional<int64_t>(j, "amoristic"));
        if (j.find("blennophthalmia") != j.end() && !j.at("blennophthalmia").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("blennophthalmia") != j.end() && j.at("blennophthalmia").is_null()) throw std::runtime_error("Unexpected null");
        x.set_blennophthalmia(get_stack_optional<int64_t>(j, "blennophthalmia"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("disciplinability") != j.end() && !j.at("disciplinability").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("disciplinability") != j.end() && j.at("disciplinability").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disciplinability(get_stack_optional<int64_t>(j, "disciplinability"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("goofer") != j.end() && !j.at("goofer").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("goofer") != j.end() && j.at("goofer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_goofer(get_stack_optional<int64_t>(j, "goofer"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("laryngograph") != j.end() && !j.at("laryngograph").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("laryngograph") != j.end() && j.at("laryngograph").is_null()) throw std::runtime_error("Unexpected null");
        x.set_laryngograph(get_stack_optional<int64_t>(j, "laryngograph"));
        if (j.find("leucitis") != j.end() && !j.at("leucitis").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("leucitis") != j.end() && j.at("leucitis").is_null()) throw std::runtime_error("Unexpected null");
        x.set_leucitis(get_stack_optional<int64_t>(j, "leucitis"));
        if (j.find("lymphocyst") != j.end() && !j.at("lymphocyst").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lymphocyst") != j.end() && j.at("lymphocyst").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lymphocyst(get_stack_optional<int64_t>(j, "lymphocyst"));
        if (j.find("microcosmology") != j.end() && !j.at("microcosmology").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("microcosmology") != j.end() && j.at("microcosmology").is_null()) throw std::runtime_error("Unexpected null");
        x.set_microcosmology(get_stack_optional<int64_t>(j, "microcosmology"));
        if (j.find("nauseation") != j.end() && !j.at("nauseation").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("nauseation") != j.end() && j.at("nauseation").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nauseation(get_stack_optional<int64_t>(j, "nauseation"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("Patarin") != j.end() && !j.at("Patarin").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Patarin") != j.end() && j.at("Patarin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_patarin(get_stack_optional<int64_t>(j, "Patarin"));
        if (j.find("preliberal") != j.end() && !j.at("preliberal").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("preliberal") != j.end() && j.at("preliberal").is_null()) throw std::runtime_error("Unexpected null");
        x.set_preliberal(get_stack_optional<int64_t>(j, "preliberal"));
        if (j.find("prettifier") != j.end() && !j.at("prettifier").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("prettifier") != j.end() && j.at("prettifier").is_null()) throw std::runtime_error("Unexpected null");
        x.set_prettifier(get_stack_optional<int64_t>(j, "prettifier"));
        if (j.find("rangework") != j.end() && !j.at("rangework").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("rangework") != j.end() && j.at("rangework").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rangework(get_stack_optional<int64_t>(j, "rangework"));
        if (j.find("redient") != j.end() && !j.at("redient").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("redient") != j.end() && j.at("redient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_redient(get_stack_optional<int64_t>(j, "redient"));
        if (j.find("subfusiform") != j.end() && !j.at("subfusiform").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("subfusiform") != j.end() && j.at("subfusiform").is_null()) throw std::runtime_error("Unexpected null");
        x.set_subfusiform(get_stack_optional<int64_t>(j, "subfusiform"));
        if (j.find("suicidical") != j.end() && !j.at("suicidical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("suicidical") != j.end() && j.at("suicidical").is_null()) throw std::runtime_error("Unexpected null");
        x.set_suicidical(get_stack_optional<int64_t>(j, "suicidical"));
        if (j.find("swow") != j.end() && !j.at("swow").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("swow") != j.end() && j.at("swow").is_null()) throw std::runtime_error("Unexpected null");
        x.set_swow(get_stack_optional<int64_t>(j, "swow"));
        if (j.find("wastrel") != j.end() && !j.at("wastrel").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("wastrel") != j.end() && j.at("wastrel").is_null()) throw std::runtime_error("Unexpected null");
        x.set_wastrel(get_stack_optional<int64_t>(j, "wastrel"));
        if (j.find("wingle") != j.end() && !j.at("wingle").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("wingle") != j.end() && j.at("wingle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_wingle(get_stack_optional<int64_t>(j, "wingle"));
    }

    inline void to_json(json & j, DiscordiaClass const & x) {
        j = json::object();
        j["Altaic"] = x.get_altaic();
        j["amoristic"] = x.get_amoristic();
        j["blennophthalmia"] = x.get_blennophthalmia();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["disciplinability"] = x.get_disciplinability();
        j["disdiapason"] = x.get_disdiapason();
        j["goofer"] = x.get_goofer();
        j["homocerc"] = x.get_homocerc();
        j["laryngograph"] = x.get_laryngograph();
        j["leucitis"] = x.get_leucitis();
        j["lymphocyst"] = x.get_lymphocyst();
        j["microcosmology"] = x.get_microcosmology();
        j["nauseation"] = x.get_nauseation();
        j["nonbookish"] = x.get_nonbookish();
        j["Patarin"] = x.get_patarin();
        j["preliberal"] = x.get_preliberal();
        j["prettifier"] = x.get_prettifier();
        j["rangework"] = x.get_rangework();
        j["redient"] = x.get_redient();
        j["subfusiform"] = x.get_subfusiform();
        j["suicidical"] = x.get_suicidical();
        j["swow"] = x.get_swow();
        j["wastrel"] = x.get_wastrel();
        j["wingle"] = x.get_wingle();
    }

    inline void from_json(json const & j, GryphosaurusClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_amissibility(get_untyped(j, "amissibility"));
        x.set_burushaski(get_untyped(j, "Burushaski"));
        x.set_citronin(get_untyped(j, "citronin"));
        x.set_coplaintiff(get_untyped(j, "coplaintiff"));
        x.set_disquisitionary(get_untyped(j, "disquisitionary"));
        x.set_enoplan(get_untyped(j, "enoplan"));
        x.set_faintness(get_untyped(j, "faintness"));
        x.set_hebetomy(get_untyped(j, "hebetomy"));
        x.set_islandry(get_untyped(j, "islandry"));
        x.set_lameduck(get_untyped(j, "lameduck"));
        x.set_overbattle(get_untyped(j, "overbattle"));
        x.set_overinterested(get_untyped(j, "overinterested"));
        x.set_phrenologic(get_untyped(j, "phrenologic"));
        x.set_rainband(get_untyped(j, "rainband"));
        x.set_shiningly(get_untyped(j, "shiningly"));
        x.set_stamineous(get_untyped(j, "stamineous"));
        x.set_subscapularis(get_untyped(j, "subscapularis"));
        x.set_tahami(get_untyped(j, "Tahami"));
        x.set_undaubed(get_untyped(j, "undaubed"));
        x.set_underntime(get_untyped(j, "underntime"));
    }

    inline void to_json(json & j, GryphosaurusClass const & x) {
        j = json::object();
        j["amissibility"] = x.get_amissibility();
        j["Burushaski"] = x.get_burushaski();
        j["citronin"] = x.get_citronin();
        j["coplaintiff"] = x.get_coplaintiff();
        j["disquisitionary"] = x.get_disquisitionary();
        j["enoplan"] = x.get_enoplan();
        j["faintness"] = x.get_faintness();
        j["hebetomy"] = x.get_hebetomy();
        j["islandry"] = x.get_islandry();
        j["lameduck"] = x.get_lameduck();
        j["overbattle"] = x.get_overbattle();
        j["overinterested"] = x.get_overinterested();
        j["phrenologic"] = x.get_phrenologic();
        j["rainband"] = x.get_rainband();
        j["shiningly"] = x.get_shiningly();
        j["stamineous"] = x.get_stamineous();
        j["subscapularis"] = x.get_subscapularis();
        j["Tahami"] = x.get_tahami();
        j["undaubed"] = x.get_undaubed();
        j["underntime"] = x.get_underntime();
    }

    inline void from_json(json const & j, LaviniaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("agitable") != j.end() && !j.at("agitable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("agitable") != j.end() && j.at("agitable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_agitable(get_stack_optional<int64_t>(j, "agitable"));
        if (j.find("asininity") != j.end() && !j.at("asininity").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("asininity") != j.end() && j.at("asininity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_asininity(get_stack_optional<int64_t>(j, "asininity"));
        if (j.find("benefiter") != j.end() && !j.at("benefiter").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("benefiter") != j.end() && j.at("benefiter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_benefiter(get_stack_optional<int64_t>(j, "benefiter"));
        if (j.find("bronzelike") != j.end() && !j.at("bronzelike").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("bronzelike") != j.end() && j.at("bronzelike").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bronzelike(get_stack_optional<int64_t>(j, "bronzelike"));
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_catharticalness(get_stack_optional<double>(j, "catharticalness"));
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.set_chirotherium(get_stack_optional<int64_t>(j, "Chirotherium"));
        if (j.find("cholesteatomatous") != j.end() && !j.at("cholesteatomatous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("cholesteatomatous") != j.end() && j.at("cholesteatomatous").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cholesteatomatous(get_stack_optional<int64_t>(j, "cholesteatomatous"));
        if (j.find("deprivement") != j.end() && !j.at("deprivement").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("deprivement") != j.end() && j.at("deprivement").is_null()) throw std::runtime_error("Unexpected null");
        x.set_deprivement(get_stack_optional<int64_t>(j, "deprivement"));
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.set_disdiapason(get_stack_optional<std::string>(j, "disdiapason"));
        if (j.find("flippantness") != j.end() && !j.at("flippantness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("flippantness") != j.end() && j.at("flippantness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_flippantness(get_stack_optional<int64_t>(j, "flippantness"));
        if (j.find("fogproof") != j.end() && !j.at("fogproof").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("fogproof") != j.end() && j.at("fogproof").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fogproof(get_stack_optional<int64_t>(j, "fogproof"));
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_homocerc(get_stack_optional<bool>(j, "homocerc"));
        if (j.find("merrymeeting") != j.end() && !j.at("merrymeeting").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("merrymeeting") != j.end() && j.at("merrymeeting").is_null()) throw std::runtime_error("Unexpected null");
        x.set_merrymeeting(get_stack_optional<int64_t>(j, "merrymeeting"));
        x.set_nonbookish(get_untyped(j, "nonbookish"));
        if (j.find("overcareful") != j.end() && !j.at("overcareful").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("overcareful") != j.end() && j.at("overcareful").is_null()) throw std::runtime_error("Unexpected null");
        x.set_overcareful(get_stack_optional<int64_t>(j, "overcareful"));
        if (j.find("panaris") != j.end() && !j.at("panaris").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("panaris") != j.end() && j.at("panaris").is_null()) throw std::runtime_error("Unexpected null");
        x.set_panaris(get_stack_optional<int64_t>(j, "panaris"));
        if (j.find("preacceptance") != j.end() && !j.at("preacceptance").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("preacceptance") != j.end() && j.at("preacceptance").is_null()) throw std::runtime_error("Unexpected null");
        x.set_preacceptance(get_stack_optional<int64_t>(j, "preacceptance"));
        if (j.find("quinoxaline") != j.end() && !j.at("quinoxaline").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("quinoxaline") != j.end() && j.at("quinoxaline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_quinoxaline(get_stack_optional<int64_t>(j, "quinoxaline"));
        if (j.find("sig") != j.end() && !j.at("sig").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sig") != j.end() && j.at("sig").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sig(get_stack_optional<int64_t>(j, "sig"));
        if (j.find("superconfusion") != j.end() && !j.at("superconfusion").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("superconfusion") != j.end() && j.at("superconfusion").is_null()) throw std::runtime_error("Unexpected null");
        x.set_superconfusion(get_stack_optional<int64_t>(j, "superconfusion"));
        if (j.find("Tacana") != j.end() && !j.at("Tacana").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Tacana") != j.end() && j.at("Tacana").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tacana(get_stack_optional<int64_t>(j, "Tacana"));
        if (j.find("tillotter") != j.end() && !j.at("tillotter").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tillotter") != j.end() && j.at("tillotter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tillotter(get_stack_optional<int64_t>(j, "tillotter"));
        if (j.find("tranquillize") != j.end() && !j.at("tranquillize").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tranquillize") != j.end() && j.at("tranquillize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tranquillize(get_stack_optional<int64_t>(j, "tranquillize"));
        if (j.find("unquestionable") != j.end() && !j.at("unquestionable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unquestionable") != j.end() && j.at("unquestionable").is_null()) throw std::runtime_error("Unexpected null");
        x.set_unquestionable(get_stack_optional<int64_t>(j, "unquestionable"));
        if (j.find("uproute") != j.end() && !j.at("uproute").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("uproute") != j.end() && j.at("uproute").is_null()) throw std::runtime_error("Unexpected null");
        x.set_uproute(get_stack_optional<int64_t>(j, "uproute"));
    }

    inline void to_json(json & j, LaviniaClass const & x) {
        j = json::object();
        j["agitable"] = x.get_agitable();
        j["asininity"] = x.get_asininity();
        j["benefiter"] = x.get_benefiter();
        j["bronzelike"] = x.get_bronzelike();
        j["catharticalness"] = x.get_catharticalness();
        j["Chirotherium"] = x.get_chirotherium();
        j["cholesteatomatous"] = x.get_cholesteatomatous();
        j["deprivement"] = x.get_deprivement();
        j["disdiapason"] = x.get_disdiapason();
        j["flippantness"] = x.get_flippantness();
        j["fogproof"] = x.get_fogproof();
        j["homocerc"] = x.get_homocerc();
        j["merrymeeting"] = x.get_merrymeeting();
        j["nonbookish"] = x.get_nonbookish();
        j["overcareful"] = x.get_overcareful();
        j["panaris"] = x.get_panaris();
        j["preacceptance"] = x.get_preacceptance();
        j["quinoxaline"] = x.get_quinoxaline();
        j["sig"] = x.get_sig();
        j["superconfusion"] = x.get_superconfusion();
        j["Tacana"] = x.get_tacana();
        j["tillotter"] = x.get_tillotter();
        j["tranquillize"] = x.get_tranquillize();
        j["unquestionable"] = x.get_unquestionable();
        j["uproute"] = x.get_uproute();
    }

    inline void from_json(json const & j, OskarClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_acrobates(get_untyped(j, "Acrobates"));
        x.set_beanshooter(get_untyped(j, "beanshooter"));
        x.set_bearhound(get_untyped(j, "bearhound"));
        x.set_cayuga(get_untyped(j, "Cayuga"));
        x.set_guarneri(get_untyped(j, "guarneri"));
        x.set_hypochondriacism(get_untyped(j, "hypochondriacism"));
        x.set_indication(get_untyped(j, "indication"));
        x.set_jaculative(get_untyped(j, "jaculative"));
        x.set_nagana(get_untyped(j, "nagana"));
        x.set_netherlandish(get_untyped(j, "Netherlandish"));
        x.set_noctivagous(get_untyped(j, "noctivagous"));
        x.set_nonphysiological(get_untyped(j, "nonphysiological"));
        x.set_praxis(get_untyped(j, "praxis"));
        x.set_provision(get_untyped(j, "provision"));
        x.set_subterhuman(get_untyped(j, "subterhuman"));
        x.set_sunlit(get_untyped(j, "sunlit"));
        x.set_syncraniate(get_untyped(j, "syncraniate"));
        x.set_teachment(get_untyped(j, "teachment"));
        x.set_unmutinous(get_untyped(j, "unmutinous"));
        x.set_unstoppable(get_untyped(j, "unstoppable"));
    }

    inline void to_json(json & j, OskarClass const & x) {
        j = json::object();
        j["Acrobates"] = x.get_acrobates();
        j["beanshooter"] = x.get_beanshooter();
        j["bearhound"] = x.get_bearhound();
        j["Cayuga"] = x.get_cayuga();
        j["guarneri"] = x.get_guarneri();
        j["hypochondriacism"] = x.get_hypochondriacism();
        j["indication"] = x.get_indication();
        j["jaculative"] = x.get_jaculative();
        j["nagana"] = x.get_nagana();
        j["Netherlandish"] = x.get_netherlandish();
        j["noctivagous"] = x.get_noctivagous();
        j["nonphysiological"] = x.get_nonphysiological();
        j["praxis"] = x.get_praxis();
        j["provision"] = x.get_provision();
        j["subterhuman"] = x.get_subterhuman();
        j["sunlit"] = x.get_sunlit();
        j["syncraniate"] = x.get_syncraniate();
        j["teachment"] = x.get_teachment();
        j["unmutinous"] = x.get_unmutinous();
        j["unstoppable"] = x.get_unstoppable();
    }

    inline void from_json(json const & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_abranchiata(j.at("Abranchiata").get<std::vector<Abranchiata>>());
        x.set_academe(j.at("academe").get<std::vector<Academe>>());
        x.set_acquirable(j.at("acquirable").get<std::vector<Acquirable>>());
        x.set_aerometry(j.at("aerometry").get<std::vector<Aerometry>>());
        x.set_alexin(j.at("alexin").get<std::vector<Alexin>>());
        x.set_alleviate(j.at("alleviate").get<std::vector<AlleviateElement>>());
        x.set_amaas(j.at("amaas").get<std::vector<Amaa>>());
        x.set_ambassage(j.at("ambassage").get<std::vector<Ambassage>>());
        x.set_amphithyron(j.at("amphithyron").get<std::vector<std::optional<Amphithyron>>>());
        x.set_andriana(j.at("Andriana").get<std::vector<std::optional<std::string>>>());
        x.set_ankee(j.at("ankee").get<std::vector<AnkeeElement>>());
        x.set_annihilator(j.at("annihilator").get<std::vector<std::optional<std::map<std::string, std::optional<int64_t>>>>>());
        x.set_annulose(get_untyped(j, "annulose"));
        x.set_ansarie(j.at("Ansarie").get<std::vector<AnsarieElement>>());
        x.set_aphasia(j.at("aphasia").get<std::vector<Aphasia>>());
        x.set_asprawl(j.at("asprawl").get<std::vector<Asprawl>>());
        x.set_attractive(j.at("attractive").get<std::vector<std::optional<bool>>>());
        x.set_barksome(j.at("barksome").get<std::map<std::string, int64_t>>());
        x.set_bedesman(j.at("bedesman").get<std::vector<Bedesman>>());
        x.set_belard(j.at("belard").get<std::vector<Belard>>());
        x.set_bocking(j.at("bocking").get<std::vector<Bocking>>());
        x.set_brawlingly(j.at("brawlingly").get<std::vector<Brawlingly>>());
        x.set_brookie(j.at("brookie").get<std::vector<Brookie>>());
        x.set_bumboatman(j.at("bumboatman").get<std::vector<Bumboatman>>());
        x.set_bystreet(j.at("bystreet").get<std::vector<nlohmann::json>>());
        x.set_calaverite(j.at("calaverite").get<std::vector<Calaverite>>());
        x.set_catallactic(j.at("catallactic").get<std::vector<Catallactic>>());
        x.set_cemental(j.at("cemental").get<std::vector<Cemental>>());
        x.set_chytridiaceae(j.at("Chytridiaceae").get<std::vector<ChytridiaceaeElement>>());
        x.set_discordia(j.at("Discordia").get<std::vector<DiscordiaElement>>());
        x.set_endomyces(j.at("Endomyces").get<std::vector<Endomyce>>());
        x.set_epinephelidae(j.at("Epinephelidae").get<std::vector<Epinephelidae>>());
        x.set_eupatorium(j.at("Eupatorium").get<std::vector<Eupatorium>>());
        x.set_gryphosaurus(j.at("Gryphosaurus").get<std::vector<GryphosaurusElement>>());
        x.set_koryak(j.at("Koryak").get<std::vector<Koryak>>());
        x.set_lavinia(j.at("Lavinia").get<std::vector<LaviniaElement>>());
        x.set_oskar(j.at("Oskar").get<std::vector<OskarElement>>());
        x.set_rebecca(j.at("Rebecca").get<std::vector<RebeccaElement>>());
        x.set_rhomboganoidei(j.at("Rhomboganoidei").get<std::vector<Rhomboganoidei>>());
        x.set_rigsmal(j.at("Rigsmal").get<bool>());
        x.set_ruellia(j.at("Ruellia").get<std::vector<Ruellia>>());
        x.set_school(j.at("School").get<std::vector<School>>());
        x.set_shakespearolater(j.at("Shakespearolater").get<std::vector<Shakespearolater>>());
        x.set_svan(j.at("Svan").get<std::vector<double>>());
        x.set_wayao(j.at("Wayao").get<std::map<std::string, double>>());
    }

    inline void to_json(json & j, TopLevel const & x) {
        j = json::object();
        j["Abranchiata"] = x.get_abranchiata();
        j["academe"] = x.get_academe();
        j["acquirable"] = x.get_acquirable();
        j["aerometry"] = x.get_aerometry();
        j["alexin"] = x.get_alexin();
        j["alleviate"] = x.get_alleviate();
        j["amaas"] = x.get_amaas();
        j["ambassage"] = x.get_ambassage();
        j["amphithyron"] = x.get_amphithyron();
        j["Andriana"] = x.get_andriana();
        j["ankee"] = x.get_ankee();
        j["annihilator"] = x.get_annihilator();
        j["annulose"] = x.get_annulose();
        j["Ansarie"] = x.get_ansarie();
        j["aphasia"] = x.get_aphasia();
        j["asprawl"] = x.get_asprawl();
        j["attractive"] = x.get_attractive();
        j["barksome"] = x.get_barksome();
        j["bedesman"] = x.get_bedesman();
        j["belard"] = x.get_belard();
        j["bocking"] = x.get_bocking();
        j["brawlingly"] = x.get_brawlingly();
        j["brookie"] = x.get_brookie();
        j["bumboatman"] = x.get_bumboatman();
        j["bystreet"] = x.get_bystreet();
        j["calaverite"] = x.get_calaverite();
        j["catallactic"] = x.get_catallactic();
        j["cemental"] = x.get_cemental();
        j["Chytridiaceae"] = x.get_chytridiaceae();
        j["Discordia"] = x.get_discordia();
        j["Endomyces"] = x.get_endomyces();
        j["Epinephelidae"] = x.get_epinephelidae();
        j["Eupatorium"] = x.get_eupatorium();
        j["Gryphosaurus"] = x.get_gryphosaurus();
        j["Koryak"] = x.get_koryak();
        j["Lavinia"] = x.get_lavinia();
        j["Oskar"] = x.get_oskar();
        j["Rebecca"] = x.get_rebecca();
        j["Rhomboganoidei"] = x.get_rhomboganoidei();
        j["Rigsmal"] = x.get_rigsmal();
        j["Ruellia"] = x.get_ruellia();
        j["School"] = x.get_school();
        j["Shakespearolater"] = x.get_shakespearolater();
        j["Svan"] = x.get_svan();
        j["Wayao"] = x.get_wayao();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t>>::from_json(json const & j, std::variant<std::vector<int64_t>, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t>>::to_json(json & j, std::variant<std::vector<int64_t>, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, int64_t>>(x);
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass>>::from_json(json const & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::AlleviateClass>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass>>::to_json(json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<quicktype::AlleviateClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, int64_t>>::from_json(json const & j, std::variant<bool, quicktype::Rebecca, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, int64_t>>::to_json(json & j, std::variant<bool, quicktype::Rebecca, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::Rebecca>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::string>>::from_json(json const & j, std::variant<std::vector<json>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::string>>::to_json(json & j, std::variant<std::vector<json>, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::AnkeeClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::AnkeeClass>(x);
                break;
            case 2:
                j = std::get<int64_t>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnsarieClass>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::AnsarieClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::AnsarieClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnsarieClass>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::AnsarieClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::AnsarieClass>(x);
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

    inline void adl_serializer<std::variant<bool, double, std::string>>::from_json(json const & j, std::variant<bool, double, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double, std::string>>::to_json(json & j, std::variant<bool, double, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, double>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, double>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, double> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::Rebecca>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>>>::from_json(json const & j, std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, std::optional<int64_t>>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::Rebecca> & x) {
        if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::Rebecca>(x);
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<std::map<std::string, int64_t>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>>>::from_json(json const & j, std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>>>::to_json(json & j, std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
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

    inline void adl_serializer<std::variant<bool, quicktype::ChytridiaceaeClass>>::from_json(json const & j, std::variant<bool, quicktype::ChytridiaceaeClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::ChytridiaceaeClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::ChytridiaceaeClass>>::to_json(json & j, std::variant<bool, quicktype::ChytridiaceaeClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::ChytridiaceaeClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::DiscordiaClass>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::DiscordiaClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::DiscordiaClass>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::DiscordiaClass>(x);
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

    inline void adl_serializer<std::variant<bool, int64_t, std::string>>::from_json(json const & j, std::variant<bool, int64_t, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, int64_t, std::string>>::to_json(json & j, std::variant<bool, int64_t, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::GryphosaurusClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::GryphosaurusClass>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::map<std::string, std::optional<int64_t>>, std::string>>::from_json(json const & j, std::variant<std::map<std::string, std::optional<int64_t>>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::map<std::string, std::optional<int64_t>>, std::string>>::to_json(json & j, std::variant<std::map<std::string, std::optional<int64_t>>, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::map<std::string, std::optional<int64_t>>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::LaviniaClass, std::string>>::from_json(json const & j, std::variant<quicktype::LaviniaClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::LaviniaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LaviniaClass, std::string>>::to_json(json & j, std::variant<quicktype::LaviniaClass, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::LaviniaClass>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::OskarClass>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::OskarClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::OskarClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::OskarClass>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::OskarClass> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::OskarClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::Rebecca, int64_t, std::string>>::from_json(json const & j, std::variant<quicktype::Rebecca, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Rebecca, int64_t, std::string>>::to_json(json & j, std::variant<quicktype::Rebecca, int64_t, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Rebecca>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string>>::from_json(json const & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string>>::to_json(json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
                break;
            case 1:
                j = std::get<quicktype::Rebecca>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, std::string>>::from_json(json const & j, std::variant<bool, quicktype::Rebecca, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, std::string>>::to_json(json & j, std::variant<bool, quicktype::Rebecca, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::Rebecca>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::string>>::from_json(json const & j, std::variant<std::vector<int64_t>, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::string>>::to_json(json & j, std::variant<std::vector<int64_t>, double, std::string> const & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<int64_t>>(x);
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
}
