//  To parse this JSON data, first install
//
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <boost/optional.hpp>
#include "json.hpp"

#include <boost/optional.hpp>
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
    struct adl_serializer<boost::optional<T>> {
        static void to_json(json & j, const boost::optional<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static boost::optional<T> from_json(const json & j) {
            if (j.is_null()) return boost::optional<T>(); else return boost::optional<T>(j.get<T>());
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
    inline boost::optional<T> get_stack_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<boost::optional<T>>();
        }
        return boost::optional<T>();
    }

    template <typename T>
    inline boost::optional<T> get_stack_optional(const json & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    enum class Egg : int { THE_2_KM, NOT_IN_EGGS, THE_5_KM, THE_10_KM, OMANYTE_CANDY };

    class Evolution {
        public:
        Evolution() = default;
        virtual ~Evolution() = default;

        private:
        std::string name;
        std::string num;

        public:
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_num() const { return num; }
        std::string & get_mutable_num() { return num; }
        void set_num(const std::string & value) { this->num = value; }
    };

    enum class Type : int { FIRE, ICE, FLYING, PSYCHIC, WATER, GROUND, ROCK, ELECTRIC, GRASS, FIGHTING, POISON, BUG, FAIRY, GHOST, DARK, STEEL, DRAGON, NORMAL };

    class Pokemon {
        public:
        Pokemon() = default;
        virtual ~Pokemon() = default;

        private:
        double avg_spawns;
        std::string candy;
        boost::optional<int64_t> candy_count;
        Egg egg;
        std::string height;
        int64_t id;
        std::string img;
        boost::optional<std::vector<double>> multipliers;
        std::string name;
        boost::optional<std::vector<Evolution>> next_evolution;
        std::string num;
        boost::optional<std::vector<Evolution>> prev_evolution;
        double spawn_chance;
        std::string spawn_time;
        std::vector<Type> type;
        std::vector<Type> weaknesses;
        std::string weight;

        public:
        const double & get_avg_spawns() const { return avg_spawns; }
        double & get_mutable_avg_spawns() { return avg_spawns; }
        void set_avg_spawns(const double & value) { this->avg_spawns = value; }

        const std::string & get_candy() const { return candy; }
        std::string & get_mutable_candy() { return candy; }
        void set_candy(const std::string & value) { this->candy = value; }

        const boost::optional<int64_t> & get_candy_count() const { return candy_count; }
        boost::optional<int64_t> & get_mutable_candy_count() { return candy_count; }
        void set_candy_count(const boost::optional<int64_t> & value) { this->candy_count = value; }

        const Egg & get_egg() const { return egg; }
        Egg & get_mutable_egg() { return egg; }
        void set_egg(const Egg & value) { this->egg = value; }

        const std::string & get_height() const { return height; }
        std::string & get_mutable_height() { return height; }
        void set_height(const std::string & value) { this->height = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }

        const std::string & get_img() const { return img; }
        std::string & get_mutable_img() { return img; }
        void set_img(const std::string & value) { this->img = value; }

        boost::optional<std::vector<double>> get_multipliers() const { return multipliers; }
        void set_multipliers(boost::optional<std::vector<double>> value) { this->multipliers = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const boost::optional<std::vector<Evolution>> & get_next_evolution() const { return next_evolution; }
        boost::optional<std::vector<Evolution>> & get_mutable_next_evolution() { return next_evolution; }
        void set_next_evolution(const boost::optional<std::vector<Evolution>> & value) { this->next_evolution = value; }

        const std::string & get_num() const { return num; }
        std::string & get_mutable_num() { return num; }
        void set_num(const std::string & value) { this->num = value; }

        const boost::optional<std::vector<Evolution>> & get_prev_evolution() const { return prev_evolution; }
        boost::optional<std::vector<Evolution>> & get_mutable_prev_evolution() { return prev_evolution; }
        void set_prev_evolution(const boost::optional<std::vector<Evolution>> & value) { this->prev_evolution = value; }

        const double & get_spawn_chance() const { return spawn_chance; }
        double & get_mutable_spawn_chance() { return spawn_chance; }
        void set_spawn_chance(const double & value) { this->spawn_chance = value; }

        const std::string & get_spawn_time() const { return spawn_time; }
        std::string & get_mutable_spawn_time() { return spawn_time; }
        void set_spawn_time(const std::string & value) { this->spawn_time = value; }

        const std::vector<Type> & get_type() const { return type; }
        std::vector<Type> & get_mutable_type() { return type; }
        void set_type(const std::vector<Type> & value) { this->type = value; }

        const std::vector<Type> & get_weaknesses() const { return weaknesses; }
        std::vector<Type> & get_mutable_weaknesses() { return weaknesses; }
        void set_weaknesses(const std::vector<Type> & value) { this->weaknesses = value; }

        const std::string & get_weight() const { return weight; }
        std::string & get_mutable_weight() { return weight; }
        void set_weight(const std::string & value) { this->weight = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Pokemon> pokemon;

        public:
        const std::vector<Pokemon> & get_pokemon() const { return pokemon; }
        std::vector<Pokemon> & get_mutable_pokemon() { return pokemon; }
        void set_pokemon(const std::vector<Pokemon> & value) { this->pokemon = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Evolution & x);
    void to_json(json & j, const Evolution & x);

    void from_json(const json & j, Pokemon & x);
    void to_json(json & j, const Pokemon & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Egg & x);
    void to_json(json & j, const Egg & x);

    void from_json(const json & j, Type & x);
    void to_json(json & j, const Type & x);

    inline void from_json(const json & j, Evolution& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_name(j.at("name").get<std::string>());
        x.set_num(j.at("num").get<std::string>());
    }

    inline void to_json(json & j, const Evolution & x) {
        j = json::object();
        j["name"] = x.get_name();
        j["num"] = x.get_num();
    }

    inline void from_json(const json & j, Pokemon& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_avg_spawns(j.at("avg_spawns").get<double>());
        x.set_candy(j.at("candy").get<std::string>());
        if (j.find("candy_count") != j.end() && !j.at("candy_count").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("candy_count") != j.end() && j.at("candy_count").is_null()) throw std::runtime_error("Unexpected null");
        x.set_candy_count(get_stack_optional<int64_t>(j, "candy_count"));
        x.set_egg(j.at("egg").get<Egg>());
        x.set_height(j.at("height").get<std::string>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
        x.set_img(j.at("img").get<std::string>());
        j.at("multipliers");
        x.set_multipliers(get_stack_optional<std::vector<double>>(j, "multipliers"));
        x.set_name(j.at("name").get<std::string>());
        if (j.find("next_evolution") != j.end() && j.at("next_evolution").is_null()) throw std::runtime_error("Unexpected null");
        x.set_next_evolution(get_stack_optional<std::vector<Evolution>>(j, "next_evolution"));
        x.set_num(j.at("num").get<std::string>());
        if (j.find("prev_evolution") != j.end() && j.at("prev_evolution").is_null()) throw std::runtime_error("Unexpected null");
        x.set_prev_evolution(get_stack_optional<std::vector<Evolution>>(j, "prev_evolution"));
        x.set_spawn_chance(j.at("spawn_chance").get<double>());
        x.set_spawn_time(j.at("spawn_time").get<std::string>());
        x.set_type(j.at("type").get<std::vector<Type>>());
        x.set_weaknesses(j.at("weaknesses").get<std::vector<Type>>());
        x.set_weight(j.at("weight").get<std::string>());
    }

    inline void to_json(json & j, const Pokemon & x) {
        j = json::object();
        j["avg_spawns"] = x.get_avg_spawns();
        j["candy"] = x.get_candy();
        j["candy_count"] = x.get_candy_count();
        j["egg"] = x.get_egg();
        j["height"] = x.get_height();
        j["id"] = x.get_id();
        j["img"] = x.get_img();
        j["multipliers"] = x.get_multipliers();
        j["name"] = x.get_name();
        j["next_evolution"] = x.get_next_evolution();
        j["num"] = x.get_num();
        j["prev_evolution"] = x.get_prev_evolution();
        j["spawn_chance"] = x.get_spawn_chance();
        j["spawn_time"] = x.get_spawn_time();
        j["type"] = x.get_type();
        j["weaknesses"] = x.get_weaknesses();
        j["weight"] = x.get_weight();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_pokemon(j.at("pokemon").get<std::vector<Pokemon>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["pokemon"] = x.get_pokemon();
    }

    inline void from_json(const json & j, Egg & x) {
        if (j == "2 km") x = Egg::THE_2_KM;
        else if (j == "Not in Eggs") x = Egg::NOT_IN_EGGS;
        else if (j == "5 km") x = Egg::THE_5_KM;
        else if (j == "10 km") x = Egg::THE_10_KM;
        else if (j == "Omanyte Candy") x = Egg::OMANYTE_CANDY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Egg\""); }
    }

    inline void to_json(json & j, const Egg & x) {
        switch (x) {
            case Egg::THE_2_KM: j = "2 km"; break;
            case Egg::NOT_IN_EGGS: j = "Not in Eggs"; break;
            case Egg::THE_5_KM: j = "5 km"; break;
            case Egg::THE_10_KM: j = "10 km"; break;
            case Egg::OMANYTE_CANDY: j = "Omanyte Candy"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Egg\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        static std::unordered_map<std::string, Type> enumValues {
            {"Fire", Type::FIRE},
            {"Ice", Type::ICE},
            {"Flying", Type::FLYING},
            {"Psychic", Type::PSYCHIC},
            {"Water", Type::WATER},
            {"Ground", Type::GROUND},
            {"Rock", Type::ROCK},
            {"Electric", Type::ELECTRIC},
            {"Grass", Type::GRASS},
            {"Fighting", Type::FIGHTING},
            {"Poison", Type::POISON},
            {"Bug", Type::BUG},
            {"Fairy", Type::FAIRY},
            {"Ghost", Type::GHOST},
            {"Dark", Type::DARK},
            {"Steel", Type::STEEL},
            {"Dragon", Type::DRAGON},
            {"Normal", Type::NORMAL},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::FIRE: j = "Fire"; break;
            case Type::ICE: j = "Ice"; break;
            case Type::FLYING: j = "Flying"; break;
            case Type::PSYCHIC: j = "Psychic"; break;
            case Type::WATER: j = "Water"; break;
            case Type::GROUND: j = "Ground"; break;
            case Type::ROCK: j = "Rock"; break;
            case Type::ELECTRIC: j = "Electric"; break;
            case Type::GRASS: j = "Grass"; break;
            case Type::FIGHTING: j = "Fighting"; break;
            case Type::POISON: j = "Poison"; break;
            case Type::BUG: j = "Bug"; break;
            case Type::FAIRY: j = "Fairy"; break;
            case Type::GHOST: j = "Ghost"; break;
            case Type::DARK: j = "Dark"; break;
            case Type::STEEL: j = "Steel"; break;
            case Type::DRAGON: j = "Dragon"; break;
            case Type::NORMAL: j = "Normal"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
