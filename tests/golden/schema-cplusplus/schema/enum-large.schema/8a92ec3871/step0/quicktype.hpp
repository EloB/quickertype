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
#include <unordered_map>

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

    enum class Callsign : int { ALPHA, BRAVO, CHARLIE, DELTA, ECHO, FOXTROT, GOLF, HOTEL, INDIA, JULIETT, KILO, LIMA, MIKE, NOVEMBER, OSCAR, PAPA, QUEBEC, ROMEO, SIERRA, TANGO };

    enum class Priority : int { LOW, MEDIUM, HIGH };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Callsign callsign;
        Priority priority;

        public:
        const Callsign & get_callsign() const { return callsign; }
        Callsign & get_mutable_callsign() { return callsign; }
        void set_callsign(const Callsign & value) { this->callsign = value; }

        const Priority & get_priority() const { return priority; }
        Priority & get_mutable_priority() { return priority; }
        void set_priority(const Priority & value) { this->priority = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Callsign & x);
    void to_json(json & j, const Callsign & x);

    void from_json(const json & j, Priority & x);
    void to_json(json & j, const Priority & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_callsign(j.at("callsign").get<Callsign>());
        x.set_priority(j.at("priority").get<Priority>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["callsign"] = x.get_callsign();
        j["priority"] = x.get_priority();
    }

    inline void from_json(const json & j, Callsign & x) {
        static std::unordered_map<std::string, Callsign> enumValues {
            {"alpha", Callsign::ALPHA},
            {"bravo", Callsign::BRAVO},
            {"charlie", Callsign::CHARLIE},
            {"delta", Callsign::DELTA},
            {"echo", Callsign::ECHO},
            {"foxtrot", Callsign::FOXTROT},
            {"golf", Callsign::GOLF},
            {"hotel", Callsign::HOTEL},
            {"india", Callsign::INDIA},
            {"juliett", Callsign::JULIETT},
            {"kilo", Callsign::KILO},
            {"lima", Callsign::LIMA},
            {"mike", Callsign::MIKE},
            {"november", Callsign::NOVEMBER},
            {"oscar", Callsign::OSCAR},
            {"papa", Callsign::PAPA},
            {"quebec", Callsign::QUEBEC},
            {"romeo", Callsign::ROMEO},
            {"sierra", Callsign::SIERRA},
            {"tango", Callsign::TANGO},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Callsign\""); }
    }

    inline void to_json(json & j, const Callsign & x) {
        switch (x) {
            case Callsign::ALPHA: j = "alpha"; break;
            case Callsign::BRAVO: j = "bravo"; break;
            case Callsign::CHARLIE: j = "charlie"; break;
            case Callsign::DELTA: j = "delta"; break;
            case Callsign::ECHO: j = "echo"; break;
            case Callsign::FOXTROT: j = "foxtrot"; break;
            case Callsign::GOLF: j = "golf"; break;
            case Callsign::HOTEL: j = "hotel"; break;
            case Callsign::INDIA: j = "india"; break;
            case Callsign::JULIETT: j = "juliett"; break;
            case Callsign::KILO: j = "kilo"; break;
            case Callsign::LIMA: j = "lima"; break;
            case Callsign::MIKE: j = "mike"; break;
            case Callsign::NOVEMBER: j = "november"; break;
            case Callsign::OSCAR: j = "oscar"; break;
            case Callsign::PAPA: j = "papa"; break;
            case Callsign::QUEBEC: j = "quebec"; break;
            case Callsign::ROMEO: j = "romeo"; break;
            case Callsign::SIERRA: j = "sierra"; break;
            case Callsign::TANGO: j = "tango"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Callsign\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Priority & x) {
        if (j == "low") x = Priority::LOW;
        else if (j == "medium") x = Priority::MEDIUM;
        else if (j == "high") x = Priority::HIGH;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Priority\""); }
    }

    inline void to_json(json & j, const Priority & x) {
        switch (x) {
            case Priority::LOW: j = "low"; break;
            case Priority::MEDIUM: j = "medium"; break;
            case Priority::HIGH: j = "high"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Priority\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
