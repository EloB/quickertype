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

    enum class Weekdays : int { MONDAY = 1, TUESDAY = 2, WEDNESDAY = 3, THURSDAY = 4, FRIDAY = 5, SATURDAY = 6, SUNDAY = 7 };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Weekdays weekdays;

        public:
        const Weekdays & get_weekdays() const { return weekdays; }
        Weekdays & get_mutable_weekdays() { return weekdays; }
        void set_weekdays(const Weekdays & value) { this->weekdays = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Weekdays & x);
    void to_json(json & j, const Weekdays & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_weekdays(j.at("weekdays").get<Weekdays>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["weekdays"] = x.get_weekdays();
    }

    inline void from_json(const json & j, Weekdays & x) {
        if (j == "Monday") x = Weekdays::MONDAY;
        else if (j == "Tuesday") x = Weekdays::TUESDAY;
        else if (j == "Wednesday") x = Weekdays::WEDNESDAY;
        else if (j == "Thursday") x = Weekdays::THURSDAY;
        else if (j == "Friday") x = Weekdays::FRIDAY;
        else if (j == "Saturday") x = Weekdays::SATURDAY;
        else if (j == "Sunday") x = Weekdays::SUNDAY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Weekdays\""); }
    }

    inline void to_json(json & j, const Weekdays & x) {
        switch (x) {
            case Weekdays::MONDAY: j = "Monday"; break;
            case Weekdays::TUESDAY: j = "Tuesday"; break;
            case Weekdays::WEDNESDAY: j = "Wednesday"; break;
            case Weekdays::THURSDAY: j = "Thursday"; break;
            case Weekdays::FRIDAY: j = "Friday"; break;
            case Weekdays::SATURDAY: j = "Saturday"; break;
            case Weekdays::SUNDAY: j = "Sunday"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Weekdays\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
