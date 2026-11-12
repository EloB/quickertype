//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <variant>
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

    enum class Id : int { EMPTY, SAS, SSA, ECA, LAC, EAP, MNA, HIC, LIC, NA, LMC, UMC, LNX, IDX, IBD, IDB, LCN, SSF, ECS, MEA, EAS, NAC };

    enum class Value : int { EMPTY, SOUTH_ASIA, SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME, EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME, LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME, EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME, MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME, HIGH_INCOME, LOW_INCOME, AGGREGATES, LOWER_MIDDLE_INCOME, UPPER_MIDDLE_INCOME, NOT_CLASSIFIED, IDA, IBRD, BLEND, LATIN_AMERICA_CARIBBEAN, SUB_SAHARAN_AFRICA, EUROPE_CENTRAL_ASIA, MIDDLE_EAST_NORTH_AFRICA, EAST_ASIA_PACIFIC, NORTH_AMERICA };

    class Adminregion {
        public:
        Adminregion() = default;
        virtual ~Adminregion() = default;

        private:
        Id id;
        Value value;

        public:
        const Id & get_id() const { return id; }
        Id & get_mutable_id() { return id; }
        void set_id(const Id & value) { this->id = value; }

        const Value & get_value() const { return value; }
        Value & get_mutable_value() { return value; }
        void set_value(const Value & value) { this->value = value; }
    };

    class PurpleTopLevel {
        public:
        PurpleTopLevel() = default;
        virtual ~PurpleTopLevel() = default;

        private:
        Adminregion adminregion;
        std::string capital_city;
        std::string id;
        Adminregion income_level;
        std::string iso2_code;
        std::string latitude;
        Adminregion lending_type;
        std::string longitude;
        std::string name;
        Adminregion region;

        public:
        const Adminregion & get_adminregion() const { return adminregion; }
        Adminregion & get_mutable_adminregion() { return adminregion; }
        void set_adminregion(const Adminregion & value) { this->adminregion = value; }

        const std::string & get_capital_city() const { return capital_city; }
        std::string & get_mutable_capital_city() { return capital_city; }
        void set_capital_city(const std::string & value) { this->capital_city = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const Adminregion & get_income_level() const { return income_level; }
        Adminregion & get_mutable_income_level() { return income_level; }
        void set_income_level(const Adminregion & value) { this->income_level = value; }

        const std::string & get_iso2_code() const { return iso2_code; }
        std::string & get_mutable_iso2_code() { return iso2_code; }
        void set_iso2_code(const std::string & value) { this->iso2_code = value; }

        const std::string & get_latitude() const { return latitude; }
        std::string & get_mutable_latitude() { return latitude; }
        void set_latitude(const std::string & value) { this->latitude = value; }

        const Adminregion & get_lending_type() const { return lending_type; }
        Adminregion & get_mutable_lending_type() { return lending_type; }
        void set_lending_type(const Adminregion & value) { this->lending_type = value; }

        const std::string & get_longitude() const { return longitude; }
        std::string & get_mutable_longitude() { return longitude; }
        void set_longitude(const std::string & value) { this->longitude = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const Adminregion & get_region() const { return region; }
        Adminregion & get_mutable_region() { return region; }
        void set_region(const Adminregion & value) { this->region = value; }
    };

    class FluffyTopLevel {
        public:
        FluffyTopLevel() = default;
        virtual ~FluffyTopLevel() = default;

        private:
        int64_t page;
        int64_t pages;
        std::string per_page;
        int64_t total;

        public:
        const int64_t & get_page() const { return page; }
        int64_t & get_mutable_page() { return page; }
        void set_page(const int64_t & value) { this->page = value; }

        const int64_t & get_pages() const { return pages; }
        int64_t & get_mutable_pages() { return pages; }
        void set_pages(const int64_t & value) { this->pages = value; }

        const std::string & get_per_page() const { return per_page; }
        std::string & get_mutable_per_page() { return per_page; }
        void set_per_page(const std::string & value) { this->per_page = value; }

        const int64_t & get_total() const { return total; }
        int64_t & get_mutable_total() { return total; }
        void set_total(const int64_t & value) { this->total = value; }
    };

    using TopLevelUnion = std::variant<std::vector<PurpleTopLevel>, FluffyTopLevel>;

    using TopLevel = std::vector<TopLevelUnion>;
}

namespace quicktype {
void from_json(const json & j, Adminregion & x);
void to_json(json & j, const Adminregion & x);

void from_json(const json & j, PurpleTopLevel & x);
void to_json(json & j, const PurpleTopLevel & x);

void from_json(const json & j, FluffyTopLevel & x);
void to_json(json & j, const FluffyTopLevel & x);

void from_json(const json & j, Id & x);
void to_json(json & j, const Id & x);

void from_json(const json & j, Value & x);
void to_json(json & j, const Value & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Adminregion& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_id(j.at("id").get<Id>());
        x.set_value(j.at("value").get<Value>());
    }

    inline void to_json(json & j, const Adminregion & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, PurpleTopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_adminregion(j.at("adminregion").get<Adminregion>());
        x.set_capital_city(j.at("capitalCity").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        x.set_income_level(j.at("incomeLevel").get<Adminregion>());
        x.set_iso2_code(j.at("iso2Code").get<std::string>());
        x.set_latitude(j.at("latitude").get<std::string>());
        x.set_lending_type(j.at("lendingType").get<Adminregion>());
        x.set_longitude(j.at("longitude").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_region(j.at("region").get<Adminregion>());
    }

    inline void to_json(json & j, const PurpleTopLevel & x) {
        j = json::object();
        j["adminregion"] = x.get_adminregion();
        j["capitalCity"] = x.get_capital_city();
        j["id"] = x.get_id();
        j["incomeLevel"] = x.get_income_level();
        j["iso2Code"] = x.get_iso2_code();
        j["latitude"] = x.get_latitude();
        j["lendingType"] = x.get_lending_type();
        j["longitude"] = x.get_longitude();
        j["name"] = x.get_name();
        j["region"] = x.get_region();
    }

    inline void from_json(const json & j, FluffyTopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("page") != j.end() && !j.at("page").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_page(j.at("page").get<int64_t>());
        if (j.find("pages") != j.end() && !j.at("pages").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_pages(j.at("pages").get<int64_t>());
        x.set_per_page(j.at("per_page").get<std::string>());
        if (j.find("total") != j.end() && !j.at("total").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_total(j.at("total").get<int64_t>());
    }

    inline void to_json(json & j, const FluffyTopLevel & x) {
        j = json::object();
        j["page"] = x.get_page();
        j["pages"] = x.get_pages();
        j["per_page"] = x.get_per_page();
        j["total"] = x.get_total();
    }

    inline void from_json(const json & j, Id & x) {
        static std::unordered_map<std::string, Id> enumValues {
            {"", Id::EMPTY},
            {"SAS", Id::SAS},
            {"SSA", Id::SSA},
            {"ECA", Id::ECA},
            {"LAC", Id::LAC},
            {"EAP", Id::EAP},
            {"MNA", Id::MNA},
            {"HIC", Id::HIC},
            {"LIC", Id::LIC},
            {"NA", Id::NA},
            {"LMC", Id::LMC},
            {"UMC", Id::UMC},
            {"LNX", Id::LNX},
            {"IDX", Id::IDX},
            {"IBD", Id::IBD},
            {"IDB", Id::IDB},
            {"LCN", Id::LCN},
            {"SSF", Id::SSF},
            {"ECS", Id::ECS},
            {"MEA", Id::MEA},
            {"EAS", Id::EAS},
            {"NAC", Id::NAC},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Id\""); }
    }

    inline void to_json(json & j, const Id & x) {
        switch (x) {
            case Id::EMPTY: j = ""; break;
            case Id::SAS: j = "SAS"; break;
            case Id::SSA: j = "SSA"; break;
            case Id::ECA: j = "ECA"; break;
            case Id::LAC: j = "LAC"; break;
            case Id::EAP: j = "EAP"; break;
            case Id::MNA: j = "MNA"; break;
            case Id::HIC: j = "HIC"; break;
            case Id::LIC: j = "LIC"; break;
            case Id::NA: j = "NA"; break;
            case Id::LMC: j = "LMC"; break;
            case Id::UMC: j = "UMC"; break;
            case Id::LNX: j = "LNX"; break;
            case Id::IDX: j = "IDX"; break;
            case Id::IBD: j = "IBD"; break;
            case Id::IDB: j = "IDB"; break;
            case Id::LCN: j = "LCN"; break;
            case Id::SSF: j = "SSF"; break;
            case Id::ECS: j = "ECS"; break;
            case Id::MEA: j = "MEA"; break;
            case Id::EAS: j = "EAS"; break;
            case Id::NAC: j = "NAC"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Id\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Value & x) {
        static std::unordered_map<std::string, Value> enumValues {
            {"", Value::EMPTY},
            {"South Asia", Value::SOUTH_ASIA},
            {"Sub-Saharan Africa (excluding high income)", Value::SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME},
            {"Europe & Central Asia (excluding high income)", Value::EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME},
            {"Latin America & Caribbean (excluding high income)", Value::LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME},
            {"East Asia & Pacific (excluding high income)", Value::EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME},
            {"Middle East & North Africa (excluding high income)", Value::MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME},
            {"High income", Value::HIGH_INCOME},
            {"Low income", Value::LOW_INCOME},
            {"Aggregates", Value::AGGREGATES},
            {"Lower middle income", Value::LOWER_MIDDLE_INCOME},
            {"Upper middle income", Value::UPPER_MIDDLE_INCOME},
            {"Not classified", Value::NOT_CLASSIFIED},
            {"IDA", Value::IDA},
            {"IBRD", Value::IBRD},
            {"Blend", Value::BLEND},
            {"Latin America & Caribbean ", Value::LATIN_AMERICA_CARIBBEAN},
            {"Sub-Saharan Africa ", Value::SUB_SAHARAN_AFRICA},
            {"Europe & Central Asia", Value::EUROPE_CENTRAL_ASIA},
            {"Middle East & North Africa", Value::MIDDLE_EAST_NORTH_AFRICA},
            {"East Asia & Pacific", Value::EAST_ASIA_PACIFIC},
            {"North America", Value::NORTH_AMERICA},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Value\""); }
    }

    inline void to_json(json & j, const Value & x) {
        switch (x) {
            case Value::EMPTY: j = ""; break;
            case Value::SOUTH_ASIA: j = "South Asia"; break;
            case Value::SUB_SAHARAN_AFRICA_EXCLUDING_HIGH_INCOME: j = "Sub-Saharan Africa (excluding high income)"; break;
            case Value::EUROPE_CENTRAL_ASIA_EXCLUDING_HIGH_INCOME: j = "Europe & Central Asia (excluding high income)"; break;
            case Value::LATIN_AMERICA_CARIBBEAN_EXCLUDING_HIGH_INCOME: j = "Latin America & Caribbean (excluding high income)"; break;
            case Value::EAST_ASIA_PACIFIC_EXCLUDING_HIGH_INCOME: j = "East Asia & Pacific (excluding high income)"; break;
            case Value::MIDDLE_EAST_NORTH_AFRICA_EXCLUDING_HIGH_INCOME: j = "Middle East & North Africa (excluding high income)"; break;
            case Value::HIGH_INCOME: j = "High income"; break;
            case Value::LOW_INCOME: j = "Low income"; break;
            case Value::AGGREGATES: j = "Aggregates"; break;
            case Value::LOWER_MIDDLE_INCOME: j = "Lower middle income"; break;
            case Value::UPPER_MIDDLE_INCOME: j = "Upper middle income"; break;
            case Value::NOT_CLASSIFIED: j = "Not classified"; break;
            case Value::IDA: j = "IDA"; break;
            case Value::IBRD: j = "IBRD"; break;
            case Value::BLEND: j = "Blend"; break;
            case Value::LATIN_AMERICA_CARIBBEAN: j = "Latin America & Caribbean "; break;
            case Value::SUB_SAHARAN_AFRICA: j = "Sub-Saharan Africa "; break;
            case Value::EUROPE_CENTRAL_ASIA: j = "Europe & Central Asia"; break;
            case Value::MIDDLE_EAST_NORTH_AFRICA: j = "Middle East & North Africa"; break;
            case Value::EAST_ASIA_PACIFIC: j = "East Asia & Pacific"; break;
            case Value::NORTH_AMERICA: j = "North America"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Value\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel>>::from_json(const json & j, std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel> & x) {
        if (j.is_object())
            x = j.get<quicktype::FluffyTopLevel>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::PurpleTopLevel>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel>>::to_json(json & j, const std::variant<std::vector<quicktype::PurpleTopLevel>, quicktype::FluffyTopLevel> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::PurpleTopLevel>>(x);
                break;
            case 1:
                j = std::get<quicktype::FluffyTopLevel>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
