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

    class IssPosition {
        public:
        IssPosition() = default;
        virtual ~IssPosition() = default;

        private:
        std::string latitude;
        std::string longitude;

        public:
        const std::string & get_latitude() const { return latitude; }
        std::string & get_mutable_latitude() { return latitude; }
        void set_latitude(const std::string & value) { this->latitude = value; }

        const std::string & get_longitude() const { return longitude; }
        std::string & get_mutable_longitude() { return longitude; }
        void set_longitude(const std::string & value) { this->longitude = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        IssPosition iss_position;
        std::string message;
        int64_t timestamp;

        public:
        const IssPosition & get_iss_position() const { return iss_position; }
        IssPosition & get_mutable_iss_position() { return iss_position; }
        void set_iss_position(const IssPosition & value) { this->iss_position = value; }

        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string & value) { this->message = value; }

        const int64_t & get_timestamp() const { return timestamp; }
        int64_t & get_mutable_timestamp() { return timestamp; }
        void set_timestamp(const int64_t & value) { this->timestamp = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, IssPosition & x);
    void to_json(json & j, const IssPosition & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, IssPosition& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_latitude(j.at("latitude").get<std::string>());
        x.set_longitude(j.at("longitude").get<std::string>());
    }

    inline void to_json(json & j, const IssPosition & x) {
        j = json::object();
        j["latitude"] = x.get_latitude();
        j["longitude"] = x.get_longitude();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_iss_position(j.at("iss_position").get<IssPosition>());
        x.set_message(j.at("message").get<std::string>());
        if (j.find("timestamp") != j.end() && !j.at("timestamp").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_timestamp(j.at("timestamp").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["iss_position"] = x.get_iss_position();
        j["message"] = x.get_message();
        j["timestamp"] = x.get_timestamp();
    }
}
