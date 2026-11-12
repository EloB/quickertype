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

    enum class Fall : int { FELL, FOUND };

    enum class Type : int { POINT };

    class Geolocation {
        public:
        Geolocation() = default;
        virtual ~Geolocation() = default;

        private:
        std::vector<double> coordinates;
        Type type;

        public:
        const std::vector<double> & get_coordinates() const { return coordinates; }
        std::vector<double> & get_mutable_coordinates() { return coordinates; }
        void set_coordinates(const std::vector<double> & value) { this->coordinates = value; }

        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    enum class Nametype : int { VALID };

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        std::optional<std::string> computed_region_cbhk_fwbd;
        std::optional<std::string> computed_region_nnqa_25_f4;
        Fall fall;
        std::optional<Geolocation> geolocation;
        std::string id;
        std::optional<std::string> mass;
        std::string name;
        Nametype nametype;
        std::string recclass;
        std::optional<std::string> reclat;
        std::optional<std::string> reclong;
        std::optional<std::string> year;

        public:
        const std::optional<std::string> & get_computed_region_cbhk_fwbd() const { return computed_region_cbhk_fwbd; }
        std::optional<std::string> & get_mutable_computed_region_cbhk_fwbd() { return computed_region_cbhk_fwbd; }
        void set_computed_region_cbhk_fwbd(const std::optional<std::string> & value) { this->computed_region_cbhk_fwbd = value; }

        const std::optional<std::string> & get_computed_region_nnqa_25__f4() const { return computed_region_nnqa_25_f4; }
        std::optional<std::string> & get_mutable_computed_region_nnqa_25__f4() { return computed_region_nnqa_25_f4; }
        void set_computed_region_nnqa_25__f4(const std::optional<std::string> & value) { this->computed_region_nnqa_25_f4 = value; }

        const Fall & get_fall() const { return fall; }
        Fall & get_mutable_fall() { return fall; }
        void set_fall(const Fall & value) { this->fall = value; }

        const std::optional<Geolocation> & get_geolocation() const { return geolocation; }
        std::optional<Geolocation> & get_mutable_geolocation() { return geolocation; }
        void set_geolocation(const std::optional<Geolocation> & value) { this->geolocation = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::optional<std::string> & get_mass() const { return mass; }
        std::optional<std::string> & get_mutable_mass() { return mass; }
        void set_mass(const std::optional<std::string> & value) { this->mass = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const Nametype & get_nametype() const { return nametype; }
        Nametype & get_mutable_nametype() { return nametype; }
        void set_nametype(const Nametype & value) { this->nametype = value; }

        const std::string & get_recclass() const { return recclass; }
        std::string & get_mutable_recclass() { return recclass; }
        void set_recclass(const std::string & value) { this->recclass = value; }

        const std::optional<std::string> & get_reclat() const { return reclat; }
        std::optional<std::string> & get_mutable_reclat() { return reclat; }
        void set_reclat(const std::optional<std::string> & value) { this->reclat = value; }

        const std::optional<std::string> & get_reclong() const { return reclong; }
        std::optional<std::string> & get_mutable_reclong() { return reclong; }
        void set_reclong(const std::optional<std::string> & value) { this->reclong = value; }

        const std::optional<std::string> & get_year() const { return year; }
        std::optional<std::string> & get_mutable_year() { return year; }
        void set_year(const std::optional<std::string> & value) { this->year = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, Geolocation & x);
    void to_json(json & j, const Geolocation & x);

    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    void from_json(const json & j, Fall & x);
    void to_json(json & j, const Fall & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    void from_json(const json & j, Nametype & x);
    void to_json(json & j, const Nametype & x);

    inline void from_json(const json & j, Geolocation& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_coordinates(j.at("coordinates").get<std::vector<double>>());
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const Geolocation & x) {
        j = json::object();
        j["coordinates"] = x.get_coordinates();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find(":@computed_region_cbhk_fwbd") != j.end() && j.at(":@computed_region_cbhk_fwbd").is_null()) throw std::runtime_error("Unexpected null");
        x.set_computed_region_cbhk_fwbd(get_stack_optional<std::string>(j, ":@computed_region_cbhk_fwbd"));
        if (j.find(":@computed_region_nnqa_25f4") != j.end() && j.at(":@computed_region_nnqa_25f4").is_null()) throw std::runtime_error("Unexpected null");
        x.set_computed_region_nnqa_25__f4(get_stack_optional<std::string>(j, ":@computed_region_nnqa_25f4"));
        x.set_fall(j.at("fall").get<Fall>());
        if (j.find("geolocation") != j.end() && j.at("geolocation").is_null()) throw std::runtime_error("Unexpected null");
        x.set_geolocation(get_stack_optional<Geolocation>(j, "geolocation"));
        x.set_id(j.at("id").get<std::string>());
        if (j.find("mass") != j.end() && j.at("mass").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mass(get_stack_optional<std::string>(j, "mass"));
        x.set_name(j.at("name").get<std::string>());
        x.set_nametype(j.at("nametype").get<Nametype>());
        x.set_recclass(j.at("recclass").get<std::string>());
        if (j.find("reclat") != j.end() && j.at("reclat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reclat(get_stack_optional<std::string>(j, "reclat"));
        if (j.find("reclong") != j.end() && j.at("reclong").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reclong(get_stack_optional<std::string>(j, "reclong"));
        if (j.find("year") != j.end() && !std::regex_match(j.at("year").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        if (j.find("year") != j.end() && j.at("year").is_null()) throw std::runtime_error("Unexpected null");
        x.set_year(get_stack_optional<std::string>(j, "year"));
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j[":@computed_region_cbhk_fwbd"] = x.get_computed_region_cbhk_fwbd();
        j[":@computed_region_nnqa_25f4"] = x.get_computed_region_nnqa_25__f4();
        j["fall"] = x.get_fall();
        j["geolocation"] = x.get_geolocation();
        j["id"] = x.get_id();
        j["mass"] = x.get_mass();
        j["name"] = x.get_name();
        j["nametype"] = x.get_nametype();
        j["recclass"] = x.get_recclass();
        j["reclat"] = x.get_reclat();
        j["reclong"] = x.get_reclong();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, Fall & x) {
        if (j == "Fell") x = Fall::FELL;
        else if (j == "Found") x = Fall::FOUND;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Fall\""); }
    }

    inline void to_json(json & j, const Fall & x) {
        switch (x) {
            case Fall::FELL: j = "Fell"; break;
            case Fall::FOUND: j = "Found"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Fall\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "Point") x = Type::POINT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::POINT: j = "Point"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Nametype & x) {
        if (j == "Valid") x = Nametype::VALID;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Nametype\""); }
    }

    inline void to_json(json & j, const Nametype & x) {
        switch (x) {
            case Nametype::VALID: j = "Valid"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Nametype\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
