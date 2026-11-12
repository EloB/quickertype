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

    class Rates {
        public:
        Rates() = default;
        virtual ~Rates() = default;

        private:
        std::optional<double> parking;
        std::optional<double> reduced;
        std::optional<double> reduced1;
        std::optional<double> reduced2;
        double standard;
        std::optional<double> super_reduced;

        public:
        const std::optional<double> & get_parking() const { return parking; }
        std::optional<double> & get_mutable_parking() { return parking; }
        void set_parking(const std::optional<double> & value) { this->parking = value; }

        const std::optional<double> & get_reduced() const { return reduced; }
        std::optional<double> & get_mutable_reduced() { return reduced; }
        void set_reduced(const std::optional<double> & value) { this->reduced = value; }

        const std::optional<double> & get_reduced1() const { return reduced1; }
        std::optional<double> & get_mutable_reduced1() { return reduced1; }
        void set_reduced1(const std::optional<double> & value) { this->reduced1 = value; }

        const std::optional<double> & get_reduced2() const { return reduced2; }
        std::optional<double> & get_mutable_reduced2() { return reduced2; }
        void set_reduced2(const std::optional<double> & value) { this->reduced2 = value; }

        const double & get_standard() const { return standard; }
        double & get_mutable_standard() { return standard; }
        void set_standard(const double & value) { this->standard = value; }

        const std::optional<double> & get_super_reduced() const { return super_reduced; }
        std::optional<double> & get_mutable_super_reduced() { return super_reduced; }
        void set_super_reduced(const std::optional<double> & value) { this->super_reduced = value; }
    };

    class Period {
        public:
        Period() = default;
        virtual ~Period() = default;

        private:
        std::string effective_from;
        Rates rates;

        public:
        const std::string & get_effective_from() const { return effective_from; }
        std::string & get_mutable_effective_from() { return effective_from; }
        void set_effective_from(const std::string & value) { this->effective_from = value; }

        const Rates & get_rates() const { return rates; }
        Rates & get_mutable_rates() { return rates; }
        void set_rates(const Rates & value) { this->rates = value; }
    };

    class Rate {
        public:
        Rate() = default;
        virtual ~Rate() = default;

        private:
        std::string code;
        std::string country_code;
        std::string name;
        std::vector<Period> periods;

        public:
        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_country_code() const { return country_code; }
        std::string & get_mutable_country_code() { return country_code; }
        void set_country_code(const std::string & value) { this->country_code = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::vector<Period> & get_periods() const { return periods; }
        std::vector<Period> & get_mutable_periods() { return periods; }
        void set_periods(const std::vector<Period> & value) { this->periods = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string details;
        std::vector<Rate> rates;
        nlohmann::json version;

        public:
        const std::string & get_details() const { return details; }
        std::string & get_mutable_details() { return details; }
        void set_details(const std::string & value) { this->details = value; }

        const std::vector<Rate> & get_rates() const { return rates; }
        std::vector<Rate> & get_mutable_rates() { return rates; }
        void set_rates(const std::vector<Rate> & value) { this->rates = value; }

        const nlohmann::json & get_version() const { return version; }
        nlohmann::json & get_mutable_version() { return version; }
        void set_version(const nlohmann::json & value) { this->version = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Rates & x);
    void to_json(json & j, const Rates & x);

    void from_json(const json & j, Period & x);
    void to_json(json & j, const Period & x);

    void from_json(const json & j, Rate & x);
    void to_json(json & j, const Rate & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Rates& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("parking") != j.end() && j.at("parking").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parking(get_stack_optional<double>(j, "parking"));
        if (j.find("reduced") != j.end() && j.at("reduced").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reduced(get_stack_optional<double>(j, "reduced"));
        if (j.find("reduced1") != j.end() && j.at("reduced1").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reduced1(get_stack_optional<double>(j, "reduced1"));
        if (j.find("reduced2") != j.end() && j.at("reduced2").is_null()) throw std::runtime_error("Unexpected null");
        x.set_reduced2(get_stack_optional<double>(j, "reduced2"));
        x.set_standard(j.at("standard").get<double>());
        if (j.find("super_reduced") != j.end() && j.at("super_reduced").is_null()) throw std::runtime_error("Unexpected null");
        x.set_super_reduced(get_stack_optional<double>(j, "super_reduced"));
    }

    inline void to_json(json & j, const Rates & x) {
        j = json::object();
        j["parking"] = x.get_parking();
        j["reduced"] = x.get_reduced();
        j["reduced1"] = x.get_reduced1();
        j["reduced2"] = x.get_reduced2();
        j["standard"] = x.get_standard();
        j["super_reduced"] = x.get_super_reduced();
    }

    inline void from_json(const json & j, Period& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_effective_from(j.at("effective_from").get<std::string>());
        x.set_rates(j.at("rates").get<Rates>());
    }

    inline void to_json(json & j, const Period & x) {
        j = json::object();
        j["effective_from"] = x.get_effective_from();
        j["rates"] = x.get_rates();
    }

    inline void from_json(const json & j, Rate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<std::string>());
        x.set_country_code(j.at("country_code").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_periods(j.at("periods").get<std::vector<Period>>());
    }

    inline void to_json(json & j, const Rate & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["country_code"] = x.get_country_code();
        j["name"] = x.get_name();
        j["periods"] = x.get_periods();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_details(j.at("details").get<std::string>());
        x.set_rates(j.at("rates").get<std::vector<Rate>>());
        x.set_version(get_untyped(j, "version"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["details"] = x.get_details();
        j["rates"] = x.get_rates();
        j["version"] = x.get_version();
    }
}
