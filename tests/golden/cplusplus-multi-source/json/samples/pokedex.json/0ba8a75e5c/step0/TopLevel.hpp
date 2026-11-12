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

#include "Pokemon.hpp"

namespace quicktype {
    using nlohmann::json;

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
