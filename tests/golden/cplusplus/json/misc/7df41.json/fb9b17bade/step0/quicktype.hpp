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

    class Pc {
        public:
        Pc() = default;
        virtual ~Pc() = default;

        private:
        int64_t count;
        std::string label;
        int64_t peak24;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const std::string & get_label() const { return label; }
        std::string & get_mutable_label() { return label; }
        void set_label(const std::string & value) { this->label = value; }

        const int64_t & get_peak24() const { return peak24; }
        int64_t & get_mutable_peak24() { return peak24; }
        void set_peak24(const int64_t & value) { this->peak24 = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Pc pc;
        Pc ps3;
        Pc ps4;
        Pc xbox;
        Pc xone;

        public:
        const Pc & get_pc() const { return pc; }
        Pc & get_mutable_pc() { return pc; }
        void set_pc(const Pc & value) { this->pc = value; }

        const Pc & get_ps3() const { return ps3; }
        Pc & get_mutable_ps3() { return ps3; }
        void set_ps3(const Pc & value) { this->ps3 = value; }

        const Pc & get_ps4() const { return ps4; }
        Pc & get_mutable_ps4() { return ps4; }
        void set_ps4(const Pc & value) { this->ps4 = value; }

        const Pc & get_xbox() const { return xbox; }
        Pc & get_mutable_xbox() { return xbox; }
        void set_xbox(const Pc & value) { this->xbox = value; }

        const Pc & get_xone() const { return xone; }
        Pc & get_mutable_xone() { return xone; }
        void set_xone(const Pc & value) { this->xone = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Pc & x);
    void to_json(json & j, const Pc & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Pc& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        x.set_label(j.at("label").get<std::string>());
        if (j.find("peak24") != j.end() && !j.at("peak24").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_peak24(j.at("peak24").get<int64_t>());
    }

    inline void to_json(json & j, const Pc & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["label"] = x.get_label();
        j["peak24"] = x.get_peak24();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_pc(j.at("pc").get<Pc>());
        x.set_ps3(j.at("ps3").get<Pc>());
        x.set_ps4(j.at("ps4").get<Pc>());
        x.set_xbox(j.at("xbox").get<Pc>());
        x.set_xone(j.at("xone").get<Pc>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["pc"] = x.get_pc();
        j["ps3"] = x.get_ps3();
        j["ps4"] = x.get_ps4();
        j["xbox"] = x.get_xbox();
        j["xone"] = x.get_xone();
    }
}
