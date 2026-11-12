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

    class Status {
        public:
        Status() = default;
        virtual ~Status() = default;

        private:
        std::string avg_delay;
        std::string closure_begin;
        std::string closure_end;
        std::string end_time;
        std::string max_delay;
        std::string min_delay;
        std::string reason;
        std::string trend;
        std::string type;

        public:
        const std::string & get_avg_delay() const { return avg_delay; }
        std::string & get_mutable_avg_delay() { return avg_delay; }
        void set_avg_delay(const std::string & value) { this->avg_delay = value; }

        const std::string & get_closure_begin() const { return closure_begin; }
        std::string & get_mutable_closure_begin() { return closure_begin; }
        void set_closure_begin(const std::string & value) { this->closure_begin = value; }

        const std::string & get_closure_end() const { return closure_end; }
        std::string & get_mutable_closure_end() { return closure_end; }
        void set_closure_end(const std::string & value) { this->closure_end = value; }

        const std::string & get_end_time() const { return end_time; }
        std::string & get_mutable_end_time() { return end_time; }
        void set_end_time(const std::string & value) { this->end_time = value; }

        const std::string & get_max_delay() const { return max_delay; }
        std::string & get_mutable_max_delay() { return max_delay; }
        void set_max_delay(const std::string & value) { this->max_delay = value; }

        const std::string & get_min_delay() const { return min_delay; }
        std::string & get_mutable_min_delay() { return min_delay; }
        void set_min_delay(const std::string & value) { this->min_delay = value; }

        const std::string & get_reason() const { return reason; }
        std::string & get_mutable_reason() { return reason; }
        void set_reason(const std::string & value) { this->reason = value; }

        const std::string & get_trend() const { return trend; }
        std::string & get_mutable_trend() { return trend; }
        void set_trend(const std::string & value) { this->trend = value; }

        const std::string & get_type() const { return type; }
        std::string & get_mutable_type() { return type; }
        void set_type(const std::string & value) { this->type = value; }
    };

    class Meta {
        public:
        Meta() = default;
        virtual ~Meta() = default;

        private:
        std::string credit;
        std::string updated;
        std::string url;

        public:
        const std::string & get_credit() const { return credit; }
        std::string & get_mutable_credit() { return credit; }
        void set_credit(const std::string & value) { this->credit = value; }

        const std::string & get_updated() const { return updated; }
        std::string & get_mutable_updated() { return updated; }
        void set_updated(const std::string & value) { this->updated = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }
    };

    class Weather {
        public:
        Weather() = default;
        virtual ~Weather() = default;

        private:
        Meta meta;
        std::string temp;
        double visibility;
        std::string weather;
        std::string wind;

        public:
        const Meta & get_meta() const { return meta; }
        Meta & get_mutable_meta() { return meta; }
        void set_meta(const Meta & value) { this->meta = value; }

        const std::string & get_temp() const { return temp; }
        std::string & get_mutable_temp() { return temp; }
        void set_temp(const std::string & value) { this->temp = value; }

        const double & get_visibility() const { return visibility; }
        double & get_mutable_visibility() { return visibility; }
        void set_visibility(const double & value) { this->visibility = value; }

        const std::string & get_weather() const { return weather; }
        std::string & get_mutable_weather() { return weather; }
        void set_weather(const std::string & value) { this->weather = value; }

        const std::string & get_wind() const { return wind; }
        std::string & get_mutable_wind() { return wind; }
        void set_wind(const std::string & value) { this->wind = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::string city;
        std::string delay;
        std::string iata;
        std::string icao;
        std::string name;
        std::string state;
        Status status;
        Weather weather;

        public:
        const std::string & get_city() const { return city; }
        std::string & get_mutable_city() { return city; }
        void set_city(const std::string & value) { this->city = value; }

        const std::string & get_delay() const { return delay; }
        std::string & get_mutable_delay() { return delay; }
        void set_delay(const std::string & value) { this->delay = value; }

        const std::string & get_iata() const { return iata; }
        std::string & get_mutable_iata() { return iata; }
        void set_iata(const std::string & value) { this->iata = value; }

        const std::string & get_icao() const { return icao; }
        std::string & get_mutable_icao() { return icao; }
        void set_icao(const std::string & value) { this->icao = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        const std::string & get_state() const { return state; }
        std::string & get_mutable_state() { return state; }
        void set_state(const std::string & value) { this->state = value; }

        const Status & get_status() const { return status; }
        Status & get_mutable_status() { return status; }
        void set_status(const Status & value) { this->status = value; }

        const Weather & get_weather() const { return weather; }
        Weather & get_mutable_weather() { return weather; }
        void set_weather(const Weather & value) { this->weather = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Status & x);
    void to_json(json & j, const Status & x);

    void from_json(const json & j, Meta & x);
    void to_json(json & j, const Meta & x);

    void from_json(const json & j, Weather & x);
    void to_json(json & j, const Weather & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Status& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_avg_delay(j.at("avgDelay").get<std::string>());
        x.set_closure_begin(j.at("closureBegin").get<std::string>());
        x.set_closure_end(j.at("closureEnd").get<std::string>());
        x.set_end_time(j.at("endTime").get<std::string>());
        x.set_max_delay(j.at("maxDelay").get<std::string>());
        x.set_min_delay(j.at("minDelay").get<std::string>());
        x.set_reason(j.at("reason").get<std::string>());
        x.set_trend(j.at("trend").get<std::string>());
        x.set_type(j.at("type").get<std::string>());
    }

    inline void to_json(json & j, const Status & x) {
        j = json::object();
        j["avgDelay"] = x.get_avg_delay();
        j["closureBegin"] = x.get_closure_begin();
        j["closureEnd"] = x.get_closure_end();
        j["endTime"] = x.get_end_time();
        j["maxDelay"] = x.get_max_delay();
        j["minDelay"] = x.get_min_delay();
        j["reason"] = x.get_reason();
        j["trend"] = x.get_trend();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Meta& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_credit(j.at("credit").get<std::string>());
        x.set_updated(j.at("updated").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
    }

    inline void to_json(json & j, const Meta & x) {
        j = json::object();
        j["credit"] = x.get_credit();
        j["updated"] = x.get_updated();
        j["url"] = x.get_url();
    }

    inline void from_json(const json & j, Weather& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_meta(j.at("meta").get<Meta>());
        x.set_temp(j.at("temp").get<std::string>());
        x.set_visibility(j.at("visibility").get<double>());
        x.set_weather(j.at("weather").get<std::string>());
        x.set_wind(j.at("wind").get<std::string>());
    }

    inline void to_json(json & j, const Weather & x) {
        j = json::object();
        j["meta"] = x.get_meta();
        j["temp"] = x.get_temp();
        j["visibility"] = x.get_visibility();
        j["weather"] = x.get_weather();
        j["wind"] = x.get_wind();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_city(j.at("city").get<std::string>());
        x.set_delay(j.at("delay").get<std::string>());
        x.set_iata(j.at("IATA").get<std::string>());
        x.set_icao(j.at("ICAO").get<std::string>());
        x.set_name(j.at("name").get<std::string>());
        x.set_state(j.at("state").get<std::string>());
        x.set_status(j.at("status").get<Status>());
        x.set_weather(j.at("weather").get<Weather>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["city"] = x.get_city();
        j["delay"] = x.get_delay();
        j["IATA"] = x.get_iata();
        j["ICAO"] = x.get_icao();
        j["name"] = x.get_name();
        j["state"] = x.get_state();
        j["status"] = x.get_status();
        j["weather"] = x.get_weather();
    }
}
