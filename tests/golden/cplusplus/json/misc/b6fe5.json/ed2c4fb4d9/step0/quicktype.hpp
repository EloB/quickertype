//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

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

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string group;
        std::string movie;
        std::string movie_image;
        std::string theater;

        public:
        const std::string & get_group() const { return group; }
        std::string & get_mutable_group() { return group; }
        void set_group(const std::string & value) { this->group = value; }

        const std::string & get_movie() const { return movie; }
        std::string & get_mutable_movie() { return movie; }
        void set_movie(const std::string & value) { this->movie = value; }

        const std::string & get_movie_image() const { return movie_image; }
        std::string & get_mutable_movie_image() { return movie_image; }
        void set_movie_image(const std::string & value) { this->movie_image = value; }

        const std::string & get_theater() const { return theater; }
        std::string & get_mutable_theater() { return theater; }
        void set_theater(const std::string & value) { this->theater = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_group(j.at("group").get<std::string>());
        x.set_movie(j.at("movie").get<std::string>());
        x.set_movie_image(j.at("movie-image").get<std::string>());
        x.set_theater(j.at("theater").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["group"] = x.get_group();
        j["movie"] = x.get_movie();
        j["movie-image"] = x.get_movie_image();
        j["theater"] = x.get_theater();
    }
}
