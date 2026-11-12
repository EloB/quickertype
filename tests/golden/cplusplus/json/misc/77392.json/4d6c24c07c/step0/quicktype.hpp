//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
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

    enum class OrbitClass : int { APOLLO, AMOR, ATEN, COMET, JUPITER_FAMILY_COMET, HALLEY_TYPE_COMET, PARABOLIC_COMET, ORBIT_CLASS_JUPITER_FAMILY_COMET, ENCKE_TYPE_COMET };

    enum class Pha : int { Y, N, N_A };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        std::string designation;
        std::string discovery_date;
        std::optional<std::string> h_mag;
        std::string i_deg;
        std::string moid_au;
        OrbitClass orbit_class;
        std::optional<std::string> period_yr;
        Pha pha;
        std::string q_au_1;
        std::optional<std::string> q_au_2;

        public:
        const std::string & get_designation() const { return designation; }
        std::string & get_mutable_designation() { return designation; }
        void set_designation(const std::string & value) { this->designation = value; }

        const std::string & get_discovery_date() const { return discovery_date; }
        std::string & get_mutable_discovery_date() { return discovery_date; }
        void set_discovery_date(const std::string & value) { this->discovery_date = value; }

        const std::optional<std::string> & get_h_mag() const { return h_mag; }
        std::optional<std::string> & get_mutable_h_mag() { return h_mag; }
        void set_h_mag(const std::optional<std::string> & value) { this->h_mag = value; }

        const std::string & get_i_deg() const { return i_deg; }
        std::string & get_mutable_i_deg() { return i_deg; }
        void set_i_deg(const std::string & value) { this->i_deg = value; }

        const std::string & get_moid_au() const { return moid_au; }
        std::string & get_mutable_moid_au() { return moid_au; }
        void set_moid_au(const std::string & value) { this->moid_au = value; }

        const OrbitClass & get_orbit_class() const { return orbit_class; }
        OrbitClass & get_mutable_orbit_class() { return orbit_class; }
        void set_orbit_class(const OrbitClass & value) { this->orbit_class = value; }

        const std::optional<std::string> & get_period_yr() const { return period_yr; }
        std::optional<std::string> & get_mutable_period_yr() { return period_yr; }
        void set_period_yr(const std::optional<std::string> & value) { this->period_yr = value; }

        const Pha & get_pha() const { return pha; }
        Pha & get_mutable_pha() { return pha; }
        void set_pha(const Pha & value) { this->pha = value; }

        const std::string & get_q_au_1() const { return q_au_1; }
        std::string & get_mutable_q_au_1() { return q_au_1; }
        void set_q_au_1(const std::string & value) { this->q_au_1 = value; }

        const std::optional<std::string> & get_q_au_2() const { return q_au_2; }
        std::optional<std::string> & get_mutable_q_au_2() { return q_au_2; }
        void set_q_au_2(const std::optional<std::string> & value) { this->q_au_2 = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, OrbitClass & x);
    void to_json(json & j, const OrbitClass & x);

    void from_json(const json & j, Pha & x);
    void to_json(json & j, const Pha & x);

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_designation(j.at("designation").get<std::string>());
        if (j.find("discovery_date") != j.end() && !std::regex_match(j.at("discovery_date").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_discovery_date(j.at("discovery_date").get<std::string>());
        if (j.find("h_mag") != j.end() && j.at("h_mag").is_null()) throw std::runtime_error("Unexpected null");
        x.set_h_mag(get_stack_optional<std::string>(j, "h_mag"));
        x.set_i_deg(j.at("i_deg").get<std::string>());
        x.set_moid_au(j.at("moid_au").get<std::string>());
        x.set_orbit_class(j.at("orbit_class").get<OrbitClass>());
        if (j.find("period_yr") != j.end() && j.at("period_yr").is_null()) throw std::runtime_error("Unexpected null");
        x.set_period_yr(get_stack_optional<std::string>(j, "period_yr"));
        x.set_pha(j.at("pha").get<Pha>());
        x.set_q_au_1(j.at("q_au_1").get<std::string>());
        if (j.find("q_au_2") != j.end() && j.at("q_au_2").is_null()) throw std::runtime_error("Unexpected null");
        x.set_q_au_2(get_stack_optional<std::string>(j, "q_au_2"));
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["designation"] = x.get_designation();
        j["discovery_date"] = x.get_discovery_date();
        j["h_mag"] = x.get_h_mag();
        j["i_deg"] = x.get_i_deg();
        j["moid_au"] = x.get_moid_au();
        j["orbit_class"] = x.get_orbit_class();
        j["period_yr"] = x.get_period_yr();
        j["pha"] = x.get_pha();
        j["q_au_1"] = x.get_q_au_1();
        j["q_au_2"] = x.get_q_au_2();
    }

    inline void from_json(const json & j, OrbitClass & x) {
        if (j == "Apollo") x = OrbitClass::APOLLO;
        else if (j == "Amor") x = OrbitClass::AMOR;
        else if (j == "Aten") x = OrbitClass::ATEN;
        else if (j == "Comet") x = OrbitClass::COMET;
        else if (j == "Jupiter-family Comet") x = OrbitClass::JUPITER_FAMILY_COMET;
        else if (j == "Halley-type Comet*") x = OrbitClass::HALLEY_TYPE_COMET;
        else if (j == "Parabolic Comet") x = OrbitClass::PARABOLIC_COMET;
        else if (j == "Jupiter-family Comet*") x = OrbitClass::ORBIT_CLASS_JUPITER_FAMILY_COMET;
        else if (j == "Encke-type Comet") x = OrbitClass::ENCKE_TYPE_COMET;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"OrbitClass\""); }
    }

    inline void to_json(json & j, const OrbitClass & x) {
        switch (x) {
            case OrbitClass::APOLLO: j = "Apollo"; break;
            case OrbitClass::AMOR: j = "Amor"; break;
            case OrbitClass::ATEN: j = "Aten"; break;
            case OrbitClass::COMET: j = "Comet"; break;
            case OrbitClass::JUPITER_FAMILY_COMET: j = "Jupiter-family Comet"; break;
            case OrbitClass::HALLEY_TYPE_COMET: j = "Halley-type Comet*"; break;
            case OrbitClass::PARABOLIC_COMET: j = "Parabolic Comet"; break;
            case OrbitClass::ORBIT_CLASS_JUPITER_FAMILY_COMET: j = "Jupiter-family Comet*"; break;
            case OrbitClass::ENCKE_TYPE_COMET: j = "Encke-type Comet"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"OrbitClass\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Pha & x) {
        if (j == "Y") x = Pha::Y;
        else if (j == "N") x = Pha::N;
        else if (j == "n/a") x = Pha::N_A;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Pha\""); }
    }

    inline void to_json(json & j, const Pha & x) {
        switch (x) {
            case Pha::Y: j = "Y"; break;
            case Pha::N: j = "N"; break;
            case Pha::N_A: j = "n/a"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Pha\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
