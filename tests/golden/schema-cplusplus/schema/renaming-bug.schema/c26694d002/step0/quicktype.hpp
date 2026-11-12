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

    class Color {
        public:
        Color() = default;
        virtual ~Color() = default;

        private:
        std::optional<double> rgb;

        public:
        const std::optional<double> & get_rgb() const { return rgb; }
        std::optional<double> & get_mutable_rgb() { return rgb; }
        void set_rgb(const std::optional<double> & value) { this->rgb = value; }
    };

    class CircularShape {
        public:
        CircularShape() = default;
        virtual ~CircularShape() = default;

        private:
        std::optional<std::string> shape_name;

        public:
        const std::optional<std::string> & get_shape_name() const { return shape_name; }
        std::optional<std::string> & get_mutable_shape_name() { return shape_name; }
        void set_shape_name(const std::optional<std::string> & value) { this->shape_name = value; }
    };

    class Part {
        public:
        Part() = default;
        virtual ~Part() = default;

        private:
        std::optional<std::string> depth;
        std::optional<std::string> length;
        std::optional<std::string> width;

        public:
        const std::optional<std::string> & get_depth() const { return depth; }
        std::optional<std::string> & get_mutable_depth() { return depth; }
        void set_depth(const std::optional<std::string> & value) { this->depth = value; }

        const std::optional<std::string> & get_length() const { return length; }
        std::optional<std::string> & get_mutable_length() { return length; }
        void set_length(const std::optional<std::string> & value) { this->length = value; }

        const std::optional<std::string> & get_width() const { return width; }
        std::optional<std::string> & get_mutable_width() { return width; }
        void set_width(const std::optional<std::string> & value) { this->width = value; }
    };

    class RectShape {
        public:
        RectShape() = default;
        virtual ~RectShape() = default;

        private:
        std::optional<std::vector<Part>> parts;

        public:
        const std::optional<std::vector<Part>> & get_parts() const { return parts; }
        std::optional<std::vector<Part>> & get_mutable_parts() { return parts; }
        void set_parts(const std::optional<std::vector<Part>> & value) { this->parts = value; }
    };

    class Geometry {
        public:
        Geometry() = default;
        virtual ~Geometry() = default;

        private:
        std::optional<RectShape> rect_shape;
        std::optional<std::vector<CircularShape>> circular_shape;

        public:
        const std::optional<RectShape> & get_rect_shape() const { return rect_shape; }
        std::optional<RectShape> & get_mutable_rect_shape() { return rect_shape; }
        void set_rect_shape(const std::optional<RectShape> & value) { this->rect_shape = value; }

        const std::optional<std::vector<CircularShape>> & get_circular_shape() const { return circular_shape; }
        std::optional<std::vector<CircularShape>> & get_mutable_circular_shape() { return circular_shape; }
        void set_circular_shape(const std::optional<std::vector<CircularShape>> & value) { this->circular_shape = value; }
    };

    class History {
        public:
        History() = default;
        virtual ~History() = default;

        private:
        std::optional<std::string> history_class;

        public:
        const std::optional<std::string> & get_history_class() const { return history_class; }
        std::optional<std::string> & get_mutable_history_class() { return history_class; }
        void set_history_class(const std::optional<std::string> & value) { this->history_class = value; }
    };

    class Shape {
        public:
        Shape() = default;
        virtual ~Shape() = default;

        private:
        std::optional<Geometry> geometry;
        std::optional<History> history;

        public:
        const std::optional<Geometry> & get_geometry() const { return geometry; }
        std::optional<Geometry> & get_mutable_geometry() { return geometry; }
        void set_geometry(const std::optional<Geometry> & value) { this->geometry = value; }

        const std::optional<History> & get_history() const { return history; }
        std::optional<History> & get_mutable_history() { return history; }
        void set_history(const std::optional<History> & value) { this->history = value; }
    };

    class Berry {
        public:
        Berry() :
            name_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 1, std::nullopt, std::nullopt)
        {}
        virtual ~Berry() = default;

        private:
        std::optional<Color> color;
        std::optional<std::string> name;
        ClassMemberConstraints name_constraint;
        std::optional<std::vector<Shape>> shapes;

        public:
        const std::optional<Color> & get_color() const { return color; }
        std::optional<Color> & get_mutable_color() { return color; }
        void set_color(const std::optional<Color> & value) { this->color = value; }

        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { CheckConstraint("name", name_constraint, value); this->name = value; }

        const std::optional<std::vector<Shape>> & get_shapes() const { return shapes; }
        std::optional<std::vector<Shape>> & get_mutable_shapes() { return shapes; }
        void set_shapes(const std::optional<std::vector<Shape>> & value) { this->shapes = value; }
    };

    class Fruit {
        public:
        Fruit() = default;
        virtual ~Fruit() = default;

        private:
        std::optional<bool> apple;
        std::optional<std::vector<Berry>> berries;
        std::optional<bool> orange;

        public:
        const std::optional<bool> & get_apple() const { return apple; }
        std::optional<bool> & get_mutable_apple() { return apple; }
        void set_apple(const std::optional<bool> & value) { this->apple = value; }

        const std::optional<std::vector<Berry>> & get_berries() const { return berries; }
        std::optional<std::vector<Berry>> & get_mutable_berries() { return berries; }
        void set_berries(const std::optional<std::vector<Berry>> & value) { this->berries = value; }

        const std::optional<bool> & get_orange() const { return orange; }
        std::optional<bool> & get_mutable_orange() { return orange; }
        void set_orange(const std::optional<bool> & value) { this->orange = value; }
    };

    class Limit {
        public:
        Limit() = default;
        virtual ~Limit() = default;

        private:
        std::optional<double> maximum;
        std::optional<double> minimum;

        public:
        const std::optional<double> & get_maximum() const { return maximum; }
        std::optional<double> & get_mutable_maximum() { return maximum; }
        void set_maximum(const std::optional<double> & value) { this->maximum = value; }

        const std::optional<double> & get_minimum() const { return minimum; }
        std::optional<double> & get_mutable_minimum() { return minimum; }
        void set_minimum(const std::optional<double> & value) { this->minimum = value; }
    };

    class Speed {
        public:
        Speed() = default;
        virtual ~Speed() = default;

        private:
        std::optional<Limit> velocity;

        public:
        const std::optional<Limit> & get_velocity() const { return velocity; }
        std::optional<Limit> & get_mutable_velocity() { return velocity; }
        void set_velocity(const std::optional<Limit> & value) { this->velocity = value; }
    };

    enum class Axis : int { X, Y, Z, XY, YZ, ZX };

    enum class Name : int { TRUCK, BUS, CAR, VAN, TRAIN, BIKE, AEROPLANE, JEEP, TROLLEY };

    class VehicleType {
        public:
        VehicleType() = default;
        virtual ~VehicleType() = default;

        private:
        std::optional<Name> name;
        std::optional<Axis> width;
        std::optional<Axis> length;

        public:
        const std::optional<Name> & get_name() const { return name; }
        std::optional<Name> & get_mutable_name() { return name; }
        void set_name(const std::optional<Name> & value) { this->name = value; }

        const std::optional<Axis> & get_width() const { return width; }
        std::optional<Axis> & get_mutable_width() { return width; }
        void set_width(const std::optional<Axis> & value) { this->width = value; }

        const std::optional<Axis> & get_length() const { return length; }
        std::optional<Axis> & get_mutable_length() { return length; }
        void set_length(const std::optional<Axis> & value) { this->length = value; }
    };

    class Vehicle {
        public:
        Vehicle() :
            id_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, 1, std::nullopt, std::nullopt)
        {}
        virtual ~Vehicle() = default;

        private:
        std::optional<std::string> brand;
        std::optional<std::string> id;
        ClassMemberConstraints id_constraint;
        std::optional<Speed> speed;
        std::optional<bool> sub_module;
        std::optional<VehicleType> type;
        std::optional<std::string> year;

        public:
        const std::optional<std::string> & get_brand() const { return brand; }
        std::optional<std::string> & get_mutable_brand() { return brand; }
        void set_brand(const std::optional<std::string> & value) { this->brand = value; }

        const std::optional<std::string> & get_id() const { return id; }
        std::optional<std::string> & get_mutable_id() { return id; }
        void set_id(const std::optional<std::string> & value) { CheckConstraint("id", id_constraint, value); this->id = value; }

        const std::optional<Speed> & get_speed() const { return speed; }
        std::optional<Speed> & get_mutable_speed() { return speed; }
        void set_speed(const std::optional<Speed> & value) { this->speed = value; }

        const std::optional<bool> & get_sub_module() const { return sub_module; }
        std::optional<bool> & get_mutable_sub_module() { return sub_module; }
        void set_sub_module(const std::optional<bool> & value) { this->sub_module = value; }

        const std::optional<VehicleType> & get_type() const { return type; }
        std::optional<VehicleType> & get_mutable_type() { return type; }
        void set_type(const std::optional<VehicleType> & value) { this->type = value; }

        const std::optional<std::string> & get_year() const { return year; }
        std::optional<std::string> & get_mutable_year() { return year; }
        void set_year(const std::optional<std::string> & value) { this->year = value; }
    };

    class TopLevel {
        public:
        TopLevel() :
            version_constraint(std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::nullopt, std::string("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$"))
        {}
        virtual ~TopLevel() = default;

        private:
        std::optional<std::string> version;
        ClassMemberConstraints version_constraint;
        std::optional<std::vector<Fruit>> fruits;
        std::optional<std::vector<Vehicle>> vehicles;

        public:
        const std::optional<std::string> & get_version() const { return version; }
        std::optional<std::string> & get_mutable_version() { return version; }
        void set_version(const std::optional<std::string> & value) { CheckConstraint("version", version_constraint, value); this->version = value; }

        const std::optional<std::vector<Fruit>> & get_fruits() const { return fruits; }
        std::optional<std::vector<Fruit>> & get_mutable_fruits() { return fruits; }
        void set_fruits(const std::optional<std::vector<Fruit>> & value) { this->fruits = value; }

        const std::optional<std::vector<Vehicle>> & get_vehicles() const { return vehicles; }
        std::optional<std::vector<Vehicle>> & get_mutable_vehicles() { return vehicles; }
        void set_vehicles(const std::optional<std::vector<Vehicle>> & value) { this->vehicles = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, Color & x);
    void to_json(json & j, const Color & x);

    void from_json(const json & j, CircularShape & x);
    void to_json(json & j, const CircularShape & x);

    void from_json(const json & j, Part & x);
    void to_json(json & j, const Part & x);

    void from_json(const json & j, RectShape & x);
    void to_json(json & j, const RectShape & x);

    void from_json(const json & j, Geometry & x);
    void to_json(json & j, const Geometry & x);

    void from_json(const json & j, History & x);
    void to_json(json & j, const History & x);

    void from_json(const json & j, Shape & x);
    void to_json(json & j, const Shape & x);

    void from_json(const json & j, Berry & x);
    void to_json(json & j, const Berry & x);

    void from_json(const json & j, Fruit & x);
    void to_json(json & j, const Fruit & x);

    void from_json(const json & j, Limit & x);
    void to_json(json & j, const Limit & x);

    void from_json(const json & j, Speed & x);
    void to_json(json & j, const Speed & x);

    void from_json(const json & j, VehicleType & x);
    void to_json(json & j, const VehicleType & x);

    void from_json(const json & j, Vehicle & x);
    void to_json(json & j, const Vehicle & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    void from_json(const json & j, Axis & x);
    void to_json(json & j, const Axis & x);

    void from_json(const json & j, Name & x);
    void to_json(json & j, const Name & x);

    inline void from_json(const json & j, Color& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("rgb") != j.end() && j.at("rgb").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rgb(get_stack_optional<double>(j, "rgb"));
    }

    inline void to_json(json & j, const Color & x) {
        j = json::object();
        j["rgb"] = x.get_rgb();
    }

    inline void from_json(const json & j, CircularShape& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("shapeName") != j.end() && j.at("shapeName").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape_name(get_stack_optional<std::string>(j, "shapeName"));
    }

    inline void to_json(json & j, const CircularShape & x) {
        j = json::object();
        j["shapeName"] = x.get_shape_name();
    }

    inline void from_json(const json & j, Part& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("depth") != j.end() && j.at("depth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_depth(get_stack_optional<std::string>(j, "depth"));
        if (j.find("length") != j.end() && j.at("length").is_null()) throw std::runtime_error("Unexpected null");
        x.set_length(get_stack_optional<std::string>(j, "length"));
        if (j.find("width") != j.end() && j.at("width").is_null()) throw std::runtime_error("Unexpected null");
        x.set_width(get_stack_optional<std::string>(j, "width"));
    }

    inline void to_json(json & j, const Part & x) {
        j = json::object();
        j["depth"] = x.get_depth();
        j["length"] = x.get_length();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, RectShape& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("parts") != j.end() && j.at("parts").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parts(get_stack_optional<std::vector<Part>>(j, "parts"));
    }

    inline void to_json(json & j, const RectShape & x) {
        j = json::object();
        j["parts"] = x.get_parts();
    }

    inline void from_json(const json & j, Geometry& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("rectShape") != j.end() && j.at("rectShape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rect_shape(get_stack_optional<RectShape>(j, "rectShape"));
        if (j.find("circularShape") != j.end() && j.at("circularShape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_circular_shape(get_stack_optional<std::vector<CircularShape>>(j, "circularShape"));
    }

    inline void to_json(json & j, const Geometry & x) {
        j = json::object();
        j["rectShape"] = x.get_rect_shape();
        j["circularShape"] = x.get_circular_shape();
    }

    inline void from_json(const json & j, History& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("class") != j.end() && j.at("class").is_null()) throw std::runtime_error("Unexpected null");
        x.set_history_class(get_stack_optional<std::string>(j, "class"));
    }

    inline void to_json(json & j, const History & x) {
        j = json::object();
        j["class"] = x.get_history_class();
    }

    inline void from_json(const json & j, Shape& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("geometry") != j.end() && j.at("geometry").is_null()) throw std::runtime_error("Unexpected null");
        x.set_geometry(get_stack_optional<Geometry>(j, "geometry"));
        if (j.find("history") != j.end() && j.at("history").is_null()) throw std::runtime_error("Unexpected null");
        x.set_history(get_stack_optional<History>(j, "history"));
    }

    inline void to_json(json & j, const Shape & x) {
        j = json::object();
        j["geometry"] = x.get_geometry();
        j["history"] = x.get_history();
    }

    inline void from_json(const json & j, Berry& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<Color>(j, "color"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        if (j.find("shapes") != j.end() && j.at("shapes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shapes(get_stack_optional<std::vector<Shape>>(j, "shapes"));
    }

    inline void to_json(json & j, const Berry & x) {
        j = json::object();
        j["color"] = x.get_color();
        j["name"] = x.get_name();
        j["shapes"] = x.get_shapes();
    }

    inline void from_json(const json & j, Fruit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("apple") != j.end() && j.at("apple").is_null()) throw std::runtime_error("Unexpected null");
        x.set_apple(get_stack_optional<bool>(j, "apple"));
        if (j.find("berries") != j.end() && j.at("berries").is_null()) throw std::runtime_error("Unexpected null");
        x.set_berries(get_stack_optional<std::vector<Berry>>(j, "berries"));
        if (j.find("orange") != j.end() && j.at("orange").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orange(get_stack_optional<bool>(j, "orange"));
    }

    inline void to_json(json & j, const Fruit & x) {
        j = json::object();
        j["apple"] = x.get_apple();
        j["berries"] = x.get_berries();
        j["orange"] = x.get_orange();
    }

    inline void from_json(const json & j, Limit& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("maximum") != j.end() && j.at("maximum").is_null()) throw std::runtime_error("Unexpected null");
        x.set_maximum(get_stack_optional<double>(j, "maximum"));
        if (j.find("minimum") != j.end() && j.at("minimum").is_null()) throw std::runtime_error("Unexpected null");
        x.set_minimum(get_stack_optional<double>(j, "minimum"));
    }

    inline void to_json(json & j, const Limit & x) {
        j = json::object();
        j["maximum"] = x.get_maximum();
        j["minimum"] = x.get_minimum();
    }

    inline void from_json(const json & j, Speed& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("velocity") != j.end() && j.at("velocity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_velocity(get_stack_optional<Limit>(j, "velocity"));
    }

    inline void to_json(json & j, const Speed & x) {
        j = json::object();
        j["velocity"] = x.get_velocity();
    }

    inline void from_json(const json & j, VehicleType& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<Name>(j, "name"));
        if (j.find("width") != j.end() && j.at("width").is_null()) throw std::runtime_error("Unexpected null");
        x.set_width(get_stack_optional<Axis>(j, "width"));
        if (j.find("length") != j.end() && j.at("length").is_null()) throw std::runtime_error("Unexpected null");
        x.set_length(get_stack_optional<Axis>(j, "length"));
    }

    inline void to_json(json & j, const VehicleType & x) {
        j = json::object();
        j["name"] = x.get_name();
        j["width"] = x.get_width();
        j["length"] = x.get_length();
    }

    inline void from_json(const json & j, Vehicle& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("brand") != j.end() && j.at("brand").is_null()) throw std::runtime_error("Unexpected null");
        x.set_brand(get_stack_optional<std::string>(j, "brand"));
        if (j.find("id") != j.end() && j.at("id").is_null()) throw std::runtime_error("Unexpected null");
        x.set_id(get_stack_optional<std::string>(j, "id"));
        if (j.find("speed") != j.end() && j.at("speed").is_null()) throw std::runtime_error("Unexpected null");
        x.set_speed(get_stack_optional<Speed>(j, "speed"));
        if (j.find("subModule") != j.end() && j.at("subModule").is_null()) throw std::runtime_error("Unexpected null");
        x.set_sub_module(get_stack_optional<bool>(j, "subModule"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<VehicleType>(j, "type"));
        if (j.find("year") != j.end() && j.at("year").is_null()) throw std::runtime_error("Unexpected null");
        x.set_year(get_stack_optional<std::string>(j, "year"));
    }

    inline void to_json(json & j, const Vehicle & x) {
        j = json::object();
        j["brand"] = x.get_brand();
        j["id"] = x.get_id();
        j["speed"] = x.get_speed();
        j["subModule"] = x.get_sub_module();
        j["type"] = x.get_type();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("version") != j.end() && j.at("version").is_null()) throw std::runtime_error("Unexpected null");
        x.set_version(get_stack_optional<std::string>(j, "version"));
        if (j.find("fruits") != j.end() && j.at("fruits").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fruits(get_stack_optional<std::vector<Fruit>>(j, "fruits"));
        if (j.find("vehicles") != j.end() && j.at("vehicles").is_null()) throw std::runtime_error("Unexpected null");
        x.set_vehicles(get_stack_optional<std::vector<Vehicle>>(j, "vehicles"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["version"] = x.get_version();
        j["fruits"] = x.get_fruits();
        j["vehicles"] = x.get_vehicles();
    }

    inline void from_json(const json & j, Axis & x) {
        if (j == "X") x = Axis::X;
        else if (j == "Y") x = Axis::Y;
        else if (j == "Z") x = Axis::Z;
        else if (j == "XY") x = Axis::XY;
        else if (j == "YZ") x = Axis::YZ;
        else if (j == "ZX") x = Axis::ZX;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Axis\""); }
    }

    inline void to_json(json & j, const Axis & x) {
        switch (x) {
            case Axis::X: j = "X"; break;
            case Axis::Y: j = "Y"; break;
            case Axis::Z: j = "Z"; break;
            case Axis::XY: j = "XY"; break;
            case Axis::YZ: j = "YZ"; break;
            case Axis::ZX: j = "ZX"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Axis\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Name & x) {
        if (j == "truck") x = Name::TRUCK;
        else if (j == "bus") x = Name::BUS;
        else if (j == "car") x = Name::CAR;
        else if (j == "van") x = Name::VAN;
        else if (j == "train") x = Name::TRAIN;
        else if (j == "Bike") x = Name::BIKE;
        else if (j == "Aeroplane") x = Name::AEROPLANE;
        else if (j == "Jeep") x = Name::JEEP;
        else if (j == "Trolley") x = Name::TROLLEY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Name\""); }
    }

    inline void to_json(json & j, const Name & x) {
        switch (x) {
            case Name::TRUCK: j = "truck"; break;
            case Name::BUS: j = "bus"; break;
            case Name::CAR: j = "car"; break;
            case Name::VAN: j = "van"; break;
            case Name::TRAIN: j = "train"; break;
            case Name::BIKE: j = "Bike"; break;
            case Name::AEROPLANE: j = "Aeroplane"; break;
            case Name::JEEP: j = "Jeep"; break;
            case Name::TROLLEY: j = "Trolley"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Name\": " + std::to_string(static_cast<int>(x)));
        }
    }
}
