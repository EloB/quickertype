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

    class TopLevelElement {
        public:
        TopLevelElement() = default;
        virtual ~TopLevelElement() = default;

        private:
        std::optional<std::string> birth_date;
        bool birth_date_is_protected;
        int64_t gender_type_id;
        std::string notes;
        std::string parliamentary_name;
        int64_t person_id;
        std::string photo_url;
        std::string preferred_name;

        public:
        std::optional<std::string> get_birth_date() const { return birth_date; }
        void set_birth_date(std::optional<std::string> value) { this->birth_date = value; }

        const bool & get_birth_date_is_protected() const { return birth_date_is_protected; }
        bool & get_mutable_birth_date_is_protected() { return birth_date_is_protected; }
        void set_birth_date_is_protected(const bool & value) { this->birth_date_is_protected = value; }

        const int64_t & get_gender_type_id() const { return gender_type_id; }
        int64_t & get_mutable_gender_type_id() { return gender_type_id; }
        void set_gender_type_id(const int64_t & value) { this->gender_type_id = value; }

        const std::string & get_notes() const { return notes; }
        std::string & get_mutable_notes() { return notes; }
        void set_notes(const std::string & value) { this->notes = value; }

        const std::string & get_parliamentary_name() const { return parliamentary_name; }
        std::string & get_mutable_parliamentary_name() { return parliamentary_name; }
        void set_parliamentary_name(const std::string & value) { this->parliamentary_name = value; }

        const int64_t & get_person_id() const { return person_id; }
        int64_t & get_mutable_person_id() { return person_id; }
        void set_person_id(const int64_t & value) { this->person_id = value; }

        const std::string & get_photo_url() const { return photo_url; }
        std::string & get_mutable_photo_url() { return photo_url; }
        void set_photo_url(const std::string & value) { this->photo_url = value; }

        const std::string & get_preferred_name() const { return preferred_name; }
        std::string & get_mutable_preferred_name() { return preferred_name; }
        void set_preferred_name(const std::string & value) { this->preferred_name = value; }
    };

    using TopLevel = std::vector<TopLevelElement>;
}

namespace quicktype {
    void from_json(const json & j, TopLevelElement & x);
    void to_json(json & j, const TopLevelElement & x);

    inline void from_json(const json & j, TopLevelElement& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        j.at("BirthDate");
        x.set_birth_date(get_stack_optional<std::string>(j, "BirthDate"));
        x.set_birth_date_is_protected(j.at("BirthDateIsProtected").get<bool>());
        if (j.find("GenderTypeID") != j.end() && !j.at("GenderTypeID").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_gender_type_id(j.at("GenderTypeID").get<int64_t>());
        x.set_notes(j.at("Notes").get<std::string>());
        x.set_parliamentary_name(j.at("ParliamentaryName").get<std::string>());
        if (j.find("PersonID") != j.end() && !j.at("PersonID").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_person_id(j.at("PersonID").get<int64_t>());
        x.set_photo_url(j.at("PhotoURL").get<std::string>());
        x.set_preferred_name(j.at("PreferredName").get<std::string>());
    }

    inline void to_json(json & j, const TopLevelElement & x) {
        j = json::object();
        j["BirthDate"] = x.get_birth_date();
        j["BirthDateIsProtected"] = x.get_birth_date_is_protected();
        j["GenderTypeID"] = x.get_gender_type_id();
        j["Notes"] = x.get_notes();
        j["ParliamentaryName"] = x.get_parliamentary_name();
        j["PersonID"] = x.get_person_id();
        j["PhotoURL"] = x.get_photo_url();
        j["PreferredName"] = x.get_preferred_name();
    }
}
