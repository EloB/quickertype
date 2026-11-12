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

    using Abranchiata = std::optional<std::variant<std::vector<int64_t>, int64_t>>;

    using Academe = std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>;

    using Acquirable = std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>;

    using Aerometry = std::variant<bool, double>;

    using Alexin = std::variant<std::vector<int64_t>, bool>;

    struct AlleviateClass {
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
    };

    using AlleviateElement = std::variant<std::vector<std::optional<int64_t>>, AlleviateClass>;

    struct Rebecca {
        double catharticalness;
        int64_t chirotherium;
        std::string disdiapason;
        bool homocerc;
        nlohmann::json nonbookish;
    };

    using Amaa = std::variant<bool, Rebecca, int64_t>;

    using Ambassage = std::variant<std::vector<nlohmann::json>, std::string>;

    struct Amphithyron {
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
    };

    struct AnkeeClass {
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
    };

    using AnkeeElement = std::variant<std::vector<int64_t>, AnkeeClass, int64_t>;

    struct AnsarieClass {
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

    struct ChytridiaceaeClass {
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
    };

    using ChytridiaceaeElement = std::optional<std::variant<bool, ChytridiaceaeClass>>;

    struct DiscordiaClass {
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
    };

    using DiscordiaElement = std::variant<std::vector<int64_t>, DiscordiaClass>;

    using Endomyce = std::variant<int64_t, std::string>;

    using Epinephelidae = std::variant<bool, int64_t, std::string>;

    using Eupatorium = std::variant<std::vector<nlohmann::json>, std::map<std::string, int64_t>>;

    struct GryphosaurusClass {
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
    };

    using GryphosaurusElement = std::variant<std::vector<int64_t>, GryphosaurusClass, std::string>;

    using Koryak = std::variant<std::map<std::string, std::optional<int64_t>>, std::string>;

    struct LaviniaClass {
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
    };

    using LaviniaElement = std::variant<LaviniaClass, std::string>;

    struct OskarClass {
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
    };

    using OskarElement = std::variant<std::vector<int64_t>, OskarClass>;

    using RebeccaElement = std::variant<Rebecca, int64_t, std::string>;

    using Rhomboganoidei = std::variant<std::vector<int64_t>, Rebecca, std::string>;

    using Ruellia = std::variant<bool, Rebecca, std::string>;

    using School = std::optional<std::variant<int64_t, std::map<std::string, int64_t>>>;

    using Shakespearolater = std::variant<std::vector<int64_t>, double, std::string>;

    struct TopLevel {
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
    };
}

namespace quicktype {
void from_json(const json & j, AlleviateClass & x);
void to_json(json & j, const AlleviateClass & x);

void from_json(const json & j, Rebecca & x);
void to_json(json & j, const Rebecca & x);

void from_json(const json & j, Amphithyron & x);
void to_json(json & j, const Amphithyron & x);

void from_json(const json & j, AnkeeClass & x);
void to_json(json & j, const AnkeeClass & x);

void from_json(const json & j, AnsarieClass & x);
void to_json(json & j, const AnsarieClass & x);

void from_json(const json & j, ChytridiaceaeClass & x);
void to_json(json & j, const ChytridiaceaeClass & x);

void from_json(const json & j, DiscordiaClass & x);
void to_json(json & j, const DiscordiaClass & x);

void from_json(const json & j, GryphosaurusClass & x);
void to_json(json & j, const GryphosaurusClass & x);

void from_json(const json & j, LaviniaClass & x);
void to_json(json & j, const LaviniaClass & x);

void from_json(const json & j, OskarClass & x);
void to_json(json & j, const OskarClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<int64_t>, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(const json & j, std::variant<bool, double> & x);
    static void to_json(json & j, const std::variant<bool, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass>> {
    static void from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> & x);
    static void to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::Rebecca, int64_t>> {
    static void from_json(const json & j, std::variant<bool, quicktype::Rebecca, int64_t> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::Rebecca, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnsarieClass>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::AnsarieClass> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::AnsarieClass> & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(const json & j, std::variant<double, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, double, std::string>> {
    static void from_json(const json & j, std::variant<bool, double, std::string> & x);
    static void to_json(json & j, const std::variant<bool, double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, double>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, double> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::Rebecca, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(const json & j, std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::Rebecca> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::ChytridiaceaeClass>> {
    static void from_json(const json & j, std::variant<bool, quicktype::ChytridiaceaeClass> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::ChytridiaceaeClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::DiscordiaClass>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::string>> {
    static void from_json(const json & j, std::variant<int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<bool, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<bool, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<json>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::map<std::string, std::optional<int64_t>>, std::string>> {
    static void from_json(const json & j, std::variant<std::map<std::string, std::optional<int64_t>>, std::string> & x);
    static void to_json(json & j, const std::variant<std::map<std::string, std::optional<int64_t>>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LaviniaClass, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::LaviniaClass, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::LaviniaClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::OskarClass>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::OskarClass> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::OskarClass> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::Rebecca, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::Rebecca, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::Rebecca, int64_t, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::Rebecca, std::string>> {
    static void from_json(const json & j, std::variant<bool, quicktype::Rebecca, std::string> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::Rebecca, std::string> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<int64_t, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, double, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, double, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, AlleviateClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.apriori = get_untyped(j, "apriori");
        x.beggarer = get_untyped(j, "beggarer");
        x.brokenheartedly = get_untyped(j, "brokenheartedly");
        x.debilitation = get_untyped(j, "debilitation");
        x.frike = get_untyped(j, "frike");
        x.gastrolith = get_untyped(j, "gastrolith");
        x.hulsean = get_untyped(j, "Hulsean");
        x.orthocentric = get_untyped(j, "orthocentric");
        x.petaly = get_untyped(j, "petaly");
        x.probudgeting = get_untyped(j, "probudgeting");
        x.reacquire = get_untyped(j, "reacquire");
        x.scow = get_untyped(j, "scow");
        x.shutoff = get_untyped(j, "shutoff");
        x.subcontiguous = get_untyped(j, "subcontiguous");
        x.suffumigate = get_untyped(j, "suffumigate");
        x.transformable = get_untyped(j, "transformable");
        x.uncoroneted = get_untyped(j, "uncoroneted");
        x.unparking = get_untyped(j, "unparking");
        x.unvarnishedness = get_untyped(j, "unvarnishedness");
        x.wherewithal = get_untyped(j, "wherewithal");
    }

    inline void to_json(json & j, const AlleviateClass & x) {
        j = json::object();
        j["apriori"] = x.apriori;
        j["beggarer"] = x.beggarer;
        j["brokenheartedly"] = x.brokenheartedly;
        j["debilitation"] = x.debilitation;
        j["frike"] = x.frike;
        j["gastrolith"] = x.gastrolith;
        j["Hulsean"] = x.hulsean;
        j["orthocentric"] = x.orthocentric;
        j["petaly"] = x.petaly;
        j["probudgeting"] = x.probudgeting;
        j["reacquire"] = x.reacquire;
        j["scow"] = x.scow;
        j["shutoff"] = x.shutoff;
        j["subcontiguous"] = x.subcontiguous;
        j["suffumigate"] = x.suffumigate;
        j["transformable"] = x.transformable;
        j["uncoroneted"] = x.uncoroneted;
        j["unparking"] = x.unparking;
        j["unvarnishedness"] = x.unvarnishedness;
        j["wherewithal"] = x.wherewithal;
    }

    inline void from_json(const json & j, Rebecca& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.catharticalness = j.at("catharticalness").get<double>();
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.chirotherium = j.at("Chirotherium").get<int64_t>();
        x.disdiapason = j.at("disdiapason").get<std::string>();
        x.homocerc = j.at("homocerc").get<bool>();
        x.nonbookish = get_untyped(j, "nonbookish");
    }

    inline void to_json(json & j, const Rebecca & x) {
        j = json::object();
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["homocerc"] = x.homocerc;
        j["nonbookish"] = x.nonbookish;
    }

    inline void from_json(const json & j, Amphithyron& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("akroasis") != j.end() && !j.at("akroasis").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("akroasis") != j.end() && j.at("akroasis").is_null()) throw std::runtime_error("Unexpected null");
        x.akroasis = get_stack_optional<int64_t>(j, "akroasis");
        if (j.find("antiphonical") != j.end() && !j.at("antiphonical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("antiphonical") != j.end() && j.at("antiphonical").is_null()) throw std::runtime_error("Unexpected null");
        x.antiphonical = get_stack_optional<int64_t>(j, "antiphonical");
        if (j.find("basebred") != j.end() && !j.at("basebred").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("basebred") != j.end() && j.at("basebred").is_null()) throw std::runtime_error("Unexpected null");
        x.basebred = get_stack_optional<int64_t>(j, "basebred");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("conductometric") != j.end() && !j.at("conductometric").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("conductometric") != j.end() && j.at("conductometric").is_null()) throw std::runtime_error("Unexpected null");
        x.conductometric = get_stack_optional<int64_t>(j, "conductometric");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("ensilation") != j.end() && !j.at("ensilation").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ensilation") != j.end() && j.at("ensilation").is_null()) throw std::runtime_error("Unexpected null");
        x.ensilation = get_stack_optional<int64_t>(j, "ensilation");
        if (j.find("eyebolt") != j.end() && !j.at("eyebolt").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("eyebolt") != j.end() && j.at("eyebolt").is_null()) throw std::runtime_error("Unexpected null");
        x.eyebolt = get_stack_optional<int64_t>(j, "eyebolt");
        if (j.find("fistulated") != j.end() && !j.at("fistulated").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("fistulated") != j.end() && j.at("fistulated").is_null()) throw std::runtime_error("Unexpected null");
        x.fistulated = get_stack_optional<int64_t>(j, "fistulated");
        if (j.find("heteropod") != j.end() && !j.at("heteropod").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("heteropod") != j.end() && j.at("heteropod").is_null()) throw std::runtime_error("Unexpected null");
        x.heteropod = get_stack_optional<int64_t>(j, "heteropod");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("Juniperus") != j.end() && !j.at("Juniperus").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Juniperus") != j.end() && j.at("Juniperus").is_null()) throw std::runtime_error("Unexpected null");
        x.juniperus = get_stack_optional<int64_t>(j, "Juniperus");
        if (j.find("labyrinthically") != j.end() && !j.at("labyrinthically").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("labyrinthically") != j.end() && j.at("labyrinthically").is_null()) throw std::runtime_error("Unexpected null");
        x.labyrinthically = get_stack_optional<int64_t>(j, "labyrinthically");
        if (j.find("martyrization") != j.end() && !j.at("martyrization").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("martyrization") != j.end() && j.at("martyrization").is_null()) throw std::runtime_error("Unexpected null");
        x.martyrization = get_stack_optional<int64_t>(j, "martyrization");
        if (j.find("mispolicy") != j.end() && !j.at("mispolicy").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mispolicy") != j.end() && j.at("mispolicy").is_null()) throw std::runtime_error("Unexpected null");
        x.mispolicy = get_stack_optional<int64_t>(j, "mispolicy");
        if (j.find("multipara") != j.end() && !j.at("multipara").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("multipara") != j.end() && j.at("multipara").is_null()) throw std::runtime_error("Unexpected null");
        x.multipara = get_stack_optional<int64_t>(j, "multipara");
        if (j.find("Nazirite") != j.end() && !j.at("Nazirite").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Nazirite") != j.end() && j.at("Nazirite").is_null()) throw std::runtime_error("Unexpected null");
        x.nazirite = get_stack_optional<int64_t>(j, "Nazirite");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("possessorial") != j.end() && !j.at("possessorial").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("possessorial") != j.end() && j.at("possessorial").is_null()) throw std::runtime_error("Unexpected null");
        x.possessorial = get_stack_optional<int64_t>(j, "possessorial");
        if (j.find("shamed") != j.end() && !j.at("shamed").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("shamed") != j.end() && j.at("shamed").is_null()) throw std::runtime_error("Unexpected null");
        x.shamed = get_stack_optional<int64_t>(j, "shamed");
        if (j.find("shelfworn") != j.end() && !j.at("shelfworn").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("shelfworn") != j.end() && j.at("shelfworn").is_null()) throw std::runtime_error("Unexpected null");
        x.shelfworn = get_stack_optional<int64_t>(j, "shelfworn");
        if (j.find("stagnum") != j.end() && !j.at("stagnum").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("stagnum") != j.end() && j.at("stagnum").is_null()) throw std::runtime_error("Unexpected null");
        x.stagnum = get_stack_optional<int64_t>(j, "stagnum");
        if (j.find("Those") != j.end() && !j.at("Those").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Those") != j.end() && j.at("Those").is_null()) throw std::runtime_error("Unexpected null");
        x.those = get_stack_optional<int64_t>(j, "Those");
        if (j.find("undecimal") != j.end() && !j.at("undecimal").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("undecimal") != j.end() && j.at("undecimal").is_null()) throw std::runtime_error("Unexpected null");
        x.undecimal = get_stack_optional<int64_t>(j, "undecimal");
    }

    inline void to_json(json & j, const Amphithyron & x) {
        j = json::object();
        j["akroasis"] = x.akroasis;
        j["antiphonical"] = x.antiphonical;
        j["basebred"] = x.basebred;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["conductometric"] = x.conductometric;
        j["disdiapason"] = x.disdiapason;
        j["ensilation"] = x.ensilation;
        j["eyebolt"] = x.eyebolt;
        j["fistulated"] = x.fistulated;
        j["heteropod"] = x.heteropod;
        j["homocerc"] = x.homocerc;
        j["Juniperus"] = x.juniperus;
        j["labyrinthically"] = x.labyrinthically;
        j["martyrization"] = x.martyrization;
        j["mispolicy"] = x.mispolicy;
        j["multipara"] = x.multipara;
        j["Nazirite"] = x.nazirite;
        j["nonbookish"] = x.nonbookish;
        j["possessorial"] = x.possessorial;
        j["shamed"] = x.shamed;
        j["shelfworn"] = x.shelfworn;
        j["stagnum"] = x.stagnum;
        j["Those"] = x.those;
        j["undecimal"] = x.undecimal;
    }

    inline void from_json(const json & j, AnkeeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.anomoean = get_untyped(j, "Anomoean");
        x.barleyhood = get_untyped(j, "barleyhood");
        x.befriender = get_untyped(j, "befriender");
        x.brutishness = get_untyped(j, "brutishness");
        x.cephalalgy = get_untyped(j, "cephalalgy");
        x.cirurgian = get_untyped(j, "cirurgian");
        x.conventionally = get_untyped(j, "conventionally");
        x.jackshay = get_untyped(j, "jackshay");
        x.milammeter = get_untyped(j, "milammeter");
        x.naja = get_untyped(j, "Naja");
        x.ombrological = get_untyped(j, "ombrological");
        x.phonasthenia = get_untyped(j, "phonasthenia");
        x.retrievableness = get_untyped(j, "retrievableness");
        x.snakily = get_untyped(j, "snakily");
        x.swot = get_untyped(j, "swot");
        x.tartlet = get_untyped(j, "tartlet");
        x.thiofuran = get_untyped(j, "thiofuran");
        x.tracheophone = get_untyped(j, "tracheophone");
        x.tuglike = get_untyped(j, "tuglike");
        x.unscratchingly = get_untyped(j, "unscratchingly");
    }

    inline void to_json(json & j, const AnkeeClass & x) {
        j = json::object();
        j["Anomoean"] = x.anomoean;
        j["barleyhood"] = x.barleyhood;
        j["befriender"] = x.befriender;
        j["brutishness"] = x.brutishness;
        j["cephalalgy"] = x.cephalalgy;
        j["cirurgian"] = x.cirurgian;
        j["conventionally"] = x.conventionally;
        j["jackshay"] = x.jackshay;
        j["milammeter"] = x.milammeter;
        j["Naja"] = x.naja;
        j["ombrological"] = x.ombrological;
        j["phonasthenia"] = x.phonasthenia;
        j["retrievableness"] = x.retrievableness;
        j["snakily"] = x.snakily;
        j["swot"] = x.swot;
        j["tartlet"] = x.tartlet;
        j["thiofuran"] = x.thiofuran;
        j["tracheophone"] = x.tracheophone;
        j["tuglike"] = x.tuglike;
        j["unscratchingly"] = x.unscratchingly;
    }

    inline void from_json(const json & j, AnsarieClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.accension = get_untyped(j, "accension");
        x.alida = get_untyped(j, "Alida");
        x.asteria = get_untyped(j, "asteria");
        x.beriberic = get_untyped(j, "beriberic");
        x.edgebone = get_untyped(j, "edgebone");
        x.gastrodialysis = get_untyped(j, "gastrodialysis");
        x.geographic = get_untyped(j, "geographic");
        x.ictonyx = get_untyped(j, "Ictonyx");
        x.metrocele = get_untyped(j, "metrocele");
        x.misgraft = get_untyped(j, "misgraft");
        x.monteith = get_untyped(j, "monteith");
        x.notcher = get_untyped(j, "notcher");
        x.prorestriction = get_untyped(j, "prorestriction");
        x.ramist = get_untyped(j, "Ramist");
        x.throatlet = get_untyped(j, "throatlet");
        x.unfair = get_untyped(j, "unfair");
        x.unsynonymous = get_untyped(j, "unsynonymous");
        x.water = get_untyped(j, "water");
        x.zestfully = get_untyped(j, "zestfully");
        x.zincic = get_untyped(j, "zincic");
    }

    inline void to_json(json & j, const AnsarieClass & x) {
        j = json::object();
        j["accension"] = x.accension;
        j["Alida"] = x.alida;
        j["asteria"] = x.asteria;
        j["beriberic"] = x.beriberic;
        j["edgebone"] = x.edgebone;
        j["gastrodialysis"] = x.gastrodialysis;
        j["geographic"] = x.geographic;
        j["Ictonyx"] = x.ictonyx;
        j["metrocele"] = x.metrocele;
        j["misgraft"] = x.misgraft;
        j["monteith"] = x.monteith;
        j["notcher"] = x.notcher;
        j["prorestriction"] = x.prorestriction;
        j["Ramist"] = x.ramist;
        j["throatlet"] = x.throatlet;
        j["unfair"] = x.unfair;
        j["unsynonymous"] = x.unsynonymous;
        j["water"] = x.water;
        j["zestfully"] = x.zestfully;
        j["zincic"] = x.zincic;
    }

    inline void from_json(const json & j, ChytridiaceaeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.batidaceae = get_untyped(j, "Batidaceae");
        x.brechites = get_untyped(j, "Brechites");
        x.codespairer = get_untyped(j, "codespairer");
        x.emery = get_untyped(j, "Emery");
        x.enervative = get_untyped(j, "enervative");
        x.excriminate = get_untyped(j, "excriminate");
        x.goshenite = get_untyped(j, "goshenite");
        x.grime = get_untyped(j, "grime");
        x.gritten = get_untyped(j, "gritten");
        x.hectorly = get_untyped(j, "hectorly");
        x.intermediation = get_untyped(j, "intermediation");
        x.meeterly = get_untyped(j, "meeterly");
        x.narraganset = get_untyped(j, "Narraganset");
        x.onymatic = get_untyped(j, "onymatic");
        x.paddlecock = get_untyped(j, "paddlecock");
        x.thana = get_untyped(j, "thana");
        x.thornily = get_untyped(j, "thornily");
        x.uckia = get_untyped(j, "uckia");
        x.unmettle = get_untyped(j, "unmettle");
        x.vorticellid = get_untyped(j, "vorticellid");
    }

    inline void to_json(json & j, const ChytridiaceaeClass & x) {
        j = json::object();
        j["Batidaceae"] = x.batidaceae;
        j["Brechites"] = x.brechites;
        j["codespairer"] = x.codespairer;
        j["Emery"] = x.emery;
        j["enervative"] = x.enervative;
        j["excriminate"] = x.excriminate;
        j["goshenite"] = x.goshenite;
        j["grime"] = x.grime;
        j["gritten"] = x.gritten;
        j["hectorly"] = x.hectorly;
        j["intermediation"] = x.intermediation;
        j["meeterly"] = x.meeterly;
        j["Narraganset"] = x.narraganset;
        j["onymatic"] = x.onymatic;
        j["paddlecock"] = x.paddlecock;
        j["thana"] = x.thana;
        j["thornily"] = x.thornily;
        j["uckia"] = x.uckia;
        j["unmettle"] = x.unmettle;
        j["vorticellid"] = x.vorticellid;
    }

    inline void from_json(const json & j, DiscordiaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Altaic") != j.end() && !j.at("Altaic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Altaic") != j.end() && j.at("Altaic").is_null()) throw std::runtime_error("Unexpected null");
        x.altaic = get_stack_optional<int64_t>(j, "Altaic");
        if (j.find("amoristic") != j.end() && !j.at("amoristic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("amoristic") != j.end() && j.at("amoristic").is_null()) throw std::runtime_error("Unexpected null");
        x.amoristic = get_stack_optional<int64_t>(j, "amoristic");
        if (j.find("blennophthalmia") != j.end() && !j.at("blennophthalmia").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("blennophthalmia") != j.end() && j.at("blennophthalmia").is_null()) throw std::runtime_error("Unexpected null");
        x.blennophthalmia = get_stack_optional<int64_t>(j, "blennophthalmia");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("disciplinability") != j.end() && !j.at("disciplinability").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("disciplinability") != j.end() && j.at("disciplinability").is_null()) throw std::runtime_error("Unexpected null");
        x.disciplinability = get_stack_optional<int64_t>(j, "disciplinability");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("goofer") != j.end() && !j.at("goofer").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("goofer") != j.end() && j.at("goofer").is_null()) throw std::runtime_error("Unexpected null");
        x.goofer = get_stack_optional<int64_t>(j, "goofer");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("laryngograph") != j.end() && !j.at("laryngograph").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("laryngograph") != j.end() && j.at("laryngograph").is_null()) throw std::runtime_error("Unexpected null");
        x.laryngograph = get_stack_optional<int64_t>(j, "laryngograph");
        if (j.find("leucitis") != j.end() && !j.at("leucitis").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("leucitis") != j.end() && j.at("leucitis").is_null()) throw std::runtime_error("Unexpected null");
        x.leucitis = get_stack_optional<int64_t>(j, "leucitis");
        if (j.find("lymphocyst") != j.end() && !j.at("lymphocyst").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lymphocyst") != j.end() && j.at("lymphocyst").is_null()) throw std::runtime_error("Unexpected null");
        x.lymphocyst = get_stack_optional<int64_t>(j, "lymphocyst");
        if (j.find("microcosmology") != j.end() && !j.at("microcosmology").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("microcosmology") != j.end() && j.at("microcosmology").is_null()) throw std::runtime_error("Unexpected null");
        x.microcosmology = get_stack_optional<int64_t>(j, "microcosmology");
        if (j.find("nauseation") != j.end() && !j.at("nauseation").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("nauseation") != j.end() && j.at("nauseation").is_null()) throw std::runtime_error("Unexpected null");
        x.nauseation = get_stack_optional<int64_t>(j, "nauseation");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("Patarin") != j.end() && !j.at("Patarin").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Patarin") != j.end() && j.at("Patarin").is_null()) throw std::runtime_error("Unexpected null");
        x.patarin = get_stack_optional<int64_t>(j, "Patarin");
        if (j.find("preliberal") != j.end() && !j.at("preliberal").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("preliberal") != j.end() && j.at("preliberal").is_null()) throw std::runtime_error("Unexpected null");
        x.preliberal = get_stack_optional<int64_t>(j, "preliberal");
        if (j.find("prettifier") != j.end() && !j.at("prettifier").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("prettifier") != j.end() && j.at("prettifier").is_null()) throw std::runtime_error("Unexpected null");
        x.prettifier = get_stack_optional<int64_t>(j, "prettifier");
        if (j.find("rangework") != j.end() && !j.at("rangework").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("rangework") != j.end() && j.at("rangework").is_null()) throw std::runtime_error("Unexpected null");
        x.rangework = get_stack_optional<int64_t>(j, "rangework");
        if (j.find("redient") != j.end() && !j.at("redient").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("redient") != j.end() && j.at("redient").is_null()) throw std::runtime_error("Unexpected null");
        x.redient = get_stack_optional<int64_t>(j, "redient");
        if (j.find("subfusiform") != j.end() && !j.at("subfusiform").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("subfusiform") != j.end() && j.at("subfusiform").is_null()) throw std::runtime_error("Unexpected null");
        x.subfusiform = get_stack_optional<int64_t>(j, "subfusiform");
        if (j.find("suicidical") != j.end() && !j.at("suicidical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("suicidical") != j.end() && j.at("suicidical").is_null()) throw std::runtime_error("Unexpected null");
        x.suicidical = get_stack_optional<int64_t>(j, "suicidical");
        if (j.find("swow") != j.end() && !j.at("swow").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("swow") != j.end() && j.at("swow").is_null()) throw std::runtime_error("Unexpected null");
        x.swow = get_stack_optional<int64_t>(j, "swow");
        if (j.find("wastrel") != j.end() && !j.at("wastrel").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("wastrel") != j.end() && j.at("wastrel").is_null()) throw std::runtime_error("Unexpected null");
        x.wastrel = get_stack_optional<int64_t>(j, "wastrel");
        if (j.find("wingle") != j.end() && !j.at("wingle").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("wingle") != j.end() && j.at("wingle").is_null()) throw std::runtime_error("Unexpected null");
        x.wingle = get_stack_optional<int64_t>(j, "wingle");
    }

    inline void to_json(json & j, const DiscordiaClass & x) {
        j = json::object();
        j["Altaic"] = x.altaic;
        j["amoristic"] = x.amoristic;
        j["blennophthalmia"] = x.blennophthalmia;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disciplinability"] = x.disciplinability;
        j["disdiapason"] = x.disdiapason;
        j["goofer"] = x.goofer;
        j["homocerc"] = x.homocerc;
        j["laryngograph"] = x.laryngograph;
        j["leucitis"] = x.leucitis;
        j["lymphocyst"] = x.lymphocyst;
        j["microcosmology"] = x.microcosmology;
        j["nauseation"] = x.nauseation;
        j["nonbookish"] = x.nonbookish;
        j["Patarin"] = x.patarin;
        j["preliberal"] = x.preliberal;
        j["prettifier"] = x.prettifier;
        j["rangework"] = x.rangework;
        j["redient"] = x.redient;
        j["subfusiform"] = x.subfusiform;
        j["suicidical"] = x.suicidical;
        j["swow"] = x.swow;
        j["wastrel"] = x.wastrel;
        j["wingle"] = x.wingle;
    }

    inline void from_json(const json & j, GryphosaurusClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.amissibility = get_untyped(j, "amissibility");
        x.burushaski = get_untyped(j, "Burushaski");
        x.citronin = get_untyped(j, "citronin");
        x.coplaintiff = get_untyped(j, "coplaintiff");
        x.disquisitionary = get_untyped(j, "disquisitionary");
        x.enoplan = get_untyped(j, "enoplan");
        x.faintness = get_untyped(j, "faintness");
        x.hebetomy = get_untyped(j, "hebetomy");
        x.islandry = get_untyped(j, "islandry");
        x.lameduck = get_untyped(j, "lameduck");
        x.overbattle = get_untyped(j, "overbattle");
        x.overinterested = get_untyped(j, "overinterested");
        x.phrenologic = get_untyped(j, "phrenologic");
        x.rainband = get_untyped(j, "rainband");
        x.shiningly = get_untyped(j, "shiningly");
        x.stamineous = get_untyped(j, "stamineous");
        x.subscapularis = get_untyped(j, "subscapularis");
        x.tahami = get_untyped(j, "Tahami");
        x.undaubed = get_untyped(j, "undaubed");
        x.underntime = get_untyped(j, "underntime");
    }

    inline void to_json(json & j, const GryphosaurusClass & x) {
        j = json::object();
        j["amissibility"] = x.amissibility;
        j["Burushaski"] = x.burushaski;
        j["citronin"] = x.citronin;
        j["coplaintiff"] = x.coplaintiff;
        j["disquisitionary"] = x.disquisitionary;
        j["enoplan"] = x.enoplan;
        j["faintness"] = x.faintness;
        j["hebetomy"] = x.hebetomy;
        j["islandry"] = x.islandry;
        j["lameduck"] = x.lameduck;
        j["overbattle"] = x.overbattle;
        j["overinterested"] = x.overinterested;
        j["phrenologic"] = x.phrenologic;
        j["rainband"] = x.rainband;
        j["shiningly"] = x.shiningly;
        j["stamineous"] = x.stamineous;
        j["subscapularis"] = x.subscapularis;
        j["Tahami"] = x.tahami;
        j["undaubed"] = x.undaubed;
        j["underntime"] = x.underntime;
    }

    inline void from_json(const json & j, LaviniaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("agitable") != j.end() && !j.at("agitable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("agitable") != j.end() && j.at("agitable").is_null()) throw std::runtime_error("Unexpected null");
        x.agitable = get_stack_optional<int64_t>(j, "agitable");
        if (j.find("asininity") != j.end() && !j.at("asininity").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("asininity") != j.end() && j.at("asininity").is_null()) throw std::runtime_error("Unexpected null");
        x.asininity = get_stack_optional<int64_t>(j, "asininity");
        if (j.find("benefiter") != j.end() && !j.at("benefiter").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("benefiter") != j.end() && j.at("benefiter").is_null()) throw std::runtime_error("Unexpected null");
        x.benefiter = get_stack_optional<int64_t>(j, "benefiter");
        if (j.find("bronzelike") != j.end() && !j.at("bronzelike").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("bronzelike") != j.end() && j.at("bronzelike").is_null()) throw std::runtime_error("Unexpected null");
        x.bronzelike = get_stack_optional<int64_t>(j, "bronzelike");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("cholesteatomatous") != j.end() && !j.at("cholesteatomatous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("cholesteatomatous") != j.end() && j.at("cholesteatomatous").is_null()) throw std::runtime_error("Unexpected null");
        x.cholesteatomatous = get_stack_optional<int64_t>(j, "cholesteatomatous");
        if (j.find("deprivement") != j.end() && !j.at("deprivement").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("deprivement") != j.end() && j.at("deprivement").is_null()) throw std::runtime_error("Unexpected null");
        x.deprivement = get_stack_optional<int64_t>(j, "deprivement");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("flippantness") != j.end() && !j.at("flippantness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("flippantness") != j.end() && j.at("flippantness").is_null()) throw std::runtime_error("Unexpected null");
        x.flippantness = get_stack_optional<int64_t>(j, "flippantness");
        if (j.find("fogproof") != j.end() && !j.at("fogproof").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("fogproof") != j.end() && j.at("fogproof").is_null()) throw std::runtime_error("Unexpected null");
        x.fogproof = get_stack_optional<int64_t>(j, "fogproof");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("merrymeeting") != j.end() && !j.at("merrymeeting").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("merrymeeting") != j.end() && j.at("merrymeeting").is_null()) throw std::runtime_error("Unexpected null");
        x.merrymeeting = get_stack_optional<int64_t>(j, "merrymeeting");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("overcareful") != j.end() && !j.at("overcareful").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("overcareful") != j.end() && j.at("overcareful").is_null()) throw std::runtime_error("Unexpected null");
        x.overcareful = get_stack_optional<int64_t>(j, "overcareful");
        if (j.find("panaris") != j.end() && !j.at("panaris").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("panaris") != j.end() && j.at("panaris").is_null()) throw std::runtime_error("Unexpected null");
        x.panaris = get_stack_optional<int64_t>(j, "panaris");
        if (j.find("preacceptance") != j.end() && !j.at("preacceptance").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("preacceptance") != j.end() && j.at("preacceptance").is_null()) throw std::runtime_error("Unexpected null");
        x.preacceptance = get_stack_optional<int64_t>(j, "preacceptance");
        if (j.find("quinoxaline") != j.end() && !j.at("quinoxaline").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("quinoxaline") != j.end() && j.at("quinoxaline").is_null()) throw std::runtime_error("Unexpected null");
        x.quinoxaline = get_stack_optional<int64_t>(j, "quinoxaline");
        if (j.find("sig") != j.end() && !j.at("sig").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sig") != j.end() && j.at("sig").is_null()) throw std::runtime_error("Unexpected null");
        x.sig = get_stack_optional<int64_t>(j, "sig");
        if (j.find("superconfusion") != j.end() && !j.at("superconfusion").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("superconfusion") != j.end() && j.at("superconfusion").is_null()) throw std::runtime_error("Unexpected null");
        x.superconfusion = get_stack_optional<int64_t>(j, "superconfusion");
        if (j.find("Tacana") != j.end() && !j.at("Tacana").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Tacana") != j.end() && j.at("Tacana").is_null()) throw std::runtime_error("Unexpected null");
        x.tacana = get_stack_optional<int64_t>(j, "Tacana");
        if (j.find("tillotter") != j.end() && !j.at("tillotter").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tillotter") != j.end() && j.at("tillotter").is_null()) throw std::runtime_error("Unexpected null");
        x.tillotter = get_stack_optional<int64_t>(j, "tillotter");
        if (j.find("tranquillize") != j.end() && !j.at("tranquillize").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tranquillize") != j.end() && j.at("tranquillize").is_null()) throw std::runtime_error("Unexpected null");
        x.tranquillize = get_stack_optional<int64_t>(j, "tranquillize");
        if (j.find("unquestionable") != j.end() && !j.at("unquestionable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unquestionable") != j.end() && j.at("unquestionable").is_null()) throw std::runtime_error("Unexpected null");
        x.unquestionable = get_stack_optional<int64_t>(j, "unquestionable");
        if (j.find("uproute") != j.end() && !j.at("uproute").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("uproute") != j.end() && j.at("uproute").is_null()) throw std::runtime_error("Unexpected null");
        x.uproute = get_stack_optional<int64_t>(j, "uproute");
    }

    inline void to_json(json & j, const LaviniaClass & x) {
        j = json::object();
        j["agitable"] = x.agitable;
        j["asininity"] = x.asininity;
        j["benefiter"] = x.benefiter;
        j["bronzelike"] = x.bronzelike;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["cholesteatomatous"] = x.cholesteatomatous;
        j["deprivement"] = x.deprivement;
        j["disdiapason"] = x.disdiapason;
        j["flippantness"] = x.flippantness;
        j["fogproof"] = x.fogproof;
        j["homocerc"] = x.homocerc;
        j["merrymeeting"] = x.merrymeeting;
        j["nonbookish"] = x.nonbookish;
        j["overcareful"] = x.overcareful;
        j["panaris"] = x.panaris;
        j["preacceptance"] = x.preacceptance;
        j["quinoxaline"] = x.quinoxaline;
        j["sig"] = x.sig;
        j["superconfusion"] = x.superconfusion;
        j["Tacana"] = x.tacana;
        j["tillotter"] = x.tillotter;
        j["tranquillize"] = x.tranquillize;
        j["unquestionable"] = x.unquestionable;
        j["uproute"] = x.uproute;
    }

    inline void from_json(const json & j, OskarClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.acrobates = get_untyped(j, "Acrobates");
        x.beanshooter = get_untyped(j, "beanshooter");
        x.bearhound = get_untyped(j, "bearhound");
        x.cayuga = get_untyped(j, "Cayuga");
        x.guarneri = get_untyped(j, "guarneri");
        x.hypochondriacism = get_untyped(j, "hypochondriacism");
        x.indication = get_untyped(j, "indication");
        x.jaculative = get_untyped(j, "jaculative");
        x.nagana = get_untyped(j, "nagana");
        x.netherlandish = get_untyped(j, "Netherlandish");
        x.noctivagous = get_untyped(j, "noctivagous");
        x.nonphysiological = get_untyped(j, "nonphysiological");
        x.praxis = get_untyped(j, "praxis");
        x.provision = get_untyped(j, "provision");
        x.subterhuman = get_untyped(j, "subterhuman");
        x.sunlit = get_untyped(j, "sunlit");
        x.syncraniate = get_untyped(j, "syncraniate");
        x.teachment = get_untyped(j, "teachment");
        x.unmutinous = get_untyped(j, "unmutinous");
        x.unstoppable = get_untyped(j, "unstoppable");
    }

    inline void to_json(json & j, const OskarClass & x) {
        j = json::object();
        j["Acrobates"] = x.acrobates;
        j["beanshooter"] = x.beanshooter;
        j["bearhound"] = x.bearhound;
        j["Cayuga"] = x.cayuga;
        j["guarneri"] = x.guarneri;
        j["hypochondriacism"] = x.hypochondriacism;
        j["indication"] = x.indication;
        j["jaculative"] = x.jaculative;
        j["nagana"] = x.nagana;
        j["Netherlandish"] = x.netherlandish;
        j["noctivagous"] = x.noctivagous;
        j["nonphysiological"] = x.nonphysiological;
        j["praxis"] = x.praxis;
        j["provision"] = x.provision;
        j["subterhuman"] = x.subterhuman;
        j["sunlit"] = x.sunlit;
        j["syncraniate"] = x.syncraniate;
        j["teachment"] = x.teachment;
        j["unmutinous"] = x.unmutinous;
        j["unstoppable"] = x.unstoppable;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.abranchiata = j.at("Abranchiata").get<std::vector<Abranchiata>>();
        x.academe = j.at("academe").get<std::vector<Academe>>();
        x.acquirable = j.at("acquirable").get<std::vector<Acquirable>>();
        x.aerometry = j.at("aerometry").get<std::vector<Aerometry>>();
        x.alexin = j.at("alexin").get<std::vector<Alexin>>();
        x.alleviate = j.at("alleviate").get<std::vector<AlleviateElement>>();
        x.amaas = j.at("amaas").get<std::vector<Amaa>>();
        x.ambassage = j.at("ambassage").get<std::vector<Ambassage>>();
        x.amphithyron = j.at("amphithyron").get<std::vector<std::optional<Amphithyron>>>();
        x.andriana = j.at("Andriana").get<std::vector<std::optional<std::string>>>();
        x.ankee = j.at("ankee").get<std::vector<AnkeeElement>>();
        x.annihilator = j.at("annihilator").get<std::vector<std::optional<std::map<std::string, std::optional<int64_t>>>>>();
        x.annulose = get_untyped(j, "annulose");
        x.ansarie = j.at("Ansarie").get<std::vector<AnsarieElement>>();
        x.aphasia = j.at("aphasia").get<std::vector<Aphasia>>();
        x.asprawl = j.at("asprawl").get<std::vector<Asprawl>>();
        x.attractive = j.at("attractive").get<std::vector<std::optional<bool>>>();
        x.barksome = j.at("barksome").get<std::map<std::string, int64_t>>();
        x.bedesman = j.at("bedesman").get<std::vector<Bedesman>>();
        x.belard = j.at("belard").get<std::vector<Belard>>();
        x.bocking = j.at("bocking").get<std::vector<Bocking>>();
        x.brawlingly = j.at("brawlingly").get<std::vector<Brawlingly>>();
        x.brookie = j.at("brookie").get<std::vector<Brookie>>();
        x.bumboatman = j.at("bumboatman").get<std::vector<Bumboatman>>();
        x.bystreet = j.at("bystreet").get<std::vector<nlohmann::json>>();
        x.calaverite = j.at("calaverite").get<std::vector<Calaverite>>();
        x.catallactic = j.at("catallactic").get<std::vector<Catallactic>>();
        x.cemental = j.at("cemental").get<std::vector<Cemental>>();
        x.chytridiaceae = j.at("Chytridiaceae").get<std::vector<ChytridiaceaeElement>>();
        x.discordia = j.at("Discordia").get<std::vector<DiscordiaElement>>();
        x.endomyces = j.at("Endomyces").get<std::vector<Endomyce>>();
        x.epinephelidae = j.at("Epinephelidae").get<std::vector<Epinephelidae>>();
        x.eupatorium = j.at("Eupatorium").get<std::vector<Eupatorium>>();
        x.gryphosaurus = j.at("Gryphosaurus").get<std::vector<GryphosaurusElement>>();
        x.koryak = j.at("Koryak").get<std::vector<Koryak>>();
        x.lavinia = j.at("Lavinia").get<std::vector<LaviniaElement>>();
        x.oskar = j.at("Oskar").get<std::vector<OskarElement>>();
        x.rebecca = j.at("Rebecca").get<std::vector<RebeccaElement>>();
        x.rhomboganoidei = j.at("Rhomboganoidei").get<std::vector<Rhomboganoidei>>();
        x.rigsmal = j.at("Rigsmal").get<bool>();
        x.ruellia = j.at("Ruellia").get<std::vector<Ruellia>>();
        x.school = j.at("School").get<std::vector<School>>();
        x.shakespearolater = j.at("Shakespearolater").get<std::vector<Shakespearolater>>();
        x.svan = j.at("Svan").get<std::vector<double>>();
        x.wayao = j.at("Wayao").get<std::map<std::string, double>>();
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["Abranchiata"] = x.abranchiata;
        j["academe"] = x.academe;
        j["acquirable"] = x.acquirable;
        j["aerometry"] = x.aerometry;
        j["alexin"] = x.alexin;
        j["alleviate"] = x.alleviate;
        j["amaas"] = x.amaas;
        j["ambassage"] = x.ambassage;
        j["amphithyron"] = x.amphithyron;
        j["Andriana"] = x.andriana;
        j["ankee"] = x.ankee;
        j["annihilator"] = x.annihilator;
        j["annulose"] = x.annulose;
        j["Ansarie"] = x.ansarie;
        j["aphasia"] = x.aphasia;
        j["asprawl"] = x.asprawl;
        j["attractive"] = x.attractive;
        j["barksome"] = x.barksome;
        j["bedesman"] = x.bedesman;
        j["belard"] = x.belard;
        j["bocking"] = x.bocking;
        j["brawlingly"] = x.brawlingly;
        j["brookie"] = x.brookie;
        j["bumboatman"] = x.bumboatman;
        j["bystreet"] = x.bystreet;
        j["calaverite"] = x.calaverite;
        j["catallactic"] = x.catallactic;
        j["cemental"] = x.cemental;
        j["Chytridiaceae"] = x.chytridiaceae;
        j["Discordia"] = x.discordia;
        j["Endomyces"] = x.endomyces;
        j["Epinephelidae"] = x.epinephelidae;
        j["Eupatorium"] = x.eupatorium;
        j["Gryphosaurus"] = x.gryphosaurus;
        j["Koryak"] = x.koryak;
        j["Lavinia"] = x.lavinia;
        j["Oskar"] = x.oskar;
        j["Rebecca"] = x.rebecca;
        j["Rhomboganoidei"] = x.rhomboganoidei;
        j["Rigsmal"] = x.rigsmal;
        j["Ruellia"] = x.ruellia;
        j["School"] = x.school;
        j["Shakespearolater"] = x.shakespearolater;
        j["Svan"] = x.svan;
        j["Wayao"] = x.wayao;
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t>>::from_json(const json & j, std::variant<std::vector<int64_t>, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t>>::to_json(json & j, const std::variant<std::vector<int64_t>, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<int64_t>, int64_t, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass>>::from_json(const json & j, std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::AlleviateClass>();
        else if (j.is_array())
            x = j.get<std::vector<std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass>>::to_json(json & j, const std::variant<std::vector<std::optional<int64_t>>, quicktype::AlleviateClass> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, int64_t>>::from_json(const json & j, std::variant<bool, quicktype::Rebecca, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, int64_t>>::to_json(json & j, const std::variant<bool, quicktype::Rebecca, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, std::string>>::from_json(const json & j, std::variant<std::vector<json>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::string>>::to_json(json & j, const std::variant<std::vector<json>, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::AnkeeClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::AnkeeClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnsarieClass>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::AnsarieClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::AnsarieClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::AnsarieClass>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::AnsarieClass> & x) {
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

    inline void adl_serializer<std::variant<bool, double, std::string>>::from_json(const json & j, std::variant<bool, double, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double, std::string>>::to_json(json & j, const std::variant<bool, double, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, double>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, double>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::Rebecca, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>>>::from_json(const json & j, std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, const std::variant<std::vector<json>, std::map<std::string, std::optional<int64_t>>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca> & x) {
        if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::Rebecca> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<json>, bool, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<int64_t>, double, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::ChytridiaceaeClass>>::from_json(const json & j, std::variant<bool, quicktype::ChytridiaceaeClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::ChytridiaceaeClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::ChytridiaceaeClass>>::to_json(json & j, const std::variant<bool, quicktype::ChytridiaceaeClass> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::DiscordiaClass>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::DiscordiaClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::DiscordiaClass>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::DiscordiaClass> & x) {
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

    inline void adl_serializer<std::variant<bool, int64_t, std::string>>::from_json(const json & j, std::variant<bool, int64_t, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, int64_t, std::string>>::to_json(json & j, const std::variant<bool, int64_t, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::GryphosaurusClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::GryphosaurusClass, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::map<std::string, std::optional<int64_t>>, std::string>>::from_json(const json & j, std::variant<std::map<std::string, std::optional<int64_t>>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::map<std::string, std::optional<int64_t>>, std::string>>::to_json(json & j, const std::variant<std::map<std::string, std::optional<int64_t>>, std::string> & x) {
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

    inline void adl_serializer<std::variant<quicktype::LaviniaClass, std::string>>::from_json(const json & j, std::variant<quicktype::LaviniaClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::LaviniaClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LaviniaClass, std::string>>::to_json(json & j, const std::variant<quicktype::LaviniaClass, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::OskarClass>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::OskarClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::OskarClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::OskarClass>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::OskarClass> & x) {
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

    inline void adl_serializer<std::variant<quicktype::Rebecca, int64_t, std::string>>::from_json(const json & j, std::variant<quicktype::Rebecca, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Rebecca, int64_t, std::string>>::to_json(json & j, const std::variant<quicktype::Rebecca, int64_t, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::Rebecca, std::string> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, std::string>>::from_json(const json & j, std::variant<bool, quicktype::Rebecca, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::Rebecca>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::Rebecca, std::string>>::to_json(json & j, const std::variant<bool, quicktype::Rebecca, std::string> & x) {
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

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<int64_t, std::map<std::string, int64_t>> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<int64_t, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::string>>::from_json(const json & j, std::variant<std::vector<int64_t>, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, double, std::string>>::to_json(json & j, const std::variant<std::vector<int64_t>, double, std::string> & x) {
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
