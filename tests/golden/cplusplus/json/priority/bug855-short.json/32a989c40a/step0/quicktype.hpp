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

    class TopLevelValue {
        public:
        TopLevelValue() = default;
        virtual ~TopLevelValue() = default;

        private:
        std::string channel_id;
        std::string channel_name;
        std::string code;
        int64_t emoticon_set;
        int64_t id;

        public:
        const std::string & get_channel_id() const { return channel_id; }
        std::string & get_mutable_channel_id() { return channel_id; }
        void set_channel_id(const std::string & value) { this->channel_id = value; }

        const std::string & get_channel_name() const { return channel_name; }
        std::string & get_mutable_channel_name() { return channel_name; }
        void set_channel_name(const std::string & value) { this->channel_name = value; }

        const std::string & get_code() const { return code; }
        std::string & get_mutable_code() { return code; }
        void set_code(const std::string & value) { this->code = value; }

        const int64_t & get_emoticon_set() const { return emoticon_set; }
        int64_t & get_mutable_emoticon_set() { return emoticon_set; }
        void set_emoticon_set(const int64_t & value) { this->emoticon_set = value; }

        const int64_t & get_id() const { return id; }
        int64_t & get_mutable_id() { return id; }
        void set_id(const int64_t & value) { this->id = value; }
    };

    using TopLevel = std::map<std::string, TopLevelValue>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelValue & x);
    void to_json(json & j, const TopLevelValue & x);

    inline void from_json(const json & j, TopLevelValue& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_channel_id(j.at("channel_id").get<std::string>());
        x.set_channel_name(j.at("channel_name").get<std::string>());
        x.set_code(j.at("code").get<std::string>());
        if (j.find("emoticon_set") != j.end() && !j.at("emoticon_set").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_emoticon_set(j.at("emoticon_set").get<int64_t>());
        if (j.find("id") != j.end() && !j.at("id").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_id(j.at("id").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevelValue & x) {
        j = json::object();
        j["channel_id"] = x.get_channel_id();
        j["channel_name"] = x.get_channel_name();
        j["code"] = x.get_code();
        j["emoticon_set"] = x.get_emoticon_set();
        j["id"] = x.get_id();
    }
}
