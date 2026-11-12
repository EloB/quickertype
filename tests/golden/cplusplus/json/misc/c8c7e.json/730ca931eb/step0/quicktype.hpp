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

    enum class Id : int { IN, NY_GDP_MKTP_CD };

    enum class Value : int { INDIA, GDP_CURRENT_US };

    class Country {
        public:
        Country() = default;
        virtual ~Country() = default;

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
        Country country;
        std::string date;
        std::string decimal;
        Country indicator;
        std::string value;

        public:
        const Country & get_country() const { return country; }
        Country & get_mutable_country() { return country; }
        void set_country(const Country & value) { this->country = value; }

        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const std::string & get_decimal() const { return decimal; }
        std::string & get_mutable_decimal() { return decimal; }
        void set_decimal(const std::string & value) { this->decimal = value; }

        const Country & get_indicator() const { return indicator; }
        Country & get_mutable_indicator() { return indicator; }
        void set_indicator(const Country & value) { this->indicator = value; }

        const std::string & get_value() const { return value; }
        std::string & get_mutable_value() { return value; }
        void set_value(const std::string & value) { this->value = value; }
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
void from_json(const json & j, Country & x);
void to_json(json & j, const Country & x);

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
    inline void from_json(const json & j, Country& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_id(j.at("id").get<Id>());
        x.set_value(j.at("value").get<Value>());
    }

    inline void to_json(json & j, const Country & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, PurpleTopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_country(j.at("country").get<Country>());
        x.set_date(j.at("date").get<std::string>());
        x.set_decimal(j.at("decimal").get<std::string>());
        x.set_indicator(j.at("indicator").get<Country>());
        x.set_value(j.at("value").get<std::string>());
    }

    inline void to_json(json & j, const PurpleTopLevel & x) {
        j = json::object();
        j["country"] = x.get_country();
        j["date"] = x.get_date();
        j["decimal"] = x.get_decimal();
        j["indicator"] = x.get_indicator();
        j["value"] = x.get_value();
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
        if (j == "IN") x = Id::IN;
        else if (j == "NY.GDP.MKTP.CD") x = Id::NY_GDP_MKTP_CD;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Id\""); }
    }

    inline void to_json(json & j, const Id & x) {
        switch (x) {
            case Id::IN: j = "IN"; break;
            case Id::NY_GDP_MKTP_CD: j = "NY.GDP.MKTP.CD"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Id\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Value & x) {
        if (j == "India") x = Value::INDIA;
        else if (j == "GDP (current US$)") x = Value::GDP_CURRENT_US;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Value\""); }
    }

    inline void to_json(json & j, const Value & x) {
        switch (x) {
            case Value::INDIA: j = "India"; break;
            case Value::GDP_CURRENT_US: j = "GDP (current US$)"; break;
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
