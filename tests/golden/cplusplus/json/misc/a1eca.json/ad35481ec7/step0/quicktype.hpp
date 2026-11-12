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

    class Astronomy {
        public:
        Astronomy() = default;
        virtual ~Astronomy() = default;

        private:
        std::string sunrise;
        std::string sunset;

        public:
        const std::string & get_sunrise() const { return sunrise; }
        std::string & get_mutable_sunrise() { return sunrise; }
        void set_sunrise(const std::string & value) { this->sunrise = value; }

        const std::string & get_sunset() const { return sunset; }
        std::string & get_mutable_sunset() { return sunset; }
        void set_sunset(const std::string & value) { this->sunset = value; }
    };

    class Atmosphere {
        public:
        Atmosphere() = default;
        virtual ~Atmosphere() = default;

        private:
        std::string humidity;
        std::string pressure;
        std::string rising;
        std::string visibility;

        public:
        const std::string & get_humidity() const { return humidity; }
        std::string & get_mutable_humidity() { return humidity; }
        void set_humidity(const std::string & value) { this->humidity = value; }

        const std::string & get_pressure() const { return pressure; }
        std::string & get_mutable_pressure() { return pressure; }
        void set_pressure(const std::string & value) { this->pressure = value; }

        const std::string & get_rising() const { return rising; }
        std::string & get_mutable_rising() { return rising; }
        void set_rising(const std::string & value) { this->rising = value; }

        const std::string & get_visibility() const { return visibility; }
        std::string & get_mutable_visibility() { return visibility; }
        void set_visibility(const std::string & value) { this->visibility = value; }
    };

    class Image {
        public:
        Image() = default;
        virtual ~Image() = default;

        private:
        std::string height;
        std::string link;
        std::string title;
        std::string url;
        std::string width;

        public:
        const std::string & get_height() const { return height; }
        std::string & get_mutable_height() { return height; }
        void set_height(const std::string & value) { this->height = value; }

        const std::string & get_link() const { return link; }
        std::string & get_mutable_link() { return link; }
        void set_link(const std::string & value) { this->link = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const std::string & get_width() const { return width; }
        std::string & get_mutable_width() { return width; }
        void set_width(const std::string & value) { this->width = value; }
    };

    class Condition {
        public:
        Condition() = default;
        virtual ~Condition() = default;

        private:
        std::string code;
        std::string date;
        std::string temp;
        std::string text;

        public:
        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const std::string & get_temp() const { return temp; }
        std::string & get_mutable_temp() { return temp; }
        void set_temp(const std::string & value) { this->temp = value; }

        const std::string & get_text() const { return text; }
        std::string & get_mutable_text() { return text; }
        void set_text(const std::string & value) { this->text = value; }
    };

    class Forecast {
        public:
        Forecast() = default;
        virtual ~Forecast() = default;

        private:
        std::string code;
        std::string date;
        std::string day;
        std::string high;
        std::string low;
        std::string text;

        public:
        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_date() const { return date; }
        std::string & get_mutable_date() { return date; }
        void set_date(const std::string & value) { this->date = value; }

        const std::string & get_day() const { return day; }
        std::string & get_mutable_day() { return day; }
        void set_day(const std::string & value) { this->day = value; }

        const std::string & get_high() const { return high; }
        std::string & get_mutable_high() { return high; }
        void set_high(const std::string & value) { this->high = value; }

        const std::string & get_low() const { return low; }
        std::string & get_mutable_low() { return low; }
        void set_low(const std::string & value) { this->low = value; }

        const std::string & get_text() const { return text; }
        std::string & get_mutable_text() { return text; }
        void set_text(const std::string & value) { this->text = value; }
    };

    class Guid {
        public:
        Guid() = default;
        virtual ~Guid() = default;

        private:
        std::string is_perma_link;

        public:
        const std::string & get_is_perma_link() const { return is_perma_link; }
        std::string & get_mutable_is_perma_link() { return is_perma_link; }
        void set_is_perma_link(const std::string & value) { this->is_perma_link = value; }
    };

    class Item {
        public:
        Item() = default;
        virtual ~Item() = default;

        private:
        Condition condition;
        std::string description;
        std::vector<Forecast> forecast;
        Guid guid;
        std::string item_long;
        std::string lat;
        std::string link;
        std::string pub_date;
        std::string title;

        public:
        const Condition & get_condition() const { return condition; }
        Condition & get_mutable_condition() { return condition; }
        void set_condition(const Condition & value) { this->condition = value; }

        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const std::vector<Forecast> & get_forecast() const { return forecast; }
        std::vector<Forecast> & get_mutable_forecast() { return forecast; }
        void set_forecast(const std::vector<Forecast> & value) { this->forecast = value; }

        const Guid & get_guid() const { return guid; }
        Guid & get_mutable_guid() { return guid; }
        void set_guid(const Guid & value) { this->guid = value; }

        const std::string & get_item_long() const { return item_long; }
        std::string & get_mutable_item_long() { return item_long; }
        void set_item_long(const std::string & value) { this->item_long = value; }

        const std::string & get_lat() const { return lat; }
        std::string & get_mutable_lat() { return lat; }
        void set_lat(const std::string & value) { this->lat = value; }

        const std::string & get_link() const { return link; }
        std::string & get_mutable_link() { return link; }
        void set_link(const std::string & value) { this->link = value; }

        const std::string & get_pub_date() const { return pub_date; }
        std::string & get_mutable_pub_date() { return pub_date; }
        void set_pub_date(const std::string & value) { this->pub_date = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }
    };

    class Location {
        public:
        Location() = default;
        virtual ~Location() = default;

        private:
        std::string city;
        std::string country;
        std::string region;

        public:
        const std::string & get_city() const { return city; }
        std::string & get_mutable_city() { return city; }
        void set_city(const std::string & value) { this->city = value; }

        const std::string & get_country() const { return country; }
        std::string & get_mutable_country() { return country; }
        void set_country(const std::string & value) { this->country = value; }

        const std::string & get_region() const { return region; }
        std::string & get_mutable_region() { return region; }
        void set_region(const std::string & value) { this->region = value; }
    };

    class Units {
        public:
        Units() = default;
        virtual ~Units() = default;

        private:
        std::string distance;
        std::string pressure;
        std::string speed;
        std::string temperature;

        public:
        const std::string & get_distance() const { return distance; }
        std::string & get_mutable_distance() { return distance; }
        void set_distance(const std::string & value) { this->distance = value; }

        const std::string & get_pressure() const { return pressure; }
        std::string & get_mutable_pressure() { return pressure; }
        void set_pressure(const std::string & value) { this->pressure = value; }

        const std::string & get_speed() const { return speed; }
        std::string & get_mutable_speed() { return speed; }
        void set_speed(const std::string & value) { this->speed = value; }

        const std::string & get_temperature() const { return temperature; }
        std::string & get_mutable_temperature() { return temperature; }
        void set_temperature(const std::string & value) { this->temperature = value; }
    };

    class Wind {
        public:
        Wind() = default;
        virtual ~Wind() = default;

        private:
        std::string chill;
        std::string direction;
        std::string speed;

        public:
        const std::string & get_chill() const { return chill; }
        std::string & get_mutable_chill() { return chill; }
        void set_chill(const std::string & value) { this->chill = value; }

        const std::string & get_direction() const { return direction; }
        std::string & get_mutable_direction() { return direction; }
        void set_direction(const std::string & value) { this->direction = value; }

        const std::string & get_speed() const { return speed; }
        std::string & get_mutable_speed() { return speed; }
        void set_speed(const std::string & value) { this->speed = value; }
    };

    class Channel {
        public:
        Channel() = default;
        virtual ~Channel() = default;

        private:
        Astronomy astronomy;
        Atmosphere atmosphere;
        std::string description;
        Image image;
        Item item;
        std::string language;
        std::string last_build_date;
        std::string link;
        Location location;
        std::string title;
        std::string ttl;
        Units units;
        Wind wind;

        public:
        const Astronomy & get_astronomy() const { return astronomy; }
        Astronomy & get_mutable_astronomy() { return astronomy; }
        void set_astronomy(const Astronomy & value) { this->astronomy = value; }

        const Atmosphere & get_atmosphere() const { return atmosphere; }
        Atmosphere & get_mutable_atmosphere() { return atmosphere; }
        void set_atmosphere(const Atmosphere & value) { this->atmosphere = value; }

        const std::string & get_description() const { return description; }
        std::string & get_mutable_description() { return description; }
        void set_description(const std::string & value) { this->description = value; }

        const Image & get_image() const { return image; }
        Image & get_mutable_image() { return image; }
        void set_image(const Image & value) { this->image = value; }

        const Item & get_item() const { return item; }
        Item & get_mutable_item() { return item; }
        void set_item(const Item & value) { this->item = value; }

        const std::string & get_language() const { return language; }
        std::string & get_mutable_language() { return language; }
        void set_language(const std::string & value) { this->language = value; }

        const std::string & get_last_build_date() const { return last_build_date; }
        std::string & get_mutable_last_build_date() { return last_build_date; }
        void set_last_build_date(const std::string & value) { this->last_build_date = value; }

        const std::string & get_link() const { return link; }
        std::string & get_mutable_link() { return link; }
        void set_link(const std::string & value) { this->link = value; }

        const Location & get_location() const { return location; }
        Location & get_mutable_location() { return location; }
        void set_location(const Location & value) { this->location = value; }

        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }

        const std::string & get_ttl() const { return ttl; }
        std::string & get_mutable_ttl() { return ttl; }
        void set_ttl(const std::string & value) { this->ttl = value; }

        const Units & get_units() const { return units; }
        Units & get_mutable_units() { return units; }
        void set_units(const Units & value) { this->units = value; }

        const Wind & get_wind() const { return wind; }
        Wind & get_mutable_wind() { return wind; }
        void set_wind(const Wind & value) { this->wind = value; }
    };

    class Results {
        public:
        Results() = default;
        virtual ~Results() = default;

        private:
        Channel channel;

        public:
        const Channel & get_channel() const { return channel; }
        Channel & get_mutable_channel() { return channel; }
        void set_channel(const Channel & value) { this->channel = value; }
    };

    class Query {
        public:
        Query() = default;
        virtual ~Query() = default;

        private:
        int64_t count;
        std::string created;
        std::string lang;
        Results results;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const std::string & get_created() const { return created; }
        std::string & get_mutable_created() { return created; }
        void set_created(const std::string & value) { this->created = value; }

        const std::string & get_lang() const { return lang; }
        std::string & get_mutable_lang() { return lang; }
        void set_lang(const std::string & value) { this->lang = value; }

        const Results & get_results() const { return results; }
        Results & get_mutable_results() { return results; }
        void set_results(const Results & value) { this->results = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        Query query;

        public:
        const Query & get_query() const { return query; }
        Query & get_mutable_query() { return query; }
        void set_query(const Query & value) { this->query = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Astronomy & x);
    void to_json(json & j, const Astronomy & x);

    void from_json(const json & j, Atmosphere & x);
    void to_json(json & j, const Atmosphere & x);

    void from_json(const json & j, Image & x);
    void to_json(json & j, const Image & x);

    void from_json(const json & j, Condition & x);
    void to_json(json & j, const Condition & x);

    void from_json(const json & j, Forecast & x);
    void to_json(json & j, const Forecast & x);

    void from_json(const json & j, Guid & x);
    void to_json(json & j, const Guid & x);

    void from_json(const json & j, Item & x);
    void to_json(json & j, const Item & x);

    void from_json(const json & j, Location & x);
    void to_json(json & j, const Location & x);

    void from_json(const json & j, Units & x);
    void to_json(json & j, const Units & x);

    void from_json(const json & j, Wind & x);
    void to_json(json & j, const Wind & x);

    void from_json(const json & j, Channel & x);
    void to_json(json & j, const Channel & x);

    void from_json(const json & j, Results & x);
    void to_json(json & j, const Results & x);

    void from_json(const json & j, Query & x);
    void to_json(json & j, const Query & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Astronomy& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_sunrise(j.at("sunrise").get<std::string>());
        x.set_sunset(j.at("sunset").get<std::string>());
    }

    inline void to_json(json & j, const Astronomy & x) {
        j = json::object();
        j["sunrise"] = x.get_sunrise();
        j["sunset"] = x.get_sunset();
    }

    inline void from_json(const json & j, Atmosphere& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_humidity(j.at("humidity").get<std::string>());
        x.set_pressure(j.at("pressure").get<std::string>());
        x.set_rising(j.at("rising").get<std::string>());
        x.set_visibility(j.at("visibility").get<std::string>());
    }

    inline void to_json(json & j, const Atmosphere & x) {
        j = json::object();
        j["humidity"] = x.get_humidity();
        j["pressure"] = x.get_pressure();
        j["rising"] = x.get_rising();
        j["visibility"] = x.get_visibility();
    }

    inline void from_json(const json & j, Image& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_height(j.at("height").get<std::string>());
        x.set_link(j.at("link").get<std::string>());
        x.set_title(j.at("title").get<std::string>());
        x.set_url(j.at("url").get<std::string>());
        x.set_width(j.at("width").get<std::string>());
    }

    inline void to_json(json & j, const Image & x) {
        j = json::object();
        j["height"] = x.get_height();
        j["link"] = x.get_link();
        j["title"] = x.get_title();
        j["url"] = x.get_url();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, Condition& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<std::string>());
        x.set_date(j.at("date").get<std::string>());
        x.set_temp(j.at("temp").get<std::string>());
        x.set_text(j.at("text").get<std::string>());
    }

    inline void to_json(json & j, const Condition & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["date"] = x.get_date();
        j["temp"] = x.get_temp();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, Forecast& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<std::string>());
        x.set_date(j.at("date").get<std::string>());
        x.set_day(j.at("day").get<std::string>());
        x.set_high(j.at("high").get<std::string>());
        x.set_low(j.at("low").get<std::string>());
        x.set_text(j.at("text").get<std::string>());
    }

    inline void to_json(json & j, const Forecast & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["date"] = x.get_date();
        j["day"] = x.get_day();
        j["high"] = x.get_high();
        j["low"] = x.get_low();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, Guid& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_is_perma_link(j.at("isPermaLink").get<std::string>());
    }

    inline void to_json(json & j, const Guid & x) {
        j = json::object();
        j["isPermaLink"] = x.get_is_perma_link();
    }

    inline void from_json(const json & j, Item& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_condition(j.at("condition").get<Condition>());
        x.set_description(j.at("description").get<std::string>());
        x.set_forecast(j.at("forecast").get<std::vector<Forecast>>());
        x.set_guid(j.at("guid").get<Guid>());
        x.set_item_long(j.at("long").get<std::string>());
        x.set_lat(j.at("lat").get<std::string>());
        x.set_link(j.at("link").get<std::string>());
        x.set_pub_date(j.at("pubDate").get<std::string>());
        x.set_title(j.at("title").get<std::string>());
    }

    inline void to_json(json & j, const Item & x) {
        j = json::object();
        j["condition"] = x.get_condition();
        j["description"] = x.get_description();
        j["forecast"] = x.get_forecast();
        j["guid"] = x.get_guid();
        j["long"] = x.get_item_long();
        j["lat"] = x.get_lat();
        j["link"] = x.get_link();
        j["pubDate"] = x.get_pub_date();
        j["title"] = x.get_title();
    }

    inline void from_json(const json & j, Location& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_city(j.at("city").get<std::string>());
        x.set_country(j.at("country").get<std::string>());
        x.set_region(j.at("region").get<std::string>());
    }

    inline void to_json(json & j, const Location & x) {
        j = json::object();
        j["city"] = x.get_city();
        j["country"] = x.get_country();
        j["region"] = x.get_region();
    }

    inline void from_json(const json & j, Units& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_distance(j.at("distance").get<std::string>());
        x.set_pressure(j.at("pressure").get<std::string>());
        x.set_speed(j.at("speed").get<std::string>());
        x.set_temperature(j.at("temperature").get<std::string>());
    }

    inline void to_json(json & j, const Units & x) {
        j = json::object();
        j["distance"] = x.get_distance();
        j["pressure"] = x.get_pressure();
        j["speed"] = x.get_speed();
        j["temperature"] = x.get_temperature();
    }

    inline void from_json(const json & j, Wind& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_chill(j.at("chill").get<std::string>());
        x.set_direction(j.at("direction").get<std::string>());
        x.set_speed(j.at("speed").get<std::string>());
    }

    inline void to_json(json & j, const Wind & x) {
        j = json::object();
        j["chill"] = x.get_chill();
        j["direction"] = x.get_direction();
        j["speed"] = x.get_speed();
    }

    inline void from_json(const json & j, Channel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_astronomy(j.at("astronomy").get<Astronomy>());
        x.set_atmosphere(j.at("atmosphere").get<Atmosphere>());
        x.set_description(j.at("description").get<std::string>());
        x.set_image(j.at("image").get<Image>());
        x.set_item(j.at("item").get<Item>());
        x.set_language(j.at("language").get<std::string>());
        x.set_last_build_date(j.at("lastBuildDate").get<std::string>());
        x.set_link(j.at("link").get<std::string>());
        x.set_location(j.at("location").get<Location>());
        x.set_title(j.at("title").get<std::string>());
        x.set_ttl(j.at("ttl").get<std::string>());
        x.set_units(j.at("units").get<Units>());
        x.set_wind(j.at("wind").get<Wind>());
    }

    inline void to_json(json & j, const Channel & x) {
        j = json::object();
        j["astronomy"] = x.get_astronomy();
        j["atmosphere"] = x.get_atmosphere();
        j["description"] = x.get_description();
        j["image"] = x.get_image();
        j["item"] = x.get_item();
        j["language"] = x.get_language();
        j["lastBuildDate"] = x.get_last_build_date();
        j["link"] = x.get_link();
        j["location"] = x.get_location();
        j["title"] = x.get_title();
        j["ttl"] = x.get_ttl();
        j["units"] = x.get_units();
        j["wind"] = x.get_wind();
    }

    inline void from_json(const json & j, Results& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_channel(j.at("channel").get<Channel>());
    }

    inline void to_json(json & j, const Results & x) {
        j = json::object();
        j["channel"] = x.get_channel();
    }

    inline void from_json(const json & j, Query& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        if (j.find("created") != j.end() && !std::regex_match(j.at("created").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        x.set_created(j.at("created").get<std::string>());
        x.set_lang(j.at("lang").get<std::string>());
        x.set_results(j.at("results").get<Results>());
    }

    inline void to_json(json & j, const Query & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["created"] = x.get_created();
        j["lang"] = x.get_lang();
        j["results"] = x.get_results();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_query(j.at("query").get<Query>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["query"] = x.get_query();
    }
}
