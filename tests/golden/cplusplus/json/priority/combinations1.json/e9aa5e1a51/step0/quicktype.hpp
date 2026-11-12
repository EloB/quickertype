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

    struct CerographClass {
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
    };

    using CerographElement = std::optional<std::variant<CerographClass, std::string>>;

    struct ChemotherapeuticClass {
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
    };

    using ChemotherapeuticElement = std::variant<ChemotherapeuticClass, int64_t>;

    struct CimeliaClass {
        double catharticalness;
        int64_t chirotherium;
        std::string disdiapason;
        bool homocerc;
        nlohmann::json nonbookish;
    };

    using CimeliaElement = std::optional<std::variant<std::vector<int64_t>, CimeliaClass>>;

    using Clinodome = std::variant<double, std::string>;

    struct CoadjustClass {
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
    };

    using CoadjustElement = std::variant<CoadjustClass, double>;

    using Consilience = std::variant<double, std::map<std::string, int64_t>>;

    using Constructor = std::variant<bool, std::map<std::string, std::optional<int64_t>>>;

    using Continuative = std::variant<std::map<std::string, int64_t>, std::string>;

    struct CredulityClass {
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
    };

    using CredulityElement = std::variant<CredulityClass, int64_t, std::string>;

    using Creviced = std::variant<bool, std::map<std::string, int64_t>, std::string>;

    struct DeruralizeClass {
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
    };

    using DeruralizeElement = std::variant<std::vector<nlohmann::json>, bool, DeruralizeClass>;

    struct DiaereseClass {
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
    };

    using DiaereseElement = std::variant<std::vector<int64_t>, bool, DiaereseClass>;

    using Downstroke = std::variant<std::vector<nlohmann::json>, bool, std::string>;

    using Eleutheromania = std::variant<double, std::map<std::string, int64_t>, std::string>;

    struct Encrust {
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
    };

    using Entomoid = std::variant<CimeliaClass, int64_t>;

    using Epipaleolithic = std::variant<std::vector<int64_t>, double>;

    using Expropriable = std::variant<std::vector<nlohmann::json>, CimeliaClass, double>;

    struct FagginglyClass {
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
    };

    using FagginglyElement = std::variant<FagginglyClass, double>;

    struct FenkClass {
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
    };

    using FenkElement = std::variant<FenkClass, std::string>;

    struct FlagmakingClass {
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
    };

    using FlagmakingElement = std::variant<bool, FlagmakingClass, double>;

    using Fluorometer = std::optional<std::variant<int64_t, std::string>>;

    using Fuzzy = std::variant<int64_t, std::map<std::string, std::optional<int64_t>>>;

    using Gardenward = std::variant<std::vector<int64_t>, bool, std::string>;

    using Generalissimo = std::optional<std::variant<bool, std::map<std::string, int64_t>>>;

    using Hemicrystalline = std::variant<CimeliaClass, std::string>;

    struct HemocoeleClass {
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
    };

    using HemocoeleElement = std::variant<std::vector<int64_t>, HemocoeleClass>;

    using Hoister = std::optional<std::variant<CimeliaClass, std::string>>;

    using Hyperpiesi = std::optional<std::variant<std::vector<nlohmann::json>, CimeliaClass>>;

    using Hyppish = std::optional<std::variant<bool, std::string>>;

    using Idealizer = std::variant<std::vector<nlohmann::json>, CimeliaClass, int64_t>;

    using Incrustator = std::variant<std::vector<int64_t>, int64_t, std::string>;

    using Intentiveness = std::variant<CimeliaClass, double, std::string>;

    struct Interacinar {
        double assapan;
        bool benefactorship;
        std::string triseriatim;
        int64_t tubbing;
        nlohmann::json untrimmed;
    };

    using Jacutinga = std::variant<std::vector<int64_t>, std::map<std::string, std::optional<int64_t>>>;

    struct TopLevel {
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
        x.apotropaion = get_untyped(j, "apotropaion");
        x.casuary = get_untyped(j, "casuary");
        x.creaker = get_untyped(j, "creaker");
        x.disqualification = get_untyped(j, "disqualification");
        x.imperatorious = get_untyped(j, "imperatorious");
        x.impermeabilize = get_untyped(j, "impermeabilize");
        x.metastoma = get_untyped(j, "metastoma");
        x.noctidiurnal = get_untyped(j, "noctidiurnal");
        x.nonreserve = get_untyped(j, "nonreserve");
        x.ophthalmotonometry = get_untyped(j, "ophthalmotonometry");
        x.pailful = get_untyped(j, "pailful");
        x.pigfish = get_untyped(j, "pigfish");
        x.pongee = get_untyped(j, "pongee");
        x.prosodical = get_untyped(j, "prosodical");
        x.scrofuloderm = get_untyped(j, "scrofuloderm");
        x.storekeeping = get_untyped(j, "storekeeping");
        x.therologist = get_untyped(j, "therologist");
        x.tolowa = get_untyped(j, "Tolowa");
        x.tradeful = get_untyped(j, "tradeful");
        x.unriveting = get_untyped(j, "unriveting");
    }

    inline void to_json(json & j, const CerographClass & x) {
        j = json::object();
        j["apotropaion"] = x.apotropaion;
        j["casuary"] = x.casuary;
        j["creaker"] = x.creaker;
        j["disqualification"] = x.disqualification;
        j["imperatorious"] = x.imperatorious;
        j["impermeabilize"] = x.impermeabilize;
        j["metastoma"] = x.metastoma;
        j["noctidiurnal"] = x.noctidiurnal;
        j["nonreserve"] = x.nonreserve;
        j["ophthalmotonometry"] = x.ophthalmotonometry;
        j["pailful"] = x.pailful;
        j["pigfish"] = x.pigfish;
        j["pongee"] = x.pongee;
        j["prosodical"] = x.prosodical;
        j["scrofuloderm"] = x.scrofuloderm;
        j["storekeeping"] = x.storekeeping;
        j["therologist"] = x.therologist;
        j["Tolowa"] = x.tolowa;
        j["tradeful"] = x.tradeful;
        j["unriveting"] = x.unriveting;
    }

    inline void from_json(const json & j, ChemotherapeuticClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.angioneurotic = get_untyped(j, "angioneurotic");
        x.availment = get_untyped(j, "availment");
        x.bladelet = get_untyped(j, "bladelet");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        x.caulis = get_untyped(j, "caulis");
        x.chalcus = get_untyped(j, "chalcus");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.enteradenological = get_untyped(j, "enteradenological");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.imporosity = get_untyped(j, "imporosity");
        x.insistently = get_untyped(j, "insistently");
        x.intraparietal = get_untyped(j, "intraparietal");
        x.ivied = get_untyped(j, "ivied");
        x.maureen = get_untyped(j, "Maureen");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.nostochine = get_untyped(j, "nostochine");
        x.nutcracker = get_untyped(j, "nutcracker");
        x.ofttimes = get_untyped(j, "ofttimes");
        x.phenocryst = get_untyped(j, "phenocryst");
        x.precoincident = get_untyped(j, "precoincident");
        x.ramiferous = get_untyped(j, "ramiferous");
        x.stagmometer = get_untyped(j, "stagmometer");
        x.tetherball = get_untyped(j, "tetherball");
        x.unshy = get_untyped(j, "unshy");
    }

    inline void to_json(json & j, const ChemotherapeuticClass & x) {
        j = json::object();
        j["angioneurotic"] = x.angioneurotic;
        j["availment"] = x.availment;
        j["bladelet"] = x.bladelet;
        j["catharticalness"] = x.catharticalness;
        j["caulis"] = x.caulis;
        j["chalcus"] = x.chalcus;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["enteradenological"] = x.enteradenological;
        j["homocerc"] = x.homocerc;
        j["imporosity"] = x.imporosity;
        j["insistently"] = x.insistently;
        j["intraparietal"] = x.intraparietal;
        j["ivied"] = x.ivied;
        j["Maureen"] = x.maureen;
        j["nonbookish"] = x.nonbookish;
        j["nostochine"] = x.nostochine;
        j["nutcracker"] = x.nutcracker;
        j["ofttimes"] = x.ofttimes;
        j["phenocryst"] = x.phenocryst;
        j["precoincident"] = x.precoincident;
        j["ramiferous"] = x.ramiferous;
        j["stagmometer"] = x.stagmometer;
        j["tetherball"] = x.tetherball;
        j["unshy"] = x.unshy;
    }

    inline void from_json(const json & j, CimeliaClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.catharticalness = j.at("catharticalness").get<double>();
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        x.chirotherium = j.at("Chirotherium").get<int64_t>();
        x.disdiapason = j.at("disdiapason").get<std::string>();
        x.homocerc = j.at("homocerc").get<bool>();
        x.nonbookish = get_untyped(j, "nonbookish");
    }

    inline void to_json(json & j, const CimeliaClass & x) {
        j = json::object();
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["homocerc"] = x.homocerc;
        j["nonbookish"] = x.nonbookish;
    }

    inline void from_json(const json & j, CoadjustClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.amidosulphonal = get_untyped(j, "amidosulphonal");
        x.benny = get_untyped(j, "Benny");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.ensnare = get_untyped(j, "ensnare");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.hybridizer = get_untyped(j, "hybridizer");
        x.leastwise = get_untyped(j, "leastwise");
        x.lof = get_untyped(j, "lof");
        x.monkhood = get_untyped(j, "monkhood");
        x.netherlandish = get_untyped(j, "Netherlandish");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.peonism = get_untyped(j, "peonism");
        x.phonelescope = get_untyped(j, "Phonelescope");
        x.porphyrogeniture = get_untyped(j, "porphyrogeniture");
        x.preindemnify = get_untyped(j, "preindemnify");
        x.rosal = get_untyped(j, "rosal");
        x.scalenous = get_untyped(j, "scalenous");
        x.scopine = get_untyped(j, "scopine");
        x.sedaceae = get_untyped(j, "Sedaceae");
        x.suberinize = get_untyped(j, "suberinize");
        x.symbiot = get_untyped(j, "symbiot");
        x.tablefellow = get_untyped(j, "tablefellow");
        x.unchargeable = get_untyped(j, "unchargeable");
    }

    inline void to_json(json & j, const CoadjustClass & x) {
        j = json::object();
        j["amidosulphonal"] = x.amidosulphonal;
        j["Benny"] = x.benny;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["ensnare"] = x.ensnare;
        j["homocerc"] = x.homocerc;
        j["hybridizer"] = x.hybridizer;
        j["leastwise"] = x.leastwise;
        j["lof"] = x.lof;
        j["monkhood"] = x.monkhood;
        j["Netherlandish"] = x.netherlandish;
        j["nonbookish"] = x.nonbookish;
        j["peonism"] = x.peonism;
        j["Phonelescope"] = x.phonelescope;
        j["porphyrogeniture"] = x.porphyrogeniture;
        j["preindemnify"] = x.preindemnify;
        j["rosal"] = x.rosal;
        j["scalenous"] = x.scalenous;
        j["scopine"] = x.scopine;
        j["Sedaceae"] = x.sedaceae;
        j["suberinize"] = x.suberinize;
        j["symbiot"] = x.symbiot;
        j["tablefellow"] = x.tablefellow;
        j["unchargeable"] = x.unchargeable;
    }

    inline void from_json(const json & j, CredulityClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.ammonolytic = get_untyped(j, "ammonolytic");
        x.bushmaster = get_untyped(j, "bushmaster");
        x.considering = get_untyped(j, "considering");
        x.consuetudinary = get_untyped(j, "consuetudinary");
        x.embarras = get_untyped(j, "embarras");
        x.fineness = get_untyped(j, "fineness");
        x.flaithship = get_untyped(j, "flaithship");
        x.flavia = get_untyped(j, "Flavia");
        x.gruffly = get_untyped(j, "gruffly");
        x.hedychium = get_untyped(j, "Hedychium");
        x.leadwort = get_untyped(j, "leadwort");
        x.overseriously = get_untyped(j, "overseriously");
        x.parabola = get_untyped(j, "parabola");
        x.pectinatodenticulate = get_untyped(j, "pectinatodenticulate");
        x.popean = get_untyped(j, "Popean");
        x.pornocrat = get_untyped(j, "pornocrat");
        x.quadrisect = get_untyped(j, "quadrisect");
        x.seriality = get_untyped(j, "seriality");
        x.vamphorn = get_untyped(j, "vamphorn");
        x.wharp = get_untyped(j, "wharp");
    }

    inline void to_json(json & j, const CredulityClass & x) {
        j = json::object();
        j["ammonolytic"] = x.ammonolytic;
        j["bushmaster"] = x.bushmaster;
        j["considering"] = x.considering;
        j["consuetudinary"] = x.consuetudinary;
        j["embarras"] = x.embarras;
        j["fineness"] = x.fineness;
        j["flaithship"] = x.flaithship;
        j["Flavia"] = x.flavia;
        j["gruffly"] = x.gruffly;
        j["Hedychium"] = x.hedychium;
        j["leadwort"] = x.leadwort;
        j["overseriously"] = x.overseriously;
        j["parabola"] = x.parabola;
        j["pectinatodenticulate"] = x.pectinatodenticulate;
        j["Popean"] = x.popean;
        j["pornocrat"] = x.pornocrat;
        j["quadrisect"] = x.quadrisect;
        j["seriality"] = x.seriality;
        j["vamphorn"] = x.vamphorn;
        j["wharp"] = x.wharp;
    }

    inline void from_json(const json & j, DeruralizeClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.bockerel = get_untyped(j, "bockerel");
        x.boulder = get_untyped(j, "boulder");
        x.churrus = get_untyped(j, "churrus");
        x.counterdigged = get_untyped(j, "counterdigged");
        x.dialogite = get_untyped(j, "dialogite");
        x.digenic = get_untyped(j, "digenic");
        x.dunbird = get_untyped(j, "dunbird");
        x.ergatogyne = get_untyped(j, "ergatogyne");
        x.fiendful = get_untyped(j, "fiendful");
        x.jackrod = get_untyped(j, "jackrod");
        x.jehovistic = get_untyped(j, "Jehovistic");
        x.paninean = get_untyped(j, "Paninean");
        x.panther = get_untyped(j, "panther");
        x.placentigerous = get_untyped(j, "placentigerous");
        x.romney = get_untyped(j, "Romney");
        x.sparm = get_untyped(j, "sparm");
        x.tocsin = get_untyped(j, "tocsin");
        x.unnicked = get_untyped(j, "unnicked");
        x.unstavable = get_untyped(j, "unstavable");
        x.windfirm = get_untyped(j, "windfirm");
    }

    inline void to_json(json & j, const DeruralizeClass & x) {
        j = json::object();
        j["bockerel"] = x.bockerel;
        j["boulder"] = x.boulder;
        j["churrus"] = x.churrus;
        j["counterdigged"] = x.counterdigged;
        j["dialogite"] = x.dialogite;
        j["digenic"] = x.digenic;
        j["dunbird"] = x.dunbird;
        j["ergatogyne"] = x.ergatogyne;
        j["fiendful"] = x.fiendful;
        j["jackrod"] = x.jackrod;
        j["Jehovistic"] = x.jehovistic;
        j["Paninean"] = x.paninean;
        j["panther"] = x.panther;
        j["placentigerous"] = x.placentigerous;
        j["Romney"] = x.romney;
        j["sparm"] = x.sparm;
        j["tocsin"] = x.tocsin;
        j["unnicked"] = x.unnicked;
        j["unstavable"] = x.unstavable;
        j["windfirm"] = x.windfirm;
    }

    inline void from_json(const json & j, DiaereseClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.amoreuxia = get_untyped(j, "Amoreuxia");
        x.ani = get_untyped(j, "ani");
        x.bernicle = get_untyped(j, "bernicle");
        x.blackwasher = get_untyped(j, "blackwasher");
        x.blowhard = get_untyped(j, "blowhard");
        x.broma = get_untyped(j, "broma");
        x.closecross = get_untyped(j, "closecross");
        x.congregationalism = get_untyped(j, "congregationalism");
        x.grayly = get_untyped(j, "grayly");
        x.historically = get_untyped(j, "historically");
        x.hoast = get_untyped(j, "hoast");
        x.irretentive = get_untyped(j, "irretentive");
        x.parcener = get_untyped(j, "parcener");
        x.pedder = get_untyped(j, "pedder");
        x.pseudoanatomic = get_untyped(j, "pseudoanatomic");
        x.rhizocarpian = get_untyped(j, "rhizocarpian");
        x.samel = get_untyped(j, "samel");
        x.silker = get_untyped(j, "silker");
        x.subdentated = get_untyped(j, "subdentated");
        x.subobscure = get_untyped(j, "subobscure");
    }

    inline void to_json(json & j, const DiaereseClass & x) {
        j = json::object();
        j["Amoreuxia"] = x.amoreuxia;
        j["ani"] = x.ani;
        j["bernicle"] = x.bernicle;
        j["blackwasher"] = x.blackwasher;
        j["blowhard"] = x.blowhard;
        j["broma"] = x.broma;
        j["closecross"] = x.closecross;
        j["congregationalism"] = x.congregationalism;
        j["grayly"] = x.grayly;
        j["historically"] = x.historically;
        j["hoast"] = x.hoast;
        j["irretentive"] = x.irretentive;
        j["parcener"] = x.parcener;
        j["pedder"] = x.pedder;
        j["pseudoanatomic"] = x.pseudoanatomic;
        j["rhizocarpian"] = x.rhizocarpian;
        j["samel"] = x.samel;
        j["silker"] = x.silker;
        j["subdentated"] = x.subdentated;
        j["subobscure"] = x.subobscure;
    }

    inline void from_json(const json & j, Encrust& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.comradely = get_untyped(j, "comradely");
        x.diacanthous = get_untyped(j, "diacanthous");
        x.feminineness = get_untyped(j, "feminineness");
        x.gossamered = get_untyped(j, "gossamered");
        x.hibernia = get_untyped(j, "Hibernia");
        x.hibiscus = get_untyped(j, "Hibiscus");
        x.lepidosauria = get_untyped(j, "Lepidosauria");
        x.lollingly = get_untyped(j, "lollingly");
        x.manager = get_untyped(j, "manager");
        x.mechanic = get_untyped(j, "mechanic");
        x.overminuteness = get_untyped(j, "overminuteness");
        x.papelonne = get_untyped(j, "papelonne");
        x.plebification = get_untyped(j, "plebification");
        x.pugmiller = get_untyped(j, "pugmiller");
        x.recoveror = get_untyped(j, "recoveror");
        x.spermatoblastic = get_untyped(j, "spermatoblastic");
        x.syllidae = get_untyped(j, "Syllidae");
        x.ungyved = get_untyped(j, "ungyved");
        x.whirlabout = get_untyped(j, "whirlabout");
        x.woodenware = get_untyped(j, "woodenware");
    }

    inline void to_json(json & j, const Encrust & x) {
        j = json::object();
        j["comradely"] = x.comradely;
        j["diacanthous"] = x.diacanthous;
        j["feminineness"] = x.feminineness;
        j["gossamered"] = x.gossamered;
        j["Hibernia"] = x.hibernia;
        j["Hibiscus"] = x.hibiscus;
        j["Lepidosauria"] = x.lepidosauria;
        j["lollingly"] = x.lollingly;
        j["manager"] = x.manager;
        j["mechanic"] = x.mechanic;
        j["overminuteness"] = x.overminuteness;
        j["papelonne"] = x.papelonne;
        j["plebification"] = x.plebification;
        j["pugmiller"] = x.pugmiller;
        j["recoveror"] = x.recoveror;
        j["spermatoblastic"] = x.spermatoblastic;
        j["Syllidae"] = x.syllidae;
        j["ungyved"] = x.ungyved;
        j["whirlabout"] = x.whirlabout;
        j["woodenware"] = x.woodenware;
    }

    inline void from_json(const json & j, FagginglyClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.abranchian = get_untyped(j, "abranchian");
        x.aculeiform = get_untyped(j, "aculeiform");
        x.adiaphoristic = get_untyped(j, "adiaphoristic");
        x.adoptionism = get_untyped(j, "adoptionism");
        x.anglic = get_untyped(j, "Anglic");
        x.antrotomy = get_untyped(j, "antrotomy");
        x.coerciveness = get_untyped(j, "coerciveness");
        x.decorist = get_untyped(j, "decorist");
        x.duckhood = get_untyped(j, "duckhood");
        x.heteromeri = get_untyped(j, "Heteromeri");
        x.hypochnose = get_untyped(j, "hypochnose");
        x.lochage = get_untyped(j, "lochage");
        x.melee = get_untyped(j, "melee");
        x.nonconformitant = get_untyped(j, "nonconformitant");
        x.poinsettia = get_untyped(j, "Poinsettia");
        x.putatively = get_untyped(j, "putatively");
        x.semivolatile = get_untyped(j, "semivolatile");
        x.soleas = get_untyped(j, "soleas");
        x.unfastenable = get_untyped(j, "unfastenable");
        x.unmillinered = get_untyped(j, "unmillinered");
    }

    inline void to_json(json & j, const FagginglyClass & x) {
        j = json::object();
        j["abranchian"] = x.abranchian;
        j["aculeiform"] = x.aculeiform;
        j["adiaphoristic"] = x.adiaphoristic;
        j["adoptionism"] = x.adoptionism;
        j["Anglic"] = x.anglic;
        j["antrotomy"] = x.antrotomy;
        j["coerciveness"] = x.coerciveness;
        j["decorist"] = x.decorist;
        j["duckhood"] = x.duckhood;
        j["Heteromeri"] = x.heteromeri;
        j["hypochnose"] = x.hypochnose;
        j["lochage"] = x.lochage;
        j["melee"] = x.melee;
        j["nonconformitant"] = x.nonconformitant;
        j["Poinsettia"] = x.poinsettia;
        j["putatively"] = x.putatively;
        j["semivolatile"] = x.semivolatile;
        j["soleas"] = x.soleas;
        j["unfastenable"] = x.unfastenable;
        j["unmillinered"] = x.unmillinered;
    }

    inline void from_json(const json & j, FenkClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.apoise = get_untyped(j, "apoise");
        x.astronomize = get_untyped(j, "astronomize");
        x.cockhorse = get_untyped(j, "cockhorse");
        x.copular = get_untyped(j, "copular");
        x.dagomba = get_untyped(j, "Dagomba");
        x.draffy = get_untyped(j, "draffy");
        x.foreigner = get_untyped(j, "foreigner");
        x.guyandot = get_untyped(j, "Guyandot");
        x.neurogliosis = get_untyped(j, "neurogliosis");
        x.osmious = get_untyped(j, "osmious");
        x.palpitate = get_untyped(j, "palpitate");
        x.rebukeable = get_untyped(j, "rebukeable");
        x.reinwardtia = get_untyped(j, "Reinwardtia");
        x.reservatory = get_untyped(j, "reservatory");
        x.scalt = get_untyped(j, "scalt");
        x.scripturalize = get_untyped(j, "scripturalize");
        x.tintometer = get_untyped(j, "tintometer");
        x.tritoness = get_untyped(j, "Tritoness");
        x.undergrade = get_untyped(j, "undergrade");
        x.undermountain = get_untyped(j, "undermountain");
    }

    inline void to_json(json & j, const FenkClass & x) {
        j = json::object();
        j["apoise"] = x.apoise;
        j["astronomize"] = x.astronomize;
        j["cockhorse"] = x.cockhorse;
        j["copular"] = x.copular;
        j["Dagomba"] = x.dagomba;
        j["draffy"] = x.draffy;
        j["foreigner"] = x.foreigner;
        j["Guyandot"] = x.guyandot;
        j["neurogliosis"] = x.neurogliosis;
        j["osmious"] = x.osmious;
        j["palpitate"] = x.palpitate;
        j["rebukeable"] = x.rebukeable;
        j["Reinwardtia"] = x.reinwardtia;
        j["reservatory"] = x.reservatory;
        j["scalt"] = x.scalt;
        j["scripturalize"] = x.scripturalize;
        j["tintometer"] = x.tintometer;
        j["Tritoness"] = x.tritoness;
        j["undergrade"] = x.undergrade;
        j["undermountain"] = x.undermountain;
    }

    inline void from_json(const json & j, FlagmakingClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.albarco = get_untyped(j, "albarco");
        x.bunodonta = get_untyped(j, "Bunodonta");
        x.hornify = get_untyped(j, "hornify");
        x.hydrocorisae = get_untyped(j, "Hydrocorisae");
        x.hypoglossus = get_untyped(j, "hypoglossus");
        x.inexpiably = get_untyped(j, "inexpiably");
        x.ingratitude = get_untyped(j, "ingratitude");
        x.ladyfly = get_untyped(j, "ladyfly");
        x.medicament = get_untyped(j, "medicament");
        x.monogrammatic = get_untyped(j, "monogrammatic");
        x.nobbut = get_untyped(j, "nobbut");
        x.notacanthidae = get_untyped(j, "Notacanthidae");
        x.polyplacophore = get_untyped(j, "polyplacophore");
        x.proexercise = get_untyped(j, "proexercise");
        x.protoplast = get_untyped(j, "protoplast");
        x.puzzling = get_untyped(j, "puzzling");
        x.splanchnoskeleton = get_untyped(j, "splanchnoskeleton");
        x.unloveliness = get_untyped(j, "unloveliness");
        x.unquarantined = get_untyped(j, "unquarantined");
        x.unrenounceable = get_untyped(j, "unrenounceable");
    }

    inline void to_json(json & j, const FlagmakingClass & x) {
        j = json::object();
        j["albarco"] = x.albarco;
        j["Bunodonta"] = x.bunodonta;
        j["hornify"] = x.hornify;
        j["Hydrocorisae"] = x.hydrocorisae;
        j["hypoglossus"] = x.hypoglossus;
        j["inexpiably"] = x.inexpiably;
        j["ingratitude"] = x.ingratitude;
        j["ladyfly"] = x.ladyfly;
        j["medicament"] = x.medicament;
        j["monogrammatic"] = x.monogrammatic;
        j["nobbut"] = x.nobbut;
        j["Notacanthidae"] = x.notacanthidae;
        j["polyplacophore"] = x.polyplacophore;
        j["proexercise"] = x.proexercise;
        j["protoplast"] = x.protoplast;
        j["puzzling"] = x.puzzling;
        j["splanchnoskeleton"] = x.splanchnoskeleton;
        j["unloveliness"] = x.unloveliness;
        j["unquarantined"] = x.unquarantined;
        j["unrenounceable"] = x.unrenounceable;
    }

    inline void from_json(const json & j, HemocoeleClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.acrogamy = get_untyped(j, "acrogamy");
        x.amelification = get_untyped(j, "amelification");
        x.autobiographic = get_untyped(j, "autobiographic");
        x.berat = get_untyped(j, "berat");
        if (j.find("catharticalness") != j.end() && j.at("catharticalness").is_null()) throw std::runtime_error("Unexpected null");
        x.catharticalness = get_stack_optional<double>(j, "catharticalness");
        if (j.find("Chirotherium") != j.end() && !j.at("Chirotherium").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("Chirotherium") != j.end() && j.at("Chirotherium").is_null()) throw std::runtime_error("Unexpected null");
        x.chirotherium = get_stack_optional<int64_t>(j, "Chirotherium");
        if (j.find("disdiapason") != j.end() && j.at("disdiapason").is_null()) throw std::runtime_error("Unexpected null");
        x.disdiapason = get_stack_optional<std::string>(j, "disdiapason");
        x.disproportionably = get_untyped(j, "disproportionably");
        x.erythrite = get_untyped(j, "erythrite");
        x.graphic = get_untyped(j, "graphic");
        x.hepatological = get_untyped(j, "hepatological");
        if (j.find("homocerc") != j.end() && j.at("homocerc").is_null()) throw std::runtime_error("Unexpected null");
        x.homocerc = get_stack_optional<bool>(j, "homocerc");
        x.incommensurably = get_untyped(j, "incommensurably");
        x.misaffirm = get_untyped(j, "misaffirm");
        x.nonbookish = get_untyped(j, "nonbookish");
        x.pocketbook = get_untyped(j, "pocketbook");
        x.sclerometric = get_untyped(j, "sclerometric");
        x.stambouline = get_untyped(j, "stambouline");
        x.stickpin = get_untyped(j, "stickpin");
        x.tubulure = get_untyped(j, "tubulure");
        x.undelated = get_untyped(j, "undelated");
        x.unsalt = get_untyped(j, "unsalt");
        x.untutelar = get_untyped(j, "untutelar");
        x.vagrant = get_untyped(j, "vagrant");
        x.walt = get_untyped(j, "Walt");
    }

    inline void to_json(json & j, const HemocoeleClass & x) {
        j = json::object();
        j["acrogamy"] = x.acrogamy;
        j["amelification"] = x.amelification;
        j["autobiographic"] = x.autobiographic;
        j["berat"] = x.berat;
        j["catharticalness"] = x.catharticalness;
        j["Chirotherium"] = x.chirotherium;
        j["disdiapason"] = x.disdiapason;
        j["disproportionably"] = x.disproportionably;
        j["erythrite"] = x.erythrite;
        j["graphic"] = x.graphic;
        j["hepatological"] = x.hepatological;
        j["homocerc"] = x.homocerc;
        j["incommensurably"] = x.incommensurably;
        j["misaffirm"] = x.misaffirm;
        j["nonbookish"] = x.nonbookish;
        j["pocketbook"] = x.pocketbook;
        j["sclerometric"] = x.sclerometric;
        j["stambouline"] = x.stambouline;
        j["stickpin"] = x.stickpin;
        j["tubulure"] = x.tubulure;
        j["undelated"] = x.undelated;
        j["unsalt"] = x.unsalt;
        j["untutelar"] = x.untutelar;
        j["vagrant"] = x.vagrant;
        j["Walt"] = x.walt;
    }

    inline void from_json(const json & j, Interacinar& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.assapan = j.at("assapan").get<double>();
        x.benefactorship = j.at("benefactorship").get<bool>();
        x.triseriatim = j.at("triseriatim").get<std::string>();
        if (j.find("tubbing") != j.end() && !j.at("tubbing").is_number_integer()) throw std::runtime_error("Expected integer");
        x.tubbing = j.at("tubbing").get<int64_t>();
        x.untrimmed = get_untyped(j, "untrimmed");
    }

    inline void to_json(json & j, const Interacinar & x) {
        j = json::object();
        j["assapan"] = x.assapan;
        j["benefactorship"] = x.benefactorship;
        j["triseriatim"] = x.triseriatim;
        j["tubbing"] = x.tubbing;
        j["untrimmed"] = x.untrimmed;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.centrodesmose = j.at("centrodesmose").get<std::string>();
        x.cerograph = j.at("cerograph").get<std::vector<CerographElement>>();
        x.chemotherapeutics = j.at("chemotherapeutics").get<std::vector<ChemotherapeuticElement>>();
        x.cimelia = j.at("cimelia").get<std::vector<CimeliaElement>>();
        if (j.find("citrated") != j.end() && !j.at("citrated").is_number_integer()) throw std::runtime_error("Expected integer");
        x.citrated = j.at("citrated").get<int64_t>();
        x.clinodome = j.at("clinodome").get<std::vector<Clinodome>>();
        x.coadjust = j.at("coadjust").get<std::vector<CoadjustElement>>();
        x.consilience = j.at("consilience").get<std::vector<Consilience>>();
        x.constructor = j.at("constructor").get<std::vector<Constructor>>();
        x.continuative = j.at("continuative").get<std::vector<Continuative>>();
        x.credulity = j.at("credulity").get<std::vector<CredulityElement>>();
        x.creviced = j.at("creviced").get<std::vector<Creviced>>();
        x.cubiculum = j.at("cubiculum").get<std::vector<std::vector<std::optional<int64_t>>>>();
        x.deruralize = j.at("deruralize").get<std::vector<DeruralizeElement>>();
        x.diaereses = j.at("diaereses").get<std::vector<DiaereseElement>>();
        x.dissolution = j.at("dissolution").get<std::vector<std::optional<std::vector<nlohmann::json>>>>();
        x.downstroke = j.at("downstroke").get<std::vector<Downstroke>>();
        x.electrotautomerism = j.at("electrotautomerism").get<std::vector<std::optional<double>>>();
        x.eleutheromania = j.at("eleutheromania").get<std::vector<Eleutheromania>>();
        x.encrust = j.at("encrust").get<Encrust>();
        x.entomoid = j.at("entomoid").get<std::vector<Entomoid>>();
        x.epipaleolithic = j.at("epipaleolithic").get<std::vector<Epipaleolithic>>();
        x.expropriable = j.at("expropriable").get<std::vector<Expropriable>>();
        x.faggingly = j.at("faggingly").get<std::vector<FagginglyElement>>();
        x.fenks = j.at("fenks").get<std::vector<FenkElement>>();
        x.flagmaking = j.at("flagmaking").get<std::vector<FlagmakingElement>>();
        x.fluorometer = j.at("fluorometer").get<std::vector<Fluorometer>>();
        x.fulsome = j.at("fulsome").get<std::vector<std::optional<int64_t>>>();
        x.fuzzy = j.at("fuzzy").get<std::vector<Fuzzy>>();
        x.gardenwards = j.at("gardenwards").get<std::vector<Gardenward>>();
        x.generalissimo = j.at("generalissimo").get<std::vector<Generalissimo>>();
        x.habeas = j.at("habeas").get<std::vector<std::optional<std::map<std::string, int64_t>>>>();
        x.hemicrystalline = j.at("hemicrystalline").get<std::vector<Hemicrystalline>>();
        x.hemocoele = j.at("hemocoele").get<std::vector<HemocoeleElement>>();
        x.hoister = j.at("hoister").get<std::vector<Hoister>>();
        x.hyperpiesis = j.at("hyperpiesis").get<std::vector<Hyperpiesi>>();
        x.hyppish = j.at("hyppish").get<std::vector<Hyppish>>();
        x.idealizer = j.at("idealizer").get<std::vector<Idealizer>>();
        x.incrustator = j.at("incrustator").get<std::vector<Incrustator>>();
        x.intentiveness = j.at("intentiveness").get<std::vector<Intentiveness>>();
        x.interacinar = j.at("interacinar").get<Interacinar>();
        x.intercorrelation = j.at("intercorrelation").get<std::vector<std::optional<std::vector<int64_t>>>>();
        x.jacutinga = j.at("jacutinga").get<std::vector<Jacutinga>>();
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["centrodesmose"] = x.centrodesmose;
        j["cerograph"] = x.cerograph;
        j["chemotherapeutics"] = x.chemotherapeutics;
        j["cimelia"] = x.cimelia;
        j["citrated"] = x.citrated;
        j["clinodome"] = x.clinodome;
        j["coadjust"] = x.coadjust;
        j["consilience"] = x.consilience;
        j["constructor"] = x.constructor;
        j["continuative"] = x.continuative;
        j["credulity"] = x.credulity;
        j["creviced"] = x.creviced;
        j["cubiculum"] = x.cubiculum;
        j["deruralize"] = x.deruralize;
        j["diaereses"] = x.diaereses;
        j["dissolution"] = x.dissolution;
        j["downstroke"] = x.downstroke;
        j["electrotautomerism"] = x.electrotautomerism;
        j["eleutheromania"] = x.eleutheromania;
        j["encrust"] = x.encrust;
        j["entomoid"] = x.entomoid;
        j["epipaleolithic"] = x.epipaleolithic;
        j["expropriable"] = x.expropriable;
        j["faggingly"] = x.faggingly;
        j["fenks"] = x.fenks;
        j["flagmaking"] = x.flagmaking;
        j["fluorometer"] = x.fluorometer;
        j["fulsome"] = x.fulsome;
        j["fuzzy"] = x.fuzzy;
        j["gardenwards"] = x.gardenwards;
        j["generalissimo"] = x.generalissimo;
        j["habeas"] = x.habeas;
        j["hemicrystalline"] = x.hemicrystalline;
        j["hemocoele"] = x.hemocoele;
        j["hoister"] = x.hoister;
        j["hyperpiesis"] = x.hyperpiesis;
        j["hyppish"] = x.hyppish;
        j["idealizer"] = x.idealizer;
        j["incrustator"] = x.incrustator;
        j["intentiveness"] = x.intentiveness;
        j["interacinar"] = x.interacinar;
        j["intercorrelation"] = x.intercorrelation;
        j["jacutinga"] = x.jacutinga;
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
