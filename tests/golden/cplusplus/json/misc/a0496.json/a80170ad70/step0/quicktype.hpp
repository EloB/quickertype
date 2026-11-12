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

    using Datum = std::optional<std::variant<double, std::string>>;

    class Errors {
        public:
        Errors() = default;
        virtual ~Errors() = default;

        private:

        public:
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string code;
        std::vector<std::string> column_names;
        std::vector<std::vector<Datum>> data;
        std::string description;
        std::string display_url;
        Errors errors;
        std::string frequency;
        std::string from_date;
        int64_t id;
        std::string name;
        bool premium;
        std::string source_code;
        std::string source_name;
        std::string to_date;
        std::string type;
        std::string updated_at;
        std::string urlize_name;

        public:
        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::vector<std::string> & get_column_names() const { return column_names; }
        std::vector<std::string> & get_mutable_column_names() { return column_names; }
        void set_column_names(const std::vector<std::string> & value) { this->column_names = value; }

        const std::vector<std::vector<Datum>> & get_data() const { return data; }
        std::vector<std::vector<Datum>> & get_mutable_data() { return data; }
        void set_data(const std::vector<std::vector<Datum>> & value) { this->data = value; }

        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const std::string & get_display_url() const { return display_url; }
        std::string & get_mutable_display_url() { return display_url; }
        void set_display_url(const std::string & value) { this->display_url = value; }

        const Errors & get_errors() const { return errors; }
        Errors & get_mutable_errors() { return errors; }
        void set_errors(const Errors & value) { this->errors = value; }

        const std::string & get_frequency() const { return frequency; }
        std::string & get_mutable_frequency() { return frequency; }
        void set_frequency(const std::string & value) { this->frequency = value; }

        const std::string & get_from_date() const { return from_date; }
        std::string & get_mutable_from_date() { return from_date; }
        void set_from_date(const std::string & value) { this->from_date = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const bool & get_premium() const { return premium; }
        bool & get_mutable_premium() { return premium; }
        void set_premium(const bool & value) { this->premium = value; }

        const std::string & get_source_code() const { return source_code; }
        std::string & get_mutable_source_code() { return source_code; }
        void set_source_code(const std::string & value) { this->source_code = value; }

        const std::string & get_source_name() const { return source_name; }
        std::string & get_mutable_source_name() { return source_name; }
        void set_source_name(const std::string & value) { this->source_name = value; }

        const std::string & get_to_date() const { return to_date; }
        std::string & get_mutable_to_date() { return to_date; }
        void set_to_date(const std::string & value) { this->to_date = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }

        const std::string & get_updated_at() const { return updated_at; }
        std::string & get_mutable_updated_at() { return updated_at; }
        void set_updated_at(const std::string & value) { this->updated_at = value; }

        const std::string & get_urlize_name() const { return urlize_name; }
        std::string & get_mutable_urlize_name() { return urlize_name; }
        void set_urlize_name(const std::string & value) { this->urlize_name = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Errors & x);
void to_json(json & j, const Errors & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(const json & j, std::variant<double, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Errors& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Errors & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<std::string>());
        x.set_column_names(j.at("column_names").get<std::vector<std::string>>());
        x.set_data(j.at("data").get<std::vector<std::vector<Datum>>>());
        x.set_description(j.at("description").get<std::string>());
        x.set_display_url(j.at("display_url").get<std::string>());
        x.set_errors(j.at("errors").get<Errors>());
        x.set_frequency(j.at("frequency").get<std::string>());
        x.set_from_date(j.at("from_date").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_name(j.at("name").get<std::string>());
        x.set_premium(j.at("premium").get<bool>());
        x.set_source_code(j.at("source_code").get<std::string>());
        x.set_source_name(j.at("source_name").get<std::string>());
        x.set_to_date(j.at("to_date").get<std::string>());
        x.set_type(j.at("type").get<std::string>());
        if (j.find("updated_at") != j.end() && !std::regex_match(j.at("updated_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_updated_at(j.at("updated_at").get<std::string>());
        x.set_urlize_name(j.at("urlize_name").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["column_names"] = x.get_column_names();
        j["data"] = x.get_data();
        j["description"] = x.get_description();
        j["display_url"] = x.get_display_url();
        j["errors"] = x.get_errors();
        j["frequency"] = x.get_frequency();
        j["from_date"] = x.get_from_date();
        j["id"] = x.get_id();
        j["name"] = x.get_name();
        j["premium"] = x.get_premium();
        j["source_code"] = x.get_source_code();
        j["source_name"] = x.get_source_name();
        j["to_date"] = x.get_to_date();
        j["type"] = x.get_type();
        j["updated_at"] = x.get_updated_at();
        j["urlize_name"] = x.get_urlize_name();
    }
}
namespace nlohmann {
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
}
