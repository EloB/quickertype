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
#include <algorithm>

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

    class ClassMemberConstraints {
        private:
        std::optional<int64_t> min_int_value;
        std::optional<int64_t> max_int_value;
        std::optional<double> min_double_value;
        std::optional<double> max_double_value;
        std::optional<size_t> min_length;
        std::optional<size_t> max_length;
        std::optional<std::string> pattern;

        public:
        ClassMemberConstraints(
            std::optional<int64_t> min_int_value,
            std::optional<int64_t> max_int_value,
            std::optional<double> min_double_value,
            std::optional<double> max_double_value,
            std::optional<size_t> min_length,
            std::optional<size_t> max_length,
            std::optional<std::string> pattern
        ) : min_int_value(min_int_value), max_int_value(max_int_value), min_double_value(min_double_value), max_double_value(max_double_value), min_length(min_length), max_length(max_length), pattern(pattern) {}
        ClassMemberConstraints() = default;
        virtual ~ClassMemberConstraints() = default;

        void set_min_int_value(int64_t min_int_value) { this->min_int_value = min_int_value; }
        auto get_min_int_value() const { return min_int_value; }

        void set_max_int_value(int64_t max_int_value) { this->max_int_value = max_int_value; }
        auto get_max_int_value() const { return max_int_value; }

        void set_min_double_value(double min_double_value) { this->min_double_value = min_double_value; }
        auto get_min_double_value() const { return min_double_value; }

        void set_max_double_value(double max_double_value) { this->max_double_value = max_double_value; }
        auto get_max_double_value() const { return max_double_value; }

        void set_min_length(size_t min_length) { this->min_length = min_length; }
        auto get_min_length() const { return min_length; }

        void set_max_length(size_t max_length) { this->max_length = max_length; }
        auto get_max_length() const { return max_length; }

        void set_pattern(const std::string &  pattern) { this->pattern = pattern; }
        auto get_pattern() const { return pattern; }
    };

    class ClassMemberConstraintException : public std::runtime_error {
        public:
        ClassMemberConstraintException(const std::string &  msg) : std::runtime_error(msg) {}
    };

    class ValueTooLowException : public ClassMemberConstraintException {
        public:
        ValueTooLowException(const std::string &  msg) : ClassMemberConstraintException(msg) {}
    };

    class ValueTooHighException : public ClassMemberConstraintException {
        public:
        ValueTooHighException(const std::string &  msg) : ClassMemberConstraintException(msg) {}
    };

    class ValueTooShortException : public ClassMemberConstraintException {
        public:
        ValueTooShortException(const std::string &  msg) : ClassMemberConstraintException(msg) {}
    };

    class ValueTooLongException : public ClassMemberConstraintException {
        public:
        ValueTooLongException(const std::string &  msg) : ClassMemberConstraintException(msg) {}
    };

    class InvalidPatternException : public ClassMemberConstraintException {
        public:
        InvalidPatternException(const std::string &  msg) : ClassMemberConstraintException(msg) {}
    };

    inline void CheckConstraint(const std::string &  name, const ClassMemberConstraints & c, int64_t value) {
        if (c.get_min_int_value() != std::nullopt && value < *c.get_min_int_value()) {
            throw ValueTooLowException ("Value too low for " + name + " (" + std::to_string(value) + "<" + std::to_string(*c.get_min_int_value()) + ")");
        }

        if (c.get_max_int_value() != std::nullopt && value > *c.get_max_int_value()) {
            throw ValueTooHighException ("Value too high for " + name + " (" + std::to_string(value) + ">" + std::to_string(*c.get_max_int_value()) + ")");
        }
    }

    inline void CheckConstraint(const std::string &  name, const ClassMemberConstraints & c, const std::optional<int64_t> & value) {
        if (value) {
            CheckConstraint(name, c, *value);
        }
    }

    inline void CheckConstraint(const std::string &  name, const ClassMemberConstraints & c, double value) {
        if (c.get_min_double_value() != std::nullopt && value < *c.get_min_double_value()) {
            throw ValueTooLowException ("Value too low for " + name + " (" + std::to_string(value) + "<" + std::to_string(*c.get_min_double_value()) + ")");
        }

        if (c.get_max_double_value() != std::nullopt && value > *c.get_max_double_value()) {
            throw ValueTooHighException ("Value too high for " + name + " (" + std::to_string(value) + ">" + std::to_string(*c.get_max_double_value()) + ")");
        }
    }

    inline void CheckConstraint(const std::string &  name, const ClassMemberConstraints & c, const std::optional<double> & value) {
        if (value) {
            CheckConstraint(name, c, *value);
        }
    }

    inline size_t CodePointLength(const std::string &  value) {
        return std::count_if(value.begin(), value.end(), [](char ch) { return (static_cast<unsigned char>(ch) & 0xC0) != 0x80; });
    }

    inline void CheckConstraint(const std::string &  name, const ClassMemberConstraints & c, const std::string &  value) {
        if (c.get_min_length() != std::nullopt && CodePointLength(value) < *c.get_min_length()) {
            throw ValueTooShortException ("Value too short for " + name + " (" + std::to_string(CodePointLength(value)) + "<" + std::to_string(*c.get_min_length()) + ")");
        }

        if (c.get_max_length() != std::nullopt && CodePointLength(value) > *c.get_max_length()) {
            throw ValueTooLongException ("Value too long for " + name + " (" + std::to_string(CodePointLength(value)) + ">" + std::to_string(*c.get_max_length()) + ")");
        }

        if (c.get_pattern() != std::nullopt) {
            std::smatch result;
            std::regex_search(value, result, std::regex( *c.get_pattern() ));
            if (result.empty()) {
                throw InvalidPatternException ("Value doesn't match pattern for " + name + " (" + value +" != " + *c.get_pattern() + ")");
            }
        }
    }

    inline void CheckConstraint(const std::string &  name, const ClassMemberConstraints & c, const std::optional<std::string> & value) {
        if (value) {
            CheckConstraint(name, c, *value);
        }
    }

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

    class Coordinate {
        public:
        Coordinate() = default;
        virtual ~Coordinate() = default;

        private:
        double latitude;
        double longitude;

        public:
        const double & get_latitude() const { return latitude; }
        double & get_mutable_latitude() { return latitude; }
        void set_latitude(const double & value) { this->latitude = value; }

        const double & get_longitude() const { return longitude; }
        double & get_mutable_longitude() { return longitude; }
        void set_longitude(const double & value) { this->longitude = value; }
    };

    class TopLevel {
        public:
        TopLevel() :
            count_constraint(1, 100, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            label_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 2, 16, std::nullopt),
            required_count_constraint(1, 100, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            required_label_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 2, 16, std::nullopt),
            weight_constraint(std::nullopt, std::nullopt, 0.5, 99.5, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~TopLevel() = default;

        private:
        std::optional<std::vector<Coordinate>> coordinates;
        std::optional<int64_t> count;
        ClassMemberConstraints count_constraint;
        std::optional<std::string> label;
        ClassMemberConstraints label_constraint;
        std::vector<Coordinate> required_coordinates;
        int64_t required_count;
        ClassMemberConstraints required_count_constraint;
        std::string required_label;
        ClassMemberConstraints required_label_constraint;
        std::optional<double> weight;
        ClassMemberConstraints weight_constraint;

        public:
        const std::optional<std::vector<Coordinate>> & get_coordinates() const { return coordinates; }
        std::optional<std::vector<Coordinate>> & get_mutable_coordinates() { return coordinates; }
        void set_coordinates(const std::optional<std::vector<Coordinate>> & value) { this->coordinates = value; }

        const std::optional<int64_t> & get_count() const { return count; }
        std::optional<int64_t> & get_mutable_count() { return count; }
        void set_count(const std::optional<int64_t> & value) { CheckConstraint("count", count_constraint, value); this->count = value; }

        const std::optional<std::string> & get_label() const { return label; }
        std::optional<std::string> & get_mutable_label() { return label; }
        void set_label(const std::optional<std::string> & value) { CheckConstraint("label", label_constraint, value); this->label = value; }

        const std::vector<Coordinate> & get_required_coordinates() const { return required_coordinates; }
        std::vector<Coordinate> & get_mutable_required_coordinates() { return required_coordinates; }
        void set_required_coordinates(const std::vector<Coordinate> & value) { this->required_coordinates = value; }

        const int64_t & get_required_count() const { return required_count; }
        int64_t & get_mutable_required_count() { return required_count; }
        void set_required_count(const int64_t & value) { CheckConstraint("required_count", required_count_constraint, value); this->required_count = value; }

        const std::string & get_required_label() const { return required_label; }
        std::string & get_mutable_required_label() { return required_label; }
        void set_required_label(const std::string & value) { CheckConstraint("required_label", required_label_constraint, value); this->required_label = value; }

        const std::optional<double> & get_weight() const { return weight; }
        std::optional<double> & get_mutable_weight() { return weight; }
        void set_weight(const std::optional<double> & value) { CheckConstraint("weight", weight_constraint, value); this->weight = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Coordinate & x);
    void to_json(json & j, const Coordinate & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, Coordinate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_latitude(j.at("latitude").get<double>());
        x.set_longitude(j.at("longitude").get<double>());
    }

    inline void to_json(json & j, const Coordinate & x) {
        j = json::object();
        j["latitude"] = x.get_latitude();
        j["longitude"] = x.get_longitude();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("coordinates") != j.end() && j.at("coordinates").is_null()) throw std::runtime_error("Unexpected null");
        x.set_coordinates(get_stack_optional<std::vector<Coordinate>>(j, "coordinates"));
        if (j.find("count") != j.end() && !j.at("count").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("count") != j.end() && j.at("count").is_null()) throw std::runtime_error("Unexpected null");
        x.set_count(get_stack_optional<int64_t>(j, "count"));
        if (j.find("label") != j.end() && j.at("label").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label(get_stack_optional<std::string>(j, "label"));
        x.set_required_coordinates(j.at("requiredCoordinates").get<std::vector<Coordinate>>());
        if (j.find("requiredCount") != j.end() && !j.at("requiredCount").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_required_count(j.at("requiredCount").get<int64_t>());
        x.set_required_label(j.at("requiredLabel").get<std::string>());
        if (j.find("weight") != j.end() && j.at("weight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_weight(get_stack_optional<double>(j, "weight"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["coordinates"] = x.get_coordinates();
        j["count"] = x.get_count();
        j["label"] = x.get_label();
        j["requiredCoordinates"] = x.get_required_coordinates();
        j["requiredCount"] = x.get_required_count();
        j["requiredLabel"] = x.get_required_label();
        j["weight"] = x.get_weight();
    }
}
