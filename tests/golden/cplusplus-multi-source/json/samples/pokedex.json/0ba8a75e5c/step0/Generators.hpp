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
#include "helper.hpp"

#include "TopLevel.hpp"
#include "Pokemon.hpp"
#include "Type.hpp"
#include "Evolution.hpp"
#include "Egg.hpp"

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
