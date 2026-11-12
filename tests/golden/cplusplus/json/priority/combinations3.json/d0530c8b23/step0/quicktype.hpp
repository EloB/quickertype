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

    struct JurorClass {
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
    };

    using JurorElement = std::variant<bool, JurorClass>;

    using Kongoni = std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>;

    struct LadronismClass {
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
    };

    using LadronismElement = std::variant<LadronismClass, double, std::string>;

    struct LandlubberlyClass {
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
    };

    using LandlubberlyElement = std::variant<bool, LandlubberlyClass, int64_t>;

    using Listener = std::variant<std::vector<nlohmann::json>, int64_t>;

    struct LupusClass {
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
    };

    using LupusElement = std::variant<LupusClass, int64_t>;

    struct Maslin {
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
    };

    struct MonaziteClass {
        double catharticalness;
        int64_t chirotherium;
        std::string disdiapason;
        bool homocerc;
        nlohmann::json nonbookish;
    };

    using MonaziteElement = std::variant<MonaziteClass, double>;

    using Monoliteral = std::variant<std::vector<nlohmann::json>, bool>;

    struct MonotheisticallyClass {
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
    };

    using MonotheisticallyElement = std::variant<std::vector<nlohmann::json>, MonotheisticallyClass>;

    using Montage = std::variant<std::vector<nlohmann::json>, double, std::string>;

    using Moralness = std::optional<std::variant<std::vector<nlohmann::json>, double>>;

    using Mulishly = std::optional<std::variant<std::vector<int64_t>, double>>;

    using Myoscope = std::variant<std::vector<nlohmann::json>, bool, int64_t>;

    using Neuromastic = std::variant<std::vector<nlohmann::json>, double>;

    struct Noncontributing {
        std::string estevin;
        double jolterhead;
        int64_t sauternes;
        bool sparsely;
        nlohmann::json unrequested;
    };

    using Nonnervous = std::variant<bool, int64_t>;

    using Nonvaluation = std::variant<std::vector<nlohmann::json>, bool, double>;

    struct OccupationalistClass {
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
    };

    using OccupationalistElement = std::optional<std::variant<std::vector<nlohmann::json>, OccupationalistClass>>;

    struct OutrivalClass {
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
    };

    using OutrivalElement = std::optional<std::variant<OutrivalClass, double>>;

    using Paleographically = std::variant<double, std::map<std::string, std::optional<int64_t>>>;

    using Pamphletwise = std::variant<int64_t, std::map<std::string, int64_t>, std::string>;

    using Pediatric = std::optional<std::variant<bool, double>>;

    struct PiaculumClass {
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
    };

    using PiaculumElement = std::variant<PiaculumClass, double>;

    using Piccadilly = std::optional<std::variant<double, std::string>>;

    using Piffler = std::variant<std::vector<nlohmann::json>, MonaziteClass>;

    using Pithful = std::optional<std::variant<bool, int64_t>>;

    using Placuntiti = std::variant<int64_t, std::map<std::string, int64_t>>;

    using Plectopterous = std::variant<double, std::map<std::string, int64_t>>;

    struct Pneumocele {
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
    };

    using Poliorcetic = std::variant<bool, MonaziteClass>;

    using Poormaster = std::optional<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>>;

    struct PotwhiskyClass {
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
    };

    using PotwhiskyElement = std::optional<std::variant<PotwhiskyClass, int64_t>>;

    using Practicalizer = std::variant<std::vector<nlohmann::json>, MonaziteClass, std::string>;

    struct PrefreshmanClass {
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
    };

    using PrefreshmanElement = std::variant<std::vector<nlohmann::json>, PrefreshmanClass, std::string>;

    using Prehensility = std::variant<std::vector<nlohmann::json>, bool, MonaziteClass>;

    using Prevoidance = std::variant<std::vector<int64_t>, MonaziteClass, int64_t>;

    using Protext = std::variant<std::vector<int64_t>, bool, MonaziteClass>;

    struct TopLevel {
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
    };
}

namespace quicktype {
void from_json(const json & j, JurorClass & x);
void to_json(json & j, const JurorClass & x);

void from_json(const json & j, LadronismClass & x);
void to_json(json & j, const LadronismClass & x);

void from_json(const json & j, LandlubberlyClass & x);
void to_json(json & j, const LandlubberlyClass & x);

void from_json(const json & j, LupusClass & x);
void to_json(json & j, const LupusClass & x);

void from_json(const json & j, Maslin & x);
void to_json(json & j, const Maslin & x);

void from_json(const json & j, MonaziteClass & x);
void to_json(json & j, const MonaziteClass & x);

void from_json(const json & j, MonotheisticallyClass & x);
void to_json(json & j, const MonotheisticallyClass & x);

void from_json(const json & j, Noncontributing & x);
void to_json(json & j, const Noncontributing & x);

void from_json(const json & j, OccupationalistClass & x);
void to_json(json & j, const OccupationalistClass & x);

void from_json(const json & j, OutrivalClass & x);
void to_json(json & j, const OutrivalClass & x);

void from_json(const json & j, PiaculumClass & x);
void to_json(json & j, const PiaculumClass & x);

void from_json(const json & j, Pneumocele & x);
void to_json(json & j, const Pneumocele & x);

void from_json(const json & j, PotwhiskyClass & x);
void to_json(json & j, const PotwhiskyClass & x);

void from_json(const json & j, PrefreshmanClass & x);
void to_json(json & j, const PrefreshmanClass & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<bool, quicktype::JurorClass>> {
    static void from_json(const json & j, std::variant<bool, quicktype::JurorClass> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::JurorClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LadronismClass, double, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::LadronismClass, double, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::LadronismClass, double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::LandlubberlyClass, int64_t>> {
    static void from_json(const json & j, std::variant<bool, quicktype::LandlubberlyClass, int64_t> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::LandlubberlyClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<json>, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::LupusClass, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::LupusClass, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::LupusClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::MonaziteClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::MonaziteClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::MonaziteClass, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::MonotheisticallyClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::MonotheisticallyClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::MonotheisticallyClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, double, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, double>> {
    static void from_json(const json & j, std::variant<std::vector<json>, double> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, double>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, double> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<bool, int64_t>> {
    static void from_json(const json & j, std::variant<bool, int64_t> & x);
    static void to_json(json & j, const std::variant<bool, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, double>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, double> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::OccupationalistClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::OccupationalistClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::OccupationalistClass> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::OutrivalClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::OutrivalClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::OutrivalClass, double> & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, std::optional<int64_t>>>> {
    static void from_json(const json & j, std::variant<double, std::map<std::string, std::optional<int64_t>>> & x);
    static void to_json(json & j, const std::variant<double, std::map<std::string, std::optional<int64_t>>> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>, std::string>> {
    static void from_json(const json & j, std::variant<int64_t, std::map<std::string, int64_t>, std::string> & x);
    static void to_json(json & j, const std::variant<int64_t, std::map<std::string, int64_t>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(const json & j, std::variant<bool, double> & x);
    static void to_json(json & j, const std::variant<bool, double> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PiaculumClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::PiaculumClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::PiaculumClass, double> & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(const json & j, std::variant<double, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::MonaziteClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::MonaziteClass> & x);
};

template <>
struct adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<int64_t, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<int64_t, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<double, std::map<std::string, int64_t>>> {
    static void from_json(const json & j, std::variant<double, std::map<std::string, int64_t>> & x);
    static void to_json(json & j, const std::variant<double, std::map<std::string, int64_t>> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::MonaziteClass>> {
    static void from_json(const json & j, std::variant<bool, quicktype::MonaziteClass> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::MonaziteClass> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PotwhiskyClass, int64_t>> {
    static void from_json(const json & j, std::variant<quicktype::PotwhiskyClass, int64_t> & x);
    static void to_json(json & j, const std::variant<quicktype::PotwhiskyClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<json>, bool, quicktype::MonaziteClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::MonaziteClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::MonaziteClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass>> {
    static void from_json(const json & j, std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> & x);
    static void to_json(json & j, const std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, JurorClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.adipsy = get_untyped(j, "adipsy");
        x.auxiliator = get_untyped(j, "auxiliator");
        x.benda = get_untyped(j, "benda");
        x.benjamin = get_untyped(j, "benjamin");
        x.brandling = get_untyped(j, "brandling");
        x.epicurishly = get_untyped(j, "epicurishly");
        x.eremochaetous = get_untyped(j, "eremochaetous");
        x.marten = get_untyped(j, "marten");
        x.monocline = get_untyped(j, "monocline");
        x.olea = get_untyped(j, "Olea");
        x.palgat = get_untyped(j, "palgat");
        x.pennyworth = get_untyped(j, "pennyworth");
        x.pioury = get_untyped(j, "pioury");
        x.pragmatistic = get_untyped(j, "pragmatistic");
        x.stylelessness = get_untyped(j, "stylelessness");
        x.systematical = get_untyped(j, "systematical");
        x.thready = get_untyped(j, "thready");
        x.uncontemporary = get_untyped(j, "uncontemporary");
        x.uncouched = get_untyped(j, "uncouched");
        x.uninhabitedness = get_untyped(j, "uninhabitedness");
    }

    inline void to_json(json & j, const JurorClass & x) {
        j = json::object();
        j["adipsy"] = x.adipsy;
        j["auxiliator"] = x.auxiliator;
        j["benda"] = x.benda;
        j["benjamin"] = x.benjamin;
        j["brandling"] = x.brandling;
        j["epicurishly"] = x.epicurishly;
        j["eremochaetous"] = x.eremochaetous;
        j["marten"] = x.marten;
        j["monocline"] = x.monocline;
        j["Olea"] = x.olea;
        j["palgat"] = x.palgat;
        j["pennyworth"] = x.pennyworth;
        j["pioury"] = x.pioury;
        j["pragmatistic"] = x.pragmatistic;
        j["stylelessness"] = x.stylelessness;
        j["systematical"] = x.systematical;
        j["thready"] = x.thready;
        j["uncontemporary"] = x.uncontemporary;
        j["uncouched"] = x.uncouched;
        j["uninhabitedness"] = x.uninhabitedness;
    }

    inline void from_json(const json & j, LadronismClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.acclaimer = get_untyped(j, "acclaimer");
        x.achree = get_untyped(j, "achree");
        x.base = get_untyped(j, "base");
        x.conundrumize = get_untyped(j, "conundrumize");
        x.degerminator = get_untyped(j, "degerminator");
        x.describable = get_untyped(j, "describable");
        x.exasperatedly = get_untyped(j, "exasperatedly");
        x.heroine = get_untyped(j, "heroine");
        x.indazin = get_untyped(j, "indazin");
        x.luteous = get_untyped(j, "luteous");
        x.papular = get_untyped(j, "papular");
        x.pritch = get_untyped(j, "pritch");
        x.prodenia = get_untyped(j, "Prodenia");
        x.seege = get_untyped(j, "seege");
        x.shopgirl = get_untyped(j, "shopgirl");
        x.tragedietta = get_untyped(j, "tragedietta");
        x.unsparse = get_untyped(j, "unsparse");
        x.uplook = get_untyped(j, "uplook");
        x.vermiformis = get_untyped(j, "vermiformis");
        x.whafabout = get_untyped(j, "whafabout");
    }

    inline void to_json(json & j, const LadronismClass & x) {
        j = json::object();
        j["acclaimer"] = x.acclaimer;
        j["achree"] = x.achree;
        j["base"] = x.base;
        j["conundrumize"] = x.conundrumize;
        j["degerminator"] = x.degerminator;
        j["describable"] = x.describable;
        j["exasperatedly"] = x.exasperatedly;
        j["heroine"] = x.heroine;
        j["indazin"] = x.indazin;
        j["luteous"] = x.luteous;
        j["papular"] = x.papular;
        j["pritch"] = x.pritch;
        j["Prodenia"] = x.prodenia;
        j["seege"] = x.seege;
        j["shopgirl"] = x.shopgirl;
        j["tragedietta"] = x.tragedietta;
        j["unsparse"] = x.unsparse;
        j["uplook"] = x.uplook;
        j["vermiformis"] = x.vermiformis;
        j["whafabout"] = x.whafabout;
    }

    inline void from_json(const json & j, LandlubberlyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.acropoleis = get_untyped(j, "acropoleis");
        x.aminate = get_untyped(j, "aminate");
        x.amyraldism = get_untyped(j, "Amyraldism");
        x.bipenniform = get_untyped(j, "bipenniform");
        x.bugre = get_untyped(j, "bugre");
        x.calycule = get_untyped(j, "calycule");
        x.caoutchouc = get_untyped(j, "caoutchouc");
        x.disprover = get_untyped(j, "disprover");
        x.fitroot = get_untyped(j, "fitroot");
        x.fulgently = get_untyped(j, "fulgently");
        x.kickup = get_untyped(j, "kickup");
        x.laevoversion = get_untyped(j, "laevoversion");
        x.moter = get_untyped(j, "moter");
        x.objectivity = get_untyped(j, "objectivity");
        x.posterity = get_untyped(j, "posterity");
        x.postnuptial = get_untyped(j, "postnuptial");
        x.precedentary = get_untyped(j, "precedentary");
        x.saddling = get_untyped(j, "saddling");
        x.subcurrent = get_untyped(j, "subcurrent");
        x.unrecriminative = get_untyped(j, "unrecriminative");
    }

    inline void to_json(json & j, const LandlubberlyClass & x) {
        j = json::object();
        j["acropoleis"] = x.acropoleis;
        j["aminate"] = x.aminate;
        j["Amyraldism"] = x.amyraldism;
        j["bipenniform"] = x.bipenniform;
        j["bugre"] = x.bugre;
        j["calycule"] = x.calycule;
        j["caoutchouc"] = x.caoutchouc;
        j["disprover"] = x.disprover;
        j["fitroot"] = x.fitroot;
        j["fulgently"] = x.fulgently;
        j["kickup"] = x.kickup;
        j["laevoversion"] = x.laevoversion;
        j["moter"] = x.moter;
        j["objectivity"] = x.objectivity;
        j["posterity"] = x.posterity;
        j["postnuptial"] = x.postnuptial;
        j["precedentary"] = x.precedentary;
        j["saddling"] = x.saddling;
        j["subcurrent"] = x.subcurrent;
        j["unrecriminative"] = x.unrecriminative;
    }

    inline void from_json(const json & j, LupusClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("Chlorioninae") != j.end() && !j.at("Chlorioninae").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chlorioninae") != j.end() && j.at("Chlorioninae").is_null()) throw std::runtime_error("Unexpected null");
        x.chlorioninae = get_stack_optional<int64_t>(j, "Chlorioninae");
        if (j.find("Corvinae") != j.end() && !j.at("Corvinae").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Corvinae") != j.end() && j.at("Corvinae").is_null()) throw std::runtime_error("Unexpected null");
        x.corvinae = get_stack_optional<int64_t>(j, "Corvinae");
        if (j.find("Crassina") != j.end() && !j.at("Crassina").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Crassina") != j.end() && j.at("Crassina").is_null()) throw std::runtime_error("Unexpected null");
        x.crassina = get_stack_optional<int64_t>(j, "Crassina");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("exiguity") != j.end() && !j.at("exiguity").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("exiguity") != j.end() && j.at("exiguity").is_null()) throw std::runtime_error("Unexpected null");
        x.exiguity = get_stack_optional<int64_t>(j, "exiguity");
        if (j.find("farcist") != j.end() && !j.at("farcist").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("farcist") != j.end() && j.at("farcist").is_null()) throw std::runtime_error("Unexpected null");
        x.farcist = get_stack_optional<int64_t>(j, "farcist");
        if (j.find("holographical") != j.end() && !j.at("holographical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("holographical") != j.end() && j.at("holographical").is_null()) throw std::runtime_error("Unexpected null");
        x.holographical = get_stack_optional<int64_t>(j, "holographical");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("ichthyophagan") != j.end() && !j.at("ichthyophagan").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ichthyophagan") != j.end() && j.at("ichthyophagan").is_null()) throw std::runtime_error("Unexpected null");
        x.ichthyophagan = get_stack_optional<int64_t>(j, "ichthyophagan");
        if (j.find("implacable") != j.end() && !j.at("implacable").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("implacable") != j.end() && j.at("implacable").is_null()) throw std::runtime_error("Unexpected null");
        x.implacable = get_stack_optional<int64_t>(j, "implacable");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("outshiner") != j.end() && !j.at("outshiner").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("outshiner") != j.end() && j.at("outshiner").is_null()) throw std::runtime_error("Unexpected null");
        x.outshiner = get_stack_optional<int64_t>(j, "outshiner");
        if (j.find("overweather") != j.end() && !j.at("overweather").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("overweather") != j.end() && j.at("overweather").is_null()) throw std::runtime_error("Unexpected null");
        x.overweather = get_stack_optional<int64_t>(j, "overweather");
        if (j.find("protonegroid") != j.end() && !j.at("protonegroid").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("protonegroid") != j.end() && j.at("protonegroid").is_null()) throw std::runtime_error("Unexpected null");
        x.protonegroid = get_stack_optional<int64_t>(j, "protonegroid");
        if (j.find("shallowish") != j.end() && !j.at("shallowish").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("shallowish") != j.end() && j.at("shallowish").is_null()) throw std::runtime_error("Unexpected null");
        x.shallowish = get_stack_optional<int64_t>(j, "shallowish");
        if (j.find("snoke") != j.end() && !j.at("snoke").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("snoke") != j.end() && j.at("snoke").is_null()) throw std::runtime_error("Unexpected null");
        x.snoke = get_stack_optional<int64_t>(j, "snoke");
        if (j.find("snout") != j.end() && !j.at("snout").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("snout") != j.end() && j.at("snout").is_null()) throw std::runtime_error("Unexpected null");
        x.snout = get_stack_optional<int64_t>(j, "snout");
        if (j.find("surveillance") != j.end() && !j.at("surveillance").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("surveillance") != j.end() && j.at("surveillance").is_null()) throw std::runtime_error("Unexpected null");
        x.surveillance = get_stack_optional<int64_t>(j, "surveillance");
        if (j.find("threshingtime") != j.end() && !j.at("threshingtime").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("threshingtime") != j.end() && j.at("threshingtime").is_null()) throw std::runtime_error("Unexpected null");
        x.threshingtime = get_stack_optional<int64_t>(j, "threshingtime");
        if (j.find("Thysanocarpus") != j.end() && !j.at("Thysanocarpus").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Thysanocarpus") != j.end() && j.at("Thysanocarpus").is_null()) throw std::runtime_error("Unexpected null");
        x.thysanocarpus = get_stack_optional<int64_t>(j, "Thysanocarpus");
        if (j.find("unsignificantly") != j.end() && !j.at("unsignificantly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unsignificantly") != j.end() && j.at("unsignificantly").is_null()) throw std::runtime_error("Unexpected null");
        x.unsignificantly = get_stack_optional<int64_t>(j, "unsignificantly");
        if (j.find("unsnap") != j.end() && !j.at("unsnap").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unsnap") != j.end() && j.at("unsnap").is_null()) throw std::runtime_error("Unexpected null");
        x.unsnap = get_stack_optional<int64_t>(j, "unsnap");
        if (j.find("vendible") != j.end() && !j.at("vendible").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("vendible") != j.end() && j.at("vendible").is_null()) throw std::runtime_error("Unexpected null");
        x.vendible = get_stack_optional<int64_t>(j, "vendible");
    }

    inline void to_json(json & j, const LupusClass & x) {
        j = json::object();
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["Chlorioninae"] = x.chlorioninae;
        j["Corvinae"] = x.corvinae;
        j["Crassina"] = x.crassina;
        j["disdiapason"] = x.disdiapason;
        j["exiguity"] = x.exiguity;
        j["farcist"] = x.farcist;
        j["holographical"] = x.holographical;
        j["homocerc"] = x.homocerc;
        j["ichthyophagan"] = x.ichthyophagan;
        j["implacable"] = x.implacable;
        j["nonbookish"] = x.nonbookish;
        j["outshiner"] = x.outshiner;
        j["overweather"] = x.overweather;
        j["protonegroid"] = x.protonegroid;
        j["shallowish"] = x.shallowish;
        j["snoke"] = x.snoke;
        j["snout"] = x.snout;
        j["surveillance"] = x.surveillance;
        j["threshingtime"] = x.threshingtime;
        j["Thysanocarpus"] = x.thysanocarpus;
        j["unsignificantly"] = x.unsignificantly;
        j["unsnap"] = x.unsnap;
        j["vendible"] = x.vendible;
    }

    inline void from_json(const json & j, Maslin& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("Alicant") != j.end() && !j.at("Alicant").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Alicant") != j.end() && j.at("Alicant").is_null()) throw std::runtime_error("Unexpected null");
        x.alicant = get_stack_optional<int64_t>(j, "Alicant");
        x.antiatonement = get_untyped(j, "antiatonement");
        if (j.find("anticorrosive") != j.end() && !j.at("anticorrosive").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("anticorrosive") != j.end() && j.at("anticorrosive").is_null()) throw std::runtime_error("Unexpected null");
        x.anticorrosive = get_stack_optional<int64_t>(j, "anticorrosive");
        x.aphidozer = get_untyped(j, "aphidozer");
        x.bakuninist = get_untyped(j, "Bakuninist");
        if (j.find("be") != j.end() && !j.at("be").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("be") != j.end() && j.at("be").is_null()) throw std::runtime_error("Unexpected null");
        x.be = get_stack_optional<int64_t>(j, "be");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("chub") != j.end() && !j.at("chub").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("chub") != j.end() && j.at("chub").is_null()) throw std::runtime_error("Unexpected null");
        x.chub = get_stack_optional<int64_t>(j, "chub");
        if (j.find("cuprosilicon") != j.end() && !j.at("cuprosilicon").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("cuprosilicon") != j.end() && j.at("cuprosilicon").is_null()) throw std::runtime_error("Unexpected null");
        x.cuprosilicon = get_stack_optional<int64_t>(j, "cuprosilicon");
        if (j.find("curtailedly") != j.end() && !j.at("curtailedly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("curtailedly") != j.end() && j.at("curtailedly").is_null()) throw std::runtime_error("Unexpected null");
        x.curtailedly = get_stack_optional<int64_t>(j, "curtailedly");
        if (j.find("dellenite") != j.end() && !j.at("dellenite").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("dellenite") != j.end() && j.at("dellenite").is_null()) throw std::runtime_error("Unexpected null");
        x.dellenite = get_stack_optional<int64_t>(j, "dellenite");
        if (j.find("Dimitry") != j.end() && !j.at("Dimitry").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Dimitry") != j.end() && j.at("Dimitry").is_null()) throw std::runtime_error("Unexpected null");
        x.dimitry = get_stack_optional<int64_t>(j, "Dimitry");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.edifying = get_untyped(j, "edifying");
        if (j.find("ethmoiditis") != j.end() && !j.at("ethmoiditis").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("ethmoiditis") != j.end() && j.at("ethmoiditis").is_null()) throw std::runtime_error("Unexpected null");
        x.ethmoiditis = get_stack_optional<int64_t>(j, "ethmoiditis");
        x.gastralgy = get_untyped(j, "gastralgy");
        if (j.find("goatherd") != j.end() && !j.at("goatherd").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("goatherd") != j.end() && j.at("goatherd").is_null()) throw std::runtime_error("Unexpected null");
        x.goatherd = get_stack_optional<int64_t>(j, "goatherd");
        if (j.find("hammerdress") != j.end() && !j.at("hammerdress").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hammerdress") != j.end() && j.at("hammerdress").is_null()) throw std::runtime_error("Unexpected null");
        x.hammerdress = get_stack_optional<int64_t>(j, "hammerdress");
        x.hangfire = get_untyped(j, "hangfire");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("lacunosity") != j.end() && !j.at("lacunosity").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("lacunosity") != j.end() && j.at("lacunosity").is_null()) throw std::runtime_error("Unexpected null");
        x.lacunosity = get_stack_optional<int64_t>(j, "lacunosity");
        x.longiloquence = get_untyped(j, "longiloquence");
        if (j.find("mameliere") != j.end() && !j.at("mameliere").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("mameliere") != j.end() && j.at("mameliere").is_null()) throw std::runtime_error("Unexpected null");
        x.mameliere = get_stack_optional<int64_t>(j, "mameliere");
        x.motherless = get_untyped(j, "motherless");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.noncorrodible = get_untyped(j, "noncorrodible");
        x.nonsensicality = get_untyped(j, "nonsensicality");
        if (j.find("oafishly") != j.end() && !j.at("oafishly").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("oafishly") != j.end() && j.at("oafishly").is_null()) throw std::runtime_error("Unexpected null");
        x.oafishly = get_stack_optional<int64_t>(j, "oafishly");
        x.pfund = get_untyped(j, "pfund");
        x.preadvisory = get_untyped(j, "preadvisory");
        x.retroflexed = get_untyped(j, "retroflexed");
        if (j.find("saccharulmic") != j.end() && !j.at("saccharulmic").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("saccharulmic") != j.end() && j.at("saccharulmic").is_null()) throw std::runtime_error("Unexpected null");
        x.saccharulmic = get_stack_optional<int64_t>(j, "saccharulmic");
        if (j.find("scowlful") != j.end() && !j.at("scowlful").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("scowlful") != j.end() && j.at("scowlful").is_null()) throw std::runtime_error("Unexpected null");
        x.scowlful = get_stack_optional<int64_t>(j, "scowlful");
        x.secluded = get_untyped(j, "secluded");
        x.slackage = get_untyped(j, "slackage");
        if (j.find("sphaeridial") != j.end() && !j.at("sphaeridial").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sphaeridial") != j.end() && j.at("sphaeridial").is_null()) throw std::runtime_error("Unexpected null");
        x.sphaeridial = get_stack_optional<int64_t>(j, "sphaeridial");
        x.spondulics = get_untyped(j, "spondulics");
        if (j.find("subsecive") != j.end() && !j.at("subsecive").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("subsecive") != j.end() && j.at("subsecive").is_null()) throw std::runtime_error("Unexpected null");
        x.subsecive = get_stack_optional<int64_t>(j, "subsecive");
        x.swellmobsman = get_untyped(j, "swellmobsman");
        if (j.find("trachyglossate") != j.end() && !j.at("trachyglossate").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("trachyglossate") != j.end() && j.at("trachyglossate").is_null()) throw std::runtime_error("Unexpected null");
        x.trachyglossate = get_stack_optional<int64_t>(j, "trachyglossate");
        x.trialogue = get_untyped(j, "trialogue");
        if (j.find("unassuaged") != j.end() && !j.at("unassuaged").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("unassuaged") != j.end() && j.at("unassuaged").is_null()) throw std::runtime_error("Unexpected null");
        x.unassuaged = get_stack_optional<int64_t>(j, "unassuaged");
        x.ungross = get_untyped(j, "ungross");
        x.unjudiciously = get_untyped(j, "unjudiciously");
    }

    inline void to_json(json & j, const Maslin & x) {
        j = json::object();
        j["Alicant"] = x.alicant;
        j["antiatonement"] = x.antiatonement;
        j["anticorrosive"] = x.anticorrosive;
        j["aphidozer"] = x.aphidozer;
        j["Bakuninist"] = x.bakuninist;
        j["be"] = x.be;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["chub"] = x.chub;
        j["cuprosilicon"] = x.cuprosilicon;
        j["curtailedly"] = x.curtailedly;
        j["dellenite"] = x.dellenite;
        j["Dimitry"] = x.dimitry;
        j["disdiapason"] = x.disdiapason;
        j["edifying"] = x.edifying;
        j["ethmoiditis"] = x.ethmoiditis;
        j["gastralgy"] = x.gastralgy;
        j["goatherd"] = x.goatherd;
        j["hammerdress"] = x.hammerdress;
        j["hangfire"] = x.hangfire;
        j["homocerc"] = x.homocerc;
        j["lacunosity"] = x.lacunosity;
        j["longiloquence"] = x.longiloquence;
        j["mameliere"] = x.mameliere;
        j["motherless"] = x.motherless;
        j["nonbookish"] = x.nonbookish;
        j["noncorrodible"] = x.noncorrodible;
        j["nonsensicality"] = x.nonsensicality;
        j["oafishly"] = x.oafishly;
        j["pfund"] = x.pfund;
        j["preadvisory"] = x.preadvisory;
        j["retroflexed"] = x.retroflexed;
        j["saccharulmic"] = x.saccharulmic;
        j["scowlful"] = x.scowlful;
        j["secluded"] = x.secluded;
        j["slackage"] = x.slackage;
        j["sphaeridial"] = x.sphaeridial;
        j["spondulics"] = x.spondulics;
        j["subsecive"] = x.subsecive;
        j["swellmobsman"] = x.swellmobsman;
        j["trachyglossate"] = x.trachyglossate;
        j["trialogue"] = x.trialogue;
        j["unassuaged"] = x.unassuaged;
        j["ungross"] = x.ungross;
        j["unjudiciously"] = x.unjudiciously;
    }

    inline void from_json(const json & j, MonaziteClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.catharticalness = j.at("catharticalness").get<double>();
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.chirotherium = j.at("Chirotherium").get<int64_t>();
        x.disdiapason = j.at("disdiapason").get<std::string>();
        x.homocerc = j.at("homocerc").get<bool>();
        x.nonbookish = get_untyped(j, "nonbookish");
    }

    inline void to_json(json & j, const MonaziteClass & x) {
        j = json::object();
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["homocerc"] = x.homocerc;
        j["nonbookish"] = x.nonbookish;
    }

    inline void from_json(const json & j, MonotheisticallyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.blaspheme = get_untyped(j, "blaspheme");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        x.celiosalpingectomy = get_untyped(j, "celiosalpingectomy");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        x.consummativeness = get_untyped(j, "consummativeness");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.egestive = get_untyped(j, "egestive");
        x.enchylema = get_untyped(j, "enchylema");
        x.gasconade = get_untyped(j, "gasconade");
        x.holidayer = get_untyped(j, "holidayer");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.intuitionalism = get_untyped(j, "intuitionalism");
        x.lophiostomate = get_untyped(j, "lophiostomate");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.nonvolition = get_untyped(j, "nonvolition");
        x.palatableness = get_untyped(j, "palatableness");
        x.pimpery = get_untyped(j, "pimpery");
        x.previolation = get_untyped(j, "previolation");
        x.reconveyance = get_untyped(j, "reconveyance");
        x.registership = get_untyped(j, "registership");
        x.rhyacolite = get_untyped(j, "rhyacolite");
        x.smithereens = get_untyped(j, "smithereens");
        x.superedification = get_untyped(j, "superedification");
        x.trust = get_untyped(j, "trust");
        x.whitestone = get_untyped(j, "whitestone");
    }

    inline void to_json(json & j, const MonotheisticallyClass & x) {
        j = json::object();
        j["blaspheme"] = x.blaspheme;
        j["catharticalness"] = x.catharticalness;
        j["celiosalpingectomy"] = x.celiosalpingectomy;
        j["Chirotherium"] = x.chirotherium;
        j["consummativeness"] = x.consummativeness;
        j["disdiapason"] = x.disdiapason;
        j["egestive"] = x.egestive;
        j["enchylema"] = x.enchylema;
        j["gasconade"] = x.gasconade;
        j["holidayer"] = x.holidayer;
        j["homocerc"] = x.homocerc;
        j["intuitionalism"] = x.intuitionalism;
        j["lophiostomate"] = x.lophiostomate;
        j["nonbookish"] = x.nonbookish;
        j["nonvolition"] = x.nonvolition;
        j["palatableness"] = x.palatableness;
        j["pimpery"] = x.pimpery;
        j["previolation"] = x.previolation;
        j["reconveyance"] = x.reconveyance;
        j["registership"] = x.registership;
        j["rhyacolite"] = x.rhyacolite;
        j["smithereens"] = x.smithereens;
        j["superedification"] = x.superedification;
        j["trust"] = x.trust;
        j["whitestone"] = x.whitestone;
    }

    inline void from_json(const json & j, Noncontributing& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.estevin = j.at("estevin").get<std::string>();
        x.jolterhead = j.at("jolterhead").get<double>();
        if (j.find("sauternes") != j.end() && !j.at("sauternes").is_number_integer()) throw std::runtime_error("Expected integer");
        x.sauternes = j.at("sauternes").get<int64_t>();
        x.sparsely = j.at("sparsely").get<bool>();
        x.unrequested = get_untyped(j, "unrequested");
    }

    inline void to_json(json & j, const Noncontributing & x) {
        j = json::object();
        j["estevin"] = x.estevin;
        j["jolterhead"] = x.jolterhead;
        j["sauternes"] = x.sauternes;
        j["sparsely"] = x.sparsely;
        j["unrequested"] = x.unrequested;
    }

    inline void from_json(const json & j, OccupationalistClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.beholdable = get_untyped(j, "beholdable");
        x.brotuliform = get_untyped(j, "brotuliform");
        x.chimakum = get_untyped(j, "Chimakum");
        x.doodler = get_untyped(j, "doodler");
        x.emulsin = get_untyped(j, "emulsin");
        x.fin = get_untyped(j, "Fin");
        x.flourishing = get_untyped(j, "flourishing");
        x.flueless = get_untyped(j, "flueless");
        x.furtively = get_untyped(j, "furtively");
        x.gritter = get_untyped(j, "gritter");
        x.interwish = get_untyped(j, "interwish");
        x.monoxylic = get_untyped(j, "monoxylic");
        x.myristic = get_untyped(j, "myristic");
        x.nightwear = get_untyped(j, "nightwear");
        x.peruser = get_untyped(j, "peruser");
        x.theoastrological = get_untyped(j, "theoastrological");
        x.thumby = get_untyped(j, "thumby");
        x.tingitid = get_untyped(j, "tingitid");
        x.trailless = get_untyped(j, "trailless");
        x.unpocketed = get_untyped(j, "unpocketed");
    }

    inline void to_json(json & j, const OccupationalistClass & x) {
        j = json::object();
        j["beholdable"] = x.beholdable;
        j["brotuliform"] = x.brotuliform;
        j["Chimakum"] = x.chimakum;
        j["doodler"] = x.doodler;
        j["emulsin"] = x.emulsin;
        j["Fin"] = x.fin;
        j["flourishing"] = x.flourishing;
        j["flueless"] = x.flueless;
        j["furtively"] = x.furtively;
        j["gritter"] = x.gritter;
        j["interwish"] = x.interwish;
        j["monoxylic"] = x.monoxylic;
        j["myristic"] = x.myristic;
        j["nightwear"] = x.nightwear;
        j["peruser"] = x.peruser;
        j["theoastrological"] = x.theoastrological;
        j["thumby"] = x.thumby;
        j["tingitid"] = x.tingitid;
        j["trailless"] = x.trailless;
        j["unpocketed"] = x.unpocketed;
    }

    inline void from_json(const json & j, OutrivalClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.adroitly = get_untyped(j, "adroitly");
        x.bridehood = get_untyped(j, "bridehood");
        x.castoroides = get_untyped(j, "Castoroides");
        x.czechoslovak = get_untyped(j, "Czechoslovak");
        x.diagenesis = get_untyped(j, "diagenesis");
        x.dihexahedron = get_untyped(j, "dihexahedron");
        x.dopester = get_untyped(j, "dopester");
        x.eumerism = get_untyped(j, "eumerism");
        x.flyness = get_untyped(j, "flyness");
        x.fouler = get_untyped(j, "fouler");
        x.laudanosine = get_untyped(j, "laudanosine");
        x.lingulidae = get_untyped(j, "Lingulidae");
        x.minutary = get_untyped(j, "minutary");
        x.mitra = get_untyped(j, "mitra");
        x.opisthorchiasis = get_untyped(j, "opisthorchiasis");
        x.pensively = get_untyped(j, "pensively");
        x.pubigerous = get_untyped(j, "pubigerous");
        x.rebellious = get_untyped(j, "rebellious");
        x.recodify = get_untyped(j, "recodify");
        x.unpaced = get_untyped(j, "unpaced");
    }

    inline void to_json(json & j, const OutrivalClass & x) {
        j = json::object();
        j["adroitly"] = x.adroitly;
        j["bridehood"] = x.bridehood;
        j["Castoroides"] = x.castoroides;
        j["Czechoslovak"] = x.czechoslovak;
        j["diagenesis"] = x.diagenesis;
        j["dihexahedron"] = x.dihexahedron;
        j["dopester"] = x.dopester;
        j["eumerism"] = x.eumerism;
        j["flyness"] = x.flyness;
        j["fouler"] = x.fouler;
        j["laudanosine"] = x.laudanosine;
        j["Lingulidae"] = x.lingulidae;
        j["minutary"] = x.minutary;
        j["mitra"] = x.mitra;
        j["opisthorchiasis"] = x.opisthorchiasis;
        j["pensively"] = x.pensively;
        j["pubigerous"] = x.pubigerous;
        j["rebellious"] = x.rebellious;
        j["recodify"] = x.recodify;
        j["unpaced"] = x.unpaced;
    }

    inline void from_json(const json & j, PiaculumClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("alada") != j.end() && !j.at("alada").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("alada") != j.end() && j.at("alada").is_null()) throw std::runtime_error("Unexpected null");
        x.alada = get_stack_optional<int64_t>(j, "alada");
        if (j.find("amphistomous") != j.end() && !j.at("amphistomous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("amphistomous") != j.end() && j.at("amphistomous").is_null()) throw std::runtime_error("Unexpected null");
        x.amphistomous = get_stack_optional<int64_t>(j, "amphistomous");
        if (j.find("boysenberry") != j.end() && !j.at("boysenberry").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("boysenberry") != j.end() && j.at("boysenberry").is_null()) throw std::runtime_error("Unexpected null");
        x.boysenberry = get_stack_optional<int64_t>(j, "boysenberry");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("decardinalize") != j.end() && !j.at("decardinalize").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("decardinalize") != j.end() && j.at("decardinalize").is_null()) throw std::runtime_error("Unexpected null");
        x.decardinalize = get_stack_optional<int64_t>(j, "decardinalize");
        if (j.find("discouragement") != j.end() && !j.at("discouragement").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("discouragement") != j.end() && j.at("discouragement").is_null()) throw std::runtime_error("Unexpected null");
        x.discouragement = get_stack_optional<int64_t>(j, "discouragement");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        if (j.find("doitrified") != j.end() && !j.at("doitrified").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("doitrified") != j.end() && j.at("doitrified").is_null()) throw std::runtime_error("Unexpected null");
        x.doitrified = get_stack_optional<int64_t>(j, "doitrified");
        if (j.find("hexaspermous") != j.end() && !j.at("hexaspermous").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("hexaspermous") != j.end() && j.at("hexaspermous").is_null()) throw std::runtime_error("Unexpected null");
        x.hexaspermous = get_stack_optional<int64_t>(j, "hexaspermous");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        if (j.find("insinking") != j.end() && !j.at("insinking").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("insinking") != j.end() && j.at("insinking").is_null()) throw std::runtime_error("Unexpected null");
        x.insinking = get_stack_optional<int64_t>(j, "insinking");
        if (j.find("loathfulness") != j.end() && !j.at("loathfulness").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("loathfulness") != j.end() && j.at("loathfulness").is_null()) throw std::runtime_error("Unexpected null");
        x.loathfulness = get_stack_optional<int64_t>(j, "loathfulness");
        if (j.find("miasmatical") != j.end() && !j.at("miasmatical").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("miasmatical") != j.end() && j.at("miasmatical").is_null()) throw std::runtime_error("Unexpected null");
        x.miasmatical = get_stack_optional<int64_t>(j, "miasmatical");
        if (j.find("neurofibril") != j.end() && !j.at("neurofibril").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("neurofibril") != j.end() && j.at("neurofibril").is_null()) throw std::runtime_error("Unexpected null");
        x.neurofibril = get_stack_optional<int64_t>(j, "neurofibril");
        x.nonbookish = get_untyped(j, "nonbookish");
        if (j.find("phonendoscope") != j.end() && !j.at("phonendoscope").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("phonendoscope") != j.end() && j.at("phonendoscope").is_null()) throw std::runtime_error("Unexpected null");
        x.phonendoscope = get_stack_optional<int64_t>(j, "phonendoscope");
        if (j.find("pilferment") != j.end() && !j.at("pilferment").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("pilferment") != j.end() && j.at("pilferment").is_null()) throw std::runtime_error("Unexpected null");
        x.pilferment = get_stack_optional<int64_t>(j, "pilferment");
        if (j.find("predismissory") != j.end() && !j.at("predismissory").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("predismissory") != j.end() && j.at("predismissory").is_null()) throw std::runtime_error("Unexpected null");
        x.predismissory = get_stack_optional<int64_t>(j, "predismissory");
        if (j.find("preinscription") != j.end() && !j.at("preinscription").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("preinscription") != j.end() && j.at("preinscription").is_null()) throw std::runtime_error("Unexpected null");
        x.preinscription = get_stack_optional<int64_t>(j, "preinscription");
        if (j.find("quotative") != j.end() && !j.at("quotative").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("quotative") != j.end() && j.at("quotative").is_null()) throw std::runtime_error("Unexpected null");
        x.quotative = get_stack_optional<int64_t>(j, "quotative");
        if (j.find("sienna") != j.end() && !j.at("sienna").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("sienna") != j.end() && j.at("sienna").is_null()) throw std::runtime_error("Unexpected null");
        x.sienna = get_stack_optional<int64_t>(j, "sienna");
        if (j.find("thorax") != j.end() && !j.at("thorax").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("thorax") != j.end() && j.at("thorax").is_null()) throw std::runtime_error("Unexpected null");
        x.thorax = get_stack_optional<int64_t>(j, "thorax");
        if (j.find("yachting") != j.end() && !j.at("yachting").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("yachting") != j.end() && j.at("yachting").is_null()) throw std::runtime_error("Unexpected null");
        x.yachting = get_stack_optional<int64_t>(j, "yachting");
        if (j.find("Zipper") != j.end() && !j.at("Zipper").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Zipper") != j.end() && j.at("Zipper").is_null()) throw std::runtime_error("Unexpected null");
        x.zipper = get_stack_optional<int64_t>(j, "Zipper");
    }

    inline void to_json(json & j, const PiaculumClass & x) {
        j = json::object();
        j["alada"] = x.alada;
        j["amphistomous"] = x.amphistomous;
        j["boysenberry"] = x.boysenberry;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["decardinalize"] = x.decardinalize;
        j["discouragement"] = x.discouragement;
        j["disdiapason"] = x.disdiapason;
        j["doitrified"] = x.doitrified;
        j["hexaspermous"] = x.hexaspermous;
        j["homocerc"] = x.homocerc;
        j["insinking"] = x.insinking;
        j["loathfulness"] = x.loathfulness;
        j["miasmatical"] = x.miasmatical;
        j["neurofibril"] = x.neurofibril;
        j["nonbookish"] = x.nonbookish;
        j["phonendoscope"] = x.phonendoscope;
        j["pilferment"] = x.pilferment;
        j["predismissory"] = x.predismissory;
        j["preinscription"] = x.preinscription;
        j["quotative"] = x.quotative;
        j["sienna"] = x.sienna;
        j["thorax"] = x.thorax;
        j["yachting"] = x.yachting;
        j["Zipper"] = x.zipper;
    }

    inline void from_json(const json & j, Pneumocele& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.carbonarism = get_untyped(j, "Carbonarism");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        x.cineolic = get_untyped(j, "cineolic");
        x.cobbly = get_untyped(j, "cobbly");
        x.conchyliferous = get_untyped(j, "conchyliferous");
        x.congregation = get_untyped(j, "congregation");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.enterotomy = get_untyped(j, "enterotomy");
        x.entophytal = get_untyped(j, "entophytal");
        x.fewtrils = get_untyped(j, "fewtrils");
        x.herem = get_untyped(j, "herem");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.koniga = get_untyped(j, "Koniga");
        x.meticulosity = get_untyped(j, "meticulosity");
        x.micky = get_untyped(j, "Micky");
        x.mismarriage = get_untyped(j, "mismarriage");
        x.neurotrophic = get_untyped(j, "neurotrophic");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.persuasively = get_untyped(j, "persuasively");
        x.replaceable = get_untyped(j, "replaceable");
        x.silex = get_untyped(j, "silex");
        x.taillight = get_untyped(j, "taillight");
        x.unjealous = get_untyped(j, "unjealous");
        x.visitorial = get_untyped(j, "visitorial");
    }

    inline void to_json(json & j, const Pneumocele & x) {
        j = json::object();
        j["Carbonarism"] = x.carbonarism;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["cineolic"] = x.cineolic;
        j["cobbly"] = x.cobbly;
        j["conchyliferous"] = x.conchyliferous;
        j["congregation"] = x.congregation;
        j["disdiapason"] = x.disdiapason;
        j["enterotomy"] = x.enterotomy;
        j["entophytal"] = x.entophytal;
        j["fewtrils"] = x.fewtrils;
        j["herem"] = x.herem;
        j["homocerc"] = x.homocerc;
        j["Koniga"] = x.koniga;
        j["meticulosity"] = x.meticulosity;
        j["Micky"] = x.micky;
        j["mismarriage"] = x.mismarriage;
        j["neurotrophic"] = x.neurotrophic;
        j["nonbookish"] = x.nonbookish;
        j["persuasively"] = x.persuasively;
        j["replaceable"] = x.replaceable;
        j["silex"] = x.silex;
        j["taillight"] = x.taillight;
        j["unjealous"] = x.unjealous;
        j["visitorial"] = x.visitorial;
    }

    inline void from_json(const json & j, PotwhiskyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.arciform = get_untyped(j, "arciform");
        x.cresolin = get_untyped(j, "cresolin");
        x.disheartener = get_untyped(j, "disheartener");
        x.disproportionable = get_untyped(j, "disproportionable");
        x.euchorda = get_untyped(j, "Euchorda");
        x.ferryway = get_untyped(j, "ferryway");
        x.filamentiferous = get_untyped(j, "filamentiferous");
        x.flemish = get_untyped(j, "flemish");
        x.forgainst = get_untyped(j, "forgainst");
        x.grainering = get_untyped(j, "grainering");
        x.irrevoluble = get_untyped(j, "irrevoluble");
        x.kindredship = get_untyped(j, "kindredship");
        x.pinguitudinous = get_untyped(j, "pinguitudinous");
        x.simpletonic = get_untyped(j, "simpletonic");
        x.singsong = get_untyped(j, "singsong");
        x.submergement = get_untyped(j, "submergement");
        x.supraoesophagal = get_untyped(j, "supraoesophagal");
        x.thrashel = get_untyped(j, "thrashel");
        x.tyremesis = get_untyped(j, "tyremesis");
        x.yoruba = get_untyped(j, "Yoruba");
    }

    inline void to_json(json & j, const PotwhiskyClass & x) {
        j = json::object();
        j["arciform"] = x.arciform;
        j["cresolin"] = x.cresolin;
        j["disheartener"] = x.disheartener;
        j["disproportionable"] = x.disproportionable;
        j["Euchorda"] = x.euchorda;
        j["ferryway"] = x.ferryway;
        j["filamentiferous"] = x.filamentiferous;
        j["flemish"] = x.flemish;
        j["forgainst"] = x.forgainst;
        j["grainering"] = x.grainering;
        j["irrevoluble"] = x.irrevoluble;
        j["kindredship"] = x.kindredship;
        j["pinguitudinous"] = x.pinguitudinous;
        j["simpletonic"] = x.simpletonic;
        j["singsong"] = x.singsong;
        j["submergement"] = x.submergement;
        j["supraoesophagal"] = x.supraoesophagal;
        j["thrashel"] = x.thrashel;
        j["tyremesis"] = x.tyremesis;
        j["Yoruba"] = x.yoruba;
    }

    inline void from_json(const json & j, PrefreshmanClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.azorubine = get_untyped(j, "azorubine");
        x.choroiditis = get_untyped(j, "choroiditis");
        x.coagulatory = get_untyped(j, "coagulatory");
        x.cyclorama = get_untyped(j, "cyclorama");
        x.dolphus = get_untyped(j, "Dolphus");
        x.duckhearted = get_untyped(j, "duckhearted");
        x.ficus = get_untyped(j, "Ficus");
        x.gemaric = get_untyped(j, "Gemaric");
        x.jugation = get_untyped(j, "jugation");
        x.myoliposis = get_untyped(j, "myoliposis");
        x.nonnomination = get_untyped(j, "nonnomination");
        x.palay = get_untyped(j, "palay");
        x.pentactinal = get_untyped(j, "pentactinal");
        x.phaet = get_untyped(j, "Phaet");
        x.piquant = get_untyped(j, "piquant");
        x.registration = get_untyped(j, "registration");
        x.remancipation = get_untyped(j, "remancipation");
        x.scutatiform = get_untyped(j, "scutatiform");
        x.theodolite = get_untyped(j, "theodolite");
        x.underward = get_untyped(j, "underward");
    }

    inline void to_json(json & j, const PrefreshmanClass & x) {
        j = json::object();
        j["azorubine"] = x.azorubine;
        j["choroiditis"] = x.choroiditis;
        j["coagulatory"] = x.coagulatory;
        j["cyclorama"] = x.cyclorama;
        j["Dolphus"] = x.dolphus;
        j["duckhearted"] = x.duckhearted;
        j["Ficus"] = x.ficus;
        j["Gemaric"] = x.gemaric;
        j["jugation"] = x.jugation;
        j["myoliposis"] = x.myoliposis;
        j["nonnomination"] = x.nonnomination;
        j["palay"] = x.palay;
        j["pentactinal"] = x.pentactinal;
        j["Phaet"] = x.phaet;
        j["piquant"] = x.piquant;
        j["registration"] = x.registration;
        j["remancipation"] = x.remancipation;
        j["scutatiform"] = x.scutatiform;
        j["theodolite"] = x.theodolite;
        j["underward"] = x.underward;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.juror = j.at("juror").get<std::vector<JurorElement>>();
        x.kongoni = j.at("kongoni").get<std::vector<Kongoni>>();
        x.ladronism = j.at("ladronism").get<std::vector<LadronismElement>>();
        x.landlubberly = j.at("landlubberly").get<std::vector<LandlubberlyElement>>();
        x.listener = j.at("listener").get<std::vector<Listener>>();
        x.lupus = j.at("lupus").get<std::vector<LupusElement>>();
        x.maslin = j.at("maslin").get<std::vector<Maslin>>();
        x.monazite = j.at("monazite").get<std::vector<MonaziteElement>>();
        x.monoliteral = j.at("monoliteral").get<std::vector<Monoliteral>>();
        x.monotheistically = j.at("monotheistically").get<std::vector<MonotheisticallyElement>>();
        x.montage = j.at("montage").get<std::vector<Montage>>();
        x.moralness = j.at("moralness").get<std::vector<Moralness>>();
        x.mowra = j.at("mowra").get<std::vector<std::optional<MonaziteClass>>>();
        x.mulishly = j.at("mulishly").get<std::vector<Mulishly>>();
        x.myoscope = j.at("myoscope").get<std::vector<Myoscope>>();
        x.nach = j.at("nach").get<std::vector<std::optional<std::vector<std::optional<int64_t>>>>>();
        x.neuromastic = j.at("neuromastic").get<std::vector<Neuromastic>>();
        x.noncontributing = j.at("noncontributing").get<std::vector<Noncontributing>>();
        x.nonnervous = j.at("nonnervous").get<std::vector<Nonnervous>>();
        x.nonvaluation = j.at("nonvaluation").get<std::vector<Nonvaluation>>();
        x.occupationalist = j.at("occupationalist").get<std::vector<OccupationalistElement>>();
        x.outrival = j.at("outrival").get<std::vector<OutrivalElement>>();
        x.paleographically = j.at("paleographically").get<std::vector<Paleographically>>();
        x.pamphletwise = j.at("pamphletwise").get<std::vector<Pamphletwise>>();
        x.pediatrics = j.at("pediatrics").get<std::vector<Pediatric>>();
        x.perceptive = j.at("perceptive").get<std::vector<bool>>();
        x.piaculum = j.at("piaculum").get<std::vector<PiaculumElement>>();
        x.piccadilly = j.at("piccadilly").get<std::vector<Piccadilly>>();
        x.piffler = j.at("piffler").get<std::vector<Piffler>>();
        x.pithful = j.at("pithful").get<std::vector<Pithful>>();
        x.placuntitis = j.at("placuntitis").get<std::vector<Placuntiti>>();
        x.plectopterous = j.at("plectopterous").get<std::vector<Plectopterous>>();
        x.pneumocele = j.at("pneumocele").get<std::vector<std::optional<Pneumocele>>>();
        x.poliorcetic = j.at("poliorcetic").get<std::vector<Poliorcetic>>();
        x.poormaster = j.at("poormaster").get<std::vector<Poormaster>>();
        x.potwhisky = j.at("potwhisky").get<std::vector<PotwhiskyElement>>();
        x.practicalizer = j.at("practicalizer").get<std::vector<Practicalizer>>();
        x.prefreshman = j.at("prefreshman").get<std::vector<PrefreshmanElement>>();
        x.prehensility = j.at("prehensility").get<std::vector<Prehensility>>();
        x.prevoidance = j.at("prevoidance").get<std::vector<Prevoidance>>();
        x.probant = j.at("probant").get<std::vector<std::map<std::string, std::optional<int64_t>>>>();
        x.protext = j.at("protext").get<std::vector<Protext>>();
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["juror"] = x.juror;
        j["kongoni"] = x.kongoni;
        j["ladronism"] = x.ladronism;
        j["landlubberly"] = x.landlubberly;
        j["listener"] = x.listener;
        j["lupus"] = x.lupus;
        j["maslin"] = x.maslin;
        j["monazite"] = x.monazite;
        j["monoliteral"] = x.monoliteral;
        j["monotheistically"] = x.monotheistically;
        j["montage"] = x.montage;
        j["moralness"] = x.moralness;
        j["mowra"] = x.mowra;
        j["mulishly"] = x.mulishly;
        j["myoscope"] = x.myoscope;
        j["nach"] = x.nach;
        j["neuromastic"] = x.neuromastic;
        j["noncontributing"] = x.noncontributing;
        j["nonnervous"] = x.nonnervous;
        j["nonvaluation"] = x.nonvaluation;
        j["occupationalist"] = x.occupationalist;
        j["outrival"] = x.outrival;
        j["paleographically"] = x.paleographically;
        j["pamphletwise"] = x.pamphletwise;
        j["pediatrics"] = x.pediatrics;
        j["perceptive"] = x.perceptive;
        j["piaculum"] = x.piaculum;
        j["piccadilly"] = x.piccadilly;
        j["piffler"] = x.piffler;
        j["pithful"] = x.pithful;
        j["placuntitis"] = x.placuntitis;
        j["plectopterous"] = x.plectopterous;
        j["pneumocele"] = x.pneumocele;
        j["poliorcetic"] = x.poliorcetic;
        j["poormaster"] = x.poormaster;
        j["potwhisky"] = x.potwhisky;
        j["practicalizer"] = x.practicalizer;
        j["prefreshman"] = x.prefreshman;
        j["prehensility"] = x.prehensility;
        j["prevoidance"] = x.prevoidance;
        j["probant"] = x.probant;
        j["protext"] = x.protext;
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<bool, quicktype::JurorClass>>::from_json(const json & j, std::variant<bool, quicktype::JurorClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::JurorClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::JurorClass>>::to_json(json & j, const std::variant<bool, quicktype::JurorClass> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>>::from_json(const json & j, std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, std::map<std::string, int64_t>>>::to_json(json & j, const std::variant<std::vector<int64_t>, std::map<std::string, int64_t>> & x) {
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

    inline void adl_serializer<std::variant<quicktype::LadronismClass, double, std::string>>::from_json(const json & j, std::variant<quicktype::LadronismClass, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::LadronismClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LadronismClass, double, std::string>>::to_json(json & j, const std::variant<quicktype::LadronismClass, double, std::string> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::LandlubberlyClass, int64_t>>::from_json(const json & j, std::variant<bool, quicktype::LandlubberlyClass, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::LandlubberlyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::LandlubberlyClass, int64_t>>::to_json(json & j, const std::variant<bool, quicktype::LandlubberlyClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<quicktype::LupusClass, int64_t>>::from_json(const json & j, std::variant<quicktype::LupusClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::LupusClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::LupusClass, int64_t>>::to_json(json & j, const std::variant<quicktype::LupusClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<quicktype::MonaziteClass, double>>::from_json(const json & j, std::variant<quicktype::MonaziteClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::MonaziteClass, double>>::to_json(json & j, const std::variant<quicktype::MonaziteClass, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonotheisticallyClass>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::MonotheisticallyClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::MonotheisticallyClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonotheisticallyClass>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::MonotheisticallyClass> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, double, std::string>>::from_json(const json & j, std::variant<std::vector<json>, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, double, std::string>>::to_json(json & j, const std::variant<std::vector<json>, double, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, int64_t>>::from_json(const json & j, std::variant<std::vector<json>, bool, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, int64_t>>::to_json(json & j, const std::variant<std::vector<json>, bool, int64_t> & x) {
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

    inline void adl_serializer<std::variant<bool, int64_t>>::from_json(const json & j, std::variant<bool, int64_t> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, int64_t>>::to_json(json & j, const std::variant<bool, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, double>>::from_json(const json & j, std::variant<std::vector<json>, bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, double>>::to_json(json & j, const std::variant<std::vector<json>, bool, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::OccupationalistClass>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::OccupationalistClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::OccupationalistClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::OccupationalistClass>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::OccupationalistClass> & x) {
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

    inline void adl_serializer<std::variant<quicktype::OutrivalClass, double>>::from_json(const json & j, std::variant<quicktype::OutrivalClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::OutrivalClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::OutrivalClass, double>>::to_json(json & j, const std::variant<quicktype::OutrivalClass, double> & x) {
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

    inline void adl_serializer<std::variant<double, std::map<std::string, std::optional<int64_t>>>>::from_json(const json & j, std::variant<double, std::map<std::string, std::optional<int64_t>>> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<std::map<std::string, std::optional<int64_t>>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::map<std::string, std::optional<int64_t>>>>::to_json(json & j, const std::variant<double, std::map<std::string, std::optional<int64_t>>> & x) {
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

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>, std::string>>::from_json(const json & j, std::variant<int64_t, std::map<std::string, int64_t>, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<int64_t, std::map<std::string, int64_t>, std::string>>::to_json(json & j, const std::variant<int64_t, std::map<std::string, int64_t>, std::string> & x) {
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

    inline void adl_serializer<std::variant<quicktype::PiaculumClass, double>>::from_json(const json & j, std::variant<quicktype::PiaculumClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::PiaculumClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PiaculumClass, double>>::to_json(json & j, const std::variant<quicktype::PiaculumClass, double> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::MonaziteClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::MonaziteClass> & x) {
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

    inline void adl_serializer<std::variant<bool, quicktype::MonaziteClass>>::from_json(const json & j, std::variant<bool, quicktype::MonaziteClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::MonaziteClass>>::to_json(json & j, const std::variant<bool, quicktype::MonaziteClass> & x) {
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

    inline void adl_serializer<std::variant<quicktype::PotwhiskyClass, int64_t>>::from_json(const json & j, std::variant<quicktype::PotwhiskyClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::PotwhiskyClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PotwhiskyClass, int64_t>>::to_json(json & j, const std::variant<quicktype::PotwhiskyClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass, std::string>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::MonaziteClass, std::string>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::MonaziteClass, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::PrefreshmanClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::PrefreshmanClass, std::string> & x) {
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

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::MonaziteClass>>::from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::MonaziteClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::MonaziteClass>>::to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::MonaziteClass> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t>>::from_json(const json & j, std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t>>::to_json(json & j, const std::variant<std::vector<int64_t>, quicktype::MonaziteClass, int64_t> & x) {
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

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass>>::from_json(const json & j, std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::MonaziteClass>();
        else if (j.is_array())
            x = j.get<std::vector<int64_t>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass>>::to_json(json & j, const std::variant<std::vector<int64_t>, bool, quicktype::MonaziteClass> & x) {
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
