//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
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

    enum class Gender : int { MALE, FEMALE, ORG };

    class AffiliationClass {
        public:
        AffiliationClass() = default;
        virtual ~AffiliationClass() = default;

        private:
        std::optional<std::string> city;
        std::optional<std::string> country;
        std::optional<std::string> name;

        public:
        const std::optional<std::string> & get_city() const { return city; }
        std::optional<std::string> & get_mutable_city() { return city; }
        void set_city(const std::optional<std::string> & value) { this->city = value; }

        const std::optional<std::string> & get_country() const { return country; }
        std::optional<std::string> & get_mutable_country() { return country; }
        void set_country(const std::optional<std::string> & value) { this->country = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }
    };

    using AffiliationElement = std::variant<std::vector<nlohmann::json>, AffiliationClass>;

    enum class Category : int { PHYSICS, CHEMISTRY, PEACE, MEDICINE, LITERATURE, ECONOMICS };

    class Prize {
        public:
        Prize() = default;
        virtual ~Prize() = default;

        private:
        std::vector<AffiliationElement> affiliations;
        std::optional<Category> category;
        std::optional<std::string> motivation;
        std::optional<std::string> overall_motivation;
        std::optional<std::string> share;
        std::optional<std::string> year;

        public:
        const std::vector<AffiliationElement> & get_affiliations() const { return affiliations; }
        std::vector<AffiliationElement> & get_mutable_affiliations() { return affiliations; }
        void set_affiliations(const std::vector<AffiliationElement> & value) { this->affiliations = value; }

        const std::optional<Category> & get_category() const { return category; }
        std::optional<Category> & get_mutable_category() { return category; }
        void set_category(const std::optional<Category> & value) { this->category = value; }

        const std::optional<std::string> & get_motivation() const { return motivation; }
        std::optional<std::string> & get_mutable_motivation() { return motivation; }
        void set_motivation(const std::optional<std::string> & value) { this->motivation = value; }

        const std::optional<std::string> & get_overall_motivation() const { return overall_motivation; }
        std::optional<std::string> & get_mutable_overall_motivation() { return overall_motivation; }
        void set_overall_motivation(const std::optional<std::string> & value) { this->overall_motivation = value; }

        const std::optional<std::string> & get_share() const { return share; }
        std::optional<std::string> & get_mutable_share() { return share; }
        void set_share(const std::optional<std::string> & value) { this->share = value; }

        const std::optional<std::string> & get_year() const { return year; }
        std::optional<std::string> & get_mutable_year() { return year; }
        void set_year(const std::optional<std::string> & value) { this->year = value; }
    };

    class Laureate {
        public:
        Laureate() = default;
        virtual ~Laureate() = default;

        private:
        std::string born;
        std::optional<std::string> born_city;
        std::optional<std::string> born_country;
        std::optional<std::string> born_country_code;
        std::string died;
        std::optional<std::string> died_city;
        std::optional<std::string> died_country;
        std::optional<std::string> died_country_code;
        std::optional<std::string> firstname;
        Gender gender;
        std::string id;
        std::vector<Prize> prizes;
        std::optional<std::string> surname;

        public:
        const std::string & get_born() const { return born; }
        std::string & get_mutable_born() { return born; }
        void set_born(const std::string & value) { this->born = value; }

        const std::optional<std::string> & get_born_city() const { return born_city; }
        std::optional<std::string> & get_mutable_born_city() { return born_city; }
        void set_born_city(const std::optional<std::string> & value) { this->born_city = value; }

        const std::optional<std::string> & get_born_country() const { return born_country; }
        std::optional<std::string> & get_mutable_born_country() { return born_country; }
        void set_born_country(const std::optional<std::string> & value) { this->born_country = value; }

        const std::optional<std::string> & get_born_country_code() const { return born_country_code; }
        std::optional<std::string> & get_mutable_born_country_code() { return born_country_code; }
        void set_born_country_code(const std::optional<std::string> & value) { this->born_country_code = value; }

        const std::string & get_died() const { return died; }
        std::string & get_mutable_died() { return died; }
        void set_died(const std::string & value) { this->died = value; }

        const std::optional<std::string> & get_died_city() const { return died_city; }
        std::optional<std::string> & get_mutable_died_city() { return died_city; }
        void set_died_city(const std::optional<std::string> & value) { this->died_city = value; }

        const std::optional<std::string> & get_died_country() const { return died_country; }
        std::optional<std::string> & get_mutable_died_country() { return died_country; }
        void set_died_country(const std::optional<std::string> & value) { this->died_country = value; }

        const std::optional<std::string> & get_died_country_code() const { return died_country_code; }
        std::optional<std::string> & get_mutable_died_country_code() { return died_country_code; }
        void set_died_country_code(const std::optional<std::string> & value) { this->died_country_code = value; }

        const std::optional<std::string> & get_firstname() const { return firstname; }
        std::optional<std::string> & get_mutable_firstname() { return firstname; }
        void set_firstname(const std::optional<std::string> & value) { this->firstname = value; }

        const Gender & get_gender() const { return gender; }
        Gender & get_mutable_gender() { return gender; }
        void set_gender(const Gender & value) { this->gender = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::vector<Prize> & get_prizes() const { return prizes; }
        std::vector<Prize> & get_mutable_prizes() { return prizes; }
        void set_prizes(const std::vector<Prize> & value) { this->prizes = value; }

        const std::optional<std::string> & get_surname() const { return surname; }
        std::optional<std::string> & get_mutable_surname() { return surname; }
        void set_surname(const std::optional<std::string> & value) { this->surname = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Laureate> laureates;

        public:
        const std::vector<Laureate> & get_laureates() const { return laureates; }
        std::vector<Laureate> & get_mutable_laureates() { return laureates; }
        void set_laureates(const std::vector<Laureate> & value) { this->laureates = value; }
    };
}

namespace quicktype {
void from_json(const json & j, AffiliationClass & x);
void to_json(json & j, const AffiliationClass & x);

void from_json(const json & j, Prize & x);
void to_json(json & j, const Prize & x);

void from_json(const json & j, Laureate & x);
void to_json(json & j, const Laureate & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, Gender & x);
void to_json(json & j, const Gender & x);

void from_json(const json & j, Category & x);
void to_json(json & j, const Category & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<json>, quicktype::AffiliationClass>> {
    static void from_json(const json & j, std::variant<std::vector<json>, quicktype::AffiliationClass> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, quicktype::AffiliationClass> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, AffiliationClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("city") != j.end() && j.at("city").is_null()) throw std::runtime_error("Unexpected null");
        x.set_city(get_stack_optional<std::string>(j, "city"));
        if (j.find("country") != j.end() && j.at("country").is_null()) throw std::runtime_error("Unexpected null");
        x.set_country(get_stack_optional<std::string>(j, "country"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
    }

    inline void to_json(json & j, const AffiliationClass & x) {
        j = json::object();
        j["city"] = x.get_city();
        j["country"] = x.get_country();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, Prize& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_affiliations(j.at("affiliations").get<std::vector<AffiliationElement>>());
        if (j.find("category") != j.end() && j.at("category").is_null()) throw std::runtime_error("Unexpected null");
        x.set_category(get_stack_optional<Category>(j, "category"));
        if (j.find("motivation") != j.end() && j.at("motivation").is_null()) throw std::runtime_error("Unexpected null");
        x.set_motivation(get_stack_optional<std::string>(j, "motivation"));
        if (j.find("overallMotivation") != j.end() && j.at("overallMotivation").is_null()) throw std::runtime_error("Unexpected null");
        x.set_overall_motivation(get_stack_optional<std::string>(j, "overallMotivation"));
        if (j.find("share") != j.end() && j.at("share").is_null()) throw std::runtime_error("Unexpected null");
        x.set_share(get_stack_optional<std::string>(j, "share"));
        if (j.find("year") != j.end() && j.at("year").is_null()) throw std::runtime_error("Unexpected null");
        x.set_year(get_stack_optional<std::string>(j, "year"));
    }

    inline void to_json(json & j, const Prize & x) {
        j = json::object();
        j["affiliations"] = x.get_affiliations();
        j["category"] = x.get_category();
        j["motivation"] = x.get_motivation();
        j["overallMotivation"] = x.get_overall_motivation();
        j["share"] = x.get_share();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, Laureate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_born(j.at("born").get<std::string>());
        if (j.find("bornCity") != j.end() && j.at("bornCity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_born_city(get_stack_optional<std::string>(j, "bornCity"));
        if (j.find("bornCountry") != j.end() && j.at("bornCountry").is_null()) throw std::runtime_error("Unexpected null");
        x.set_born_country(get_stack_optional<std::string>(j, "bornCountry"));
        if (j.find("bornCountryCode") != j.end() && j.at("bornCountryCode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_born_country_code(get_stack_optional<std::string>(j, "bornCountryCode"));
        x.set_died(j.at("died").get<std::string>());
        if (j.find("diedCity") != j.end() && j.at("diedCity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_died_city(get_stack_optional<std::string>(j, "diedCity"));
        if (j.find("diedCountry") != j.end() && j.at("diedCountry").is_null()) throw std::runtime_error("Unexpected null");
        x.set_died_country(get_stack_optional<std::string>(j, "diedCountry"));
        if (j.find("diedCountryCode") != j.end() && j.at("diedCountryCode").is_null()) throw std::runtime_error("Unexpected null");
        x.set_died_country_code(get_stack_optional<std::string>(j, "diedCountryCode"));
        if (j.find("firstname") != j.end() && j.at("firstname").is_null()) throw std::runtime_error("Unexpected null");
        x.set_firstname(get_stack_optional<std::string>(j, "firstname"));
        x.set_gender(j.at("gender").get<Gender>());
        x.set_id(j.at("id").get<std::string>());
        x.set_prizes(j.at("prizes").get<std::vector<Prize>>());
        if (j.find("surname") != j.end() && j.at("surname").is_null()) throw std::runtime_error("Unexpected null");
        x.set_surname(get_stack_optional<std::string>(j, "surname"));
    }

    inline void to_json(json & j, const Laureate & x) {
        j = json::object();
        j["born"] = x.get_born();
        j["bornCity"] = x.get_born_city();
        j["bornCountry"] = x.get_born_country();
        j["bornCountryCode"] = x.get_born_country_code();
        j["died"] = x.get_died();
        j["diedCity"] = x.get_died_city();
        j["diedCountry"] = x.get_died_country();
        j["diedCountryCode"] = x.get_died_country_code();
        j["firstname"] = x.get_firstname();
        j["gender"] = x.get_gender();
        j["id"] = x.get_id();
        j["prizes"] = x.get_prizes();
        j["surname"] = x.get_surname();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_laureates(j.at("laureates").get<std::vector<Laureate>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["laureates"] = x.get_laureates();
    }

    inline void from_json(const json & j, Gender & x) {
        if (j == "male") x = Gender::MALE;
        else if (j == "female") x = Gender::FEMALE;
        else if (j == "org") x = Gender::ORG;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Gender\""); }
    }

    inline void to_json(json & j, const Gender & x) {
        switch (x) {
            case Gender::MALE: j = "male"; break;
            case Gender::FEMALE: j = "female"; break;
            case Gender::ORG: j = "org"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Gender\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Category & x) {
        if (j == "physics") x = Category::PHYSICS;
        else if (j == "chemistry") x = Category::CHEMISTRY;
        else if (j == "peace") x = Category::PEACE;
        else if (j == "medicine") x = Category::MEDICINE;
        else if (j == "literature") x = Category::LITERATURE;
        else if (j == "economics") x = Category::ECONOMICS;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Category\""); }
    }

    inline void to_json(json & j, const Category & x) {
        switch (x) {
            case Category::PHYSICS: j = "physics"; break;
            case Category::CHEMISTRY: j = "chemistry"; break;
            case Category::PEACE: j = "peace"; break;
            case Category::MEDICINE: j = "medicine"; break;
            case Category::LITERATURE: j = "literature"; break;
            case Category::ECONOMICS: j = "economics"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Category\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<json>, quicktype::AffiliationClass>>::from_json(const json & j, std::variant<std::vector<json>, quicktype::AffiliationClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::AffiliationClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, quicktype::AffiliationClass>>::to_json(json & j, const std::variant<std::vector<json>, quicktype::AffiliationClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<quicktype::AffiliationClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
