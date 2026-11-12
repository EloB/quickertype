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

    using Protrusive = std::variant<std::vector<std::optional<int64_t>>, double>;

    struct PulpitismClass {
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
    };

    using PulpitismElement = std::variant<std::vector<int64_t>, PulpitismClass, double>;

    struct PyodermiaClass {
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
    };

    using PyodermiaElement = std::variant<PyodermiaClass, int64_t>;

    struct QuebrachineClass {
        double catharticalness;
        int64_t chirotherium;
        std::string disdiapason;
        bool homocerc;
        nlohmann::json nonbookish;
    };

    using QuebrachineElement = std::optional<std::variant<bool, QuebrachineClass>>;

    using Querier = std::variant<bool, std::map<std::string, int64_t>>;

    using Rebarbative = std::variant<std::vector<int64_t>, bool, double>;

    struct Reimagine {
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
    };

    struct Ressaut {
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
    };

    using Retrocervical = std::variant<std::vector<std::optional<int64_t>>, int64_t>;

    using Revert = std::variant<bool, std::string>;

    struct RewriteClass {
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
    };

    using RewriteElement = std::variant<std::vector<nlohmann::json>, RewriteClass, double>;

    using Saccoderm = std::optional<std::variant<std::vector<int64_t>, std::string>>;

    struct SantirClass {
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
    };

    using SantirElement = std::variant<SantirClass, double>;

    using Saprophilous = std::optional<std::variant<std::map<std::string, int64_t>, std::string>>;

    struct SaxtenClass {
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
    };

    using SaxtenElement = std::variant<SaxtenClass, std::string>;

    struct Scatty {
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
    };

    using Scoffer = std::optional<std::variant<std::vector<nlohmann::json>, std::map<std::string, int64_t>>>;

    using Scrampum = std::optional<std::variant<std::vector<int64_t>, bool>>;

    using Serpentinic = std::variant<std::vector<int64_t>, double>;

    using Shadowable = std::variant<std::vector<std::optional<int64_t>>, bool>;

    struct SisteringClass {
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
    };

    using SisteringElement = std::variant<std::vector<nlohmann::json>, SisteringClass, int64_t>;

    struct Staghunting {
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
    };

    using Stagmometer = std::variant<std::vector<std::optional<int64_t>>, std::string>;

    using Stimulability = std::variant<bool, int64_t, std::map<std::string, int64_t>>;

    using Strangleable = std::variant<std::vector<nlohmann::json>, double>;

    struct StrenuosityClass {
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
    };

    using StrenuosityElement = std::variant<std::vector<nlohmann::json>, StrenuosityClass>;

    using Tabaxir = std::variant<bool, double>;

    using Talpiform = std::optional<std::variant<QuebrachineClass, double>>;

    using Thwack = std::variant<bool, QuebrachineClass, double>;

    using Tortricine = std::variant<std::vector<std::optional<int64_t>>, QuebrachineClass>;

    struct TruantcyClass {
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
    };

    using TruantcyElement = std::variant<bool, TruantcyClass>;

    using Unbeginning = std::variant<std::vector<nlohmann::json>, std::map<std::string, int64_t>, std::string>;

    using Undesirability = std::variant<std::vector<int64_t>, std::map<std::string, int64_t>, std::string>;

    using Unerasing = std::variant<std::vector<nlohmann::json>, int64_t, std::map<std::string, int64_t>>;

    using Unguentarium = std::optional<std::variant<std::vector<nlohmann::json>, int64_t>>;

    struct UnimpeachablyClass {
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
    };

    using UnimpeachablyElement = std::variant<bool, UnimpeachablyClass>;

    using Unmortgaged = std::optional<std::variant<double, std::map<std::string, int64_t>>>;

    using Unobstructed = std::optional<std::variant<QuebrachineClass, int64_t>>;

    using Unreceptivity = std::variant<std::vector<nlohmann::json>, int64_t, std::string>;

    using Unsatisfactoriness = std::variant<std::vector<int64_t>, bool, int64_t>;

    struct UnstressedClass {
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
    };

    using UnstressedElement = std::variant<bool, UnstressedClass, std::string>;

    using Untasked = std::variant<std::vector<nlohmann::json>, double, std::map<std::string, int64_t>>;

    using Unvarying = std::variant<bool, double, std::map<std::string, int64_t>>;

    using Vehemently = std::optional<std::variant<std::vector<nlohmann::json>, bool>>;

    using Whitepot = std::variant<QuebrachineClass, double>;

    struct WrothyClass {
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
    };

    using WrothyElement = std::variant<std::vector<nlohmann::json>, WrothyClass>;

    struct TopLevel {
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
        x.abnet = get_untyped(j, "abnet");
        x.buckhorn = get_untyped(j, "buckhorn");
        x.calciform = get_untyped(j, "calciform");
        x.chelophore = get_untyped(j, "chelophore");
        x.cogitation = get_untyped(j, "cogitation");
        x.decreeable = get_untyped(j, "decreeable");
        x.despicable = get_untyped(j, "despicable");
        x.isodiazo = get_untyped(j, "isodiazo");
        x.jadedly = get_untyped(j, "jadedly");
        x.leptochlorite = get_untyped(j, "leptochlorite");
        x.nursling = get_untyped(j, "nursling");
        x.palamedean = get_untyped(j, "palamedean");
        x.photoheliograph = get_untyped(j, "photoheliograph");
        x.pipewood = get_untyped(j, "pipewood");
        x.roberd = get_untyped(j, "roberd");
        x.statable = get_untyped(j, "statable");
        x.superassume = get_untyped(j, "superassume");
        x.syllabe = get_untyped(j, "syllabe");
        x.toughhead = get_untyped(j, "toughhead");
        x.underburn = get_untyped(j, "underburn");
    }

    inline void to_json(json & j, const PulpitismClass & x) {
        j = json::object();
        j["abnet"] = x.abnet;
        j["buckhorn"] = x.buckhorn;
        j["calciform"] = x.calciform;
        j["chelophore"] = x.chelophore;
        j["cogitation"] = x.cogitation;
        j["decreeable"] = x.decreeable;
        j["despicable"] = x.despicable;
        j["isodiazo"] = x.isodiazo;
        j["jadedly"] = x.jadedly;
        j["leptochlorite"] = x.leptochlorite;
        j["nursling"] = x.nursling;
        j["palamedean"] = x.palamedean;
        j["photoheliograph"] = x.photoheliograph;
        j["pipewood"] = x.pipewood;
        j["roberd"] = x.roberd;
        j["statable"] = x.statable;
        j["superassume"] = x.superassume;
        j["syllabe"] = x.syllabe;
        j["toughhead"] = x.toughhead;
        j["underburn"] = x.underburn;
    }

    inline void from_json(const json & j, PyodermiaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.aphoristically = get_untyped(j, "aphoristically");
        x.apophyllous = get_untyped(j, "apophyllous");
        x.cognize = get_untyped(j, "cognize");
        x.dermonosology = get_untyped(j, "dermonosology");
        x.gyppo = get_untyped(j, "Gyppo");
        x.ither = get_untyped(j, "ither");
        x.juglandaceous = get_untyped(j, "juglandaceous");
        x.litho = get_untyped(j, "litho");
        x.macropterous = get_untyped(j, "macropterous");
        x.photographer = get_untyped(j, "photographer");
        x.romancing = get_untyped(j, "romancing");
        x.rumness = get_untyped(j, "rumness");
        x.somniloquist = get_untyped(j, "somniloquist");
        x.stressfully = get_untyped(j, "stressfully");
        x.tactically = get_untyped(j, "tactically");
        x.tracheophony = get_untyped(j, "tracheophony");
        x.unappositely = get_untyped(j, "unappositely");
        x.unclothedly = get_untyped(j, "unclothedly");
        x.unimplied = get_untyped(j, "unimplied");
        x.unsyncopated = get_untyped(j, "unsyncopated");
    }

    inline void to_json(json & j, const PyodermiaClass & x) {
        j = json::object();
        j["aphoristically"] = x.aphoristically;
        j["apophyllous"] = x.apophyllous;
        j["cognize"] = x.cognize;
        j["dermonosology"] = x.dermonosology;
        j["Gyppo"] = x.gyppo;
        j["ither"] = x.ither;
        j["juglandaceous"] = x.juglandaceous;
        j["litho"] = x.litho;
        j["macropterous"] = x.macropterous;
        j["photographer"] = x.photographer;
        j["romancing"] = x.romancing;
        j["rumness"] = x.rumness;
        j["somniloquist"] = x.somniloquist;
        j["stressfully"] = x.stressfully;
        j["tactically"] = x.tactically;
        j["tracheophony"] = x.tracheophony;
        j["unappositely"] = x.unappositely;
        j["unclothedly"] = x.unclothedly;
        j["unimplied"] = x.unimplied;
        j["unsyncopated"] = x.unsyncopated;
    }

    inline void from_json(const json & j, QuebrachineClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.catharticalness = j.at("catharticalness").get<double>();
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.chirotherium = j.at("Chirotherium").get<int64_t>();
        x.disdiapason = j.at("disdiapason").get<std::string>();
        x.homocerc = j.at("homocerc").get<bool>();
        x.nonbookish = get_untyped(j, "nonbookish");
    }

    inline void to_json(json & j, const QuebrachineClass & x) {
        j = json::object();
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["homocerc"] = x.homocerc;
        j["nonbookish"] = x.nonbookish;
    }

    inline void from_json(const json & j, Reimagine& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.adducible = get_untyped(j, "adducible");
        x.anabolin = get_untyped(j, "anabolin");
        x.brainy = get_untyped(j, "brainy");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        x.chrysamine = get_untyped(j, "chrysamine");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.fluxweed = get_untyped(j, "fluxweed");
        x.glaucine = get_untyped(j, "glaucine");
        x.grobianism = get_untyped(j, "grobianism");
        x.hermo = get_untyped(j, "Hermo");
        x.hieroglyphist = get_untyped(j, "hieroglyphist");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.icteroid = get_untyped(j, "icteroid");
        x.immortal = get_untyped(j, "immortal");
        x.impetulant = get_untyped(j, "impetulant");
        x.irrigate = get_untyped(j, "irrigate");
        x.myxedema = get_untyped(j, "myxedema");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.onyx = get_untyped(j, "onyx");
        x.repasser = get_untyped(j, "repasser");
        x.septomarginal = get_untyped(j, "septomarginal");
        x.subdie = get_untyped(j, "subdie");
        x.tibiometatarsal = get_untyped(j, "tibiometatarsal");
        x.waltzlike = get_untyped(j, "waltzlike");
    }

    inline void to_json(json & j, const Reimagine & x) {
        j = json::object();
        j["adducible"] = x.adducible;
        j["anabolin"] = x.anabolin;
        j["brainy"] = x.brainy;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["chrysamine"] = x.chrysamine;
        j["disdiapason"] = x.disdiapason;
        j["fluxweed"] = x.fluxweed;
        j["glaucine"] = x.glaucine;
        j["grobianism"] = x.grobianism;
        j["Hermo"] = x.hermo;
        j["hieroglyphist"] = x.hieroglyphist;
        j["homocerc"] = x.homocerc;
        j["icteroid"] = x.icteroid;
        j["immortal"] = x.immortal;
        j["impetulant"] = x.impetulant;
        j["irrigate"] = x.irrigate;
        j["myxedema"] = x.myxedema;
        j["nonbookish"] = x.nonbookish;
        j["onyx"] = x.onyx;
        j["repasser"] = x.repasser;
        j["septomarginal"] = x.septomarginal;
        j["subdie"] = x.subdie;
        j["tibiometatarsal"] = x.tibiometatarsal;
        j["waltzlike"] = x.waltzlike;
    }

    inline void from_json(const json & j, Ressaut& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.apperceptive = j.at("apperceptive").get<std::string>();
        x.cuttoo = j.at("cuttoo").get<std::string>();
        x.douser = j.at("douser").get<std::string>();
        x.drinkproof = j.at("drinkproof").get<std::string>();
        x.forementioned = j.at("forementioned").get<std::string>();
        x.freesia = j.at("Freesia").get<std::string>();
        x.genevieve = j.at("Genevieve").get<std::string>();
        x.hyperdiabolical = j.at("hyperdiabolical").get<std::string>();
        x.hypocone = j.at("hypocone").get<std::string>();
        x.irreverentially = j.at("irreverentially").get<std::string>();
        x.jumart = j.at("jumart").get<std::string>();
        x.mimosaceae = j.at("Mimosaceae").get<std::string>();
        x.mollicrush = j.at("mollicrush").get<std::string>();
        x.nedder = j.at("nedder").get<std::string>();
        x.retinasphalt = j.at("retinasphalt").get<std::string>();
        x.sough = j.at("sough").get<std::string>();
        x.steading = j.at("steading").get<std::string>();
        x.theopaschitism = j.at("Theopaschitism").get<std::string>();
        x.undurableness = j.at("undurableness").get<std::string>();
        x.unmingleable = j.at("unmingleable").get<std::string>();
    }

    inline void to_json(json & j, const Ressaut & x) {
        j = json::object();
        j["apperceptive"] = x.apperceptive;
        j["cuttoo"] = x.cuttoo;
        j["douser"] = x.douser;
        j["drinkproof"] = x.drinkproof;
        j["forementioned"] = x.forementioned;
        j["Freesia"] = x.freesia;
        j["Genevieve"] = x.genevieve;
        j["hyperdiabolical"] = x.hyperdiabolical;
        j["hypocone"] = x.hypocone;
        j["irreverentially"] = x.irreverentially;
        j["jumart"] = x.jumart;
        j["Mimosaceae"] = x.mimosaceae;
        j["mollicrush"] = x.mollicrush;
        j["nedder"] = x.nedder;
        j["retinasphalt"] = x.retinasphalt;
        j["sough"] = x.sough;
        j["steading"] = x.steading;
        j["Theopaschitism"] = x.theopaschitism;
        j["undurableness"] = x.undurableness;
        j["unmingleable"] = x.unmingleable;
    }

    inline void from_json(const json & j, RewriteClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.accountancy = get_untyped(j, "accountancy");
        x.cacotrophic = get_untyped(j, "cacotrophic");
        x.contest = get_untyped(j, "contest");
        x.couthily = get_untyped(j, "couthily");
        x.falculate = get_untyped(j, "falculate");
        x.foreseize = get_untyped(j, "foreseize");
        x.hyades = get_untyped(j, "Hyades");
        x.lemnad = get_untyped(j, "lemnad");
        x.monotheistically = get_untyped(j, "monotheistically");
        x.nonflying = get_untyped(j, "nonflying");
        x.ptenoglossa = get_untyped(j, "Ptenoglossa");
        x.repatch = get_untyped(j, "repatch");
        x.rodman = get_untyped(j, "rodman");
        x.strung = get_untyped(j, "strung");
        x.titmal = get_untyped(j, "titmal");
        x.twalpennyworth = get_untyped(j, "twalpennyworth");
        x.unblamable = get_untyped(j, "unblamable");
        x.vertical = get_untyped(j, "vertical");
        x.whiggification = get_untyped(j, "Whiggification");
        x.yardman = get_untyped(j, "yardman");
    }

    inline void to_json(json & j, const RewriteClass & x) {
        j = json::object();
        j["accountancy"] = x.accountancy;
        j["cacotrophic"] = x.cacotrophic;
        j["contest"] = x.contest;
        j["couthily"] = x.couthily;
        j["falculate"] = x.falculate;
        j["foreseize"] = x.foreseize;
        j["Hyades"] = x.hyades;
        j["lemnad"] = x.lemnad;
        j["monotheistically"] = x.monotheistically;
        j["nonflying"] = x.nonflying;
        j["Ptenoglossa"] = x.ptenoglossa;
        j["repatch"] = x.repatch;
        j["rodman"] = x.rodman;
        j["strung"] = x.strung;
        j["titmal"] = x.titmal;
        j["twalpennyworth"] = x.twalpennyworth;
        j["unblamable"] = x.unblamable;
        j["vertical"] = x.vertical;
        j["Whiggification"] = x.whiggification;
        j["yardman"] = x.yardman;
    }

    inline void from_json(const json & j, SantirClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.admiredly = get_untyped(j, "admiredly");
        x.demicaponier = get_untyped(j, "demicaponier");
        x.epitympanic = get_untyped(j, "epitympanic");
        x.investitor = get_untyped(j, "investitor");
        x.lupiform = get_untyped(j, "lupiform");
        x.monoflagellate = get_untyped(j, "monoflagellate");
        x.paleoethnic = get_untyped(j, "paleoethnic");
        x.prediscountable = get_untyped(j, "prediscountable");
        x.rhetoricals = get_untyped(j, "rhetoricals");
        x.roomth = get_untyped(j, "roomth");
        x.saccharose = get_untyped(j, "saccharose");
        x.septonasal = get_untyped(j, "septonasal");
        x.serpenticide = get_untyped(j, "serpenticide");
        x.setarious = get_untyped(j, "setarious");
        x.spaework = get_untyped(j, "spaework");
        x.stylite = get_untyped(j, "stylite");
        x.suessiones = get_untyped(j, "Suessiones");
        x.timelily = get_untyped(j, "timelily");
        x.unprofaned = get_untyped(j, "unprofaned");
        x.vorticular = get_untyped(j, "vorticular");
    }

    inline void to_json(json & j, const SantirClass & x) {
        j = json::object();
        j["admiredly"] = x.admiredly;
        j["demicaponier"] = x.demicaponier;
        j["epitympanic"] = x.epitympanic;
        j["investitor"] = x.investitor;
        j["lupiform"] = x.lupiform;
        j["monoflagellate"] = x.monoflagellate;
        j["paleoethnic"] = x.paleoethnic;
        j["prediscountable"] = x.prediscountable;
        j["rhetoricals"] = x.rhetoricals;
        j["roomth"] = x.roomth;
        j["saccharose"] = x.saccharose;
        j["septonasal"] = x.septonasal;
        j["serpenticide"] = x.serpenticide;
        j["setarious"] = x.setarious;
        j["spaework"] = x.spaework;
        j["stylite"] = x.stylite;
        j["Suessiones"] = x.suessiones;
        j["timelily"] = x.timelily;
        j["unprofaned"] = x.unprofaned;
        j["vorticular"] = x.vorticular;
    }

    inline void from_json(const json & j, SaxtenClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.algarrobilla = get_untyped(j, "algarrobilla");
        x.bowgrace = get_untyped(j, "bowgrace");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        x.centaurid = get_untyped(j, "Centaurid");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.flix = get_untyped(j, "flix");
        x.germanely = get_untyped(j, "germanely");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.inhume = get_untyped(j, "inhume");
        x.lepidote = get_untyped(j, "lepidote");
        x.megalochirous = get_untyped(j, "megalochirous");
        x.ninepenny = get_untyped(j, "ninepenny");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.nondeist = get_untyped(j, "nondeist");
        x.nymphaeaceous = get_untyped(j, "nymphaeaceous");
        x.parietofrontal = get_untyped(j, "parietofrontal");
        x.sancyite = get_untyped(j, "sancyite");
        x.subjectivist = get_untyped(j, "subjectivist");
        x.tibiad = get_untyped(j, "tibiad");
        x.transonic = get_untyped(j, "transonic");
        x.tripetalous = get_untyped(j, "tripetalous");
        x.trunchman = get_untyped(j, "trunchman");
        x.urger = get_untyped(j, "urger");
        x.withdrawnness = get_untyped(j, "withdrawnness");
    }

    inline void to_json(json & j, const SaxtenClass & x) {
        j = json::object();
        j["algarrobilla"] = x.algarrobilla;
        j["bowgrace"] = x.bowgrace;
        j["catharticalness"] = x.catharticalness;
        j["Centaurid"] = x.centaurid;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["flix"] = x.flix;
        j["germanely"] = x.germanely;
        j["homocerc"] = x.homocerc;
        j["inhume"] = x.inhume;
        j["lepidote"] = x.lepidote;
        j["megalochirous"] = x.megalochirous;
        j["ninepenny"] = x.ninepenny;
        j["nonbookish"] = x.nonbookish;
        j["nondeist"] = x.nondeist;
        j["nymphaeaceous"] = x.nymphaeaceous;
        j["parietofrontal"] = x.parietofrontal;
        j["sancyite"] = x.sancyite;
        j["subjectivist"] = x.subjectivist;
        j["tibiad"] = x.tibiad;
        j["transonic"] = x.transonic;
        j["tripetalous"] = x.tripetalous;
        j["trunchman"] = x.trunchman;
        j["urger"] = x.urger;
        j["withdrawnness"] = x.withdrawnness;
    }

    inline void from_json(const json & j, Scatty& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.aeriferous = get_untyped(j, "aeriferous");
        x.antical = get_untyped(j, "antical");
        x.antighostism = get_untyped(j, "antighostism");
        x.arcanum = get_untyped(j, "arcanum");
        x.autotrophy = get_untyped(j, "autotrophy");
        x.baronial = get_untyped(j, "baronial");
        x.caffeine = get_untyped(j, "caffeine");
        x.gorgoniacean = get_untyped(j, "gorgoniacean");
        x.heroical = get_untyped(j, "heroical");
        x.hydropical = get_untyped(j, "hydropical");
        x.mechanology = get_untyped(j, "mechanology");
        x.musicopoetic = get_untyped(j, "musicopoetic");
        x.officiality = get_untyped(j, "officiality");
        x.oftentimes = get_untyped(j, "oftentimes");
        x.ophthalmotonometer = get_untyped(j, "ophthalmotonometer");
        x.reflectively = get_untyped(j, "reflectively");
        x.springer = get_untyped(j, "springer");
        x.tabasco = get_untyped(j, "Tabasco");
        x.teleianthous = get_untyped(j, "teleianthous");
        x.uncombated = get_untyped(j, "uncombated");
    }

    inline void to_json(json & j, const Scatty & x) {
        j = json::object();
        j["aeriferous"] = x.aeriferous;
        j["antical"] = x.antical;
        j["antighostism"] = x.antighostism;
        j["arcanum"] = x.arcanum;
        j["autotrophy"] = x.autotrophy;
        j["baronial"] = x.baronial;
        j["caffeine"] = x.caffeine;
        j["gorgoniacean"] = x.gorgoniacean;
        j["heroical"] = x.heroical;
        j["hydropical"] = x.hydropical;
        j["mechanology"] = x.mechanology;
        j["musicopoetic"] = x.musicopoetic;
        j["officiality"] = x.officiality;
        j["oftentimes"] = x.oftentimes;
        j["ophthalmotonometer"] = x.ophthalmotonometer;
        j["reflectively"] = x.reflectively;
        j["springer"] = x.springer;
        j["Tabasco"] = x.tabasco;
        j["teleianthous"] = x.teleianthous;
        j["uncombated"] = x.uncombated;
    }

    inline void from_json(const json & j, SisteringClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.amphicarpic = get_untyped(j, "amphicarpic");
        x.chianti = get_untyped(j, "Chianti");
        x.frigorific = get_untyped(j, "frigorific");
        x.haplomi = get_untyped(j, "Haplomi");
        x.hyperkinesis = get_untyped(j, "hyperkinesis");
        x.laudable = get_untyped(j, "laudable");
        x.madwoman = get_untyped(j, "madwoman");
        x.maimedly = get_untyped(j, "maimedly");
        x.micropterygidae = get_untyped(j, "Micropterygidae");
        x.microrhabdus = get_untyped(j, "microrhabdus");
        x.nondense = get_untyped(j, "nondense");
        x.phlebemphraxis = get_untyped(j, "phlebemphraxis");
        x.redsear = get_untyped(j, "redsear");
        x.schismatical = get_untyped(j, "schismatical");
        x.tartryl = get_untyped(j, "tartryl");
        x.unabhorred = get_untyped(j, "unabhorred");
        x.undeliberateness = get_untyped(j, "undeliberateness");
        x.unmixable = get_untyped(j, "unmixable");
        x.untruckling = get_untyped(j, "untruckling");
        x.vineal = get_untyped(j, "vineal");
    }

    inline void to_json(json & j, const SisteringClass & x) {
        j = json::object();
        j["amphicarpic"] = x.amphicarpic;
        j["Chianti"] = x.chianti;
        j["frigorific"] = x.frigorific;
        j["Haplomi"] = x.haplomi;
        j["hyperkinesis"] = x.hyperkinesis;
        j["laudable"] = x.laudable;
        j["madwoman"] = x.madwoman;
        j["maimedly"] = x.maimedly;
        j["Micropterygidae"] = x.micropterygidae;
        j["microrhabdus"] = x.microrhabdus;
        j["nondense"] = x.nondense;
        j["phlebemphraxis"] = x.phlebemphraxis;
        j["redsear"] = x.redsear;
        j["schismatical"] = x.schismatical;
        j["tartryl"] = x.tartryl;
        j["unabhorred"] = x.unabhorred;
        j["undeliberateness"] = x.undeliberateness;
        j["unmixable"] = x.unmixable;
        j["untruckling"] = x.untruckling;
        j["vineal"] = x.vineal;
    }

    inline void from_json(const json & j, Staghunting& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("calorimetric") != j.end() && !j.at("calorimetric").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("calorimetric") != j.end() && j.at("calorimetric").is_null()) throw std::runtime_error("Unexpected null");
        x.calorimetric = get_stack_optional<int64_t>(j, "calorimetric");
        if (j.find("canid") != j.end() && !j.at("canid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("canid") != j.end() && j.at("canid").is_null()) throw std::runtime_error("Unexpected null");
        x.canid = get_stack_optional<int64_t>(j, "canid");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("ditriglyphic") != j.end() && !j.at("ditriglyphic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ditriglyphic") != j.end() && j.at("ditriglyphic").is_null()) throw std::runtime_error("Unexpected null");
        x.ditriglyphic = get_stack_optional<int64_t>(j, "ditriglyphic");
        if (j.find("floriferousness") != j.end() && !j.at("floriferousness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("floriferousness") != j.end() && j.at("floriferousness").is_null()) throw std::runtime_error("Unexpected null");
        x.floriferousness = get_stack_optional<int64_t>(j, "floriferousness");
        if (j.find("gamelike") != j.end() && !j.at("gamelike").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("gamelike") != j.end() && j.at("gamelike").is_null()) throw std::runtime_error("Unexpected null");
        x.gamelike = get_stack_optional<int64_t>(j, "gamelike");
        if (j.find("grig") != j.end() && !j.at("grig").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("grig") != j.end() && j.at("grig").is_null()) throw std::runtime_error("Unexpected null");
        x.grig = get_stack_optional<int64_t>(j, "grig");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("interloan") != j.end() && !j.at("interloan").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("interloan") != j.end() && j.at("interloan").is_null()) throw std::runtime_error("Unexpected null");
        x.interloan = get_stack_optional<int64_t>(j, "interloan");
        if (j.find("lithotomy") != j.end() && !j.at("lithotomy").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lithotomy") != j.end() && j.at("lithotomy").is_null()) throw std::runtime_error("Unexpected null");
        x.lithotomy = get_stack_optional<int64_t>(j, "lithotomy");
        if (j.find("loric") != j.end() && !j.at("loric").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("loric") != j.end() && j.at("loric").is_null()) throw std::runtime_error("Unexpected null");
        x.loric = get_stack_optional<int64_t>(j, "loric");
        if (j.find("membranocoriaceous") != j.end() && !j.at("membranocoriaceous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("membranocoriaceous") != j.end() && j.at("membranocoriaceous").is_null()) throw std::runtime_error("Unexpected null");
        x.membranocoriaceous = get_stack_optional<int64_t>(j, "membranocoriaceous");
        if (j.find("membranogenic") != j.end() && !j.at("membranogenic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("membranogenic") != j.end() && j.at("membranogenic").is_null()) throw std::runtime_error("Unexpected null");
        x.membranogenic = get_stack_optional<int64_t>(j, "membranogenic");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("overtrump") != j.end() && !j.at("overtrump").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("overtrump") != j.end() && j.at("overtrump").is_null()) throw std::runtime_error("Unexpected null");
        x.overtrump = get_stack_optional<int64_t>(j, "overtrump");
        if (j.find("scotino") != j.end() && !j.at("scotino").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("scotino") != j.end() && j.at("scotino").is_null()) throw std::runtime_error("Unexpected null");
        x.scotino = get_stack_optional<int64_t>(j, "scotino");
        if (j.find("seasonable") != j.end() && !j.at("seasonable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("seasonable") != j.end() && j.at("seasonable").is_null()) throw std::runtime_error("Unexpected null");
        x.seasonable = get_stack_optional<int64_t>(j, "seasonable");
        if (j.find("sephen") != j.end() && !j.at("sephen").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sephen") != j.end() && j.at("sephen").is_null()) throw std::runtime_error("Unexpected null");
        x.sephen = get_stack_optional<int64_t>(j, "sephen");
        if (j.find("stigmarioid") != j.end() && !j.at("stigmarioid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("stigmarioid") != j.end() && j.at("stigmarioid").is_null()) throw std::runtime_error("Unexpected null");
        x.stigmarioid = get_stack_optional<int64_t>(j, "stigmarioid");
        if (j.find("tired") != j.end() && !j.at("tired").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tired") != j.end() && j.at("tired").is_null()) throw std::runtime_error("Unexpected null");
        x.tired = get_stack_optional<int64_t>(j, "tired");
        if (j.find("trifid") != j.end() && !j.at("trifid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("trifid") != j.end() && j.at("trifid").is_null()) throw std::runtime_error("Unexpected null");
        x.trifid = get_stack_optional<int64_t>(j, "trifid");
        if (j.find("undefeatedly") != j.end() && !j.at("undefeatedly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("undefeatedly") != j.end() && j.at("undefeatedly").is_null()) throw std::runtime_error("Unexpected null");
        x.undefeatedly = get_stack_optional<int64_t>(j, "undefeatedly");
        if (j.find("ungirlish") != j.end() && !j.at("ungirlish").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ungirlish") != j.end() && j.at("ungirlish").is_null()) throw std::runtime_error("Unexpected null");
        x.ungirlish = get_stack_optional<int64_t>(j, "ungirlish");
    }

    inline void to_json(json & j, const Staghunting & x) {
        j = json::object();
        j["calorimetric"] = x.calorimetric;
        j["canid"] = x.canid;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["ditriglyphic"] = x.ditriglyphic;
        j["floriferousness"] = x.floriferousness;
        j["gamelike"] = x.gamelike;
        j["grig"] = x.grig;
        j["homocerc"] = x.homocerc;
        j["interloan"] = x.interloan;
        j["lithotomy"] = x.lithotomy;
        j["loric"] = x.loric;
        j["membranocoriaceous"] = x.membranocoriaceous;
        j["membranogenic"] = x.membranogenic;
        j["nonbookish"] = x.nonbookish;
        j["overtrump"] = x.overtrump;
        j["scotino"] = x.scotino;
        j["seasonable"] = x.seasonable;
        j["sephen"] = x.sephen;
        j["stigmarioid"] = x.stigmarioid;
        j["tired"] = x.tired;
        j["trifid"] = x.trifid;
        j["undefeatedly"] = x.undefeatedly;
        j["ungirlish"] = x.ungirlish;
    }

    inline void from_json(const json & j, StrenuosityClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bliss") != j.end() && !j.at("bliss").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("bliss") != j.end() && j.at("bliss").is_null()) throw std::runtime_error("Unexpected null");
        x.bliss = get_stack_optional<int64_t>(j, "bliss");
        if (j.find("buccate") != j.end() && !j.at("buccate").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("buccate") != j.end() && j.at("buccate").is_null()) throw std::runtime_error("Unexpected null");
        x.buccate = get_stack_optional<int64_t>(j, "buccate");
        if (j.find("bulletproof") != j.end() && !j.at("bulletproof").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("bulletproof") != j.end() && j.at("bulletproof").is_null()) throw std::runtime_error("Unexpected null");
        x.bulletproof = get_stack_optional<int64_t>(j, "bulletproof");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("crumblingness") != j.end() && !j.at("crumblingness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("crumblingness") != j.end() && j.at("crumblingness").is_null()) throw std::runtime_error("Unexpected null");
        x.crumblingness = get_stack_optional<int64_t>(j, "crumblingness");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("engagedly") != j.end() && !j.at("engagedly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("engagedly") != j.end() && j.at("engagedly").is_null()) throw std::runtime_error("Unexpected null");
        x.engagedly = get_stack_optional<int64_t>(j, "engagedly");
        if (j.find("fightable") != j.end() && !j.at("fightable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("fightable") != j.end() && j.at("fightable").is_null()) throw std::runtime_error("Unexpected null");
        x.fightable = get_stack_optional<int64_t>(j, "fightable");
        if (j.find("hoariness") != j.end() && !j.at("hoariness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hoariness") != j.end() && j.at("hoariness").is_null()) throw std::runtime_error("Unexpected null");
        x.hoariness = get_stack_optional<int64_t>(j, "hoariness");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("hypopodium") != j.end() && !j.at("hypopodium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hypopodium") != j.end() && j.at("hypopodium").is_null()) throw std::runtime_error("Unexpected null");
        x.hypopodium = get_stack_optional<int64_t>(j, "hypopodium");
        if (j.find("luxurist") != j.end() && !j.at("luxurist").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("luxurist") != j.end() && j.at("luxurist").is_null()) throw std::runtime_error("Unexpected null");
        x.luxurist = get_stack_optional<int64_t>(j, "luxurist");
        if (j.find("mechanician") != j.end() && !j.at("mechanician").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mechanician") != j.end() && j.at("mechanician").is_null()) throw std::runtime_error("Unexpected null");
        x.mechanician = get_stack_optional<int64_t>(j, "mechanician");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("Onopordon") != j.end() && !j.at("Onopordon").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Onopordon") != j.end() && j.at("Onopordon").is_null()) throw std::runtime_error("Unexpected null");
        x.onopordon = get_stack_optional<int64_t>(j, "Onopordon");
        if (j.find("podgily") != j.end() && !j.at("podgily").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("podgily") != j.end() && j.at("podgily").is_null()) throw std::runtime_error("Unexpected null");
        x.podgily = get_stack_optional<int64_t>(j, "podgily");
        if (j.find("reformableness") != j.end() && !j.at("reformableness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("reformableness") != j.end() && j.at("reformableness").is_null()) throw std::runtime_error("Unexpected null");
        x.reformableness = get_stack_optional<int64_t>(j, "reformableness");
        if (j.find("scatterbrains") != j.end() && !j.at("scatterbrains").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("scatterbrains") != j.end() && j.at("scatterbrains").is_null()) throw std::runtime_error("Unexpected null");
        x.scatterbrains = get_stack_optional<int64_t>(j, "scatterbrains");
        if (j.find("seminuria") != j.end() && !j.at("seminuria").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("seminuria") != j.end() && j.at("seminuria").is_null()) throw std::runtime_error("Unexpected null");
        x.seminuria = get_stack_optional<int64_t>(j, "seminuria");
        if (j.find("Sodomite") != j.end() && !j.at("Sodomite").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Sodomite") != j.end() && j.at("Sodomite").is_null()) throw std::runtime_error("Unexpected null");
        x.sodomite = get_stack_optional<int64_t>(j, "Sodomite");
        if (j.find("tramp") != j.end() && !j.at("tramp").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tramp") != j.end() && j.at("tramp").is_null()) throw std::runtime_error("Unexpected null");
        x.tramp = get_stack_optional<int64_t>(j, "tramp");
        if (j.find("undueness") != j.end() && !j.at("undueness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("undueness") != j.end() && j.at("undueness").is_null()) throw std::runtime_error("Unexpected null");
        x.undueness = get_stack_optional<int64_t>(j, "undueness");
        if (j.find("worthily") != j.end() && !j.at("worthily").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("worthily") != j.end() && j.at("worthily").is_null()) throw std::runtime_error("Unexpected null");
        x.worthily = get_stack_optional<int64_t>(j, "worthily");
        if (j.find("Yankeeist") != j.end() && !j.at("Yankeeist").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Yankeeist") != j.end() && j.at("Yankeeist").is_null()) throw std::runtime_error("Unexpected null");
        x.yankeeist = get_stack_optional<int64_t>(j, "Yankeeist");
    }

    inline void to_json(json & j, const StrenuosityClass & x) {
        j = json::object();
        j["bliss"] = x.bliss;
        j["buccate"] = x.buccate;
        j["bulletproof"] = x.bulletproof;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["crumblingness"] = x.crumblingness;
        j["disdiapason"] = x.disdiapason;
        j["engagedly"] = x.engagedly;
        j["fightable"] = x.fightable;
        j["hoariness"] = x.hoariness;
        j["homocerc"] = x.homocerc;
        j["hypopodium"] = x.hypopodium;
        j["luxurist"] = x.luxurist;
        j["mechanician"] = x.mechanician;
        j["nonbookish"] = x.nonbookish;
        j["Onopordon"] = x.onopordon;
        j["podgily"] = x.podgily;
        j["reformableness"] = x.reformableness;
        j["scatterbrains"] = x.scatterbrains;
        j["seminuria"] = x.seminuria;
        j["Sodomite"] = x.sodomite;
        j["tramp"] = x.tramp;
        j["undueness"] = x.undueness;
        j["worthily"] = x.worthily;
        j["Yankeeist"] = x.yankeeist;
    }

    inline void from_json(const json & j, TruantcyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.alfiona = get_untyped(j, "alfiona");
        x.ascaridiasis = get_untyped(j, "ascaridiasis");
        x.bungey = get_untyped(j, "bungey");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        x.ceroxyle = get_untyped(j, "ceroxyle");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        x.chorology = get_untyped(j, "chorology");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.enmarble = get_untyped(j, "enmarble");
        x.epeira = get_untyped(j, "Epeira");
        x.eurylaimi = get_untyped(j, "Eurylaimi");
        x.germination = get_untyped(j, "germination");
        x.hallelujah = get_untyped(j, "hallelujah");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.lev = get_untyped(j, "lev");
        x.mouthing = get_untyped(j, "mouthing");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.philliloo = get_untyped(j, "philliloo");
        x.planetal = get_untyped(j, "planetal");
        x.poney = get_untyped(j, "poney");
        x.punctualist = get_untyped(j, "punctualist");
        x.returnlessly = get_untyped(j, "returnlessly");
        x.skelder = get_untyped(j, "skelder");
        x.windwaywardly = get_untyped(j, "windwaywardly");
        x.yuman = get_untyped(j, "Yuman");
    }

    inline void to_json(json & j, const TruantcyClass & x) {
        j = json::object();
        j["alfiona"] = x.alfiona;
        j["ascaridiasis"] = x.ascaridiasis;
        j["bungey"] = x.bungey;
        j["catharticalness"] = x.catharticalness;
        j["ceroxyle"] = x.ceroxyle;
        j["Chirotherium"] = x.chirotherium;
        j["chorology"] = x.chorology;
        j["disdiapason"] = x.disdiapason;
        j["enmarble"] = x.enmarble;
        j["Epeira"] = x.epeira;
        j["Eurylaimi"] = x.eurylaimi;
        j["germination"] = x.germination;
        j["hallelujah"] = x.hallelujah;
        j["homocerc"] = x.homocerc;
        j["lev"] = x.lev;
        j["mouthing"] = x.mouthing;
        j["nonbookish"] = x.nonbookish;
        j["philliloo"] = x.philliloo;
        j["planetal"] = x.planetal;
        j["poney"] = x.poney;
        j["punctualist"] = x.punctualist;
        j["returnlessly"] = x.returnlessly;
        j["skelder"] = x.skelder;
        j["windwaywardly"] = x.windwaywardly;
        j["Yuman"] = x.yuman;
    }

    inline void from_json(const json & j, UnimpeachablyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("acerin") != j.end() && !j.at("acerin").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("acerin") != j.end() && j.at("acerin").is_null()) throw std::runtime_error("Unexpected null");
        x.acerin = get_stack_optional<int64_t>(j, "acerin");
        if (j.find("Bobadil") != j.end() && !j.at("Bobadil").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Bobadil") != j.end() && j.at("Bobadil").is_null()) throw std::runtime_error("Unexpected null");
        x.bobadil = get_stack_optional<int64_t>(j, "Bobadil");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("chlorophylligenous") != j.end() && !j.at("chlorophylligenous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("chlorophylligenous") != j.end() && j.at("chlorophylligenous").is_null()) throw std::runtime_error("Unexpected null");
        x.chlorophylligenous = get_stack_optional<int64_t>(j, "chlorophylligenous");
        if (j.find("conversational") != j.end() && !j.at("conversational").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("conversational") != j.end() && j.at("conversational").is_null()) throw std::runtime_error("Unexpected null");
        x.conversational = get_stack_optional<int64_t>(j, "conversational");
        if (j.find("demiowl") != j.end() && !j.at("demiowl").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("demiowl") != j.end() && j.at("demiowl").is_null()) throw std::runtime_error("Unexpected null");
        x.demiowl = get_stack_optional<int64_t>(j, "demiowl");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("ectorhinal") != j.end() && !j.at("ectorhinal").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ectorhinal") != j.end() && j.at("ectorhinal").is_null()) throw std::runtime_error("Unexpected null");
        x.ectorhinal = get_stack_optional<int64_t>(j, "ectorhinal");
        if (j.find("gamblesomeness") != j.end() && !j.at("gamblesomeness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("gamblesomeness") != j.end() && j.at("gamblesomeness").is_null()) throw std::runtime_error("Unexpected null");
        x.gamblesomeness = get_stack_optional<int64_t>(j, "gamblesomeness");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("irrorate") != j.end() && !j.at("irrorate").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("irrorate") != j.end() && j.at("irrorate").is_null()) throw std::runtime_error("Unexpected null");
        x.irrorate = get_stack_optional<int64_t>(j, "irrorate");
        if (j.find("kindergartening") != j.end() && !j.at("kindergartening").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("kindergartening") != j.end() && j.at("kindergartening").is_null()) throw std::runtime_error("Unexpected null");
        x.kindergartening = get_stack_optional<int64_t>(j, "kindergartening");
        if (j.find("lateritic") != j.end() && !j.at("lateritic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lateritic") != j.end() && j.at("lateritic").is_null()) throw std::runtime_error("Unexpected null");
        x.lateritic = get_stack_optional<int64_t>(j, "lateritic");
        if (j.find("mespil") != j.end() && !j.at("mespil").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mespil") != j.end() && j.at("mespil").is_null()) throw std::runtime_error("Unexpected null");
        x.mespil = get_stack_optional<int64_t>(j, "mespil");
        if (j.find("misconfiguration") != j.end() && !j.at("misconfiguration").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("misconfiguration") != j.end() && j.at("misconfiguration").is_null()) throw std::runtime_error("Unexpected null");
        x.misconfiguration = get_stack_optional<int64_t>(j, "misconfiguration");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("planometry") != j.end() && !j.at("planometry").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("planometry") != j.end() && j.at("planometry").is_null()) throw std::runtime_error("Unexpected null");
        x.planometry = get_stack_optional<int64_t>(j, "planometry");
        if (j.find("Quiina") != j.end() && !j.at("Quiina").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Quiina") != j.end() && j.at("Quiina").is_null()) throw std::runtime_error("Unexpected null");
        x.quiina = get_stack_optional<int64_t>(j, "Quiina");
        if (j.find("Robert") != j.end() && !j.at("Robert").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Robert") != j.end() && j.at("Robert").is_null()) throw std::runtime_error("Unexpected null");
        x.robert = get_stack_optional<int64_t>(j, "Robert");
        if (j.find("rot") != j.end() && !j.at("rot").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("rot") != j.end() && j.at("rot").is_null()) throw std::runtime_error("Unexpected null");
        x.rot = get_stack_optional<int64_t>(j, "rot");
        if (j.find("subcinctorium") != j.end() && !j.at("subcinctorium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("subcinctorium") != j.end() && j.at("subcinctorium").is_null()) throw std::runtime_error("Unexpected null");
        x.subcinctorium = get_stack_optional<int64_t>(j, "subcinctorium");
        if (j.find("tussocker") != j.end() && !j.at("tussocker").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("tussocker") != j.end() && j.at("tussocker").is_null()) throw std::runtime_error("Unexpected null");
        x.tussocker = get_stack_optional<int64_t>(j, "tussocker");
        if (j.find("ultraproud") != j.end() && !j.at("ultraproud").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ultraproud") != j.end() && j.at("ultraproud").is_null()) throw std::runtime_error("Unexpected null");
        x.ultraproud = get_stack_optional<int64_t>(j, "ultraproud");
        if (j.find("unsuggestedness") != j.end() && !j.at("unsuggestedness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unsuggestedness") != j.end() && j.at("unsuggestedness").is_null()) throw std::runtime_error("Unexpected null");
        x.unsuggestedness = get_stack_optional<int64_t>(j, "unsuggestedness");
    }

    inline void to_json(json & j, const UnimpeachablyClass & x) {
        j = json::object();
        j["acerin"] = x.acerin;
        j["Bobadil"] = x.bobadil;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["chlorophylligenous"] = x.chlorophylligenous;
        j["conversational"] = x.conversational;
        j["demiowl"] = x.demiowl;
        j["disdiapason"] = x.disdiapason;
        j["ectorhinal"] = x.ectorhinal;
        j["gamblesomeness"] = x.gamblesomeness;
        j["homocerc"] = x.homocerc;
        j["irrorate"] = x.irrorate;
        j["kindergartening"] = x.kindergartening;
        j["lateritic"] = x.lateritic;
        j["mespil"] = x.mespil;
        j["misconfiguration"] = x.misconfiguration;
        j["nonbookish"] = x.nonbookish;
        j["planometry"] = x.planometry;
        j["Quiina"] = x.quiina;
        j["Robert"] = x.robert;
        j["rot"] = x.rot;
        j["subcinctorium"] = x.subcinctorium;
        j["tussocker"] = x.tussocker;
        j["ultraproud"] = x.ultraproud;
        j["unsuggestedness"] = x.unsuggestedness;
    }

    inline void from_json(const json & j, UnstressedClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.alain = get_untyped(j, "Alain");
        x.amphirhina = get_untyped(j, "Amphirhina");
        x.antimachinery = get_untyped(j, "antimachinery");
        x.coldish = get_untyped(j, "coldish");
        x.crantara = get_untyped(j, "crantara");
        x.distinguishing = get_untyped(j, "distinguishing");
        x.elytroposis = get_untyped(j, "elytroposis");
        x.gentianwort = get_untyped(j, "gentianwort");
        x.heliosis = get_untyped(j, "heliosis");
        x.instrumental = get_untyped(j, "instrumental");
        x.introinflection = get_untyped(j, "introinflection");
        x.kala = get_untyped(j, "kala");
        x.lincolnian = get_untyped(j, "Lincolnian");
        x.metad = get_untyped(j, "metad");
        x.sarcophilus = get_untyped(j, "Sarcophilus");
        x.swingingly = get_untyped(j, "swingingly");
        x.unconformity = get_untyped(j, "unconformity");
        x.undecreed = get_untyped(j, "undecreed");
        x.venerable = get_untyped(j, "venerable");
        x.vowellessness = get_untyped(j, "vowellessness");
    }

    inline void to_json(json & j, const UnstressedClass & x) {
        j = json::object();
        j["Alain"] = x.alain;
        j["Amphirhina"] = x.amphirhina;
        j["antimachinery"] = x.antimachinery;
        j["coldish"] = x.coldish;
        j["crantara"] = x.crantara;
        j["distinguishing"] = x.distinguishing;
        j["elytroposis"] = x.elytroposis;
        j["gentianwort"] = x.gentianwort;
        j["heliosis"] = x.heliosis;
        j["instrumental"] = x.instrumental;
        j["introinflection"] = x.introinflection;
        j["kala"] = x.kala;
        j["Lincolnian"] = x.lincolnian;
        j["metad"] = x.metad;
        j["Sarcophilus"] = x.sarcophilus;
        j["swingingly"] = x.swingingly;
        j["unconformity"] = x.unconformity;
        j["undecreed"] = x.undecreed;
        j["venerable"] = x.venerable;
        j["vowellessness"] = x.vowellessness;
    }

    inline void from_json(const json & j, WrothyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.aeschynanthus = get_untyped(j, "Aeschynanthus");
        x.aquiferous = get_untyped(j, "aquiferous");
        x.cheapener = get_untyped(j, "cheapener");
        x.enumeration = get_untyped(j, "enumeration");
        x.ephesine = get_untyped(j, "Ephesine");
        x.escadrille = get_untyped(j, "escadrille");
        x.estrous = get_untyped(j, "estrous");
        x.interestedly = get_untyped(j, "interestedly");
        x.katakinetomer = get_untyped(j, "katakinetomer");
        x.mortification = get_untyped(j, "mortification");
        x.morula = get_untyped(j, "morula");
        x.orthosymmetrical = get_untyped(j, "orthosymmetrical");
        x.overbark = get_untyped(j, "overbark");
        x.politist = get_untyped(j, "politist");
        x.qualified = get_untyped(j, "qualified");
        x.sphenomalar = get_untyped(j, "sphenomalar");
        x.throatful = get_untyped(j, "throatful");
        x.transhumance = get_untyped(j, "transhumance");
        x.triandrian = get_untyped(j, "triandrian");
        x.unbooked = get_untyped(j, "unbooked");
    }

    inline void to_json(json & j, const WrothyClass & x) {
        j = json::object();
        j["Aeschynanthus"] = x.aeschynanthus;
        j["aquiferous"] = x.aquiferous;
        j["cheapener"] = x.cheapener;
        j["enumeration"] = x.enumeration;
        j["Ephesine"] = x.ephesine;
        j["escadrille"] = x.escadrille;
        j["estrous"] = x.estrous;
        j["interestedly"] = x.interestedly;
        j["katakinetomer"] = x.katakinetomer;
        j["mortification"] = x.mortification;
        j["morula"] = x.morula;
        j["orthosymmetrical"] = x.orthosymmetrical;
        j["overbark"] = x.overbark;
        j["politist"] = x.politist;
        j["qualified"] = x.qualified;
        j["sphenomalar"] = x.sphenomalar;
        j["throatful"] = x.throatful;
        j["transhumance"] = x.transhumance;
        j["triandrian"] = x.triandrian;
        j["unbooked"] = x.unbooked;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.protrusive = j.at("protrusive").get<std::vector<Protrusive>>();
        x.pulpitism = j.at("pulpitism").get<std::vector<PulpitismElement>>();
        x.pyodermia = j.at("pyodermia").get<std::vector<PyodermiaElement>>();
        x.quebrachine = j.at("quebrachine").get<std::vector<QuebrachineElement>>();
        x.querier = j.at("querier").get<std::vector<Querier>>();
        x.rebarbative = j.at("rebarbative").get<std::vector<Rebarbative>>();
        x.reimagine = j.at("reimagine").get<std::vector<Reimagine>>();
        x.ressaut = j.at("ressaut").get<Ressaut>();
        x.retrocervical = j.at("retrocervical").get<std::vector<Retrocervical>>();
        x.revert = j.at("revert").get<std::vector<Revert>>();
        x.rewrite = j.at("rewrite").get<std::vector<RewriteElement>>();
        x.saccoderm = j.at("saccoderm").get<std::vector<Saccoderm>>();
        x.santir = j.at("santir").get<std::vector<SantirElement>>();
        x.saprophilous = j.at("saprophilous").get<std::vector<Saprophilous>>();
        x.saxten = j.at("saxten").get<std::vector<SaxtenElement>>();
        x.scatty = j.at("scatty").get<std::vector<std::optional<Scatty>>>();
        x.scoffer = j.at("scoffer").get<std::vector<Scoffer>>();
        x.scrampum = j.at("scrampum").get<std::vector<Scrampum>>();
        x.semantic = j.at("semantic").get<double>();
        x.serpentinic = j.at("serpentinic").get<std::vector<Serpentinic>>();
        x.shadowable = j.at("shadowable").get<std::vector<Shadowable>>();
        x.sistering = j.at("sistering").get<std::vector<SisteringElement>>();
        x.staghunting = j.at("staghunting").get<std::vector<Staghunting>>();
        x.stagmometer = j.at("stagmometer").get<std::vector<Stagmometer>>();
        x.stimulability = j.at("stimulability").get<std::vector<Stimulability>>();
        x.strangleable = j.at("strangleable").get<std::vector<Strangleable>>();
        x.strenuosity = j.at("strenuosity").get<std::vector<StrenuosityElement>>();
        x.tabaxir = j.at("tabaxir").get<std::vector<Tabaxir>>();
        x.talpiform = j.at("talpiform").get<std::vector<Talpiform>>();
        x.thwack = j.at("thwack").get<std::vector<Thwack>>();
        x.to = j.at("to").get<std::vector<std::optional<double>>>();
        x.tortricine = j.at("tortricine").get<std::vector<Tortricine>>();
        x.truantcy = j.at("truantcy").get<std::vector<TruantcyElement>>();
        x.turgesce = j.at("turgesce").get<std::vector<std::string>>();
        x.unbeginning = j.at("unbeginning").get<std::vector<Unbeginning>>();
        x.underdunged = j.at("underdunged").get<std::vector<double>>();
        x.undesirability = j.at("undesirability").get<std::vector<Undesirability>>();
        x.unerasing = j.at("unerasing").get<std::vector<Unerasing>>();
        x.unguentarium = j.at("unguentarium").get<std::vector<Unguentarium>>();
        x.unimpeachably = j.at("unimpeachably").get<std::vector<UnimpeachablyElement>>();
        x.unmortgaged = j.at("unmortgaged").get<std::vector<Unmortgaged>>();
        x.unobstructed = j.at("unobstructed").get<std::vector<Unobstructed>>();
        x.unreceptivity = j.at("unreceptivity").get<std::vector<Unreceptivity>>();
        x.unsatisfactoriness = j.at("unsatisfactoriness").get<std::vector<Unsatisfactoriness>>();
        x.unsecurity = j.at("unsecurity").get<std::vector<int64_t>>();
        x.unstressed = j.at("unstressed").get<std::vector<UnstressedElement>>();
        x.untasked = j.at("untasked").get<std::vector<Untasked>>();
        x.unvarying = j.at("unvarying").get<std::vector<Unvarying>>();
        x.vehemently = j.at("vehemently").get<std::vector<Vehemently>>();
        x.warriorship = j.at("warriorship").get<std::map<std::string, bool>>();
        x.whitepot = j.at("whitepot").get<std::vector<Whitepot>>();
        x.wrothy = j.at("wrothy").get<std::vector<WrothyElement>>();
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["protrusive"] = x.protrusive;
        j["pulpitism"] = x.pulpitism;
        j["pyodermia"] = x.pyodermia;
        j["quebrachine"] = x.quebrachine;
        j["querier"] = x.querier;
        j["rebarbative"] = x.rebarbative;
        j["reimagine"] = x.reimagine;
        j["ressaut"] = x.ressaut;
        j["retrocervical"] = x.retrocervical;
        j["revert"] = x.revert;
        j["rewrite"] = x.rewrite;
        j["saccoderm"] = x.saccoderm;
        j["santir"] = x.santir;
        j["saprophilous"] = x.saprophilous;
        j["saxten"] = x.saxten;
        j["scatty"] = x.scatty;
        j["scoffer"] = x.scoffer;
        j["scrampum"] = x.scrampum;
        j["semantic"] = x.semantic;
        j["serpentinic"] = x.serpentinic;
        j["shadowable"] = x.shadowable;
        j["sistering"] = x.sistering;
        j["staghunting"] = x.staghunting;
        j["stagmometer"] = x.stagmometer;
        j["stimulability"] = x.stimulability;
        j["strangleable"] = x.strangleable;
        j["strenuosity"] = x.strenuosity;
        j["tabaxir"] = x.tabaxir;
        j["talpiform"] = x.talpiform;
        j["thwack"] = x.thwack;
        j["to"] = x.to;
        j["tortricine"] = x.tortricine;
        j["truantcy"] = x.truantcy;
        j["turgesce"] = x.turgesce;
        j["unbeginning"] = x.unbeginning;
        j["underdunged"] = x.underdunged;
        j["undesirability"] = x.undesirability;
        j["unerasing"] = x.unerasing;
        j["unguentarium"] = x.unguentarium;
        j["unimpeachably"] = x.unimpeachably;
        j["unmortgaged"] = x.unmortgaged;
        j["unobstructed"] = x.unobstructed;
        j["unreceptivity"] = x.unreceptivity;
        j["unsatisfactoriness"] = x.unsatisfactoriness;
        j["unsecurity"] = x.unsecurity;
        j["unstressed"] = x.unstressed;
        j["untasked"] = x.untasked;
        j["unvarying"] = x.unvarying;
        j["vehemently"] = x.vehemently;
        j["warriorship"] = x.warriorship;
        j["whitepot"] = x.whitepot;
        j["wrothy"] = x.wrothy;
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
