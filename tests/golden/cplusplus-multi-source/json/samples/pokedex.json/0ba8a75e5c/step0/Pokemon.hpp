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

#include "Evolution.hpp"

namespace quicktype {
    enum class Egg : int;
    enum class Type : int;
}

namespace quicktype {
    using nlohmann::json;

    class Pokemon {
        public:
        Pokemon() = default;
        virtual ~Pokemon() = default;

        private:
        double avg_spawns;
        std::string candy;
        std::optional<int64_t> candy_count;
        Egg egg;
        std::string height;
        int64_t id;
        std::string img;
        std::optional<std::vector<double>> multipliers;
        std::string name;
        std::optional<std::vector<Evolution>> next_evolution;
        std::string num;
        std::optional<std::vector<Evolution>> prev_evolution;
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

        const std::optional<int64_t> & get_candy_count() const { return candy_count; }
        std::optional<int64_t> & get_mutable_candy_count() { return candy_count; }
        void set_candy_count(const std::optional<int64_t> & value) { this->candy_count = value; }

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

        std::optional<std::vector<double>> get_multipliers() const { return multipliers; }
        void set_multipliers(std::optional<std::vector<double>> value) { this->multipliers = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::optional<std::vector<Evolution>> & get_next_evolution() const { return next_evolution; }
        std::optional<std::vector<Evolution>> & get_mutable_next_evolution() { return next_evolution; }
        void set_next_evolution(const std::optional<std::vector<Evolution>> & value) { this->next_evolution = value; }

        const std::string & get_num() const { return num; }
        std::string & get_mutable_num() { return num; }
        void set_num(const std::string & value) { this->num = value; }

        const std::optional<std::vector<Evolution>> & get_prev_evolution() const { return prev_evolution; }
        std::optional<std::vector<Evolution>> & get_mutable_prev_evolution() { return prev_evolution; }
        void set_prev_evolution(const std::optional<std::vector<Evolution>> & value) { this->prev_evolution = value; }

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
}
