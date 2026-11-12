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

    enum class GeometryType : int { MULTI_POLYGON };

    class Geometry {
        public:
        Geometry() = default;
        virtual ~Geometry() = default;

        private:
        std::vector<std::vector<std::vector<std::vector<double>>>> coordinates;
        GeometryType type;

        public:
        const std::vector<std::vector<std::vector<std::vector<double>>>> & get_coordinates() const { return coordinates; }
        std::vector<std::vector<std::vector<std::vector<double>>>> & get_mutable_coordinates() { return coordinates; }
        void set_coordinates(const std::vector<std::vector<std::vector<std::vector<double>>>> & value) { this->coordinates = value; }

        const GeometryType & get_type() const { return type; }
        GeometryType & get_mutable_type() { return type; }
        void set_type(const GeometryType & value) { this->type = value; }
    };

    enum class GeometryName : int { GEOM };

    enum class AddImprov : int { F, ADD_IMPROV_F, T };

    enum class FundingBa : int { NON_GCCC, CAPEX, INITIAL, CONTRIBUTE };

    enum class LevelAccu : int { GPS_CORRECTED_10_M, APPROX, GPS_C_ORRECTED_10_M };

    enum class Material : int { GRAVEL, CONCRETE, BITUMEN, INTERLOCK_CONC_BLOCK, OTHER, EARTH };

    enum class MiSymbolo : int { PEN_2265535_BRUSH_1016777215 };

    enum class Status : int { CURRENT };

    enum class PropertiesType : int { BOAT_RAMP };

    class FeatureProperties {
        public:
        FeatureProperties() = default;
        virtual ~FeatureProperties() = default;

        private:
        std::optional<AddImprov> add_improv;
        double area;
        std::string asset_numb;
        std::optional<std::string> comments;
        int64_t condition;
        std::optional<std::string> constructi;
        nlohmann::json createdate;
        nlohmann::json createuser;
        nlohmann::json disposal_d;
        std::string documents;
        std::optional<std::string> drawing_nu;
        std::optional<std::string> file_numbe;
        std::optional<std::string> folder_num;
        std::optional<FundingBa> funding_ba;
        int64_t historic_c;
        std::string inspection;
        nlohmann::json inspectors;
        nlohmann::json last_updat;
        std::optional<LevelAccu> level_accu;
        Material material;
        int64_t mi_prinx;
        MiSymbolo mi_symbolo;
        int64_t number_lan;
        std::optional<std::string> owner;
        std::optional<LevelAccu> positional;
        std::optional<std::string> project_nu;
        int64_t rec_id;
        std::optional<std::string> record_cre;
        double shape_area;
        double shape_leng;
        Status status;
        nlohmann::json survey_num;
        double toe_rl;
        double top_rl;
        std::optional<PropertiesType> type;
        std::string update_dat;
        nlohmann::json updatedate;
        nlohmann::json updateuser;

        public:
        std::optional<AddImprov> get_add_improv() const { return add_improv; }
        void set_add_improv(std::optional<AddImprov> value) { this->add_improv = value; }

        const double & get_area() const { return area; }
        double & get_mutable_area() { return area; }
        void set_area(const double & value) { this->area = value; }

        const std::string & get_asset_numb() const { return asset_numb; }
        std::string & get_mutable_asset_numb() { return asset_numb; }
        void set_asset_numb(const std::string & value) { this->asset_numb = value; }

        std::optional<std::string> get_comments() const { return comments; }
        void set_comments(std::optional<std::string> value) { this->comments = value; }

        const int64_t & get_condition() const { return condition; }
        int64_t & get_mutable_condition() { return condition; }
        void set_condition(const int64_t & value) { this->condition = value; }

        std::optional<std::string> get_constructi() const { return constructi; }
        void set_constructi(std::optional<std::string> value) { this->constructi = value; }

        const nlohmann::json & get_createdate() const { return createdate; }
        nlohmann::json & get_mutable_createdate() { return createdate; }
        void set_createdate(const nlohmann::json & value) { this->createdate = value; }

        const nlohmann::json & get_createuser() const { return createuser; }
        nlohmann::json & get_mutable_createuser() { return createuser; }
        void set_createuser(const nlohmann::json & value) { this->createuser = value; }

        const nlohmann::json & get_disposal_d() const { return disposal_d; }
        nlohmann::json & get_mutable_disposal_d() { return disposal_d; }
        void set_disposal_d(const nlohmann::json & value) { this->disposal_d = value; }

        const std::string & get_documents() const { return documents; }
        std::string & get_mutable_documents() { return documents; }
        void set_documents(const std::string & value) { this->documents = value; }

        std::optional<std::string> get_drawing_nu() const { return drawing_nu; }
        void set_drawing_nu(std::optional<std::string> value) { this->drawing_nu = value; }

        std::optional<std::string> get_file_numbe() const { return file_numbe; }
        void set_file_numbe(std::optional<std::string> value) { this->file_numbe = value; }

        std::optional<std::string> get_folder_num() const { return folder_num; }
        void set_folder_num(std::optional<std::string> value) { this->folder_num = value; }

        std::optional<FundingBa> get_funding_ba() const { return funding_ba; }
        void set_funding_ba(std::optional<FundingBa> value) { this->funding_ba = value; }

        const int64_t & get_historic_c() const { return historic_c; }
        int64_t & get_mutable_historic_c() { return historic_c; }
        void set_historic_c(const int64_t & value) { this->historic_c = value; }

        const std::string & get_inspection() const { return inspection; }
        std::string & get_mutable_inspection() { return inspection; }
        void set_inspection(const std::string & value) { this->inspection = value; }

        const nlohmann::json & get_inspectors() const { return inspectors; }
        nlohmann::json & get_mutable_inspectors() { return inspectors; }
        void set_inspectors(const nlohmann::json & value) { this->inspectors = value; }

        const nlohmann::json & get_last_updat() const { return last_updat; }
        nlohmann::json & get_mutable_last_updat() { return last_updat; }
        void set_last_updat(const nlohmann::json & value) { this->last_updat = value; }

        std::optional<LevelAccu> get_level_accu() const { return level_accu; }
        void set_level_accu(std::optional<LevelAccu> value) { this->level_accu = value; }

        const Material & get_material() const { return material; }
        Material & get_mutable_material() { return material; }
        void set_material(const Material & value) { this->material = value; }

        const int64_t & get_mi_prinx() const { return mi_prinx; }
        int64_t & get_mutable_mi_prinx() { return mi_prinx; }
        void set_mi_prinx(const int64_t & value) { this->mi_prinx = value; }

        const MiSymbolo & get_mi_symbolo() const { return mi_symbolo; }
        MiSymbolo & get_mutable_mi_symbolo() { return mi_symbolo; }
        void set_mi_symbolo(const MiSymbolo & value) { this->mi_symbolo = value; }

        const int64_t & get_number_lan() const { return number_lan; }
        int64_t & get_mutable_number_lan() { return number_lan; }
        void set_number_lan(const int64_t & value) { this->number_lan = value; }

        std::optional<std::string> get_owner() const { return owner; }
        void set_owner(std::optional<std::string> value) { this->owner = value; }

        std::optional<LevelAccu> get_positional() const { return positional; }
        void set_positional(std::optional<LevelAccu> value) { this->positional = value; }

        std::optional<std::string> get_project_nu() const { return project_nu; }
        void set_project_nu(std::optional<std::string> value) { this->project_nu = value; }

        const int64_t & get_rec_id() const { return rec_id; }
        int64_t & get_mutable_rec_id() { return rec_id; }
        void set_rec_id(const int64_t & value) { this->rec_id = value; }

        std::optional<std::string> get_record_cre() const { return record_cre; }
        void set_record_cre(std::optional<std::string> value) { this->record_cre = value; }

        const double & get_shape_area() const { return shape_area; }
        double & get_mutable_shape_area() { return shape_area; }
        void set_shape_area(const double & value) { this->shape_area = value; }

        const double & get_shape_leng() const { return shape_leng; }
        double & get_mutable_shape_leng() { return shape_leng; }
        void set_shape_leng(const double & value) { this->shape_leng = value; }

        const Status & get_status() const { return status; }
        Status & get_mutable_status() { return status; }
        void set_status(const Status & value) { this->status = value; }

        const nlohmann::json & get_survey_num() const { return survey_num; }
        nlohmann::json & get_mutable_survey_num() { return survey_num; }
        void set_survey_num(const nlohmann::json & value) { this->survey_num = value; }

        const double & get_toe_rl() const { return toe_rl; }
        double & get_mutable_toe_rl() { return toe_rl; }
        void set_toe_rl(const double & value) { this->toe_rl = value; }

        const double & get_top_rl() const { return top_rl; }
        double & get_mutable_top_rl() { return top_rl; }
        void set_top_rl(const double & value) { this->top_rl = value; }

        std::optional<PropertiesType> get_type() const { return type; }
        void set_type(std::optional<PropertiesType> value) { this->type = value; }

        const std::string & get_update_dat() const { return update_dat; }
        std::string & get_mutable_update_dat() { return update_dat; }
        void set_update_dat(const std::string & value) { this->update_dat = value; }

        const nlohmann::json & get_updatedate() const { return updatedate; }
        nlohmann::json & get_mutable_updatedate() { return updatedate; }
        void set_updatedate(const nlohmann::json & value) { this->updatedate = value; }

        const nlohmann::json & get_updateuser() const { return updateuser; }
        nlohmann::json & get_mutable_updateuser() { return updateuser; }
        void set_updateuser(const nlohmann::json & value) { this->updateuser = value; }
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

    void from_json(const json & j, AddImprov & x);
    void to_json(json & j, const AddImprov & x);

    void from_json(const json & j, FundingBa & x);
    void to_json(json & j, const FundingBa & x);

    void from_json(const json & j, LevelAccu & x);
    void to_json(json & j, const LevelAccu & x);

    void from_json(const json & j, Material & x);
    void to_json(json & j, const Material & x);

    void from_json(const json & j, MiSymbolo & x);
    void to_json(json & j, const MiSymbolo & x);

    void from_json(const json & j, Status & x);
    void to_json(json & j, const Status & x);

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
        x.set_coordinates(j.at("coordinates").get<std::vector<std::vector<std::vector<std::vector<double>>>>>());
        x.set_type(j.at("type").get<GeometryType>());
    }

    inline void to_json(json & j, const Geometry & x) {
        j = json::object();
        j["coordinates"] = x.get_coordinates();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, FeatureProperties& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("add_improv");
        x.set_add_improv(get_stack_optional<AddImprov>(j, "add_improv"));
        x.set_area(j.at("area_").get<double>());
        x.set_asset_numb(j.at("asset_numb").get<std::string>());
        j.at("comments");
        x.set_comments(get_stack_optional<std::string>(j, "comments"));
        if (j.find("condition") != j.end() && !j.at("condition").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_condition(j.at("condition").get<int64_t>());
        j.at("constructi");
        x.set_constructi(get_stack_optional<std::string>(j, "constructi"));
        x.set_createdate(get_untyped(j, "createdate"));
        x.set_createuser(get_untyped(j, "createuser"));
        x.set_disposal_d(get_untyped(j, "disposal_d"));
        x.set_documents(j.at("documents").get<std::string>());
        j.at("drawing_nu");
        x.set_drawing_nu(get_stack_optional<std::string>(j, "drawing_nu"));
        j.at("file_numbe");
        x.set_file_numbe(get_stack_optional<std::string>(j, "file_numbe"));
        j.at("folder_num");
        x.set_folder_num(get_stack_optional<std::string>(j, "folder_num"));
        j.at("funding_ba");
        x.set_funding_ba(get_stack_optional<FundingBa>(j, "funding_ba"));
        if (j.find("historic_c") != j.end() && !j.at("historic_c").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_historic_c(j.at("historic_c").get<int64_t>());
        x.set_inspection(j.at("inspection").get<std::string>());
        x.set_inspectors(get_untyped(j, "inspectors"));
        x.set_last_updat(get_untyped(j, "last_updat"));
        j.at("level_accu");
        x.set_level_accu(get_stack_optional<LevelAccu>(j, "level_accu"));
        x.set_material(j.at("material").get<Material>());
        if (j.find("mi_prinx") != j.end() && !j.at("mi_prinx").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_mi_prinx(j.at("mi_prinx").get<int64_t>());
        x.set_mi_symbolo(j.at("mi_symbolo").get<MiSymbolo>());
        if (j.find("number_lan") != j.end() && !j.at("number_lan").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_number_lan(j.at("number_lan").get<int64_t>());
        j.at("owner");
        x.set_owner(get_stack_optional<std::string>(j, "owner"));
        j.at("positional");
        x.set_positional(get_stack_optional<LevelAccu>(j, "positional"));
        j.at("project_nu");
        x.set_project_nu(get_stack_optional<std::string>(j, "project_nu"));
        if (j.find("rec_id") != j.end() && !j.at("rec_id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_rec_id(j.at("rec_id").get<int64_t>());
        j.at("record_cre");
        x.set_record_cre(get_stack_optional<std::string>(j, "record_cre"));
        x.set_shape_area(j.at("shape_area").get<double>());
        x.set_shape_leng(j.at("shape_leng").get<double>());
        x.set_status(j.at("status").get<Status>());
        x.set_survey_num(get_untyped(j, "survey_num"));
        x.set_toe_rl(j.at("toe_rl").get<double>());
        x.set_top_rl(j.at("top_rl").get<double>());
        j.at("type");
        x.set_type(get_stack_optional<PropertiesType>(j, "type"));
        x.set_update_dat(j.at("update_dat").get<std::string>());
        x.set_updatedate(get_untyped(j, "updatedate"));
        x.set_updateuser(get_untyped(j, "updateuser"));
    }

    inline void to_json(json & j, const FeatureProperties & x) {
        j = json::object();
        j["add_improv"] = x.get_add_improv();
        j["area_"] = x.get_area();
        j["asset_numb"] = x.get_asset_numb();
        j["comments"] = x.get_comments();
        j["condition"] = x.get_condition();
        j["constructi"] = x.get_constructi();
        j["createdate"] = x.get_createdate();
        j["createuser"] = x.get_createuser();
        j["disposal_d"] = x.get_disposal_d();
        j["documents"] = x.get_documents();
        j["drawing_nu"] = x.get_drawing_nu();
        j["file_numbe"] = x.get_file_numbe();
        j["folder_num"] = x.get_folder_num();
        j["funding_ba"] = x.get_funding_ba();
        j["historic_c"] = x.get_historic_c();
        j["inspection"] = x.get_inspection();
        j["inspectors"] = x.get_inspectors();
        j["last_updat"] = x.get_last_updat();
        j["level_accu"] = x.get_level_accu();
        j["material"] = x.get_material();
        j["mi_prinx"] = x.get_mi_prinx();
        j["mi_symbolo"] = x.get_mi_symbolo();
        j["number_lan"] = x.get_number_lan();
        j["owner"] = x.get_owner();
        j["positional"] = x.get_positional();
        j["project_nu"] = x.get_project_nu();
        j["rec_id"] = x.get_rec_id();
        j["record_cre"] = x.get_record_cre();
        j["shape_area"] = x.get_shape_area();
        j["shape_leng"] = x.get_shape_leng();
        j["status"] = x.get_status();
        j["survey_num"] = x.get_survey_num();
        j["toe_rl"] = x.get_toe_rl();
        j["top_rl"] = x.get_top_rl();
        j["type"] = x.get_type();
        j["update_dat"] = x.get_update_dat();
        j["updatedate"] = x.get_updatedate();
        j["updateuser"] = x.get_updateuser();
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
        if (j == "MultiPolygon") x = GeometryType::MULTI_POLYGON;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"GeometryType\""); }
    }

    inline void to_json(json & j, const GeometryType & x) {
        switch (x) {
            case GeometryType::MULTI_POLYGON: j = "MultiPolygon"; break;
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

    inline void from_json(const json & j, AddImprov & x) {
        if (j == "f") x = AddImprov::F;
        else if (j == "F") x = AddImprov::ADD_IMPROV_F;
        else if (j == "t") x = AddImprov::T;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"AddImprov\""); }
    }

    inline void to_json(json & j, const AddImprov & x) {
        switch (x) {
            case AddImprov::F: j = "f"; break;
            case AddImprov::ADD_IMPROV_F: j = "F"; break;
            case AddImprov::T: j = "t"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"AddImprov\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FundingBa & x) {
        if (j == "Non GCCC") x = FundingBa::NON_GCCC;
        else if (j == "Capex") x = FundingBa::CAPEX;
        else if (j == "Initial") x = FundingBa::INITIAL;
        else if (j == "Contribute") x = FundingBa::CONTRIBUTE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FundingBa\""); }
    }

    inline void to_json(json & j, const FundingBa & x) {
        switch (x) {
            case FundingBa::NON_GCCC: j = "Non GCCC"; break;
            case FundingBa::CAPEX: j = "Capex"; break;
            case FundingBa::INITIAL: j = "Initial"; break;
            case FundingBa::CONTRIBUTE: j = "Contribute"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FundingBa\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, LevelAccu & x) {
        if (j == "GPS Corrected 1.0M") x = LevelAccu::GPS_CORRECTED_10_M;
        else if (j == "APPROX") x = LevelAccu::APPROX;
        else if (j == "GPS COrrected 1.0M") x = LevelAccu::GPS_C_ORRECTED_10_M;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"LevelAccu\""); }
    }

    inline void to_json(json & j, const LevelAccu & x) {
        switch (x) {
            case LevelAccu::GPS_CORRECTED_10_M: j = "GPS Corrected 1.0M"; break;
            case LevelAccu::APPROX: j = "APPROX"; break;
            case LevelAccu::GPS_C_ORRECTED_10_M: j = "GPS COrrected 1.0M"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"LevelAccu\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Material & x) {
        if (j == "Gravel") x = Material::GRAVEL;
        else if (j == "Concrete") x = Material::CONCRETE;
        else if (j == "Bitumen") x = Material::BITUMEN;
        else if (j == "Interlock Conc Block") x = Material::INTERLOCK_CONC_BLOCK;
        else if (j == "Other") x = Material::OTHER;
        else if (j == "Earth") x = Material::EARTH;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Material\""); }
    }

    inline void to_json(json & j, const Material & x) {
        switch (x) {
            case Material::GRAVEL: j = "Gravel"; break;
            case Material::CONCRETE: j = "Concrete"; break;
            case Material::BITUMEN: j = "Bitumen"; break;
            case Material::INTERLOCK_CONC_BLOCK: j = "Interlock Conc Block"; break;
            case Material::OTHER: j = "Other"; break;
            case Material::EARTH: j = "Earth"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Material\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, MiSymbolo & x) {
        if (j == "Pen (2, 2, 65535) Brush (1, 0, 16777215)") x = MiSymbolo::PEN_2265535_BRUSH_1016777215;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"MiSymbolo\""); }
    }

    inline void to_json(json & j, const MiSymbolo & x) {
        switch (x) {
            case MiSymbolo::PEN_2265535_BRUSH_1016777215: j = "Pen (2, 2, 65535) Brush (1, 0, 16777215)"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"MiSymbolo\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Status & x) {
        if (j == "CURRENT") x = Status::CURRENT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Status\""); }
    }

    inline void to_json(json & j, const Status & x) {
        switch (x) {
            case Status::CURRENT: j = "CURRENT"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Status\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, PropertiesType & x) {
        if (j == "Boat Ramp") x = PropertiesType::BOAT_RAMP;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"PropertiesType\""); }
    }

    inline void to_json(json & j, const PropertiesType & x) {
        switch (x) {
            case PropertiesType::BOAT_RAMP: j = "Boat Ramp"; break;
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
