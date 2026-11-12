//  To parse this JSON data, first install
//
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     TopLevel data = nlohmann::json::parse(jsonString);

#pragma once

#include <variant>
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

    using InUnion = std::variant<double, std::string>;

    class TopLevel {
        public:
        TopLevel() :
            intersection_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 4, 5, std::nullopt),
            maxlength_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt, 5, std::nullopt),
            minlength_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 3, std::nullopt, std::nullopt),
            min_max_intersection_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 3, 5, std::nullopt),
            minmaxlength_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 3, 5, std::nullopt),
            union_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 3, 6, std::nullopt)
        {}
        virtual ~TopLevel() = default;

        private:
        std::string intersection;
        ClassMemberConstraints intersection_constraint;
        InUnion in_union;
        std::string maxlength;
        ClassMemberConstraints maxlength_constraint;
        std::string minlength;
        ClassMemberConstraints minlength_constraint;
        std::string min_max_intersection;
        ClassMemberConstraints min_max_intersection_constraint;
        std::string minmaxlength;
        ClassMemberConstraints minmaxlength_constraint;
        std::string min_max_union;
        std::string top_level_union;
        ClassMemberConstraints union_constraint;

        public:
        const std::string & get_intersection() const { return intersection; }
        std::string & get_mutable_intersection() { return intersection; }
        void set_intersection(const std::string & value) { CheckConstraint("intersection", intersection_constraint, value); this->intersection = value; }

        const InUnion & get_in_union() const { return in_union; }
        InUnion & get_mutable_in_union() { return in_union; }
        void set_in_union(const InUnion & value) { this->in_union = value; }

        const std::string & get_maxlength() const { return maxlength; }
        std::string & get_mutable_maxlength() { return maxlength; }
        void set_maxlength(const std::string & value) { CheckConstraint("maxlength", maxlength_constraint, value); this->maxlength = value; }

        const std::string & get_minlength() const { return minlength; }
        std::string & get_mutable_minlength() { return minlength; }
        void set_minlength(const std::string & value) { CheckConstraint("minlength", minlength_constraint, value); this->minlength = value; }

        const std::string & get_min_max_intersection() const { return min_max_intersection; }
        std::string & get_mutable_min_max_intersection() { return min_max_intersection; }
        void set_min_max_intersection(const std::string & value) { CheckConstraint("min_max_intersection", min_max_intersection_constraint, value); this->min_max_intersection = value; }

        const std::string & get_minmaxlength() const { return minmaxlength; }
        std::string & get_mutable_minmaxlength() { return minmaxlength; }
        void set_minmaxlength(const std::string & value) { CheckConstraint("minmaxlength", minmaxlength_constraint, value); this->minmaxlength = value; }

        const std::string & get_min_max_union() const { return min_max_union; }
        std::string & get_mutable_min_max_union() { return min_max_union; }
        void set_min_max_union(const std::string & value) { this->min_max_union = value; }

        const std::string & get_top_level_union() const { return top_level_union; }
        std::string & get_mutable_top_level_union() { return top_level_union; }
        void set_top_level_union(const std::string & value) { CheckConstraint("top_level_union", union_constraint, value); this->top_level_union = value; }
    };
}

namespace quicktype {
void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(const json & j, std::variant<double, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_intersection(j.at("intersection").get<std::string>());
        x.set_in_union(j.at("inUnion").get<InUnion>());
        x.set_maxlength(j.at("maxlength").get<std::string>());
        x.set_minlength(j.at("minlength").get<std::string>());
        x.set_min_max_intersection(j.at("minMaxIntersection").get<std::string>());
        x.set_minmaxlength(j.at("minmaxlength").get<std::string>());
        x.set_min_max_union(j.at("minMaxUnion").get<std::string>());
        x.set_top_level_union(j.at("union").get<std::string>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["intersection"] = x.get_intersection();
        j["inUnion"] = x.get_in_union();
        j["maxlength"] = x.get_maxlength();
        j["minlength"] = x.get_minlength();
        j["minMaxIntersection"] = x.get_min_max_intersection();
        j["minmaxlength"] = x.get_minmaxlength();
        j["minMaxUnion"] = x.get_min_max_union();
        j["union"] = x.get_top_level_union();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<double, std::string>>::from_json(const json & j, std::variant<double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, std::string>>::to_json(json & j, const std::variant<double, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<double>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
