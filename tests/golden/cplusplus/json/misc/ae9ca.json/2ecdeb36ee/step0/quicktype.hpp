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

    enum class MaintainingAuthority : int { CITY_OF_BALLARAT };

    enum class Class : int { NO_CODE_ALLOCATED, OS_DISTRICT, OS_NEIGHBOURHOOD, OS_REGIONAL };

    enum class Ward : int { SOUTH, NORTH, CENTRAL };

    class Properties {
        public:
        Properties() = default;
        virtual ~Properties() = default;

        private:
        std::string area;
        std::string central_asset_id;
        std::string feature_location;
        std::string lat;
        MaintainingAuthority maintaining_authority;
        std::string number;
        Class properties_class;
        std::string properties_long;
        std::string site_name;
        Ward ward;

        public:
        const std::string & get_area() const { return area; }
        std::string & get_mutable_area() { return area; }
        void set_area(const std::string & value) { this->area = value; }

        const std::string & get_central_asset_id() const { return central_asset_id; }
        std::string & get_mutable_central_asset_id() { return central_asset_id; }
        void set_central_asset_id(const std::string & value) { this->central_asset_id = value; }

        const std::string & get_feature_location() const { return feature_location; }
        std::string & get_mutable_feature_location() { return feature_location; }
        void set_feature_location(const std::string & value) { this->feature_location = value; }

        const std::string & get_lat() const { return lat; }
        std::string & get_mutable_lat() { return lat; }
        void set_lat(const std::string & value) { this->lat = value; }

        const MaintainingAuthority & get_maintaining_authority() const { return maintaining_authority; }
        MaintainingAuthority & get_mutable_maintaining_authority() { return maintaining_authority; }
        void set_maintaining_authority(const MaintainingAuthority & value) { this->maintaining_authority = value; }

        const std::string & get_number() const { return number; }
        std::string & get_mutable_number() { return number; }
        void set_number(const std::string & value) { this->number = value; }

        const Class & get_properties_class() const { return properties_class; }
        Class & get_mutable_properties_class() { return properties_class; }
        void set_properties_class(const Class & value) { this->properties_class = value; }

        const std::string & get_properties_long() const { return properties_long; }
        std::string & get_mutable_properties_long() { return properties_long; }
        void set_properties_long(const std::string & value) { this->properties_long = value; }

        const std::string & get_site_name() const { return site_name; }
        std::string & get_mutable_site_name() { return site_name; }
        void set_site_name(const std::string & value) { this->site_name = value; }

        const Ward & get_ward() const { return ward; }
        Ward & get_mutable_ward() { return ward; }
        void set_ward(const Ward & value) { this->ward = value; }
    };

    enum class FeatureType : int { FEATURE };

    class Feature {
        public:
        Feature() = default;
        virtual ~Feature() = default;

        private:
        Geometry geometry;
        Properties properties;
        FeatureType type;

        public:
        const Geometry & get_geometry() const { return geometry; }
        Geometry & get_mutable_geometry() { return geometry; }
        void set_geometry(const Geometry & value) { this->geometry = value; }

        const Properties & get_properties() const { return properties; }
        Properties & get_mutable_properties() { return properties; }
        void set_properties(const Properties & value) { this->properties = value; }

        const FeatureType & get_type() const { return type; }
        FeatureType & get_mutable_type() { return type; }
        void set_type(const FeatureType & value) { this->type = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Feature> features;
        std::string name;
        std::string type;

        public:
        const std::vector<Feature> & get_features() const { return features; }
        std::vector<Feature> & get_mutable_features() { return features; }
        void set_features(const std::vector<Feature> & value) { this->features = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Geometry & x);
    void to_json(json & j, const Geometry & x);

    void from_json(const json & j, Properties & x);
    void to_json(json & j, const Properties & x);

    void from_json(const json & j, Feature & x);
    void to_json(json & j, const Feature & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, GeometryType & x);
    void to_json(json & j, const GeometryType & x);

    void from_json(const json & j, MaintainingAuthority & x);
    void to_json(json & j, const MaintainingAuthority & x);

    void from_json(const json & j, Class & x);
    void to_json(json & j, const Class & x);

    void from_json(const json & j, Ward & x);
    void to_json(json & j, const Ward & x);

    void from_json(const json & j, FeatureType & x);
    void to_json(json & j, const FeatureType & x);

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

    inline void from_json(const json & j, Properties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_area(j.at("Area").get<std::string>());
        x.set_central_asset_id(j.at("Central Asset ID").get<std::string>());
        x.set_feature_location(j.at("Feature Location").get<std::string>());
        x.set_lat(j.at("lat").get<std::string>());
        x.set_maintaining_authority(j.at("Maintaining Authority").get<MaintainingAuthority>());
        x.set_number(j.at("Number").get<std::string>());
        x.set_properties_class(j.at("Class").get<Class>());
        x.set_properties_long(j.at("long").get<std::string>());
        x.set_site_name(j.at("Site Name").get<std::string>());
        x.set_ward(j.at("Ward").get<Ward>());
    }

    inline void to_json(json & j, const Properties & x) {
        j = json::object();
        j["Area"] = x.get_area();
        j["Central Asset ID"] = x.get_central_asset_id();
        j["Feature Location"] = x.get_feature_location();
        j["lat"] = x.get_lat();
        j["Maintaining Authority"] = x.get_maintaining_authority();
        j["Number"] = x.get_number();
        j["Class"] = x.get_properties_class();
        j["long"] = x.get_properties_long();
        j["Site Name"] = x.get_site_name();
        j["Ward"] = x.get_ward();
    }

    inline void from_json(const json & j, Feature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_geometry(j.at("geometry").get<Geometry>());
        x.set_properties(j.at("properties").get<Properties>());
        x.set_type(j.at("type").get<FeatureType>());
    }

    inline void to_json(json & j, const Feature & x) {
        j = json::object();
        j["geometry"] = x.get_geometry();
        j["properties"] = x.get_properties();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_features(j.at("features").get<std::vector<Feature>>());
        x.set_name(j.at("name").get<std::string>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["features"] = x.get_features();
        j["name"] = x.get_name();
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

    inline void from_json(const json & j, MaintainingAuthority & x) {
        if (j == "City of Ballarat") x = MaintainingAuthority::CITY_OF_BALLARAT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"MaintainingAuthority\""); }
    }

    inline void to_json(json & j, const MaintainingAuthority & x) {
        switch (x) {
            case MaintainingAuthority::CITY_OF_BALLARAT: j = "City of Ballarat"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"MaintainingAuthority\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Class & x) {
        if (j == "No Code Allocated") x = Class::NO_CODE_ALLOCATED;
        else if (j == "OS-District") x = Class::OS_DISTRICT;
        else if (j == "OS-Neighbourhood") x = Class::OS_NEIGHBOURHOOD;
        else if (j == "OS-Regional") x = Class::OS_REGIONAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Class\""); }
    }

    inline void to_json(json & j, const Class & x) {
        switch (x) {
            case Class::NO_CODE_ALLOCATED: j = "No Code Allocated"; break;
            case Class::OS_DISTRICT: j = "OS-District"; break;
            case Class::OS_NEIGHBOURHOOD: j = "OS-Neighbourhood"; break;
            case Class::OS_REGIONAL: j = "OS-Regional"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Class\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Ward & x) {
        if (j == "South") x = Ward::SOUTH;
        else if (j == "North") x = Ward::NORTH;
        else if (j == "Central") x = Ward::CENTRAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Ward\""); }
    }

    inline void to_json(json & j, const Ward & x) {
        switch (x) {
            case Ward::SOUTH: j = "South"; break;
            case Ward::NORTH: j = "North"; break;
            case Ward::CENTRAL: j = "Central"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Ward\": " + std::to_string(static_cast<int>(x)));
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
