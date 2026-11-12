//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
#include <variant>
#include "json.hpp"

#include <optional>
#include <stdexcept>
#include <regex>

#ifndef NLOHMANN_OPT_HELPER
#define NLOHMANN_OPT_HELPER
namespace nlohmann {
    template <typename T>
    struct adl_serializer<std::shared_ptr<T>> {
        static void to_json(json & j, const std::shared_ptr<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::shared_ptr<T> from_json(const json & j) {
            if (j.is_null()) return std::shared_ptr<T>(); else return std::make_shared<T>(j.get<T>());
        }
    };
    template <typename T>
    struct adl_serializer<std::optional<T>> {
        static void to_json(json & j, const std::optional<T> & opt) {
            if (!opt) j = nullptr; else j = *opt;
        }

        static std::optional<T> from_json(const json & j) {
            if (j.is_null()) return std::optional<T>(); else return std::make_optional<T>(j.get<T>());
        }
    };
}
#endif

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

    #ifndef NLOHMANN_OPTIONAL_quicktype_HELPER
    #define NLOHMANN_OPTIONAL_quicktype_HELPER
    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::shared_ptr<T>>();
        }
        return std::shared_ptr<T>();
    }

    template <typename T>
    inline std::shared_ptr<T> get_heap_optional(const json & j, std::string property) {
        return get_heap_optional<T>(j, property.data());
    }
    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, const char * property) {
        auto it = j.find(property);
        if (it != j.end() && !it->is_null()) {
            return j.at(property).get<std::optional<T>>();
        }
        return std::optional<T>();
    }

    template <typename T>
    inline std::optional<T> get_stack_optional(const json & j, std::string property) {
        return get_stack_optional<T>(j, property.data());
    }
    #endif

    class ClosedClass {
        public:
        ClosedClass() = default;
        virtual ~ClosedClass() = default;

        private:

        public:
    };

    using Closed = std::optional<std::variant<std::vector<nlohmann::json>, bool, ClosedClass, double, int64_t, std::string>>;

    class Item {
        public:
        Item() = default;
        virtual ~Item() = default;

        private:
        std::string key;
        std::string value;

        public:
        const std::string & get_key() const { return key; }
        std::string & get_mutable_key() { return key; }
        void set_key(const std::string & value) { this->key = value; }

        const std::string & get_value() const { return value; }
        std::string & get_mutable_value() { return value; }
        void set_value(const std::string & value) { this->value = value; }
    };

    class Config {
        public:
        Config() = default;
        virtual ~Config() = default;

        private:
        Closed closed;
        std::optional<std::string> name;
        std::optional<std::map<std::string, std::vector<Item>>> settings;

        public:
        Closed get_closed() const { return closed; }
        void set_closed(Closed value) { this->closed = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        const std::optional<std::map<std::string, std::vector<Item>>> & get_settings() const { return settings; }
        std::optional<std::map<std::string, std::vector<Item>>> & get_mutable_settings() { return settings; }
        void set_settings(const std::optional<std::map<std::string, std::vector<Item>>> & value) { this->settings = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<Config> config;

        public:
        const std::optional<Config> & get_config() const { return config; }
        std::optional<Config> & get_mutable_config() { return config; }
        void set_config(const std::optional<Config> & value) { this->config = value; }
    };
}

namespace quicktype {
void from_json(const json & j, ClosedClass & x);
void to_json(json & j, const ClosedClass & x);

void from_json(const json & j, Item & x);
void to_json(json & j, const Item & x);

void from_json(const json & j, Config & x);
void to_json(json & j, const Config & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<std::vector<json>, bool, quicktype::ClosedClass, double, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::ClosedClass, double, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::ClosedClass, double, int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, ClosedClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const ClosedClass & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, Item& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_key(j.at("key").get<std::string>());
        x.set_value(j.at("value").get<std::string>());
    }

    inline void to_json(json & j, const Item & x) {
        j = json::object();
        j["key"] = x.get_key();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, Config& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_closed(get_stack_optional<std::variant<std::vector<nlohmann::json>, bool, ClosedClass, double, int64_t, std::string>>(j, "closed"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        if (j.find("settings") != j.end() && j.at("settings").is_null()) throw std::runtime_error("Unexpected null");
        x.set_settings(get_stack_optional<std::map<std::string, std::vector<Item>>>(j, "settings"));
    }

    inline void to_json(json & j, const Config & x) {
        j = json::object();
        j["closed"] = x.get_closed();
        j["name"] = x.get_name();
        j["settings"] = x.get_settings();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("config") != j.end() && j.at("config").is_null()) throw std::runtime_error("Unexpected null");
        x.set_config(get_stack_optional<Config>(j, "config"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["config"] = x.get_config();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::ClosedClass, double, int64_t, std::string>>::from_json(const json & j, std::variant<std::vector<json>, bool, quicktype::ClosedClass, double, int64_t, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::ClosedClass>();
        else if (j.is_array())
            x = j.get<std::vector<json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<json>, bool, quicktype::ClosedClass, double, int64_t, std::string>>::to_json(json & j, const std::variant<std::vector<json>, bool, quicktype::ClosedClass, double, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<json>>(x);
                break;
            case 1:
                j = std::get<bool>(x);
                break;
            case 2:
                j = std::get<quicktype::ClosedClass>(x);
                break;
            case 3:
                j = std::get<double>(x);
                break;
            case 4:
                j = std::get<int64_t>(x);
                break;
            case 5:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
