//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <optional>
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

    class Address {
        public:
        Address() = default;
        virtual ~Address() = default;

        private:
        std::string city;
        std::string country;
        std::string street;

        public:
        const std::string & get_city() const { return city; }
        std::string & get_mutable_city() { return city; }
        void set_city(const std::string & value) { this->city = value; }

        const std::string & get_country() const { return country; }
        std::string & get_mutable_country() { return country; }
        void set_country(const std::string & value) { this->country = value; }

        const std::string & get_street() const { return street; }
        std::string & get_mutable_street() { return street; }
        void set_street(const std::string & value) { this->street = value; }
    };

    class Item {
        public:
        Item() = default;
        virtual ~Item() = default;

        private:
        std::optional<Address> address;
        std::optional<std::string> created_at;
        std::string name;
        std::optional<int64_t> sex;

        public:
        const std::optional<Address> & get_address() const { return address; }
        std::optional<Address> & get_mutable_address() { return address; }
        void set_address(const std::optional<Address> & value) { this->address = value; }

        const std::optional<std::string> & get_created_at() const { return created_at; }
        std::optional<std::string> & get_mutable_created_at() { return created_at; }
        void set_created_at(const std::optional<std::string> & value) { this->created_at = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }

        std::optional<int64_t> get_sex() const { return sex; }
        void set_sex(std::optional<int64_t> value) { this->sex = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<Item> item;

        public:
        const std::vector<Item> & get_item() const { return item; }
        std::vector<Item> & get_mutable_item() { return item; }
        void set_item(const std::vector<Item> & value) { this->item = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Address & x);
    void to_json(json & j, const Address & x);

    void from_json(const json & j, Item & x);
    void to_json(json & j, const Item & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Address& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_city(j.at("city").get<std::string>());
        x.set_country(j.at("country").get<std::string>());
        x.set_street(j.at("street").get<std::string>());
    }

    inline void to_json(json & j, const Address & x) {
        j = json::object();
        j["city"] = x.get_city();
        j["country"] = x.get_country();
        j["street"] = x.get_street();
    }

    inline void from_json(const json & j, Item& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("address") != j.end() && j.at("address").is_null()) throw std::runtime_error("Unexpected null");
        x.set_address(get_stack_optional<Address>(j, "address"));
        if (j.find("created_at") != j.end() && !std::regex_match(j.at("created_at").get<std::string>(), std::regex("^[0-9]{4}-[0-9]{2}-[0-9]{2}T.*$"))) throw std::runtime_error("Expected date-time");
        if (j.find("created_at") != j.end() && j.at("created_at").is_null()) throw std::runtime_error("Unexpected null");
        x.set_created_at(get_stack_optional<std::string>(j, "created_at"));
        x.set_name(j.at("name").get<std::string>());
        j.at("sex");
        x.set_sex(get_stack_optional<int64_t>(j, "sex"));
    }

    inline void to_json(json & j, const Item & x) {
        j = json::object();
        j["address"] = x.get_address();
        j["created_at"] = x.get_created_at();
        j["name"] = x.get_name();
        j["sex"] = x.get_sex();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_item(j.at("item").get<std::vector<Item>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["item"] = x.get_item();
    }
}
