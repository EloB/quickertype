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

    enum class GeometryType : int { MULTI_POINT };

    class Geometry {
        public:
        Geometry() = default;
        virtual ~Geometry() = default;

        private:
        std::vector<std::vector<double>> coordinates;
        GeometryType type;

        public:
        const std::vector<std::vector<double>> & get_coordinates() const { return coordinates; }
        std::vector<std::vector<double>> & get_mutable_coordinates() { return coordinates; }
        void set_coordinates(const std::vector<std::vector<double>> & value) { this->coordinates = value; }

        const GeometryType & get_type() const { return type; }
        GeometryType & get_mutable_type() { return type; }
        void set_type(const GeometryType & value) { this->type = value; }
    };

    enum class GeometryName : int { GEOM };

    class FeatureProperties {
        public:
        FeatureProperties() = default;
        virtual ~FeatureProperties() = default;

        private:
        std::string facebookaccount;
        std::string frequencyfinderurl;
        std::string name;
        std::string siteurl;
        std::string streetaddress;
        std::string twitteraccount;

        public:
        const std::string & get_facebookaccount() const { return facebookaccount; }
        std::string & get_mutable_facebookaccount() { return facebookaccount; }
        void set_facebookaccount(const std::string & value) { this->facebookaccount = value; }

        const std::string & get_frequencyfinderurl() const { return frequencyfinderurl; }
        std::string & get_mutable_frequencyfinderurl() { return frequencyfinderurl; }
        void set_frequencyfinderurl(const std::string & value) { this->frequencyfinderurl = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_siteurl() const { return siteurl; }
        std::string & get_mutable_siteurl() { return siteurl; }
        void set_siteurl(const std::string & value) { this->siteurl = value; }

        const std::string & get_streetaddress() const { return streetaddress; }
        std::string & get_mutable_streetaddress() { return streetaddress; }
        void set_streetaddress(const std::string & value) { this->streetaddress = value; }

        const std::string & get_twitteraccount() const { return twitteraccount; }
        std::string & get_mutable_twitteraccount() { return twitteraccount; }
        void set_twitteraccount(const std::string & value) { this->twitteraccount = value; }
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
        x.set_coordinates(j.at("coordinates").get<std::vector<std::vector<double>>>());
        x.set_type(j.at("type").get<GeometryType>());
    }

    inline void to_json(json & j, const Geometry & x) {
        j = json::object();
        j["coordinates"] = x.get_coordinates();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, FeatureProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_facebookaccount(j.at("facebookaccount").get<std::string>());
        x.set_frequencyfinderurl(j.at("frequencyfinderurl").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_siteurl(j.at("siteurl").get<std::string>());
        x.set_streetaddress(j.at("streetaddress").get<std::string>());
        x.set_twitteraccount(j.at("twitteraccount").get<std::string>());
    }

    inline void to_json(json & j, const FeatureProperties & x) {
        j = json::object();
        j["facebookaccount"] = x.get_facebookaccount();
        j["frequencyfinderurl"] = x.get_frequencyfinderurl();
        j["name"] = x.get_name();
        j["siteurl"] = x.get_siteurl();
        j["streetaddress"] = x.get_streetaddress();
        j["twitteraccount"] = x.get_twitteraccount();
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
        if (j == "MultiPoint") x = GeometryType::MULTI_POINT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"GeometryType\""); }
    }

    inline void to_json(json & j, const GeometryType & x) {
        switch (x) {
            case GeometryType::MULTI_POINT: j = "MultiPoint"; break;
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
