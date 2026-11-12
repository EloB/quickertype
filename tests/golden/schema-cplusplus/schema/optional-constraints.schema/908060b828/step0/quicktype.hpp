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

    class TopLevel {
        public:
        TopLevel() :
            opt_double_constraint(std::nullopt, std::nullopt, 0.5, 99.5, std::nullopt, std::nullopt, std::nullopt),
            opt_int_constraint(0, 100, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            opt_pattern_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::string("^[a-z]+$")),
            opt_string_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 3, 10, std::nullopt),
            req_zero_min_constraint(0, 100, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~TopLevel() = default;

        private:
        std::optional<double> opt_double;
        ClassMemberConstraints opt_double_constraint;
        std::optional<int64_t> opt_int;
        ClassMemberConstraints opt_int_constraint;
        std::optional<std::string> opt_pattern;
        ClassMemberConstraints opt_pattern_constraint;
        std::optional<std::string> opt_string;
        ClassMemberConstraints opt_string_constraint;
        int64_t req_zero_min;
        ClassMemberConstraints req_zero_min_constraint;

        public:
        const std::optional<double> & get_opt_double() const { return opt_double; }
        std::optional<double> & get_mutable_opt_double() { return opt_double; }
        void set_opt_double(const std::optional<double> & value) { CheckConstraint("opt_double", opt_double_constraint, value); this->opt_double = value; }

        const std::optional<int64_t> & get_opt_int() const { return opt_int; }
        std::optional<int64_t> & get_mutable_opt_int() { return opt_int; }
        void set_opt_int(const std::optional<int64_t> & value) { CheckConstraint("opt_int", opt_int_constraint, value); this->opt_int = value; }

        const std::optional<std::string> & get_opt_pattern() const { return opt_pattern; }
        std::optional<std::string> & get_mutable_opt_pattern() { return opt_pattern; }
        void set_opt_pattern(const std::optional<std::string> & value) { CheckConstraint("opt_pattern", opt_pattern_constraint, value); this->opt_pattern = value; }

        const std::optional<std::string> & get_opt_string() const { return opt_string; }
        std::optional<std::string> & get_mutable_opt_string() { return opt_string; }
        void set_opt_string(const std::optional<std::string> & value) { CheckConstraint("opt_string", opt_string_constraint, value); this->opt_string = value; }

        const int64_t & get_req_zero_min() const { return req_zero_min; }
        int64_t & get_mutable_req_zero_min() { return req_zero_min; }
        void set_req_zero_min(const int64_t & value) { CheckConstraint("req_zero_min", req_zero_min_constraint, value); this->req_zero_min = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("optDouble") != j.end() && j.at("optDouble").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opt_double(get_stack_optional<double>(j, "optDouble"));
        if (j.find("optInt") != j.end() && !j.at("optInt").is_number_integer()) throw std::runtime_error("Expected integer");
        if (j.find("optInt") != j.end() && j.at("optInt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opt_int(get_stack_optional<int64_t>(j, "optInt"));
        if (j.find("optPattern") != j.end() && j.at("optPattern").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opt_pattern(get_stack_optional<std::string>(j, "optPattern"));
        if (j.find("optString") != j.end() && j.at("optString").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opt_string(get_stack_optional<std::string>(j, "optString"));
        if (j.find("reqZeroMin") != j.end() && !j.at("reqZeroMin").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_req_zero_min(j.at("reqZeroMin").get<int64_t>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["optDouble"] = x.get_opt_double();
        j["optInt"] = x.get_opt_int();
        j["optPattern"] = x.get_opt_pattern();
        j["optString"] = x.get_opt_string();
        j["reqZeroMin"] = x.get_req_zero_min();
    }
}
