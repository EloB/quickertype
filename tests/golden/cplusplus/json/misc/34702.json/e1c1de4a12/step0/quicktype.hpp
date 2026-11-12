//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>
#include <unordered_map>

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

    class CrsProperties {
        public:
        CrsProperties() = default;
        virtual ~CrsProperties() = default;

        private:
        std::string name;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    class Crs {
        public:
        Crs() = default;
        virtual ~Crs() = default;

        private:
        CrsProperties properties;
        std::string type;

        public:
        const CrsProperties & get_properties() const { return properties; }
        CrsProperties & get_mutable_properties() { return properties; }
        void set_properties(const CrsProperties & value) { this->properties = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };

    enum class GeometryType : int { POINT };

    class Geometry {
        public:
        Geometry() = default;
        virtual ~Geometry() = default;

        private:
        std::vector<double> coordinates;
        GeometryType type;

        public:
        const std::vector<double> & get_coordinates() const { return coordinates; }
        std::vector<double> & get_mutable_coordinates() { return coordinates; }
        void set_coordinates(const std::vector<double> & value) { this->coordinates = value; }

        const GeometryType & get_type() const { return type; }
        GeometryType & get_mutable_type() { return type; }
        void set_type(const GeometryType & value) { this->type = value; }
    };

    enum class GeometryName : int { GEOM };

    enum class FireBanR : int { NORTH_CENTRAL, CENTRAL, SOUTH_WEST, WIMMERA, NORTHERN_COUNTRY, EAST_GIPPSLAND, NORTH_EAST, MALLEE, WEST_SOUTH_GIPPSLAND, BALLARAT };

    enum class Region : int { EASTERN, NORTHERN_METRO, WESTERN, SOUTHERN_METRO };

    enum class PropertiesType : int { STREET, AVENUE, ROAD, HIGHWAY, BOULEVARD, COURT, WAY, DRIVE, SOUTH, HILL, LANE, CLOSE, PARADE, TYPE_ROAD, PLACE, RD };

    class FeatureProperties {
        public:
        FeatureProperties() = default;
        virtual ~FeatureProperties() = default;

        private:
        std::string division;
        double fax;
        std::optional<FireBanR> fire_ban_r;
        double latitude;
        std::string local_govt;
        double longitude;
        std::optional<std::string> no;
        double phone;
        int64_t postcode;
        std::string psa;
        Region region;
        std::string station;
        std::string street;
        std::string suburb;
        std::optional<PropertiesType> type;

        public:
        const std::string & get_division() const { return division; }
        std::string & get_mutable_division() { return division; }
        void set_division(const std::string & value) { this->division = value; }

        const double & get_fax() const { return fax; }
        double & get_mutable_fax() { return fax; }
        void set_fax(const double & value) { this->fax = value; }

        std::optional<FireBanR> get_fire_ban_r() const { return fire_ban_r; }
        void set_fire_ban_r(std::optional<FireBanR> value) { this->fire_ban_r = value; }

        const double & get_latitude() const { return latitude; }
        double & get_mutable_latitude() { return latitude; }
        void set_latitude(const double & value) { this->latitude = value; }

        const std::string & get_local_govt() const { return local_govt; }
        std::string & get_mutable_local_govt() { return local_govt; }
        void set_local_govt(const std::string & value) { this->local_govt = value; }

        const double & get_longitude() const { return longitude; }
        double & get_mutable_longitude() { return longitude; }
        void set_longitude(const double & value) { this->longitude = value; }

        std::optional<std::string> get_no() const { return no; }
        void set_no(std::optional<std::string> value) { this->no = value; }

        const double & get_phone() const { return phone; }
        double & get_mutable_phone() { return phone; }
        void set_phone(const double & value) { this->phone = value; }

        const int64_t & get_postcode() const { return postcode; }
        int64_t & get_mutable_postcode() { return postcode; }
        void set_postcode(const int64_t & value) { this->postcode = value; }

        const std::string & get_psa() const { return psa; }
        std::string & get_mutable_psa() { return psa; }
        void set_psa(const std::string & value) { this->psa = value; }

        const Region & get_region() const { return region; }
        Region & get_mutable_region() { return region; }
        void set_region(const Region & value) { this->region = value; }

        const std::string & get_station() const { return station; }
        std::string & get_mutable_station() { return station; }
        void set_station(const std::string & value) { this->station = value; }

        const std::string & get_street() const { return street; }
        std::string & get_mutable_street() { return street; }
        void set_street(const std::string & value) { this->street = value; }

        const std::string & get_suburb() const { return suburb; }
        std::string & get_mutable_suburb() { return suburb; }
        void set_suburb(const std::string & value) { this->suburb = value; }

        std::optional<PropertiesType> get_type() const { return type; }
        void set_type(std::optional<PropertiesType> value) { this->type = value; }
    };

    enum class FeatureType : int { FEATURE };

    class Feature {
        public:
        Feature() = default;
        virtual ~Feature() = default;

        private:
        Geometry geometry;
        GeometryName geometry_name;
        std::string id;
        FeatureProperties properties;
        FeatureType type;

        public:
        const Geometry & get_geometry() const { return geometry; }
        Geometry & get_mutable_geometry() { return geometry; }
        void set_geometry(const Geometry & value) { this->geometry = value; }

        const GeometryName & get_geometry_name() const { return geometry_name; }
        GeometryName & get_mutable_geometry_name() { return geometry_name; }
        void set_geometry_name(const GeometryName & value) { this->geometry_name = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const FeatureProperties & get_properties() const { return properties; }
        FeatureProperties & get_mutable_properties() { return properties; }
        void set_properties(const FeatureProperties & value) { this->properties = value; }

        const FeatureType & get_type() const { return type; }
        FeatureType & get_mutable_type() { return type; }
        void set_type(const FeatureType & value) { this->type = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Crs crs;
        std::vector<Feature> features;
        int64_t total_features;
        std::string type;

        public:
        const Crs & get_crs() const { return crs; }
        Crs & get_mutable_crs() { return crs; }
        void set_crs(const Crs & value) { this->crs = value; }

        const std::vector<Feature> & get_features() const { return features; }
        std::vector<Feature> & get_mutable_features() { return features; }
        void set_features(const std::vector<Feature> & value) { this->features = value; }

        const int64_t & get_total_features() const { return total_features; }
        int64_t & get_mutable_total_features() { return total_features; }
        void set_total_features(const int64_t & value) { this->total_features = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, CrsProperties & x);
    void to_json(json & j, const CrsProperties & x);

    void from_json(const json & j, Crs & x);
    void to_json(json & j, const Crs & x);

    void from_json(const json & j, Geometry & x);
    void to_json(json & j, const Geometry & x);

    void from_json(const json & j, FeatureProperties & x);
    void to_json(json & j, const FeatureProperties & x);

    void from_json(const json & j, Feature & x);
    void to_json(json & j, const Feature & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, GeometryType & x);
    void to_json(json & j, const GeometryType & x);

    void from_json(const json & j, GeometryName & x);
    void to_json(json & j, const GeometryName & x);

    void from_json(const json & j, FireBanR & x);
    void to_json(json & j, const FireBanR & x);

    void from_json(const json & j, Region & x);
    void to_json(json & j, const Region & x);

    void from_json(const json & j, PropertiesType & x);
    void to_json(json & j, const PropertiesType & x);

    void from_json(const json & j, FeatureType & x);
    void to_json(json & j, const FeatureType & x);

    inline void from_json(const json & j, CrsProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const CrsProperties & x) {
        j = json::object();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, Crs& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_properties(j.at("properties").get<CrsProperties>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const Crs & x) {
        j = json::object();
        j["properties"] = x.get_properties();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Geometry& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_coordinates(j.at("coordinates").get<std::vector<double>>());
        x.set_type(j.at("type").get<GeometryType>());
    }

    inline void to_json(json & j, const Geometry & x) {
        j = json::object();
        j["coordinates"] = x.get_coordinates();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, FeatureProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_division(j.at("division").get<std::string>());
        x.set_fax(j.at("fax").get<double>());
        j.at("fire_ban_r");
        x.set_fire_ban_r(get_stack_optional<FireBanR>(j, "fire_ban_r"));
        x.set_latitude(j.at("latitude").get<double>());
        x.set_local_govt(j.at("local_govt").get<std::string>());
        x.set_longitude(j.at("longitude").get<double>());
        j.at("no");
        x.set_no(get_stack_optional<std::string>(j, "no"));
        x.set_phone(j.at("phone").get<double>());
        if (j.find("postcode") != j.end() && !j.at("postcode").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_postcode(j.at("postcode").get<int64_t>());
        x.set_psa(j.at("psa").get<std::string>());
        x.set_region(j.at("region").get<Region>());
        x.set_station(j.at("station").get<std::string>());
        x.set_street(j.at("street").get<std::string>());
        x.set_suburb(j.at("suburb").get<std::string>());
        j.at("type");
        x.set_type(get_stack_optional<PropertiesType>(j, "type"));
    }

    inline void to_json(json & j, const FeatureProperties & x) {
        j = json::object();
        j["division"] = x.get_division();
        j["fax"] = x.get_fax();
        j["fire_ban_r"] = x.get_fire_ban_r();
        j["latitude"] = x.get_latitude();
        j["local_govt"] = x.get_local_govt();
        j["longitude"] = x.get_longitude();
        j["no"] = x.get_no();
        j["phone"] = x.get_phone();
        j["postcode"] = x.get_postcode();
        j["psa"] = x.get_psa();
        j["region"] = x.get_region();
        j["station"] = x.get_station();
        j["street"] = x.get_street();
        j["suburb"] = x.get_suburb();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Feature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_geometry(j.at("geometry").get<Geometry>());
        x.set_geometry_name(j.at("geometry_name").get<GeometryName>());
        x.set_id(j.at("id").get<std::string>());
        x.set_properties(j.at("properties").get<FeatureProperties>());
        x.set_type(j.at("type").get<FeatureType>());
    }

    inline void to_json(json & j, const Feature & x) {
        j = json::object();
        j["geometry"] = x.get_geometry();
        j["geometry_name"] = x.get_geometry_name();
        j["id"] = x.get_id();
        j["properties"] = x.get_properties();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_crs(j.at("crs").get<Crs>());
        x.set_features(j.at("features").get<std::vector<Feature>>());
        if (j.find("totalFeatures") != j.end() && !j.at("totalFeatures").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total_features(j.at("totalFeatures").get<int64_t>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["crs"] = x.get_crs();
        j["features"] = x.get_features();
        j["totalFeatures"] = x.get_total_features();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, GeometryType & x) {
        if (j == "Point") x = GeometryType::POINT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"GeometryType\""); }
    }

    inline void to_json(json & j, const GeometryType & x) {
        switch (x) {
            case GeometryType::POINT: j = "Point"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"GeometryType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, GeometryName & x) {
        if (j == "geom") x = GeometryName::GEOM;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"GeometryName\""); }
    }

    inline void to_json(json & j, const GeometryName & x) {
        switch (x) {
            case GeometryName::GEOM: j = "geom"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"GeometryName\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FireBanR & x) {
        if (j == "North Central") x = FireBanR::NORTH_CENTRAL;
        else if (j == "Central") x = FireBanR::CENTRAL;
        else if (j == "South West") x = FireBanR::SOUTH_WEST;
        else if (j == "Wimmera") x = FireBanR::WIMMERA;
        else if (j == "Northern Country") x = FireBanR::NORTHERN_COUNTRY;
        else if (j == "East Gippsland") x = FireBanR::EAST_GIPPSLAND;
        else if (j == "North East") x = FireBanR::NORTH_EAST;
        else if (j == "Mallee") x = FireBanR::MALLEE;
        else if (j == "West &South Gippsland") x = FireBanR::WEST_SOUTH_GIPPSLAND;
        else if (j == "Ballarat") x = FireBanR::BALLARAT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FireBanR\""); }
    }

    inline void to_json(json & j, const FireBanR & x) {
        switch (x) {
            case FireBanR::NORTH_CENTRAL: j = "North Central"; break;
            case FireBanR::CENTRAL: j = "Central"; break;
            case FireBanR::SOUTH_WEST: j = "South West"; break;
            case FireBanR::WIMMERA: j = "Wimmera"; break;
            case FireBanR::NORTHERN_COUNTRY: j = "Northern Country"; break;
            case FireBanR::EAST_GIPPSLAND: j = "East Gippsland"; break;
            case FireBanR::NORTH_EAST: j = "North East"; break;
            case FireBanR::MALLEE: j = "Mallee"; break;
            case FireBanR::WEST_SOUTH_GIPPSLAND: j = "West &South Gippsland"; break;
            case FireBanR::BALLARAT: j = "Ballarat"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FireBanR\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Region & x) {
        if (j == "Eastern") x = Region::EASTERN;
        else if (j == "Northern Metro") x = Region::NORTHERN_METRO;
        else if (j == "Western") x = Region::WESTERN;
        else if (j == "Southern Metro") x = Region::SOUTHERN_METRO;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Region\""); }
    }

    inline void to_json(json & j, const Region & x) {
        switch (x) {
            case Region::EASTERN: j = "Eastern"; break;
            case Region::NORTHERN_METRO: j = "Northern Metro"; break;
            case Region::WESTERN: j = "Western"; break;
            case Region::SOUTHERN_METRO: j = "Southern Metro"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Region\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, PropertiesType & x) {
        static std::unordered_map<std::string, PropertiesType> enumValues {
            {"STREET", PropertiesType::STREET},
            {"AVENUE", PropertiesType::AVENUE},
            {"ROAD", PropertiesType::ROAD},
            {"HIGHWAY", PropertiesType::HIGHWAY},
            {"BOULEVARD", PropertiesType::BOULEVARD},
            {"COURT", PropertiesType::COURT},
            {"WAY", PropertiesType::WAY},
            {"DRIVE", PropertiesType::DRIVE},
            {"SOUTH", PropertiesType::SOUTH},
            {"HILL", PropertiesType::HILL},
            {"LANE", PropertiesType::LANE},
            {"CLOSE", PropertiesType::CLOSE},
            {"PARADE", PropertiesType::PARADE},
            {"Road", PropertiesType::TYPE_ROAD},
            {"PLACE", PropertiesType::PLACE},
            {"RD", PropertiesType::RD},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PropertiesType\""); }
    }

    inline void to_json(json & j, const PropertiesType & x) {
        switch (x) {
            case PropertiesType::STREET: j = "STREET"; break;
            case PropertiesType::AVENUE: j = "AVENUE"; break;
            case PropertiesType::ROAD: j = "ROAD"; break;
            case PropertiesType::HIGHWAY: j = "HIGHWAY"; break;
            case PropertiesType::BOULEVARD: j = "BOULEVARD"; break;
            case PropertiesType::COURT: j = "COURT"; break;
            case PropertiesType::WAY: j = "WAY"; break;
            case PropertiesType::DRIVE: j = "DRIVE"; break;
            case PropertiesType::SOUTH: j = "SOUTH"; break;
            case PropertiesType::HILL: j = "HILL"; break;
            case PropertiesType::LANE: j = "LANE"; break;
            case PropertiesType::CLOSE: j = "CLOSE"; break;
            case PropertiesType::PARADE: j = "PARADE"; break;
            case PropertiesType::TYPE_ROAD: j = "Road"; break;
            case PropertiesType::PLACE: j = "PLACE"; break;
            case PropertiesType::RD: j = "RD"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"PropertiesType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FeatureType & x) {
        if (j == "Feature") x = FeatureType::FEATURE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FeatureType\""); }
    }

    inline void to_json(json & j, const FeatureType & x) {
        switch (x) {
            case FeatureType::FEATURE: j = "Feature"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FeatureType\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
