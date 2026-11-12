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

    class StateState {
        public:
        StateState() = default;
        virtual ~StateState() = default;

        private:
        std::string state_id;
        std::string state_name;

        public:
        const std::string & get_state_id() const { return state_id; }
        std::string & get_mutable_state_id() { return state_id; }
        void set_state_id(const std::string & value) { this->state_id = value; }

        const std::string & get_state_name() const { return state_name; }
        std::string & get_mutable_state_name() { return state_name; }
        void set_state_name(const std::string & value) { this->state_name = value; }
    };

    class StateElement {
        public:
        StateElement() = default;
        virtual ~StateElement() = default;

        private:
        StateState state;

        public:
        const StateState & get_state() const { return state; }
        StateState & get_mutable_state() { return state; }
        void set_state(const StateState & value) { this->state = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<StateElement> states;

        public:
        const std::vector<StateElement> & get_states() const { return states; }
        std::vector<StateElement> & get_mutable_states() { return states; }
        void set_states(const std::vector<StateElement> & value) { this->states = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, StateState & x);
    void to_json(json & j, const StateState & x);

    void from_json(const json & j, StateElement & x);
    void to_json(json & j, const StateElement & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, StateState& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_state_id(j.at("state_id").get<std::string>());
        x.set_state_name(j.at("state_name").get<std::string>());
    }

    inline void to_json(json & j, const StateState & x) {
        j = json::object();
        j["state_id"] = x.get_state_id();
        j["state_name"] = x.get_state_name();
    }

    inline void from_json(const json & j, StateElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_state(j.at("state").get<StateState>());
    }

    inline void to_json(json & j, const StateElement & x) {
        j = json::object();
        j["state"] = x.get_state();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_states(j.at("states").get<std::vector<StateElement>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["states"] = x.get_states();
    }
}
