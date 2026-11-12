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
            above_i32_max_constraint(0, 2147483648, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            below_i32_min_constraint(-2147483649, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            i32_range_constraint(-2147483648, 2147483647, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            large_bounds_constraint(-9007199254740991, 9007199254740991, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            only_maximum_constraint(std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            only_minimum_constraint(0, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            small_negative_constraint(-100, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            small_positive_constraint(0, 100, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~TopLevel() = default;

        private:
        int64_t above_i32_max;
        ClassMemberConstraints above_i32_max_constraint;
        int64_t below_i32_min;
        ClassMemberConstraints below_i32_min_constraint;
        int64_t i32_range;
        ClassMemberConstraints i32_range_constraint;
        int64_t large_bounds;
        ClassMemberConstraints large_bounds_constraint;
        int64_t only_maximum;
        ClassMemberConstraints only_maximum_constraint;
        int64_t only_minimum;
        ClassMemberConstraints only_minimum_constraint;
        int64_t small_negative;
        ClassMemberConstraints small_negative_constraint;
        int64_t small_positive;
        ClassMemberConstraints small_positive_constraint;
        int64_t unbounded;

        public:
        const int64_t & get_above_i32_max() const { return above_i32_max; }
        int64_t & get_mutable_above_i32_max() { return above_i32_max; }
        void set_above_i32_max(const int64_t & value) { CheckConstraint("above_i32_max", above_i32_max_constraint, value); this->above_i32_max = value; }

        const int64_t & get_below_i32_min() const { return below_i32_min; }
        int64_t & get_mutable_below_i32_min() { return below_i32_min; }
        void set_below_i32_min(const int64_t & value) { CheckConstraint("below_i32_min", below_i32_min_constraint, value); this->below_i32_min = value; }

        const int64_t & get_i32_range() const { return i32_range; }
        int64_t & get_mutable_i32_range() { return i32_range; }
        void set_i32_range(const int64_t & value) { CheckConstraint("i32_range", i32_range_constraint, value); this->i32_range = value; }

        const int64_t & get_large_bounds() const { return large_bounds; }
        int64_t & get_mutable_large_bounds() { return large_bounds; }
        void set_large_bounds(const int64_t & value) { CheckConstraint("large_bounds", large_bounds_constraint, value); this->large_bounds = value; }

        const int64_t & get_only_maximum() const { return only_maximum; }
        int64_t & get_mutable_only_maximum() { return only_maximum; }
        void set_only_maximum(const int64_t & value) { CheckConstraint("only_maximum", only_maximum_constraint, value); this->only_maximum = value; }

        const int64_t & get_only_minimum() const { return only_minimum; }
        int64_t & get_mutable_only_minimum() { return only_minimum; }
        void set_only_minimum(const int64_t & value) { CheckConstraint("only_minimum", only_minimum_constraint, value); this->only_minimum = value; }

        const int64_t & get_small_negative() const { return small_negative; }
        int64_t & get_mutable_small_negative() { return small_negative; }
        void set_small_negative(const int64_t & value) { CheckConstraint("small_negative", small_negative_constraint, value); this->small_negative = value; }

        const int64_t & get_small_positive() const { return small_positive; }
        int64_t & get_mutable_small_positive() { return small_positive; }
        void set_small_positive(const int64_t & value) { CheckConstraint("small_positive", small_positive_constraint, value); this->small_positive = value; }

        const int64_t & get_unbounded() const { return unbounded; }
        int64_t & get_mutable_unbounded() { return unbounded; }
        void set_unbounded(const int64_t & value) { this->unbounded = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("above_i32_max") != j.end() && !j.at("above_i32_max").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_above_i32_max(j.at("above_i32_max").get<int64_t>());
        if (j.find("below_i32_min") != j.end() && !j.at("below_i32_min").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_below_i32_min(j.at("below_i32_min").get<int64_t>());
        if (j.find("i32_range") != j.end() && !j.at("i32_range").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_i32_range(j.at("i32_range").get<int64_t>());
        if (j.find("large_bounds") != j.end() && !j.at("large_bounds").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_large_bounds(j.at("large_bounds").get<int64_t>());
        if (j.find("only_maximum") != j.end() && !j.at("only_maximum").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_only_maximum(j.at("only_maximum").get<int64_t>());
        if (j.find("only_minimum") != j.end() && !j.at("only_minimum").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_only_minimum(j.at("only_minimum").get<int64_t>());
        if (j.find("small_negative") != j.end() && !j.at("small_negative").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_small_negative(j.at("small_negative").get<int64_t>());
        if (j.find("small_positive") != j.end() && !j.at("small_positive").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_small_positive(j.at("small_positive").get<int64_t>());
        if (j.find("unbounded") != j.end() && !j.at("unbounded").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_unbounded(j.at("unbounded").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["above_i32_max"] = x.get_above_i32_max();
        j["below_i32_min"] = x.get_below_i32_min();
        j["i32_range"] = x.get_i32_range();
        j["large_bounds"] = x.get_large_bounds();
        j["only_maximum"] = x.get_only_maximum();
        j["only_minimum"] = x.get_only_minimum();
        j["small_negative"] = x.get_small_negative();
        j["small_positive"] = x.get_small_positive();
        j["unbounded"] = x.get_unbounded();
    }
}
