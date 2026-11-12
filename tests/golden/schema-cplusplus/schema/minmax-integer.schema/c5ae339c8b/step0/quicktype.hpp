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
#include <algorithm>

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

    class TopLevel {
        public:
        TopLevel() :
            intersection_constraint(4, 5, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            max_constraint(std::nullopt, 5, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            min_constraint(3, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            minmax_constraint(3, 5, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            min_max_intersection_constraint(3, 5, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            union_constraint(3, 6, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~TopLevel() = default;

        private:
        int64_t free;
        int64_t intersection;
        ClassMemberConstraints intersection_constraint;
        int64_t max;
        ClassMemberConstraints max_constraint;
        int64_t min;
        ClassMemberConstraints min_constraint;
        int64_t minmax;
        ClassMemberConstraints minmax_constraint;
        int64_t min_max_intersection;
        ClassMemberConstraints min_max_intersection_constraint;
        int64_t min_max_union;
        int64_t top_level_union;
        ClassMemberConstraints union_constraint;

        public:
        const int64_t & get_free() const { return free; }
        int64_t & get_mutable_free() { return free; }
        void set_free(const int64_t & value) { this->free = value; }

        const int64_t & get_intersection() const { return intersection; }
        int64_t & get_mutable_intersection() { return intersection; }
        void set_intersection(const int64_t & value) { CheckConstraint("intersection", intersection_constraint, value); this->intersection = value; }

        const int64_t & get_max() const { return max; }
        int64_t & get_mutable_max() { return max; }
        void set_max(const int64_t & value) { CheckConstraint("max", max_constraint, value); this->max = value; }

        const int64_t & get_min() const { return min; }
        int64_t & get_mutable_min() { return min; }
        void set_min(const int64_t & value) { CheckConstraint("min", min_constraint, value); this->min = value; }

        const int64_t & get_minmax() const { return minmax; }
        int64_t & get_mutable_minmax() { return minmax; }
        void set_minmax(const int64_t & value) { CheckConstraint("minmax", minmax_constraint, value); this->minmax = value; }

        const int64_t & get_min_max_intersection() const { return min_max_intersection; }
        int64_t & get_mutable_min_max_intersection() { return min_max_intersection; }
        void set_min_max_intersection(const int64_t & value) { CheckConstraint("min_max_intersection", min_max_intersection_constraint, value); this->min_max_intersection = value; }

        const int64_t & get_min_max_union() const { return min_max_union; }
        int64_t & get_mutable_min_max_union() { return min_max_union; }
        void set_min_max_union(const int64_t & value) { this->min_max_union = value; }

        const int64_t & get_top_level_union() const { return top_level_union; }
        int64_t & get_mutable_top_level_union() { return top_level_union; }
        void set_top_level_union(const int64_t & value) { CheckConstraint("top_level_union", union_constraint, value); this->top_level_union = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("free") != j.end() && !j.at("free").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_free(j.at("free").get<int64_t>());
        if (j.find("intersection") != j.end() && !j.at("intersection").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_intersection(j.at("intersection").get<int64_t>());
        if (j.find("max") != j.end() && !j.at("max").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_max(j.at("max").get<int64_t>());
        if (j.find("min") != j.end() && !j.at("min").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_min(j.at("min").get<int64_t>());
        if (j.find("minmax") != j.end() && !j.at("minmax").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_minmax(j.at("minmax").get<int64_t>());
        if (j.find("minMaxIntersection") != j.end() && !j.at("minMaxIntersection").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_min_max_intersection(j.at("minMaxIntersection").get<int64_t>());
        if (j.find("minMaxUnion") != j.end() && !j.at("minMaxUnion").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_min_max_union(j.at("minMaxUnion").get<int64_t>());
        if (j.find("union") != j.end() && !j.at("union").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_top_level_union(j.at("union").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["free"] = x.get_free();
        j["intersection"] = x.get_intersection();
        j["max"] = x.get_max();
        j["min"] = x.get_min();
        j["minmax"] = x.get_minmax();
        j["minMaxIntersection"] = x.get_min_max_intersection();
        j["minMaxUnion"] = x.get_min_max_union();
        j["union"] = x.get_top_level_union();
    }
}
