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

    enum class Code : int { SF };

    enum class English : int { SF };

    enum class Thai : int { EMPTY };

    class Group {
        public:
        Group() = default;
        virtual ~Group() = default;

        private:
        Code code;
        English english;
        Thai thai;
        std::string website;

        public:
        const Code & get_code() const { return code; }
        Code & get_mutable_code() { return code; }
        void set_code(const Code & value) { this->code = value; }

        const English & get_english() const { return english; }
        English & get_mutable_english() { return english; }
        void set_english(const English & value) { this->english = value; }

        const Thai & get_thai() const { return thai; }
        Thai & get_mutable_thai() { return thai; }
        void set_thai(const Thai & value) { this->thai = value; }

        const std::string & get_website() const { return website; }
        std::string & get_mutable_website() { return website; }
        void set_website(const std::string & value) { this->website = value; }
    };

    enum class Location : int { EMPTY, THE_5_TH_FL_EMPORIUM };

    enum class Tel : int { EMPTY, THE_022688899 };

    class Result {
        public:
        Result() = default;
        virtual ~Result() = default;

        private:
        std::string code;
        std::string english;
        bool fav;
        Group group;
        Location location;
        int64_t min_screens;
        int64_t num_views;
        std::string showtimes;
        int64_t stars;
        Tel tel;
        std::string thai;
        int64_t today_screens;
        std::string url;
        std::string website;

        public:
        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const std::string & get_english() const { return english; }
        std::string & get_mutable_english() { return english; }
        void set_english(const std::string & value) { this->english = value; }

        const bool & get_fav() const { return fav; }
        bool & get_mutable_fav() { return fav; }
        void set_fav(const bool & value) { this->fav = value; }

        const Group & get_group() const { return group; }
        Group & get_mutable_group() { return group; }
        void set_group(const Group & value) { this->group = value; }

        const Location & get_location() const { return location; }
        Location & get_mutable_location() { return location; }
        void set_location(const Location & value) { this->location = value; }

        const int64_t & get_min_screens() const { return min_screens; }
        int64_t & get_mutable_min_screens() { return min_screens; }
        void set_min_screens(const int64_t & value) { this->min_screens = value; }

        const int64_t & get_num_views() const { return num_views; }
        int64_t & get_mutable_num_views() { return num_views; }
        void set_num_views(const int64_t & value) { this->num_views = value; }

        const std::string & get_showtimes() const { return showtimes; }
        std::string & get_mutable_showtimes() { return showtimes; }
        void set_showtimes(const std::string & value) { this->showtimes = value; }

        const int64_t & get_stars() const { return stars; }
        int64_t & get_mutable_stars() { return stars; }
        void set_stars(const int64_t & value) { this->stars = value; }

        const Tel & get_tel() const { return tel; }
        Tel & get_mutable_tel() { return tel; }
        void set_tel(const Tel & value) { this->tel = value; }

        const std::string & get_thai() const { return thai; }
        std::string & get_mutable_thai() { return thai; }
        void set_thai(const std::string & value) { this->thai = value; }

        const int64_t & get_today_screens() const { return today_screens; }
        int64_t & get_mutable_today_screens() { return today_screens; }
        void set_today_screens(const int64_t & value) { this->today_screens = value; }

        const std::string & get_url() const { return url; }
        std::string & get_mutable_url() { return url; }
        void set_url(const std::string & value) { this->url = value; }

        const std::string & get_website() const { return website; }
        std::string & get_mutable_website() { return website; }
        void set_website(const std::string & value) { this->website = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        int64_t count;
        std::string next;
        nlohmann::json previous;
        std::vector<Result> results;

        public:
        const int64_t & get_count() const { return count; }
        int64_t & get_mutable_count() { return count; }
        void set_count(const int64_t & value) { this->count = value; }

        const std::string & get_next() const { return next; }
        std::string & get_mutable_next() { return next; }
        void set_next(const std::string & value) { this->next = value; }

        const nlohmann::json & get_previous() const { return previous; }
        nlohmann::json & get_mutable_previous() { return previous; }
        void set_previous(const nlohmann::json & value) { this->previous = value; }

        const std::vector<Result> & get_results() const { return results; }
        std::vector<Result> & get_mutable_results() { return results; }
        void set_results(const std::vector<Result> & value) { this->results = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Group & x);
    void to_json(json & j, const Group & x);

    void from_json(const json & j, Result & x);
    void to_json(json & j, const Result & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Code & x);
    void to_json(json & j, const Code & x);

    void from_json(const json & j, English & x);
    void to_json(json & j, const English & x);

    void from_json(const json & j, Thai & x);
    void to_json(json & j, const Thai & x);

    void from_json(const json & j, Location & x);
    void to_json(json & j, const Location & x);

    void from_json(const json & j, Tel & x);
    void to_json(json & j, const Tel & x);

    inline void from_json(const json & j, Group& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<Code>());
        x.set_english(j.at("english").get<English>());
        x.set_thai(j.at("thai").get<Thai>());
        x.set_website(j.at("website").get<std::string>());
    }

    inline void to_json(json & j, const Group & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["english"] = x.get_english();
        j["thai"] = x.get_thai();
        j["website"] = x.get_website();
    }

    inline void from_json(const json & j, Result& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_code(j.at("code").get<std::string>());
        x.set_english(j.at("english").get<std::string>());
        x.set_fav(j.at("fav").get<bool>());
        x.set_group(j.at("group").get<Group>());
        x.set_location(j.at("location").get<Location>());
        if (j.find("min_screens") != j.end() && !j.at("min_screens").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_min_screens(j.at("min_screens").get<int64_t>());
        if (j.find("num_views") != j.end() && !j.at("num_views").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_num_views(j.at("num_views").get<int64_t>());
        x.set_showtimes(j.at("showtimes").get<std::string>());
        if (j.find("stars") != j.end() && !j.at("stars").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_stars(j.at("stars").get<int64_t>());
        x.set_tel(j.at("tel").get<Tel>());
        x.set_thai(j.at("thai").get<std::string>());
        if (j.find("today_screens") != j.end() && !j.at("today_screens").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_today_screens(j.at("today_screens").get<int64_t>());
        x.set_url(j.at("url").get<std::string>());
        x.set_website(j.at("website").get<std::string>());
    }

    inline void to_json(json & j, const Result & x) {
        j = json::object();
        j["code"] = x.get_code();
        j["english"] = x.get_english();
        j["fav"] = x.get_fav();
        j["group"] = x.get_group();
        j["location"] = x.get_location();
        j["min_screens"] = x.get_min_screens();
        j["num_views"] = x.get_num_views();
        j["showtimes"] = x.get_showtimes();
        j["stars"] = x.get_stars();
        j["tel"] = x.get_tel();
        j["thai"] = x.get_thai();
        j["today_screens"] = x.get_today_screens();
        j["url"] = x.get_url();
        j["website"] = x.get_website();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_count(j.at("count").get<int64_t>());
        x.set_next(j.at("next").get<std::string>());
        x.set_previous(get_untyped(j, "previous"));
        x.set_results(j.at("results").get<std::vector<Result>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["next"] = x.get_next();
        j["previous"] = x.get_previous();
        j["results"] = x.get_results();
    }

    inline void from_json(const json & j, Code & x) {
        if (j == "sf") x = Code::SF;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Code\""); }
    }

    inline void to_json(json & j, const Code & x) {
        switch (x) {
            case Code::SF: j = "sf"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Code\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, English & x) {
        if (j == "SF") x = English::SF;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"English\""); }
    }

    inline void to_json(json & j, const English & x) {
        switch (x) {
            case English::SF: j = "SF"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"English\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Thai & x) {
        if (j == "เอสเอฟ") x = Thai::EMPTY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Thai\""); }
    }

    inline void to_json(json & j, const Thai & x) {
        switch (x) {
            case Thai::EMPTY: j = "เอสเอฟ"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Thai\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Location & x) {
        if (j == "") x = Location::EMPTY;
        else if (j == "5th Fl. Emporium") x = Location::THE_5_TH_FL_EMPORIUM;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Location\""); }
    }

    inline void to_json(json & j, const Location & x) {
        switch (x) {
            case Location::EMPTY: j = ""; break;
            case Location::THE_5_TH_FL_EMPORIUM: j = "5th Fl. Emporium"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Location\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Tel & x) {
        if (j == "") x = Tel::EMPTY;
        else if (j == "02-268-8899") x = Tel::THE_022688899;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Tel\""); }
    }

    inline void to_json(json & j, const Tel & x) {
        switch (x) {
            case Tel::EMPTY: j = ""; break;
            case Tel::THE_022688899: j = "02-268-8899"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Tel\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
