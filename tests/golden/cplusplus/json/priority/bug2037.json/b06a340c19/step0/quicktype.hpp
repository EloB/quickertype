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

    class Reward {
        public:
        Reward() = default;
        virtual ~Reward() = default;

        private:

        public:
    };

    class Objective {
        public:
        Objective() = default;
        virtual ~Objective() = default;

        private:
        std::map<std::string, Reward> rewards;

        public:
        const std::map<std::string, Reward> & get_rewards() const { return rewards; }
        std::map<std::string, Reward> & get_mutable_rewards() { return rewards; }
        void set_rewards(const std::map<std::string, Reward> & value) { this->rewards = value; }
    };

    class MissionSpec {
        public:
        MissionSpec() = default;
        virtual ~MissionSpec() = default;

        private:
        std::map<std::string, Objective> objectives;

        public:
        const std::map<std::string, Objective> & get_objectives() const { return objectives; }
        std::map<std::string, Objective> & get_mutable_objectives() { return objectives; }
        void set_objectives(const std::map<std::string, Objective> & value) { this->objectives = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::map<std::string, MissionSpec> mission_specs;

        public:
        const std::map<std::string, MissionSpec> & get_mission_specs() const { return mission_specs; }
        std::map<std::string, MissionSpec> & get_mutable_mission_specs() { return mission_specs; }
        void set_mission_specs(const std::map<std::string, MissionSpec> & value) { this->mission_specs = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Reward & x);
    void to_json(json & j, const Reward & x);

    void from_json(const json & j, Objective & x);
    void to_json(json & j, const Objective & x);

    void from_json(const json & j, MissionSpec & x);
    void to_json(json & j, const MissionSpec & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Reward& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Reward & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Objective& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_rewards(j.at("rewards").get<std::map<std::string, Reward>>());
    }

    inline void to_json(json & j, const Objective & x) {
        j = json::object();
        j["rewards"] = x.get_rewards();
    }

    inline void from_json(const json & j, MissionSpec& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_objectives(j.at("objectives").get<std::map<std::string, Objective>>());
    }

    inline void to_json(json & j, const MissionSpec & x) {
        j = json::object();
        j["objectives"] = x.get_objectives();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_mission_specs(j.at("mission_specs").get<std::map<std::string, MissionSpec>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["mission_specs"] = x.get_mission_specs();
    }
}
