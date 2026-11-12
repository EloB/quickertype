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

    enum class Category : int { PHYSICS, CHEMISTRY, MEDICINE, LITERATURE, PEACE, ECONOMICS };

    class Laureate {
        public:
        Laureate() = default;
        virtual ~Laureate() = default;

        private:
        std::string firstname;
        std::string id;
        std::optional<std::string> motivation;
        std::string share;
        std::string surname;

        public:
        const std::string & get_firstname() const { return firstname; }
        std::string & get_mutable_firstname() { return firstname; }
        void set_firstname(const std::string & value) { this->firstname = value; }

        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::optional<std::string> & get_motivation() const { return motivation; }
        std::optional<std::string> & get_mutable_motivation() { return motivation; }
        void set_motivation(const std::optional<std::string> & value) { this->motivation = value; }

        const std::string & get_share() const { return share; }
        std::string & get_mutable_share() { return share; }
        void set_share(const std::string & value) { this->share = value; }

        const std::string & get_surname() const { return surname; }
        std::string & get_mutable_surname() { return surname; }
        void set_surname(const std::string & value) { this->surname = value; }
    };

    class Prize {
        public:
        Prize() = default;
        virtual ~Prize() = default;

        private:
        Category category;
        std::vector<Laureate> laureates;
        std::optional<std::string> overall_motivation;
        std::string year;

        public:
        const Category & get_category() const { return category; }
        Category & get_mutable_category() { return category; }
        void set_category(const Category & value) { this->category = value; }

        const std::vector<Laureate> & get_laureates() const { return laureates; }
        std::vector<Laureate> & get_mutable_laureates() { return laureates; }
        void set_laureates(const std::vector<Laureate> & value) { this->laureates = value; }

        const std::optional<std::string> & get_overall_motivation() const { return overall_motivation; }
        std::optional<std::string> & get_mutable_overall_motivation() { return overall_motivation; }
        void set_overall_motivation(const std::optional<std::string> & value) { this->overall_motivation = value; }

        const std::string & get_year() const { return year; }
        std::string & get_mutable_year() { return year; }
        void set_year(const std::string & value) { this->year = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Prize> prizes;

        public:
        const std::vector<Prize> & get_prizes() const { return prizes; }
        std::vector<Prize> & get_mutable_prizes() { return prizes; }
        void set_prizes(const std::vector<Prize> & value) { this->prizes = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Laureate & x);
    void to_json(json & j, const Laureate & x);

    void from_json(const json & j, Prize & x);
    void to_json(json & j, const Prize & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Category & x);
    void to_json(json & j, const Category & x);

    inline void from_json(const json & j, Laureate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_firstname(j.at("firstname").get<std::string>());
        x.set_id(j.at("id").get<std::string>());
        if (j.find("motivation") != j.end() && j.at("motivation").is_null()) throw std::runtime_error("Unexpected null");
        x.set_motivation(get_stack_optional<std::string>(j, "motivation"));
        x.set_share(j.at("share").get<std::string>());
        x.set_surname(j.at("surname").get<std::string>());
    }

    inline void to_json(json & j, const Laureate & x) {
        j = json::object();
        j["firstname"] = x.get_firstname();
        j["id"] = x.get_id();
        j["motivation"] = x.get_motivation();
        j["share"] = x.get_share();
        j["surname"] = x.get_surname();
    }

    inline void from_json(const json & j, Prize& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_category(j.at("category").get<Category>());
        x.set_laureates(j.at("laureates").get<std::vector<Laureate>>());
        if (j.find("overallMotivation") != j.end() && j.at("overallMotivation").is_null()) throw std::runtime_error("Unexpected null");
        x.set_overall_motivation(get_stack_optional<std::string>(j, "overallMotivation"));
        x.set_year(j.at("year").get<std::string>());
    }

    inline void to_json(json & j, const Prize & x) {
        j = json::object();
        j["category"] = x.get_category();
        j["laureates"] = x.get_laureates();
        j["overallMotivation"] = x.get_overall_motivation();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_prizes(j.at("prizes").get<std::vector<Prize>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["prizes"] = x.get_prizes();
    }

    inline void from_json(const json & j, Category & x) {
        if (j == "physics") x = Category::PHYSICS;
        else if (j == "chemistry") x = Category::CHEMISTRY;
        else if (j == "medicine") x = Category::MEDICINE;
        else if (j == "literature") x = Category::LITERATURE;
        else if (j == "peace") x = Category::PEACE;
        else if (j == "economics") x = Category::ECONOMICS;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Category\""); }
    }

    inline void to_json(json & j, const Category & x) {
        switch (x) {
            case Category::PHYSICS: j = "physics"; break;
            case Category::CHEMISTRY: j = "chemistry"; break;
            case Category::MEDICINE: j = "medicine"; break;
            case Category::LITERATURE: j = "literature"; break;
            case Category::PEACE: j = "peace"; break;
            case Category::ECONOMICS: j = "economics"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Category\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
