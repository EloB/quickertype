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

    enum class MagType : int { MD, ML, MB };

    enum class Status : int { AUTOMATIC, REVIEWED };

    enum class PropertiesType : int { EARTHQUAKE };

    class Properties {
        public:
        Properties() = default;
        virtual ~Properties() = default;

        private:
        nlohmann::json alert;
        nlohmann::json cdi;
        std::string code;
        std::string detail;
        std::optional<double> dmin;
        nlohmann::json felt;
        std::optional<int64_t> gap;
        std::string ids;
        double mag;
        MagType mag_type;
        nlohmann::json mmi;
        std::string net;
        std::optional<int64_t> nst;
        std::string place;
        double rms;
        int64_t sig;
        std::string sources;
        Status status;
        int64_t time;
        std::string title;
        int64_t tsunami;
        PropertiesType type;
        std::string types;
        int64_t tz;
        int64_t updated;
        std::string url;

        public:
        const nlohmann::json & get_alert() const { return alert; }
        nlohmann::json & get_mutable_alert() { return alert; }
        void set_alert(const nlohmann::json & value) { this->alert = value; }

        const nlohmann::json & get_cdi() const { return cdi; }
        nlohmann::json & get_mutable_cdi() { return cdi; }
        void set_cdi(const nlohmann::json & value) { this->cdi = value; }

        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_detail() const { return detail; }
        std::string & get_mutable_detail() { return detail; }
        void set_detail(const std::string & value) { this->detail = value; }

        std::optional<double> get_dmin() const { return dmin; }
        void set_dmin(std::optional<double> value) { this->dmin = value; }

        const nlohmann::json & get_felt() const { return felt; }
        nlohmann::json & get_mutable_felt() { return felt; }
        void set_felt(const nlohmann::json & value) { this->felt = value; }

        std::optional<int64_t> get_gap() const { return gap; }
        void set_gap(std::optional<int64_t> value) { this->gap = value; }

        const std::string & get_ids() const { return ids; }
        std::string & get_mutable_ids() { return ids; }
        void set_ids(const std::string & value) { this->ids = value; }

        const double & get_mag() const { return mag; }
        double & get_mutable_mag() { return mag; }
        void set_mag(const double & value) { this->mag = value; }

        const MagType & get_mag_type() const { return mag_type; }
        MagType & get_mutable_mag_type() { return mag_type; }
        void set_mag_type(const MagType & value) { this->mag_type = value; }

        const nlohmann::json & get_mmi() const { return mmi; }
        nlohmann::json & get_mutable_mmi() { return mmi; }
        void set_mmi(const nlohmann::json & value) { this->mmi = value; }

        const std::string & get_net() const { return net; }
        std::string & get_mutable_net() { return net; }
        void set_net(const std::string & value) { this->net = value; }

        std::optional<int64_t> get_nst() const { return nst; }
        void set_nst(std::optional<int64_t> value) { this->nst = value; }

        const std::string & get_place() const { return place; }
        std::string & get_mutable_place() { return place; }
        void set_place(const std::string & value) { this->place = value; }

        const double & get_rms() const { return rms; }
        double & get_mutable_rms() { return rms; }
        void set_rms(const double & value) { this->rms = value; }

        const int64_t & get_sig() const { return sig; }
        int64_t & get_mutable_sig() { return sig; }
        void set_sig(const int64_t & value) { this->sig = value; }

        const std::string & get_sources() const { return sources; }
        std::string & get_mutable_sources() { return sources; }
        void set_sources(const std::string & value) { this->sources = value; }

        const Status & get_status() const { return status; }
        Status & get_mutable_status() { return status; }
        void set_status(const Status & value) { this->status = value; }

        const int64_t & get_time() const { return time; }
        int64_t & get_mutable_time() { return time; }
        void set_time(const int64_t & value) { this->time = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const int64_t & get_tsunami() const { return tsunami; }
        int64_t & get_mutable_tsunami() { return tsunami; }
        void set_tsunami(const int64_t & value) { this->tsunami = value; }

        const PropertiesType & get_type() const { return type; }
        PropertiesType & get_mutable_type() { return type; }
        void set_type(const PropertiesType & value) { this->type = value; }

        const std::string & get_types() const { return types; }
        std::string & get_mutable_types() { return types; }
        void set_types(const std::string & value) { this->types = value; }

        const int64_t & get_tz() const { return tz; }
        int64_t & get_mutable_tz() { return tz; }
        void set_tz(const int64_t & value) { this->tz = value; }

        const int64_t & get_updated() const { return updated; }
        int64_t & get_mutable_updated() { return updated; }
        void set_updated(const int64_t & value) { this->updated = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    enum class FeatureType : int { FEATURE };

    class Feature {
        public:
        Feature() = default;
        virtual ~Feature() = default;

        private:
        Geometry geometry;
        std::string id;
        Properties properties;
        FeatureType type;

        public:
        const Geometry & get_geometry() const { return geometry; }
        Geometry & get_mutable_geometry() { return geometry; }
        void set_geometry(const Geometry & value) { this->geometry = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const Properties & get_properties() const { return properties; }
        Properties & get_mutable_properties() { return properties; }
        void set_properties(const Properties & value) { this->properties = value; }

        const FeatureType & get_type() const { return type; }
        FeatureType & get_mutable_type() { return type; }
        void set_type(const FeatureType & value) { this->type = value; }
    };

    class Metadata {
        public:
        Metadata() = default;
        virtual ~Metadata() = default;

        private:
        std::string api;
        int64_t count;
        int64_t generated;
        int64_t status;
        std::string title;
        std::string url;

        public:
        const std::string & get_api() const { return api; }
        std::string & get_mutable_api() { return api; }
        void set_api(const std::string & value) { this->api = value; }

        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const int64_t & get_generated() const { return generated; }
        int64_t & get_mutable_generated() { return generated; }
        void set_generated(const int64_t & value) { this->generated = value; }

        const int64_t & get_status() const { return status; }
        int64_t & get_mutable_status() { return status; }
        void set_status(const int64_t & value) { this->status = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<double> bbox;
        std::vector<Feature> features;
        Metadata metadata;
        std::string type;

        public:
        const std::vector<double> & get_bbox() const { return bbox; }
        std::vector<double> & get_mutable_bbox() { return bbox; }
        void set_bbox(const std::vector<double> & value) { this->bbox = value; }

        const std::vector<Feature> & get_features() const { return features; }
        std::vector<Feature> & get_mutable_features() { return features; }
        void set_features(const std::vector<Feature> & value) { this->features = value; }

        const Metadata & get_metadata() const { return metadata; }
        Metadata & get_mutable_metadata() { return metadata; }
        void set_metadata(const Metadata & value) { this->metadata = value; }

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

    void from_json(const json & j, Metadata & x);
    void to_json(json & j, const Metadata & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, GeometryType & x);
    void to_json(json & j, const GeometryType & x);

    void from_json(const json & j, MagType & x);
    void to_json(json & j, const MagType & x);

    void from_json(const json & j, Status & x);
    void to_json(json & j, const Status & x);

    void from_json(const json & j, PropertiesType & x);
    void to_json(json & j, const PropertiesType & x);

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
        x.set_alert(get_untyped(j, "alert"));
        x.set_cdi(get_untyped(j, "cdi"));
        x.set_code(j.at("code").get<std::string>());
        x.set_detail(j.at("detail").get<std::string>());
        j.at("dmin");
        x.set_dmin(get_stack_optional<double>(j, "dmin"));
        x.set_felt(get_untyped(j, "felt"));
        j.at("gap");
        x.set_gap(get_stack_optional<int64_t>(j, "gap"));
        x.set_ids(j.at("ids").get<std::string>());
        x.set_mag(j.at("mag").get<double>());
        x.set_mag_type(j.at("magType").get<MagType>());
        x.set_mmi(get_untyped(j, "mmi"));
        x.set_net(j.at("net").get<std::string>());
        j.at("nst");
        x.set_nst(get_stack_optional<int64_t>(j, "nst"));
        x.set_place(j.at("place").get<std::string>());
        x.set_rms(j.at("rms").get<double>());
        if (j.find("sig") != j.end() && !j.at("sig").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_sig(j.at("sig").get<int64_t>());
        x.set_sources(j.at("sources").get<std::string>());
        x.set_status(j.at("status").get<Status>());
        if (j.find("time") != j.end() && !j.at("time").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_time(j.at("time").get<int64_t>());
        x.set_title(j.at("title").get<std::string>());
        if (j.find("tsunami") != j.end() && !j.at("tsunami").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tsunami(j.at("tsunami").get<int64_t>());
        x.set_type(j.at("type").get<PropertiesType>());
        x.set_types(j.at("types").get<std::string>());
        if (j.find("tz") != j.end() && !j.at("tz").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_tz(j.at("tz").get<int64_t>());
        if (j.find("updated") != j.end() && !j.at("updated").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_updated(j.at("updated").get<int64_t>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Properties & x) {
        j = json::object();
        j["alert"] = x.get_alert();
        j["cdi"] = x.get_cdi();
        j["code"] = x.get_code();
        j["detail"] = x.get_detail();
        j["dmin"] = x.get_dmin();
        j["felt"] = x.get_felt();
        j["gap"] = x.get_gap();
        j["ids"] = x.get_ids();
        j["mag"] = x.get_mag();
        j["magType"] = x.get_mag_type();
        j["mmi"] = x.get_mmi();
        j["net"] = x.get_net();
        j["nst"] = x.get_nst();
        j["place"] = x.get_place();
        j["rms"] = x.get_rms();
        j["sig"] = x.get_sig();
        j["sources"] = x.get_sources();
        j["status"] = x.get_status();
        j["time"] = x.get_time();
        j["title"] = x.get_title();
        j["tsunami"] = x.get_tsunami();
        j["type"] = x.get_type();
        j["types"] = x.get_types();
        j["tz"] = x.get_tz();
        j["updated"] = x.get_updated();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Feature& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_geometry(j.at("geometry").get<Geometry>());
        x.set_id(j.at("id").get<std::string>());
        x.set_properties(j.at("properties").get<Properties>());
        x.set_type(j.at("type").get<FeatureType>());
    }

    inline void to_json(json & j, const Feature & x) {
        j = json::object();
        j["geometry"] = x.get_geometry();
        j["id"] = x.get_id();
        j["properties"] = x.get_properties();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Metadata& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_api(j.at("api").get<std::string>());
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        if (j.find("generated") != j.end() && !j.at("generated").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_generated(j.at("generated").get<int64_t>());
        if (j.find("status") != j.end() && !j.at("status").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_status(j.at("status").get<int64_t>());
        x.set_title(j.at("title").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Metadata & x) {
        j = json::object();
        j["api"] = x.get_api();
        j["count"] = x.get_count();
        j["generated"] = x.get_generated();
        j["status"] = x.get_status();
        j["title"] = x.get_title();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_bbox(j.at("bbox").get<std::vector<double>>());
        x.set_features(j.at("features").get<std::vector<Feature>>());
        x.set_metadata(j.at("metadata").get<Metadata>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["bbox"] = x.get_bbox();
        j["features"] = x.get_features();
        j["metadata"] = x.get_metadata();
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

    inline void from_json(const json & j, MagType & x) {
        if (j == "md") x = MagType::MD;
        else if (j == "ml") x = MagType::ML;
        else if (j == "mb") x = MagType::MB;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"MagType\""); }
    }

    inline void to_json(json & j, const MagType & x) {
        switch (x) {
            case MagType::MD: j = "md"; break;
            case MagType::ML: j = "ml"; break;
            case MagType::MB: j = "mb"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"MagType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Status & x) {
        if (j == "automatic") x = Status::AUTOMATIC;
        else if (j == "reviewed") x = Status::REVIEWED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Status\""); }
    }

    inline void to_json(json & j, const Status & x) {
        switch (x) {
            case Status::AUTOMATIC: j = "automatic"; break;
            case Status::REVIEWED: j = "reviewed"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Status\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, PropertiesType & x) {
        if (j == "earthquake") x = PropertiesType::EARTHQUAKE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PropertiesType\""); }
    }

    inline void to_json(json & j, const PropertiesType & x) {
        switch (x) {
            case PropertiesType::EARTHQUAKE: j = "earthquake"; break;
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
